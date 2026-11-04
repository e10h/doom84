#include "doom/engine.h"
#include "doom/assets.h"
#include "doom/context.h"
#include "doom/input.h"

namespace doom {

Engine& Engine::Instance() {
    static Engine instance;
    return instance;
}

Engine::Engine()
    : tic_accumulator_(0.0f)
    , show_automap_(false)
    , paused_(false) {
}

bool Engine::init() {
    AssetManager& assets = AssetManager::Instance();
    if (!assets.load_all()) {
        return false;
    }

    if (!init(assets.map_data(), assets.map_size(), assets.banks(), assets.bank_lengths())) {
        return false;
    }

    Context::Instance().set_palette(map.palette);
    renderer.detail = 2;
    world.player.texture_planes = false;
    reset();
    return true;
}

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

void Engine::update(float dt) {
    Input& input = Input::Instance();

    if (input.was_pressed(Key::Automap)) {
        show_automap_ = !show_automap_;
    }

    if (input.was_pressed(Key::ToggleFlats)) {
        if (world.player.wireframe) {
            world.player.wireframe = false;
            world.player.texture_planes = false;
        } else if (!world.player.texture_planes) {
            world.player.texture_planes = true;
        } else {
            world.player.wireframe = true;
        }
    }

    if (input.was_pressed(Key::ToggleDetail)) {
        if (renderer.detail == 2) renderer.detail = 3;
        else if (renderer.detail == 3) renderer.detail = 4;
        else if (renderer.detail == 4) renderer.detail = 1;
        else renderer.detail = 2;
    }

    if (input.was_pressed(Key::Pause)) {
        paused_ = !paused_;
    }

    if (input.was_pressed(Key::Reset)) {
        reset();
    }

    constexpr float TicDuration = 1.0f / 35.0f;
    tic_accumulator_ += dt;
    while (tic_accumulator_ >= TicDuration) {
        tic_accumulator_ -= TicDuration;
        if (!paused_) {
            tick(input.movement_bits());
        }
    }
}

void Engine::tick(uint8_t input) {
    world.tick(input);
}

void Engine::render() {
    Context& context = Context::Instance();

    if (show_automap_) {
        automap.draw(world.player, map);
    } else {
        renderer.render(world, map);
        uint8_t* target = context.viewport_target();
        if (target) {
            video.blit_viewport(framebuffer(), target);
        }
    }

    context.draw_status_bar(world.player);
    context.draw_overlay(*this);
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

bool Engine::is_automap_active() const {
    return show_automap_;
}

void Engine::toggle_automap() {
    show_automap_ = !show_automap_;
}

bool Engine::is_paused() const {
    return paused_;
}

void Engine::toggle_pause() {
    paused_ = !paused_;
}

} // namespace doom
