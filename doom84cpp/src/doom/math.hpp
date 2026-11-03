#pragma once

#include "types.hpp"
#include "../generated.h"
#include <algorithm>
#include <type_traits>

namespace doom::math {

template <typename T>
constexpr T clamp(T val, T low, T high) noexcept {
    return (val < low) ? low : (val > high) ? high : val;
}

template <typename T>
constexpr T min(T a, T b) noexcept {
    return (a < b) ? a : b;
}

template <typename T>
constexpr T max(T a, T b) noexcept {
    return (a > b) ? a : b;
}

template <typename T>
constexpr T abs(T v) noexcept {
    return (v < 0) ? -v : v;
}

constexpr int high_word(int32_t v) noexcept {
    return static_cast<int>(v >> 16);
}

constexpr int shr8(int v) noexcept {
    return v >> 8;
}

class Angle {
public:
    uint16_t value{0};

    constexpr Angle() noexcept = default;
    constexpr explicit Angle(uint16_t v) noexcept : value(v & 1023) {}

    constexpr Angle operator+(int delta) const noexcept {
        return Angle(static_cast<uint16_t>((value + delta) & 1023));
    }
    constexpr Angle operator-(int delta) const noexcept {
        return Angle(static_cast<uint16_t>((value - delta) & 1023));
    }
    constexpr Angle& operator+=(int delta) noexcept {
        value = (value + delta) & 1023;
        return *this;
    }
    constexpr Angle& operator-=(int delta) noexcept {
        value = (value - delta) & 1023;
        return *this;
    }
    constexpr operator uint16_t() const noexcept { return value; }

    [[nodiscard]] int sin() const noexcept {
        return sine_table[value & 1023];
    }
    [[nodiscard]] int cos() const noexcept {
        return sine_table[(value + 256) & 1023];
    }
};

inline uint16_t reciprocal_table[2049];
inline unsigned small_reciprocals[17];
inline uint16_t random_state = 1;

inline void init_tables() noexcept {
    for (unsigned i = 1; i <= 2048; ++i) {
        unsigned value = static_cast<unsigned>(1048576L / i);
        reciprocal_table[i] = static_cast<uint16_t>(value);
        if (i < 17) small_reciprocals[i] = value;
    }
}

inline unsigned reciprocal(unsigned iz) noexcept {
    if (iz < 17) return small_reciprocals[iz];
    if (iz <= 2048) return reciprocal_table[iz];
    return 1048576u / iz;
}

inline int screen_x(int r, int z) noexcept {
    return 64 + static_cast<int>(static_cast<int32_t>(r) * static_cast<int32_t>(reciprocal(static_cast<unsigned>(z))) / 16384);
}

inline int isin(unsigned a) noexcept {
    return sine_table[a & 1023];
}

inline int icos(unsigned a) noexcept {
    return sine_table[(a + 256) & 1023];
}

inline unsigned rnd() noexcept {
    random_state = static_cast<uint16_t>(random_state * 25173u + 13849u);
    return random_state;
}

} // namespace doom::math
