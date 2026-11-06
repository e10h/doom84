#pragma once

#include "types.h"
#include <cstdint>

namespace doom {

class Player {
public:
    int32_t x = 0;
    int32_t y = 0;
    int16_t eye = 0;
    int16_t floor = 0;
    int16_t health = 100;
    int16_t armor = 0;
    int16_t ammo = 50;
    uint16_t angle = 0;
    uint16_t kills = 0;
    uint16_t total = 0;
    uint16_t ticks = 0;
    uint8_t  sector = 0;
    uint8_t  fire = 0;
    uint8_t  damage = 0;
    bool     exited = false;
    bool     dead = false;
    bool     texture_planes = true;
    bool     wireframe = false;

    Player() = default;

    void reset(int start_x, int start_y, uint16_t start_angle, uint8_t start_sector, int16_t start_floor);
    int world_x() const;
    int world_y() const;
    void hurt(int dmg);
};

} // namespace doom
