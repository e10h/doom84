#ifndef R_DEFS_H
#define R_DEFS_H

#include "doomdef.h"
#include <stdint.h>
#include <stdbool.h>

typedef struct __attribute__((packed)) {
    uint8_t sector, back, middle, upper, lower, flags;
    int16_t x, y;
} Material;

typedef struct {
    const uint8_t *image;
    int base;
    int8_t shiftx, shifty;
} WallStyle;

typedef struct {
    int start, end, iz, diz, uz, duz, cyq, cy_step, fyq, fy_step, upperq, upper_step, lowerq, lower_step;
    int fceil, ffloor, bceil, bfloor, fs, base_shade;
    bool solid, skyportal;
    const Material *side;
    const uint8_t *light;
    WallStyle middle, upper, lower;
    uint8_t x, top, bottom, cy, fy, up, low;
    uint8_t *top_ptr, *bottom_ptr;
    uint8_t draw_upper, draw_lower;
    uint8_t *fill_base;
    uint8_t ceil_color, floor_color, stride;
    int inverse, z, v, step;
    uint8_t tx, count, y1;
} RenderWall;

#endif /* R_DEFS_H */
