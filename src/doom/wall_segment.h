#pragma once

#include "doom/types.h"
#include <cstdint>

namespace doom {

struct WallSegment {
    int start_x = 0;
    int end_x = 0;

    int inv_depth = 0;
    int inv_depth_step = 0;

    int tex_u_depth = 0;
    int tex_u_depth_step = 0;

    int ceil_screen_y = 0;
    int ceil_screen_step = 0;

    int floor_screen_y = 0;
    int floor_screen_step = 0;

    int upper_screen_y = 0;
    int upper_screen_step = 0;

    int lower_screen_y = 0;
    int lower_screen_step = 0;

    int front_ceiling_z = 0;
    int front_floor_z = 0;
    int back_ceiling_z = 0;
    int back_floor_z = 0;

    int front_sector = 0;
    bool is_solid = false;
    bool is_sky_portal = false;

    const Material* material = nullptr;
    WallStyle middle{};
    WallStyle upper{};
    WallStyle lower{};

    uint8_t draw_upper = 0;
    uint8_t draw_lower = 0;
    uint8_t stride = 1;

    void step();
};

} // namespace doom
