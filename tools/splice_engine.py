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

# 3. Extract Stage 2 _bsp from commit 1233cb9 and add PVS + early-out
stage2_bsp = subprocess.check_output(
    ["git", "show", "1233cb9:doom84s/src/engine.s"], text=True
)
m = re.search(r"(\.section\s+\.text\._bsp.*?)(?=\.section\s+\.text\.|\Z)", stage2_bsp, re.DOTALL)
if not m:
    sys.exit("Failed to find _bsp in 1233cb9")
bsp_code = m.group(1)

# Add open_columns early out to _bsp entry
bsp_code = bsp_code.replace(
    "_bsp:                                   ; @bsp\n",
    "_bsp:                                   ; @bsp\n\tld\ta, (_open_columns)\n\tor\ta, a\n\tret\tz\n"
)
# Add open_columns early out between near and far child
bsp_code = bsp_code.replace(
    "\tcall\t_bsp\n\tld\thl, 6\n\tadd\thl, sp\n\tld\tsp, hl\n\n\tld\ta, (ix - 6)",
    "\tcall\t_bsp\n\tld\thl, 6\n\tadd\thl, sp\n\tld\tsp, hl\n\n\tld\ta, (_open_columns)\n\tor\ta, a\n\tjr\tz, .Lbsp_return\n\n\tld\ta, (ix - 6)"
)
# Add open_columns early out in .Lbsp_seg
bsp_code = bsp_code.replace(
    ".Lbsp_seg:\n\tld\thl, (ix - 9)",
    ".Lbsp_seg:\n\tld\ta, (_open_columns)\n\tor\ta, a\n\tjr\tz, .Lbsp_return\n\tld\thl, (ix - 9)"
)
# Add PVS leaf check in .Lbsp_leaf
old_leaf = """\tld\tde, _materials
\tadd\thl, de
\tld\t(ix - 6), hl
.Lbsp_seg:"""
new_leaf = """\tld\tde, _materials
\tadd\thl, de
\tld\t(ix - 6), hl
\tld\tc, (hl)
\tld\ta, (_player+26)
\tpush\tbc
\tcall\t_pvs_test
\tpop\tbc
\tjr\tz, .Lbsp_return
.Lbsp_seg:"""
bsp_code = bsp_code.replace(old_leaf, new_leaf)

# Append _pvs_test routine
pvs_test_asm = """
	.type	_pvs_test,@function
_pvs_test:
	cp	a, 85
	jr	c, .Lfrom_ok
	or	a, 1
	ret
.Lfrom_ok:
	ld	b, a
	ld	a, c
	cp	a, 85
	jr	c, .Lto_ok
	or	a, 1
	ret
.Lto_ok:
	ld	hl, 0
	ld	h, 11
	ld	l, b
	mlt	hl
	ld	a, c
	rrca
	rrca
	rrca
	and	a, 0x1f
	ld	e, a
	ld	d, 0
	add	hl, de
	ld	de, _pvs_table
	add	hl, de
	ld	b, (hl)
	ld	a, c
	and	a, 7
	ld	e, a
	ld	d, 0
	ld	hl, .Lpvs_masks
	add	hl, de
	ld	a, (hl)
	and	a, b
	ret

.Lpvs_masks:
	.byte	1, 2, 4, 8, 16, 32, 64, 128
"""
bsp_code = bsp_code + "\n" + pvs_test_asm

# 4. Extract Stage 3 _d84_wall_column from commit 9ab297d
stage3_wall = subprocess.check_output(
    ["git", "show", "9ab297d:doom84s/src/engine.s"], text=True
)
m = re.search(r"(\.section\s+\.text\._d84_wall_column.*?)(?=\.section\s+\.rodata\._d84_wall_column|\.section\s+\.text\.|\Z)", stage3_wall, re.DOTALL)
if not m:
    sys.exit("Failed to find _d84_wall_column in 9ab297d")
wall_col_code = m.group(1)

# 5. Extract Stage 4 _render_columns from commit 276a800 and add open_columns tracking
stage4_rc = subprocess.check_output(
    ["git", "show", "276a800:doom84s/src/engine.s"], text=True
)
m = re.search(r"(\.equ RW_START, 0.*?\.section\s+\.text\._render_columns.*?)(?=\.section\s+\.text\.|\Z)", stage4_rc, re.DOTALL)
if not m:
    sys.exit("Failed to find _render_columns in 276a800")
rc_code = m.group(1)

old_col_write = """.Lcolumn_write:
    ld hl,(ix+RW_TOPPTR)
    ld a,(ix+RW_TOP)
    ld (hl),a
    ld de,(ix+RW_BOTTOMPTR)
    ld a,(ix+RW_BOTTOM)
    ld (de),a
    ld b,(ix+RW_STRIDE)
    dec b
    jr z,.Lcolumn_next
    /* Stop at VIEW_W so detail 3 near x=126 cannot write past cliptop[]. */
    ld a,(ix+RW_X)
    ld c,a
.Lduplicate_clip:
    inc c
    ld a,c
    cp a,128
    jr nc,.Lcolumn_next
    inc hl
    inc de
    ld a,(ix+RW_TOP)
    ld (hl),a
    ld a,(ix+RW_BOTTOM)
    ld (de),a
    djnz .Lduplicate_clip"""

new_col_write = """.Lcolumn_write:
    ld hl,(ix+RW_TOPPTR)
    ld a,(ix+RW_TOP)
    ld (hl),a
    ld de,(ix+RW_BOTTOMPTR)
    ld a,(ix+RW_BOTTOM)
    ld (de),a
    cp a,(ix+RW_TOP)
    jr c,.Lcol_dec
    jr z,.Lcol_dec
    jr .Lcol_stride
.Lcol_dec:
    ld a,(_open_columns)
    or a,a
    jr z,.Lcol_stride
    dec a
    ld (_open_columns),a
.Lcol_stride:
    ld b,(ix+RW_STRIDE)
    dec b
    jr z,.Lcolumn_next
    /* Stop at VIEW_W so detail 3 near x=126 cannot write past cliptop[]. */
    ld a,(ix+RW_X)
    ld c,a
.Lduplicate_clip:
    inc c
    ld a,c
    cp a,128
    jr nc,.Lcolumn_next
    inc hl
    inc de
    ld a,(ix+RW_TOP)
    ld (hl),a
    ld a,(ix+RW_BOTTOM)
    ld (de),a
    cp a,(ix+RW_TOP)
    jr c,.Ldup_dec
    jr z,.Ldup_dec
    jr .Ldup_loop_end
.Ldup_dec:
    ld a,(_open_columns)
    or a,a
    jr z,.Ldup_loop_end
    dec a
    ld (_open_columns),a
.Ldup_loop_end:
    djnz .Lduplicate_clip"""

rc_code = rc_code.replace(old_col_write, new_col_write)

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
