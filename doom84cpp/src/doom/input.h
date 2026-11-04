#pragma once

#include <cstdint>

namespace doom {

enum class Key : uint8_t {
    Forward,
    Backward,
    Left,
    Right,
    Fire,
    Use,
    Run,
    Automap,
    ToggleFlats,
    ToggleDetail,
    Pause,
    Reset,
    Quit,
    Count
};

class Input {
public:
    static Input& Instance();

    void update();
    bool is_down(Key key) const;
    bool was_pressed(Key key) const;
    uint8_t movement_bits() const;

private:
    Input();

    uint16_t current_keys_ = 0;
    uint16_t previous_keys_ = 0;
};

} // namespace doom
