#include "p_inter.h"
#include "p_local.h"
#include "p_map.h"
#include "r_state.h"
#include "m_fixed.h"
#include <stddef.h>

void activate_sector(unsigned s) {
    int ceiling = 32767, floor = 32767;
    for (unsigned j = 0; j < NUM_LINES; ++j) {
        const Line *edge = &map_lines[j];
        if (edge->side[1] == 65535u) continue;
        unsigned a = sides[edge->side[0]].sector, b = sides[edge->side[1]].sector;
        if (a != s && b != s) continue;
        unsigned other = a == s ? b : a;
        ceiling = MIN(ceiling, sector_ceiling[other] - 4);
        floor = MIN(floor, sector_floor[other]);
    }
    if (ceiling != 32767) sector_target[s] = MAX(sector_ceiling[s], ceiling);
    if (floor != 32767 && floor < sector_floor[s]) floor_target[s] = floor;
}

void use(void) {
    int x = (int)(player.x / 256), y = (int)(player.y / 256);
    int c = icos(player.angle), s = isin(player.angle);
    int best = 80;
    const Line *found = NULL;
    for (unsigned i = 0; i < NUM_LINES; ++i) {
        const Line *l = &map_lines[i];
        if (!l->special || l->special == 48) continue;
        const Vertex *a = &map_vertices[l->v1], *b = &map_vertices[l->v2];
        int ax = a->x - x, ay = a->y - y, bx = b->x - x, by = b->y - y;
        int ar = (int)(((int32_t)ax * s - (int32_t)ay * c) / 256);
        int br = (int)(((int32_t)bx * s - (int32_t)by * c) / 256);
        if ((ar < 0) == (br < 0) || ar == br) continue;
        int az = (int)(((int32_t)ax * c + (int32_t)ay * s) / 256);
        int bz = (int)(((int32_t)bx * c + (int32_t)by * s) / 256);
        int z = az + (int)((int32_t)(bz - az) * ar / (ar - br));
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
    if (found->side[1] != 65535u) activate_sector(sides[found->side[1]].sector);
}

void hurt(int damage) {
    int absorbed = MIN(player.armor, damage / 3);
    player.armor -= absorbed;
    player.health -= damage - absorbed;
    player.damage = 5;
    if (player.health <= 0) {
        player.health = 0;
        player.dead = true;
    }
}

void explode_barrel(unsigned index) {
    Actor *a = &actors[index];
    if (a->removed || a->explode) return;
    a->hp = 0;
    a->explode = 1;
    int bx = a->x, by = a->y;
    int px = (int)(player.x / 256), py = (int)(player.y / 256);
    int pdist = MAX(ABS(px - bx), ABS(py - by));
    if (pdist < 128) hurt((128 - pdist) / 4 + 1 + (int)(rnd() % 5));
    for (unsigned i = 0; i < NUM_ACTORS; ++i) {
        if (i == index) continue;
        Actor *o = &actors[i];
        if (!o->hp || o->removed || o->explode) continue;
        int dist = MAX(ABS(o->x - bx), ABS(o->y - by));
        if (dist >= 128) continue;
        damage_actor(i, (128 - dist) / 2 + 1 + (int)(rnd() % 5));
    }
}

void damage_actor(unsigned index, int damage) {
    Actor *a = &actors[index];
    const MapActor *m = &map_actors[index];
    if (!a->hp || a->removed || a->explode || a->die) return;
    if (damage < a->hp) {
        a->hp = (uint8_t)(a->hp - damage);
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

void fire_shot(void) {
    if (!player.ammo) return;
    --player.ammo;
    int c = icos(player.angle), s = isin(player.angle), best = 2048, index = -1;
    int x = (int)(player.x / 256), y = (int)(player.y / 256);
    for (unsigned i = 0; i < NUM_ACTORS; ++i) {
        Actor *a = &actors[i];
        if (!a->hp || a->removed || a->explode) continue;
        int dx = a->x - x, dy = a->y - y;
        int z = (int)(((int32_t)dx * c + (int32_t)dy * s) / 256);
        int r = (int)(((int32_t)dx * s - (int32_t)dy * c) / 256);
        if (z < 0 || z >= best || ABS(r) > 20) continue;
        if (!sight(x, y, a->x, a->y, player.eye)) continue;
        best = z;
        index = (int)i;
    }
    if (index >= 0) damage_actor((unsigned)index, 5 * (1 + (rnd() % 3)));
}

void shoot(void) {
    if (player.fire || !player.ammo) return;
    player.fire = PISTOL_TOTAL;
}
