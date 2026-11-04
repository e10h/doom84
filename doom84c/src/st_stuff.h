#ifndef ST_STUFF_H
#define ST_STUFF_H

#include <stdbool.h>
#include <stdint.h>

void ST_Init(void);
void draw_status(int y);
unsigned face_index(void);
void draw_stt(int value, int x, int y, bool percent);
void draw_sty(int value, int x, int y);
void blit_trans(const uint8_t *src, int dx, int dy, int w, int h, int stride);

#endif /* ST_STUFF_H */
