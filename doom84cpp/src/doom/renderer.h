#pragma once

#include "types.h"
#include "map.h"
#include "world.h"
#include "../geometry.h"
#include <cstdint>

namespace doom {

struct InternalRenderWall {
    int start = 0;
    int end = 0;
    int iz = 0;
    int diz = 0;
    int uz = 0;
    int duz = 0;
    int cyq = 0;
    int cy_step = 0;
    int fyq = 0;
    int fy_step = 0;
    int upperq = 0;
    int upper_step = 0;
    int lowerq = 0;
    int lower_step = 0;
    int fceil = 0;
    int ffloor = 0;
    int bceil = 0;
    int bfloor = 0;
    int fs = 0;
    bool solid = false;
    bool skyportal = false;
    const Material* side = nullptr;
    WallStyle middle{};
    WallStyle upper{};
    WallStyle lower{};
    uint8_t draw_upper = 0;
    uint8_t draw_lower = 0;
    uint8_t stride = 1;
};

class Renderer {
public:
    View        view;
    uint8_t     depthbuffer[ViewWidth * ViewHeight]{};
    uint8_t     planes[ViewWidth * ViewHeight]{};
    uint8_t     cliptop[ViewWidth]{};
    uint8_t     clipbottom[ViewWidth]{};

    int16_t     vertex_side[NUM_RENDER_POINTS]{};
    int16_t     vertex_depth[NUM_RENDER_POINTS]{};
    int16_t     vertex_screen[NUM_RENDER_POINTS]{};
    uint8_t     vertex_stamp[NUM_RENDER_POINTS]{};
    uint8_t     frame_stamp = 0;

    int         camx = 0;
    int         camy = 0;
    int         camcos = 0;
    int         camsin = 0;

    RenderStats stats;
    unsigned    detail = 1;

    InternalRenderWall rw;

    uint8_t     sprite_order[NUM_ACTORS]{};
    int16_t     sprite_z[NUM_ACTORS]{};
    int16_t     sprite_x[NUM_ACTORS]{};

    Renderer() = default;

    uint8_t* framebuffer();
    const uint8_t* framebuffer() const;

    void render(const World& world, const Map& map);

private:
    void rotate(int dx, int dy, int& out_r, int& out_z) const;
    void vertex(unsigned v, const Map& map, int& r, int& z);
    int vertex_projection(unsigned v, int r, int z);
    int project(int height, int z, int player_eye) const;
    const uint8_t* lighting(const Map& map, unsigned sector, int z) const;
    static uint8_t screen_y(int value);
    static uint8_t wire_screen_y(int value);
    bool bbox_visible(const int16_t* box, unsigned boxindex, const Map& map);
    void plane_column(int x, int y1, int y2, uint8_t plane, const World& world, const Map& map);
    WallStyle make_wall_style(unsigned tex, int anchor, int yoff, const World& world, const Map& map) const;
    void wall_column(int x, int y1, int y2, const WallStyle* style, int iz, int uz, unsigned sector, const Map& map);
    void render_wire_columns();
    void render_columns(const World& world, const Map& map);
    static int height_product(int height, int inverse);
    static bool clip_seg_plane(int& r1, int& z1, int& u1, int& r2, int& z2, int& u2, int a1, int a2, bool do_u);
    void draw_seg(const Seg* seg, const Material* side, const World& world, const Map& map);
    void render_bsp_node(unsigned index, unsigned depth, const World& world, const Map& map);
    void draw_planes(const World& world, const Map& map);
    void draw_sprites(const World& world, const Map& map);
    void draw_hud_weapon(const World& world);
};

} // namespace doom
