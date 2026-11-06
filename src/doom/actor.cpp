#include "actor.h"

namespace doom {

void Actor::reset(int16_t x_, int16_t y_, uint8_t hp_) {
    x = x_;
    y = y_;
    sector = 0;
    hp = hp_;
    removed = 0;
    cooldown = 0;
    explode = 0;
    pain = 0;
    die = 0;
}

bool Actor::is_alive() const {
    return hp > 0 && !removed && !explode && !die;
}

} // namespace doom
