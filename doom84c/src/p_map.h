#ifndef P_MAP_H
#define P_MAP_H

#include "doomdef.h"
#include <stdbool.h>
#include <stdint.h>

uint8_t engine_sector(int x, int y);
bool engine_can_move(int x, int y, int floor);
bool line_passable(const Line *l, int floor);
bool collision_line(unsigned i, int x, int y, int floor);
bool sight(int x, int y, int tx, int ty, int eye);

#endif /* P_MAP_H */
