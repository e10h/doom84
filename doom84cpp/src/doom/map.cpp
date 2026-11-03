#include "map.h"
#include "math.h"
#include "../geometry.h"
#include <cstring>

namespace doom {

static constexpr uint16_t s_row_offsets[ViewHeight] = {
    0,128,256,384,512,640,768,896,1024,1152,1280,1408,1536,1664,1792,1920,
    2048,2176,2304,2432,2560,2688,2816,2944,3072,3200,3328,3456,3584,3712,3840,3968,
    4096,4224,4352,4480,4608,4736,4864,4992,5120,5248,5376,5504,5632,5760,5888,6016,
    6144,6272,6400,6528,6656,6784,6912,7040,7168,7296,7424,7552,7680,7808,7936,8064,
    8192,8320,8448,8576,8704,8832,8960,9088,9216,9344,9472,9600,9728,9856,9984,10112
};

uint16_t Map::row_offset(uint8_t y) {
    return (y < ViewHeight) ? s_row_offsets[y] : 0;
}

const Sector* Map::sector_at(unsigned index) const {
    return reinterpret_cast<const Sector*>(reinterpret_cast<const uint8_t*>(sectors) + sector_offsets[index]);
}

bool Map::unpack(const uint8_t* map_blob, unsigned size, const uint8_t* const* banks, const unsigned* bank_sizes_in) {
    if (size != MAP_SIZE || std::memcmp(map_blob, "D84MAP01", 8) != 0 || std::memcmp(map_blob + 8, asset_id, 8) != 0) {
        return false;
    }
    for (unsigned i = 0; i < NUM_BANKS; ++i) {
        if (bank_sizes_in[i] != bank_sizes[i] || std::memcmp(banks[i], "D84TEX01", 8) != 0 || std::memcmp(banks[i] + 8, asset_id, 8) != 0) {
            return false;
        }
    }

    vertices    = reinterpret_cast<const Vertex*>(map_blob + OFF_VERTICES);
    lines       = reinterpret_cast<const Line*>(map_blob + OFF_LINES);
    sides       = reinterpret_cast<const Side*>(map_blob + OFF_SIDES);
    sectors     = reinterpret_cast<const Sector*>(map_blob + OFF_SECTORS);
    segs        = reinterpret_cast<const Seg*>(map_blob + OFF_SEGS);
    subsectors  = reinterpret_cast<const Subsector*>(map_blob + OFF_SUBSECTORS);
    nodes       = reinterpret_cast<const Node*>(map_blob + OFF_NODES);
    actors      = reinterpret_cast<const MapActor*>(map_blob + OFF_ACTORS);
    blockmap    = reinterpret_cast<const int16_t*>(map_blob + OFF_BLOCKMAP);
    palette     = map_blob + OFF_PALETTE;

    std::memcpy(ram_colormaps, map_blob + OFF_COLORMAP, sizeof(ram_colormaps));
    colormaps = ram_colormaps;
    for (unsigned i = 0; i < 32; ++i) {
        shade_rows[i] = colormaps + i * 256;
    }

    math::init_tables();

    for (unsigned i = 0; i < NUM_TILES; ++i) {
        images[i] = banks[tile_bank[i]] + tile_offset[i];
    }

    for (unsigned i = 0; i < NUM_SEGS; ++i) {
        const Seg* seg = &segs[i];
        const Line* line = &lines[seg->line];
        const Side* s = &sides[line->side[seg->side]];
        materials[i] = Material{
            s->sector,
            line->side[seg->side ^ 1] == 65535u ? static_cast<uint8_t>(255) : sides[line->side[seg->side ^ 1]].sector,
            s->middle,
            s->upper,
            s->lower,
            static_cast<uint8_t>(line->flags),
            s->x,
            s->y
        };
        Material* m = &materials[i];
        m->flags &= 127;
        if (m->back != 255) {
            const Sector* a = sector_at(m->sector);
            const Sector* b = sector_at(m->back);
            if (a->flat == b->flat && a->ceiltex == b->ceiltex && a->light == b->light) {
                m->flags |= 128;
            }
        }
    }

    // FAST-mode sky fill: mean RGB of the upper SKY1 band
    {
        const uint8_t* sky = images[SKY_TILE];
        unsigned long sr = 0, sg = 0, sb = 0, n = 0;
        for (unsigned y = 0; y < 6; ++y) {
            for (unsigned x = 0; x < 32; ++x, ++n) {
                const uint8_t* c = palette + sky[y * 32 + x] * 3;
                sr += c[0]; sg += c[1]; sb += c[2];
            }
        }
        sr /= n; sg /= n; sb /= n;
        unsigned best = sky[0], bestd = ~0u;
        for (unsigned i = 0; i < 256; ++i) {
            const uint8_t* c = palette + i * 3;
            int dr = static_cast<int>(c[0]) - static_cast<int>(sr);
            int dg = static_cast<int>(c[1]) - static_cast<int>(sg);
            int db = static_cast<int>(c[2]) - static_cast<int>(sb);
            unsigned d = static_cast<unsigned>(dr * dr + dg * dg + db * db);
            if (d < bestd) { bestd = d; best = i; }
        }
        sky_flat = static_cast<uint8_t>(best);
    }

    for (unsigned i = 0; i < NUM_SECTORS; ++i) {
        const Sector* s = sector_at(i);
        sector_shades[i] = static_cast<uint8_t>((255 - s->light) / 8);
        const uint8_t* light = colormaps + ((255 - s->light) / 8) * 256;
        plane_colors[i] = light[images[s->flat][528]];
        plane_colors[i + NUM_SECTORS] = s->ceiltex == 255 ? sky_flat : light[images[s->ceiltex][528]];
    }

    return true;
}

} // namespace doom
