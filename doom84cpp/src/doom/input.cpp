#include "doom/input.h"
#include "doom/types.h"

#ifdef __TICE__
#include <keypadc.h>
#endif

namespace doom {

Input& Input::Instance() {
    static Input instance;
    return instance;
}

Input::Input()
    : current_keys_(0)
    , previous_keys_(0) {
}

void Input::update() {
    previous_keys_ = current_keys_;
    current_keys_ = 0;

#ifdef __TICE__
    kb_Scan();

    auto set_key = [this](Key key, bool active) {
        if (active) {
            current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(key));
        }
    };

    set_key(Key::Forward,      (kb_Data[7] & kb_Up) != 0);
    set_key(Key::Backward,     (kb_Data[7] & kb_Down) != 0);
    set_key(Key::Left,         (kb_Data[7] & kb_Left) != 0);
    set_key(Key::Right,        (kb_Data[7] & kb_Right) != 0);
    set_key(Key::Fire,         (kb_Data[1] & kb_2nd) != 0);
    set_key(Key::Use,          (kb_Data[2] & kb_Math) != 0);
    set_key(Key::Run,          (kb_Data[2] & kb_Alpha) != 0);
    set_key(Key::Automap,      (kb_Data[1] & kb_Graph) != 0);
    set_key(Key::ToggleFlats,  (kb_Data[1] & kb_Window) != 0);
    set_key(Key::ToggleDetail, (kb_Data[1] & kb_Trace) != 0);
    set_key(Key::Pause,        (kb_Data[1] & kb_Yequ) != 0);
    set_key(Key::Reset,        (kb_Data[1] & kb_Zoom) != 0);
    set_key(Key::Quit,         (kb_Data[6] & kb_Clear) != 0);
#endif
}

bool Input::is_down(Key key) const {
    const uint16_t mask = static_cast<uint16_t>(1u << static_cast<uint8_t>(key));
    return (current_keys_ & mask) != 0;
}

bool Input::was_pressed(Key key) const {
    const uint16_t mask = static_cast<uint16_t>(1u << static_cast<uint8_t>(key));
    return ((current_keys_ & mask) != 0) && ((previous_keys_ & mask) == 0);
}

uint8_t Input::movement_bits() const {
    uint8_t result = 0;
    if (is_down(Key::Forward))  result |= InputMask::Forward;
    if (is_down(Key::Backward)) result |= InputMask::Back;
    if (is_down(Key::Left))     result |= InputMask::Left;
    if (is_down(Key::Right))    result |= InputMask::Right;
    if (is_down(Key::Fire))     result |= InputMask::Fire;
    if (is_down(Key::Use))      result |= InputMask::Use;
    if (is_down(Key::Run))      result |= InputMask::Run;
    return result;
}

} // namespace doom
