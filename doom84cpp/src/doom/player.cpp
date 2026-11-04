#include "player.h"
#include "math.h"

namespace doom {

void Player::reset(int start_x, int start_y, uint16_t start_angle, uint8_t start_sector, int16_t start_floor) {
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

int Player::world_x() const {
    return static_cast<int>(x / 256);
}

int Player::world_y() const {
    return static_cast<int>(y / 256);
}

void Player::hurt(int dmg) {
    int absorbed = math::min(static_cast<int>(armor), dmg / 3);
    armor -= static_cast<int16_t>(absorbed);
    health -= static_cast<int16_t>(dmg - absorbed);
    damage = 5;
    if (health <= 0) {
        health = 0;
        dead = true;
    }
}

} // namespace doom
