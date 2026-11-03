#pragma once

#include "types.hpp"
#include "player.hpp"
#include "actor.hpp"
#include "map.hpp"
#include "math.hpp"
#include <algorithm>

namespace doom {

class World {
public:
    Player   player;
    Actor    actors[NUM_ACTORS]{};
    int16_t  sector_ceiling[NUM_SECTORS]{};
    int16_t  sector_target[NUM_SECTORS]{};
    int16_t  sector_floor[NUM_SECTORS]{};
    int16_t  floor_target[NUM_SECTORS]{};
    uint8_t  floor_wait[NUM_SECTORS]{};
    uint8_t  use_held{0};

    const MapData* map{nullptr};

    void init(const MapData& map_data) noexcept {
        map = &map_data;
        reset();
    }

    void reset() noexcept {
        player.reset(START_X, START_Y, START_ANGLE, find_sector(START_X, START_Y), (*map->sector_at(find_sector(START_X, START_Y))).floor);
        math::random_state = 1;
        use_held = 0;
        std::memset(floor_wait, 0, sizeof(floor_wait));

        player.total = 0;
        for (unsigned i = 0; i < NUM_SECTORS; ++i) {
            const Sector* s = map->sector_at(i);
            sector_target[i] = sector_ceiling[i] = s->ceiling;
            floor_target[i] = sector_floor[i] = s->floor;
        }

        for (unsigned i = 0; i < NUM_ACTORS; ++i) {
            const MapActor* m = &map->actors[i];
            actors[i].reset(m->x, m->y, m->hp);
            actors[i].sector = find_sector(m->x, m->y);
            if (m->kind == 1) ++player.total;
        }
    }

    [[nodiscard]] uint8_t find_sector(int x, int y) const noexcept {
        unsigned index = NUM_NODES - 1;
        while (!(index & 0x8000u)) {
            const Node* n = reinterpret_cast<const Node*>(reinterpret_cast<const uint8_t*>(map->nodes) + node_offsets[static_cast<uint8_t>(index)]);
            unsigned side;
            if (!n->dx) side = (x <= n->x) ? (n->dy > 0) : (n->dy < 0);
            else if (!n->dy) side = (y <= n->y) ? (n->dx < 0) : (n->dx > 0);
            else {
                int32_t left = static_cast<int32_t>(x - n->x) * n->dy;
                int32_t right = static_cast<int32_t>(y - n->y) * n->dx;
                side = (right >= left);
            }
            index = n->child[side];
        }
        const Subsector* sub = &map->subsectors[index & 0x7fffu];
        const Seg* seg = &map->segs[sub->first];
        return map->sides[map->lines[seg->line].side[seg->side]].sector;
    }

    [[nodiscard]] bool line_passable(const Line* l, int floor_val) const noexcept {
        if (l->side[1] == 65535u || (l->flags & 1)) return false;
        unsigned a = map->sides[l->side[0]].sector;
        unsigned b = map->sides[l->side[1]].sector;
        int bottom = math::max(static_cast<int>(sector_floor[a]), static_cast<int>(sector_floor[b]));
        return (bottom - floor_val <= 24) &&
               (math::min(static_cast<int>(sector_ceiling[a]), static_cast<int>(sector_ceiling[b])) - math::max(bottom, floor_val) >= 56);
    }

