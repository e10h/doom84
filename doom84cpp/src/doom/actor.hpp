#pragma once

#include "types.hpp"
#include "../generated.h"

namespace doom {

inline constexpr int DeathTics     = 14;
inline constexpr int ExplodeTic    = 3;
inline constexpr int ExplodeTotal  = NUM_BARREL_EXP * ExplodeTic;
inline constexpr int PistolTotal   = 19;
inline constexpr int PistolFireAt  = 15;

class Actor {
public:
    int16_t x{0}, y{0};
    uint8_t sector{0};
    uint8_t hp{0};
    uint8_t removed{0};
    uint8_t cooldown{0};
    uint8_t explode{0};
    uint8_t pain{0};
    uint8_t die{0};

    constexpr void reset(int16_t x_, int16_t y_, uint8_t hp_) noexcept {
        x = x_;
        y = y_;
        sector = 0;
        hp = hp_;
        removed = 0;
        cooldown = 0;
        explode = 0;
        pain = 0;
        die = 0;
    }

    [[nodiscard]] constexpr bool is_alive() const noexcept {
        return hp > 0 && !removed && !explode && !die;
    }
};

} // namespace doom
