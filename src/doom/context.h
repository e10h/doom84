#pragma once

#include "doom/player.h"
#include <cstdint>

namespace doom {

class Engine;

class Context {
public:
    static Context& Instance();

    bool init();
    void update();
    void draw();

    bool should_close() const;
    void close();

    void set_palette(const uint8_t* rgb24_palette);
    void show_alert(const char* message);

    uint8_t* viewport_target();
    void draw_status_bar(const Player& player);
    void draw_overlay(const Engine& engine);

private:
    Context();
    ~Context();

    bool is_closed_ = false;

#ifdef __TICE__
    int hud_health_ = -1;
    int hud_armor_  = -1;
    int hud_ammo_   = -1;
    unsigned hud_face_ = 999;
    unsigned hud_dirty_ = 0;
#endif
};

} // namespace doom
