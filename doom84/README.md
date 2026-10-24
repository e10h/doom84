# E1M1 on the TI-84 Plus CE

An **optimized assembly prototype, with hardware performance still being tested**, alongside the
existing cube project. Full detail renders at 128×80; a doubled-column 64×80
mode and a 32×80 emergency mode are also available. All use a 256×160 viewport on the CE display.

This uses E1M1's real vertices, linedefs, sidedefs, segs, subsectors, BSP nodes,
sectors, blockmap, and thing placements from a supplied Doom shareware WAD.
It preserves the level's geometry instead of converting it to a tile grid.

**Status:** the first build was measured by the user at about 2 FPS, with
approximately 1000 ms rendering textured planes and 600 ms with flat planes.
It fails the playability requirement. The current revision
now renders those default-quality views in about 81–83 ms in emulation;
some other views still exceed 100 ms. See
[`PERFORMANCE.md`](PERFORMANCE.md). No playable whole-game FPS is claimed.
The screenshots are native renders of the shared C code.

![Native renders at 128×80, enlarged 2×](build/preview.png)

## Run on your CE

1. In TI Connect CE, send `bin/E1M1.8xp` and **all four** `bin/D84*.8xv`
   files to **Archive**. All five files must come from the same build.
2. The program uses the standard CE C libraries: LibLoad, GRAPHX, KEYPADC,
   and FILEIOC. The transfer ZIP includes the locally installed `clibs.8xg`
   group for convenience; send it too if those libraries are missing.
3. Launch `E1M1` using the same calculator launcher that runs `CUBE`.
   Use your existing Cesium/arTIfiCE setup if required by your OS.

The AppVars stay in archive and are read directly. If any is missing, in RAM,
the wrong size, or from a mismatched asset set, the program displays an error
before entering graphics mode. Archive all four again if that happens.

| Key | Action |
| --- | --- |
| Up / Down | Walk forward / backward |
| Left / Right | Turn |
| Alpha + Left / Right | Strafe |
| Mode, held | Run / turn faster |
| 2nd, held | Fire pistol |
| Enter | Use a door or the exit switch |
| Graph | Toggle automap; pauses simulation |
| Window | Toggle textured / solid-color planes |
| Trace | Cycle 64×80 → 32×80 → 128×80 sampling |
| Y= | Pause / resume |
| Zoom | Restart the level |
| Clear | Exit to TI-OS |

The default is 64×80 with solid-color planes. Trace cycles sampling modes;
Window enables textured planes. The framebuffer remains 128×80: lower
sampling modes duplicate each world/sprite column two or four times. The
pistol and HUD retain their usual resolution. These are explicit quality/performance settings;
the lower-resolution mode has not met the playability target either.

The header reports elapsed-time-corrected whole-program FPS and time spent rendering, in
milliseconds. Compare those at the starting position, facing the courtyard,
and during combat. Window provides a useful comparison of floor/ceiling
texture cost. Native desktop timings cannot predict CE performance.

## What this prototype implements

- Near-first BSP traversal, vertex-transform caching, conservative bounding-box
  culling, perspective-correct wall U coordinates, per-column portal clipping.
- Actual sector floor/ceiling heights, steps, windows, sky, upper/lower walls,
  and wall texture offsets and pegging. Wall/flats are reduced to 32×32 tiles.
- Perspective-mapped floor and ceiling spans, Doom's palette and colormaps,
  sector lighting and distance shading.
- 64×64 sprite assets, approximate depth-buffer occlusion, a pistol overlay,
  walking frames and corpse sprites.
- Radius collision accelerated by Doom's original blockmap; 24-unit steps
  and a 56-unit player clearance. Doors rise and remain open.
- E1M1's walk-over floor triggers 36 and 88, including a returning lift,
  and its special-11 exit switch.
- Basic hitscan pistol, enemy movement and attacks, health, armor, pickups,
  toxic-floor damage, deaths, kills, pause and restart.
- A fixed 35 Hz simulation accumulator with catch-up capped at six tics.
  If rendering falls substantially behind, game time slows instead of running
  an unbounded catch-up loop.

## What is still different from original Doom