    [[nodiscard]] bool collision_line(unsigned i, int x, int y, int floor_val) const noexcept {
        constexpr int radius = 16;
        const Line* l = &map->lines[i];
        const Vertex* a = &map->vertices[l->v1];
        const Vertex* b = &map->vertices[l->v2];
        if (x < math::min(a->x, b->x) - radius || x > math::max(a->x, b->x) + radius ||
            y < math::min(a->y, b->y) - radius || y > math::max(a->y, b->y) + radius) {
            return true;
        }
        if (line_passable(l, floor_val)) return true;

        int dx = b->x - a->x, dy = b->y - a->y;
        int px = x - a->x, py = y - a->y;
        int32_t len2 = static_cast<int32_t>(dx) * dx + static_cast<int32_t>(dy) * dy;
        int32_t dot = static_cast<int32_t>(px) * dx + static_cast<int32_t>(py) * dy;

        if (dot < 0) {
            if (static_cast<int32_t>(px) * px + static_cast<int32_t>(py) * py < radius * radius) return false;
        } else if (dot > len2) {
            px = x - b->x; py = y - b->y;
            if (static_cast<int32_t>(px) * px + static_cast<int32_t>(py) * py < radius * radius) return false;
        } else if (len2) {
            int32_t t = static_cast<int32_t>((static_cast<int64_t>(dot) * 256) / len2);
            px = x - (a->x + static_cast<int>(static_cast<int32_t>(dx) * t / 256));
            py = y - (a->y + static_cast<int>(static_cast<int32_t>(dy) * t / 256));
            if (static_cast<int32_t>(px) * px + static_cast<int32_t>(py) * py < radius * radius) return false;
        }
        return true;
    }

    [[nodiscard]] bool can_move(int x, int y, int floor_val) const noexcept {
        int left   = (x - 16 - map->blockmap[0]) >> 7;
        int right  = (x + 16 - map->blockmap[0]) >> 7;
        int bottom = (y - 16 - map->blockmap[1]) >> 7;
        int top    = (y + 16 - map->blockmap[1]) >> 7;

        if (left < 0 || bottom < 0 || right >= map->blockmap[2] || top >= map->blockmap[3]) return false;

        for (int row = bottom; row <= top; ++row) {
            for (int col = left; col <= right; ++col) {
                unsigned offset = static_cast<uint16_t>(map->blockmap[4 + row * map->blockmap[2] + col]);
                for (++offset; map->blockmap[offset] != -1; ++offset) {
                    if (!collision_line(static_cast<uint16_t>(map->blockmap[offset]), x, y, floor_val)) return false;
                }
            }
        }
        uint8_t s = find_sector(x, y);
        return (sector_floor[s] - floor_val <= 24) &&
               (sector_ceiling[s] - math::max(static_cast<int>(sector_floor[s]), floor_val) >= 56);
    }

    [[nodiscard]] bool line_of_sight(int x, int y, int tx, int ty, int eye) const noexcept {
        int dx = tx - x, dy = ty - y;
        for (unsigned i = 0; i < NUM_LINES; ++i) {
            const Line* l = &map->lines[i];
            const Vertex* a = &map->vertices[l->v1];
            const Vertex* b = &map->vertices[l->v2];
            if (math::max(x, tx) < math::min(a->x, b->x) || math::min(x, tx) > math::max(a->x, b->x) ||
                math::max(y, ty) < math::min(a->y, b->y) || math::min(y, ty) > math::max(a->y, b->y)) {
                continue;
            }
            if (l->side[1] != 65535u) {
                unsigned sa = map->sides[l->side[0]].sector;
                unsigned sb = map->sides[l->side[1]].sector;
                if (eye > math::max(static_cast<int>(sector_floor[sa]), static_cast<int>(sector_floor[sb])) &&
                    eye < math::min(static_cast<int>(sector_ceiling[sa]), static_cast<int>(sector_ceiling[sb]))) {
                    continue;
                }
            }
            int32_t c1 = static_cast<int32_t>(a->x - x) * dy - static_cast<int32_t>(a->y - y) * dx;
            int32_t c2 = static_cast<int32_t>(b->x - x) * dy - static_cast<int32_t>(b->y - y) * dx;
            int32_t c3 = static_cast<int32_t>(x - a->x) * (b->y - a->y) - static_cast<int32_t>(y - a->y) * (b->x - a->x);
            int32_t c4 = static_cast<int32_t>(tx - a->x) * (b->y - a->y) - static_cast<int32_t>(ty - a->y) * (b->x - a->x);
            if ((c1 < 0) != (c2 < 0) && (c3 < 0) != (c4 < 0)) return false;
        }
        return true;
    }

