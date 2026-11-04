#include "st_stuff.h"
#include "r_state.h"
#include "hud.h"
#ifdef __TICE__
#include <graphx.h>
#else
extern uint8_t *gfx_vbuffer[240];
#endif
#include <string.h>

void blit_trans(const uint8_t *src, int dx, int dy, int w, int h, int stride) {
    for (int row = 0; row < h; ++row) {
        uint8_t *dst = gfx_vbuffer[dy + row] + dx;
        const uint8_t *line = src + row * stride;
        for (int x = 0; x < w; ++x) {
            if (line[x] != 255) dst[x] = line[x];
        }
    }
}

/* Doom ST_* big numbers are right-aligned to the given x. */
void draw_stt(int value, int x, int y, bool percent) {
    char buf[8];
    int n = 0;
    if (value < 0) value = 0;
    if (value > 999) value = 999;
    if (value >= 100) buf[n++] = (char)('0' + value / 100);
    if (value >= 10) buf[n++] = (char)('0' + (value / 10) % 10);
    buf[n++] = (char)('0' + value % 10);
    if (percent) buf[n++] = '%';
    for (int i = n - 1; i >= 0; --i) {
        int digit = buf[i] == '%' ? 10 : buf[i] - '0';
        int w = stt_w[digit];
        x -= w;
        blit_trans(stt_digits[digit], x, y, w, STT_H, STT_W);
    }
}

void draw_sty(int value, int x, int y) {
    char buf[4];
    int n = 0;
    if (value < 0) value = 0;
    if (value > 999) value = 999;
    if (value >= 100) buf[n++] = (char)('0' + value / 100);
    if (value >= 10) buf[n++] = (char)('0' + (value / 10) % 10);
    buf[n++] = (char)('0' + value % 10);
    for (int i = n - 1; i >= 0; --i) {
        int digit = buf[i] - '0';
        int w = sty_w[digit];
        x -= w;
        blit_trans(sty_digits[digit], x, y, w, STY_H, STY_W);
    }
}

unsigned face_index(void) {
    if (player.dead) return 5;
    if (player.damage) return 6;
    int health = player.health;
    if (health > 100) health = 100;
    unsigned pain = (health <= 0) ? 4 : (unsigned)((100 - health) * 5 / 100);
    if (pain > 4) pain = 4;
    return pain;
}

void draw_status(int y) {
    /* STBAR is 320px wide; gfx_sprite_t only stores 8-bit dimensions. */
    for (int row = 0; row < STBAR_H; ++row) {
        memcpy(gfx_vbuffer[y + row], stbar + row * STBAR_W, STBAR_W);
    }

    draw_stt(player.ammo, ST_AMMO_X, y + ST_NUM_Y, false);
    draw_stt(player.health, ST_HEALTH_X, y + ST_NUM_Y, true);
    draw_stt(player.armor, ST_ARMOR_X, y + ST_NUM_Y, true);

    blit_trans(st_faces[face_index()], ST_FACE_X, y + ST_FACE_Y, FACE_W, FACE_H, FACE_W);

    /* Current / max ammo on the right; only bullets are tracked in-sim. */
    draw_sty(player.ammo, ST_AMMO0_X, y + ST_AMMO0_Y);
    draw_sty(200, ST_MAXAMMO0_X, y + ST_AMMO0_Y);
    draw_sty(0, ST_AMMO0_X, y + ST_AMMO1_Y);
    draw_sty(50, ST_MAXAMMO0_X, y + ST_AMMO1_Y);
    draw_sty(0, ST_AMMO0_X, y + ST_AMMO2_Y);
    draw_sty(50, ST_MAXAMMO0_X, y + ST_AMMO2_Y);
    draw_sty(0, ST_AMMO0_X, y + ST_AMMO3_Y);
    draw_sty(300, ST_MAXAMMO0_X, y + ST_AMMO3_Y);
}
