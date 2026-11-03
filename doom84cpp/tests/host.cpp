#include "../src/doom/engine.h"

#include <cassert>
#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <memory>
#include <vector>

namespace {

unsigned checks = 0;
bool hash_frames = false;
uint64_t frame_hash = 14695981039346656037ull;
doom::Engine g_engine;

void render_frame() {
    g_engine.render();
    if (hash_frames) {
        for (unsigned i = 0; i < doom::ViewWidth * doom::ViewHeight; ++i) {
            frame_hash ^= g_engine.framebuffer()[i];
            frame_hash *= 1099511628211ull;
        }
    }
}

#define CHECK(expr) do { \
    ++checks; \
    if (!(expr)) { \
        std::fprintf(stderr, "FAIL %s:%d: %s\n", __FILE__, __LINE__, #expr); \
        std::exit(1); \
    } \
} while (0)

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

void screenshot(const char* path) {
    render_frame();
    std::FILE* f = std::fopen(path, "wb");
    if (!f) {
        std::perror(path);
        std::exit(1);
    }
    std::fprintf(f, "P6\n128 80\n255\n");
    for (unsigned i = 0; i < doom::ViewWidth * doom::ViewHeight; ++i) {
        std::fwrite(g_engine.map.palette + g_engine.framebuffer()[i] * 3, 1, 3, f);
    }
    std::fclose(f);
    std::printf("%s: pos %ld,%ld sector %u eye %d; %u segs, %u subsectors, %u columns, %u plane spans, BSP depth %u\n",
                path,
                static_cast<long>(g_engine.player().x / 256),
                static_cast<long>(g_engine.player().y / 256),
                g_engine.player().sector,
                g_engine.player().eye,
                g_engine.stats().segs,
                g_engine.stats().subsectors,
                g_engine.stats().wall_columns,
                g_engine.stats().plane_spans,
                g_engine.stats().bsp_depth);
}

void pose(int x, int y, unsigned angle) {
    g_engine.player().x = static_cast<int32_t>(x) * 256;
    g_engine.player().y = static_cast<int32_t>(y) * 256;
    g_engine.player().sector = g_engine.world.find_sector(x, y);
    g_engine.player().floor  = g_engine.map.sectors[g_engine.player().sector].floor;
    g_engine.player().eye    = g_engine.player().floor + 41;
    g_engine.player().angle  = angle;
}

void pose_sector(unsigned sector) {
    for (unsigned i = 0; i < NUM_LINES; ++i) {
        const doom::Line* l = &g_engine.map.lines[i];
        const doom::Vertex* a = &g_engine.map.vertices[l->v1];
        const doom::Vertex* b = &g_engine.map.vertices[l->v2];
        int dx = b->x - a->x, dy = b->y - a->y;
        double length = std::hypot(dx, dy);
        if (!length) continue;
        for (int sign = -1; sign <= 1; sign += 2) {
            int x = (a->x + b->x) / 2 + static_cast<int>(sign * dy * 8 / length);
            int y = (a->y + b->y) / 2 - static_cast<int>(sign * dx * 8 / length);
            if (g_engine.world.find_sector(x, y) == sector) {
                pose(x, y, 0);
                return;
            }
        }
    }
    CHECK(!"No sample found in sector");
}

void run_tests() {
    CHECK(g_engine.player().x / 256 == START_X && g_engine.player().y / 256 == START_Y);
    CHECK(g_engine.player().sector < NUM_SECTORS);
    CHECK(g_engine.world.can_move(START_X, START_Y, g_engine.player().floor));

    unsigned map_size;
    uint8_t* map = read_file("build/D84MAP.bin", &map_size);
    const doom::Seg* segs = reinterpret_cast<const doom::Seg*>(map + OFF_SEGS);
    const doom::Side* sides = reinterpret_cast<const doom::Side*>(map + OFF_SIDES);
    const doom::Subsector* subs = reinterpret_cast<const doom::Subsector*>(map + OFF_SUBSECTORS);

    for (unsigned trigger = 0; trigger < NUM_WALK_TRIGGERS; ++trigger) {
        g_engine.reset();
        const doom::Line* l = &g_engine.map.lines[walk_triggers[trigger]];
        const doom::Vertex* a = &g_engine.map.vertices[l->v1];
        const doom::Vertex* b = &g_engine.map.vertices[l->v2];
        int dx = b->x - a->x, dy = b->y - a->y;
        double length = std::hypot(dx, dy);
        int x = (a->x + b->x) / 2 + static_cast<int>(dy * 40 / length);
        int y = (a->y + b->y) / 2 - static_cast<int>(dx * 40 / length);
        pose(x, y, static_cast<unsigned>(static_cast<int>(std::lround(std::atan2(dx, -dy) * 1024 / (2 * 3.141592653589793)))) & 1023);

        for (unsigned tic = 0; tic < 40; ++tic) g_engine.tick(doom::Input::Forward);

        unsigned target = 0;
        while (target < NUM_SECTORS && g_engine.map.sectors[target].tag != l->tag) ++target;
        CHECK(target < NUM_SECTORS);
        pose_sector(target);
        g_engine.tick(0);
        CHECK(g_engine.player().floor < g_engine.map.sectors[target].floor);

        if (l->special == 88) {
            for (unsigned tic = 0; tic < 220; ++tic) {
                g_engine.player().health = 200;
                g_engine.tick(0);
            }
            CHECK(g_engine.player().floor == g_engine.map.sectors[target].floor);
        }
    }

    for (unsigned i = 0; i < NUM_LINES; ++i) {
        const doom::Line* l = &g_engine.map.lines[i];
        if (l->special != 1) continue;
        g_engine.reset();
        const doom::Vertex* a = &g_engine.map.vertices[l->v1];
        const doom::Vertex* b = &g_engine.map.vertices[l->v2];
        int dx = b->x - a->x, dy = b->y - a->y;
        double length = std::hypot(dx, dy);
        int mx = (a->x + b->x) / 2, my = (a->y + b->y) / 2;
        int x = mx + static_cast<int>(dy * 40 / length);
        int y = my - static_cast<int>(dx * 40 / length);
        g_engine.player().x = static_cast<int32_t>(x) * 256;
        g_engine.player().y = static_cast<int32_t>(y) * 256;
        g_engine.player().sector = g_engine.world.find_sector(x, y);
        g_engine.player().floor  = g_engine.map.sectors[g_engine.player().sector].floor;
        g_engine.player().eye    = g_engine.player().floor + 41;
        g_engine.player().angle  = static_cast<unsigned>(static_cast<int>(std::lround(std::atan2(dx, -dy) * 1024 / (2 * 3.141592653589793)))) & 1023;

        CHECK(!g_engine.world.can_move(mx, my, g_engine.player().floor));
        g_engine.tick(doom::Input::Use);
        for (unsigned tic = 0; tic < 65; ++tic) g_engine.tick(0);
        CHECK(g_engine.world.can_move(mx, my, g_engine.player().floor));
    }

    g_engine.reset();
    g_engine.player().x = 2952L * 256;
    g_engine.player().y = -4768L * 256;
    g_engine.player().sector = g_engine.world.find_sector(2952, -4768);
    g_engine.player().floor  = g_engine.map.sectors[g_engine.player().sector].floor;
    g_engine.player().eye    = g_engine.player().floor + 41;
    g_engine.player().angle  = 512;
    g_engine.tick(doom::Input::Use);
    CHECK(g_engine.player().exited);

    g_engine.reset();
    for (unsigned i = 0; i < NUM_SUBSECTORS; ++i) {
        if (subs[i].count < 3) continue;
        int32_t x = 0, y = 0;
        for (unsigned j = 0; j < subs[i].count; ++j) {
            const doom::Vertex* v = &g_engine.map.vertices[segs[subs[i].first + j].v1];
            x += v->x; y += v->y;
        }
        unsigned expected = sides[g_engine.map.lines[segs[subs[i].first].line].side[segs[subs[i].first].side]].sector;
        CHECK(g_engine.world.find_sector(x / subs[i].count, y / subs[i].count) == expected);
    }

    for (unsigned i = 0; i < 1024; i += 8) {
        g_engine.player().angle = i;
        render_frame();
        CHECK(g_engine.stats().segs > 0);
        CHECK(g_engine.stats().bsp_depth < 32);
    }

    g_engine.reset();
    for (unsigned i = 0; i < 400; ++i) {
        g_engine.tick(doom::Input::Forward);
        CHECK(g_engine.world.can_move(g_engine.player().world_x(), g_engine.player().world_y(), g_engine.player().floor));
    }

    unsigned frames = 0;
    for (unsigned i = 0; i < NUM_SUBSECTORS; i += 3) {
        int32_t x = 0, y = 0;
        for (unsigned j = 0; j < subs[i].count; ++j) {
            const doom::Vertex* v = &g_engine.map.vertices[segs[subs[i].first + j].v1];
            x += v->x; y += v->y;
        }
        x /= subs[i].count; y /= subs[i].count;
        g_engine.player().x = x * 256;
        g_engine.player().y = y * 256;
        g_engine.player().sector = g_engine.world.find_sector(x, y);
        g_engine.player().floor  = g_engine.map.sectors[g_engine.player().sector].floor;
        g_engine.player().eye    = g_engine.player().floor + 41;

        for (unsigned detail = 1; detail <= 4; detail *= 2) {
            for (unsigned textured = 0; textured <= 1; ++textured) {
                g_engine.renderer.detail = detail;
                g_engine.player().texture_planes = (textured != 0);
                for (unsigned angle = 0; angle < 1024; angle += 128) {
                    g_engine.player().angle = angle;
                    render_frame();
                    ++frames;
                }
            }
        }
    }

    g_engine.renderer.detail = 1;
    g_engine.reset();
    {
        int ammo = g_engine.player().ammo;
        g_engine.tick(doom::Input::Fire);
        CHECK(g_engine.player().fire == 19);
        CHECK(g_engine.player().ammo == ammo);
        for (int i = 0; i < 4; ++i) g_engine.tick(0);
        CHECK(g_engine.player().fire == 15);
        CHECK(g_engine.player().ammo == ammo - 1);
    }

    g_engine.reset();
    for (unsigned i = 0; i < 500; ++i) {
        g_engine.tick((i % 100 < 50 ? doom::Input::Forward : doom::Input::Right) |
                      doom::Input::Fire |
                      ((i % 35 == 0) ? doom::Input::Use : 0));
    }
    CHECK(g_engine.player().health >= 0 && g_engine.player().health <= 200);
    CHECK(g_engine.player().ammo >= 0 && g_engine.player().ammo <= 200);
    CHECK(g_engine.player().kills <= g_engine.player().total);

    std::free(map);
    std::printf("PASS: %u checks; %u sector/direction stress frames\n", checks, frames);
}

} // namespace

