#include "p_map.h"
#include "p_local.h"
#include "r_state.h"
#include "r_bsp.h"
#include "m_fixed.h"

int16_t sector_ceiling[NUM_SECTORS], sector_target[NUM_SECTORS];
int16_t sector_floor[NUM_SECTORS], floor_target[NUM_SECTORS];
uint8_t floor_wait[NUM_SECTORS];

uint8_t engine_sector(int x, int y) {
    unsigned index = NUM_NODES - 1;
    while (!(index & 0x8000u)) {
        const Node *n = (const Node *)((const uint8_t *)nodes + node_offsets[(uint8_t)index]);
        index = n->child[node_side(x, y, n)];
    }
    const Subsector *sub = &subsectors[index & 0x7fffu];
    const Seg *seg = &segs[sub->first];
    return sides[map_lines[seg->line].side[seg->side]].sector;
}

bool line_passable(const Line *l, int floor) {
    if (l->side[1] == 65535u || (l->flags & 1)) return false;
    unsigned a = sides[l->side[0]].sector, b = sides[l->side[1]].sector;
    int bottom = MAX(sector_floor[a], sector_floor[b]);
    return bottom - floor <= 24 && MIN(sector_ceiling[a], sector_ceiling[b]) - MAX(bottom, floor) >= 56;
}

bool collision_line(unsigned i, int x, int y, int floor) {
    const int radius = 16;
    const Line *l = &map_lines[i];
    const Vertex *a = &map_vertices[l->v1], *b = &map_vertices[l->v2];
    if (x < MIN(a->x, b->x) - radius || x > MAX(a->x, b->x) + radius || y < MIN(a->y, b->y) - radius || y > MAX(a->y, b->y) + radius) return true;
    if (line_passable(l, floor)) return true;
    int dx = b->x - a->x, dy = b->y - a->y, px = x - a->x, py = y - a->y;
    int32_t len2 = (int32_t)dx * dx + (int32_t)dy * dy;
    int32_t dot = (int32_t)px * dx + (int32_t)py * dy;
    if (dot < 0) {
        if ((int32_t)px * px + (int32_t)py * py < radius * radius) return false;
    } else if (dot > len2) {
        px = x - b->x; py = y - b->y;
        if ((int32_t)px * px + (int32_t)py * py < radius * radius) return false;
    } else if (len2) {
        /* Project to 8.8 along segment. The bbox above bounds these
         * products for E1M1; use 64-bit only in this infrequent path. */
        int32_t t = (int32_t)(((int64_t)dot * 256) / len2);
        px = x - (a->x + (int)((int32_t)dx * t / 256));
        py = y - (a->y + (int)((int32_t)dy * t / 256));
        if ((int32_t)px * px + (int32_t)py * py < radius * radius) return false;
    }
    return true;
}

bool engine_can_move(int x, int y, int floor) {
    int left = (x - 16 - blockmap[0]) >> 7, right = (x + 16 - blockmap[0]) >> 7;
    int bottom = (y - 16 - blockmap[1]) >> 7, top = (y + 16 - blockmap[1]) >> 7;
    if (left < 0 || bottom < 0 || right >= blockmap[2] || top >= blockmap[3]) return false;
    for (int row = bottom; row <= top; ++row) {
        for (int col = left; col <= right; ++col) {
            unsigned offset = (uint16_t)blockmap[4 + row * blockmap[2] + col];
            /* Each original Doom block list starts with a dummy zero. */
            for (++offset; blockmap[offset] != -1; ++offset) {
                if (!collision_line((uint16_t)blockmap[offset], x, y, floor)) return false;
            }
        }
    }
    uint8_t s = engine_sector(x, y);
    return sector_floor[s] - floor <= 24 && sector_ceiling[s] - MAX(sector_floor[s], floor) >= 56;
}

/* Segment crossing test for shooting/AI. The prototype treats the shot as
 * horizontal at eye height and respects closed doors and vertical openings. */
bool sight(int x, int y, int tx, int ty, int eye) {
    int dx = tx - x, dy = ty - y;
    for (unsigned i = 0; i < NUM_LINES; ++i) {
        const Line *l = &map_lines[i];
        const Vertex *a = &map_vertices[l->v1], *b = &map_vertices[l->v2];
        if (MAX(x, tx) < MIN(a->x, b->x) || MIN(x, tx) > MAX(a->x, b->x) || MAX(y, ty) < MIN(a->y, b->y) || MIN(y, ty) > MAX(a->y, b->y)) continue;
        if (l->side[1] != 65535u) {
            unsigned sa = sides[l->side[0]].sector, sb = sides[l->side[1]].sector;
            if (eye > MAX(sector_floor[sa], sector_floor[sb]) && eye < MIN(sector_ceiling[sa], sector_ceiling[sb])) continue;
        }
        int32_t c1 = (int32_t)(a->x - x) * dy - (int32_t)(a->y - y) * dx;
        int32_t c2 = (int32_t)(b->x - x) * dy - (int32_t)(b->y - y) * dx;
        int32_t c3 = (int32_t)(x - a->x) * (b->y - a->y) - (int32_t)(y - a->y) * (b->x - a->x);
        int32_t c4 = (int32_t)(tx - a->x) * (b->y - a->y) - (int32_t)(ty - a->y) * (b->x - a->x);
        if ((c1 < 0) != (c2 < 0) && (c3 < 0) != (c4 < 0)) return false;
    }
    return true;
}
