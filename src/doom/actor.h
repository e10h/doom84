#pragma once

#include "types.h"
#include <cstdint>

namespace doom {

constexpr int DeathTics    = 14;
constexpr int ExplodeTic   = 3;
constexpr int PistolTotal  = 19;
constexpr int PistolFireAt = 15;

class Actor {
public:
    int16_t x = 0;
    int16_t y = 0;
    uint8_t sector = 0;
    uint8_t hp = 0;
    uint8_t removed = 0;
    uint8_t cooldown = 0;
    uint8_t explode = 0;
    uint8_t pain = 0;
    uint8_t die = 0;

    Actor() = default;

    void reset(int16_t x_, int16_t y_, uint8_t hp_);
    bool is_alive() const;
};

} // namespace doom