int main(int argc, char** argv) {
    hash_frames = (std::getenv("D84_HASH_FRAMES") != nullptr);
    unsigned length, sizes[NUM_BANKS];
    uint8_t* map = read_file("build/D84MAP.bin", &length);
    const uint8_t* banks[NUM_BANKS];

    for (unsigned i = 0; i < NUM_BANKS; ++i) {
        char name[64];
        std::snprintf(name, sizeof(name), "build/D84T%u.bin", i);
        banks[i] = read_file(name, &sizes[i]);
    }

    CHECK(g_engine.init(map, length, banks, sizes));
    CHECK(!g_engine.init(map, length - 1, banks, sizes));
    map[8] ^= 1;
    CHECK(!g_engine.init(map, length, banks, sizes));
    map[8] ^= 1;
    CHECK(g_engine.init(map, length, banks, sizes));

    if (argc > 1 && !std::strcmp(argv[1], "--test")) {
        run_tests();
    } else {
        if (argc >= 6) {
            g_engine.player().x = std::strtol(argv[3], nullptr, 10) * 256;
            g_engine.player().y = std::strtol(argv[4], nullptr, 10) * 256;
            g_engine.player().angle = static_cast<unsigned>(std::strtol(argv[5], nullptr, 10));
            g_engine.player().sector = g_engine.world.find_sector(g_engine.player().world_x(), g_engine.player().world_y());
            g_engine.player().floor = g_engine.map.sectors[g_engine.player().sector].floor;
            g_engine.player().eye = g_engine.player().floor + 41;
        }
        if (argc >= 7) g_engine.player().texture_planes = (std::strtol(argv[6], nullptr, 10) != 0);
        if (argc >= 8) g_engine.renderer.detail = static_cast<unsigned>(std::strtol(argv[7], nullptr, 10));
        screenshot(argc > 2 ? argv[2] : "build/preview.ppm");
    }

    std::free(map);
    for (unsigned i = 0; i < NUM_BANKS; ++i) std::free(const_cast<uint8_t*>(banks[i]));
    if (hash_frames) std::printf("Frame hash: %llx\n", static_cast<unsigned long long>(frame_hash));
    return 0;
}
