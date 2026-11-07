#include "automap.h"
#include "math.h"

#ifdef __TICE__
#include <graphx.h>
#endif

namespace doom {

void Automap::draw(const Player& player, const Map& map) {
#ifdef __TICE__
    gfx_SetClipRegion(0, ViewY, 320, ViewY + ViewHeightDst);
    gfx_SetColor(0);
    gfx_FillRectangle_NoClip(0, ViewY, 320, ViewHeightDst);
    int px = player.world_x(), py = player.world_y();
    int cx = 160, cy = ViewY + ViewHeightDst / 2;

    for (unsigned i = 0; i < NUM_LINES; ++i) {
        const Line* l = &map.lines[i];
        const Vertex* a = &map.vertices[l->v1];
        const Vertex* b = &map.vertices[l->v2];
        gfx_SetColor(l->side[1] == 65535u ? 176 : 96);
        gfx_Line(cx + (a->x - px) / 16, cy - (a->y - py) / 16,
                 cx + (b->x - px) / 16, cy - (b->y - py) / 16);
    }

    gfx_SetColor(4);
    gfx_FillCircle(cx, cy, 2);
    int c = math::icos(player.angle), s = math::isin(player.angle);
    gfx_Line(cx, cy, cx + c / 32, cy - s / 32);
    gfx_SetClipRegion(0, 0, 320, 240);
#else
    (void)player;
    (void)map;
#endif
}

} // namespace doom
