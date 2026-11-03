#pragma once

#include "types.hpp"
#include "map.hpp"
#include "world.hpp"
#include "renderer.hpp"
#include "hud.hpp"
#include "automap.hpp"
#include "video.hpp"

namespace doom {

class Engine {
public:
    MapData  map;
    World    world;
    Renderer renderer;

    bool init(const uint8_t* map_blob, unsigned size, const uint8_t* const* banks, const unsigned* sizes) noexcept {
        if (!map.unpack(map_blob, size, banks, sizes)) {
            return false;
        }
        world.init(map);
        return true;
    }

    void reset() noexcept {
        world.reset();
    }

    void tick(uint8_t input) noexcept {
        world.tick(input);
    }

    void render() noexcept {
        renderer.render(world, map);
    }

    [[nodiscard]] Player& player() noexcept {
        return world.player;
    }

    [[nodiscard]] const Player& player() const noexcept {
        return world.player;
    }

    [[nodiscard]] RenderStats& stats() noexcept {
        return renderer.stats;
    }

    [[nodiscard]] const RenderStats& stats() const noexcept {
        return renderer.stats;
    }

    [[nodiscard]] uint8_t* framebuffer() noexcept {
        return renderer.framebuffer();
    }

    [[nodiscard]] const uint8_t* framebuffer() const noexcept {
        return renderer.framebuffer();
    }
};

} // namespace doom
