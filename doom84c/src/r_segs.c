#include "r_segs.h"
#include "r_state.h"
#include "r_draw.h"
#include "r_plane.h"
#include "r_main.h"
#include "p_local.h"
#include "m_fixed.h"
#include <stddef.h>

static WallStyle wall_style(unsigned tex, int anchor, int yoff) {
    WallStyle style = {NULL, 0, 0, 0};
    if (tex != 255) {
        style.image = images[tex];
        style.shiftx = (int8_t)tile_info[tex][1] - 5;
        style.shifty = (int8_t)tile_info[tex][2] - 5;
        style.base = (anchor - player.eye + yoff) * 256;
        if (style.shifty >= 0) style.base >>= style.shifty;
        else style.base *= 1 << -style.shifty;
    }
    return style;
}

void d84_wall_column(int x, int y1, int y2, const WallStyle *style, int iz, int uz, unsigned sector) {
    if (y1 > y2 || !style->image) return;
    ++render_stats.wall_columns;
    unsigned inv = reciprocal((unsigned)iz);
    int z = (int)(inv >> 2);
    int u = high_word((int32_t)uz * inv);
    const uint8_t *light = lighting(sector, z);
    unsigned tx = (style->shiftx >= 0 ? ((unsigned)u >> style->shiftx) : ((unsigned)u << -style->shiftx)) & 31;
    int step = z;
    int v = (y1 - CENTER) * z;
    switch (style->shifty) {
        case 2: break;
        case 1: v *= 2; step *= 2; break;
        case 0: v *= 4; step *= 4; break;
        case -1: v *= 8; step *= 8; break;
        case -2: v *= 16; step *= 16; break;
        default:
            if (style->shifty > 2) {
                v >>= style->shifty - 2;
                step >>= style->shifty - 2;
            } else {
                v *= 1 << (2 - style->shifty);
                step *= 1 << (2 - style->shifty);
            }
            break;
    }
    v += style->base;
    uint8_t depth = (uint8_t)CLAMP(z / 16, 1, 254);
    unsigned offset = row_offsets[(uint8_t)y1] + x;
    d84_wall(framebuffer + offset, depthbuffer + offset, style->image + tx, light, (unsigned)(y2 - y1 + 1), v, step, depth);
}

__attribute__((noinline)) void render_wire_columns(void) {
    uint8_t color = rw.solid ? 4 : 196;
    for (int x = rw.start; x < rw.end; x += (int)rw.stride, rw.iz += rw.diz, rw.cyq += rw.cy_step, rw.fyq += rw.fy_step, rw.upperq += rw.upper_step, rw.lowerq += rw.lower_step) {
        int top = cliptop[x], bottom = clipbottom[x];
        if (top >= bottom || rw.iz <= 0) continue;
        uint8_t cy = wire_screen_y(rw.cyq), fy = wire_screen_y(rw.fyq);
        if (cy >= top && cy < bottom) wire_plot(x, cy, color);
        if (fy > top && fy <= bottom) wire_plot(x, fy - 1, color);
        if (rw.solid) {
            if (x == rw.start || x + (int)rw.stride >= rw.end) {
                int y1 = MAX(top, cy), y2 = MIN(bottom - 1, fy - 1);
                for (int y = y1; y <= y2; ++y) wire_plot(x, y, color);
            }
            cliptop[x] = clipbottom[x];
        } else {
            uint8_t upper = wire_screen_y(rw.upperq), lower = wire_screen_y(rw.lowerq);
            if (rw.draw_upper && upper >= top && upper < bottom) wire_plot(x, upper, color);
            if (rw.draw_lower && lower >= top && lower < bottom) wire_plot(x, lower, color);
            if (x == rw.start || x + (int)rw.stride >= rw.end) {
                if (rw.draw_upper) {
                    int y1 = MAX(top, cy), y2 = MIN(bottom - 1, upper - 1);
                    for (int y = y1; y <= y2; y += 2) wire_plot(x, y, color);
                }
                if (rw.draw_lower) {
                    int y1 = MAX(top, lower), y2 = MIN(bottom - 1, fy - 1);
                    for (int y = y1; y <= y2; y += 2) wire_plot(x, y, color);
                }
            }
            cliptop[x] = (uint8_t)CLAMP(MAX(top, MAX(cy, upper)), top, bottom);
            clipbottom[x] = (uint8_t)CLAMP(MIN(bottom, MIN(fy, lower)), cliptop[x], bottom);
        }
        for (unsigned k = 1; k < rw.stride && x + (int)k < VIEW_W; ++k) {
            cliptop[x + (int)k] = cliptop[x];
            clipbottom[x + (int)k] = clipbottom[x];
        }
    }
}

