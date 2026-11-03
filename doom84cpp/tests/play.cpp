#include "../src/doom/engine.h"

#include <SDL.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>

namespace {

inline constexpr int Scale = 4;
inline constexpr int WinW = doom::ViewWidth * Scale;
inline constexpr int WinH = doom::ViewHeight * Scale;

doom::Engine g_engine;

uint8_t* read_file(const char* path, unsigned* size) {
    std::FILE* f = std::fopen(path, "rb");
    if (!f) {
        std::perror(path);
        std::exit(1);
    }
    std::fseek(f, 0, SEEK_END);
    long length = std::ftell(f);
    std::rewind(f);
    uint8_t* p = static_cast<uint8_t*>(std::malloc(static_cast<size_t>(length)));
    if (!p || std::fread(p, 1, static_cast<size_t>(length), f) != static_cast<size_t>(length)) {
        std::exit(1);
    }
    std::fclose(f);
    *size = static_cast<unsigned>(length);
    return p;
}

uint8_t poll_input(const Uint8* keys) {
    uint8_t result = 0;
    if (keys[SDL_SCANCODE_UP] || keys[SDL_SCANCODE_W])       result |= doom::Input::Forward;
    if (keys[SDL_SCANCODE_DOWN] || keys[SDL_SCANCODE_S])     result |= doom::Input::Back;
    if (keys[SDL_SCANCODE_LEFT] || keys[SDL_SCANCODE_A])     result |= doom::Input::Left;
    if (keys[SDL_SCANCODE_RIGHT] || keys[SDL_SCANCODE_D])    result |= doom::Input::Right;
    if (keys[SDL_SCANCODE_LCTRL] || keys[SDL_SCANCODE_RCTRL] || keys[SDL_SCANCODE_Z]) result |= doom::Input::Fire;
    if (keys[SDL_SCANCODE_SPACE] || keys[SDL_SCANCODE_E])    result |= doom::Input::Use;
    if (keys[SDL_SCANCODE_LSHIFT] || keys[SDL_SCANCODE_RSHIFT]) result |= doom::Input::Run;
    if (keys[SDL_SCANCODE_LALT] || keys[SDL_SCANCODE_RALT])  result |= doom::Input::Strafe;
    return result;
}

} // namespace

