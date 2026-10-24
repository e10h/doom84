#include <graphx.h>
#include <keypadc.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <tice.h>
#include <time.h>

#define CUBE_SIZE       38
#define CAM_DISTANCE    170
#define FOV_SCALE       220
#define SCREEN_CX       160
#define SCREEN_CY       120

/* Palette Indices */
#define PAL_BG          0
#define PAL_BORDER      1
#define PAL_WHITE       2
#define PAL_GRAY        3
#define PAL_CYAN        4
#define PAL_RED         10
#define PAL_ORANGE      11
#define PAL_BLUE        12
#define PAL_GREEN       13
#define PAL_YELLOW      14
#define PAL_PURPLE      15

typedef struct {
    int x, y;
} point2d_t;

typedef struct {
    int x, y, z;
} vec3i_t;

typedef struct {
    uint8_t v[4];
    uint8_t color;
} face_def_t;

/* 6 Cube Faces with consistent outward counter-clockwise winding */
static const face_def_t cube_faces[6] = {
    { { 4, 5, 6, 7 }, PAL_RED    }, /* 0: Front  (+Z) */
    { { 1, 0, 3, 2 }, PAL_ORANGE }, /* 1: Back   (-Z) */
    { { 7, 6, 2, 3 }, PAL_BLUE   }, /* 2: Top    (+Y) */
    { { 4, 0, 1, 5 }, PAL_GREEN  }, /* 3: Bottom (-Y) */
    { { 5, 1, 2, 6 }, PAL_YELLOW }, /* 4: Right  (+X) */
    { { 0, 4, 7, 3 }, PAL_PURPLE }  /* 5: Left   (-X) */
};

/* 256-entry 8.8 fixed-point sine table: round(sin(i * 2*pi / 256) * 256) */
static const int16_t sin_table[256] = {
       0,    6,   13,   19,   25,   31,   38,   44,   50,   56,   62,   68,   74,   80,   86,   92,
      98,  104,  109,  115,  121,  126,  132,  137,  142,  147,  152,  157,  162,  167,  172,  177,
     181,  185,  190,  194,  198,  202,  206,  209,  213,  216,  220,  223,  226,  229,  231,  234,
     237,  239,  241,  243,  245,  247,  248,  250,  251,  252,  253,  254,  255,  255,  256,  256,
     256,  256,  256,  255,  255,  254,  253,  252,  251,  250,  248,  247,  245,  243,  241,  239,
     237,  234,  231,  229,  226,  223,  220,  216,  213,  209,  206,  202,  198,  194,  190,  185,
     181,  177,  172,  167,  162,  157,  152,  147,  142,  137,  132,  126,  121,  115,  109,  104,
      98,   92,   86,   80,   74,   68,   62,   56,   50,   44,   38,   31,   25,   19,   13,    6,
       0,   -6,  -13,  -19,  -25,  -31,  -38,  -44,  -50,  -56,  -62,  -68,  -74,  -80,  -86,  -92,
     -98, -104, -109, -115, -121, -126, -132, -137, -142, -147, -152, -157, -162, -167, -172, -177,
    -181, -185, -190, -194, -198, -202, -206, -209, -213, -216, -220, -223, -226, -229, -231, -234,
    -237, -239, -241, -243, -245, -247, -248, -250, -251, -252, -253, -254, -255, -255, -256, -256,
    -256, -256, -256, -255, -255, -254, -253, -252, -251, -250, -248, -247, -245, -243, -241, -239,
    -237, -234, -231, -229, -226, -223, -220, -216, -213, -209, -206, -202, -198, -194, -190, -185,
    -181, -177, -172, -167, -162, -157, -152, -147, -142, -137, -132, -126, -121, -115, -109, -104,
     -98,  -92,  -86,  -80,  -74,  -68,  -62,  -56,  -50,  -44,  -38,  -31,  -25,  -19,  -13,   -6,
};

static inline int fast_sin(uint8_t a) {
    return (int)sin_table[a];
}

static inline int fast_cos(uint8_t a) {
    return (int)sin_table[(uint8_t)(a + 64)];
}

/* Static arrays in BSS to prevent eZ80 stack frame overflows */
static point2d_t projected[8];
static int left_x[240];
static int right_x[240];

