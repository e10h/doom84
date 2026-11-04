#include "r_draw.h"
#include "r_state.h"

void d84_wall(uint8_t *dst, uint8_t *depth, const uint8_t *image, const uint8_t *light, unsigned count, int v, int step, unsigned z) {
    while (count--) {
        *dst = light[image[(((unsigned)v >> 8) & 31) * 32]];
        *depth = (uint8_t)z;
        dst += VIEW_W;
        depth += VIEW_W;
        v += step;
    }
}

void d84_span(uint8_t *dst, uint8_t *depth, const uint8_t *image, const uint8_t *light, unsigned count, int wx, int wy, int sx, int sy, unsigned z) {
    while (count--) {
        *dst++ = light[image[(((unsigned)wy >> 9) & 31) * 32 + (((unsigned)wx >> 9) & 31)]];
        *depth++ = (uint8_t)z;
        wx += sx;
        wy += sy;
    }
}

void d84_span2(uint8_t *dst, uint8_t *depth, const uint8_t *image, const uint8_t *light, unsigned count, int wx, int wy, int sx, int sy, unsigned z) {
    while (count--) {
        *dst = light[image[(((unsigned)wy >> 9) & 31) * 32 + (((unsigned)wx >> 9) & 31)]];
        *depth = (uint8_t)z;
        dst += 2;
        depth += 2;
        wx += sx;
        wy += sy;
    }
}

void d84_span3(uint8_t *dst, uint8_t *depth, const uint8_t *image, const uint8_t *light, unsigned count, int wx, int wy, int sx, int sy, unsigned z) {
    while (count--) {
        *dst = light[image[(((unsigned)wy >> 9) & 31) * 32 + (((unsigned)wx >> 9) & 31)]];
        *depth = (uint8_t)z;
        dst += 3;
        depth += 3;
        wx += sx;
        wy += sy;
    }
}

void d84_span4(uint8_t *dst, uint8_t *depth, const uint8_t *image, const uint8_t *light, unsigned count, int wx, int wy, int sx, int sy, unsigned z) {
    while (count--) {
        *dst = light[image[(((unsigned)wy >> 9) & 31) * 32 + (((unsigned)wx >> 9) & 31)]];
        *depth = (uint8_t)z;
        dst += 4;
        depth += 4;
        wx += sx;
        wy += sy;
    }
}

void d84_quad_columns(uint8_t *dst, unsigned count) {
    while (count--) {
        dst[1] = dst[2] = dst[3] = dst[0];
        dst += 4;
    }
}

/* rows = VIEW_H; 128 is not divisible by 3, so expand per row. */
void d84_triple_columns(uint8_t *dst, unsigned rows) {
    for (unsigned y = 0; y < rows; ++y) {
        uint8_t *row = dst + y * VIEW_W;
        for (unsigned x = 0; x < VIEW_W; x += 3) {
            uint8_t v = row[x];
            if (x + 1 < VIEW_W) row[x + 1] = v;
            if (x + 2 < VIEW_W) row[x + 2] = v;
        }
    }
}

void d84_fill_column(uint8_t *dst, unsigned count, unsigned color) {
    while (count--) {
        *dst = (uint8_t)color;
        dst += VIEW_W;
    }
}

void d84_double_columns(uint8_t *dst, unsigned count) {
    while (count--) {
        dst[1] = dst[0];
        dst += 2;
    }
}

void d84_sprite(uint8_t *dst, uint8_t *depth, const uint8_t *image, const uint8_t *light, unsigned count, unsigned u, unsigned step, unsigned z, unsigned stride) {
    while (count--) {
        if (z < *depth) {
            uint8_t pixel = image[u >> 8];
            if (pixel != 255) {
                *dst = light[pixel];
                *depth = (uint8_t)z;
            }
        }
        dst += stride;
        depth += stride;
        u += step;
    }
}

void wire_plot(int x, int y, uint8_t color) {
    if ((unsigned)x < VIEW_W && (unsigned)y < VIEW_H) framebuffer[y * VIEW_W + x] = color;
}
