#include "p_tick.h"
#include "p_local.h"
#include "p_map.h"
#include "p_inter.h"
#include "r_state.h"
#include "m_fixed.h"

void cross_triggers(int oldx, int oldy, int x, int y) {
    if (oldx == x && oldy == y) return;
    for (unsigned i = 0; i < NUM_WALK_TRIGGERS; ++i) {
        const Line *line = &map_lines[walk_triggers[i]];
        const Vertex *a = &map_vertices[line->v1], *b = &map_vertices[line->v2];
        if (MAX(oldx, x) < MIN(a->x, b->x) || MIN(oldx, x) > MAX(a->x, b->x) || MAX(oldy, y) < MIN(a->y, b->y) || MIN(oldy, y) > MAX(a->y, b->y)) continue;
        int dx = b->x - a->x, dy = b->y - a->y;
        int32_t before = (int32_t)(oldx - a->x) * dy - (int32_t)(oldy - a->y) * dx;
        int32_t after = (int32_t)(x - a->x) * dy - (int32_t)(y - a->y) * dx;
        if ((before < 0) == (after < 0)) continue;
        for (unsigned s = 0; s < NUM_SECTORS; ++s) {
            if (!line->tag || (*sector_at(s)).tag != line->tag) continue;
            int lowest = sector_floor[s];
            for (unsigned j = 0; j < NUM_LINES; ++j) {
                const Line *edge = &map_lines[j];
                if (edge->side[1] == 65535u) continue;
                unsigned sa = sides[edge->side[0]].sector, sb = sides[edge->side[1]].sector;
                if (sa == s) lowest = MIN(lowest, sector_floor[sb]);
                if (sb == s) lowest = MIN(lowest, sector_floor[sa]);
            }
            if (line->special == 36) floor_target[s] = MIN(sector_floor[s], lowest + 8);
            else if (!floor_wait[s] && sector_floor[s] == (*sector_at(s)).floor) {
                floor_target[s] = lowest;
                floor_wait[s] = 255;
            }
        }
    }
}

void engine_tick(uint8_t input) {
    if (player.dead || player.exited) return;
    ++player.ticks;
    if (player.fire) {
        --player.fire;
        if (player.fire == PISTOL_FIRE_AT) fire_shot();
        /* A_ReFire: holding the trigger restarts at the end of the cycle. */
        if (player.fire == 0 && (input & INPUT_FIRE) && player.ammo) player.fire = PISTOL_TOTAL;
    }
    if (player.damage) --player.damage;
    if (!(input & INPUT_STRAFE)) {
        /* Keyboard turn in 1024-circle units (slower than Doom BAM 640/1280). */
        int turn = (input & INPUT_RUN) ? 6 : 3;
        if (input & INPUT_LEFT) player.angle = (player.angle + turn) & 1023;
        if (input & INPUT_RIGHT) player.angle = (player.angle - turn) & 1023;
    }
    int forward = ((input & INPUT_FORWARD) != 0) - ((input & INPUT_BACK) != 0);
    int strafe = (input & INPUT_STRAFE) ? (((input & INPUT_RIGHT) != 0) - ((input & INPUT_LEFT) != 0)) : 0;
    int oldx = (int)(player.x / 256), oldy = (int)(player.y / 256);
    if (forward || strafe) {
        int c = icos(player.angle), s = isin(player.angle), speed = (input & INPUT_RUN) ? 8 : 4;
        int32_t nx = player.x + (forward * c + strafe * s) * speed;
        int32_t ny = player.y + (forward * s - strafe * c) * speed;
        if (nx != player.x && engine_can_move((int)(nx / 256), (int)(player.y / 256), player.floor)) player.x = nx;
        if (ny != player.y && engine_can_move((int)(player.x / 256), (int)(ny / 256), player.floor)) player.y = ny;
    }
    int x = (int)(player.x / 256), y = (int)(player.y / 256);
    if (x != oldx || y != oldy) player.sector = engine_sector(x, y);
    player.floor = sector_floor[player.sector];
    int target = player.floor + 41;
    player.eye += CLAMP(target - player.eye, -8, 8);
    cross_triggers(oldx, oldy, x, y);
    for (unsigned i = 0; i < NUM_SECTORS; ++i) {
        if (sector_ceiling[i] == sector_target[i] && sector_floor[i] == floor_target[i] && !floor_wait[i]) continue;
        sector_ceiling[i] += CLAMP(sector_target[i] - sector_ceiling[i], 0, 2);
        sector_floor[i] += CLAMP(floor_target[i] - sector_floor[i], -4, 4);
        if (floor_wait[i] == 255 && sector_floor[i] == floor_target[i]) floor_wait[i] = 105;
        else if (floor_wait[i] && floor_wait[i] < 255 && !--floor_wait[i]) floor_target[i] = (*sector_at(i)).floor;
    }
    if ((input & INPUT_USE) && !use_held) use();
    use_held = (input & INPUT_USE) != 0;
    if (input & INPUT_FIRE) shoot();
    if (!(player.ticks & 31) && ((*sector_at(player.sector)).special == 5 || (*sector_at(player.sector)).special == 7 || (*sector_at(player.sector)).special == 16)) hurt(5);
    Actor *a = actors;
    const MapActor *m = map_actors;
    for (unsigned i = 0; i < NUM_ACTORS; ++i, ++a, ++m) {
        if (a->removed) continue;
        if (a->pain) --a->pain;
        if (a->die && a->die != 255) {
            if (++a->die >= DEATH_TICS) a->die = 255;
            continue;
        }
        if (a->explode) {
            if (++a->explode > EXPLODE_TOTAL) a->removed = 1;
            continue;
        }
        if ((m->kind != 1 && m->kind != 2) || (m->kind == 1 && !a->hp)) continue;
        int dx = x - a->x, dy = y - a->y, dist = MAX(ABS(dx), ABS(dy));
        if (m->kind == 2 && dist < 28) {
            bool take = true;
            switch (m->type) {
                case 2011: case 2012:
                    if (player.health >= 100) take = false;
                    else player.health = MIN(100, player.health + (m->type == 2011 ? 10 : 25));
                    break;
                case 2014: player.health = MIN(200, player.health + 1); break;
                case 2015: player.armor = MIN(200, player.armor + 1); break;
                case 2018: case 2019: player.armor = MAX(player.armor, m->type == 2018 ? 100 : 200); break;
                default: player.ammo = MIN(200, player.ammo + 10); break;
            }
            if (take) a->removed = 1;
        }
        if (m->kind != 1 || !a->hp || dist > 768) continue;
        if (a->cooldown) --a->cooldown;
        if (((player.ticks + i) & 7) != 0 || !sight(a->x, a->y, x, y, player.eye)) continue;
        if (dist < 384 && !a->cooldown) {
            hurt(2 + (rnd() % 7));
            a->cooldown = 35;
        }
        if (dist > 48) {
            int mx = a->x + CLAMP(dx, -4, 4), my = a->y + CLAMP(dy, -4, 4);
            if (engine_can_move(mx, a->y, sector_floor[a->sector])) a->x = mx;
            if (engine_can_move(a->x, my, sector_floor[a->sector])) a->y = my;
            a->sector = engine_sector(a->x, a->y);
        }
    }
}
