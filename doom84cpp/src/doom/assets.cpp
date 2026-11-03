#include "doom/assets.h"
#include "generated.h"

#ifdef __TICE__
#include <fileioc.h>
#endif

namespace doom {

namespace {

#ifdef __TICE__
const uint8_t* open_appvar(const char* name, unsigned expected, unsigned* length) {
    uint8_t handle = ti_Open(name, "r");
    if (!handle) return nullptr;

    const uint8_t* data = nullptr;
    *length = ti_GetSize(handle);
    if (*length == expected && ti_IsArchived(handle)) {
        data = reinterpret_cast<const uint8_t*>(ti_GetDataPtr(handle));
    }
    ti_Close(handle);
    return data;
}
#endif

} // namespace

AssetManager& AssetManager::Instance() {
    static AssetManager instance;
    return instance;
}

AssetManager::AssetManager() {
    for (unsigned i = 0; i < NUM_BANKS; ++i) {
        banks_[i] = nullptr;
        bank_lengths_[i] = 0;
    }
}

bool AssetManager::load_all() {
#ifdef __TICE__
    map_data_ = open_appvar("D84MAP", MAP_SIZE, &map_size_);
    if (!map_data_) return false;

    for (unsigned i = 0; i < NUM_BANKS; ++i) {
        char name[] = "D84T0";
        name[4] = static_cast<char>('0' + i);
        banks_[i] = open_appvar(name, bank_sizes[i], &bank_lengths_[i]);
        if (!banks_[i]) return false;
    }
    return true;
#else
    return false;
#endif
}

const uint8_t* AssetManager::map_data() const {
    return map_data_;
}

unsigned AssetManager::map_size() const {
    return map_size_;
}

const uint8_t* const* AssetManager::banks() const {
    return banks_;
}

const unsigned* AssetManager::bank_lengths() const {
    return bank_lengths_;
}

} // namespace doom
