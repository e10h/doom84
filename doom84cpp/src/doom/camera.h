#pragma once

#include "doom/player.h"

namespace doom {

class Camera {
public:
    Camera();

    void update(const Player& player);

    void transform(int world_x, int world_y, int& out_side, int& out_depth) const;

    int project_x(int side, int depth) const;
    int project_y(int world_z, int depth) const;

    int x() const;
    int y() const;
    int eye() const;
    int angle() const;
    int cos() const;
    int sin() const;

private:
    int x_ = 0;
    int y_ = 0;
    int eye_ = 0;
    int angle_ = 0;
    int cos_ = 0;
    int sin_ = 0;
};

} // namespace doom
