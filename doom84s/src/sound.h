#ifndef D84_SOUND_H
#define D84_SOUND_H

#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include "usb_audio.h"

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

/*
 * OPTICAL AUDIO CABLE - DUAL-LAYER HIGH-FIDELITY PROTOCOL
 *
 * Top two layers of pixels across 320x2 LCD:
 * - Scanline 0 (Layer 0, 40 cells / 320px): Primary Event & Trigger Layer
 * - Scanline 1 (Layer 1, 40 cells / 320px): High-Fidelity Acoustic, Spatial & Sync Layer
 *
 * Every single cell is strictly BOOLEAN: Pure White (1) or Pure Black (0).
 *
 * Layer 0 Layout (Scanline 0 - 40 bits / 5 bytes):
 * [0..3]:   Start Finder [1, 0, 1, 0]
 * [4..11]:  Sync Byte 0xA5 (10100101)
 * [12..19]: Master Sequence Counter (0..255)
 * [20..27]: SFX Trigger Mask Low (8 SFX: Pistol, Player Death, Player Pain, Zombie Death, Zombie Pain, Door, Switch, Item)
 * [28..31]: Status & Beat (Bit 0: BAREXP, Bit 1: MUSIC_ACTIVE, Bit 2: MUSIC_BEAT, Bit 3: 0)
 * [32..35]: Layer 0 XOR Checksum (4 bits)
 * [36..39]: End Finder [0, 1, 0, 1]
 *
 * Layer 1 Layout (Scanline 1 - 40 bits / 5 bytes):
 * [0..3]:   Start Finder [0, 1, 0, 1]  (Inverted from L0 for scanline discrimination)
 * [4..11]:  Sync Byte 0x5A (01011010)
 * [12..19]: Sub-Frame Music Phase Sync (0..255 fractional measure position)
 * [20..23]: SFX Pitch Shift Mod (0..15, 7=normal pitch, <7=lower, >7=higher)
 * [24..27]: SFX Stereo Pan (0..15, 0=hard left, 7=center, 15=hard right)
 * [28..31]: SFX Dynamic Volume (0..15, 15=100%, 12=75%, 8=50%, 4=25%)
 * [32..35]: Layer 1 XOR Checksum (4 bits)
 * [36..39]: End Finder [1, 0, 1, 0]
 */
#define OPTICAL_CELL_WIDTH   8
#define OPTICAL_NUM_CELLS    40
#define OPTICAL_TOTAL_WIDTH  (OPTICAL_CELL_WIDTH * OPTICAL_NUM_CELLS) /* 320 */

#define OPTICAL_SYNC_BYTE    0xA5
#define OPTICAL_SYNC1_BYTE   0x5A

/* Global optical sound state */
extern uint16_t sound_active_mask;
extern uint8_t sound_sequence;
extern uint8_t sound_hold_frames[NUM_SFX];
extern uint8_t sound_music_active;
extern uint8_t sound_music_beat;

/* Layer 1 High-Fidelity acoustic state */
extern uint8_t sound_music_phase;
extern uint8_t sound_sfx_pitch;   /* 0..15, default 7 */
extern uint8_t sound_sfx_pan;     /* 0..15, default 7 (center) */
extern uint8_t sound_sfx_vol;     /* 0..15, default 15 (max) */

static inline void sound_init(void) {
    sound_active_mask = 0;
    sound_sequence = 0;
    sound_music_active = 1;
    sound_music_beat = 0;
    sound_music_phase = 0;
    sound_sfx_pitch = 7;
    sound_sfx_pan = 7;
    sound_sfx_vol = 15;
    memset(sound_hold_frames, 0, sizeof(sound_hold_frames));
}

static inline void sound_trigger_ext(uint8_t sfx_id, uint8_t pan, uint8_t vol, uint8_t pitch) {
    if (sfx_id == SFX_NONE || sfx_id >= NUM_SFX) return;
    d84_audio_trigger(sfx_id,vol & 15,pitch & 15);
    sound_active_mask |= (uint16_t)(1u << (sfx_id - 1));
    /* Hold for 6 visual frames (~180ms) so camera and human eyes reliably capture it */
    sound_hold_frames[sfx_id] = 6;
    sound_sequence = (uint8_t)(sound_sequence + 1);
    sound_sfx_pan = pan & 0x0F;
    sound_sfx_vol = vol & 0x0F;
    sound_sfx_pitch = pitch & 0x0F;
}

static inline void sound_trigger(uint8_t sfx_id) {
    /* Default: center pan (7), full volume (15), standard pitch (7) */
    sound_trigger_ext(sfx_id, 7, 15, 7);
}

/* Step hold timers once per visual frame */
static inline void sound_frame_step(void) {
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
}

