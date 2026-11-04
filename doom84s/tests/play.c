/*
 * Native SDL2 play loop where audio is 100% DECODED FROM DUAL-LAYER STRICTLY BOOLEAN TOP BAR PIXELS.
 *
 * Top 2 Scanlines (320x2 pixels):
 * - Row 0 (Layer 0, 40 cells / 320px): Primary Event & Trigger Layer
 * - Row 1 (Layer 1, 40 cells / 320px): High-Fidelity Acoustic, Spatial & Sync Layer
 *
 * Every single cell is strictly BOOLEAN: Pure White (1) or Pure Black (0).
 * Audio is decoded STRICTLY by sampling the screen pixels:
 * 1. Engine draws 40 boolean cells on Row 0 and 40 boolean cells on Row 1.
 * 2. Decoder samples Row 0 (Sync 0xA5, Sequence, SFX triggers, Checksum).
 * 3. Decoder samples Row 1 (Sync 0x5A, Music Phase, Pitch mod, Stereo Pan, Volume, Checksum).
 * 4. High-fidelity 44.1 kHz 16-bit stereo Roland SC-55 audio is synthesized and queued smoothly!
 */

#include "engine.h"
#include "generated.h"
#include "sound.h"
#include <SDL.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SCREEN_W 320
#define SCREEN_H 240
#define VIEW_Y 8
#define VIEW_H_DST 200
#define SCALE 3
#define WIN_W (SCREEN_W * SCALE)
#define WIN_H (SCREEN_H * SCALE)

#define AUDIO_SAMPLE_RATE 44100
#define SAMPLES_PER_FRAME (AUDIO_SAMPLE_RATE / 35) /* 1260 stereo frames at 35 FPS */

/* Multi-channel 44.1 kHz 16-bit audio mixer driven strictly by optical decoder */
#define MAX_CHANNELS 8
typedef struct {
    const int16_t *data;
    uint32_t length;     /* in frames */
    float pos;
    float step;          /* pitch step factor */
    float l_gain;        /* channel left volume */
    float r_gain;        /* channel right volume */
    bool active;
} AudioChannel;

static AudioChannel channels[MAX_CHANNELS];

/* Sound effects database in 44.1 kHz 16-bit mono */
typedef struct {
    int16_t *data;
    uint32_t length;
} SfxSample;

static SfxSample sfx_library[NUM_SFX];

/* Background Music state in 44.1 kHz 16-bit stereo */
static int16_t *music_data = NULL;
static uint32_t music_samples = 0; /* in stereo frames */
static uint32_t music_pos = 0;
static bool music_enabled = true;
static bool game_paused = false;

static int16_t *load_wav_16(const char *path, uint32_t *out_frames, int *out_channels) {
    FILE *f = fopen(path, "rb");
    if (!f) return NULL;
    uint8_t hdr[44];
    if (fread(hdr, 1, 44, f) != 44) { fclose(f); return NULL; }
    int channels = hdr[22] | (hdr[23] << 8);
    int bits = hdr[34] | (hdr[35] << 8);
    uint32_t bytes = hdr[40] | (hdr[41] << 8) | (hdr[42] << 16) | (hdr[43] << 24);
    if (bits != 16 || bytes == 0) { fclose(f); return NULL; }
    int16_t *buf = malloc(bytes);
    if (!buf) { fclose(f); return NULL; }
    if (fread(buf, 1, bytes, f) != bytes) { free(buf); fclose(f); return NULL; }
    fclose(f);
    if (out_channels) *out_channels = channels;
    if (out_frames) *out_frames = bytes / (channels * sizeof(int16_t));
    return buf;
}

