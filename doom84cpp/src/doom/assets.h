#pragma once

#include "doom/map.h"
#include <cstdint>

namespace doom {

class AssetManager {
public:
    static AssetManager& Instance();

    bool load_all();

    const uint8_t* map_data() const;
    unsigned map_size() const;

    const uint8_t* const* banks() const;
    const unsigned* bank_lengths() const;

private:
    AssetManager();

    const uint8_t* map_data_ = nullptr;
    unsigned map_size_ = 0;

    const uint8_t* banks_[NUM_BANKS] = {};
    unsigned bank_lengths_[NUM_BANKS] = {};
};

} // namespace doom
