# Spinning 3D Colored Cube for TI-84 Plus CE

A high-performance, real-time 3D spinning colored cube written in C for the **TI-84 Plus CE** (and TI-83 Premium CE) graphing calculator.

Outputs a standard **`.8xp`** calculator program file ready to transfer and run.

---

## 📦 Output File

- **Executable**: [`bin/CUBE.8xp`](file:///Users/ethan/Code/cube84/bin/CUBE.8xp) (5.2 KB, ZX7 compressed)
- **Calculator Program Name**: `prgmCUBE`

---

## 🎮 Features & Controls

- **Full 3D Perspective Projection**: Smooth 3D rotation across X, Y, and Z axes.
- **Delta-Time (`dt`) Physics**: Frame-rate independent rotation so the cube rotates at the exact same physical speed whether in colored solid mode (~13 FPS) or wireframe mode (~33 FPS).
- **Real-Time FPS & Speed Display**: Live frames-per-second and rotation speed multiplier (`1.0x`) displayed in the top header.
- **6 Vibrant Colored Faces**:
  - Front: Crimson Red
  - Back: Sunset Orange
  - Top: Electric Blue
  - Bottom: Emerald Green
  - Right: Sunburst Yellow
  - Left: Vibrant Purple
- **Crisp Outlines & Shading**: Double-buffered rendering using `graphx` with back-face culling and Painter's algorithm depth sorting.
- **Interactive Keypad Controls**:
  - **`[+]` / `[-]`**: Increase / decrease rotation speed (from `0.1x` to `5.0x`).
  - **`[CLEAR]`**: Exit cleanly back to the TI-OS home screen.
  - **`[↑]` / `[↓]`**: Manually rotate / adjust pitch (X-axis).
  - **`[←]` / `[→]`**: Manually rotate / adjust yaw (Y-axis).
  - **`[2nd]`**: Pause / resume auto-rotation.
  - **`[ALPHA]`**: Toggle between **Solid Filled Polygons** and **Wireframe Mode**.

---

## 📲 How to Transfer to Calculator

1. Connect your **TI-84 Plus CE** to your computer via USB (mini-USB to USB-A or USB-C).
2. Open **[TI Connect CE](https://education.ti.com/en/products/computer-software/ti-connect-ce-software)** (or [TiLP](https://lpg.ticalc.org/prj_tilp/)).
3. Drag and drop [`bin/CUBE.8xp`](file:///Users/ethan/Code/cube84/bin/CUBE.8xp) into TI Connect CE.
4. Select your connected calculator and send to **Archive** (recommended).
5. On the calculator:
   - Press **`[prgm]`**
   - Select **`CUBE`** and press **`[enter]`** twice to run!

---

## 🛠️ Building from Source

This project uses the official **CE C/C++ Toolchain** (`CEdev`).

```bash
# In the cube84 directory:
make clean
make
```

The compiled program will be placed in `bin/CUBE.8xp`.

---

## 📁 Project Structure

```
cube84/
├── bin/
│   └── CUBE.8xp      # TI-84 Plus CE binary executable
├── src/
│   └── main.c        # 3D math, perspective projection, rendering & controls
├── icon.png          # 16x16 program icon displayed in TI-OS menu
├── makefile          # Build configuration targeting eZ80 with CEdev
└── README.md         # Documentation
```