__attribute__((noinline)) void render_columns(void) {
    if (player.wireframe) {
        render_wire_columns();
        return;
    }
    for (int x = rw.start; x < rw.end; x += (int)render_detail, rw.iz += rw.diz, rw.uz += rw.duz, rw.cyq += rw.cy_step, rw.fyq += rw.fy_step, rw.upperq += rw.upper_step, rw.lowerq += rw.lower_step) {
        int top = cliptop[x], bottom = clipbottom[x];
        if (top >= bottom || rw.iz <= 0) continue;
        uint8_t cy = screen_y(rw.cyq), fy = screen_y(rw.fyq);
        plane_column(x, top, MIN(bottom - 1, cy - 1), (uint8_t)(rw.fs | 128));
        plane_column(x, MAX(top, fy), bottom - 1, (uint8_t)rw.fs);
        if (rw.solid) {
            d84_wall_column(x, MAX(top, cy), MIN(bottom - 1, fy - 1), &rw.middle, rw.iz, rw.uz, (unsigned)rw.fs);
            cliptop[x] = clipbottom[x];
        } else {
            uint8_t upper = screen_y(rw.upperq), lower = screen_y(rw.lowerq);
            if (rw.bceil < rw.fceil && !rw.skyportal) {
                d84_wall_column(x, MAX(top, cy), MIN(bottom - 1, upper - 1), &rw.upper, rw.iz, rw.uz, (unsigned)rw.fs);
            }
            if (rw.bfloor > rw.ffloor) {
                d84_wall_column(x, MAX(top, lower), MIN(bottom - 1, fy - 1), &rw.lower, rw.iz, rw.uz, (unsigned)rw.fs);
            }
            cliptop[x] = (uint8_t)CLAMP(MAX(top, MAX(cy, upper)), top, bottom);
            clipbottom[x] = (uint8_t)CLAMP(MIN(bottom, MIN(fy, lower)), cliptop[x], bottom);
        }
        for (unsigned k = 1; k < render_detail && x + (int)k < VIEW_W; ++k) {
            cliptop[x + (int)k] = cliptop[x];
            clipbottom[x + (int)k] = clipbottom[x];
        }
    }
}

static int height_product(int height, int inverse) {
    if (inverse >= -16384 && inverse <= 16383) return (height * inverse) >> 4;
    return (int)(((int32_t)height * inverse) >> 4);
}

static bool clip_seg_plane(int *r1, int *z1, int *u1, int *r2, int *z2, int *u2, int a1, int a2, bool do_u) {
    if (a1 < 0 && a2 < 0) return false;
    if (a1 >= 0 && a2 >= 0) return true;
    if (a1 < 0) {
        int den = a1 - a2;
        if (!den) return false;
        *r1 += (int)((int32_t)(*r2 - *r1) * a1 / den);
        *z1 += (int)((int32_t)(*z2 - *z1) * a1 / den);
        if (do_u) *u1 += (int)((int32_t)(*u2 - *u1) * a1 / den);
    } else {
        int den = a2 - a1;
        if (!den) return false;
        *r2 += (int)((int32_t)(*r1 - *r2) * a2 / den);
        *z2 += (int)((int32_t)(*z1 - *z2) * a2 / den);
        if (do_u) *u2 += (int)((int32_t)(*u1 - *u2) * a2 / den);
    }
    return true;
}

