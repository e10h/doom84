#include "engine.h"
#include "generated.h"
#include "hud.h"
#include "st_stuff.h"
#include "am_map.h"
#include <fileioc.h>
#include <graphx.h>
#include <keypadc.h>
#include <tice.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

#define VIEW_Y 8
#define VIEW_H_DST 200
#define STBAR_Y 208

static const uint8_t *banks[NUM_BANKS];
static unsigned bank_lengths[NUM_BANKS];

static const uint8_t *open_asset(const char *name, unsigned expected, unsigned *length) {
    uint8_t handle = ti_Open(name, "r");
    if (!handle) return NULL;
    const uint8_t *data = NULL;
    *length = ti_GetSize(handle);
    /* No allocation or archive writes occur after these pointers are cached. */
    if (*length == expected && ti_IsArchived(handle)) data = ti_GetDataPtr(handle);
    ti_Close(handle);
    return data;
}

static uint8_t input(void) {
    uint8_t result = 0;
    if (kb_Data[7] & kb_Up) result |= INPUT_FORWARD;
    if (kb_Data[7] & kb_Down) result |= INPUT_BACK;
    if (kb_Data[7] & kb_Left) result |= INPUT_LEFT;
    if (kb_Data[7] & kb_Right) result |= INPUT_RIGHT;
    if (kb_Data[1] & kb_2nd) result |= INPUT_FIRE;
    if (kb_Data[2] & kb_Math) result |= INPUT_USE;
    if (kb_Data[2] & kb_Alpha) result |= INPUT_RUN;
    return result;
}

static void text(const char *s, int x, int y) {
    gfx_PrintStringXY(s, x, y);
}

