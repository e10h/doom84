#include "draw.h"

namespace doom::draw {

void wall(uint8_t* dst, uint8_t* depth, const uint8_t* image, const uint8_t* light,
          unsigned count, int v, int step, unsigned z) {
    while (count--) {
        *dst = light[image[((static_cast<unsigned>(v) >> 8) & 31) * 32]];
        *depth = static_cast<uint8_t>(z);
        dst += ViewWidth;
        depth += ViewWidth;
        v += step;
    }
}

void span(uint8_t* dst, uint8_t* depth, const uint8_t* image, const uint8_t* light,
          unsigned count, int wx, int wy, int sx, int sy, unsigned z) {
    while (count--) {
        *dst++ = light[image[(((static_cast<unsigned>(wy) >> 9) & 31) * 32) + ((static_cast<unsigned>(wx) >> 9) & 31)]];
        *depth++ = static_cast<uint8_t>(z);
        wx += sx;
        wy += sy;
    }
}

void span2(uint8_t* dst, uint8_t* depth, const uint8_t* image, const uint8_t* light,
           unsigned count, int wx, int wy, int sx, int sy, unsigned z) {
    while (count--) {
        *dst = light[image[(((static_cast<unsigned>(wy) >> 9) & 31) * 32) + ((static_cast<unsigned>(wx) >> 9) & 31)]];
        *depth = static_cast<uint8_t>(z);
        dst += 2;
        depth += 2;
        wx += sx;
        wy += sy;
    }
}

void span3(uint8_t* dst, uint8_t* depth, const uint8_t* image, const uint8_t* light,
           unsigned count, int wx, int wy, int sx, int sy, unsigned z) {
    while (count--) {
        *dst = light[image[(((static_cast<unsigned>(wy) >> 9) & 31) * 32) + ((static_cast<unsigned>(wx) >> 9) & 31)]];
        *depth = static_cast<uint8_t>(z);
        dst += 3;
        depth += 3;
        wx += sx;
        wy += sy;
    }
}

void span4(uint8_t* dst, uint8_t* depth, const uint8_t* image, const uint8_t* light,
           unsigned count, int wx, int wy, int sx, int sy, unsigned z) {
    while (count--) {
        *dst = light[image[(((static_cast<unsigned>(wy) >> 9) & 31) * 32) + ((static_cast<unsigned>(wx) >> 9) & 31)]];
        *depth = static_cast<uint8_t>(z);
        dst += 4;
        depth += 4;
        wx += sx;
        wy += sy;
    }
}

void quad_columns(uint8_t* dst, unsigned count) {
    while (count--) {
        dst[1] = dst[2] = dst[3] = dst[0];
        dst += 4;
    }
}

void triple_columns(uint8_t* dst, unsigned rows) {
    for (unsigned y = 0; y < rows; ++y) {
        uint8_t* row = dst + y * ViewWidth;
        for (unsigned x = 0; x < ViewWidth; x += 3) {
            uint8_t v = row[x];
            if (x + 1 < ViewWidth) row[x + 1] = v;
            if (x + 2 < ViewWidth) row[x + 2] = v;
        }
    }
}

void double_columns(uint8_t* dst, unsigned count) {
    while (count--) {
        dst[1] = dst[0];
        dst += 2;
    }
}

void fill_column(uint8_t* dst, unsigned count, unsigned color) {
    while (count--) {
        *dst = static_cast<uint8_t>(color);
        dst += ViewWidth;
    }
}

void sprite(uint8_t* dst, uint8_t* depth, const uint8_t* image, const uint8_t* light,
            unsigned count, unsigned u, unsigned step, unsigned z, unsigned stride) {
    while (count--) {
        if (z < *depth) {
            uint8_t pixel = image[u >> 8];
            if (pixel != 255) {
                *dst = light[pixel];
                *depth = static_cast<uint8_t>(z);
            }
        }
        dst += stride;
        depth += stride;
        u += step;
    }
}

void wire_plot(uint8_t* framebuffer, int x, int y, uint8_t color) {
    if (static_cast<unsigned>(x) < ViewWidth && static_cast<unsigned>(y) < ViewHeight) {
        framebuffer[y * ViewWidth + x] = color;
    }
}

} // namespace doom::draw
