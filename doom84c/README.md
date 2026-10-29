# Doom84C: Pure C Port for TI-84 Plus CE

**Doom84C** is a pure **C11** implementation of the Doom84 E1M1 sector engine for the **TI-84 Plus CE** graphing calculator, with **zero assembly language (`.S` files)**.

Every single subsystem—including BSP traversal, column clipping, fixed-point perspective texture mapping, sprite rasterization, and LCD viewport blitting—is written entirely in portable C.

---

## 🚀 Key Differences: `doom84` vs `doom84c`

| Component | Original `doom84` | `doom84c` (Pure C) |
| :--- | :--- | :--- |
| **Assembly Files** | `bsp.S`, `geometry.S`, `pixels.S`, `render.S` | **None** (100% standard C) |
| **ABI Glue Headers** | `render_abi.h`, `geometry_abi.h` | **Removed** (clean static C functions) |
| **BSP Traversal** | Hand-rolled eZ80 stack-frame assembly (`_d84_bsp`) | Clean recursive C function `bsp()` |
| **Math & Transforms** | Self-modifying eZ80 camera rotation and MLT instructions | Fixed-point integer C math (`shr8`, `high_word`, `screen_x`) |
| **Column & Span Rasterizer** | Unrolled assembly loops with register-packed pointers | Portable C column loops (`d84_wall_column`, `d84_span*`) |
| **Display Blit** | eZ80 `ldir` pair-pixel assembly blitter | Clean 2.5× nearest-neighbor C blitter with `memcpy` |
| **Calculator Binary** | `bin/E1M1.8xp` | `bin/DOOM84C.8xp` |
| **Compatibility** | TI-84 Plus CE (eZ80) & Desktop (macOS/Linux) | TI-84 Plus CE (eZ80) & Desktop (macOS/Linux) |

---

## 🏛️ Subsystem Architecture (OG DOOM Module Prefixes)

`Doom84C` follows id Software's classic module-prefix architecture:

| Prefix | Subsystem | Files | Responsibilities |
| :--- | :--- | :--- | :--- |
| **`d_`** | **DOOM / Lifecycle** | [`d_main.c`](file:///Users/ethan/Code/doom84/doom84c/src/d_main.c), [`d_main.h`](file:///Users/ethan/Code/doom84/doom84c/src/d_main.h) | `engine_init()`, `engine_reset()`, asset unpacking, palette/sky init. |
| **`m_`** | **Math & Utils** | [`m_fixed.c`](file:///Users/ethan/Code/doom84/doom84c/src/m_fixed.c), [`m_bbox.c`](file:///Users/ethan/Code/doom84/doom84c/src/m_bbox.c) | Reciprocals, fast trig, screen projections, bbox frustum culling. |
| **`r_`** | **Renderer** | [`r_main.c`](file:///Users/ethan/Code/doom84/doom84c/src/r_main.c), [`r_bsp.c`](file:///Users/ethan/Code/doom84/doom84c/src/r_bsp.c), [`r_segs.c`](file:///Users/ethan/Code/doom84/doom84c/src/r_segs.c),<br>[`r_plane.c`](file:///Users/ethan/Code/doom84/doom84c/src/r_plane.c), [`r_things.c`](file:///Users/ethan/Code/doom84/doom84c/src/r_things.c), [`r_draw.c`](file:///Users/ethan/Code/doom84/doom84c/src/r_draw.c) | • `r_main`: Viewport setup, camera rotation, HUD weapon overlay.<br>• `r_bsp`: Recursive near-first BSP traversal (`R_RenderBSPNode`).<br>• `r_segs`: Solid wall clipping, portal rendering, column DDAs.<br>• `r_plane`: Floor/ceiling flat spans.<br>• `r_things`: Sprite sorting, scaling, and rasterization.<br>• `r_draw`: Core pixel column/span drawers. |
| **`p_`** | **Play / World** | [`p_map.c`](file:///Users/ethan/Code/doom84/doom84c/src/p_map.c), [`p_tick.c`](file:///Users/ethan/Code/doom84/doom84c/src/p_tick.c), [`p_inter.c`](file:///Users/ethan/Code/doom84/doom84c/src/p_inter.c) | • `p_map`: Blockmap collision (`engine_can_move`), sector lookup, sight.<br>• `p_tick`: Movement, turning, door/lift motion, trigger crossings, AI.<br>• `p_inter`: Use switches/doors, weapons, barrel explosions, damage. |
| **`st_`** | **Status Bar** | [`st_stuff.c`](file:///Users/ethan/Code/doom84/doom84c/src/st_stuff.c), [`st_stuff.h`](file:///Users/ethan/Code/doom84/doom84c/src/st_stuff.h) | Health, armor, ammo numbers, mugshot pain faces, STBAR blits. |
| **`am_`** | **Automap** | [`am_map.c`](file:///Users/ethan/Code/doom84/doom84c/src/am_map.c), [`am_map.h`](file:///Users/ethan/Code/doom84/doom84c/src/am_map.h) | 2D vector automap with linedef flags and player directional cone. |
| **`v_`** | **Video** | [`v_video.c`](file:///Users/ethan/Code/doom84/doom84c/src/v_video.c), [`v_video.h`](file:///Users/ethan/Code/doom84/doom84c/src/v_video.h) | 2.5× nearest-neighbor LCD blitter (`d84_blit_viewport`). |

---

## 📦 Output Files

- **Calculator Program**: [`bin/DOOM84C.8xp`](file:///Users/ethan/Code/doom84/doom84c/bin/DOOM84C.8xp) (50.6 KB, ZX7 compressed)
- **AppVar Data**:
  - `bin/D84MAP.8xv` (E1M1 geometry, BSP nodes, linedefs, sectors, actors)
  - `bin/D84T0.8xv`, `bin/D84T1.8xv`, `bin/D84T2.8xv`, `bin/D84T3.8xv` (wall textures, flats, sprites)

---

## 🎮 Calculator Keymap

| Key | Action |
| :--- | :--- |
| **[↑] / [↓]** | Move forward / backward |
| **[←] / [→]** | Turn left / right |
| **[ALPHA]** (held) | Sprint |
| **[2nd]** (held) | Fire pistol |
| **[MATH]** | Use door / exit switch |
| **[GRAPH]** | Automap toggle |
| **[WINDOW]** | Cycle solid planes → textured planes → wireframe |
| **[TRACE]** | Cycle sampling modes (64×80 → ~43×80 → 32×80 → 128×80) |
| **[Y=]** | Pause / resume |
| **[ZOOM]** | Restart level |
| **[CLEAR]** | Exit back to TI-OS |

---

## 🛠️ Building

### 1. Build for TI-84 Plus CE
Requires the [CE C/C++ Toolchain (`CEdev`)](https://github.com/CE-Programming/toolchain):

```bash
cd doom84c
make clean
make
```

### 2. Run Test Suite (Host C Harness)
Validates 825 integrity checks and 3,792 direction/sector stress frames:

```bash
make check-host
```

### 3. Play Interactively on Desktop (macOS / Linux)
Requires SDL2 (`brew install sdl2`):

```bash
make play
```