int main(void) {
    unsigned map_length = 0;
    const uint8_t *map = open_asset("D84MAP", MAP_SIZE, &map_length);
    bool valid = map != NULL;
    for (unsigned i = 0; i < NUM_BANKS; ++i) {
        char name[] = "D84T0";
        name[4] = (char)('0' + i);
        banks[i] = open_asset(name, bank_sizes[i], &bank_lengths[i]);
        if (!banks[i]) valid = false;
    }
    if (!valid || !engine_init(map, map_length, banks, bank_lengths)) {
        os_ClrHome();
        os_PutStrFull("E1M1 assets missing,"); os_NewLine();
        os_PutStrFull("unarchived or outdated."); os_NewLine();
        os_PutStrFull("Send ALL D84*.8xv"); os_NewLine();
        os_PutStrFull("files to Archive."); os_NewLine();
        os_PutStrFull("Press any key.");
        while (!os_GetCSC());
        return 1;
    }
    gfx_Begin();
    render_detail = 2;
    player.texture_planes = false;
    for (unsigned i = 0; i < 256; ++i) {
        gfx_palette[i] = gfx_RGBTo1555(map_palette[i * 3], map_palette[i * 3 + 1], map_palette[i * 3 + 2]);
    }
    gfx_SetDrawBuffer();
    gfx_SetTextFGColor(4);
    gfx_SetTextBGColor(0);
    gfx_SetTextTransparentColor(0);
    for (unsigned i = 0; i < 2; ++i) {
        gfx_FillScreen(0);
        draw_status(STBAR_Y);
        gfx_SwapDraw();
    }
    bool showmap = false, flatheld = false, mapheld = false, resetheld = false, paused = false, pauseheld = false, detailheld = false;
    clock_t last = clock(), accumulator = 0, fps_start = last;
    unsigned frames = 0, fps = 0, render_ms = 0;
    int hud_health = -1, hud_armor = -1, hud_ammo = -1;
    unsigned hud_face = 999, hud_dirty = 0;

    for (;;) {
        kb_Scan();
        if (kb_Data[6] & kb_Clear) break;
        bool mapkey = (kb_Data[1] & kb_Graph) != 0;
        if (mapkey && !mapheld) showmap = !showmap;
        mapheld = mapkey;
        bool flatkey = (kb_Data[1] & kb_Window) != 0;
        /* Window cycles FAST (flat) -> TEXTURED -> WIRE (edge-only). */
        if (flatkey && !flatheld) {
            if (player.wireframe) {
                player.wireframe = false;
                player.texture_planes = false;
            } else if (!player.texture_planes) {
                player.texture_planes = true;
            } else {
                player.texture_planes = false;
                player.wireframe = true;
            }
        }
        flatheld = flatkey;
        bool detailkey = (kb_Data[1] & kb_Trace) != 0;
        /* 64 → ~43 (every 3rd) → 32 → 128 → 64 */
        if (detailkey && !detailheld) {
            render_detail = render_detail == 2 ? 3 : render_detail == 3 ? 4 : render_detail == 4 ? 1 : 2;
        }
        detailheld = detailkey;
        bool resetkey = (kb_Data[1] & kb_Zoom) != 0;
        if (resetkey && !resetheld) {
            bool textured = player.texture_planes, wire = player.wireframe;
            engine_reset();
            player.texture_planes = textured;
            player.wireframe = wire;
        }
        resetheld = resetkey;
        bool pausekey = (kb_Data[1] & kb_Yequ) != 0;
        if (pausekey && !pauseheld) paused = !paused;
        pauseheld = pausekey;

        clock_t now = clock(), elapsed = now - last;
        last = now;
        /* Limit catch-up to six 35 Hz tics. Prevents a slow frame from
         * causing a long unresponsive simulation burst. */
        accumulator += elapsed;
        if (accumulator > CLOCKS_PER_SEC * 6 / 35) accumulator = CLOCKS_PER_SEC * 6 / 35;
        uint8_t keys = input();
        while (accumulator >= CLOCKS_PER_SEC / 35) {
            if (!paused && !showmap) engine_tick(keys);
            accumulator -= CLOCKS_PER_SEC / 35;
        }
        clock_t begin = clock();
        if (!showmap) engine_render();
        render_ms = showmap ? 0 : (unsigned)((clock() - begin) * 1000 / CLOCKS_PER_SEC);

        gfx_SetColor(0);
        gfx_FillRectangle_NoClip(0, 0, 320, VIEW_Y);
        if (showmap) {
            automap();
        } else {
#ifdef __TICE__
            d84_blit_viewport(engine_view.pixels, (uint8_t *)gfx_vbuffer + VIEW_Y * 320);
#else
            gfx_ScaledSprite_NoClip((const gfx_sprite_t *)&engine_view, 32, VIEW_Y, 2, 2);
#endif
        }
        /* STBAR only when stats change; dirty=2 covers both LCD buffers. */
        unsigned face = face_index();
        if (player.health != hud_health || player.armor != hud_armor || player.ammo != hud_ammo || face != hud_face) {
            hud_health = player.health;
            hud_armor = player.armor;
            hud_ammo = player.ammo;
            hud_face = face;
            hud_dirty = 2;
        }
        if (hud_dirty) {
            draw_status(STBAR_Y);
            --hud_dirty;
        }
        char line[40];
        snprintf(line, sizeof(line), "E1M1 %uFPS %ums %s", fps, render_ms,
                 player.wireframe ? "WIRE" : player.texture_planes ? "TEX" : "FAST");
        text(line, 4, 0);
        if (paused) text("PAUSED", 136, VIEW_Y + 90);
        if (player.dead) text("YOU DIED - ZOOM RESTART", 64, VIEW_Y + 90);
        if (player.exited) text("E1M1 EXIT - ZOOM RESTART", 64, VIEW_Y + 90);
        if (player.damage) {
            gfx_SetColor(176);
            gfx_Rectangle_NoClip(0, VIEW_Y, 320, VIEW_H_DST);
        }
        gfx_SwapDraw();
        ++frames;
        if (clock() - fps_start >= CLOCKS_PER_SEC) {
            clock_t duration = clock() - fps_start;
            fps = (unsigned)((uint32_t)frames * CLOCKS_PER_SEC / duration);
            frames = 0;
            fps_start = clock();
        }
    }
    gfx_End();
    return 0;
}
