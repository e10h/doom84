#include "d_main.h"
#include "r_state.h"
#include "p_local.h"
#include "p_map.h"
#include "m_fixed.h"
#include <string.h>

Actor actors[NUM_ACTORS];
uint8_t use_held;

bool engine_init(const uint8_t *map, unsigned size, const uint8_t *const *banks, const unsigned *sizes) {
    if (size != MAP_SIZE || memcmp(map, "D84MAP01", 8) || memcmp(map + 8, asset_id, 8)) return false;
    for (unsigned i = 0; i < NUM_BANKS; ++i) {
        if (sizes[i] != bank_sizes[i] || memcmp(banks[i], "D84TEX01", 8) || memcmp(banks[i] + 8, asset_id, 8)) return false;
    }
    map_vertices = (const Vertex *)(map + OFF_VERTICES);
    map_lines = (const Line *)(map + OFF_LINES);
    sides = (const Side *)(map + OFF_SIDES);
    map_sectors = (const Sector *)(map + OFF_SECTORS);
    segs = (const Seg *)(map + OFF_SEGS);
    subsectors = (const Subsector *)(map + OFF_SUBSECTORS);
    nodes = (const Node *)(map + OFF_NODES);
    map_actors = (const MapActor *)(map + OFF_ACTORS);
    blockmap = (const int16_t *)(map + OFF_BLOCKMAP);
    map_palette = map + OFF_PALETTE;
    memcpy(ram_colormaps, map + OFF_COLORMAP, sizeof(ram_colormaps));
    colormaps = ram_colormaps;
    for (unsigned i = 0; i < 32; ++i) shade_rows[i] = colormaps + i * 256;
    M_InitMath();
    for (unsigned i = 0; i < NUM_TILES; ++i) images[i] = banks[tile_bank[i]] + tile_offset[i];
    for (unsigned i = 0; i < NUM_SEGS; ++i) {
        const Seg *seg = &segs[i];
        const Line *line = &map_lines[seg->line];
        const Side *s = &sides[line->side[seg->side]];
        materials[i] = (Material){
            s->sector,
            line->side[seg->side ^ 1] == 65535u ? (uint8_t)255 : sides[line->side[seg->side ^ 1]].sector,
            s->middle,
            s->upper,
            s->lower,
            (uint8_t)line->flags,
            s->x,
            s->y
        };
        Material *m = &materials[i];
        m->flags &= 127;
        if (m->back != 255) {
            const Sector *a = sector_at(m->sector), *b = sector_at(m->back);
            if (a->flat == b->flat && a->ceiltex == b->ceiltex && a->light == b->light) m->flags |= 128;
        }
    }
    /* FAST-mode sky fill: mean RGB of the upper SKY1 band (textured mode only
     * samples ~top 24/32 rows; averaging the dark horizon dragged the fill down). */
    {
        const uint8_t *sky = images[SKY_TILE];
        unsigned long sr = 0, sg = 0, sb = 0, n = 0;
        for (unsigned y = 0; y < 6; ++y) {
            for (unsigned x = 0; x < 32; ++x, ++n) {
                const uint8_t *c = map_palette + sky[y * 32 + x] * 3;
                sr += c[0]; sg += c[1]; sb += c[2];
            }
        }
        sr /= n; sg /= n; sb /= n;
        unsigned best = sky[0], bestd = ~0u;
        for (unsigned i = 0; i < 256; ++i) {
            const uint8_t *c = map_palette + i * 3;
            int dr = (int)c[0] - (int)sr, dg = (int)c[1] - (int)sg, db = (int)c[2] - (int)sb;
            unsigned d = (unsigned)(dr * dr + dg * dg + db * db);
            if (d < bestd) { bestd = d; best = i; }
        }
        sky_flat = (uint8_t)best;
    }
    for (unsigned i = 0; i < NUM_SECTORS; ++i) {
        const Sector *s = &(*sector_at(i));
        sector_shades[i] = (uint8_t)((255 - s->light) / 8);
        const uint8_t *light = colormaps + ((255 - s->light) / 8) * 256;
        plane_colors[i] = light[images[s->flat][528]];
        plane_colors[i + NUM_SECTORS] = s->ceiltex == 255 ? sky_flat : light[images[s->ceiltex][528]];
    }
    engine_view.width = VIEW_W;
    engine_view.height = VIEW_H;
    engine_reset();
    return true;
}

void engine_reset(void) {
    memset(&player, 0, sizeof(player));
    player.x = (int32_t)START_X * 256;
    player.y = (int32_t)START_Y * 256;
    player.angle = START_ANGLE;
    player.health = 100;
    player.ammo = 50;
    player.texture_planes = true;
    player.sector = engine_sector(START_X, START_Y);
    player.floor = (*sector_at(player.sector)).floor;
    player.eye = player.floor + 41;
    random_state = 1;
    use_held = 0;
    memset(floor_wait, 0, sizeof(floor_wait));
    for (unsigned i = 0; i < NUM_SECTORS; ++i) {
        sector_target[i] = sector_ceiling[i] = (*sector_at(i)).ceiling;
        floor_target[i] = sector_floor[i] = (*sector_at(i)).floor;
    }
    for (unsigned i = 0; i < NUM_ACTORS; ++i) {
        const MapActor *m = &map_actors[i];
        actors[i] = (Actor){m->x, m->y, engine_sector(m->x, m->y), (uint8_t)m->hp, 0, 0, 0, 0, 0};
        if (m->kind == 1) ++player.total;
    }
}
