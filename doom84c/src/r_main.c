#include "r_main.h"
#include "r_state.h"
#include "r_draw.h"
#include "r_bsp.h"
#include "r_plane.h"
#include "r_things.h"
#include "m_fixed.h"
#include "gun.h"
#include <string.h>

Player player;
RenderStats render_stats;
unsigned render_detail = 1;
View engine_view;

const Vertex *map_vertices;
const Line *map_lines;
const Sector *map_sectors;
const uint8_t *map_palette;
const Side *sides;
const Seg *segs;
const Subsector *subsectors;
const Node *nodes;
const MapActor *map_actors;
const int16_t *blockmap;
const uint8_t *colormaps;
const uint8_t *images[NUM_TILES];
uint8_t ram_colormaps[32*256] __attribute__((aligned(256)));
Material materials[NUM_SEGS];

const uint16_t row_offsets[VIEW_H] = {
    0,128,256,384,512,640,768,896,1024,1152,1280,1408,1536,1664,1792,1920,
    2048,2176,2304,2432,2560,2688,2816,2944,3072,3200,3328,3456,3584,3712,3840,3968,
    4096,4224,4352,4480,4608,4736,4864,4992,5120,5248,5376,5504,5632,5760,5888,6016,
    6144,6272,6400,6528,6656,6784,6912,7040,7168,7296,7424,7552,7680,7808,7936,8064,
    8192,8320,8448,8576,8704,8832,8960,9088,9216,9344,9472,9600,9728,9856,9984,10112
};

uint8_t sector_shades[NUM_SECTORS];
const uint8_t *shade_rows[32];
uint8_t plane_colors[NUM_SECTORS*2];
uint8_t sky_flat;

uint8_t depthbuffer[VIEW_W*VIEW_H];
uint8_t planes[VIEW_W*VIEW_H];
uint8_t cliptop[VIEW_W], clipbottom[VIEW_W];
int16_t vertex_side[NUM_RENDER_POINTS], vertex_depth[NUM_RENDER_POINTS], vertex_screen[NUM_RENDER_POINTS];
uint8_t vertex_stamp[NUM_RENDER_POINTS], frame_stamp;
int camx, camy;
int camcos, camsin;
int16_t d84_rotated[3];
RenderWall d84_rw;

void d84_rotate(int dx, int dy) {
    d84_rotated[0] = shr8(dx * camsin - dy * camcos);
    d84_rotated[1] = shr8(dx * camcos + dy * camsin);
}

void d84_set_camera(int x, int y, unsigned angle) {
    camx = x;
    camy = y;
    camcos = icos(angle);
    camsin = isin(angle);
}

void vertex(unsigned v, int *r, int *z) {
    if ((vertex_stamp[v] & 254) != frame_stamp) {
        const Vertex *point = v < NUM_VERTICES ? map_vertices + v : extra_points + (v - NUM_VERTICES);
        int dx = point->x - camx, dy = point->y - camy;
        /* E1M1's coordinate range bounds each product and sum to 24 bits. */
        d84_rotate(dx, dy);
        vertex_side[v] = d84_rotated[0];
        vertex_depth[v] = d84_rotated[1];
        vertex_stamp[v] = frame_stamp;
    }
    *r = vertex_side[v];
    *z = vertex_depth[v];
}

int vertex_projection(unsigned v, int r, int z) {
    if (z < 32) return screen_x(r, z);
    if (!(vertex_stamp[v] & 1)) {
        vertex_screen[v] = (int16_t)screen_x(r, z);
        vertex_stamp[v] |= 1;
    }
    return vertex_screen[v];
}

int project(int height, int z) {
    return CENTER - (height - player.eye) * FOCAL / z;
}

const uint8_t *lighting(unsigned sector, int z) {
    if (z >= 4096) return shade_rows[31];
    uint8_t distance = (uint8_t)(z >> 7);
    uint8_t shade = sector_shades[sector] + distance;
    return shade_rows[MIN(shade, 31)];
}

