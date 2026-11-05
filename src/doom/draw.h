#pragma once

#include "types.h"
#include <cstdint>

namespace doom::draw {

void wall(uint8_t* dst, uint8_t* depth, const uint8_t* image, const uint8_t* light,
          unsigned count, int v, int step, unsigned z);

void span(uint8_t* dst, uint8_t* depth, const uint8_t* image, const uint8_t* light,
          unsigned count, int wx, int wy, int sx, int sy, unsigned z);

void span2(uint8_t* dst, uint8_t* depth, const uint8_t* image, const uint8_t* light,
           unsigned count, int wx, int wy, int sx, int sy, unsigned z);

void span3(uint8_t* dst, uint8_t* depth, const uint8_t* image, const uint8_t* light,
           unsigned count, int wx, int wy, int sx, int sy, unsigned z);

void span4(uint8_t* dst, uint8_t* depth, const uint8_t* image, const uint8_t* light,
           unsigned count, int wx, int wy, int sx, int sy, unsigned z);

void quad_columns(uint8_t* dst, unsigned count);
void triple_columns(uint8_t* dst, unsigned rows);
void double_columns(uint8_t* dst, unsigned count);
void fill_column(uint8_t* dst, unsigned count, unsigned color);

void sprite(uint8_t* dst, uint8_t* depth, const uint8_t* image, const uint8_t* light,
            unsigned count, unsigned u, unsigned step, unsigned z, unsigned stride);

void wire_plot(uint8_t* framebuffer, int x, int y, uint8_t color);

} // namespace doom::draw