    void activate_sector(unsigned s) noexcept {
        int ceiling = 32767, floor_val = 32767;
        for (unsigned j = 0; j < NUM_LINES; ++j) {
            const Line* edge = &map->lines[j];
            if (edge->side[1] == 65535u) continue;
            unsigned a = map->sides[edge->side[0]].sector;
            unsigned b = map->sides[edge->side[1]].sector;
            if (a != s && b != s) continue;
            unsigned other = (a == s) ? b : a;
            ceiling   = math::min(ceiling, static_cast<int>(sector_ceiling[other]) - 4);
            floor_val = math::min(floor_val, static_cast<int>(sector_floor[other]));
        }
        if (ceiling != 32767) sector_target[s] = static_cast<int16_t>(math::max(static_cast<int>(sector_ceiling[s]), ceiling));
        if (floor_val != 32767 && floor_val < sector_floor[s]) floor_target[s] = static_cast<int16_t>(floor_val);
    }

    void use() noexcept {
        int x = player.world_x(), y = player.world_y();
        int c = math::icos(player.angle), s = math::isin(player.angle);
        int best = 80;
        const Line* found = nullptr;

        for (unsigned i = 0; i < NUM_LINES; ++i) {
            const Line* l = &map->lines[i];
            if (!l->special || l->special == 48) continue;
            const Vertex* a = &map->vertices[l->v1];
            const Vertex* b = &map->vertices[l->v2];
            int ax = a->x - x, ay = a->y - y, bx = b->x - x, by = b->y - y;
            int ar = static_cast<int>((static_cast<int32_t>(ax) * s - static_cast<int32_t>(ay) * c) / 256);
            int br = static_cast<int>((static_cast<int32_t>(bx) * s - static_cast<int32_t>(by) * c) / 256);
            if ((ar < 0) == (br < 0) || ar == br) continue;
            int az = static_cast<int>((static_cast<int32_t>(ax) * c + static_cast<int32_t>(ay) * s) / 256);
            int bz = static_cast<int>((static_cast<int32_t>(bx) * c + static_cast<int32_t>(by) * s) / 256);
            int z = az + static_cast<int>(static_cast<int32_t>(bz - az) * ar / (ar - br));
            if (z > 0 && z < best) {
                best = z;
                found = l;
            }
        }
        if (!found) return;
        if (found->special == 11) {
            player.exited = true;
            return;
        }
        if (found->side[1] != 65535u) {
            activate_sector(map->sides[found->side[1]].sector);
        }
    }

    void damage_actor(unsigned index, int damage) noexcept {
        Actor* a = &actors[index];
        const MapActor* m = &map->actors[index];
        if (!a->hp || a->removed || a->explode || a->die) return;
        if (damage < a->hp) {
            a->hp = static_cast<uint8_t>(a->hp - damage);
            if (m->kind == 1) a->pain = 12;
            return;
        }
        a->hp = 0;
        a->pain = 0;
        if (m->kind == 1) {
            a->die = 1;
            ++player.kills;
            player.ammo += 5;
        }
        if (m->kind == 3) explode_barrel(index);
    }

    void explode_barrel(unsigned index) noexcept {
        Actor* a = &actors[index];
        if (a->removed || a->explode) return;
        a->hp = 0;
        a->explode = 1;
        int bx = a->x, by = a->y;
        int px = player.world_x(), py = player.world_y();
        int pdist = math::max(math::abs(px - bx), math::abs(py - by));
        if (pdist < 128) player.hurt((128 - pdist) / 4 + 1 + static_cast<int>(math::rnd() % 5));
        for (unsigned i = 0; i < NUM_ACTORS; ++i) {
            if (i == index) continue;
            Actor* o = &actors[i];
            if (!o->hp || o->removed || o->explode) continue;
            int dist = math::max(math::abs(o->x - bx), math::abs(o->y - by));
            if (dist >= 128) continue;
            damage_actor(i, (128 - dist) / 2 + 1 + static_cast<int>(math::rnd() % 5));
        }
    }

