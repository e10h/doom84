#include "m_fixed.h"
#include "doomdef.h"
#include "generated.h"
#include "geometry.h"

uint16_t reciprocal_table[2049];
unsigned small_reciprocals[17];
uint16_t random_state = 1;

void M_InitMath(void) {
    for (unsigned i=1; i<=2048; ++i) {
        unsigned value = (unsigned)(1048576L / i);
        reciprocal_table[i] = (uint16_t)value;
        if (i < 17) small_reciprocals[i] = value;
    }
}

int isin(unsigned a) {
    return sine_table[a & 1023];
}

int icos(unsigned a) {
    return sine_table[(a + 256) & 1023];
}

unsigned rnd(void) {
    random_state = (uint16_t)(random_state * 25173u + 13849u);
    return random_state;
}

int d84_screen_x(int r, int z) {
    return screen_x(r, z);
}
