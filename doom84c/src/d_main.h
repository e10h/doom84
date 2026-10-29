#ifndef D_MAIN_H
#define D_MAIN_H

#include <stdbool.h>
#include <stdint.h>

bool engine_init(const uint8_t *map, unsigned size, const uint8_t *const *banks, const unsigned *sizes);
void engine_reset(void);

#endif /* D_MAIN_H */
