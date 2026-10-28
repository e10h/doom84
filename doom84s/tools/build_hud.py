#!/usr/bin/env python3
"""Bake Doom pistol frames and status-bar graphics for the CE HUD."""
from pathlib import Path
import struct

VIEW_W, VIEW_H = 128, 80
SX, SY = VIEW_W / 320.0, VIEW_H / 200.0
GUN_NAMES = ('PISGA0', 'PISGB0', 'PISGC0')  # ready / fire / recoil
FLASH_NAME = 'PISFA0'
FACE_NAMES = ('STFST01', 'STFST11', 'STFST21', 'STFST31', 'STFST41', 'STFDEAD0', 'STFOUCH0')
FACE_W, FACE_H = 24, 32
STT_W, STT_H = 14, 16
STY_W, STY_H = 4, 6


def _c_array(values):
    return '{' + ','.join(map(str, values)) + '}'


def build_hud(wad, out):
    """Write src/gun.h and src/hud.h from Doom WAD patches."""
    out = Path(out)
    (out / 'src').mkdir(parents=True, exist_ok=True)

    def patch(name):
        return wad.patch(name)

    def scale_to_view(name):
        w, h, left, top, pixels = patch(name)
        # Doom psprite placement for sx≈FRACUNIT, sy=WEAPONTOP (see R_DrawPSprite).
        x1 = 1 - left
        y0 = int(31.5 - top)
        sw = max(1, round(w * SX))
        sh = max(1, round(h * SY))
        dx = round(x1 * SX)
        dy = round(y0 * SY)
        canvas = bytearray([255]) * (VIEW_W * VIEW_H)
        for y in range(sh):
            sy = min(h - 1, y * h // sh)
            for x in range(sw):
                sx = min(w - 1, x * w // sw)
                c = pixels[sy * w + sx]
                if c == 255:
                    continue
                xx, yy = dx + x, dy + y
                if 0 <= xx < VIEW_W and 0 <= yy < VIEW_H:
                    canvas[yy * VIEW_W + xx] = c
        return canvas

    canvases = [scale_to_view(n) for n in GUN_NAMES]
    flash = scale_to_view(FLASH_NAME)
    used = [i for c in canvases + [flash] for i, p in enumerate(c) if p != 255]
    minx = min(i % VIEW_W for i in used)
    miny = min(i // VIEW_W for i in used)
    maxx = max(i % VIEW_W for i in used)
    maxy = max(i // VIEW_W for i in used)
    gw, gh = maxx - minx + 1, maxy - miny + 1

    def crop(canvas):
        return [canvas[y * VIEW_W + x] for y in range(miny, maxy + 1) for x in range(minx, maxx + 1)]

    gun_h = [
        '/* Generated pistol frames with Doom weapon offsets. Do not edit. */',
        f'#define GUN_X {minx}',
        f'#define GUN_Y {miny}',
        f'#define GUN_W {gw}',
        f'#define GUN_H {gh}',
        f'#define GUN_FRAME_COUNT {len(GUN_NAMES)}',
        f'static const unsigned char gun_frames[GUN_FRAME_COUNT][GUN_W*GUN_H] = {{',
        ','.join(_c_array(crop(c)) for c in canvases),
        '};',
        f'static const unsigned char gun_flash[GUN_W*GUN_H] = {_c_array(crop(flash))};',
        '',
    ]
    (out / 'src/gun.h').write_text('\n'.join(gun_h))

    # Status bar background with arms panel composited in.
    sw, sh, _, _, stpix = patch('STBAR')
    if sw != 320 or sh != 32:
        raise ValueError(f'STBAR expected 320x32, got {sw}x{sh}')
    stbar = bytearray(stpix)
    def blit_patch(name, dx, dy):
        pw, ph, _, _, pix = patch(name)
        for y in range(min(ph, 32 - dy)):
            for x in range(min(pw, 320 - dx)):
                c = pix[y * pw + x]
                if c != 255:
                    stbar[(dy + y) * 320 + dx + x] = c

    # Doom draws STARMS at (104,168); weapon-2 digit at arms cell (111,172).
    blit_patch('STARMS', 104, 0)
    blit_patch('STGNUM2', 111, 4)

    def pad_patch(name, dw, dh):
        w, h, _, _, pixels = patch(name)
        outp = bytearray([255]) * (dw * dh)
        for y in range(min(h, dh)):
            for x in range(min(w, dw)):
                outp[y * dw + x] = pixels[y * w + x]
        return list(outp), w

    digits = []
    digit_w = []
    for i in range(10):
        pix, w = pad_patch(f'STTNUM{i}', STT_W, STT_H)
        digits.append(pix)
        digit_w.append(w)
    pct, pct_w = pad_patch('STTPRCNT', STT_W, STT_H)
    digits.append(pct)
    digit_w.append(pct_w)

    small = []
    small_w = []
    for i in range(10):
        pix, w = pad_patch(f'STYSNUM{i}', STY_W, STY_H)
        small.append(pix)
        small_w.append(w)

    faces = []
    for name in FACE_NAMES:
        pix, _ = pad_patch(name, FACE_W, FACE_H)
        faces.append(pix)

    hud_h = [
        '/* Generated Doom status bar. Do not edit. */',
        '#define STBAR_W 320',
        '#define STBAR_H 32',
        f'#define STT_W {STT_W}',
        f'#define STT_H {STT_H}',
        f'#define STY_W {STY_W}',
        f'#define STY_H {STY_H}',
        f'#define FACE_W {FACE_W}',
        f'#define FACE_H {FACE_H}',
        f'#define FACE_COUNT {len(FACE_NAMES)}',
        # Screen positions match Doom's st_stuff.c, shifted to CE y=184.
        '#define ST_AMMO_X 44',
        '#define ST_HEALTH_X 90',
        '#define ST_ARMOR_X 221',
        '#define ST_FACE_X 143',
        '#define ST_FACE_Y 0',
        '#define ST_NUM_Y 3',
        '#define ST_AMMO0_X 288',
        '#define ST_MAXAMMO0_X 314',
        '#define ST_AMMO0_Y 5',
        '#define ST_AMMO1_Y 11',
        '#define ST_AMMO2_Y 23',
        '#define ST_AMMO3_Y 17',
        f'static const unsigned char stbar[STBAR_W*STBAR_H] = {_c_array(stbar)};',
        f'static const unsigned char stt_w[11] = {_c_array(digit_w)};',
        'static const unsigned char stt_digits[11][STT_W*STT_H] = {' + ','.join(_c_array(d) for d in digits) + '};',
        f'static const unsigned char sty_w[10] = {_c_array(small_w)};',
        'static const unsigned char sty_digits[10][STY_W*STY_H] = {' + ','.join(_c_array(d) for d in small) + '};',
        'static const unsigned char st_faces[FACE_COUNT][FACE_W*FACE_H] = {' + ','.join(_c_array(f) for f in faces) + '};',
        '',
    ]
    (out / 'src/hud.h').write_text('\n'.join(hud_h))
    return {'gun': (gw, gh), 'hud_bytes': 320 * 32 + 11 * STT_W * STT_H + 10 * STY_W * STY_H + len(FACE_NAMES) * FACE_W * FACE_H}


if __name__ == '__main__':
    import argparse
    import sys
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    from build_assets import Wad
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('wad', type=Path)
    p.add_argument('--out', type=Path, default=Path(__file__).resolve().parents[1])
    args = p.parse_args()
    info = build_hud(Wad(args.wad), args.out)
    print(f'gun {info["gun"][0]}x{info["gun"][1]}; hud payload ~{info["hud_bytes"]} bytes')
