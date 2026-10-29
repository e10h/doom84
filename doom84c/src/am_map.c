#include "am_map.h"
#include "r_state.h"
#include "m_fixed.h"
#ifdef __TICE__
#include <graphx.h>
#endif

#define VIEW_Y 8
#define VIEW_H_DST 200

void automap(void) {
#ifdef __TICE__
    gfx_SetClipRegion(0, VIEW_Y, 320, VIEW_Y + VIEW_H_DST);
    gfx_SetColor(0);
    gfx_FillRectangle_NoClip(0, VIEW_Y, 320, VIEW_H_DST);
    int px = (int)(player.x / 256), py = (int)(player.y / 256);
    int cx = 160, cy = VIEW_Y + VIEW_H_DST / 2;
    for (unsigned i = 0; i < NUM_LINES; ++i) {
        const Line *l = &map_lines[i];
        const Vertex *a = &map_vertices[l->v1], *b = &map_vertices[l->v2];
        gfx_SetColor(l->side[1] == 65535u ? 176 : 96);
        gfx_Line(cx + (a->x - px) / 16, cy - (a->y - py) / 16, cx + (b->x - px) / 16, cy - (b->y - py) / 16);
    }
    gfx_SetColor(4);
    gfx_FillCircle(cx, cy, 2);
    int c = icos(player.angle), s = isin(player.angle);
    gfx_Line(cx, cy, cx + c / 32, cy - s / 32);
    gfx_SetClipRegion(0, 0, 320, 240);
#endif
}