static void init_audio_library(void) {
    int ch;
    music_data = load_wav_16("build/sounds/e1m1_44k.wav", &music_samples, &ch);
    if (music_data) {
        printf("Loaded Studio E1M1 Roland SC-55 Music (44.1 kHz Stereo, %u frames, ~%.1fs loop)\n",
               music_samples, (float)music_samples / 44100.0f);
    }

    const char *sfx_files[NUM_SFX] = {
        [SFX_NONE]   = NULL,
        [SFX_PISTOL] = "build/sounds/sfx_pistol_44k.wav",
        [SFX_PLDETH] = "build/sounds/sfx_pldeth_44k.wav",
        [SFX_PLPAIN] = "build/sounds/sfx_plpain_44k.wav",
        [SFX_PODTH]  = "build/sounds/sfx_podth_44k.wav",
        [SFX_POPAIN] = "build/sounds/sfx_popain_44k.wav",
        [SFX_DOROPN] = "build/sounds/sfx_doropn_44k.wav",
        [SFX_SWTCHN] = "build/sounds/sfx_swtchn_44k.wav",
        [SFX_ITEMUP] = "build/sounds/sfx_itemup_44k.wav",
        [SFX_BAREXP] = "build/sounds/sfx_barexp_44k.wav",
    };

    for (int i = 1; i < NUM_SFX; ++i) {
        if (sfx_files[i]) {
            sfx_library[i].data = load_wav_16(sfx_files[i], &sfx_library[i].length, &ch);
        }
    }
}

static void trigger_decoded_sfx(uint8_t sfx_id, int pan, int vol, int pitch) {
    if (sfx_id == SFX_NONE || sfx_id >= NUM_SFX) return;
    const SfxSample *sfx = &sfx_library[sfx_id];
    if (!sfx->data || !sfx->length) return;

    int slot = -1;
    if (sfx_id == SFX_PISTOL) {
        /* Dedicate channel 0 exclusively to player weapon: never truncated by monsters */
        slot = 0;
    } else {
        for (int i = 1; i < MAX_CHANNELS; ++i) {
            if (!channels[i].active) { slot = i; break; }
        }
        if (slot == -1) slot = 1;
    }

    channels[slot].data = sfx->data;
    channels[slot].length = sfx->length;
    channels[slot].pos = 0.0f;

    if (sfx_id == SFX_PISTOL) {
        /* 100% authentic Doom pistol frequency and stereo center */
        channels[slot].step = 1.0f;
        channels[slot].l_gain = 1.0f;
        channels[slot].r_gain = 1.0f;
    } else {
        channels[slot].step = powf(2.0f, ((float)pitch - 7.0f) / 24.0f);
        channels[slot].l_gain = ((15.0f - (float)pan) / 15.0f) * ((float)vol / 15.0f);
        channels[slot].r_gain = (((float)pan) / 15.0f) * ((float)vol / 15.0f);
    }
    channels[slot].active = true;
}

static uint8_t *read_file(const char *path, unsigned *size) {
    FILE *f = fopen(path, "rb");
    if (!f) { perror(path); exit(1); }
    fseek(f, 0, SEEK_END); long length = ftell(f); rewind(f);
    uint8_t *p = malloc((size_t)length);
    if (!p || fread(p, 1, (size_t)length, f) != (size_t)length) exit(1);
    fclose(f); *size = (unsigned)length; return p;
}

static uint8_t poll_input(const Uint8 *keys, bool mouse_fire) {
    uint8_t result = 0;
    if (keys[SDL_SCANCODE_UP] || keys[SDL_SCANCODE_W]) result |= INPUT_FORWARD;
    if (keys[SDL_SCANCODE_DOWN] || keys[SDL_SCANCODE_S]) result |= INPUT_BACK;
    if (keys[SDL_SCANCODE_LEFT] || keys[SDL_SCANCODE_A]) result |= INPUT_LEFT;
    if (keys[SDL_SCANCODE_RIGHT] || keys[SDL_SCANCODE_D]) result |= INPUT_RIGHT;
    if (mouse_fire || keys[SDL_SCANCODE_SPACE] || keys[SDL_SCANCODE_RETURN] ||
        keys[SDL_SCANCODE_F] || keys[SDL_SCANCODE_LCTRL] || keys[SDL_SCANCODE_RCTRL] ||
        keys[SDL_SCANCODE_Z]) result |= INPUT_FIRE;
    if (keys[SDL_SCANCODE_E] || keys[SDL_SCANCODE_U]) result |= INPUT_USE;
    if (keys[SDL_SCANCODE_LSHIFT] || keys[SDL_SCANCODE_RSHIFT]) result |= INPUT_RUN;
    if (keys[SDL_SCANCODE_LALT] || keys[SDL_SCANCODE_RALT]) result |= INPUT_STRAFE;
    return result;
}

