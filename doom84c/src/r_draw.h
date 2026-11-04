#ifndef R_DRAW_H
#define R_DRAW_H

#include <stdint.h>

void d84_wall(uint8_t *dst, uint8_t *depth, const uint8_t *image, const uint8_t *light, unsigned count, int v, int step, unsigned z);
void d84_span(uint8_t *dst, uint8_t *depth, const uint8_t *image, const uint8_t *light, unsigned count, int wx, int wy, int sx, int sy, unsigned z);
void d84_span2(uint8_t *dst, uint8_t *depth, const uint8_t *image, const uint8_t *light, unsigned count, int wx, int wy, int sx, int sy, unsigned z);
void d84_span3(uint8_t *dst, uint8_t *depth, const uint8_t *image, const uint8_t *light, unsigned count, int wx, int wy, int sx, int sy, unsigned z);
void d84_span4(uint8_t *dst, uint8_t *depth, const uint8_t *image, const uint8_t *light, unsigned count, int wx, int wy, int sx, int sy, unsigned z);

void d84_quad_columns(uint8_t *dst, unsigned count);
void d84_triple_columns(uint8_t *dst, unsigned rows);
void d84_double_columns(uint8_t *dst, unsigned count);
void d84_fill_column(uint8_t *dst, unsigned count, unsigned color);

void d84_sprite(uint8_t *dst, uint8_t *depth, const uint8_t *image, const uint8_t *light, unsigned count, unsigned u, unsigned step, unsigned z, unsigned stride);

void wire_plot(int x, int y, uint8_t color);

#endif /* R_DRAW_H */
