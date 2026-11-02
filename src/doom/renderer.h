#pragma once

#include "doom/types.h"
#include "doom/camera.h"
#include "doom/occlusion.h"
#include "doom/wall_segment.h"
#include "doom/map.h"
#include "doom/world.h"
#include "../geometry.h"
#include <cstdint>

namespace doom {

class Renderer {
public:
    View            view;
    Camera          camera;
    OcclusionBuffer occlusion;
    WallSegment     wall_segment;

    uint8_t         depthbuffer[ViewWidth * ViewHeight]{};
    uint8_t         planes[ViewWidth * ViewHeight]{};

    int16_t         vertex_side[NUM_RENDER_POINTS]{};
    int16_t         vertex_depth[NUM_RENDER_POINTS]{};
    int16_t         vertex_screen[NUM_RENDER_POINTS]{};
    uint8_t         vertex_stamp[NUM_RENDER_POINTS]{};
    uint8_t         frame_stamp = 0;

    RenderStats     stats;
    unsigned        detail = 1;

    uint8_t         sprite_order[NUM_ACTORS]{};
    int16_t         sprite_z[NUM_ACTORS]{};
    int16_t         sprite_x[NUM_ACTORS]{};

    Renderer();

    uint8_t* framebuffer();
    const uint8_t* framebuffer() const;

    void render(const World& world, const Map& map);

private:
    void clear_buffers(const World& world);
    void advance_frame_stamp();

    void vertex(unsigned v, const Map& map, int& r, int& z);
    int vertex_projection(unsigned v, int r, int z);
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
    void draw_crosshair();
    void apply_detail_replication();
};

} // namespace doom
