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

    if (kb_Data[7] & kb_Up)    current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::Forward));
    if (kb_Data[7] & kb_Down)  current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::Backward));
    if (kb_Data[7] & kb_Left)  current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::Left));
    if (kb_Data[7] & kb_Right) current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::Right));
    if (kb_Data[1] & kb_2nd)   current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::Fire));
    if (kb_Data[2] & kb_Math)  current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::Use));
    if (kb_Data[2] & kb_Alpha) current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::Run));
    if (kb_Data[1] & kb_Graph) current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::Automap));
    if (kb_Data[1] & kb_Window)current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::ToggleFlats));
    if (kb_Data[1] & kb_Trace) current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::ToggleDetail));
    if (kb_Data[1] & kb_Yequ)  current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::Pause));
    if (kb_Data[1] & kb_Zoom)  current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::Reset));
    if (kb_Data[6] & kb_Clear) current_keys_ |= static_cast<uint16_t>(1u << static_cast<uint8_t>(Key::Quit));
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
