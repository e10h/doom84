#include "types.h"

namespace doom {

void RenderStats::reset() {
    segs = 0;
    subsectors = 0;
    wall_columns = 0;
    plane_spans = 0;
    bsp_depth = 0;
}

} // namespace doom
