#pragma once

#include "types.h"
#include "../generated.h"
#include <cstdint>

namespace doom {

class Map {
public:
    const Vertex*   vertices = nullptr;
    const Line*     lines = nullptr;
    const Sector*   sectors = nullptr;
    const uint8_t*  palette = nullptr;
    const Side*     sides = nullptr;
    const Seg*      segs = nullptr;
    const Subsector* subsectors = nullptr;
    const Node*     nodes = nullptr;
    const MapActor* actors = nullptr;
    const int16_t*  blockmap = nullptr;
    const uint8_t*  colormaps = nullptr;
    const uint8_t*  images[NUM_TILES]{};

    alignas(256) uint8_t ram_colormaps[32 * 256]{};
    Material        materials[NUM_SEGS]{};
    uint8_t         sector_shades[NUM_SECTORS]{};
    const uint8_t*  shade_rows[32]{};
    uint8_t         plane_colors[NUM_SECTORS * 2]{};
    uint8_t         sky_flat = 0;

    Map() = default;

    bool unpack(const uint8_t* map_blob, unsigned size, const uint8_t* const* banks, const unsigned* bank_sizes_in);
    const Sector* sector_at(unsigned index) const;
    static uint16_t row_offset(uint8_t y);
};

} // namespace doom