/* Isolated stack frame, native 24-bit integer scanline DDA */
__attribute__((noinline))
static void fill_convex_quad(const point2d_t *p0, const point2d_t *p1,
                             const point2d_t *p2, const point2d_t *p3,
                             uint8_t color) {
    const point2d_t *pts[4] = { p0, p1, p2, p3 };

    int min_y = pts[0]->y;
    int max_y = pts[0]->y;
    for (uint8_t i = 1; i < 4; ++i) {
        int py = pts[i]->y;
        if (py < min_y) min_y = py;
        if (py > max_y) max_y = py;
    }
    if (min_y < 0) min_y = 0;
    if (max_y >= 240) max_y = 239;
    if (min_y > max_y) return;

    for (int y = min_y; y <= max_y; ++y) {
        left_x[y] = 320;
        right_x[y] = -1;
    }

    for (uint8_t i = 0; i < 4; ++i) {
        uint8_t next = (i + 1) & 3;
        int x0 = pts[i]->x;
        int y0 = pts[i]->y;
        int x1 = pts[next]->x;
        int y1 = pts[next]->y;

        if (y0 == y1) {
            if (y0 >= 0 && y0 < 240) {
                int lx = x0 < x1 ? x0 : x1;
                int rx = x0 > x1 ? x0 : x1;
                if (lx < left_x[y0]) left_x[y0] = lx;
                if (rx > right_x[y0]) right_x[y0] = rx;
            }
            continue;
        }

        if (y0 > y1) {
            int tx = x0; x0 = x1; x1 = tx;
            int ty = y0; y0 = y1; y1 = ty;
        }

        int dy = y1 - y0;
        int dx_step = ((x1 - x0) << 8) / dy;
        int cur_x = (x0 << 8) + 128;

        int start_y = y0;
        int end_y = y1;
        if (start_y < 0) {
            cur_x += dx_step * (-start_y);
            start_y = 0;
        }
        if (end_y >= 240) end_y = 239;

        for (int y = start_y; y <= end_y; ++y) {
            int x = cur_x >> 8;
            if (x < left_x[y]) left_x[y] = x;
            if (x > right_x[y]) right_x[y] = x;
            cur_x += dx_step;
        }
    }

    /* Fast row span filling */
    uint8_t *row = &gfx_vbuffer[min_y][0];
    for (int y = min_y; y <= max_y; ++y, row += 320) {
        int lx = left_x[y];
        int rx = right_x[y];
        if (lx <= rx) {
            if (lx < 0) lx = 0;
            if (rx >= 320) rx = 319;
            int len = rx - lx + 1;
            if (len > 0) {
                memset(row + lx, color, (size_t)len);
            }
        }
    }
}

static void init_palette(void) {
    gfx_SetDefaultPalette(gfx_8bpp);

    gfx_palette[PAL_BG]     = gfx_RGBTo1555(18, 22, 32);     /* Dark slate blue */
    gfx_palette[PAL_BORDER] = gfx_RGBTo1555(10, 10, 14);     /* Deep edge border */
    gfx_palette[PAL_WHITE]  = gfx_RGBTo1555(255, 255, 255);  /* White text */
    gfx_palette[PAL_GRAY]   = gfx_RGBTo1555(80, 95, 120);    /* Divider gray */
    gfx_palette[PAL_CYAN]   = gfx_RGBTo1555(0, 215, 230);    /* Bright cyan */
    gfx_palette[PAL_RED]    = gfx_RGBTo1555(235, 55, 60);    /* Crimson red */
    gfx_palette[PAL_ORANGE] = gfx_RGBTo1555(245, 130, 32);   /* Sunset orange */
    gfx_palette[PAL_BLUE]   = gfx_RGBTo1555(45, 135, 250);   /* Royal blue */
    gfx_palette[PAL_GREEN]  = gfx_RGBTo1555(46, 204, 113);   /* Emerald green */
    gfx_palette[PAL_YELLOW] = gfx_RGBTo1555(245, 205, 25);   /* Radiant yellow */
    gfx_palette[PAL_PURPLE] = gfx_RGBTo1555(160, 80, 220);   /* Vibrant purple */
}

