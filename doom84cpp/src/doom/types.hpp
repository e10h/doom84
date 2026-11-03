#pragma once

#include <cstdint>
#include <cstddef>

namespace doom {

inline constexpr int ViewWidth  = 128;
inline constexpr int ViewHeight = 80;
inline constexpr int Focal      = 64;
inline constexpr int CenterY    = 40;
inline constexpr int NearZ      = 4;

#ifndef D84_FRUSTUM_CULL
#define D84_FRUSTUM_CULL 1
#endif

namespace Input {
    inline constexpr uint8_t Forward = 1;
    inline constexpr uint8_t Back    = 2;
    inline constexpr uint8_t Left    = 4;
    inline constexpr uint8_t Right   = 8;
    inline constexpr uint8_t Strafe  = 16;
    inline constexpr uint8_t Fire    = 32;
    inline constexpr uint8_t Use     = 64;
    inline constexpr uint8_t Run     = 128;
}

#pragma pack(push, 1)

struct Vertex {
    int16_t x, y;
};

struct Line {
    uint16_t v1, v2;
    uint16_t flags;
    uint16_t special;
    uint16_t tag;
    uint16_t side[2];
};

struct Side {
    int16_t x, y;
    uint8_t upper, lower, middle, sector;
};

struct Sector {
    int16_t floor, ceiling;
    uint8_t flat, ceiltex, light, special, tag, pad;
};

struct Seg {
    uint16_t v1, v2;
    uint16_t angle;
    uint16_t line;
    uint16_t side;
    uint16_t offset;
    uint16_t length;
};

struct Subsector {
    uint16_t count, first;
};

struct Node {
    int16_t x, y, dx, dy;
    int16_t bbox[2][4];
    uint16_t child[2];
};

struct MapActor {
    int16_t x, y;
    uint16_t type;
    uint8_t image, walk, death, width, height, hp, kind, pad;
};

struct Material {
    uint8_t sector, back, middle, upper, lower, flags;
    int16_t x, y;
};

#pragma pack(pop)

static_assert(sizeof(Vertex)    == 4,  "Vertex disk layout mismatch");
static_assert(sizeof(Line)      == 14, "Line disk layout mismatch");
static_assert(sizeof(Side)      == 8,  "Side disk layout mismatch");
static_assert(sizeof(Sector)    == 10, "Sector disk layout mismatch");
static_assert(sizeof(Seg)       == 14, "Seg disk layout mismatch");
static_assert(sizeof(Subsector) == 4,  "Subsector disk layout mismatch");
static_assert(sizeof(Node)      == 28, "Node disk layout mismatch");
static_assert(sizeof(MapActor)  == 14, "Actor disk layout mismatch");
static_assert(sizeof(Material)  == 10, "Material layout mismatch");

struct WallStyle {
    const uint8_t* image{nullptr};
    int base{0};
    int8_t shiftx{0}, shifty{0};
};

struct RenderStats {
    uint16_t segs{0};
    uint16_t subsectors{0};
    uint16_t wall_columns{0};
    uint16_t plane_spans{0};
    uint8_t  bsp_depth{0};

    constexpr void reset() {
        segs = 0;
        subsectors = 0;
        wall_columns = 0;
        plane_spans = 0;
        bsp_depth = 0;
    }
};

struct View {
    uint8_t width{ViewWidth};
    uint8_t height{ViewHeight};
    uint8_t pixels[ViewWidth * ViewHeight]{};
};

} // namespace doom

using doom::Vertex;