    void fire_shot() noexcept {
        if (!player.ammo) return;
        --player.ammo;
        int c = math::icos(player.angle), s = math::isin(player.angle);
        int best = 2048, index = -1;
        int x = player.world_x(), y = player.world_y();
        for (unsigned i = 0; i < NUM_ACTORS; ++i) {
            Actor* a = &actors[i];
            if (!a->hp || a->removed || a->explode) continue;
            int dx = a->x - x, dy = a->y - y;
            int z = static_cast<int>((static_cast<int32_t>(dx) * c + static_cast<int32_t>(dy) * s) / 256);
            int r = static_cast<int>((static_cast<int32_t>(dx) * s - static_cast<int32_t>(dy) * c) / 256);
            if (z < 0 || z >= best || math::abs(r) > 20) continue;
            if (!line_of_sight(x, y, a->x, a->y, player.eye)) continue;
            best = z;
            index = static_cast<int>(i);
        }
        if (index >= 0) damage_actor(static_cast<unsigned>(index), 5 * (1 + (math::rnd() % 3)));
    }

    void shoot() noexcept {
        if (player.fire || !player.ammo) return;
        player.fire = PistolTotal;
    }

    void cross_triggers(int oldx, int oldy, int x, int y) noexcept {
        if (oldx == x && oldy == y) return;
        for (unsigned i = 0; i < NUM_WALK_TRIGGERS; ++i) {
            const Line* line = &map->lines[walk_triggers[i]];
            const Vertex* a = &map->vertices[line->v1];
            const Vertex* b = &map->vertices[line->v2];
            if (math::max(oldx, x) < math::min(a->x, b->x) || math::min(oldx, x) > math::max(a->x, b->x) ||
                math::max(oldy, y) < math::min(a->y, b->y) || math::min(oldy, y) > math::max(a->y, b->y)) {
                continue;
            }
            int dx = b->x - a->x, dy = b->y - a->y;
            int32_t before = static_cast<int32_t>(oldx - a->x) * dy - static_cast<int32_t>(oldy - a->y) * dx;
            int32_t after  = static_cast<int32_t>(x - a->x) * dy - static_cast<int32_t>(y - a->y) * dx;
            if ((before < 0) == (after < 0)) continue;

            for (unsigned s = 0; s < NUM_SECTORS; ++s) {
                if (!line->tag || (*map->sector_at(s)).tag != line->tag) continue;
                int lowest = sector_floor[s];
                for (unsigned j = 0; j < NUM_LINES; ++j) {
                    const Line* edge = &map->lines[j];
                    if (edge->side[1] == 65535u) continue;
                    unsigned sa = map->sides[edge->side[0]].sector;
                    unsigned sb = map->sides[edge->side[1]].sector;
                    if (sa == s) lowest = math::min(lowest, static_cast<int>(sector_floor[sb]));
                    if (sb == s) lowest = math::min(lowest, static_cast<int>(sector_floor[sa]));
                }
                if (line->special == 36) {
                    floor_target[s] = static_cast<int16_t>(math::min(static_cast<int>(sector_floor[s]), lowest + 8));
                } else if (!floor_wait[s] && sector_floor[s] == (*map->sector_at(s)).floor) {
                    floor_target[s] = static_cast<int16_t>(lowest);
                    floor_wait[s] = 255;
                }
            }
        }
    }