int main(void) {
    /* 24-bit fixed point angle accumulators (16-bit fractional precision for zero shaking) */
    uint24_t angle_x_acc = 20 << 16;
    uint24_t angle_y_acc = 35 << 16;
    uint24_t angle_z_acc = 15 << 16;

    int speed_mult = 256; /* 1.0x in 8.8 fixed point */

    bool paused = false;
    bool wireframe = false;
    bool prev_2nd = false;
    bool prev_alpha = false;

    clock_t last_frame_time = clock();
    clock_t last_fps_time = last_frame_time;
    uint16_t frame_count = 0;
    uint16_t current_fps = 0;

    gfx_Begin();
    init_palette();
    gfx_SetDrawBuffer();

    while (true) {
        clock_t now = clock();

        /* High-precision delta ticks (32768 ticks = 1 second) */
        clock_t delta_ticks = now - last_frame_time;
        last_frame_time = now;
        if (delta_ticks < 1) delta_ticks = 1;
        if (delta_ticks > 32768) delta_ticks = 3276;

        frame_count++;
        clock_t fps_elapsed = now - last_fps_time;
        if (fps_elapsed >= (CLOCKS_PER_SEC / 3)) {
            current_fps = (uint16_t)(((uint32_t)frame_count * CLOCKS_PER_SEC) / fps_elapsed);
            frame_count = 0;
            last_fps_time = now;
        }

        kb_Scan();

        /* Exit on [CLEAR] */
        if (kb_IsDown(kb_KeyClear)) {
            break;
        }

        /* Toggle pause on [2nd] */
        bool curr_2nd = kb_IsDown(kb_Key2nd);
        if (curr_2nd && !prev_2nd) {
            paused = !paused;
        }
        prev_2nd = curr_2nd;

        /* Toggle wireframe on [ALPHA] */
        bool curr_alpha = kb_IsDown(kb_KeyAlpha);
        if (curr_alpha && !prev_alpha) {
            wireframe = !wireframe;
        }
        prev_alpha = curr_alpha;

        /* Speed adjustment with [+] and [-] */
        int speed_step = (int)(delta_ticks >> 6);
        if (kb_IsDown(kb_KeyAdd)) {
            speed_mult += speed_step;
            if (speed_mult > 1280) speed_mult = 1280; /* 5.0x max */
        }
        if (kb_IsDown(kb_KeySub)) {
            speed_mult -= speed_step;
            if (speed_mult < 26) speed_mult = 26;     /* 0.1x min */
        }

        /* Manual nudge with arrows (snappy responsive steering) */
        int nudge = (int)(delta_ticks * 320);
        if (kb_IsDown(kb_KeyUp))    angle_x_acc -= nudge;
        if (kb_IsDown(kb_KeyDown))  angle_x_acc += nudge;
        if (kb_IsDown(kb_KeyLeft))  angle_y_acc -= nudge;
        if (kb_IsDown(kb_KeyRight)) angle_y_acc += nudge;

        /* Smooth, snappy auto-rotation (1 full turn every ~1.9s at 1.0x) */
        if (!paused) {
            int dt_scaled = (int)((delta_ticks * speed_mult) >> 8);
            angle_x_acc += (uint24_t)(dt_scaled * 180);
            angle_y_acc += (uint24_t)(dt_scaled * 260);
            angle_z_acc += (uint24_t)(dt_scaled * 110);
        }

        /* Extract 8-bit table indices (high byte of 16-bit angle) */
        uint8_t ax = (uint8_t)(angle_x_acc >> 16);
        uint8_t ay = (uint8_t)(angle_y_acc >> 16);
        uint8_t az = (uint8_t)(angle_z_acc >> 16);

        int sx = fast_sin(ax), cx = fast_cos(ax);
        int sy = fast_sin(ay), cy = fast_cos(ay);
        int sz = fast_sin(az), cz = fast_cos(az);

        /* -------------------------------------------------------------
         * EXACT 3D ROTATION MATRIX:
         * R = Rz * Ry * Rx
         * ------------------------------------------------------------- */
        int r00 = (cy * cz) >> 8;
        int r01 = ((((sx * sy) >> 8) * cz) >> 8) - ((cx * sz) >> 8);
        int r02 = ((((cx * sy) >> 8) * cz) >> 8) + ((sx * sz) >> 8);

        int r10 = (cy * sz) >> 8;
        int r11 = ((((sx * sy) >> 8) * sz) >> 8) + ((cx * cz) >> 8);
        int r12 = ((((cx * sy) >> 8) * sz) >> 8) - ((sx * cz) >> 8);

        int r20 = -sy;
        int r21 = (sx * cy) >> 8;
        int r22 = (cx * cy) >> 8;

        int L = CUBE_SIZE;

        /* Basis vectors: u = right (+X), v = top (+Y), w = front (+Z) */
        int ux = (L * r00) >> 8, uy = (L * r10) >> 8, uz = (L * r20) >> 8;
        int vx = (L * r01) >> 8, vy = (L * r11) >> 8, vz = (L * r21) >> 8;
        int wx = (L * r02) >> 8, wy = (L * r12) >> 8, wz = (L * r22) >> 8;

        /* 8 Vertices formed directly by vector addition: +/- u +/- v +/- w */
        vec3i_t verts[8];
        verts[0].x = -ux - vx - wx; verts[0].y = -uy - vy - wy; verts[0].z = -uz - vz - wz;
        verts[1].x =  ux - vx - wx; verts[1].y =  uy - vy - wy; verts[1].z =  uz - vz - wz;
        verts[2].x =  ux + vx - wx; verts[2].y =  uy + vy - wy; verts[2].z =  uz + vz - wz;
        verts[3].x = -ux + vx - wx; verts[3].y = -uy + vy - wy; verts[3].z = -uz + vz - wz;
        verts[4].x = -ux - vx + wx; verts[4].y = -uy - vy + wy; verts[4].z = -uz - vz + wz;
        verts[5].x =  ux - vx + wx; verts[5].y =  uy - vy + wy; verts[5].z =  uz - vz + wz;
        verts[6].x =  ux + vx + wx; verts[6].y =  uy + vy + wy; verts[6].z =  uz + vz + wz;
        verts[7].x = -ux + vx + wx; verts[7].y = -uy + vy + wy; verts[7].z = -uz + vz + wz;

        /* Perspective projection */
        for (uint8_t i = 0; i < 8; ++i) {
            int depth = CAM_DISTANCE - verts[i].z;
            if (depth < 20) depth = 20;
            int scale = (FOV_SCALE << 8) / depth;
            projected[i].x = SCREEN_CX + ((verts[i].x * scale) >> 8);
            projected[i].y = SCREEN_CY - ((verts[i].y * scale) >> 8);
        }

        /* Fast hardware zero screen clear */
        gfx_ZeroScreen();

        /* -------------------------------------------------------------
         * PRECISE 2D CROSS-PRODUCT BACK-FACE CULLING & DEPTH SORTING:
         * Uses screen coordinates so face visibility is physically 100% exact.
         * ------------------------------------------------------------- */
        uint8_t vis_face[3];
        int vis_depth[3];
        uint8_t vis_count = 0;

        for (uint8_t i = 0; i < 6; ++i) {
            const face_def_t *f = &cube_faces[i];
            const point2d_t *p0 = &projected[f->v[0]];
            const point2d_t *p1 = &projected[f->v[1]];
            const point2d_t *p2 = &projected[f->v[2]];

            /* 2D cross product: negative means front-facing */
            long cross = (long)(p1->x - p0->x) * (long)(p2->y - p0->y) -
                         (long)(p1->y - p0->y) * (long)(p2->x - p0->x);

            if (cross < 0) {
                /* Average Z for painter sort */
                int face_z = verts[f->v[0]].z + verts[f->v[1]].z +
                             verts[f->v[2]].z + verts[f->v[3]].z;
                vis_face[vis_count] = i;
                vis_depth[vis_count] = face_z;
                vis_count++;
            }
        }

        /* Sort visible faces back-to-front (lowest Z first) */
        for (uint8_t i = 1; i < vis_count; ++i) {
            int kd = vis_depth[i];
            uint8_t kf = vis_face[i];
            int j = (int)i - 1;
            while (j >= 0 && vis_depth[j] > kd) {
                vis_depth[j + 1] = vis_depth[j];
                vis_face[j + 1] = vis_face[j];
                j--;
            }
            vis_depth[j + 1] = kd;
            vis_face[j + 1] = kf;
        }

        /* Render visible faces */
        for (uint8_t i = 0; i < vis_count; ++i) {
            const face_def_t *f = &cube_faces[vis_face[i]];
            const point2d_t *p0 = &projected[f->v[0]];
            const point2d_t *p1 = &projected[f->v[1]];
            const point2d_t *p2 = &projected[f->v[2]];
            const point2d_t *p3 = &projected[f->v[3]];

            if (!wireframe) {
                fill_convex_quad(p0, p1, p2, p3, f->color);
            } else {
                gfx_SetColor(f->color);
                gfx_Line(p0->x, p0->y, p1->x, p1->y);
                gfx_Line(p1->x, p1->y, p2->x, p2->y);
                gfx_Line(p2->x, p2->y, p3->x, p3->y);
                gfx_Line(p3->x, p3->y, p0->x, p0->y);
            }
        }

        /* Draw UI Header */
        gfx_SetColor(PAL_GRAY);
        gfx_HorizLine(0, 18, 320);

        gfx_SetTextTransparentColor(0);
        gfx_SetTextFGColor(PAL_WHITE);
        gfx_PrintStringXY("TI-84+ CE 3D CUBE", 8, 5);

        /* Speed multiplier display */
        gfx_SetTextFGColor(PAL_YELLOW);
        gfx_SetTextXY(180, 5);
        int spd_int = speed_mult >> 8;
        int spd_dec = ((speed_mult & 0xFF) * 10) >> 8;
        gfx_PrintUInt(spd_int, 1);
        gfx_PrintChar('.');
        gfx_PrintUInt(spd_dec, 1);
        gfx_PrintChar('x');

        /* Live FPS counter */
        gfx_SetTextFGColor(PAL_CYAN);
        gfx_PrintStringXY("FPS:", 248, 5);
        gfx_SetTextFGColor(PAL_GREEN);
        gfx_SetTextXY(284, 5);
        gfx_PrintUInt(current_fps, 1);

        /* Draw UI Footer */
        gfx_SetColor(PAL_GRAY);
        gfx_HorizLine(0, 224, 320);

        gfx_SetTextFGColor(PAL_CYAN);
        gfx_PrintStringXY("[CLEAR] Exit   [ARROWS] Spin   [+/-] Speed", 4, 228);

        /* Flip buffer to display */
        gfx_SwapDraw();
    }

    gfx_End();
    return 0;
}
