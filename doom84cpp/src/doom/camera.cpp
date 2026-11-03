#include "doom/camera.h"
#include "doom/math.h"
#include "doom/types.h"

namespace doom {

Camera::Camera()
    : x_(0)
    , y_(0)
    , eye_(0)
    , angle_(0)
    , cos_(0)
    , sin_(0) {
}

void Camera::update(const Player& player) {
    x_     = player.world_x();
    y_     = player.world_y();
    eye_   = player.eye;
    angle_ = player.angle;
    cos_   = math::icos(player.angle);
    sin_   = math::isin(player.angle);
}

void Camera::transform(int world_x, int world_y, int& out_side, int& out_depth) const {
    int dx = world_x - x_;
    int dy = world_y - y_;
    out_side  = math::shr8(dx * sin_ - dy * cos_);
    out_depth = math::shr8(dx * cos_ + dy * sin_);
}

int Camera::project_x(int side, int depth) const {
    return math::screen_x(side, depth);
}

int Camera::project_y(int world_z, int depth) const {
    return CenterY - (world_z - eye_) * Focal / depth;
}

int Camera::x() const {
    return x_;
}

int Camera::y() const {
    return y_;
}

int Camera::eye() const {
    return eye_;
}

int Camera::angle() const {
    return angle_;
}

int Camera::cos() const {
    return cos_;
}

int Camera::sin() const {
    return sin_;
}

} // namespace doom
