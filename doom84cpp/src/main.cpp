#include "doom/engine.h"

#include <fileioc.h>
#include <graphx.h>
#include <keypadc.h>
#include <tice.h>
#include <cstdio>
#include <cstring>
#include <ctime>

namespace {

constexpr int ViewY  = 8;
constexpr int StbarY = 208;

const uint8_t* banks[NUM_BANKS];
unsigned bank_lengths[NUM_BANKS];
doom::Engine g_engine;

const uint8_t* open_asset(const char* name, unsigned expected, unsigned* length) {
    uint8_t handle = ti_Open(name, "r");
    if (!handle) return nullptr;
    const uint8_t* data = nullptr;
    *length = ti_GetSize(handle);
    if (*length == expected && ti_IsArchived(handle)) {
        data = reinterpret_cast<const uint8_t*>(ti_GetDataPtr(handle));
    }
    ti_Close(handle);
    return data;
}

uint8_t read_input() {
    uint8_t result = 0;
    if (kb_Data[7] & kb_Up)    result |= doom::Input::Forward;
    if (kb_Data[7] & kb_Down)  result |= doom::Input::Back;
    if (kb_Data[7] & kb_Left)  result |= doom::Input::Left;
    if (kb_Data[7] & kb_Right) result |= doom::Input::Right;
    if (kb_Data[1] & kb_2nd)   result |= doom::Input::Fire;
    if (kb_Data[2] & kb_Math)  result |= doom::Input::Use;
    if (kb_Data[2] & kb_Alpha) result |= doom::Input::Run;
    return result;
}

void print_text(const char* s, int x, int y) {
    gfx_PrintStringXY(s, x, y);
}

} // namespace

int main() {
    unsigned map_length = 0;
    const uint8_t* map = open_asset("D84MAP", MAP_SIZE, &map_length);
    bool valid = (map != nullptr);

    for (unsigned i = 0; i < NUM_BANKS; ++i) {
        char name[] = "D84T0";
        name[4] = static_cast<char>('0' + i);
        banks[i] = open_asset(name, bank_sizes[i], &bank_lengths[i]);
        if (!banks[i]) valid = false;
    }

    if (!valid || !g_engine.init(map, map_length, banks, bank_lengths)) {
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
    g_engine.renderer.detail = 2;
    g_engine.player().texture_planes = false;

    for (unsigned i = 0; i < 256; ++i) {
        gfx_palette[i] = gfx_RGBTo1555(g_engine.map.palette[i * 3],
                                      g_engine.map.palette[i * 3 + 1],
                                      g_engine.map.palette[i * 3 + 2]);
    }

    gfx_SetDrawBuffer();
    gfx_SetTextFGColor(4);
    gfx_SetTextBGColor(0);
    gfx_SetTextTransparentColor(0);

    for (unsigned i = 0; i < 2; ++i) {
        gfx_FillScreen(0);
        doom::StatusBar::draw_calc(StbarY, g_engine.player());
        gfx_SwapDraw();
    }

    bool showmap = false, flatheld = false, mapheld = false, resetheld = false;
    bool paused = false, pauseheld = false, detailheld = false;
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
        if (flatkey && !flatheld) {
            if (g_engine.player().wireframe) {
                g_engine.player().wireframe = false;
                g_engine.player().texture_planes = false;
            } else if (!g_engine.player().texture_planes) {
                g_engine.player().texture_planes = true;
            } else {
                g_engine.player().wireframe = true;
            }
        }
        flatheld = flatkey;

        bool detailkey = (kb_Data[1] & kb_Trace) != 0;
        if (detailkey && !detailheld) {
            if (g_engine.renderer.detail == 2) g_engine.renderer.detail = 3;
            else if (g_engine.renderer.detail == 3) g_engine.renderer.detail = 4;
            else if (g_engine.renderer.detail == 4) g_engine.renderer.detail = 1;
            else g_engine.renderer.detail = 2;
        }
        detailheld = detailkey;

        bool pausekey = (kb_Data[1] & kb_Yequ) != 0;
        if (pausekey && !pauseheld) paused = !paused;
        pauseheld = pausekey;

        bool resetkey = (kb_Data[1] & kb_Zoom) != 0;
        if (resetkey && !resetheld) g_engine.reset();
        resetheld = resetkey;

        clock_t now = clock();
        clock_t elapsed = now - last;
        last = now;
        accumulator += elapsed;

        constexpr clock_t TicInterval = CLOCKS_PER_SEC / 35;
        while (accumulator >= TicInterval) {
            accumulator -= TicInterval;
            if (!paused) g_engine.tick(read_input());
        }

        clock_t t0 = clock();
        if (showmap) {
            doom::Automap::draw(g_engine.player(), g_engine.map);
        } else {
            g_engine.render();
            doom::Video::blit_viewport(g_engine.framebuffer(), gfx_vbuffer[ViewY]);
        }
        render_ms = static_cast<unsigned>((clock() - t0) * 1000 / CLOCKS_PER_SEC);

        unsigned cur_face = doom::StatusBar::face_index(g_engine.player());
        if (g_engine.player().health != hud_health ||
            g_engine.player().armor  != hud_armor ||
            g_engine.player().ammo   != hud_ammo ||
            cur_face != hud_face) {
            hud_health = g_engine.player().health;
            hud_armor  = g_engine.player().armor;
            hud_ammo   = g_engine.player().ammo;
            hud_face   = cur_face;
            hud_dirty  = 2;
        }

        if (hud_dirty) {
            doom::StatusBar::draw_calc(StbarY, g_engine.player());
            --hud_dirty;
        }

        ++frames;
        if (now - fps_start >= CLOCKS_PER_SEC) {
            fps = frames;
            frames = 0;
            fps_start = now;
        }

        char buf[40];
        const char* pmode = g_engine.player().wireframe ? "WIRE" : (g_engine.player().texture_planes ? "TEX" : "FLAT");
        const char* smode = (g_engine.renderer.detail == 1) ? "128" : (g_engine.renderer.detail == 2 ? "64" : (g_engine.renderer.detail == 3 ? "43" : "32"));
        std::snprintf(buf, sizeof(buf), "%u FPS %ums %s %s", fps, render_ms, pmode, smode);
        print_text(buf, 2, 0);

        if (paused) print_text("PAUSED", 140, 96);
        if (g_engine.player().dead) print_text("YOU DIED - PRESS ZOOM", 88, 96);
        if (g_engine.player().exited) print_text("LEVEL CLEAR!", 120, 96);

        gfx_SwapDraw();
    }

    gfx_End();
    return 0;
}