uint8_t screen_y(int value) {
    if (value <= 0) return 0;
    if (value >= VIEW_H * 256) return VIEW_H;
    return (uint8_t)(value >> 8);
}

uint8_t wire_screen_y(int value) {
    if (value <= 0) return 0;
    if (value >= VIEW_H * 256) return VIEW_H;
    return (uint8_t)(value >> 8);
}

#define PISTOL_FIRE_AT 15

void engine_render(void) {
    memset(&render_stats, 0, sizeof(render_stats));
    memset(framebuffer, 0, sizeof(framebuffer));
    if (!player.wireframe) memset(depthbuffer, 255, sizeof(depthbuffer));
    if (player.texture_planes && !player.wireframe) memset(planes, 255, sizeof(planes));
    memset(cliptop, 0, sizeof(cliptop));
    memset(clipbottom, VIEW_H, sizeof(clipbottom));
    frame_stamp += 2;
    if (!frame_stamp) {
        memset(vertex_stamp, 0, sizeof(vertex_stamp));
        frame_stamp = 2;
    }
    camx = (int)(player.x / 256);
    camy = (int)(player.y / 256);
    camcos = icos(player.angle);
    camsin = isin(player.angle);

    R_RenderBSPNode(NUM_NODES - 1, 0);

    if (player.wireframe) {
        framebuffer[39 * VIEW_W + 64] = 4;
        framebuffer[41 * VIEW_W + 64] = 4;
        framebuffer[40 * VIEW_W + 63] = 4;
        framebuffer[40 * VIEW_W + 65] = 4;
        return;
    }

    if (player.texture_planes) {
        if (render_detail == 4) d84_quad_columns(planes, VIEW_W * VIEW_H / 4);
        else if (render_detail == 3) d84_triple_columns(planes, VIEW_H);
        else if (render_detail == 2) d84_double_columns(planes, VIEW_W * VIEW_H / 2);
        draw_planes();
    }

    draw_sprites();

    if (render_detail == 4) d84_quad_columns(framebuffer, VIEW_W * VIEW_H / 4);
    else if (render_detail == 3) d84_triple_columns(framebuffer, VIEW_H);
    else if (render_detail == 2) d84_double_columns(framebuffer, VIEW_W * VIEW_H / 2);

    /* Pistol frame from remaining fire tics: A / B / C / B, plus muzzle flash. */
    unsigned frame = 0;
    if (player.fire) {
        if (player.fire > PISTOL_FIRE_AT) frame = 0;
        else if (player.fire > 9) frame = 1;
        else if (player.fire > 5) frame = 2;
        else frame = 1;
    }
    const uint8_t *gun = gun_frames[frame];
    int bob = player.fire ? 0 : (isin(player.ticks * 16) / 128);
    for (int y = 0; y < GUN_H; ++y) {
        int dest = GUN_Y + y + bob;
        if (dest < 0 || dest >= VIEW_H) continue;
        for (int x = 0; x < GUN_W; ++x) {
            uint8_t pixel = gun[y * GUN_W + x];
            if (pixel != 255) framebuffer[dest * VIEW_W + GUN_X + x] = pixel;
        }
    }
    if (player.fire && player.fire <= PISTOL_FIRE_AT && player.fire > 9) {
        for (int y = 0; y < GUN_H; ++y) {
            int dest = GUN_Y + y + bob;
            if (dest < 0 || dest >= VIEW_H) continue;
            for (int x = 0; x < GUN_W; ++x) {
                uint8_t pixel = gun_flash[y * GUN_W + x];
                if (pixel != 255) framebuffer[dest * VIEW_W + GUN_X + x] = pixel;
            }
        }
    }

    /* Subtle crosshair uses palette entry 4 (near-white in Doom PLAYPAL). */
    framebuffer[39 * VIEW_W + 64] = 4;
    framebuffer[41 * VIEW_W + 64] = 4;
    framebuffer[40 * VIEW_W + 63] = 4;
    framebuffer[40 * VIEW_W + 65] = 4;
}
