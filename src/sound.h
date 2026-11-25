#ifndef D84_SOUND_H
#define D84_SOUND_H

#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#if defined(__TICE__) && !defined(D84_DISABLE_AUDIO)
#include "doomvision_audio.h"
#endif

enum {
    SFX_NONE = 0,
    SFX_PISTOL = 1,
    SFX_PLDETH = 2,
    SFX_PLPAIN = 3,
    SFX_PODTH  = 4,
    SFX_POPAIN = 5,
    SFX_DOROPN = 6,
    SFX_SWTCHN = 7,
    SFX_ITEMUP = 8,
    SFX_BAREXP = 9,
    NUM_SFX = 10
};

extern uint16_t sound_active_mask;
extern uint8_t sound_sequence;
extern uint8_t sound_hold_frames[NUM_SFX];
extern uint8_t sound_music_active;
extern uint8_t sound_music_beat;
extern uint8_t sound_music_phase;
extern uint8_t sound_sfx_pitch;
extern uint8_t sound_sfx_pan;
extern uint8_t sound_sfx_vol;

static inline void sound_frame_step(void) {
#ifdef D84_DISABLE_AUDIO
    return;
#else
    uint16_t new_mask = 0;
    for (unsigned i = 1; i < NUM_SFX; ++i) {
        if (sound_hold_frames[i] > 0) {
            --sound_hold_frames[i];
            if (sound_hold_frames[i] > 0) {
                new_mask |= (uint16_t)(1u << (i - 1));
            }
        }
    }
    sound_active_mask = new_mask;
    sound_music_phase = (uint8_t)(sound_music_phase + 1);
#endif
}

static inline void sound_init(void) {
#ifdef D84_DISABLE_AUDIO
    return;
#else
    sound_active_mask = 0;
    sound_sequence = 0;
    sound_music_active = 1;
    sound_music_beat = 0;
    sound_music_phase = 0;
    sound_sfx_pitch = 7;
    sound_sfx_pan = 7;
    sound_sfx_vol = 15;
    memset(sound_hold_frames, 0, sizeof(sound_hold_frames));
#ifdef __TICE__
    dv_audio_init();
#endif
#endif
}

static inline void sound_trigger_ext(uint8_t sfx_id, uint8_t pan, uint8_t vol, uint8_t pitch) {
#if defined(__TICE__) && !defined(D84_DISABLE_AUDIO)
    dv_audio_trigger_ext(sfx_id, pan, vol, pitch);
#else
    (void)sfx_id; (void)pan; (void)vol; (void)pitch;
#endif
}

static inline void sound_trigger(uint8_t sfx_id) {
    sound_trigger_ext(sfx_id, 7, 15, 7);
}

static inline void sound_poll(void) {
#if defined(__TICE__) && !defined(D84_DISABLE_AUDIO)
    dv_audio_poll();
#endif
}

static inline void d84_audio_poll(void) {
    sound_poll();
}

static inline void sound_cleanup(void) {
#if defined(__TICE__) && !defined(D84_DISABLE_AUDIO)
    dv_audio_cleanup();
#endif
}

#endif /* D84_SOUND_H */