__attribute__((noinline)) void d84_draw_seg(const Seg *seg, const Material *side) {
    unsigned fs = side->sector;
    int bs = side->back == 255 ? -1 : side->back;
    if (bs >= 0 && (side->flags & 128) && sector_floor[fs] == sector_floor[bs] && sector_ceiling[fs] == sector_ceiling[bs] && side->middle == 255) return;
    int r1, z1, r2, z2;
    vertex(seg->v1, &r1, &z1);
    vertex(seg->v2, &r2, &z2);
    /* Backface cull before clipping, using the projected segment winding. */
    if ((int)((unsigned)r1 * z2 - (unsigned)r2 * z1) >= 0 || (z1 < NEAR_Z && z2 < NEAR_Z)) return;
    int u1 = 0, u2 = 0;
    bool do_u = !player.wireframe;
    if (do_u) {
        u1 = (side->x + seg->offset) & 1023;
        u2 = u1 + seg->length;
    }
    if (!clip_seg_plane(&r1, &z1, &u1, &r2, &z2, &u2, z1 - NEAR_Z, z2 - NEAR_Z, do_u)) return;
    if (!clip_seg_plane(&r1, &z1, &u1, &r2, &z2, &u2, r1 + z1, r2 + z2, do_u)) return;
    if (!clip_seg_plane(&r1, &z1, &u1, &r2, &z2, &u2, z1 - r1, z2 - r2, do_u)) return;
    int sx1 = screen_x(r1, z1), sx2 = screen_x(r2, z2);
    if (sx1 >= sx2 || sx2 <= 0 || sx1 >= VIEW_W) return;
    int start = MAX(0, sx1), end = MIN(VIEW_W, sx2);
    unsigned step = player.wireframe ? 1 : render_detail;
    if (step > 1) start = ((start + (int)step - 1) / (int)step) * (int)step;
    while (start < end && cliptop[start] >= clipbottom[start]) start += (int)step;
    while (end > start && cliptop[end - 1] >= clipbottom[end - 1]) --end;
    if (start >= end) return;
    int iz1 = (int)(reciprocal((unsigned)z1) >> 2), iz2 = (int)(reciprocal((unsigned)z2) >> 2);
    int span = sx2 - sx1;
    int diz = (iz2 - iz1) / span;
    int iz = iz1 + (int)((int32_t)(iz2 - iz1) * (start - sx1) / span);
    int uz = 0, duz = 0;
    if (do_u) {
        int uz1 = (int)(((int32_t)u1 * iz1) >> 4), uz2 = (int)(((int32_t)u2 * iz2) >> 4);
        duz = (uz2 - uz1) / span;
        uz = uz1 + (int)((int32_t)(uz2 - uz1) * (start - sx1) / span);
    }
    int fceil = sector_ceiling[fs], ffloor = sector_floor[fs];
    bool skyportal = bs >= 0 && (*sector_at(fs)).ceiltex == 255 && (*sector_at(bs)).ceiltex == 255;
    if (skyportal) fceil = sector_ceiling[bs];
    bool solid = bs < 0 || sector_ceiling[bs] <= ffloor || sector_floor[bs] >= fceil || sector_ceiling[bs] <= sector_floor[bs];
    int cyq = 40 * 256 - height_product(fceil - player.eye, iz);
    int fyq = 40 * 256 - height_product(ffloor - player.eye, iz);
    int cy_step = -height_product(fceil - player.eye, diz);
    int fy_step = -height_product(ffloor - player.eye, diz);
    int bceil = bs < 0 ? fceil : sector_ceiling[bs], bfloor = bs < 0 ? ffloor : sector_floor[bs];
    int upperq = bceil == fceil ? cyq : 40 * 256 - height_product(bceil - player.eye, iz);
    int lowerq = bfloor == ffloor ? fyq : 40 * 256 - height_product(bfloor - player.eye, iz);
    int upper_step = bceil == fceil ? cy_step : -height_product(bceil - player.eye, diz);
    int lower_step = bfloor == ffloor ? fy_step : -height_product(bfloor - player.eye, diz);
    diz *= (int)step;
    duz *= (int)step;
    cy_step *= (int)step;
    fy_step *= (int)step;
    upper_step *= (int)step;
    lower_step *= (int)step;
    const uint8_t *light = colormaps;
    ++render_stats.segs;
    rw = (RenderWall){start, end, iz, diz, uz, duz, cyq, cy_step, fyq, fy_step, upperq, upper_step, lowerq, lower_step, fceil, ffloor, bceil, bfloor, (int)fs, sector_shades[fs], solid, skyportal, side, light, {0}, {0}, {0}, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    rw.top_ptr = cliptop + start;
    rw.bottom_ptr = clipbottom + start;
    rw.draw_upper = (uint8_t)(bceil < fceil && !skyportal);
    rw.draw_lower = (uint8_t)(bfloor > ffloor);
    rw.stride = (uint8_t)step;
    if (player.wireframe) {
        render_wire_columns();
        return;
    }
    if (solid) {
        unsigned tex = side->middle;
        if (tex == 255 && bs >= 0) tex = side->upper;
        if (tex == 255 && bs >= 0) tex = side->lower;
        rw.middle = wall_style(tex, tex != 255 && (side->flags & 16) ? ffloor + (1 << tile_info[tex][2]) : fceil, side->y);
    } else {
        if (bceil < fceil && !skyportal) rw.upper = wall_style(side->upper, (side->flags & 8) ? fceil : bceil + (side->upper == 255 ? 128 : (1 << tile_info[side->upper][2])), side->y);
        if (bfloor > ffloor) rw.lower = wall_style(side->lower, (side->flags & 16) ? fceil : bfloor, side->y);
    }
    rw.fill_base = player.texture_planes ? planes : framebuffer;
    rw.ceil_color = player.texture_planes ? (uint8_t)(fs | 128) : plane_colors[fs + NUM_SECTORS];
    rw.floor_color = player.texture_planes ? (uint8_t)fs : plane_colors[fs];
    render_columns();
}