    void tick(uint8_t input) noexcept {
        if (player.dead || player.exited) return;
        ++player.ticks;
        if (player.fire) {
            --player.fire;
            if (player.fire == PistolFireAt) fire_shot();
            if (player.fire == 0 && (input & Input::Fire) && player.ammo) player.fire = PistolTotal;
        }
        if (player.damage) --player.damage;

        if (!(input & Input::Strafe)) {
            int turn = (input & Input::Run) ? 6 : 3;
            if (input & Input::Left)  player.angle = (player.angle + turn) & 1023;
            if (input & Input::Right) player.angle = (player.angle - turn) & 1023;
        }

        int forward = ((input & Input::Forward) != 0) - ((input & Input::Back) != 0);
        int strafe  = (input & Input::Strafe) ? (((input & Input::Right) != 0) - ((input & Input::Left) != 0)) : 0;
        int oldx = player.world_x(), oldy = player.world_y();

        if (forward || strafe) {
            int c = math::icos(player.angle), s = math::isin(player.angle);
            int speed = (input & Input::Run) ? 8 : 4;
            int32_t nx = player.x + (forward * c + strafe * s) * speed;
            int32_t ny = player.y + (forward * s - strafe * c) * speed;
            if (nx != player.x && can_move(static_cast<int>(nx / 256), player.world_y(), player.floor)) player.x = nx;
            if (ny != player.y && can_move(player.world_x(), static_cast<int>(ny / 256), player.floor)) player.y = ny;
        }

        int x = player.world_x(), y = player.world_y();
        if (x != oldx || y != oldy) player.sector = find_sector(x, y);
        player.floor = sector_floor[player.sector];
        int target = player.floor + 41;
        player.eye += static_cast<int16_t>(math::clamp(target - player.eye, -8, 8));

        cross_triggers(oldx, oldy, x, y);

        for (unsigned i = 0; i < NUM_SECTORS; ++i) {
            if (sector_ceiling[i] == sector_target[i] && sector_floor[i] == floor_target[i] && !floor_wait[i]) continue;
            sector_ceiling[i] += static_cast<int16_t>(math::clamp(sector_target[i] - sector_ceiling[i], 0, 2));
            sector_floor[i]   += static_cast<int16_t>(math::clamp(floor_target[i] - sector_floor[i], -4, 4));
            if (floor_wait[i] == 255 && sector_floor[i] == floor_target[i]) floor_wait[i] = 105;
            else if (floor_wait[i] && floor_wait[i] < 255 && !--floor_wait[i]) floor_target[i] = (*map->sector_at(i)).floor;
        }

        if ((input & Input::Use) && !use_held) use();
        use_held = (input & Input::Use) != 0;
        if (input & Input::Fire) shoot();

        if (!(player.ticks & 31)) {
            uint8_t spec = (*map->sector_at(player.sector)).special;
            if (spec == 5 || spec == 7 || spec == 16) player.hurt(5);
        }

        Actor* a = actors;
        const MapActor* m = map->actors;
        for (unsigned i = 0; i < NUM_ACTORS; ++i, ++a, ++m) {
            if (a->removed) continue;
            if (a->pain) --a->pain;
            if (a->die && a->die != 255) {
                if (++a->die >= DeathTics) a->die = 255;
                continue;
            }
            if (a->explode) {
                if (++a->explode > ExplodeTotal) a->removed = 1;
                continue;
            }
            if ((m->kind != 1 && m->kind != 2) || (m->kind == 1 && !a->hp)) continue;

            int dx = x - a->x, dy = y - a->y;
            int dist = math::max(math::abs(dx), math::abs(dy));

            if (m->kind == 2 && dist < 28) {
                bool take = true;
                switch (m->type) {
                    case 2011: case 2012:
                        if (player.health >= 100) take = false;
                        else player.health = static_cast<int16_t>(math::min(100, player.health + (m->type == 2011 ? 10 : 25)));
                        break;
                    case 2014: player.health = static_cast<int16_t>(math::min(200, player.health + 1)); break;
                    case 2015: player.armor  = static_cast<int16_t>(math::min(200, player.armor + 1)); break;
                    case 2018: case 2019: player.armor = static_cast<int16_t>(math::max(static_cast<int>(player.armor), m->type == 2018 ? 100 : 200)); break;
                    default: player.ammo = static_cast<int16_t>(math::min(200, player.ammo + 10)); break;
                }
                if (take) a->removed = 1;
            }

            if (m->kind != 1 || !a->hp || dist > 768) continue;
            if (a->cooldown) --a->cooldown;
            if (((player.ticks + i) & 7) != 0 || !line_of_sight(a->x, a->y, x, y, player.eye)) continue;

            if (dist < 384 && !a->cooldown) {
                player.hurt(2 + static_cast<int>(math::rnd() % 7));
                a->cooldown = 35;
            }
            if (dist > 48) {
                int mx = a->x + math::clamp(dx, -4, 4);
                int my = a->y + math::clamp(dy, -4, 4);
                if (can_move(mx, a->y, sector_floor[a->sector])) a->x = static_cast<int16_t>(mx);
                if (can_move(a->x, my, sector_floor[a->sector])) a->y = static_cast<int16_t>(my);
                a->sector = find_sector(a->x, a->y);
            }
        }
    }
};

} // namespace doom