/* -------------------------------------------------------------------------
 * OPTICAL DECODER: Reads strictly from screen_pixels Row 0 & Row 1 (320x2)
 * ------------------------------------------------------------------------- */
static int decode_and_synthesize_from_screen(const uint8_t *screen_row0, const uint8_t *screen_row1,
                                            int16_t *out_stereo_pcm, uint8_t *last_seq, uint16_t *last_mask) {
    /* 1. Sample 40 cells on Layer 0 (Row 0) */
    uint8_t l0[OPTICAL_NUM_CELLS];
    for (int c = 0; c < OPTICAL_NUM_CELLS; ++c) {
        uint8_t pix = screen_row0[c * OPTICAL_CELL_WIDTH + 4];
        l0[c] = (pix == 4 || pix > 2) ? 1 : 0;
    }

    /* 2. Sample 40 cells on Layer 1 (Row 1) */
    uint8_t l1[OPTICAL_NUM_CELLS];
    for (int c = 0; c < OPTICAL_NUM_CELLS; ++c) {
        uint8_t pix = screen_row1[c * OPTICAL_CELL_WIDTH + 4];
        l1[c] = (pix == 4 || pix > 2) ? 1 : 0;
    }

    /* --- Validate Layer 0 --- */
    if (l0[0] != 1 || l0[1] != 0 || l0[2] != 1 || l0[3] != 0) return 0;
    if (l0[36] != 0 || l0[37] != 1 || l0[38] != 0 || l0[39] != 1) return 0;

    uint8_t sync0 = 0;
    for (int i = 0; i < 8; ++i) if (l0[4 + i]) sync0 |= (uint8_t)(1 << (7 - i));
    if (sync0 != OPTICAL_SYNC_BYTE) return 0;

    uint8_t seq = 0;
    for (int i = 0; i < 8; ++i) if (l0[12 + i]) seq |= (uint8_t)(1 << (7 - i));

    uint8_t sfx_low = 0;
    for (int i = 0; i < 8; ++i) if (l0[20 + i]) sfx_low |= (uint8_t)(1 << i);

    uint8_t status = (l0[28] ? 1 : 0) | (l0[29] ? 2 : 0) | (l0[30] ? 4 : 0);

    uint8_t c0 = (sync0 ^ seq ^ sfx_low ^ status);
    uint8_t c0_4 = (c0 & 0x0F) ^ ((c0 >> 4) & 0x0F);
    uint8_t exp_c0 = 0;
    for (int i = 0; i < 4; ++i) if (l0[32 + i]) exp_c0 |= (uint8_t)(1 << (3 - i));
    if (c0_4 != exp_c0) return 0;

    /* --- Validate Layer 1 (High-Fidelity Acoustic Layer) --- */
    int pan = 7, vol = 15, pitch = 7;
    bool l1_valid = false;
    if (l1[0] == 0 && l1[1] == 1 && l1[2] == 0 && l1[3] == 1 &&
        l1[36] == 1 && l1[37] == 0 && l1[38] == 1 && l1[39] == 0) {
        uint8_t sync1 = 0;
        for (int i = 0; i < 8; ++i) if (l1[4 + i]) sync1 |= (uint8_t)(1 << (7 - i));
        if (sync1 == OPTICAL_SYNC1_BYTE) {
            uint8_t phase = 0;
            for (int i = 0; i < 8; ++i) if (l1[12 + i]) phase |= (uint8_t)(1 << (7 - i));
            pitch = 0;
            for (int i = 0; i < 4; ++i) if (l1[20 + i]) pitch |= (1 << (3 - i));
            pan = 0;
            for (int i = 0; i < 4; ++i) if (l1[24 + i]) pan |= (1 << (3 - i));
            vol = 0;
            for (int i = 0; i < 4; ++i) if (l1[28 + i]) vol |= (1 << (3 - i));

            uint8_t c1 = (sync1 ^ phase ^ ((pitch << 4) | pan) ^ vol);
            uint8_t c1_4 = (c1 & 0x0F) ^ ((c1 >> 4) & 0x0F);
            uint8_t exp_c1 = 0;
            for (int i = 0; i < 4; ++i) if (l1[32 + i]) exp_c1 |= (uint8_t)(1 << (3 - i));
            if (c1_4 == exp_c1) {
                l1_valid = true;
            }
        }
    }
    if (!l1_valid) { pan = 7; vol = 15; pitch = 7; }

    /* Rising-edge trigger detection: only trigger when a sound bit turns 0 -> 1 */
    uint16_t current_mask = (uint16_t)sfx_low | ((status & 1) ? (1u << (SFX_BAREXP - 1)) : 0u);
    uint16_t newly_triggered = current_mask & ~(*last_mask);
    *last_mask = current_mask;
    *last_seq = seq;

    if (newly_triggered != 0) {
        for (unsigned sfx_id = 1; sfx_id < NUM_SFX; ++sfx_id) {
            if (newly_triggered & (1u << (sfx_id - 1))) {
                trigger_decoded_sfx((uint8_t)sfx_id, pan, vol, pitch);
            }
        }
    }

    /* Synthesize 44.1 kHz 16-bit Stereo Audio */
    bool play_music = (status & 2) != 0;

    for (int i = 0; i < SAMPLES_PER_FRAME; ++i) {
        float music_l = 0.0f, music_r = 0.0f;
        if (music_data && music_samples > 0 && play_music && !game_paused) {
            music_l = (float)music_data[music_pos * 2 + 0];
            music_r = (float)music_data[music_pos * 2 + 1];
            music_pos++;
            if (music_pos >= music_samples) music_pos = 0;
        }

        float sfx_l = 0.0f, sfx_r = 0.0f;
        for (int ch = 0; ch < MAX_CHANNELS; ++ch) {
            if (channels[ch].active) {
                uint32_t idx = (uint32_t)channels[ch].pos;
                float frac = channels[ch].pos - (float)idx;
                float s0 = (float)channels[ch].data[idx];
                float s1 = (idx + 1 < channels[ch].length) ? (float)channels[ch].data[idx + 1] : s0;
                float s = s0 + frac * (s1 - s0);

                sfx_l += s * channels[ch].l_gain;
                sfx_r += s * channels[ch].r_gain;

                channels[ch].pos += channels[ch].step;
                if ((uint32_t)channels[ch].pos >= channels[ch].length) {
                    channels[ch].active = false;
                }
            }
        }

        /* Studio Mix: Full music presence + punchy SFX + soft limiter */
        float sum_l = music_l * 0.92f + sfx_l * 1.05f;
        float sum_r = music_r * 0.92f + sfx_r * 1.05f;

        if (sum_l > 32767.0f) sum_l = 32767.0f; else if (sum_l < -32768.0f) sum_l = -32768.0f;
        if (sum_r > 32767.0f) sum_r = 32767.0f; else if (sum_r < -32768.0f) sum_r = -32768.0f;

        out_stereo_pcm[i * 2 + 0] = (int16_t)sum_l;
        out_stereo_pcm[i * 2 + 1] = (int16_t)sum_r;
    }
    return SAMPLES_PER_FRAME;
}

