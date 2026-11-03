#include "doom/wall_segment.h"

namespace doom {

void WallSegment::step() {
    inv_depth         += inv_depth_step;
    tex_u_depth       += tex_u_depth_step;
    ceil_screen_y     += ceil_screen_step;
    floor_screen_y    += floor_screen_step;
    upper_screen_y    += upper_screen_step;
    lower_screen_y    += lower_screen_step;
}

} // namespace doom
