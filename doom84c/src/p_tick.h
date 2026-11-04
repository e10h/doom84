#ifndef P_TICK_H
#define P_TICK_H

#include <stdint.h>

void engine_tick(uint8_t input);
void cross_triggers(int oldx, int oldy, int x, int y);

#endif /* P_TICK_H */
