#include "r_plane.h"
#include "r_state.h"
#include "r_draw.h"
#include "r_main.h"
#include "p_local.h"
#include "m_fixed.h"
#include <string.h>

void plane_column(int x, int y1, int y2, uint8_t plane) {
    if (y1 > y2) return;
    if (!player.texture_planes) {
        d84_fill_column(framebuffer + row_offsets[(uint8_t)y1] + x, (unsigned)(y2 - y1 + 1), plane_colors[(plane & 127) + ((plane & 128) ? NUM_SECTORS : 0)]);
        return;
    }
    for (int y = y1; y <= y2; ++y) planes[y * VIEW_W + x] = plane;
}

__attribute__((noinline)) void draw_planes(void) {
    uint8_t *pixels = framebuffer, *depths = depthbuffer;
    const uint8_t *cursor = planes;
    for (int y = 0; y < VIEW_H; ++y) {
        const uint8_t *row = cursor, *endrow = row + VIEW_W;
        while (cursor < endrow) {
            const uint8_t *begin = cursor;
            uint8_t plane = *cursor++;
            while (cursor < endrow && *cursor == plane) ++cursor;
            unsigned length = (unsigned)(cursor - begin);
            if (plane == 255) {
                pixels += length;
                depths += length;
                continue;
            }
            int x = (int)(begin - row);
            ++render_stats.plane_spans;
            unsigned sector = plane & 127;
            int ceiling = plane & 128;
            int texture = ceiling ? (*sector_at(sector)).ceiltex : (*sector_at(sector)).flat;
            if (texture == 255) {
                const uint8_t *sky = images[SKY_TILE];
                for (unsigned i = 0; i < length; ++i) {
                    pixels[i] = sky[(y * 24 / VIEW_H) * 32 + (((player.angle >> 3) + (x + (int)i) / 4) & 31)];
                }
                pixels += length;
                depths += length;
                continue;
            }
            int height = ceiling ? sector_ceiling[sector] : sector_floor[sector];
            int dy = CENTER - y;
            int z = dy ? (height - player.eye) * FOCAL / dy : 8192;
            z = CLAMP(z, 1, 8192);
            const uint8_t *light = lighting(sector, z);
            const uint8_t *image = images[texture];
            if (!player.texture_planes) {
                memset(pixels, light[image[16 * 32 + 16]], length);
                memset(depths, CLAMP(z / 16, 1, 254), length);
                pixels += length;
                depths += length;
                continue;
            }
            int stepx = (z * camsin) >> 6, stepy = (-z * camcos) >> 6;
            int wx = (int)player.x + z * camcos + stepx * (x - 64);
            int wy = (int)player.y + z * camsin + stepy * (x - 64);
            uint8_t depth = (uint8_t)CLAMP(z / 16, 1, 254);
            if (render_detail == 4) {
                if (length >= 4) d84_span4(pixels, depths, image, light, length / 4, wx, wy, stepx * 4, stepy * 4, depth);
            } else if (render_detail == 3) {
                if (length >= 3) d84_span3(pixels, depths, image, light, length / 3, wx, wy, stepx * 3, stepy * 3, depth);
            } else if (render_detail == 2) {
                if (length >= 2) d84_span2(pixels, depths, image, light, length / 2, wx, wy, stepx * 2, stepy * 2, depth);
            } else {
                d84_span(pixels, depths, image, light, length, wx, wy, stepx, stepy, depth);
            }
            pixels += length;
            depths += length;
        }
    }
}
