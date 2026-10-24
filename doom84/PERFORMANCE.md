# Assembly build measurements

This build replaces column clipping, wall texture setup, camera rotation,
projection and BSP traversal with eZ80 assembly. It retains the original
E1M1 geometry and wall textures. A conservative frustum test avoids traversing
boxes outside the view, including boxes crossing behind the camera.

Default quality remains 64×80 sampling with solid-color floors/ceilings,
expanded into a 128×80 framebuffer. TRACE cycles 64×80, 32×80 and 128×80.
WINDOW enables textured planes. The lower sampling modes replicate world
and sprite columns; the pistol and HUD retain their usual resolution.

Isolated renderer costs on CEmu ASIC I at 48 MHz:

| Scene | 128×80 flat | 64×80 flat | 32×80 flat |
| --- | ---: | ---: | ---: |
| Spawn | 102.51 ms | 80.62 ms | 69.57 ms |
| Courtyard | 109.45 ms | 83.24 ms | 66.84 ms |
| Later room | 100.08 ms | 73.19 ms | 58.76 ms |
| Spawn, diagonal | 103.93 ms | 82.28 ms | 69.09 ms |
| Courtyard, diagonal | 156.82 ms | 127.81 ms | 106.36 ms |

Spawn at default quality improved from 149.70 ms in the previous speed-test
build to 80.62 ms. The original emulated flat-plane baseline was 683 ms.
These are renderer timings, not whole-game FPS: input, TI-OS, LCD DMA,
viewport scaling, HUD drawing and presentation are excluded. Some views
still exceed 100 ms; hardware playability is not claimed from these numbers.

Validation: 62 emulated frames match the native C reference byte for byte;
9216 assembly arithmetic checks cover all camera angles and varied projection
inputs. Native tests cover 3792 sector/direction/detail frames. Enabling and
disabling frustum culling produces the same aggregate frame hash across that
stress sequence: eff19b7f05761d98. Simulation samples measured mean idle ticks
at 3.90 ms and forward ticks at 4.85 ms, down from 6.67 ms and 7.27 ms.

The main loop initializes both display buffers once and subsequently clears
only changing HUD bands. Static instructions are drawn once per buffer, the
opaque viewport replaces its prior contents, and the automap is clipped to
that viewport. These presentation changes are excluded from renderer timing.

Reproduce with `make`, `make check-host` and
`python3 tools/cemu_bench.py --cemu /path/to/CEmu`.
For the frustum comparison, run `D84_HASH_FRAMES=1 build/host --test`, rebuild
with `make host HOST_CFLAGS='-O2 -DD84_FRUSTUM_CULL=0'`, and repeat.
`build/cemu-benchmark.json` records all measurements and the CEmu commit.