/*
 * Draw the dual-layer strictly BOOLEAN optical barcode on row0 and row1 (320x2 pixels).
 * row0 = Layer 0 (Primary Event Stream)
 * row1 = Layer 1 (High-Fidelity Acoustic, Spatial & Sync Stream)
 * Color 4 = Pure White, Color 0 = Pure Black.
 */
static inline void sound_draw_optical_stream(uint8_t *row0, uint8_t *row1,
                                            uint8_t white_col, uint8_t black_col) {
    uint8_t l0[OPTICAL_NUM_CELLS];
    uint8_t l1[OPTICAL_NUM_CELLS];

    /* --- LAYER 0: Primary Event & Trigger Stream --- */
    l0[0] = 1; l0[1] = 0; l0[2] = 1; l0[3] = 0; /* Start Finder: 1,0,1,0 */
    uint8_t sync0 = OPTICAL_SYNC_BYTE;
    for (int i = 0; i < 8; ++i) l0[4 + i] = (sync0 & (1 << (7 - i))) ? 1 : 0;
    uint8_t seq = sound_sequence;
    for (int i = 0; i < 8; ++i) l0[12 + i] = (seq & (1 << (7 - i))) ? 1 : 0;
    uint8_t sfx_low = (uint8_t)(sound_active_mask & 0xFF);
    for (int i = 0; i < 8; ++i) l0[20 + i] = (sfx_low & (1 << i)) ? 1 : 0;
    uint8_t barexp = (sound_active_mask & (1 << (SFX_BAREXP - 1))) ? 1 : 0;
    uint8_t status = (barexp) | (sound_music_active ? 2 : 0) | (sound_music_beat ? 4 : 0);
    l0[28] = (status & 1) ? 1 : 0;
    l0[29] = (status & 2) ? 1 : 0;
    l0[30] = (status & 4) ? 1 : 0;
    l0[31] = 0;
    uint8_t c0 = (sync0 ^ seq ^ sfx_low ^ status);
    uint8_t c0_4 = (c0 & 0x0F) ^ ((c0 >> 4) & 0x0F);
    for (int i = 0; i < 4; ++i) l0[32 + i] = (c0_4 & (1 << (3 - i))) ? 1 : 0;
    l0[36] = 0; l0[37] = 1; l0[38] = 0; l0[39] = 1; /* End Finder: 0,1,0,1 */

    /* --- LAYER 1: High-Fidelity Acoustic & Spatial Stream --- */
    l1[0] = 0; l1[1] = 1; l1[2] = 0; l1[3] = 1; /* Start Finder: 0,1,0,1 */
    uint8_t sync1 = OPTICAL_SYNC1_BYTE; /* 0x5A */
    for (int i = 0; i < 8; ++i) l1[4 + i] = (sync1 & (1 << (7 - i))) ? 1 : 0;
    uint8_t phase = sound_music_phase;
    for (int i = 0; i < 8; ++i) l1[12 + i] = (phase & (1 << (7 - i))) ? 1 : 0;
    uint8_t pitch = sound_sfx_pitch & 0x0F;
    for (int i = 0; i < 4; ++i) l1[20 + i] = (pitch & (1 << (3 - i))) ? 1 : 0;
    uint8_t pan = sound_sfx_pan & 0x0F;
    for (int i = 0; i < 4; ++i) l1[24 + i] = (pan & (1 << (3 - i))) ? 1 : 0;
    uint8_t vol = sound_sfx_vol & 0x0F;
    for (int i = 0; i < 4; ++i) l1[28 + i] = (vol & (1 << (3 - i))) ? 1 : 0;
    uint8_t c1 = (sync1 ^ phase ^ ((pitch << 4) | pan) ^ vol);
    uint8_t c1_4 = (c1 & 0x0F) ^ ((c1 >> 4) & 0x0F);
    for (int i = 0; i < 4; ++i) l1[32 + i] = (c1_4 & (1 << (3 - i))) ? 1 : 0;
    l1[36] = 1; l1[37] = 0; l1[38] = 1; l1[39] = 0; /* End Finder: 1,0,1,0 */

    /* Render Layer 0 into row 0 (320px) */
    if (row0) {
        for (int c_idx = 0; c_idx < OPTICAL_NUM_CELLS; ++c_idx) {
            uint8_t color = l0[c_idx] ? white_col : black_col;
            int px_start = c_idx * OPTICAL_CELL_WIDTH;
            for (int p = 0; p < OPTICAL_CELL_WIDTH; ++p) row0[px_start + p] = color;
        }
    }

    /* Render Layer 1 into row 1 (320px) */
    if (row1) {
        for (int c_idx = 0; c_idx < OPTICAL_NUM_CELLS; ++c_idx) {
            uint8_t color = l1[c_idx] ? white_col : black_col;
            int px_start = c_idx * OPTICAL_CELL_WIDTH;
            for (int p = 0; p < OPTICAL_CELL_WIDTH; ++p) row1[px_start + p] = color;
        }
    }
}

#endif /* D84_SOUND_H */