This is a **new compact sector renderer and simplified game simulation**, not
the original Doom C engine port completed. Inspecting GBADoom/nRF52840Doom
confirmed that their ARM arithmetic, packed pointers, flash layout, and runtime
would need substantial adaptation. This first milestone establishes a working
CE memory layout and a measurable renderer using the actual level data.

Enemy movement, attacks and damage are approximate. Enemies currently face the
camera; rotation-specific sprites, original state tables, projectiles, pain
states, monster blocking and barrel explosions are not implemented. Only the
pistol is usable; other weapon/ammo pickups currently replenish pistol ammo.
Doors remain open, and floor movers approximate the two E1M1 trigger types.
Masked fence textures, exact sky projection, animated textures and lighting,
original visplanes, secrets/intermission scoring, sound, saves and demo
compatibility are not implemented. Depth occlusion is quantized to 16 world
units, so distant sprites may show artifacts.

The next original-engine milestone is replacing this simulation with Doom's
player/weapon/thinker/state logic, after profiling the prototype on a CE. No
claim of playable speed or vanilla compatibility is made by this build.

## Build

Requires the existing CEdev C toolchain and Python 3. Asset conversion uses
only the Python standard library. Supply your own WAD path:

```sh
cd doom84
make assets WAD=/absolute/path/to/doom1.wad
make -j2
make check-host
make preview
```

`src/generated.h`, `build/`, `bin/`, and `obj/` are generated and ignored by Git.
The WAD itself is neither copied into this project nor added to source control.
The converter's manifest records its SHA-256, selected skill and asset sizes.
Rebuild assets and executable together after changing the converter.

For native memory and undefined-behavior validation on macOS:

```sh
clang -std=c11 -g -O1 -fsanitize=address,undefined \
  -fno-omit-frame-pointer -Isrc src/engine.c tests/host.c -lm \
  -o build/host-sanitized
UBSAN_OPTIONS=halt_on_error=1 ./build/host-sanitized --test
```

The harness checks asset sizes and IDs, BSP classification, all eight
door approaches, both floor triggers, the exit switch, movement collision, a complete view rotation,
and 3792 sector/direction/detail stress renders. It runs the same integer C engine
used by the calculator. Struct-size assertions protect the disk format from
the CE's 24-bit `int` and pointer widths.

To render another location without running TI-OS:

```sh
./build/host --preview build/courtyard.ppm 1824 -3072 768
```

The final three arguments are world X, world Y, and a 0–1023 angle (0 = east,
256 = north). PPM output is intentionally dependency-free.

Optional arguments after the angle select textured planes (0/1) and column
step (1/2), respectively. To benchmark actual eZ80 instructions without a TI ROM:

```sh
python3 tools/cemu_bench.py --cemu /absolute/path/to/CEmu
```

This separately builds CEmu's public emulator core. It runs the compiled
renderer in an isolated memory layout on a 48 MHz ASIC-I model, compares 12
emulated images with the C reference, and records `build/cemu-benchmark.json`.
It excludes TI-OS, LCD DMA, presentation and simulation overhead. Its timings
are render costs, not measured calculator or whole-game FPS.

The pixel loops in `src/pixels.S` execute from program RAM and patch their
own immediate operands once per column/span. They require 256-byte-aligned
shade rows, preserve IX/IY, and are not suitable for executing directly from
flash. The current build uses approximately 59 KB of static BSS; there is
little heap space left, and the engine does not allocate dynamically.

## Layout and attribution

`src/engine.c` is platform-independent C; `src/main.c` supplies the calculator
display, timing, asset access and keyboard. `tools/build_assets.py` composes
patch textures, downsamples art and packages fixed-width map records into
archived AppVars. `tests/host.c` is the desktop verification harness.

The BSP traversal follows id Software's original Doom algorithm. Source in
this directory is GPL-2.0-or-later; see `LICENSE`. Doom art and level data
retain their separate original rights and are generated from the supplied WAD.
The cube project is unchanged.

References:

- https://github.com/id-Software/DOOM
- https://github.com/doomhack/GBADoom
- https://github.com/next-hack/nRF52840Doom
- https://ce-programming.github.io/toolchain/
