#pragma once

#include <ctime>

namespace doom {

class Clock {
public:
    Clock();

    float restart();
    float elapsed_time() const;

private:
    clock_t start_time_;
};

} // namespace doom
