#pragma once

#include "types.h"
#include "player.h"
#include "actor.h"
#include "map.h"
#include <cstdint>

namespace doom {

class World {
public:
    Player   player;
    Actor    actors[NUM_ACTORS]{};
    int16_t  sector_ceiling[NUM_SECTORS]{};
    int16_t  sector_target[NUM_SECTORS]{};
    int16_t  sector_floor[NUM_SECTORS]{};
    int16_t  floor_target[NUM_SECTORS]{};
    uint8_t  floor_wait[NUM_SECTORS]{};
    uint8_t  use_held = 0;

    const Map* map = nullptr;

    World() = default;

    void init(const Map& map_data);
    void reset();

    uint8_t find_sector(int x, int y) const;
    bool line_passable(const Line* l, int floor_val) const;
    bool collision_line(unsigned i, int x, int y, int floor_val) const;
    bool can_move(int x, int y, int floor_val) const;
    bool line_of_sight(int x, int y, int tx, int ty, int eye) const;

    void activate_sector(unsigned s);
    void use();
    void damage_actor(unsigned index, int damage);
    void explode_barrel(unsigned index);
    void fire_shot();
    void shoot();
    void cross_triggers(int oldx, int oldy, int x, int y);
    void tick(uint8_t input);
};

} // namespace doom
