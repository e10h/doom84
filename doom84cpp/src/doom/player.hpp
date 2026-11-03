#pragma once

#include "types.hpp"
#include "math.hpp"
#include "../generated.h"

namespace doom {

class Player {
public:
    int32_t x{0}, y{0}; // 24.8 fixed point world coordinates
    int16_t eye{0};
    int16_t floor{0};
    int16_t health{100};
    int16_t armor{0};
    int16_t ammo{50};
    uint16_t angle{0};
    uint16_t kills{0};
    uint16_t total{0};
    uint16_t ticks{0};
    uint8_t  sector{0};
    uint8_t  fire{0};
    uint8_t  damage{0};
    bool     exited{false};
    bool     dead{false};
    bool     texture_planes{true};
    bool     wireframe{false};

    void reset(int start_x, int start_y, uint16_t start_angle, uint8_t start_sector, int16_t start_floor) noexcept {
        x = static_cast<int32_t>(start_x) * 256;
        y = static_cast<int32_t>(start_y) * 256;
        angle = start_angle;
        health = 100;
        armor = 0;
        ammo = 50;
        kills = 0;
        ticks = 0;
        fire = 0;
        damage = 0;
        exited = false;
        dead = false;
        texture_planes = true;
        wireframe = false;
        sector = start_sector;
        floor = start_floor;
        eye = floor + 41;
    }

    [[nodiscard]] constexpr int world_x() const noexcept {
        return static_cast<int>(x / 256);
    }

    [[nodiscard]] constexpr int world_y() const noexcept {
        return static_cast<int>(y / 256);
    }

    void hurt(int dmg) noexcept {
        int absorbed = math::min(static_cast<int>(armor), dmg / 3);
        armor -= static_cast<int16_t>(absorbed);
        health -= static_cast<int16_t>(dmg - absorbed);
        damage = 5;
        if (health <= 0) {
            health = 0;
            dead = true;
        }
    }
};

} // namespace doom