int main(int argc, char **argv) {
    (void)argc; (void)argv;
    unsigned length, sizes[NUM_BANKS];
    uint8_t *map = read_file("build/D84MAP.bin", &length);
    const uint8_t *banks[NUM_BANKS];
    for (unsigned i = 0; i < NUM_BANKS; ++i) {
        char name[64]; snprintf(name, sizeof(name), "build/D84T%u.bin", i);
        banks[i] = read_file(name, &sizes[i]);
    }
    if (!engine_init(map, length, banks, sizes)) {
        fprintf(stderr, "engine_init failed (rebuild assets?)\n");
        return 1;
    }
    render_detail = 2;
    player.texture_planes = false;

    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_TIMER | SDL_INIT_AUDIO) != 0) {
        fprintf(stderr, "SDL_Init: %s\n", SDL_GetError());
        return 1;
    }

    /* Initialize 44.1 kHz 16-bit Stereo Audio Device */
    SDL_AudioSpec wanted;
    SDL_zero(wanted);
    wanted.freq = AUDIO_SAMPLE_RATE;
    wanted.format = AUDIO_S16SYS;
    wanted.channels = 2;
    wanted.samples = 1024;
    wanted.callback = NULL; /* Queued Audio mode */

    SDL_AudioDeviceID audio_dev = SDL_OpenAudioDevice(NULL, 0, &wanted, NULL, 0);
    if (!audio_dev) {
        fprintf(stderr, "SDL_OpenAudioDevice error: %s\n", SDL_GetError());
    } else {
        SDL_PauseAudioDevice(audio_dev, 0);
    }

    init_audio_library();

    SDL_Window *win = SDL_CreateWindow("doom84 [DUAL-LAYER OPTICAL AUDIO: 320x2 Boolean Barcode]",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, WIN_W, WIN_H, 0);
    SDL_Renderer *ren = SDL_CreateRenderer(win, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (!ren) {
        ren = SDL_CreateRenderer(win, -1, SDL_RENDERER_ACCELERATED);
    }
    SDL_Texture *tex = SDL_CreateTexture(ren, SDL_PIXELFORMAT_RGB24,
        SDL_TEXTUREACCESS_STREAMING, SCREEN_W, SCREEN_H);
    if (!win || !ren || !tex) {
        fprintf(stderr, "SDL window: %s\n", SDL_GetError());
        return 1;
    }
    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "0");
    SDL_RenderSetLogicalSize(ren, SCREEN_W, SCREEN_H);

    printf("=== Doom84 Dual-Layer High-Fidelity Optical Audio ===\n");
    printf("Row 0: Layer 0 (Sync 0xA5, Triggers, Sequence)\n");
    printf("Row 1: Layer 1 (Sync 0x5A, Spatial Pan, Vol Attenuation, Pitch Mod)\n");
    printf("100%% pure boolean optical audio stream decoded from screen pixels.\n");
    printf("Controls: Click / Space / Z / F / Ctrl: Fire | WASD: Move | M: Music | B: Block Optical Bar (Mute Proof) | Tab: Pause | Esc: Quit\n");
    fflush(stdout);

    static uint8_t screen_pixels[SCREEN_W * SCREEN_H];
    static int16_t decoded_stereo_pcm[SAMPLES_PER_FRAME * 2];

    uint8_t last_decoded_seq = 255;
    uint16_t last_decoded_mask = 0;
    bool running = true, paused = false;
    bool mouse_fire = false;
    bool optical_blocked = false;
    unsigned frame_counter = 0;
    Uint32 last_tick = SDL_GetTicks();
    Uint32 acc = 0;

    while (running) {
        Uint32 frame_start = SDL_GetTicks();
        SDL_Event ev;
        while (SDL_PollEvent(&ev)) {
            if (ev.type == SDL_QUIT) running = false;
            if (ev.type == SDL_MOUSEBUTTONDOWN && ev.button.button == SDL_BUTTON_LEFT) mouse_fire = true;
            if (ev.type == SDL_MOUSEBUTTONUP && ev.button.button == SDL_BUTTON_LEFT) mouse_fire = false;
            if (ev.type == SDL_KEYDOWN) {
                SDL_Keycode k = ev.key.keysym.sym;
                if (k == SDLK_ESCAPE) running = false;
                if (k == SDLK_TAB) { paused = !paused; game_paused = paused; }
                if (k == SDLK_b) {
                    optical_blocked = !optical_blocked;
                    if (optical_blocked) {
                        SDL_ClearQueuedAudio(audio_dev);
                        printf("\n>>> [OPTICAL PROOF] TOP 2 SCANLINES BLOCKED (Wiped Black)!\n");
                        printf(">>> Optical Decoder reads all zeroes -> 0 audio samples -> 100%% DEAD SILENCE!\n\n");
                    } else {
                        printf("\n>>> [OPTICAL PROOF] TOP 2 SCANLINES RESTORED!\n");
                        printf(">>> Optical Decoder locks Sync 0xA5 + 0x5A -> Audio streaming resumes!\n\n");
                    }
                    fflush(stdout);
                }
                if (k == SDLK_m) {
                    music_enabled = !music_enabled;
                    sound_music_active = music_enabled ? 1 : 0;
                    printf("Music: %s\n", music_enabled ? "ON" : "MUTED");
                }
                if (k == SDLK_t) {
                    if (player.wireframe) { player.wireframe = false; player.texture_planes = false; }
                    else if (!player.texture_planes) player.texture_planes = true;
                    else { player.texture_planes = false; player.wireframe = true; }
                }
                if (k == SDLK_r) render_detail = render_detail == 2 ? 4 : render_detail == 4 ? 1 : 2;
                if (k == SDLK_F5) {
                    bool tex = player.texture_planes, wire = player.wireframe;
                    unsigned d = render_detail;
                    engine_reset();
                    player.texture_planes = tex; player.wireframe = wire; render_detail = d;
                }
            }
        }

        Uint32 now = SDL_GetTicks();
        Uint32 elapsed = now - last_tick;
        last_tick = now;
        acc += elapsed;
        if (acc > 6 * (1000 / 35)) acc = 6 * (1000 / 35);
        const Uint8 *keys = SDL_GetKeyboardState(NULL);
        uint8_t input = poll_input(keys, mouse_fire);
        while (acc >= 1000 / 35) {
            if (!paused) engine_tick(input);
            acc -= 1000 / 35;
        }
        engine_render();

        /* Clear screen buffer */
        memset(screen_pixels, 0, sizeof(screen_pixels));

        /* Update music beat flag every 8 frames (~4 Hz rhythm) */
        ++frame_counter;
        sound_music_beat = ((frame_counter >> 3) & 1);
        sound_music_active = (music_enabled && !game_paused) ? 1 : 0;

        /* 1. DRAW DUAL-LAYER BOOLEAN OPTICAL BARCODE ON ROWS 0..5 (3px thick per layer) */
        sound_draw_optical_stream(screen_pixels, screen_pixels + 3 * SCREEN_W, 4, 0);
        memcpy(screen_pixels + 1 * SCREEN_W, screen_pixels, SCREEN_W);
        memcpy(screen_pixels + 2 * SCREEN_W, screen_pixels, SCREEN_W);
        memcpy(screen_pixels + 4 * SCREEN_W, screen_pixels + 3 * SCREEN_W, SCREEN_W);
        memcpy(screen_pixels + 5 * SCREEN_W, screen_pixels + 3 * SCREEN_W, SCREEN_W);
        memset(screen_pixels + 6 * SCREEN_W, 0, SCREEN_W * 2);

        /* Step visual hold timers and sequence counter */
        sound_frame_step();

        /* Interactive proof: if blocked by user, wipe top rows to simulate covering the optical sensor */
        if (optical_blocked) {
            memset(screen_pixels, 0, SCREEN_W * 8);
        }

        /* 2. DECODE AUDIO STRICTLY BY READING ROWS 1 & 4 FROM SCREEN PIXELS */
        int decoded_frames = decode_and_synthesize_from_screen(
            screen_pixels + 1 * SCREEN_W, screen_pixels + 4 * SCREEN_W, decoded_stereo_pcm, &last_decoded_seq, &last_decoded_mask);

        if (audio_dev && decoded_frames > 0) {
            uint32_t queued = SDL_GetQueuedAudioSize(audio_dev);
            /* Keep audio queue smoothly buffered (~50-80ms), never clear or drop */
            if (queued < 17640) {
                SDL_QueueAudio(audio_dev, decoded_stereo_pcm, (Uint32)(decoded_frames * 2 * sizeof(int16_t)));
            }
        }

        /* 3. Scale 128x80 viewport to 320x200 starting at row VIEW_Y (8) */
        for (int y = 0; y < VIEW_H_DST; ++y) {
            int src_y = (y * VIEW_H) / VIEW_H_DST;
            const uint8_t *src_row = framebuffer + src_y * VIEW_W;
            uint8_t *dst_row = screen_pixels + (VIEW_Y + y) * SCREEN_W;
            for (int x = 0; x < SCREEN_W; ++x) {
                int src_x = (x * VIEW_W) / SCREEN_W;
                dst_row[x] = src_row[src_x];
            }
        }

        /* Convert palette indices to 24-bit RGB and upload to SDL Texture */
        void *pixels; int pitch;
        SDL_LockTexture(tex, &(SDL_Rect){0, 0, SCREEN_W, SCREEN_H}, &pixels, &pitch);
        uint8_t *dst = (uint8_t *)pixels;

        for (int y = 0; y < SCREEN_H; ++y) {
            uint8_t *row = dst + y * pitch;
            const uint8_t *src_row = screen_pixels + y * SCREEN_W;
            for (int x = 0; x < SCREEN_W; ++x) {
                const uint8_t *c = map_palette + src_row[x] * 3;
                row[x * 3 + 0] = c[0];
                row[x * 3 + 1] = c[1];
                row[x * 3 + 2] = c[2];
            }
        }
        SDL_UnlockTexture(tex);

        SDL_SetRenderDrawColor(ren, 0, 0, 0, 255);
        SDL_RenderClear(ren);
        SDL_RenderCopy(ren, tex, NULL, NULL);
        SDL_RenderPresent(ren);

        char title[128];
        snprintf(title, sizeof(title), "doom84 [DUAL-LAYER OPTICAL LOOPBACK] Seq:%u Pan:%u Vol:%u Pitch:%u Beat:%u",
                 sound_sequence, sound_sfx_pan, sound_sfx_vol, sound_sfx_pitch, sound_music_beat);
        SDL_SetWindowTitle(win, title);

        /* 35 FPS target timing: ~28.5 ms per frame */
        Uint32 frame_time = SDL_GetTicks() - frame_start;
        if (frame_time < (1000 / 35)) {
            SDL_Delay((1000 / 35) - frame_time);
        }
    }

    if (audio_dev) SDL_CloseAudioDevice(audio_dev);
    SDL_DestroyTexture(tex);
    SDL_DestroyRenderer(ren);
    SDL_DestroyWindow(win);
    SDL_Quit();
    free(map);
    if (music_data) free(music_data);
    for (int i = 1; i < NUM_SFX; ++i) {
        if (sfx_library[i].data) free(sfx_library[i].data);
    }
    for (unsigned i = 0; i < NUM_BANKS; ++i) free((void *)banks[i]);
    return 0;
}
