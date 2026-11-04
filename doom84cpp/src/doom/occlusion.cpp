#include "doom/occlusion.h"
#include "doom/math.h"
#include <cstring>

namespace doom {

OcclusionBuffer::OcclusionBuffer() {
    clear();
}

void OcclusionBuffer::clear() {
    std::memset(top_, 0, sizeof(top_));
    std::memset(bottom_, ViewHeight, sizeof(bottom_));
}

bool OcclusionBuffer::is_column_blocked(int x) const {
    return top_[x] >= bottom_[x];
}

bool OcclusionBuffer::is_range_visible(int start_x, int end_x) const {
    for (int x = start_x; x <= end_x; ++x) {
        if (top_[x] < bottom_[x]) {
            return true;
        }
    }
    return false;
}

uint8_t OcclusionBuffer::top(int x) const {
    return top_[x];
}

uint8_t OcclusionBuffer::bottom(int x) const {
    return bottom_[x];
}

void OcclusionBuffer::set_top(int x, uint8_t value) {
    top_[x] = value;
}

void OcclusionBuffer::set_bottom(int x, uint8_t value) {
    bottom_[x] = value;
}

void OcclusionBuffer::mark_solid(int x) {
    top_[x] = static_cast<uint8_t>(ViewHeight);
    bottom_[x] = 0;
}

void OcclusionBuffer::clip_portal_upper(int x, uint8_t upper_y) {
    top_[x] = static_cast<uint8_t>(math::max(static_cast<int>(top_[x]), static_cast<int>(upper_y)));
}

void OcclusionBuffer::clip_portal_lower(int x, uint8_t lower_y) {
    bottom_[x] = static_cast<uint8_t>(math::min(static_cast<int>(bottom_[x]), static_cast<int>(lower_y)));
}

const uint8_t* OcclusionBuffer::top_data() const {
    return top_;
}

const uint8_t* OcclusionBuffer::bottom_data() const {
    return bottom_;
}

} // namespace doom
