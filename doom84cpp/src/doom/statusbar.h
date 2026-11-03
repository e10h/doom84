#pragma once

#include "player.h"
#include <cstdint>

namespace doom {

class StatusBar {
public:
    StatusBar() = default;

    static unsigned face_index(const Player& player);
    static void draw(uint8_t* const vbuffer_rows[], int y, const Player& player);

#ifdef __TICE__
    static void draw_calc(int y, const Player& player);
#endif

private:
    static void blit_trans(uint8_t* dst, const uint8_t* src, int w, int h, int stride);
    static void draw_stt(uint8_t* const vbuffer_rows[], int value, int x, int y, bool percent);
    static void draw_sty(uint8_t* const vbuffer_rows[], int value, int x, int y);
};

} // namespace doom
