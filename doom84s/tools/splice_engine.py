#!/usr/bin/env python3
import subprocess
import sys
import re

# 1. Compile engine_host.c to /tmp/raw_engine.s
cmd = [
    "ez80-clang", "-S",
    "-isystem", "/Users/ethan/CEdev/include",
    "-fno-autolink", "-fno-addrsig", "-fno-threadsafe-statics",
    "-fno-aligned-allocation", "-mllvm", "-z80-gas-style",
    "-ffunction-sections", "-fdata-sections", "-fno-math-errno",
    "-D__TICE__=1", "-O3", "-fno-omit-frame-pointer", "-DNDEBUG=1",
    "-Isrc", "tests/engine_host.c", "-o", "/tmp/raw_engine.s"
]
print("Running ez80-clang...")
subprocess.check_call(cmd, cwd=".")

with open("/tmp/raw_engine.s", "r") as f:
    content = f.read()

# 2. Extract Stage 1 _d84_blit_viewport from commit 60fac76
stage1_blit = subprocess.check_output(
    ["git", "show", "60fac76:doom84s/src/engine.s"], text=True
)
m = re.search(r"(\.section\s+\.text\._d84_blit_viewport.*?)(?=\.section\s+\.text\.|\Z)", stage1_blit, re.DOTALL)
if not m:
    sys.exit("Failed to find _d84_blit_viewport in 60fac76")
blit_code = m.group(1)

# 3. Extract Stage 2 _bsp from commit 1233cb9
stage2_bsp = subprocess.check_output(
    ["git", "show", "1233cb9:doom84s/src/engine.s"], text=True
)
m = re.search(r"(\.section\s+\.text\._bsp.*?)(?=\.section\s+\.text\.|\Z)", stage2_bsp, re.DOTALL)
if not m:
    sys.exit("Failed to find _bsp in 1233cb9")
bsp_code = m.group(1)

# 4. Extract Stage 3 _d84_wall_column from commit 9ab297d
stage3_wall = subprocess.check_output(
    ["git", "show", "9ab297d:doom84s/src/engine.s"], text=True
)
m = re.search(r"(\.section\s+\.text\._d84_wall_column.*?)(?=\.section\s+\.rodata\._d84_wall_column|\.section\s+\.text\.|\Z)", stage3_wall, re.DOTALL)
if not m:
    sys.exit("Failed to find _d84_wall_column in 9ab297d")
wall_col_code = m.group(1)

# 5. Extract Stage 4 _render_columns from commit 276a800
stage4_rc = subprocess.check_output(
    ["git", "show", "276a800:doom84s/src/engine.s"], text=True
)
m = re.search(r"(\.equ RW_START, 0.*?\.section\s+\.text\._render_columns.*?)(?=\.section\s+\.text\.|\Z)", stage4_rc, re.DOTALL)
if not m:
    sys.exit("Failed to find _render_columns in 276a800")
rc_code = m.group(1)

# Replace sections in content
def replace_section(src, sec_name, new_code):
    pattern = rf"(\.section\s+\.text\.{sec_name}.*?)(?=\.section\s+\.text\.|\.section\s+\.rodata\.{sec_name}|\Z)"
    match = re.search(pattern, src, re.DOTALL)
    if not match:
        raise ValueError(f"Could not find section {sec_name}")
    print(f"Replacing {sec_name} (lines {src[:match.start()].count(chr(10))} to {src[:match.end()].count(chr(10))})")
    return src[:match.start()] + new_code + src[match.end():]

content = replace_section(content, "_d84_blit_viewport", blit_code)
content = replace_section(content, "_bsp", bsp_code)
content = replace_section(content, "_d84_wall_column", wall_col_code)
content = replace_section(content, "_render_columns", rc_code)

# Append geometry.S and pixels.S (excluding blit_viewport)
with open("../doom84/src/geometry.S", "r") as f:
    geom = f.read()

with open("../doom84/src/pixels.S", "r") as f:
    pix = f.read()

# Remove blit_viewport from pixels.S since it's already in blit_code
m_pix_blit = re.search(r"\.section \.text\._d84_blit_viewport.*", pix, re.DOTALL)
if m_pix_blit:
    pix = pix[:m_pix_blit.start()]

# Disambiguate .Lwall_* labels in _d84_wall
pix = pix.replace(".Lwall_image", ".Lpix_wall_image")
pix = pix.replace(".Lwall_light", ".Lpix_wall_light")
pix = pix.replace(".Lwall_depth", ".Lpix_wall_depth")
pix = pix.replace(".Lwall_loop", ".Lpix_wall_loop")
pix = pix.replace(".Lwall_done", ".Lpix_wall_done")

combined = content + "\n\n" + geom + "\n\n" + pix

# Clean up any bad .size directives
combined = re.sub(r"\.size\t_render_columns[^\n]*\n", "", combined)
combined = re.sub(r"\.size\t_bsp[^\n]*\n", "", combined)
combined = re.sub(r"\.size\t_d84_wall_column[^\n]*\n", "", combined)
combined = re.sub(r"\.size\t_d84_blit_viewport[^\n]*\n", "", combined)

with open("src/engine.s", "w") as f:
    f.write(combined)

print("Updated src/engine.s successfully.")
