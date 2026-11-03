#pragma once

#include <cstdint>
#include <cstring>

namespace doom::video {

inline void blit_viewport(const uint8_t* src, uint8_t* dest) noexcept {
    for (int y = 0; y < 80; ++y) {
        uint8_t* dst_row = dest;
        for (int x = 0; x < 128; x += 2) {
            uint8_t p0 = src[x];
            uint8_t p1 = src[x + 1];
            dst_row[0] = p0;
            dst_row[1] = p0;
            dst_row[2] = p1;
            dst_row[3] = p1;
            dst_row[4] = p1;
            dst_row += 5;
        }
        src += 128;
        dest += 320;
        std::memcpy(dest, dest - 320, 320);
        dest += 320;
        if (y & 1) {
            std::memcpy(dest, dest - 320, 320);
            dest += 320;
        }
    }
}

} // namespace doom::video
