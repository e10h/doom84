#include "doom/clock.h"

namespace doom {

Clock::Clock()
    : start_time_(clock()) {
}

float Clock::restart() {
    clock_t now = clock();
    float dt = static_cast<float>(now - start_time_) / static_cast<float>(CLOCKS_PER_SEC);
    start_time_ = now;
    return dt;
}

float Clock::elapsed_time() const {
    clock_t now = clock();
    return static_cast<float>(now - start_time_) / static_cast<float>(CLOCKS_PER_SEC);
}

} // namespace doom
