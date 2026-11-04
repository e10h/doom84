#include "r_bsp.h"
#include "r_state.h"
#include "r_segs.h"
#include "m_bbox.h"

unsigned node_side(int x, int y, const Node *n) {
    if (!n->dx) return x <= n->x ? n->dy > 0 : n->dy < 0;
    if (!n->dy) return y <= n->y ? n->dx < 0 : n->dx > 0;
    int32_t left = (int32_t)(x - n->x) * n->dy;
    int32_t right = (int32_t)(y - n->y) * n->dx;
    return right >= left;
}

void R_RenderBSPNode(unsigned index, unsigned depth) {
    if (depth > render_stats.bsp_depth) render_stats.bsp_depth = (uint8_t)depth;
    if (index & 0x8000u) {
        const Subsector *sub = &subsectors[index & 0x7fffu];
        ++render_stats.subsectors;
        const Seg *seg = segs + sub->first;
        const Material *side = materials + sub->first;
        for (unsigned i = sub->count; i; --i, ++seg, ++side) {
            d84_draw_seg(seg, side);
        }
        return;
    }
    const Node *n = (const Node *)((const uint8_t *)nodes + node_offsets[(uint8_t)index]);
    unsigned side = node_side(camx, camy, n);
    R_RenderBSPNode(n->child[side], depth + 1);
    if (d84_bbox_visible(n->bbox[side ^ 1], index * 2 + (side ^ 1))) {
        R_RenderBSPNode(n->child[side ^ 1], depth + 1);
    }
}
