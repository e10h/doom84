#include "engine.h"

namespace doom {

Engine::Engine() = default;

bool Engine::init(const uint8_t* map_blob, unsigned size, const uint8_t* const* banks, const unsigned* sizes) {
    if (!map.unpack(map_blob, size, banks, sizes)) {
        return false;
    }
    world.init(map);
    return true;
}

void Engine::reset() {
    world.reset();
}

void Engine::tick(uint8_t input) {
    world.tick(input);
}

void Engine::render() {
    renderer.render(world, map);
}

Player& Engine::player() {
    return world.player;
}

const Player& Engine::player() const {
    return world.player;
}

RenderStats& Engine::stats() {
    return renderer.stats;
}

const RenderStats& Engine::stats() const {
    return renderer.stats;
}

uint8_t* Engine::framebuffer() {
    return renderer.framebuffer();
}

const uint8_t* Engine::framebuffer() const {
    return renderer.framebuffer();
}

} // namespace doom
