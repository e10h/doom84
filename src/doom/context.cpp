#include "doom/context.h"
#include "doom/input.h"
#include "doom/statusbar.h"

#include "doom/engine.h"
#include <cstdio>

#ifdef __TICE__
#include <graphx.h>
#include <tice.h>
#endif

namespace doom {

#ifdef __TICE__
namespace {
constexpr int ViewportY = 8;
constexpr int StatusBarY = 208;
} // namespace
#endif

Context& Context::Instance() {
    static Context instance;
    return instance;
}

Context::Context()
    : is_closed_(false) {
}

Context::~Context() {
#ifdef __TICE__
    gfx_End();
#endif
}

bool Context::init() {
#ifdef __TICE__
    gfx_Begin();
    gfx_SetDrawBuffer();
    gfx_SetTextFGColor(4);
    gfx_SetTextBGColor(0);
    gfx_SetTextTransparentColor(0);
#endif
    return true;
}

void Context::update() {
    Input::Instance().update();
    if (Input::Instance().is_down(Key::Quit)) {
        close();
    }
}

void Context::draw() {
#ifdef __TICE__
    gfx_SwapDraw();
#endif
}

bool Context::should_close() const {
    return is_closed_;
}

void Context::close() {
    is_closed_ = true;
}

void Context::set_palette(const uint8_t* rgb24_palette) {
#ifdef __TICE__
    if (!rgb24_palette) return;
    for (unsigned i = 0; i < 256; ++i) {
        gfx_palette[i] = gfx_RGBTo1555(
            rgb24_palette[i * 3],
            rgb24_palette[i * 3 + 1],
            rgb24_palette[i * 3 + 2]
        );
    }
#else
    (void)rgb24_palette;
#endif
}

void Context::show_alert(const char* message) {
#ifdef __TICE__
    os_ClrHome();
    const char* p = message;
    while (*p) {
        const char* start = p;
        while (*p && *p != '\n') ++p;
        char line[32];
        size_t len = static_cast<size_t>(p - start);
        if (len >= sizeof(line)) len = sizeof(line) - 1;
        for (size_t i = 0; i < len; ++i) line[i] = start[i];
        line[len] = '\0';
        os_PutStrFull(line);
        os_NewLine();
        if (*p == '\n') ++p;
    }
    while (!os_GetCSC());
#else
    (void)message;
#endif
}

uint8_t* Context::viewport_target() {
#ifdef __TICE__
    return gfx_vbuffer[ViewportY];
#else
    return nullptr;
#endif
}

void Context::draw_status_bar(const Player& player) {
#ifdef __TICE__
    unsigned cur_face = StatusBar::face_index(player);
    if (player.health != hud_health_ ||
        player.armor  != hud_armor_  ||
        player.ammo   != hud_ammo_   ||
        cur_face      != hud_face_) {
        hud_health_ = player.health;
        hud_armor_  = player.armor;
        hud_ammo_   = player.ammo;
        hud_face_   = cur_face;
        hud_dirty_  = 2;
    }

    if (hud_dirty_) {
        StatusBar::draw_calc(StatusBarY, player);
        --hud_dirty_;
    }
#else
    (void)player;
#endif
}

void Context::draw_overlay(const Engine& engine) {
#ifdef __TICE__
    char buf[40];
    const char* pmode = engine.player().wireframe ? "WIRE" : (engine.player().texture_planes ? "TEX" : "FLAT");
    const char* smode = (engine.renderer.detail == 1) ? "128" : (engine.renderer.detail == 2 ? "64" : (engine.renderer.detail == 3 ? "43" : "32"));
    std::snprintf(buf, sizeof(buf), "%s %s", pmode, smode);
    gfx_PrintStringXY(buf, 2, 0);

    if (engine.is_paused()) gfx_PrintStringXY("PAUSED", 140, 96);
    if (engine.player().dead) gfx_PrintStringXY("YOU DIED - PRESS ZOOM", 88, 96);
    if (engine.player().exited) gfx_PrintStringXY("LEVEL CLEAR!", 120, 96);
#else
    (void)engine;
#endif
}

} // namespace doom
