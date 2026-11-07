#pragma once

#include "doom/types.h"
#include "doom/map.h"
#include "doom/world.h"
#include "doom/renderer.h"
#include "doom/statusbar.h"
#include "doom/automap.h"
#include "doom/video.h"

namespace doom {

class Engine {
public:
    static Engine& Instance();

    Map       map;
    World     world;
    Renderer  renderer;
    StatusBar status_bar;
    Automap   automap;
    Video     video;

    Engine();

    bool init();
    bool init(const uint8_t* map_blob, unsigned size, const uint8_t* const* banks, const unsigned* sizes);

    void reset();
    void update(float dt);
    void render();
    void tick(uint8_t input);

    Player& player();
    const Player& player() const;

    RenderStats& stats();
    const RenderStats& stats() const;

    uint8_t* framebuffer();
    const uint8_t* framebuffer() const;

    bool is_automap_active() const;
    void toggle_automap();

    bool is_paused() const;
    void toggle_pause();

private:
    float tic_accumulator_ = 0.0f;
    bool  show_automap_ = false;
    bool  paused_ = false;
};

} // namespace doom
