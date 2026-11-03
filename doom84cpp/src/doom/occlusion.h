#pragma once

#include "doom/types.h"
#include <cstdint>

namespace doom {

class OcclusionBuffer {
public:
    OcclusionBuffer();

    void clear();

    bool is_column_blocked(int x) const;
    bool is_range_visible(int start_x, int end_x) const;

    uint8_t top(int x) const;
    uint8_t bottom(int x) const;

    void set_top(int x, uint8_t value);
    void set_bottom(int x, uint8_t value);

    void mark_solid(int x);
    void clip_portal_upper(int x, uint8_t upper_y);
    void clip_portal_lower(int x, uint8_t lower_y);

    const uint8_t* top_data() const;
    const uint8_t* bottom_data() const;

private:
    uint8_t top_[ViewWidth];
    uint8_t bottom_[ViewWidth];
};

} // namespace doom
