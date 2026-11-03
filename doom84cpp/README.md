# Doom84CPP: Glorious Modern C++20 Doom for TI-84 Plus CE

**Doom84CPP** is a pure, modern **C++20** implementation of the Doom E1M1 sector engine for the **TI-84 Plus CE** graphing calculator.

No assembly language (`.S` files), no procedural C global soup, and no ugly transpiler steps — built with first-class **Clang 19 C++20**, modern namespaces, zero-cost abstractions, encapsulation, and link-time optimization (LTO).

---

## ⚡ The Verdict: C++ vs C

| Metric | `doom84c` (Pure C) | `doom84cpp` (Modern C++20) |
| :--- | :--- | :--- |
| **Language Standard** | C11 | **C++20** (`-std=c++20`) |
| **Code Style** | Procedural C (`r_`, `p_`, `m_` prefixes, globals) | **Modern Object-Oriented (`doom::Engine`, `doom::World`, `doom::Renderer`)** |
| **Fixed-Point & Angles** | Macro math (`high_word`, `shr8`) | **Strongly-typed `Angle` & fixed-point methods** |
| **Test Suite** | 825 integrity checks | **825 integrity checks (100% PASS)** |
| **Stress Frames** | 3,792 direction/sector frames | **3,792 direction/sector frames (100% PASS)** |
| **Calculator Executable** | `bin/DOOM84C.8xp` (50.5 KB) | **`bin/DOOM84CP.8xp` (42.2 KB, ~16% SMALLER!)** |
| **Desktop Play** | SDL2 interactive player | **SDL2 interactive player (`make play`)** |

---

## 🏛️ Modern C++ Architecture

All subsystems live inside the clean `doom::` namespace:

```
doom84cpp/
├── src/
│   ├── doom/
│   │   ├── types.h / .cpp       # Core types, packed disk structs & assertions
│   │   ├── math.h / .cpp        # Fixed-point math, fast angle trig, screen projection
│   │   ├── map.h / .cpp         # Map asset unpacking and query subsystem
│   │   ├── player.h / .cpp      # Player entity, movement, combat, weapon state
│   │   ├── actor.h / .cpp       # Monsters, barrels, items, and animations
│   │   ├── world.h / .cpp       # Physics, blockmap collision, line-of-sight, AI
│   │   ├── renderer.h / .cpp    # BSP traversal, wall segs, visplanes, sprites
│   │   ├── draw.h / .cpp        # Low-level wall column & floor span rasterizers
│   │   ├── statusbar.h / .cpp   # Status bar, numbers, animated mugshot face
│   │   ├── automap.h / .cpp     # 2D vector minimap
│   │   ├── video.h / .cpp       # 2.5× nearest-neighbor LCD viewport blitter
│   │   └── engine.h / .cpp      # Top-level Engine facade encapsulating all objects
│   ├── main.cpp                 # Calculator entry point with double-buffering
│   ├── generated.h              # Level constants and lookup tables
│   ├── geometry.h               # Precomputed BSP bounding-box geometry
│   ├── gun.h                    # HUD weapon sprites
│   └── hud.h                    # Status bar & font sprites
├── tests/
│   ├── host.cpp                 # Automated test harness (825 checks)
│   └── play.cpp                 # Interactive SDL2 desktop player
├── bin/
│   ├── DOOM84CP.8xp             # TI-84 Plus CE executable (42.4 KB)
│   └── D84*.8xv                 # AppVar level and texture data
├── calc_files/                  # All files ready to transfer with TI Connect CE
└── makefile                     # Multi-target build system
```

---

## 🛠️ Building & Testing

### 1. Build for TI-84 Plus CE (Calculator)
Requires the [CE C/C++ Toolchain (`CEdev`)](https://github.com/CE-Programming/toolchain):

```bash
cd doom84cpp
make clean
make
```
Outputs `bin/DOOM84CP.8xp` (42.2 KB, ZX7 compressed).

### 2. Run Comprehensive Host Test Suite
Validates the full physics, BSP traversal, triggers, and sector mechanics across 825 automated tests:

```bash
make check-host
```
Output:
```
PASS: 825 checks; 3792 sector/direction stress frames
```

### 3. Play Interactively on Desktop (macOS / Linux)
Requires SDL2 (`brew install sdl2`):

```bash
make play
```

**Controls**:
- **`[W] [A] [S] [D]`** or **`[Arrow Keys]`**: Move & Turn
- **`[Shift]`**: Sprint
- **`[Ctrl]`** or **`[Z]`**: Fire Pistol
- **`[Space]`** or **`[E]`**: Use Doors & Switches
- **`[T]`**: Cycle Fast (Solid) → Textured → Wireframe mode
- **`[R]`**: Cycle sampling resolution (128 → 64 → 43 → 32 columns)
- **`[Tab]`**: Pause / Resume
- **`[Esc]`**: Quit

---

## 📲 How to Transfer to Calculator

1. Connect your **TI-84 Plus CE** via USB.
2. Open **TI Connect CE**.
3. Drag and drop all files from `calc_files/` into TI Connect CE:
   - `DOOM84CP.8xp`
   - `D84MAP.8xv`, `D84T0.8xv`, `D84T1.8xv`, `D84T2.8xv`, `D84T3.8xv`
   - `clibs.8xg` (if C libraries are not already installed)
4. Send all files to **Archive**.
5. Press `[prgm]`, select `DOOM84CP`, and rip and tear!
