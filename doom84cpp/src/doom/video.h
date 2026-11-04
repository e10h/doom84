#pragma once

#include <cstdint>

namespace doom {

class Video {
public:
    Video() = default;

    static void blit_viewport(const uint8_t* src, uint8_t* dest);
};

} // namespace doom
