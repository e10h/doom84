#ifndef M_FIXED_H
#define M_FIXED_H

#include <stdint.h>

#define ABS(a) ((a)<0?-(a):(a))
#define MIN(a,b) ((a)<(b)?(a):(b))
#define MAX(a,b) ((a)>(b)?(a):(b))
#define CLAMP(a,l,h) MIN(MAX(a,l),h)

extern uint16_t reciprocal_table[2049];
extern unsigned small_reciprocals[17];
extern uint16_t random_state;

void M_InitMath(void);

static inline unsigned reciprocal(unsigned value) {
    unsigned shift=0;
    while (value>2048) {value>>=1;++shift;}
    return (value<17?small_reciprocals[value?value:1]:reciprocal_table[value])>>shift;
}

static inline int high_word(int32_t value) {
    return (int)(value >> 16);
}

static inline int16_t shr8(int value) {
    return (int16_t)(value >> 8);
}

static inline int screen_x(int r,int z) {
    int32_t prod = (int32_t)r * (int32_t)reciprocal((unsigned)z);
    return 64 + (int)(prod >> 14);
}

int d84_screen_x(int r,int z);
int isin(unsigned a);
int icos(unsigned a);
unsigned rnd(void);

#endif /* M_FIXED_H */
