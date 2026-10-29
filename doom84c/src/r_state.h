#ifndef R_STATE_H
#define R_STATE_H

#include "doomdef.h"
#include "r_defs.h"
#include "generated.h"
#include "geometry.h"

extern Player player;
extern RenderStats render_stats;
extern unsigned render_detail;
extern View engine_view;
#define framebuffer (engine_view.pixels)

extern const Vertex *map_vertices;
extern const Line *map_lines;
extern const Sector *map_sectors;
extern const uint8_t *map_palette;
extern const Side *sides;
extern const Seg *segs;
extern const Subsector *subsectors;
extern const Node *nodes;
extern const MapActor *map_actors;
extern const int16_t *blockmap;
extern const uint8_t *colormaps;
extern const uint8_t *images[NUM_TILES];
extern uint8_t ram_colormaps[32*256];
extern Material materials[NUM_SEGS];
extern const uint16_t row_offsets[VIEW_H];
extern uint8_t sector_shades[NUM_SECTORS];
extern const uint8_t *shade_rows[32];
extern uint8_t plane_colors[NUM_SECTORS*2];
extern uint8_t sky_flat;

extern uint8_t depthbuffer[VIEW_W*VIEW_H];
extern uint8_t planes[VIEW_W*VIEW_H];
extern uint8_t cliptop[VIEW_W], clipbottom[VIEW_W];
extern int16_t vertex_side[NUM_RENDER_POINTS], vertex_depth[NUM_RENDER_POINTS], vertex_screen[NUM_RENDER_POINTS];
extern uint8_t vertex_stamp[NUM_RENDER_POINTS], frame_stamp;
extern int camx, camy;
extern int camcos, camsin;
extern int16_t d84_rotated[3];
extern RenderWall d84_rw;
#define rw d84_rw

static inline const Sector *sector_at(unsigned index) {
    return (const Sector *)((const uint8_t *)map_sectors + sector_offsets[index]);
}

#endif /* R_STATE_H */
