#pragma once

#include "player.hpp"
#include "../hud.h"
#include <cstdint>
#include <cstring>

namespace doom::hud {

template <typename VBuf>
inline void blit_trans(VBuf&& vbuffer, const uint8_t* src, int dx, int dy, int w, int h, int stride) noexcept {
    for (int row = 0; row < h; ++row) {
        uint8_t* dst = vbuffer[dy + row] + dx;
        const uint8_t* line = src + row * stride;
        for (int x = 0; x < w; ++x) {
            if (line[x] != 255) dst[x] = line[x];
        }
    }
}

template <typename VBuf>
inline void draw_stt(VBuf&& vbuffer, int value, int x, int y, bool percent) noexcept {
    char buf[8];
    int n = 0;
    if (value < 0) value = 0;
    if (value > 999) value = 999;
    if (value >= 100) buf[n++] = static_cast<char>('0' + value / 100);
    if (value >= 10)  buf[n++] = static_cast<char>('0' + (value / 10) % 10);
    buf[n++] = static_cast<char>('0' + value % 10);
    if (percent) buf[n++] = '%';

    for (int i = n - 1; i >= 0; --i) {
        int digit = (buf[i] == '%') ? 10 : (buf[i] - '0');
        int w = stt_w[digit];
        x -= w;
        blit_trans(vbuffer, stt_digits[digit], x, y, w, STT_H, STT_W);
    }
}

template <typename VBuf>
inline void draw_sty(VBuf&& vbuffer, int value, int x, int y) noexcept {
    char buf[4];
    int n = 0;
    if (value < 0) value = 0;
    if (value > 999) value = 999;
    if (value >= 100) buf[n++] = static_cast<char>('0' + value / 100);
    if (value >= 10)  buf[n++] = static_cast<char>('0' + (value / 10) % 10);
    buf[n++] = static_cast<char>('0' + value % 10);

    for (int i = n - 1; i >= 0; --i) {
        int digit = buf[i] - '0';
        int w = sty_w[digit];
        x -= w;
        blit_trans(vbuffer, sty_digits[digit], x, y, w, STY_H, STY_W);
    }
}

inline unsigned face_index(const Player& player) noexcept {
    if (player.dead) return 5;
    if (player.damage) return 6;
    int health = player.health;
    if (health > 100) health = 100;
    unsigned pain = (health <= 0) ? 4 : static_cast<unsigned>((100 - health) * 5 / 100);
    if (pain > 4) pain = 4;
    return pain;
}

template <typename VBuf>
inline void draw_status(VBuf&& vbuffer, int y, const Player& player) noexcept {
    for (int row = 0; row < STBAR_H; ++row) {
        std::memcpy(vbuffer[y + row], stbar + row * STBAR_W, STBAR_W);
    }

    draw_stt(vbuffer, player.ammo, ST_AMMO_X, y + ST_NUM_Y, false);
    draw_stt(vbuffer, player.health, ST_HEALTH_X, y + ST_NUM_Y, true);
    draw_stt(vbuffer, player.armor, ST_ARMOR_X, y + ST_NUM_Y, true);

    blit_trans(vbuffer, st_faces[face_index(player)], ST_FACE_X, y + ST_FACE_Y, FACE_W, FACE_H, FACE_W);

    draw_sty(vbuffer, player.ammo, ST_AMMO0_X, y + ST_AMMO0_Y);
    draw_sty(vbuffer, 200, ST_MAXAMMO0_X, y + ST_AMMO0_Y);
    draw_sty(vbuffer, 0, ST_AMMO0_X, y + ST_AMMO1_Y);
    draw_sty(vbuffer, 50, ST_MAXAMMO0_X, y + ST_AMMO1_Y);
    draw_sty(vbuffer, 0, ST_AMMO0_X, y + ST_AMMO2_Y);
    draw_sty(vbuffer, 50, ST_MAXAMMO0_X, y + ST_AMMO2_Y);
    draw_sty(vbuffer, 0, ST_AMMO0_X, y + ST_AMMO3_Y);
    draw_sty(vbuffer, 300, ST_MAXAMMO0_X, y + ST_AMMO3_Y);
}

} // namespace doom::hud
