#include "math.h"
#include "../generated.h"

namespace doom::math {

static uint16_t s_reciprocal_table[2049];
static unsigned s_small_reciprocals[17];
static uint16_t s_random_state = 1;

int high_word(int32_t v) {
    return static_cast<int>(v >> 16);
}

int shr8(int v) {
    return v >> 8;
}

Angle::Angle(uint16_t v)
    : value(v & 1023) {
}

Angle Angle::operator+(int delta) const {
    return Angle(static_cast<uint16_t>((value + delta) & 1023));
}

Angle Angle::operator-(int delta) const {
    return Angle(static_cast<uint16_t>((value - delta) & 1023));
}

Angle& Angle::operator+=(int delta) {
    value = (value + delta) & 1023;
    return *this;
}

Angle& Angle::operator-=(int delta) {
    value = (value - delta) & 1023;
    return *this;
}

Angle::operator uint16_t() const {
    return value;
}

int Angle::sin() const {
    return isin(value);
}

int Angle::cos() const {
    return icos(value);
}

void init_tables() {
    for (unsigned i = 1; i <= 2048; ++i) {
        unsigned value = static_cast<unsigned>(1048576L / i);
        s_reciprocal_table[i] = static_cast<uint16_t>(value);
        if (i < 17) s_small_reciprocals[i] = value;
    }
}

unsigned reciprocal(unsigned iz) {
    if (iz < 17) return s_small_reciprocals[iz];
    if (iz <= 2048) return s_reciprocal_table[iz];
    return 1048576u / iz;
}

int screen_x(int r, int z) {
    return 64 + static_cast<int>(static_cast<int32_t>(r) * static_cast<int32_t>(reciprocal(static_cast<unsigned>(z))) / 16384);
}

int isin(unsigned a) {
    return sine_table[a & 1023];
}

int icos(unsigned a) {
    return sine_table[(a + 256) & 1023];
}

unsigned rnd() {
    s_random_state = static_cast<uint16_t>(s_random_state * 25173u + 13849u);
    return s_random_state;
}

} // namespace doom::math
