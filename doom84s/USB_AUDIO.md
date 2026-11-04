# Doom84 USB audio

The calculator mixes E1M1 music and up to four sampled sound effects into
4 kHz mono PCM, streamed over USB to the Doomvision browser receiver.
The native assembly BSP, wall/span kernels and viewport blitter remain active.

Latest build: `bin/doom84-usb-music5.zip`. Transfer all eight files to Archive
and run D84USB5. Keep archived D84UI, D84SFX, D84MAP and D84T0..3 from the
working SFX3 installation (`bin/doom84-usb-sfx3.zip` includes its UI/SFX files).
Keep the existing calculator libraries. Quit TI Connect CE, open Doomvision
`/usb` in Chrome, and connect **Doom84 USB PCM**.

D84USB3 startup and D84USB5 music playback were confirmed on hardware.
The user reports the optimized audio adds about 10 ms to rendering.

Music is ready-to-play unsigned 8-bit PCM, stored in seven archived banks.
The roughly 101-second render loops without copying the track into RAM.
The expanded executable is 64,922 bytes, checked below 64 KiB when packaged.
USB uses twelve queued packets and services events at most once per millisecond.

The C renderer uses O3 with function inlining disabled to fit the RAM budget;
audio is built with O3. The ROM-free 48 MHz mixer benchmark measures 7.2% CPU
for music alone and 33.6% with four effects. This excludes USB/game overhead.
Native output was byte-compared against the host reference.

## Build and checks

Install CEdev at ~/CEdev (or set CEDEV). The local source WAV files under
build/sounds are needed to regenerate audio assets; build_sounds.py extracts
and renders them from a local Doom WAD and sound setup. Source WAVs are not
included. Generated sample metadata and the calculator assets are included.

```
make usb-build
make check-host check-usb-audio
```

The mixer test checks the full music track, bank boundaries and looping,
all nine effects, USB cadence/timer wrap, disconnect and cleanup under
address/undefined-behavior sanitizers. The engine test has 825 checks.
The optional native timing harness in tools uses a ROM-free CEmu core.

Simulation uses a fixed 35 Hz timestep with up to six catch-up ticks per
rendered frame. Keys are currently sampled once per rendered frame.
