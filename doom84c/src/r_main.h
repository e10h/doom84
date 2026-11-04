#ifndef R_MAIN_H
#define R_MAIN_H

#include <stdint.h>
#include <stdbool.h>

void engine_render(void);
void d84_rotate(int dx, int dy);
void d84_set_camera(int x, int y, unsigned angle);
void vertex(unsigned v, int *r, int *z);
int vertex_projection(unsigned v, int r, int z);
int project(int height, int z);
const uint8_t *lighting(unsigned sector, int z);
uint8_t screen_y(int value);
uint8_t wire_screen_y(int value);

#endif /* R_MAIN_H */
