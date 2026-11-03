#pragma once

#include "types.h"
#include <cstdint>

namespace doom::math {

template <typename T>
constexpr T clamp(T val, T low, T high) {
    return (val < low) ? low : (val > high) ? high : val;
}

template <typename T>
constexpr T min(T a, T b) {
    return (a < b) ? a : b;
}

template <typename T>
constexpr T max(T a, T b) {
    return (a > b) ? a : b;
}

template <typename T>
constexpr T abs(T v) {
    return (v < 0) ? -v : v;
}

int high_word(int32_t v);
int shr8(int v);

class Angle {
public:
    uint16_t value = 0;

    Angle() = default;
    explicit Angle(uint16_t v);

    Angle operator+(int delta) const;
    Angle operator-(int delta) const;
    Angle& operator+=(int delta);
    Angle& operator-=(int delta);
    operator uint16_t() const;

    int sin() const;
    int cos() const;
};

void init_tables();
unsigned reciprocal(unsigned iz);
int screen_x(int r, int z);
int isin(unsigned a);
int icos(unsigned a);
unsigned rnd();

} // namespace doom::math
