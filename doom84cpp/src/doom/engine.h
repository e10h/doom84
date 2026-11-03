#pragma once

#include "types.h"
#include "map.h"
#include "world.h"
#include "renderer.h"
#include "statusbar.h"
#include "automap.h"
#include "video.h"

namespace doom {

class Engine {
public:
    Map       map;
    World     world;
    Renderer  renderer;
    StatusBar status_bar;
    Automap   automap;
    Video     video;

    Engine();

    bool init(const uint8_t* map_blob, unsigned size, const uint8_t* const* banks, const unsigned* sizes);
    void reset();
    void tick(uint8_t input);
    void render();

    Player& player();
    const Player& player() const;

    RenderStats& stats();
    const RenderStats& stats() const;

    uint8_t* framebuffer();
    const uint8_t* framebuffer() const;
};

} // namespace doom
