#include "doom/renderer.h"
#include "doom/draw.h"
#include "doom/math.h"
#include "../geometry.h"
#include "../gun.h"
#include <cstring>

namespace doom {

Renderer::Renderer() = default;

uint8_t* Renderer::framebuffer() {
    return view.pixels;
}

const uint8_t* Renderer::framebuffer() const {
    return view.pixels;
}

void Renderer::vertex(unsigned v, const Map& map, int& r, int& z) {
    if ((vertex_stamp[v] & 254) != frame_stamp) {
        const Vertex* point = (v < NUM_VERTICES) ? (map.vertices + v) : (extra_points + (v - NUM_VERTICES));
        int vr = 0;
        int vz = 0;
        camera.transform(point->x, point->y, vr, vz);
        vertex_side[v] = static_cast<int16_t>(vr);
        vertex_depth[v] = static_cast<int16_t>(vz);
        vertex_stamp[v] = frame_stamp;
    }
    r = vertex_side[v];
    z = vertex_depth[v];
}

int Renderer::vertex_projection(unsigned v, int r, int z) {
    if (z < 32) return camera.project_x(r, z);
    if (!(vertex_stamp[v] & 1)) {
        vertex_screen[v] = static_cast<int16_t>(camera.project_x(r, z));
        vertex_stamp[v] |= 1;
    }
    return vertex_screen[v];
}

const uint8_t* Renderer::lighting(const Map& map, unsigned sector, int z) const {
    if (z >= 4096) return map.shade_rows[31];
    uint8_t distance = static_cast<uint8_t>(z >> 7);
    uint8_t shade = map.sector_shades[sector] + distance;
    return map.shade_rows[math::min(static_cast<int>(shade), 31)];
}

uint8_t Renderer::screen_y(int value) {
    if (value <= 0) return 0;
    if (value >= ViewHeight * 256) return ViewHeight;
    return static_cast<uint8_t>(value >> 8);
}

uint8_t Renderer::wire_screen_y(int value) {
    return screen_y(value);
}

bool Renderer::bbox_visible(const int16_t* box, unsigned boxindex, const Map& map) {
    static constexpr uint8_t corners[12][2] = {
        {2,1},{2,0},{3,0},{0,0},{0,1},{0,0},
        {3,2},{0,0},{0,3},{1,3},{1,2},{0,0}
    };
    uint8_t pos = ((camera.x() <= box[2] ? 0 : camera.x() < box[3] ? 1 : 2) +
                   (camera.y() >= box[0] ? 0 : camera.y() > box[1] ? 4 : 8));
    if (pos == 5) return true;

    const uint16_t* points = box_points[boxindex];
    unsigned v1 = points[corners[pos][0]], v2 = points[corners[pos][1]];
    int r1 = 0, z1 = 0, r2 = 0, z2 = 0;
    vertex(v1, map, r1, z1);
    vertex(v2, map, r2, z2);

    if (D84_FRUSTUM_CULL) {
        int margin1 = 2 + math::abs(z1) / 64;
        int margin2 = 2 + math::abs(z2) / 64;
        if ((r1 + z1 < -margin1 && r2 + z2 < -margin2) ||
            (z1 - r1 < -margin1 && z2 - r2 < -margin2)) {
            return false;
        }
    }

    if (z1 < NearZ || z2 < NearZ) return (z1 >= NearZ || z2 >= NearZ);

    int x1 = vertex_projection(v1, r1, z1);
    int x2 = vertex_projection(v2, r2, z2);
    int left  = math::max(0, math::min(x1, x2));
    int right = math::min(ViewWidth - 1, math::max(x1, x2));

    return occlusion.is_range_visible(left, right);
}

void Renderer::plane_column(int x, int y1, int y2, uint8_t plane, const World& world, const Map& map) {
    if (y1 > y2) return;
    if (!world.player.texture_planes) {
        draw::fill_column(framebuffer() + Map::row_offset(static_cast<uint8_t>(y1)) + x,
                          static_cast<unsigned>(y2 - y1 + 1),
                          map.plane_colors[(plane & 127) + ((plane & 128) ? NUM_SECTORS : 0)]);
        return;
    }
    for (int y = y1; y <= y2; ++y) {
        planes[y * ViewWidth + x] = plane;
    }
}

WallStyle Renderer::make_wall_style(unsigned tex, int anchor, int yoff, const World& world, const Map& map) const {
    WallStyle style{};
    if (tex != 255) {
        style.image = map.images[tex];
        style.shiftx = static_cast<int8_t>(tile_info[tex][1]) - 5;
        style.shifty = static_cast<int8_t>(tile_info[tex][2]) - 5;
        style.base = (anchor - world.player.eye + yoff) * 256;
        if (style.shifty >= 0) style.base >>= style.shifty;
        else style.base *= (1 << -style.shifty);
    }
    return style;
}

void Renderer::wall_column(int x, int y1, int y2, const WallStyle* style, int iz, int uz, unsigned sector, const Map& map) {
    if (y1 > y2 || !style->image) return;
    ++stats.wall_columns;
    unsigned inv = math::reciprocal(static_cast<unsigned>(iz));
    int z = static_cast<int>(inv >> 2);
    int u = math::high_word(static_cast<int32_t>(uz) * inv);
    const uint8_t* light = lighting(map, sector, z);
    unsigned tx = (style->shiftx >= 0 ? (static_cast<unsigned>(u) >> style->shiftx) : (static_cast<unsigned>(u) << -style->shiftx)) & 31;
    int step = z;
    int v = (y1 - CenterY) * z;
    switch (style->shifty) {
        case 2: break;
        case 1: v *= 2; step *= 2; break;
        case 0: v *= 4; step *= 4; break;
        case -1: v *= 8; step *= 8; break;
        case -2: v *= 16; step *= 16; break;
        default:
            if (style->shifty > 2) {
                v >>= (style->shifty - 2);
                step >>= (style->shifty - 2);
            } else {
                v *= (1 << (2 - style->shifty));
                step *= (1 << (2 - style->shifty));
            }
            break;
    }
    v += style->base;
    uint8_t depth = static_cast<uint8_t>(math::clamp(z / 16, 1, 254));
    unsigned offset = Map::row_offset(static_cast<uint8_t>(y1)) + x;
    draw::wall(framebuffer() + offset, depthbuffer + offset, style->image + tx, light,
               static_cast<unsigned>(y2 - y1 + 1), v, step, depth);
}

void Renderer::render_wire_columns() {
    uint8_t color = wall_segment.is_solid ? 4 : 196;
    for (int x = wall_segment.start_x; x < wall_segment.end_x; x += static_cast<int>(wall_segment.stride),
         wall_segment.inv_depth += wall_segment.inv_depth_step,
         wall_segment.ceil_screen_y += wall_segment.ceil_screen_step,
         wall_segment.floor_screen_y += wall_segment.floor_screen_step,
         wall_segment.upper_screen_y += wall_segment.upper_screen_step,
         wall_segment.lower_screen_y += wall_segment.lower_screen_step) {
        int top = occlusion.top(x);
        int bottom = occlusion.bottom(x);
        if (top >= bottom || wall_segment.inv_depth <= 0) continue;
        uint8_t cy = wire_screen_y(wall_segment.ceil_screen_y);
        uint8_t fy = wire_screen_y(wall_segment.floor_screen_y);
        if (cy >= top && cy < bottom) draw::wire_plot(framebuffer(), x, cy, color);
        if (fy > top && fy <= bottom) draw::wire_plot(framebuffer(), x, fy - 1, color);

        if (wall_segment.is_solid) {
            if (x == wall_segment.start_x || x + static_cast<int>(wall_segment.stride) >= wall_segment.end_x) {
                int y1 = math::max(top, static_cast<int>(cy));
                int y2 = math::min(bottom - 1, static_cast<int>(fy - 1));
                for (int y = y1; y <= y2; ++y) draw::wire_plot(framebuffer(), x, y, color);
            }
            occlusion.set_top(x, static_cast<uint8_t>(bottom));
        } else {
            uint8_t upper = wire_screen_y(wall_segment.upper_screen_y);
            uint8_t lower = wire_screen_y(wall_segment.lower_screen_y);
            if (wall_segment.draw_upper && upper >= top && upper < bottom) draw::wire_plot(framebuffer(), x, upper, color);
            if (wall_segment.draw_lower && lower >= top && lower < bottom) draw::wire_plot(framebuffer(), x, lower, color);
            if (x == wall_segment.start_x || x + static_cast<int>(wall_segment.stride) >= wall_segment.end_x) {
                if (wall_segment.draw_upper) {
                    int y1 = math::max(top, static_cast<int>(cy));
                    int y2 = math::min(bottom - 1, static_cast<int>(upper - 1));
                    for (int y = y1; y <= y2; y += 2) draw::wire_plot(framebuffer(), x, y, color);
                }
                if (wall_segment.draw_lower) {
                    int y1 = math::max(top, static_cast<int>(lower));
                    int y2 = math::min(bottom - 1, static_cast<int>(fy - 1));
                    for (int y = y1; y <= y2; y += 2) draw::wire_plot(framebuffer(), x, y, color);
                }
            }
            uint8_t new_top = static_cast<uint8_t>(math::clamp(math::max(top, math::max(static_cast<int>(cy), static_cast<int>(upper))), top, bottom));
            uint8_t new_bot = static_cast<uint8_t>(math::clamp(math::min(bottom, math::min(static_cast<int>(fy), static_cast<int>(lower))), static_cast<int>(new_top), bottom));
            occlusion.set_top(x, new_top);
            occlusion.set_bottom(x, new_bot);
        }
        for (unsigned k = 1; k < wall_segment.stride && x + static_cast<int>(k) < ViewWidth; ++k) {
            occlusion.set_top(x + static_cast<int>(k), occlusion.top(x));
            occlusion.set_bottom(x + static_cast<int>(k), occlusion.bottom(x));
        }
    }
}

void Renderer::render_columns(const World& world, const Map& map) {
    if (world.player.wireframe) {
        render_wire_columns();
        return;
    }
    for (int x = wall_segment.start_x; x < wall_segment.end_x; x += static_cast<int>(detail),
         wall_segment.inv_depth += wall_segment.inv_depth_step,
         wall_segment.tex_u_depth += wall_segment.tex_u_depth_step,
         wall_segment.ceil_screen_y += wall_segment.ceil_screen_step,
         wall_segment.floor_screen_y += wall_segment.floor_screen_step,
         wall_segment.upper_screen_y += wall_segment.upper_screen_step,
         wall_segment.lower_screen_y += wall_segment.lower_screen_step) {
        int top = occlusion.top(x);
        int bottom = occlusion.bottom(x);
        if (top >= bottom || wall_segment.inv_depth <= 0) continue;
        uint8_t cy = screen_y(wall_segment.ceil_screen_y);
        uint8_t fy = screen_y(wall_segment.floor_screen_y);
        plane_column(x, top, math::min(bottom - 1, cy - 1), static_cast<uint8_t>(wall_segment.front_sector | 128), world, map);
        plane_column(x, math::max(top, static_cast<int>(fy)), bottom - 1, static_cast<uint8_t>(wall_segment.front_sector), world, map);

        if (wall_segment.is_solid) {
            wall_column(x, math::max(top, static_cast<int>(cy)), math::min(bottom - 1, static_cast<int>(fy - 1)),
                        &wall_segment.middle, wall_segment.inv_depth, wall_segment.tex_u_depth,
                        static_cast<unsigned>(wall_segment.front_sector), map);
            occlusion.set_top(x, static_cast<uint8_t>(bottom));
        } else {
            uint8_t upper = screen_y(wall_segment.upper_screen_y);
            uint8_t lower = screen_y(wall_segment.lower_screen_y);
            if (wall_segment.back_ceiling_z < wall_segment.front_ceiling_z && !wall_segment.is_sky_portal) {
                wall_column(x, math::max(top, static_cast<int>(cy)), math::min(bottom - 1, static_cast<int>(upper - 1)),
                            &wall_segment.upper, wall_segment.inv_depth, wall_segment.tex_u_depth,
                            static_cast<unsigned>(wall_segment.front_sector), map);
            }
            if (wall_segment.back_floor_z > wall_segment.front_floor_z) {
                wall_column(x, math::max(top, static_cast<int>(lower)), math::min(bottom - 1, static_cast<int>(fy - 1)),
                            &wall_segment.lower, wall_segment.inv_depth, wall_segment.tex_u_depth,
                            static_cast<unsigned>(wall_segment.front_sector), map);
            }
            uint8_t new_top = static_cast<uint8_t>(math::clamp(math::max(top, math::max(static_cast<int>(cy), static_cast<int>(upper))), top, bottom));
            uint8_t new_bot = static_cast<uint8_t>(math::clamp(math::min(bottom, math::min(static_cast<int>(fy), static_cast<int>(lower))), static_cast<int>(new_top), bottom));
            occlusion.set_top(x, new_top);
            occlusion.set_bottom(x, new_bot);
        }
        for (unsigned k = 1; k < detail && x + static_cast<int>(k) < ViewWidth; ++k) {
            occlusion.set_top(x + static_cast<int>(k), occlusion.top(x));
            occlusion.set_bottom(x + static_cast<int>(k), occlusion.bottom(x));
        }
    }
}

int Renderer::height_product(int height, int inverse) {
    if (inverse >= -16384 && inverse <= 16383) return (height * inverse) >> 4;
    return static_cast<int>((static_cast<int32_t>(height) * inverse) >> 4);
}

bool Renderer::clip_seg_plane(int& r1, int& z1, int& u1, int& r2, int& z2, int& u2, int a1, int a2, bool do_u) {
    if (a1 < 0 && a2 < 0) return false;
    if (a1 >= 0 && a2 >= 0) return true;
    if (a1 < 0) {
        int den = a1 - a2;
        if (!den) return false;
        r1 += static_cast<int>(static_cast<int32_t>(r2 - r1) * a1 / den);
        z1 += static_cast<int>(static_cast<int32_t>(z2 - z1) * a1 / den);
        if (do_u) u1 += static_cast<int>(static_cast<int32_t>(u2 - u1) * a1 / den);
    } else {
        int den = a2 - a1;
        if (!den) return false;
        r2 += static_cast<int>(static_cast<int32_t>(r1 - r2) * a2 / den);
        z2 += static_cast<int>(static_cast<int32_t>(z1 - z2) * a2 / den);
        if (do_u) u2 += static_cast<int>(static_cast<int32_t>(u1 - u2) * a2 / den);
    }
    return true;
}

void Renderer::draw_seg(const Seg* seg, const Material* side, const World& world, const Map& map) {
    unsigned fs = side->sector;
    int bs = (side->back == 255) ? -1 : side->back;
    if (bs >= 0 && (side->flags & 128) &&
        world.sector_floor[fs] == world.sector_floor[bs] &&
        world.sector_ceiling[fs] == world.sector_ceiling[bs] &&
        side->middle == 255) {
        return;
    }

    int r1 = 0, z1 = 0, r2 = 0, z2 = 0;
    vertex(seg->v1, map, r1, z1);
    vertex(seg->v2, map, r2, z2);

    if (static_cast<int>(static_cast<unsigned>(r1) * z2 - static_cast<unsigned>(r2) * z1) >= 0 ||
        (z1 < NearZ && z2 < NearZ)) {
        return;
    }

    int u1 = 0, u2 = 0;
    bool do_u = !world.player.wireframe;
    if (do_u) {
        u1 = (side->x + seg->offset) & 1023;
        u2 = u1 + seg->length;
    }

    if (!clip_seg_plane(r1, z1, u1, r2, z2, u2, z1 - NearZ, z2 - NearZ, do_u)) return;
    if (!clip_seg_plane(r1, z1, u1, r2, z2, u2, r1 + z1, r2 + z2, do_u)) return;
    if (!clip_seg_plane(r1, z1, u1, r2, z2, u2, z1 - r1, z2 - r2, do_u)) return;

    int sx1 = math::screen_x(r1, z1), sx2 = math::screen_x(r2, z2);
    if (sx1 >= sx2 || sx2 <= 0 || sx1 >= ViewWidth) return;

    int start = math::max(0, sx1), end = math::min(ViewWidth, sx2);
    unsigned step = world.player.wireframe ? 1 : detail;
    if (step > 1) start = ((start + static_cast<int>(step) - 1) / static_cast<int>(step)) * static_cast<int>(step);

    while (start < end && occlusion.is_column_blocked(start)) start += static_cast<int>(step);
    while (end > start && occlusion.is_column_blocked(end - 1)) --end;
    if (start >= end) return;

    int iz1 = static_cast<int>(math::reciprocal(static_cast<unsigned>(z1)) >> 2);
    int iz2 = static_cast<int>(math::reciprocal(static_cast<unsigned>(z2)) >> 2);
    int span = sx2 - sx1;
    int diz = (iz2 - iz1) / span;
    int iz = iz1 + static_cast<int>(static_cast<int32_t>(iz2 - iz1) * (start - sx1) / span);

    int uz = 0, duz = 0;
    if (do_u) {
        int uz1 = static_cast<int>((static_cast<int32_t>(u1) * iz1) >> 4);
        int uz2 = static_cast<int>((static_cast<int32_t>(u2) * iz2) >> 4);
        duz = (uz2 - uz1) / span;
        uz = uz1 + static_cast<int>(static_cast<int32_t>(uz2 - uz1) * (start - sx1) / span);
    }

    int fceil = world.sector_ceiling[fs], ffloor = world.sector_floor[fs];
    bool skyportal = (bs >= 0 && (*map.sector_at(fs)).ceiltex == 255 && (*map.sector_at(bs)).ceiltex == 255);
    if (skyportal) fceil = world.sector_ceiling[bs];

    bool solid = (bs < 0 || world.sector_ceiling[bs] <= ffloor ||
                  world.sector_floor[bs] >= fceil || world.sector_ceiling[bs] <= world.sector_floor[bs]);

    int cyq = 40 * 256 - height_product(fceil - world.player.eye, iz);
    int fyq = 40 * 256 - height_product(ffloor - world.player.eye, iz);
    int cy_step = -height_product(fceil - world.player.eye, diz);
    int fy_step = -height_product(ffloor - world.player.eye, diz);

    int bceil = (bs < 0) ? fceil : static_cast<int>(world.sector_ceiling[bs]);
    int bfloor = (bs < 0) ? ffloor : static_cast<int>(world.sector_floor[bs]);
    int upperq = (bceil == fceil) ? cyq : (40 * 256 - height_product(bceil - world.player.eye, iz));
    int lowerq = (bfloor == ffloor) ? fyq : (40 * 256 - height_product(bfloor - world.player.eye, iz));
    int upper_step = (bceil == fceil) ? cy_step : -height_product(bceil - world.player.eye, diz);
    int lower_step = (bfloor == ffloor) ? fy_step : -height_product(bfloor - world.player.eye, diz);

    diz *= static_cast<int>(step);
    duz *= static_cast<int>(step);
    cy_step *= static_cast<int>(step);
    fy_step *= static_cast<int>(step);
    upper_step *= static_cast<int>(step);
    lower_step *= static_cast<int>(step);

    ++stats.segs;

    wall_segment = WallSegment{};
    wall_segment.start_x = start;
    wall_segment.end_x = end;
    wall_segment.inv_depth = iz;
    wall_segment.inv_depth_step = diz;
    wall_segment.tex_u_depth = uz;
    wall_segment.tex_u_depth_step = duz;
    wall_segment.ceil_screen_y = cyq;
    wall_segment.ceil_screen_step = cy_step;
    wall_segment.floor_screen_y = fyq;
    wall_segment.floor_screen_step = fy_step;
    wall_segment.upper_screen_y = upperq;
    wall_segment.upper_screen_step = upper_step;
    wall_segment.lower_screen_y = lowerq;
    wall_segment.lower_screen_step = lower_step;
    wall_segment.front_ceiling_z = fceil;
    wall_segment.front_floor_z = ffloor;
    wall_segment.back_ceiling_z = bceil;
    wall_segment.back_floor_z = bfloor;
    wall_segment.front_sector = static_cast<int>(fs);
    wall_segment.is_solid = solid;
    wall_segment.is_sky_portal = skyportal;
    wall_segment.material = side;
    wall_segment.draw_upper = static_cast<uint8_t>(bceil < fceil && !skyportal);
    wall_segment.draw_lower = static_cast<uint8_t>(bfloor > ffloor);
    wall_segment.stride = static_cast<uint8_t>(step);

    if (world.player.wireframe) {
        render_wire_columns();
        return;
    }

    if (solid) {
        unsigned tex = side->middle;
        if (tex == 255 && bs >= 0) tex = side->upper;
        if (tex == 255 && bs >= 0) tex = side->lower;
        int anchor = (tex != 255 && (side->flags & 16)) ? (ffloor + (1 << tile_info[tex][2])) : fceil;
        wall_segment.middle = make_wall_style(tex, anchor, side->y, world, map);
    } else {
        if (bceil < fceil && !skyportal) {
            int anchor = (side->flags & 8) ? fceil : (bceil + (side->upper == 255 ? 128 : (1 << tile_info[side->upper][2])));
            wall_segment.upper = make_wall_style(side->upper, anchor, side->y, world, map);
        }
        if (bfloor > ffloor) {
            int anchor = (side->flags & 16) ? fceil : bfloor;
            wall_segment.lower = make_wall_style(side->lower, anchor, side->y, world, map);
        }
    }

    render_columns(world, map);
}

void Renderer::render_bsp_node(unsigned index, unsigned depth, const World& world, const Map& map) {
    if (depth > stats.bsp_depth) stats.bsp_depth = static_cast<uint8_t>(depth);
    if (index & 0x8000u) {
        const Subsector* sub = &map.subsectors[index & 0x7fffu];
        ++stats.subsectors;
        const Seg* seg = map.segs + sub->first;
        const Material* side = map.materials + sub->first;
        for (unsigned i = sub->count; i; --i, ++seg, ++side) {
            draw_seg(seg, side, world, map);
        }
        return;
    }

    const Node* n = reinterpret_cast<const Node*>(reinterpret_cast<const uint8_t*>(map.nodes) + node_offsets[static_cast<uint8_t>(index)]);
    unsigned side;
    if (!n->dx) side = (camera.x() <= n->x) ? (n->dy > 0) : (n->dy < 0);
    else if (!n->dy) side = (camera.y() <= n->y) ? (n->dx < 0) : (n->dx > 0);
    else {
        int32_t left  = static_cast<int32_t>(camera.x() - n->x) * n->dy;
        int32_t right = static_cast<int32_t>(camera.y() - n->y) * n->dx;
        side = (right >= left);
    }

    render_bsp_node(n->child[side], depth + 1, world, map);
    if (bbox_visible(n->bbox[side ^ 1], index * 2 + (side ^ 1), map)) {
        render_bsp_node(n->child[side ^ 1], depth + 1, world, map);
    }
}

void Renderer::draw_planes(const World& world, const Map& map) {
    uint8_t* pixels = framebuffer();
    uint8_t* depths = depthbuffer;
    const uint8_t* cursor = planes;

    for (int y = 0; y < ViewHeight; ++y) {
        const uint8_t* row = cursor;
        const uint8_t* endrow = row + ViewWidth;
        while (cursor < endrow) {
            const uint8_t* begin = cursor;
            uint8_t plane = *cursor++;
            while (cursor < endrow && *cursor == plane) ++cursor;
            unsigned length = static_cast<unsigned>(cursor - begin);
            if (plane == 255) {
                pixels += length;
                depths += length;
                continue;
            }
            int x = static_cast<int>(begin - row);
            ++stats.plane_spans;
            unsigned sector = plane & 127;
            int ceiling = plane & 128;
            int texture = ceiling ? (*map.sector_at(sector)).ceiltex : (*map.sector_at(sector)).flat;

            if (texture == 255) {
                const uint8_t* sky = map.images[SKY_TILE];
                for (unsigned i = 0; i < length; ++i) {
                    pixels[i] = sky[(y * 24 / ViewHeight) * 32 + (((world.player.angle >> 3) + (x + static_cast<int>(i)) / 4) & 31)];
                }
                pixels += length;
                depths += length;
                continue;
            }

            int height = ceiling ? world.sector_ceiling[sector] : world.sector_floor[sector];
            int dy = CenterY - y;
            int z = dy ? (height - world.player.eye) * Focal / dy : 8192;
            z = math::clamp(z, 1, 8192);

            const uint8_t* light = lighting(map, sector, z);
            const uint8_t* image = map.images[texture];

            if (!world.player.texture_planes) {
                std::memset(pixels, light[image[16 * 32 + 16]], length);
                std::memset(depths, math::clamp(z / 16, 1, 254), length);
                pixels += length;
                depths += length;
                continue;
            }

            int stepx = (z * camera.sin()) >> 6, stepy = (-z * camera.cos()) >> 6;
            int wx = static_cast<int>(world.player.x) + z * camera.cos() + stepx * (x - 64);
            int wy = static_cast<int>(world.player.y) + z * camera.sin() + stepy * (x - 64);
            uint8_t depth = static_cast<uint8_t>(math::clamp(z / 16, 1, 254));

            if (detail == 4) {
                if (length >= 4) draw::span4(pixels, depths, image, light, length / 4, wx, wy, stepx * 4, stepy * 4, depth);
            } else if (detail == 3) {
                if (length >= 3) draw::span3(pixels, depths, image, light, length / 3, wx, wy, stepx * 3, stepy * 3, depth);
            } else if (detail == 2) {
                if (length >= 2) draw::span2(pixels, depths, image, light, length / 2, wx, wy, stepx * 2, stepy * 2, depth);
            } else {
                draw::span(pixels, depths, image, light, length, wx, wy, stepx, stepy, depth);
            }
            pixels += length;
            depths += length;
        }
    }
}

void Renderer::draw_sprites(const World& world, const Map& map) {
    unsigned count = 0;
    for (unsigned i = 0; i < NUM_ACTORS; ++i) {
        if (world.actors[i].removed) continue;
        int r = 0, z = 0;
        camera.transform(world.actors[i].x, world.actors[i].y, r, z);
        if (z < 8 || math::abs(r) > z + 64) continue;
        sprite_z[i] = static_cast<int16_t>(z);
        sprite_x[i] = static_cast<int16_t>(r);
        unsigned j = count;
        while (j && sprite_z[sprite_order[j - 1]] < z) {
            sprite_order[j] = sprite_order[j - 1];
            --j;
        }
        sprite_order[j] = static_cast<uint8_t>(i);
        ++count;
    }

    for (unsigned k = 0; k < count; ++k) {
        unsigned i = sprite_order[k];
        const MapActor* m = &map.actors[i];
        const Actor* a = &world.actors[i];
        int z = sprite_z[i], center = 64 + static_cast<int>(sprite_x[i]) * Focal / z;
        int width = math::max(1, static_cast<int>(m->width) * Focal / z);
        int hworld = static_cast<int>(m->height);
        bool exploding = (a->explode != 0);
        unsigned image;
        const uint8_t* light;

        if (exploding) {
            unsigned frame = math::min(static_cast<unsigned>(NUM_BARREL_EXP - 1), static_cast<unsigned>(a->explode - 1) / ExplodeTic);
            image = barrel_explode[frame];
            width = math::max(width, width * 5 / 4);
            hworld = math::max(hworld, hworld * 5 / 4);
            light = map.shade_rows[0];
        } else if (m->hp && a->die && a->die != 255) {
            uint8_t d = a->die;
            image = (d < 5) ? m->image : (d < 9) ? m->walk : m->death;
            int hcorp = math::max(1, hworld / 4);
            hworld = hworld - (hworld - hcorp) * static_cast<int>(d - 1) / (DeathTics - 1);
            light = map.shade_rows[0];
        } else if (m->hp && !a->hp) {
            image = m->death;
            hworld = math::max(1, hworld / 4);
            light = lighting(map, a->sector, z);
        } else if (a->pain) {
            image = m->walk;
            light = map.shade_rows[0];
        } else {
            image = (world.player.ticks & 8) ? m->walk : m->image;
            light = lighting(map, a->sector, z);
        }

        int height = math::max(1, hworld * Focal / z);
        int left   = center - width / 2;
        int bottom = camera.project_y(world.sector_floor[a->sector], z);
        int top    = bottom - height;

        const uint8_t* pix = map.images[image];
        uint8_t depth = static_cast<uint8_t>(math::clamp(z / 16, 1, 254));

        int x1 = math::max(0, left);
        int x2 = math::min(ViewWidth, left + width);
        int y1 = math::max(0, top);
        int y2 = math::min(ViewHeight, bottom);

        unsigned sxstep = (64u * 256) / width;
        unsigned systep = (64u * 256) / height;
        if (detail > 1) x1 = ((x1 + static_cast<int>(detail) - 1) / static_cast<int>(detail)) * static_cast<int>(detail);
        if (x1 >= x2 || y1 >= y2) continue;

        unsigned scount = static_cast<unsigned>(x2 - x1 + static_cast<int>(detail) - 1) / detail;
        if (!scount) continue;

        unsigned sxpos = static_cast<unsigned>(x1 - left) * sxstep;
        unsigned sypos = static_cast<unsigned>(y1 - top) * systep;
        unsigned offset = static_cast<unsigned>(y1 * ViewWidth + x1);

        for (int y = y1; y < y2; ++y, sypos += systep, offset += ViewWidth) {
            unsigned sy = math::min(63, static_cast<int>(sypos >> 8));
            draw::sprite(framebuffer() + offset, depthbuffer + offset, pix + sy * 64, light,
                         scount, sxpos, sxstep * detail, depth, detail);
        }
    }
}

void Renderer::draw_hud_weapon(const World& world) {
    unsigned frame = 0;
    if (world.player.fire) {
        if (world.player.fire > PistolFireAt) frame = 0;
        else if (world.player.fire > 9) frame = 1;
        else if (world.player.fire > 5) frame = 2;
        else frame = 1;
    }
    const uint8_t* gun = gun_frames[frame];
    int bob = (world.player.fire == 0) ? (math::isin((world.player.ticks * 16) & 1023) * 3 / 256) : 0;

    for (int y = 0; y < GUN_H; ++y) {
        int dest = GUN_Y + y + bob;
        if (dest < 0 || dest >= ViewHeight) continue;
        for (int x = 0; x < GUN_W; ++x) {
            uint8_t pixel = gun[y * GUN_W + x];
            if (pixel != 255) framebuffer()[dest * ViewWidth + GUN_X + x] = pixel;
        }
    }

    if (world.player.fire && world.player.fire <= PistolFireAt && world.player.fire > 9) {
        for (int y = 0; y < GUN_H; ++y) {
            int dest = GUN_Y + y + bob;
            if (dest < 0 || dest >= ViewHeight) continue;
            for (int x = 0; x < GUN_W; ++x) {
                uint8_t pixel = gun_flash[y * GUN_W + x];
                if (pixel != 255) framebuffer()[dest * ViewWidth + GUN_X + x] = pixel;
            }
        }
    }

    draw_crosshair();
}

void Renderer::draw_crosshair() {
    framebuffer()[39 * ViewWidth + 64] = 4;
    framebuffer()[41 * ViewWidth + 64] = 4;
    framebuffer()[40 * ViewWidth + 63] = 4;
    framebuffer()[40 * ViewWidth + 65] = 4;
}

void Renderer::apply_detail_replication() {
    if (detail == 4) {
        draw::quad_columns(framebuffer(), ViewWidth * ViewHeight / 4);
    } else if (detail == 3) {
        draw::triple_columns(framebuffer(), ViewHeight);
    } else if (detail == 2) {
        draw::double_columns(framebuffer(), ViewWidth * ViewHeight / 2);
    }
}

void Renderer::clear_buffers(const World& world) {
    std::memset(framebuffer(), 0, ViewWidth * ViewHeight);
    if (!world.player.wireframe) std::memset(depthbuffer, 255, sizeof(depthbuffer));
    if (world.player.texture_planes && !world.player.wireframe) std::memset(planes, 255, sizeof(planes));
    occlusion.clear();
}

void Renderer::advance_frame_stamp() {
    frame_stamp += 2;
    if (!frame_stamp) {
        std::memset(vertex_stamp, 0, sizeof(vertex_stamp));
        frame_stamp = 2;
    }
}

void Renderer::render(const World& world, const Map& map) {
    stats.reset();
    clear_buffers(world);
    camera.update(world.player);
    advance_frame_stamp();

    // Pass 1: Front-to-back BSP traversal and wall rasterization
    render_bsp_node(NUM_NODES - 1, 0, world, map);

    if (world.player.wireframe) {
        draw_crosshair();
        return;
    }

    // Pass 2: Floor and ceiling visplane rasterization
    if (world.player.texture_planes) {
        if (detail == 4) draw::quad_columns(planes, ViewWidth * ViewHeight / 4);
        else if (detail == 3) draw::triple_columns(planes, ViewHeight);
        else if (detail == 2) draw::double_columns(planes, ViewWidth * ViewHeight / 2);
        draw_planes(world, map);
    }

    // Pass 3: Depth-sorted billboard sprite rasterization
    draw_sprites(world, map);

    // Pass 4: Screen detail replication
    apply_detail_replication();

    // Pass 5: HUD weapon overlay and crosshair
    draw_hud_weapon(world);
}

} // namespace doom
