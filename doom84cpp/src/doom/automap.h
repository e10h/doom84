#pragma once

#include "player.h"
#include "map.h"

namespace doom {

class Automap {
public:
    static constexpr int ViewY = 8;
    static constexpr int ViewHeightDst = 200;

    Automap() = default;

    static void draw(const Player& player, const Map& map);
};

} // namespace doom