int main(int argc, char** argv) {
    (void)argc; (void)argv;
    unsigned length, sizes[NUM_BANKS];
    uint8_t* map = read_file("build/D84MAP.bin", &length);
    const uint8_t* banks[NUM_BANKS];

    for (unsigned i = 0; i < NUM_BANKS; ++i) {
        char name[64];
        std::snprintf(name, sizeof(name), "build/D84T%u.bin", i);
        banks[i] = read_file(name, &sizes[i]);
    }

    if (!g_engine.init(map, length, banks, sizes)) {
        std::fprintf(stderr, "g_engine.init failed (rebuild assets?)\n");
        return 1;
    }
    g_engine.renderer.detail = 2;
    g_engine.player().texture_planes = false;

    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_TIMER) != 0) {
        std::fprintf(stderr, "SDL_Init: %s\n", SDL_GetError());
        return 1;
    }

    SDL_Window* win = SDL_CreateWindow("Doom84CPP E1M1 (Modern C++)",
                                       SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
                                       WinW, WinH, 0);
    SDL_Renderer* ren = SDL_CreateRenderer(win, -1, SDL_RENDERER_ACCELERATED);
    SDL_Texture* tex = SDL_CreateTexture(ren, SDL_PIXELFORMAT_RGB24,
                                         SDL_TEXTUREACCESS_STREAMING,
                                         doom::ViewWidth, doom::ViewHeight);

    if (!win || !ren || !tex) {
        std::fprintf(stderr, "SDL window setup failed: %s\n", SDL_GetError());
        return 1;
    }

    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "0");
    SDL_RenderSetLogicalSize(ren, doom::ViewWidth, doom::ViewHeight);

    std::printf("Arrows/WASD move  Ctrl/Z fire  Space/E use  Shift run  Alt strafe\n");
    std::printf("T cycle FAST/TEX/WIRE  R detail  Tab pause  Esc quit\n");
    std::fflush(stdout);

    bool running = true, paused = false;
    Uint32 last = SDL_GetTicks(), acc = 0;

    while (running) {
        SDL_Event ev;
        while (SDL_PollEvent(&ev)) {
            if (ev.type == SDL_QUIT) running = false;
            if (ev.type == SDL_KEYDOWN) {
                SDL_Keycode k = ev.key.keysym.sym;
                if (k == SDLK_ESCAPE) running = false;
                if (k == SDLK_TAB) paused = !paused;
                if (k == SDLK_t) {
                    if (g_engine.player().wireframe) {
                        g_engine.player().wireframe = false;
                        g_engine.player().texture_planes = false;
                    } else if (!g_engine.player().texture_planes) {
                        g_engine.player().texture_planes = true;
                    } else {
                        g_engine.player().texture_planes = false;
                        g_engine.player().wireframe = true;
                    }
                }
                if (k == SDLK_r) {
                    g_engine.renderer.detail = (g_engine.renderer.detail == 2) ? 4 : (g_engine.renderer.detail == 4) ? 1 : 2;
                }
                if (k == SDLK_F5) {
                    bool tex_mode = g_engine.player().texture_planes;
                    bool wire = g_engine.player().wireframe;
                    unsigned d = g_engine.renderer.detail;
                    g_engine.reset();
                    g_engine.player().texture_planes = tex_mode;
                    g_engine.player().wireframe = wire;
                    g_engine.renderer.detail = d;
                }
            }
        }

        Uint32 now = SDL_GetTicks(), elapsed = now - last;
        last = now;
        acc += elapsed;
        if (acc > 6 * (1000 / 35)) acc = 6 * (1000 / 35);

        const Uint8* keys = SDL_GetKeyboardState(nullptr);
        uint8_t input = poll_input(keys);

        while (acc >= 1000 / 35) {
            if (!paused) g_engine.tick(input);
            acc -= 1000 / 35;
        }

        g_engine.render();

        void* pixels;
        int pitch;
        SDL_Rect rect{0, 0, doom::ViewWidth, doom::ViewHeight};
        SDL_LockTexture(tex, &rect, &pixels, &pitch);
        uint8_t* dst = static_cast<uint8_t*>(pixels);

        for (int y = 0; y < doom::ViewHeight; ++y) {
            uint8_t* row = dst + y * pitch;
            for (int x = 0; x < doom::ViewWidth; ++x) {
                const uint8_t* c = g_engine.map.palette + g_engine.framebuffer()[y * doom::ViewWidth + x] * 3;
                row[x * 3 + 0] = c[0];
                row[x * 3 + 1] = c[1];
                row[x * 3 + 2] = c[2];
            }
        }
        SDL_UnlockTexture(tex);

        SDL_SetRenderDrawColor(ren, 0, 0, 0, 255);
        SDL_RenderClear(ren);
        SDL_RenderCopy(ren, tex, nullptr, nullptr);
        SDL_RenderPresent(ren);

        char title[96];
        std::snprintf(title, sizeof(title), "Doom84CPP %s d%u%s",
                      g_engine.player().wireframe ? "WIRE" : (g_engine.player().texture_planes ? "TEX" : "FAST"),
                      g_engine.renderer.detail, paused ? " PAUSED" : "");
        SDL_SetWindowTitle(win, title);
        SDL_Delay(1);
    }

    SDL_DestroyTexture(tex);
    SDL_DestroyRenderer(ren);
    SDL_DestroyWindow(win);
    SDL_Quit();

    std::free(map);
    for (unsigned i = 0; i < NUM_BANKS; ++i) std::free(const_cast<uint8_t*>(banks[i]));
    return 0;
}
