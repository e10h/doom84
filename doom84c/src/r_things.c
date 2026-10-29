#include "r_things.h"
#include "r_state.h"
#include "r_draw.h"
#include "r_main.h"
#include "p_local.h"
#include "m_fixed.h"

uint8_t sprite_order[NUM_ACTORS];
int16_t sprite_z[NUM_ACTORS], sprite_x[NUM_ACTORS];

__attribute__((noinline)) void draw_sprites(void) {
    unsigned count = 0;
    for (unsigned i = 0; i < NUM_ACTORS; ++i) {
        if (actors[i].removed) continue;
        int dx = actors[i].x - camx, dy = actors[i].y - camy;
        d84_rotate(dx, dy);
        int z = d84_rotated[1], r = d84_rotated[0];
        if (z < 8 || ABS(r) > z + 64) continue;
        sprite_z[i] = (int16_t)z;
        sprite_x[i] = (int16_t)r;
        unsigned j = count;
        while (j && sprite_z[sprite_order[j - 1]] < z) {
            sprite_order[j] = sprite_order[j - 1];
            --j;
        }
        sprite_order[j] = (uint8_t)i;
        ++count;
    }
    for (unsigned k = 0; k < count; ++k) {
        unsigned i = sprite_order[k];
        const MapActor *m = &map_actors[i];
        Actor *a = &actors[i];
        int z = sprite_z[i], center = 64 + (int)sprite_x[i] * FOCAL / z;
        int width = MAX(1, (int)m->width * FOCAL / z);
        int hworld = (int)m->height;
        bool exploding = a->explode != 0;
        unsigned image;
        const uint8_t *light;
        if (exploding) {
            unsigned frame = MIN(NUM_BARREL_EXP - 1, (unsigned)(a->explode - 1) / EXPLODE_TIC);
            image = barrel_explode[frame];
            width = MAX(width, width * 5 / 4);
            hworld = MAX(hworld, hworld * 5 / 4);
            light = shade_rows[0];
        } else if (m->hp && a->die && a->die != 255) {
            /* Stand → walk → corpse while shrinking to gib height. */
            uint8_t d = a->die;
            image = d < 5 ? m->image : d < 9 ? m->walk : m->death;
            int hcorp = MAX(1, hworld / 4);
            hworld = hworld - (hworld - hcorp) * (int)(d - 1) / (DEATH_TICS - 1);
            light = shade_rows[0];
        } else if (m->hp && !a->hp) {
            image = m->death;
            hworld = MAX(1, hworld / 4);
            light = lighting(a->sector, z);
        } else if (a->pain) {
            image = m->walk;
            light = shade_rows[0];
        } else {
            image = (player.ticks & 8) ? m->walk : m->image;
            light = lighting(a->sector, z);
        }
        int height = MAX(1, hworld * FOCAL / z);
        int left = center - width / 2, bottom = project(sector_floor[a->sector], z), top = bottom - height;
        const uint8_t *pixels = images[image];
        uint8_t depth = (uint8_t)CLAMP(z / 16, 1, 254);
        int x1 = MAX(0, left), x2 = MIN(VIEW_W, left + width), y1 = MAX(0, top), y2 = MIN(VIEW_H, bottom);
        unsigned sxstep = (64u * 256) / width, systep = (64u * 256) / height;
        if (render_detail > 1) x1 = ((x1 + (int)render_detail - 1) / (int)render_detail) * (int)render_detail;
        if (x1 >= x2 || y1 >= y2) continue;
        unsigned scount = (unsigned)(x2 - x1 + (int)render_detail - 1) / render_detail;
        if (!scount) continue;
        unsigned sxpos = (unsigned)(x1 - left) * sxstep;
        unsigned sypos = (unsigned)(y1 - top) * systep;
        unsigned offset = (unsigned)(y1 * VIEW_W + x1);
        for (int y = y1; y < y2; ++y, sypos += systep, offset += VIEW_W) {
            unsigned sy = MIN(63, sypos >> 8);
            d84_sprite(framebuffer + offset, depthbuffer + offset, pixels + sy * 64, light, scount, sxpos, sxstep * render_detail, depth, render_detail);
        }
    }
}
