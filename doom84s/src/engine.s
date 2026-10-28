	.section	.text,"ax",@progbits
	.assume	ADL = 1
	.file	"engine.c"
	.section	.text._engine_sector,"ax",@progbits
	.globl	_engine_sector                  ; -- Begin function engine_sector
	.type	_engine_sector,@function
_engine_sector:                         ; @engine_sector
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 20
	ld	sp, hl
	ld	de, 235
	ld	hl, (_nodes)
	ld	(ix - 12), hl
	.local	.LBB0_1
.LBB0_1:                                ; =>This Inner Loop Header: Depth=1
	ex	de, hl
	ld	bc, 255
	call	__iand
	add	hl, hl
	ex	de, hl
	ld	hl, _node_offsets
	add	hl, de
	ld	hl, (hl)
	ld	bc, 0
	push	bc
	pop	de
	ld	e, l
	ld	d, h
	ld	iy, (ix - 12)
	add	iy, de
	ld	de, (iy + 4)
	ld	(ix - 15), de
	sbc.sis	hl, hl
	adc.sis	hl, de
	ld	(ix - 9), iy
	jp	nz, .LBB0_4
; %bb.2:                                ;   in Loop: Header=BB0_1 Depth=1
	ld	de, (iy)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, (iy + 6)
	ld	(ix - 15), de
	ld	iy, (ix + 6)
	ld	de, -8388608
	add	iy, de
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	nc, .LBB0_8
; %bb.3:                                ;   in Loop: Header=BB0_1 Depth=1
	ld	hl, (ix - 15)
                                        ; kill: def $hl killed $hl killed $uhl
	push	bc
	pop	de
	ld	c, 15
	call	__sshru
	push	de
	pop	bc
	ld	iy, 0
	jr	.LBB0_7
	.local	.LBB0_4
.LBB0_4:                                ;   in Loop: Header=BB0_1 Depth=1
	ld	de, (iy + 6)
	sbc.sis	hl, hl
	adc.sis	hl, de
	jp	nz, .LBB0_9
; %bb.5:                                ;   in Loop: Header=BB0_1 Depth=1
	ld	bc, (iy + 2)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	iy, (ix - 15)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	c, 15
	call	__sshru
	ld	(ix - 18), l
	ld	(ix - 17), h
	ld.sis	bc, -32768
	add.sis	iy, bc
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	inc.sis	bc
	or	a, a
	sbc.sis	hl, bc
	sbc	hl, hl
	push	hl
	pop	iy
	ld	hl, (ix + 9)
	ld	bc, -8388608
	add	hl, bc
	push	hl
	pop	bc
	ex	de, hl
	ld	de, -8388608
	add	hl, de
	or	a, a
	sbc	hl, bc
	jp	c, .LBB0_11
; %bb.6:                                ;   in Loop: Header=BB0_1 Depth=1
	ld	bc, 0
	push	bc
	pop	iy
	ld	l, (ix - 18)
	ld	h, (ix - 17)
	.local	.LBB0_7
.LBB0_7:                                ;   in Loop: Header=BB0_1 Depth=1
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	jp	.LBB0_13
	.local	.LBB0_8
.LBB0_8:                                ;   in Loop: Header=BB0_1 Depth=1
	ld.sis	de, -32768
	ld	hl, (ix - 15)
	add.sis	hl, de
                                        ; kill: def $hl killed $hl killed $uhl
	inc.sis	de
	or	a, a
	sbc.sis	hl, de
	sbc	hl, hl
	push	hl
	pop	iy
	inc	iy
	jp	.LBB0_13
	.local	.LBB0_9
.LBB0_9:                                ;   in Loop: Header=BB0_1 Depth=1
	ld	iy, (iy)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	ld	hl, (ix + 6)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	ld	(ix - 6), iy
	ld	a, (ix - 4)
	rlc	a
	sbc	a, a
	ld	(ix - 18), a                    ; 1-byte Folded Spill
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	rlc	d
	sbc	a, a
	lea	hl, iy + 0
	ld	e, (ix - 18)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 18), hl
	ld	(ix - 19), e                    ; 1-byte Folded Spill
	ld	iy, (ix - 9)
	ld	bc, (iy + 2)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	hl, (ix + 9)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	(ix - 3), iy
	ld	a, (ix - 1)
	rlc	a
	sbc	a, a
	ld	(ix - 20), a                    ; 1-byte Folded Spill
	ld	de, (ix - 15)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	rlc	d
	sbc	a, a
	lea	hl, iy + 0
	ld	e, (ix - 20)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	bc, (ix - 18)
	ld	a, (ix - 19)                    ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	iy, 1
	jp	p, .LBB0_12
; %bb.10:                               ;   in Loop: Header=BB0_1 Depth=1
	ld	iy, 0
	jr	.LBB0_12
	.local	.LBB0_11
.LBB0_11:                               ;   in Loop: Header=BB0_1 Depth=1
	inc	iy
	.local	.LBB0_12
.LBB0_12:                               ;   in Loop: Header=BB0_1 Depth=1
	ld	bc, 0
	.local	.LBB0_13
.LBB0_13:                               ;   in Loop: Header=BB0_1 Depth=1
	add	iy, iy
	lea	de, iy + 0
	ld	iy, (ix - 9)
	add	iy, de
	ld	iy, (iy + 24)
	push	bc
	pop	de
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	bc, -32768
	add.sis	hl, bc
	or	a, a
	sbc.sis	hl, bc
	jp	nc, .LBB0_1
; %bb.14:
	ld	bc, (_subsectors)
	ld	l, 127
	ld	a, iyh
	and	a, l
	ld	iyh, a
	or	a, a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	de, (_segs)
	ld	(ix - 9), de
	add	hl, hl
	add	hl, hl
	ex	de, hl
	push	bc
	pop	iy
	add	iy, de
	ld	bc, (iy + 2)
	ld	de, 0
	push	de
	pop	hl
	ld	l, c
	ld	h, b
	ld	bc, 14
	call	__imulu
	push	hl
	pop	bc
	ld	iy, (ix - 9)
	add	iy, bc
	ld	hl, (_sides)
	ld	(ix - 9), hl
	ld	hl, (_map_lines)
	ld	(ix - 12), hl
	ld	bc, (iy + 6)
	push	de
	pop	hl
	ld	l, c
	ld	h, b
	ld	bc, (iy + 8)
	push	de
	pop	iy
	ld	iyl, c
	ld	iyh, b
	ld	bc, 14
	call	__imulu
	push	hl
	pop	bc
	ld	hl, (ix - 12)
	add	hl, bc
	add	iy, iy
	lea	bc, iy + 0
	push	hl
	pop	iy
	add	iy, bc
	ld	hl, (iy + 10)
	ld	e, l
	ld	d, h
	ex	de, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	iy, (ix - 9)
	add	iy, de
	ld	a, (iy + 7)
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end0
.Lfunc_end0:
	.size	_engine_sector, .Lfunc_end0-_engine_sector
                                        ; -- End function
	.section	.text._engine_init,"ax",@progbits
	.globl	_engine_init                    ; -- Begin function engine_init
	.type	_engine_init,@function
_engine_init:                           ; @engine_init
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 88
	ld	sp, hl
	ld	hl, (ix + 9)
	ld	bc, 0
	xor	a, a
	ld	de, 49528
	sbc	hl, de
	jp	nz, .LBB1_49
; %bb.1:
	ld	(ix - 30), a                    ; 1-byte Folded Spill
	ld	(ix - 33), bc
	ld	de, (ix + 6)
	ld	hl, _.str
	ld	bc, 8
	push	bc
	push	hl
	push	de
	call	_memcmp
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB1_48
; %bb.2:
	ld	hl, _asset_id
	ld	de, 8
	push	de
	push	hl
	ld	iy, (ix + 6)
	pea	iy + 8
	call	_memcmp
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB1_50
; %bb.3:
	ld	hl, (ix + 15)
	ld	hl, (hl)
	ld	de, 58384
	or	a, a
	sbc	hl, de
	jp	nz, .LBB1_50
; %bb.4:
	ld	hl, (ix + 12)
	ld	de, _.str.1
	ld	bc, (hl)
	ld	hl, 8
	push	hl
	push	de
	ld	(ix - 36), bc
	push	bc
	call	_memcmp
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB1_50
; %bb.5:
	ld	hl, 8
	push	hl
	ld	hl, _asset_id
	push	hl
	ld	iy, (ix - 36)
	pea	iy + 8
	call	_memcmp
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB1_50
; %bb.6:
	ld	iy, (ix + 15)
	ld	hl, (iy + 3)
	ld	de, 61456
	or	a, a
	sbc	hl, de
	jp	nz, .LBB1_50
; %bb.7:
	ld	iy, (ix + 12)
	ld	de, (iy + 3)
	ld	hl, 8
	push	hl
	ld	hl, _.str.1
	push	hl
	ld	(ix - 36), de
	push	de
	call	_memcmp
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB1_50
; %bb.8:
	ld	hl, 8
	push	hl
	ld	hl, _asset_id
	push	hl
	ld	iy, (ix - 36)
	pea	iy + 8
	call	_memcmp
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB1_50
; %bb.9:
	ld	iy, (ix + 15)
	ld	hl, (iy + 6)
	ld	de, 58384
	or	a, a
	sbc	hl, de
	jp	nz, .LBB1_50
; %bb.10:
	ld	iy, (ix + 12)
	ld	de, (iy + 6)
	ld	hl, 8
	push	hl
	ld	hl, _.str.1
	push	hl
	ld	(ix - 36), de
	push	de
	call	_memcmp
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB1_50
; %bb.11:
	ld	hl, 8
	push	hl
	ld	hl, _asset_id
	push	hl
	ld	iy, (ix - 36)
	pea	iy + 8
	call	_memcmp
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB1_50
; %bb.12:
	ld	iy, (ix + 15)
	ld	hl, (iy + 9)
	ld	de, 8208
	or	a, a
	sbc	hl, de
	jp	nz, .LBB1_50
; %bb.13:
	ld	iy, (ix + 12)
	ld	de, (iy + 9)
	ld	hl, 8
	push	hl
	ld	hl, _.str.1
	push	hl
	ld	(ix - 36), de
	push	de
	call	_memcmp
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB1_50
; %bb.14:
	ld	hl, 8
	push	hl
	ld	hl, _asset_id
	push	hl
	ld	iy, (ix - 36)
	pea	iy + 8
	call	_memcmp
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB1_50
; %bb.15:
	ld	hl, _sector_offsets
	ld	(ix - 60), hl
	ld	hl, 32
	ld	(ix - 75), hl
	ld	hl, 64
	ld	(ix - 72), hl
	ld	hl, 96
	ld	(ix - 69), hl
	ld	hl, 128
	ld	(ix - 66), hl
	ld	hl, 160
	ld	(ix - 63), hl
	ld	hl, _small_reciprocals+3
	ld	(ix - 45), hl
	ld	hl, _reciprocal_table+2
	ld	(ix - 42), hl
	ld	hl, _tile_offset
	ld	(ix - 39), hl
	ld	hl, _materials+4
	ld	(ix - 36), hl
	scf
	sbc	hl, hl
	ld	(ix - 57), hl
	ld	hl, (ix + 6)
	push	hl
	pop	iy
	lea	hl, iy + 16
	ld	(_map_vertices), hl
	ld	de, 1884
	lea	hl, iy + 0
	add	hl, de
	ld	(ix - 88), hl
	ld	(_map_lines), hl
	ld	de, 8534
	lea	hl, iy + 0
	add	hl, de
	ld	(ix - 48), hl
	ld	(_sides), hl
	ld	bc, 13718
	lea	hl, iy + 0
	lea	de, iy + 0
	add	hl, bc
	ld	(ix - 78), hl
	ld	(_map_sectors), hl
	ld	bc, 14568
	add	iy, bc
	ld	(_segs), iy
	ld	bc, 24816
	push	de
	pop	iy
	add	iy, bc
	ld	(_subsectors), iy
	ld	bc, 25764
	push	de
	pop	iy
	add	iy, bc
	ld	(_nodes), iy
	ld	bc, 32372
	push	de
	pop	iy
	add	iy, bc
	ld	(_map_actors), iy
	ld	bc, 33646
	push	de
	pop	iy
	add	iy, bc
	ld	(_blockmap), iy
	ld	bc, 40568
	push	de
	pop	hl
	add	hl, bc
	ld	(ix - 54), hl
	ld	(_map_palette), hl
	ld	bc, 41336
	push	de
	pop	iy
	add	iy, bc
	ld	de, _ram_colormaps
	lea	hl, iy + 0
	ld	bc, 8192
	ldir
	ld	hl, _ram_colormaps
	ld	(_colormaps), hl
	ld	(_shade_rows), hl
	ld	hl, _ram_colormaps+256
	ld	(_shade_rows+3), hl
	ld	hl, _ram_colormaps+512
	ld	(_shade_rows+6), hl
	ld	hl, _ram_colormaps+768
	ld	(_shade_rows+9), hl
	ld	hl, _ram_colormaps+1024
	ld	(_shade_rows+12), hl
	ld	hl, _ram_colormaps+1280
	ld	(_shade_rows+15), hl
	ld	hl, _ram_colormaps+1536
	ld	(_shade_rows+18), hl
	ld	hl, _ram_colormaps+1792
	ld	(_shade_rows+21), hl
	ld	hl, _ram_colormaps+2048
	ld	(_shade_rows+24), hl
	ld	hl, _ram_colormaps+2304
	ld	(_shade_rows+27), hl
	ld	hl, _ram_colormaps+2560
	ld	(_shade_rows+30), hl
	ld	hl, _ram_colormaps+2816
	ld	(_shade_rows+33), hl
	ld	hl, _ram_colormaps+3072
	ld	(_shade_rows+36), hl
	ld	hl, _ram_colormaps+3328
	ld	(_shade_rows+39), hl
	ld	hl, _ram_colormaps+3584
	ld	(_shade_rows+42), hl
	ld	hl, _ram_colormaps+3840
	ld	(_shade_rows+45), hl
	ld	hl, _ram_colormaps+4096
	ld	(_shade_rows+48), hl
	ld	hl, _ram_colormaps+4352
	ld	(_shade_rows+51), hl
	ld	hl, _ram_colormaps+4608
	ld	(_shade_rows+54), hl
	ld	hl, _ram_colormaps+4864
	ld	(_shade_rows+57), hl
	ld	hl, _ram_colormaps+5120
	ld	(_shade_rows+60), hl
	ld	hl, _ram_colormaps+5376
	ld	(_shade_rows+63), hl
	ld	hl, _ram_colormaps+5632
	ld	(_shade_rows+66), hl
	ld	hl, _ram_colormaps+5888
	ld	(_shade_rows+69), hl
	ld	hl, _ram_colormaps+6144
	ld	(_shade_rows+72), hl
	ld	hl, _ram_colormaps+6400
	ld	(_shade_rows+75), hl
	ld	hl, _ram_colormaps+6656
	ld	(_shade_rows+78), hl
	ld	hl, _ram_colormaps+6912
	ld	(_shade_rows+81), hl
	ld	hl, _ram_colormaps+7168
	ld	(_shade_rows+84), hl
	ld	hl, _ram_colormaps+7424
	ld	(_shade_rows+87), hl
	ld	hl, _ram_colormaps+7680
	ld	(_shade_rows+90), hl
	ld	hl, _ram_colormaps+7936
	ld	(_shade_rows+93), hl
	ld	bc, 1
	.local	.LBB1_16
.LBB1_16:                               ; =>This Inner Loop Header: Depth=1
	ld	hl, 1048576
	call	__idivu
	push	hl
	pop	iy
	ld	hl, (ix - 42)
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	push	bc
	pop	hl
	ld	de, 17
	or	a, a
	sbc	hl, de
	ld	de, (ix - 45)
	jr	nc, .LBB1_18
; %bb.17:                               ;   in Loop: Header=BB1_16 Depth=1
	push	de
	pop	hl
	ld	(hl), iy
	.local	.LBB1_18
.LBB1_18:                               ;   in Loop: Header=BB1_16 Depth=1
	inc	bc
	ld	iy, (ix - 42)
	lea	iy, iy + 2
	ld	(ix - 42), iy
	push	de
	pop	iy
	lea	iy, iy + 3
	ld	(ix - 45), iy
	push	bc
	pop	hl
	ld	de, 2049
	or	a, a
	sbc	hl, de
	jr	nz, .LBB1_16
; %bb.19:
	ld	hl, _images
	ld	(ix - 42), hl
	ld	de, 0
	.local	.LBB1_20
.LBB1_20:                               ; =>This Inner Loop Header: Depth=1
	ld	hl, _tile_bank
	add	hl, de
	ld	a, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, a
	ld	bc, 3
	call	__imulu
	push	hl
	pop	bc
	ld	iy, (ix + 12)
	add	iy, bc
	ld	iy, (iy)
	ld	hl, (ix - 39)
	ld	hl, (hl)
	ld	bc, 0
	ld	c, l
	ld	b, h
	lea	hl, iy + 0
	add	hl, bc
	ld	iy, (ix - 42)
	ld	(iy), hl
	inc	de
	lea	iy, iy + 3
	ld	(ix - 42), iy
	ld	iy, (ix - 39)
	lea	iy, iy + 2
	ld	(ix - 39), iy
	push	de
	pop	hl
	ld	bc, 86
	or	a, a
	sbc	hl, bc
	jr	nz, .LBB1_20
; %bb.21:
	ld	bc, 0
	push	bc
	pop	de
	.local	.LBB1_22
.LBB1_22:                               ; =>This Inner Loop Header: Depth=1
	ld	hl, (ix + 6)
	ld	(ix - 45), de
	add	hl, de
	push	hl
	pop	iy
	ld	de, 14576
	add	iy, de
	ld	(ix - 42), iy
	ld	de, 14574
	add	hl, de
	ld	de, (hl)
	push	bc
	pop	hl
	ld	l, e
	ld	h, d
	ld	bc, 14
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 88)
	add	iy, de
	ld	(ix - 51), iy
	lea	bc, iy + 10
	ld	(ix - 39), bc
	ld	hl, (ix - 42)
	ld	hl, (hl)
	ld	iy, 0
	lea	de, iy + 0
	ld	e, l
	ld	d, h
	ld	(ix - 84), de
	ex	de, hl
	add	hl, hl
	ex	de, hl
	push	bc
	pop	hl
	add	hl, de
	ld	de, (hl)
	lea	hl, iy + 0
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	iy, (ix - 48)
	add	iy, de
	ld	(ix - 81), iy
	ld	a, (iy + 7)
	ld	(ix - 42), a
	ld	hl, (ix - 84)
	ld	bc, 1
	call	__ixor
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, (ix - 39)
	add	hl, bc
	ld	bc, (hl)
	ld	l, c
	ld	h, b
	ld.sis	de, -1
	or	a, a
	sbc.sis	hl, de
	ld	a, d
	ld	(ix - 39), a                    ; 1-byte Folded Spill
	jr	z, .LBB1_24
; %bb.23:                               ;   in Loop: Header=BB1_22 Depth=1
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	ld	iy, (ix - 48)
	add	iy, bc
	ld	a, (iy + 7)
	ld	(ix - 39), a
	.local	.LBB1_24
.LBB1_24:                               ;   in Loop: Header=BB1_22 Depth=1
	ld	iy, (ix - 81)
	ld	b, (iy + 6)
	ld	a, (iy + 4)
	ld	(ix - 84), a
	ld	a, (iy + 5)
	lea	hl, iy + 0
	ld	(ix - 85), a
	ld	iy, (ix - 51)
	ld	a, (iy + 4)
	push	hl
	pop	iy
	ld	hl, (iy)
	ld	de, (iy + 2)
	ld	iy, (ix - 36)
	ld	c, (ix - 42)
	ld	(iy - 4), c
	ld	c, (ix - 39)                    ; 1-byte Folded Reload
	ld	(iy - 3), c
	ld	(iy - 2), b
	ld	b, (ix - 84)
	ld	(iy - 1), b
	ld	b, (ix - 85)
	ld	(iy), b
	ld	(iy + 2), l
	ld	(iy + 3), h
	ld	(iy + 4), e
	ld	(iy + 5), d
	ld	l, 127
	ld	(ix - 51), a                    ; 1-byte Folded Spill
	and	a, l
	ld	l, a
	ld	(iy + 1), l
	ld	a, c
	cp	a, -1
	jr	z, .LBB1_29
; %bb.25:                               ;   in Loop: Header=BB1_22 Depth=1
	ld	de, 0
	push	de
	pop	hl
	ld	l, (ix - 42)                    ; 1-byte Folded Reload
	add	hl, hl
	push	hl
	pop	bc
	ld	iy, _sector_offsets
	lea	hl, iy + 0
	add	hl, bc
	ld	hl, (hl)
	push	de
	pop	bc
	ld	c, l
	ld	b, h
	ld	iy, (ix - 78)
	lea	hl, iy + 0
	add	hl, bc
	ld	(ix - 42), hl
	push	de
	pop	hl
	ld	l, (ix - 39)                    ; 1-byte Folded Reload
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _sector_offsets
	add	hl, bc
	ld	hl, (hl)
	ld	e, l
	ld	d, h
	add	iy, de
	lea	bc, iy + 0
	ld	l, (iy + 4)
	ld	iy, (ix - 42)
	lea	de, iy + 0
	ld	a, (iy + 4)
	cp	a, l
	jr	nz, .LBB1_29
; %bb.26:                               ;   in Loop: Header=BB1_22 Depth=1
	push	bc
	pop	iy
	ld	l, (iy + 5)
	push	de
	pop	iy
	ld	a, (iy + 5)
	cp	a, l
	jr	nz, .LBB1_29
; %bb.27:                               ;   in Loop: Header=BB1_22 Depth=1
	push	bc
	pop	iy
	ld	l, (iy + 6)
	push	de
	pop	iy
	ld	a, (iy + 6)
	cp	a, l
	jr	nz, .LBB1_29
; %bb.28:                               ;   in Loop: Header=BB1_22 Depth=1
	ld	l, -128
	ld	a, (ix - 51)
	or	a, l
	ld	l, a
	ld	iy, (ix - 36)
	ld	(iy + 1), l
	.local	.LBB1_29
.LBB1_29:                               ;   in Loop: Header=BB1_22 Depth=1
	ld	hl, (ix - 45)
	ld	de, 14
	add	hl, de
	ld	iy, (ix - 36)
	lea	iy, iy + 10
	ld	(ix - 36), iy
	push	hl
	pop	bc
	ld	de, 10248
	or	a, a
	sbc	hl, de
	push	bc
	pop	de
	ld	bc, 0
	jp	nz, .LBB1_22
; %bb.30:
	ld	hl, (_images+237)
	ld	(ix - 51), hl
	ld	(ix - 48), bc
	push	bc
	pop	iy
	ld	(ix - 36), bc
	xor	a, a
	ld	(ix - 39), a                    ; 1-byte Folded Spill
	ld	(ix - 42), bc
	ld	(ix - 45), a                    ; 1-byte Folded Spill
	.local	.LBB1_31
.LBB1_31:                               ; =>This Inner Loop Header: Depth=1
	ld	hl, (ix - 51)
	lea	de, iy + 0
	ld	(ix - 81), de
	add	hl, de
	ld	a, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, a
	ld	bc, 3
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 54)
	add	iy, de
	ld	a, (iy)
	ld	d, b
	ld	(ix - 27), d
	ld	bc, (ix - 29)
	ld	b, d
	ld	c, a
	or	a, a
	sbc	hl, hl
	ld	a, l
	ld	hl, (ix - 48)
	ld	e, (ix - 30)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 48), hl
	ld	(ix - 30), e                    ; 1-byte Folded Spill
	ld	l, (iy + 1)
	ld	(ix - 26), d
	ld	bc, (ix - 28)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 42)
	ld	e, (ix - 45)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 42), hl
	ld	(ix - 45), e                    ; 1-byte Folded Spill
	ld	l, (iy + 2)
	ld	(ix - 25), d
	ld	bc, (ix - 27)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 36)
	ld	e, (ix - 39)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 36), hl
	ld	(ix - 39), e                    ; 1-byte Folded Spill
	ld	hl, (ix - 81)
	inc	hl
	push	hl
	pop	iy
	ld	de, 32
	or	a, a
	sbc	hl, de
	jp	nz, .LBB1_31
	.local	.LBB1_32
.LBB1_32:                               ; =>This Inner Loop Header: Depth=1
	ld	hl, (ix - 51)
	ld	de, (ix - 75)
	add	hl, de
	ld	e, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	bc, 3
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 54)
	add	iy, de
	ld	l, (iy)
	ld	d, b
	ld	(ix - 24), d
	ld	bc, (ix - 26)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 48)
	ld	e, (ix - 30)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 48), hl
	ld	(ix - 30), e                    ; 1-byte Folded Spill
	ld	l, (iy + 1)
	ld	(ix - 23), d
	ld	bc, (ix - 25)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 42)
	ld	e, (ix - 45)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 42), hl
	ld	(ix - 45), e                    ; 1-byte Folded Spill
	ld	l, (iy + 2)
	ld	(ix - 22), d
	ld	bc, (ix - 24)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 36)
	ld	e, (ix - 39)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 36), hl
	ld	(ix - 39), e                    ; 1-byte Folded Spill
	ld	hl, (ix - 75)
	inc	hl
	ld	(ix - 75), hl
	ld	de, 64
	or	a, a
	sbc	hl, de
	jr	nz, .LBB1_32
	.local	.LBB1_33
.LBB1_33:                               ; =>This Inner Loop Header: Depth=1
	ld	hl, (ix - 51)
	ld	de, (ix - 72)
	add	hl, de
	ld	e, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	bc, 3
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 54)
	add	iy, de
	ld	l, (iy)
	ld	d, b
	ld	(ix - 21), d
	ld	bc, (ix - 23)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 48)
	ld	e, (ix - 30)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 48), hl
	ld	(ix - 30), e                    ; 1-byte Folded Spill
	ld	l, (iy + 1)
	ld	(ix - 20), d
	ld	bc, (ix - 22)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 42)
	ld	e, (ix - 45)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 42), hl
	ld	(ix - 45), e                    ; 1-byte Folded Spill
	ld	l, (iy + 2)
	ld	(ix - 19), d
	ld	bc, (ix - 21)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 36)
	ld	e, (ix - 39)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 36), hl
	ld	(ix - 39), e                    ; 1-byte Folded Spill
	ld	hl, (ix - 72)
	inc	hl
	ld	(ix - 72), hl
	ld	de, 96
	or	a, a
	sbc	hl, de
	jr	nz, .LBB1_33
	.local	.LBB1_34
.LBB1_34:                               ; =>This Inner Loop Header: Depth=1
	ld	hl, (ix - 51)
	ld	de, (ix - 69)
	add	hl, de
	ld	e, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	bc, 3
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 54)
	add	iy, de
	ld	l, (iy)
	ld	d, b
	ld	(ix - 18), d
	ld	bc, (ix - 20)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 48)
	ld	e, (ix - 30)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 48), hl
	ld	(ix - 30), e                    ; 1-byte Folded Spill
	ld	l, (iy + 1)
	ld	(ix - 17), d
	ld	bc, (ix - 19)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 42)
	ld	e, (ix - 45)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 42), hl
	ld	(ix - 45), e                    ; 1-byte Folded Spill
	ld	l, (iy + 2)
	ld	(ix - 16), d
	ld	bc, (ix - 18)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 36)
	ld	e, (ix - 39)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 36), hl
	ld	(ix - 39), e                    ; 1-byte Folded Spill
	ld	hl, (ix - 69)
	inc	hl
	ld	(ix - 69), hl
	ld	de, 128
	or	a, a
	sbc	hl, de
	jr	nz, .LBB1_34
	.local	.LBB1_35
.LBB1_35:                               ; =>This Inner Loop Header: Depth=1
	ld	hl, (ix - 51)
	ld	de, (ix - 66)
	add	hl, de
	ld	e, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	bc, 3
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 54)
	add	iy, de
	ld	l, (iy)
	ld	d, b
	ld	(ix - 15), d
	ld	bc, (ix - 17)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 48)
	ld	e, (ix - 30)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 48), hl
	ld	(ix - 30), e                    ; 1-byte Folded Spill
	ld	l, (iy + 1)
	ld	(ix - 14), d
	ld	bc, (ix - 16)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 42)
	ld	e, (ix - 45)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 42), hl
	ld	(ix - 45), e                    ; 1-byte Folded Spill
	ld	l, (iy + 2)
	ld	(ix - 13), d
	ld	bc, (ix - 15)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 36)
	ld	e, (ix - 39)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 36), hl
	ld	(ix - 39), e                    ; 1-byte Folded Spill
	ld	hl, (ix - 66)
	inc	hl
	ld	(ix - 66), hl
	ld	de, 160
	or	a, a
	sbc	hl, de
	jr	nz, .LBB1_35
	.local	.LBB1_36
.LBB1_36:                               ; =>This Inner Loop Header: Depth=1
	ld	hl, (ix - 51)
	ld	de, (ix - 63)
	add	hl, de
	ld	e, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	bc, 3
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 54)
	add	iy, de
	ld	l, (iy)
	ld	d, b
	ld	(ix - 12), d
	ld	bc, (ix - 14)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 48)
	ld	e, (ix - 30)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 48), hl
	ld	(ix - 30), e                    ; 1-byte Folded Spill
	ld	l, (iy + 1)
	ld	(ix - 11), d
	ld	bc, (ix - 13)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 42)
	ld	e, (ix - 45)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 42), hl
	ld	(ix - 45), e                    ; 1-byte Folded Spill
	ld	l, (iy + 2)
	ld	(ix - 10), d
	ld	bc, (ix - 12)
	ld	b, d
	ld	c, l
	ld	hl, (ix - 36)
	ld	e, (ix - 39)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 36), hl
	ld	(ix - 39), e                    ; 1-byte Folded Spill
	ld	hl, (ix - 63)
	inc	hl
	ld	(ix - 63), hl
	ld	de, 192
	or	a, a
	sbc	hl, de
	jr	nz, .LBB1_36
; %bb.37:
	ld	iyl, -86
	xor	a, a
	ld	(ix - 9), a
	ld	de, (ix - 11)
	ld	d, a
	ld	e, (ix - 30)                    ; 1-byte Folded Reload
	sbc	hl, hl
	ld	c, l
	ld	b, h
	ld	(ix - 30), bc
	ld	h, -85
	ex	de, hl
	ld	e, iyl
	ex	de, hl
	ld	(ix - 8), l
	ld	iy, (ix - 10)
	ex	de, hl
	ld	iyh, e
	ld	iyl, d
	ex	de, hl
	ld	(ix - 7), a
	ld	hl, (ix - 9)
	ld	h, a
	ld	a, -86
	ld	l, a
	push	bc
	push	hl
	push	iy
	ld	hl, (ix - 48)
                                        ; kill: def $bc killed $bc killed $ubc
	call	__llmulu
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	ld	iy, 32
	push	iy
	call	__llshru
	push	hl
	pop	bc
	pop	hl
	ld	a, e
	ld	l, 7
	call	__lshru
	ld	(ix - 48), bc
	xor	a, a
	ld	(ix - 6), a
	ld	de, (ix - 8)
	ld	d, a
	ld	e, (ix - 45)                    ; 1-byte Folded Reload
	ld	c, -86
	ld	(ix - 5), c
	ld	iy, (ix - 7)
	ld	iyh, c
	ld	l, -85
	ex	de, hl
	ld	iyl, e
	ex	de, hl
	ld	(ix - 4), a
	ld	hl, (ix - 6)
	ld	h, a
	ld	l, c
	ld	bc, (ix - 30)
	push	bc
	push	hl
	push	iy
	ld	hl, (ix - 42)
                                        ; kill: def $bc killed $bc killed $ubc
	call	__llmulu
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	ld	iy, 32
	push	iy
	call	__llshru
	push	hl
	pop	bc
	pop	hl
	ld	a, e
	ld	l, 7
	call	__lshru
	ld	(ix - 54), bc
	xor	a, a
	ld	(ix - 3), a
	ld	de, (ix - 5)
	ld	d, a
	ld	b, a
	ld	e, (ix - 39)                    ; 1-byte Folded Reload
	ld	a, -86
	ld	(ix - 2), a
	ld	iy, (ix - 4)
	ld	iyh, a
	ld	c, -85
	ld	iyl, c
	ld	(ix - 1), b
	ld	hl, (ix - 3)
	ld	h, b
	ld	l, a
	ld	bc, (ix - 30)
	push	bc
	push	hl
	push	iy
	ld	hl, (ix - 36)
                                        ; kill: def $bc killed $bc killed $ubc
	call	__llmulu
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	ld	iy, 32
	push	iy
	call	__llshru
	push	hl
	pop	bc
	pop	hl
	ld	a, e
	ld	l, 7
	call	__lshru
	ld	(ix - 63), bc
	ld	hl, (ix - 51)
	ld	a, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, a
	ld	(ix - 36), hl
	ld	de, 40570
	ld	iy, (ix + 6)
	add	iy, de
	ld	de, 0
	.local	.LBB1_38
.LBB1_38:                               ; =>This Inner Loop Header: Depth=1
	ld	a, (iy - 2)
	or	a, a
	sbc	hl, hl
	ld	l, a
	ld	bc, (ix - 48)
	sbc	hl, bc
	ld	(ix - 45), hl
	ld	a, (iy - 1)
	or	a, a
	sbc	hl, hl
	ld	l, a
	ld	bc, (ix - 54)
	sbc	hl, bc
	ld	(ix - 42), hl
	ld	(ix - 39), iy
	ld	a, (iy)
	or	a, a
	sbc	hl, hl
	ld	l, a
	ld	bc, (ix - 63)
	sbc	hl, bc
	ld	(ix - 30), hl
	ld	bc, (ix - 45)
	push	bc
	pop	hl
	call	__imulu
	ld	(ix - 45), hl
	ld	bc, (ix - 42)
	push	bc
	pop	hl
	call	__imulu
	push	hl
	pop	iy
	ld	bc, (ix - 45)
	add	iy, bc
	ld	bc, (ix - 30)
	push	bc
	pop	hl
	call	__imulu
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	ld	bc, (ix - 57)
	or	a, a
	sbc	hl, bc
	ld	(ix - 30), de
	jr	c, .LBB1_40
; %bb.39:                               ;   in Loop: Header=BB1_38 Depth=1
	ld	hl, (ix - 36)
	ld	(ix - 30), hl
	.local	.LBB1_40
.LBB1_40:                               ;   in Loop: Header=BB1_38 Depth=1
	lea	hl, iy + 0
	ld	bc, (ix - 57)
	or	a, a
	sbc	hl, bc
	ld	(ix - 36), iy
	jr	c, .LBB1_42
; %bb.41:                               ;   in Loop: Header=BB1_38 Depth=1
	ld	hl, (ix - 57)
	ld	(ix - 36), hl
	.local	.LBB1_42
.LBB1_42:                               ;   in Loop: Header=BB1_38 Depth=1
	inc	de
	ld	iy, (ix - 39)
	lea	iy, iy + 3
	push	de
	pop	hl
	ld	bc, 256
	or	a, a
	sbc	hl, bc
	ld	hl, (ix - 36)
	ld	(ix - 57), hl
	ld	hl, (ix - 30)
	ld	(ix - 36), hl
	jp	nz, .LBB1_38
; %bb.43:
	ld	hl, (ix - 30)
	ld	a, l
	ld	(_sky_flat), a
	.local	.LBB1_44
.LBB1_44:                               ; =>This Inner Loop Header: Depth=1
	ld	hl, (ix - 60)
	ld	hl, (hl)
	ld	iy, 0
	lea	bc, iy + 0
	ld	c, l
	ld	b, h
	ld	iy, (ix - 78)
	add	iy, bc
	ld	(ix - 30), iy
	ld	a, (iy + 6)
	ld	l, -1
	xor	a, l
	ld	l, a
	ld	b, 3
	call	__bshru
	ld	hl, _sector_shades
	ld	de, (ix - 33)
	add	hl, de
	ld	(hl), a
	or	a, a
	sbc	hl, hl
	ld	l, a
	ld	c, 8
	call	__ishl
	push	hl
	pop	bc
	ld	hl, _ram_colormaps
	add	hl, bc
	ld	(ix - 36), hl
	ld	iy, (ix - 30)
	ld	a, (iy + 4)
	ld	iy, 0
	lea	hl, iy + 0
	ld	l, a
	ld	bc, 3
	call	__imulu
	push	hl
	pop	bc
	ld	hl, _images
	add	hl, bc
	ld	hl, (hl)
	ld	bc, 528
	add	hl, bc
	ld	a, (hl)
	lea	bc, iy + 0
	ld	c, a
	ld	hl, (ix - 36)
	add	hl, bc
	ld	a, (hl)
	ld	iy, _plane_colors
	add	iy, de
	ld	(ix - 39), iy
	ld	(iy), a
	ld	iy, (ix - 30)
	ld	a, (iy + 5)
	cp	a, -1
	ld	hl, _sky_flat
	jr	z, .LBB1_46
; %bb.45:                               ;   in Loop: Header=BB1_44 Depth=1
	ld	de, 0
	push	de
	pop	hl
	ld	l, a
	ld	bc, 3
	call	__imulu
	push	hl
	pop	bc
	ld	hl, _images
	add	hl, bc
	ld	hl, (hl)
	ld	bc, 528
	add	hl, bc
	ld	a, (hl)
	push	de
	pop	bc
	ld	c, a
	ld	hl, (ix - 36)
	add	hl, bc
	.local	.LBB1_46
.LBB1_46:                               ;   in Loop: Header=BB1_44 Depth=1
	ld	a, (hl)
	ld	iy, (ix - 39)
	ld	(iy + 85), a
	ld	hl, (ix - 33)
	inc	hl
	ld	iy, (ix - 60)
	lea	iy, iy + 2
	ld	(ix - 60), iy
	ld	(ix - 33), hl
	ld	de, 85
	or	a, a
	sbc	hl, de
	jp	nz, .LBB1_44
; %bb.47:
	ld	a, -128
	ld	(_engine_view), a
	ld	a, 80
	ld	(_engine_view+1), a
	call	_engine_reset
	ld	a, 1
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB1_48
.LBB1_48:
	xor	a, a
	.local	.LBB1_49
.LBB1_49:
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB1_50
.LBB1_50:
	xor	a, a
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end1
.Lfunc_end1:
	.size	_engine_init, .Lfunc_end1-_engine_init
                                        ; -- End function
	.section	.text._engine_reset,"ax",@progbits
	.globl	_engine_reset                   ; -- Begin function engine_reset
	.type	_engine_reset,@function
_engine_reset:                          ; @engine_reset
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 62
	ld	sp, hl
	ld	iy, _player+8
	xor	a, a
	ld.sis	hl, 0
	ld	(ix - 41), l
	ld	(ix - 40), h
	ld	(_player+8), a
	lea	hl, iy + 0
	inc	hl
	ld	bc, 25
	ex	de, hl
	lea	hl, iy + 0
	ldir
	ld	hl, 270336
	ld	(_player), hl
	ld	(_player+3), a
	ld	hl, -925696
	ld	(_player+4), hl
	dec	a
	ld	(_player+7), a
	ld.sis	hl, 256
	ld	iy, _player+18
	ld	(iy), l
	ld	(iy + 1), h
	ld.sis	hl, 100
	ld	iy, _player+12
	ld	(iy), l
	ld	(iy + 1), h
	ld.sis	hl, 50
	ld	iy, _player+16
	ld	(iy), l
	ld	(iy + 1), h
	ld	a, 1
	ld	(_player+31), a
	ld	hl, (_nodes)
	ld	(ix - 18), hl
	ld	a, 15
	ld	de, 235
	.local	.LBB2_1
.LBB2_1:                                ; =>This Inner Loop Header: Depth=1
	ex	de, hl
	ld	bc, 255
	call	__iand
	add	hl, hl
	ex	de, hl
	ld	hl, _node_offsets
	add	hl, de
	ld	hl, (hl)
	ld	de, 0
	ld	e, l
	ld	d, h
	ld	iy, (ix - 18)
	add	iy, de
	ld	de, (iy + 4)
	ld	(ix - 21), de
	sbc.sis	hl, hl
	adc.sis	hl, de
	ld	(ix - 15), iy
	jp	nz, .LBB2_4
; %bb.2:                                ;   in Loop: Header=BB2_1 Depth=1
	ld	hl, (iy)
	ld	iy, (iy + 6)
	ld.sis	de, -32768
	add.sis	hl, de
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	bc, -31712
	or	a, a
	sbc.sis	hl, bc
	jp	nc, .LBB2_7
; %bb.3:                                ;   in Loop: Header=BB2_1 Depth=1
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	c, a
	call	__sshru
	ld	iy, 0
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	jp	.LBB2_12
	.local	.LBB2_4
.LBB2_4:                                ;   in Loop: Header=BB2_1 Depth=1
	ld	de, (iy + 6)
	sbc.sis	hl, hl
	adc.sis	hl, de
	jp	nz, .LBB2_9
; %bb.5:                                ;   in Loop: Header=BB2_1 Depth=1
	ld	hl, (iy + 2)
	ld	(ix - 24), hl
	ld	iy, (ix - 21)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	c, a
	call	__sshru
	ld	(ix - 27), l
	ld	(ix - 26), h
	ld.sis	bc, -32768
	add.sis	iy, bc
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	de, -32767
	or	a, a
	sbc.sis	hl, de
	sbc	hl, hl
	push	hl
	pop	iy
	ld	hl, (ix - 24)
	add.sis	hl, bc
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	de, 29152
	or	a, a
	sbc.sis	hl, de
	jr	c, .LBB2_8
; %bb.6:                                ;   in Loop: Header=BB2_1 Depth=1
	or	a, a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	e, (ix - 27)
	ld	d, (ix - 26)
	ld	iyl, e
	ld	iyh, d
	jp	.LBB2_13
	.local	.LBB2_7
.LBB2_7:                                ;   in Loop: Header=BB2_1 Depth=1
	add.sis	iy, de
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	de, -32767
	or	a, a
	sbc.sis	hl, de
	sbc	hl, hl
	push	hl
	pop	iy
	.local	.LBB2_8
.LBB2_8:                                ;   in Loop: Header=BB2_1 Depth=1
	inc	iy
	jp	.LBB2_12
	.local	.LBB2_9
.LBB2_9:                                ;   in Loop: Header=BB2_1 Depth=1
	ld	iy, (iy)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	ld	hl, 1056
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	ld	(ix - 12), iy
	ld	a, (ix - 10)
	rlc	a
	sbc	a, a
	ld	(ix - 24), a                    ; 1-byte Folded Spill
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	rlc	d
	sbc	a, a
	lea	hl, iy + 0
	ld	e, (ix - 24)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 24), hl
	ld	(ix - 27), e                    ; 1-byte Folded Spill
	ld	iy, (ix - 15)
	ld	bc, (iy + 2)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	hl, -3616
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	(ix - 9), iy
	ld	a, (ix - 7)
	rlc	a
	sbc	a, a
	ld	(ix - 30), a                    ; 1-byte Folded Spill
	ld	de, (ix - 21)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	rlc	d
	sbc	a, a
	lea	hl, iy + 0
	ld	e, (ix - 30)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	bc, (ix - 24)
	ld	a, (ix - 27)                    ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	iy, 1
	jp	p, .LBB2_11
; %bb.10:                               ;   in Loop: Header=BB2_1 Depth=1
	ld	iy, 0
	.local	.LBB2_11
.LBB2_11:                               ;   in Loop: Header=BB2_1 Depth=1
	ld	a, 15
	.local	.LBB2_12
.LBB2_12:                               ;   in Loop: Header=BB2_1 Depth=1
	or	a, a
	sbc	hl, hl
	.local	.LBB2_13
.LBB2_13:                               ;   in Loop: Header=BB2_1 Depth=1
	add	iy, iy
	lea	de, iy + 0
	ld	iy, (ix - 15)
	add	iy, de
	ld	iy, (iy + 24)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	bc, -32768
	add.sis	hl, bc
	or	a, a
	sbc.sis	hl, bc
	jp	nc, .LBB2_1
; %bb.14:
	ld	bc, (_subsectors)
	ld	l, 127
	ld	a, iyh
	and	a, l
	ld	iyh, a
	or	a, a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	de, (_segs)
	ld	(ix - 36), de
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	(ix - 44), bc
	push	bc
	pop	iy
	add	iy, de
	ld	de, (iy + 2)
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	bc, 14
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 36)
	add	iy, de
	ld	hl, (_sides)
	ld	(ix - 39), hl
	ld	de, (_map_lines)
	ld	bc, (iy + 6)
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	bc, (iy + 8)
	ld	iy, 0
	ld	iyl, c
	ld	iyh, b
	ld	(ix - 15), iy
	ld	bc, 14
	call	__imulu
	push	hl
	pop	bc
	ld	(ix - 47), de
	push	de
	pop	iy
	add	iy, bc
	ld	hl, (ix - 15)
	add	hl, hl
	ex	de, hl
	add	iy, de
	ld	de, (iy + 10)
	ld	bc, 0
	push	bc
	pop	hl
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	iy, (ix - 39)
	add	iy, de
	ld	a, (iy + 7)
	ld	(_player+26), a
	push	bc
	pop	hl
	ld	l, a
	ld	bc, (_map_sectors)
	add	hl, hl
	ex	de, hl
	ld	iy, _sector_offsets
	lea	hl, iy + 0
	add	hl, de
	ld	hl, (hl)
	ld	de, 0
	ld	e, l
	ld	d, h
	ld	(ix - 15), bc
	push	bc
	pop	hl
	add	hl, de
	ld	iy, (hl)
	ld	hl, _player+10
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld.sis	de, 41
	add.sis	iy, de
	ld	hl, _player+8
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld.sis	hl, 1
	ld	iy, _random_state
	ld	(iy), l
	ld	(iy + 1), h
	xor	a, a
	ld	(_use_held), a
	ld	(_floor_wait), a
	ld	hl, _floor_wait
	push	hl
	pop	de
	inc	de
	ld	bc, 84
	ldir
	ld	bc, 0
	ld	iy, _sector_offsets
	.local	.LBB2_15
.LBB2_15:                               ; =>This Inner Loop Header: Depth=1
	lea	hl, iy + 0
	add	hl, bc
	ld	hl, (hl)
	ld	de, 0
	ld	e, l
	ld	d, h
	ld	iy, (ix - 15)
	add	iy, de
	ld	de, (iy + 2)
	ld	hl, _sector_ceiling
	add	hl, bc
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	hl, _sector_target
	add	hl, bc
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	de, (iy)
	ld	hl, _sector_floor
	add	hl, bc
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	hl, _floor_target
	add	hl, bc
	ld	(hl), e
	inc	hl
	ld	(hl), d
	push	bc
	pop	iy
	ld	de, 2
	add	iy, de
	lea	hl, iy + 0
	ld	de, 170
	or	a, a
	sbc	hl, de
	lea	bc, iy + 0
	ld	iy, _sector_offsets
	jr	nz, .LBB2_15
; %bb.16:
	ld	hl, (_map_actors)
	ld	(ix - 50), hl
	ld	de, 0
	.local	.LBB2_17
.LBB2_17:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_18 Depth 2
	ld	(ix - 21), de
	ex	de, hl
	ld	bc, 14
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 50)
	add	iy, de
	ld	de, (iy)
	ld	(ix - 24), iy
	ld	bc, (iy + 2)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	(ix - 27), de
	ld	l, e
	ld	h, d
	ld	(ix - 53), hl
	ld	a, b
	rlc	a
	sbc	hl, hl
	ld	(ix - 33), bc
	ld	l, c
	ld	h, b
	ld	(ix - 56), hl
	ld	de, 235
	.local	.LBB2_18
.LBB2_18:                               ;   Parent Loop BB2_17 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ex	de, hl
	ld	bc, 255
	call	__iand
	add	hl, hl
	ex	de, hl
	ld	hl, _node_offsets
	add	hl, de
	ld	hl, (hl)
	ld	de, 0
	ld	e, l
	ld	d, h
	ld	iy, (ix - 18)
	add	iy, de
	ld	de, (iy + 4)
	ld	(ix - 30), de
	sbc.sis	hl, hl
	adc.sis	hl, de
	ld	(ix - 15), iy
	jp	nz, .LBB2_21
; %bb.19:                               ;   in Loop: Header=BB2_18 Depth=2
	ld	hl, (iy)
	ld	de, (iy + 6)
	ld	(ix - 30), de
	ld	de, (ix - 27)
	ld	iyl, e
	ld	iyh, d
	ld.sis	bc, -32768
	add.sis	iy, bc
	add.sis	hl, bc
                                        ; kill: def $hl killed $hl killed $uhl
	ld	e, iyl
	ld	d, iyh
	or	a, a
	sbc.sis	hl, de
	jp	nc, .LBB2_24
; %bb.20:                               ;   in Loop: Header=BB2_18 Depth=2
	ld	hl, (ix - 30)
                                        ; kill: def $hl killed $hl killed $uhl
	ld	c, 15
	call	__sshru
	ld.sis	bc, -32768
	ld	iy, 0
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	jp	.LBB2_28
	.local	.LBB2_21
.LBB2_21:                               ;   in Loop: Header=BB2_18 Depth=2
	ld	de, (iy + 6)
	sbc.sis	hl, hl
	adc.sis	hl, de
	jp	nz, .LBB2_25
; %bb.22:                               ;   in Loop: Header=BB2_18 Depth=2
	ld	hl, (iy + 2)
	ld	(ix - 59), hl
	ld	iy, (ix - 30)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	c, 15
	call	__sshru
	ld	(ix - 61), l
	ld	(ix - 60), h
	ld.sis	bc, -32768
	add.sis	iy, bc
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	de, -32767
	or	a, a
	sbc.sis	hl, de
	sbc	hl, hl
	push	hl
	pop	iy
	ld	hl, (ix - 33)
                                        ; kill: def $hl killed $hl killed $uhl
	add.sis	hl, bc
	ex.sis	de, hl
	ld	hl, (ix - 59)
	add.sis	hl, bc
                                        ; kill: def $hl killed $hl killed $uhl
	ld	c, e
	ld	b, d
	or	a, a
	sbc.sis	hl, bc
	jp	c, .LBB2_30
; %bb.23:                               ;   in Loop: Header=BB2_18 Depth=2
	or	a, a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	e, (ix - 61)
	ld	d, (ix - 60)
	ld	iyl, e
	ld	iyh, d
	ld.sis	bc, -32768
	jp	.LBB2_29
	.local	.LBB2_24
.LBB2_24:                               ;   in Loop: Header=BB2_18 Depth=2
	ld	hl, (ix - 30)
	add.sis	hl, bc
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	de, -32767
	or	a, a
	sbc.sis	hl, de
	sbc	hl, hl
	push	hl
	pop	iy
	inc	iy
	jp	.LBB2_28
	.local	.LBB2_25
.LBB2_25:                               ;   in Loop: Header=BB2_18 Depth=2
	ld	iy, (iy)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	ld	hl, (ix - 53)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	ld	(ix - 6), iy
	ld	a, (ix - 4)
	rlc	a
	sbc	a, a
	ld	(ix - 59), a                    ; 1-byte Folded Spill
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	rlc	d
	sbc	a, a
	lea	hl, iy + 0
	ld	e, (ix - 59)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 59), hl
	ld	(ix - 61), e                    ; 1-byte Folded Spill
	ld	iy, (ix - 15)
	ld	bc, (iy + 2)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	hl, (ix - 56)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	(ix - 3), iy
	ld	a, (ix - 1)
	rlc	a
	sbc	a, a
	ld	(ix - 62), a                    ; 1-byte Folded Spill
	ld	de, (ix - 30)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	rlc	d
	sbc	a, a
	lea	hl, iy + 0
	ld	e, (ix - 62)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	bc, (ix - 59)
	ld	a, (ix - 61)                    ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	iy, 1
	jp	p, .LBB2_27
; %bb.26:                               ;   in Loop: Header=BB2_18 Depth=2
	ld	iy, 0
	.local	.LBB2_27
.LBB2_27:                               ;   in Loop: Header=BB2_18 Depth=2
	ld.sis	bc, -32768
	.local	.LBB2_28
.LBB2_28:                               ;   in Loop: Header=BB2_18 Depth=2
	or	a, a
	sbc	hl, hl
	.local	.LBB2_29
.LBB2_29:                               ;   in Loop: Header=BB2_18 Depth=2
	add	iy, iy
	lea	de, iy + 0
	ld	iy, (ix - 15)
	add	iy, de
	ld	iy, (iy + 24)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	add.sis	hl, bc
	or	a, a
	sbc.sis	hl, bc
	jp	nc, .LBB2_18
	jr	.LBB2_31
	.local	.LBB2_30
.LBB2_30:                               ;   in Loop: Header=BB2_18 Depth=2
	inc	iy
	or	a, a
	sbc	hl, hl
	ld.sis	bc, -32768
	jr	.LBB2_29
	.local	.LBB2_31
.LBB2_31:                               ;   in Loop: Header=BB2_17 Depth=1
	ld	hl, (ix - 21)
	ld	bc, 12
	call	__imulu
	ex	de, hl
	ld	hl, _actors
	add	hl, de
	ld	(ix - 15), hl
	ld	l, 127
	ld	a, iyh
	and	a, l
	ld	iyh, a
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	iy, (ix - 44)
	add	iy, de
	ld	de, (iy + 2)
	push	bc
	pop	hl
	ld	l, e
	ld	h, d
	ld	bc, 14
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 36)
	add	iy, de
	ld	de, (iy + 6)
	ld	bc, 0
	push	bc
	pop	hl
	ld	l, e
	ld	h, d
	ld	de, (iy + 8)
	ld	c, e
	ld	b, d
	ld	(ix - 30), bc
	ld	bc, 14
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 47)
	add	iy, de
	ld	hl, (ix - 30)
	add	hl, hl
	ex	de, hl
	add	iy, de
	ld	de, (iy + 10)
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	iy, (ix - 39)
	add	iy, de
	ld	a, (iy + 7)
	ld	iy, (ix - 24)
	ld	l, (iy + 11)
	ld	de, (ix - 27)
	ld	iy, (ix - 15)
	ld	(iy), e
	ld	(iy + 1), d
	ld	de, (ix - 33)
	ld	(iy + 2), e
	ld	(iy + 3), d
	ld	(iy + 4), a
	ld	(iy + 5), l
	lea	de, iy + 6
	ld	(iy + 6), b
	push	de
	pop	bc
	inc	bc
	ex	de, hl
	ld	a, (hl)
	push	bc
	pop	hl
	ld	(hl), a
	ld	a, (iy + 7)
	ld	(iy + 8), a
	ld	a, (iy + 8)
	ld	(iy + 9), a
	ld	a, (iy + 9)
	ld	(iy + 10), a
	ld	iy, (ix - 24)
	ld	a, (iy + 12)
	cp	a, 1
	jr	nz, .LBB2_33
; %bb.32:                               ;   in Loop: Header=BB2_17 Depth=1
	ld	e, (ix - 41)
	ld	d, (ix - 40)
	inc.sis	de
	ld	(ix - 41), e
	ld	(ix - 40), d
	ld	hl, _player+22
	ld	(hl), e
	inc	hl
	ld	(hl), d
	.local	.LBB2_33
.LBB2_33:                               ;   in Loop: Header=BB2_17 Depth=1
	ld	de, (ix - 21)
	inc	de
	push	de
	pop	hl
	ld	bc, 91
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB2_17
; %bb.34:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end2
.Lfunc_end2:
	.size	_engine_reset, .Lfunc_end2-_engine_reset
                                        ; -- End function
	.section	.text._engine_can_move,"ax",@progbits
	.globl	_engine_can_move                ; -- Begin function engine_can_move
	.type	_engine_can_move,@function
_engine_can_move:                       ; @engine_can_move
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 110
	ld	sp, hl
	ld	iy, (ix + 6)
	ld	de, -16
	add	iy, de
	ld	hl, (_blockmap)
	ld	(ix - 47), hl
	ld	hl, (ix - 47)
	ld	bc, (hl)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	ld	a, 7
	ld	c, a
	call	__ishrs
	ld	(ix - 50), hl
	ld	hl, (ix + 6)
	ld	bc, 16
	add	hl, bc
	or	a, a
	sbc	hl, de
	ld	c, a
	call	__ishrs
	ld	(ix - 56), hl
	ld	iy, (ix + 9)
	ld	de, -16
	add	iy, de
	ld	(ix - 53), iy
	ld	iy, (ix - 47)
	ld	bc, (iy + 2)
	ld	l, b
	rlc	l
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	hl, (ix - 53)
	or	a, a
	sbc	hl, de
	ld	c, a
	call	__ishrs
	ld	(ix - 53), hl
	ld	hl, (ix + 9)
	ld	bc, 16
	add	hl, bc
	or	a, a
	sbc	hl, de
	ld	c, a
	call	__ishrs
	ld	(ix - 59), hl
	ld	bc, -8388608
	ld	iy, (ix - 50)
	add	iy, bc
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB3_3
; %bb.1:
	xor	a, a
	.local	.LBB3_2
.LBB3_2:
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB3_3
.LBB3_3:
	ld	hl, (ix - 53)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	c, .LBB3_64
; %bb.4:
	ld	(ix - 62), iy
	ld	iy, (ix - 47)
	ld	de, (iy + 4)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 65), hl
	push	hl
	pop	iy
	add	iy, bc
	ld	hl, (ix - 56)
	add	hl, bc
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	nc, .LBB3_64
; %bb.5:
	ld	iy, (ix - 47)
	ld	de, (iy + 6)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	add	hl, bc
	ex	de, hl
	ld	iy, (ix - 59)
	add	iy, bc
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	jp	nc, .LBB3_64
; %bb.6:
	ld	hl, (ix - 53)
	add	hl, bc
	ex	de, hl
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	jp	c, .LBB3_46
; %bb.7:
	ld	hl, (ix - 56)
	add	hl, bc
	ld	de, (ix - 62)
	or	a, a
	sbc	hl, de
	jp	c, .LBB3_46
; %bb.8:
	ld	bc, (ix - 59)
	push	bc
	pop	hl
	ld	de, (ix - 53)
	or	a, a
	sbc	hl, de
	ld	(ix - 98), de
	jr	c, .LBB3_10
; %bb.9:
	ld	(ix - 98), bc
	.local	.LBB3_10
.LBB3_10:
	ld	hl, (_map_lines)
	ld	(ix - 86), hl
	ld	hl, (_map_vertices)
	ld	(ix - 89), hl
	ld	hl, (_sides)
	ld	(ix - 101), hl
	.local	.LBB3_11
.LBB3_11:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_12 Depth 2
                                        ;       Child Loop BB3_14 Depth 3
	ld	hl, (ix - 53)
	ld	bc, (ix - 65)
	call	__imulu
	add	hl, hl
	ex	de, hl
	ld	hl, (ix - 47)
	add	hl, de
	ld	(ix - 77), hl
	ld	iy, (ix - 50)
	.local	.LBB3_12
.LBB3_12:                               ;   Parent Loop BB3_11 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB3_14 Depth 3
	ld	(ix - 71), iy
	lea	hl, iy + 0
	add	hl, hl
	ex	de, hl
	ld	iy, (ix - 77)
	add	iy, de
	ld	hl, (iy + 8)
	ld	de, 0
	ld	e, l
	ld	d, h
	ld	(ix - 59), de
	ex	de, hl
	inc	hl
	add	hl, hl
	ex	de, hl
	ld	iy, (ix - 47)
	add	iy, de
	ld	bc, (iy)
	ld	l, c
	ld	h, b
	ld.sis	de, -1
	or	a, a
	sbc.sis	hl, de
	jp	z, .LBB3_44
; %bb.13:                               ;   in Loop: Header=BB3_12 Depth=2
	ld	de, 0
	ld	e, c
	ld	d, b
	ld	hl, (ix - 59)
	add	hl, hl
	push	hl
	pop	bc
	ld	iy, (ix - 47)
	add	iy, bc
	lea	hl, iy + 4
	.local	.LBB3_14
.LBB3_14:                               ;   Parent Loop BB3_11 Depth=1
                                        ;     Parent Loop BB3_12 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ld	(ix - 59), hl
	ex	de, hl
	ld	bc, 14
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 86)
	add	iy, de
	ld	bc, (iy)
	ld	de, 0
	ex	de, hl
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	ld	(ix - 62), hl
	ld	bc, (ix - 89)
	push	bc
	pop	hl
	ld	de, (ix - 62)
	add	hl, de
	ld	(ix - 68), hl
	ld	(ix - 95), iy
	ld	iy, (iy + 2)
	or	a, a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	push	bc
	pop	iy
	add	iy, de
	ld	hl, (ix - 68)
	ld	de, (hl)
	ld	(ix - 92), iy
	ld	hl, (iy)
	ld	(ix - 62), hl
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld.sis	hl, -32768
	ld	c, l
	ld	b, h
	add.sis	iy, bc
	ld	l, e
	ld	h, d
	add.sis	hl, bc
	ld	(ix - 83), l
	ld	(ix - 82), h
	push	hl
	lea	hl, iy + 0
	ld	(ix - 80), l
	ld	(ix - 79), h
	pop	hl
	ld	c, iyl
	ld	b, iyh
	or	a, a
	sbc.sis	hl, bc
	ld	hl, (ix - 62)
	ld	(ix - 74), de
	ld	c, e
	ld	b, d
	jr	c, .LBB3_16
; %bb.15:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	c, l
	ld	b, h
	.local	.LBB3_16
.LBB3_16:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	a, b
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, c
	ld	iyh, b
	ld	bc, -16
	add	iy, bc
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	ld	hl, (ix + 6)
	add	hl, bc
	push	hl
	pop	de
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	ld	iy, (ix - 59)
	jp	c, .LBB3_43
; %bb.17:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	l, (ix - 80)
	ld	h, (ix - 79)
	ld	c, (ix - 83)
	ld	b, (ix - 82)
	or	a, a
	sbc.sis	hl, bc
	ld	hl, (ix - 74)
	ld	c, l
	ld	b, h
	jr	c, .LBB3_19
; %bb.18:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	hl, (ix - 62)
	ld	c, l
	ld	b, h
	.local	.LBB3_19
.LBB3_19:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	a, b
	rlc	a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	bc, 16
	add	hl, bc
	ld	bc, -8388608
	add	hl, bc
	push	de
	pop	bc
	or	a, a
	sbc	hl, bc
	ld	iy, (ix - 59)
	jp	c, .LBB3_43
; %bb.20:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	iy, (ix - 68)
	ld	de, (iy + 2)
	ld	iy, (ix - 92)
	ld	hl, (iy + 2)
	ld	(ix - 68), hl
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld.sis	hl, -32768
	ld	c, l
	ld	b, h
	add.sis	iy, bc
	ld	l, e
	ld	h, d
	add.sis	hl, bc
	ld	(ix - 92), l
	ld	(ix - 91), h
	push	hl
	lea	hl, iy + 0
	ld	(ix - 83), l
	ld	(ix - 82), h
	pop	hl
	ld	c, iyl
	ld	b, iyh
	or	a, a
	sbc.sis	hl, bc
	ld	hl, (ix - 68)
	ld	(ix - 80), de
	ld	c, e
	ld	b, d
	jr	c, .LBB3_22
; %bb.21:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	c, l
	ld	b, h
	.local	.LBB3_22
.LBB3_22:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	a, b
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, c
	ld	iyh, b
	ld	bc, -16
	add	iy, bc
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	ld	hl, (ix + 9)
	add	hl, bc
	push	hl
	pop	de
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	ld	iy, (ix - 59)
	jp	c, .LBB3_43
; %bb.23:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	l, (ix - 83)
	ld	h, (ix - 82)
	ld	c, (ix - 92)
	ld	b, (ix - 91)
	or	a, a
	sbc.sis	hl, bc
	ld	hl, (ix - 80)
	ld	c, l
	ld	b, h
	jr	c, .LBB3_25
; %bb.24:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	hl, (ix - 68)
	ld	c, l
	ld	b, h
	.local	.LBB3_25
.LBB3_25:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	a, b
	rlc	a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	bc, 16
	add	hl, bc
	ld	bc, -8388608
	add	hl, bc
	push	de
	pop	bc
	or	a, a
	sbc	hl, bc
	ld	iy, (ix - 59)
	jp	c, .LBB3_43
; %bb.26:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	iy, (ix - 95)
	ld	de, (iy + 12)
	ld	l, e
	ld	h, d
	ld.sis	bc, -1
	or	a, a
	sbc.sis	hl, bc
	jp	z, .LBB3_36
; %bb.27:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	iy, (ix - 95)
	ld	hl, (iy + 4)
	ld	c, 1
	ld	a, l
	and	a, c
	ld	l, a
	bit	0, l
	jp	nz, .LBB3_36
; %bb.28:                               ;   in Loop: Header=BB3_14 Depth=3
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	ld	(ix - 83), bc
	ld	iy, (ix - 95)
	ld	bc, (iy + 10)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	ld	de, (ix - 101)
	push	de
	pop	iy
	add	iy, bc
	ld	a, (iy + 7)
	ld	bc, 0
	ld	c, a
	ld	hl, (ix - 83)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	de
	pop	iy
	ex	de, hl
	add	iy, de
	ld	a, (iy + 7)
	ld	de, 0
	ld	e, a
	push	bc
	pop	hl
	add	hl, hl
	ld	(ix - 92), hl
	push	hl
	pop	bc
	ld	iy, _sector_floor
	lea	hl, iy + 0
	add	hl, bc
	ld	bc, (hl)
	ld	(ix - 83), bc
	ex	de, hl
	add	hl, hl
	ld	(ix - 95), hl
	ex	de, hl
	lea	hl, iy + 0
	add	hl, de
	ld	de, (hl)
	ld	iyl, c
	ld	iyh, b
	ld.sis	hl, -32768
	ld	c, l
	ld	b, h
	add.sis	iy, bc
	ld	(ix - 104), de
	ld	l, e
	ld	h, d
	ld	de, (ix - 83)
	add.sis	hl, bc
	ld	c, iyl
	ld	b, iyh
	or	a, a
	sbc.sis	hl, bc
	jp	c, .LBB3_30
; %bb.29:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	de, (ix - 104)
                                        ; kill: def $de killed $de killed $ude def $ude
	.local	.LBB3_30
.LBB3_30:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	bc, (ix + 12)
	ld	(ix - 83), hl
	or	a, a
	sbc	hl, bc
	ld	bc, -8388608
	add	hl, bc
	ld	bc, -8388583
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB3_36
; %bb.31:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	bc, (ix - 92)
	ld	iy, _sector_ceiling
	lea	hl, iy + 0
	add	hl, bc
	ld	de, (hl)
	ld	bc, (ix - 95)
	lea	hl, iy + 0
	add	hl, bc
	ld	hl, (hl)
	ld	(ix - 92), hl
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld.sis	hl, -32768
	ld	c, l
	ld	b, h
	add.sis	iy, bc
	ld	l, e
	ld	h, d
	add.sis	hl, bc
	ld	c, iyl
	ld	b, iyh
	or	a, a
	sbc.sis	hl, bc
	jp	c, .LBB3_33
; %bb.32:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	de, (ix - 92)
                                        ; kill: def $de killed $de killed $ude def $ude
	.local	.LBB3_33
.LBB3_33:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 92), hl
	ld	de, (ix - 83)
	push	de
	pop	iy
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	ld	hl, (ix + 12)
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jr	c, .LBB3_35
; %bb.34:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	hl, (ix + 12)
	ex	de, hl
	.local	.LBB3_35
.LBB3_35:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	hl, (ix - 92)
	or	a, a
	sbc	hl, de
	ld	bc, -8388608
	add	hl, bc
	ld	bc, -8388552
	or	a, a
	sbc	hl, bc
	ld	iy, (ix - 59)
	jp	nc, .LBB3_43
	.local	.LBB3_36
.LBB3_36:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	de, (ix - 62)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	ld	iy, (ix - 74)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ld	(ix - 74), de
	ld	(ix - 107), bc
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	ld	(ix - 62), hl
	ld	bc, (ix - 68)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	iy, (ix - 80)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	ld	(ix - 110), de
	ex	de, hl
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	ld	hl, (ix + 6)
	ld	de, (ix - 74)
	or	a, a
	sbc	hl, de
	ld	(ix - 68), hl
	ld	hl, (ix + 9)
	or	a, a
	sbc	hl, bc
	ld	(ix - 74), hl
	ld	hl, (ix - 62)
	ld	(ix - 44), hl
	ld	a, (ix - 42)
	rlc	a
	sbc	a, a
	ld	(ix - 80), a
	push	hl
	pop	bc
	ld	e, a
	call	__lmulu
	ld	(ix - 83), hl
	ld	(ix - 92), e                    ; 1-byte Folded Spill
	ld	(ix - 41), iy
	ld	a, (ix - 39)
	rlc	a
	sbc	a, a
	ld	d, a
	lea	hl, iy + 0
	ld	e, d
	lea	bc, iy + 0
	call	__lmulu
	ld	bc, (ix - 83)
	ld	a, (ix - 92)                    ; 1-byte Folded Reload
	call	__ladd
	ld	(ix - 92), hl
	ld	(ix - 95), e                    ; 1-byte Folded Spill
	ld	bc, (ix - 68)
	ld	(ix - 38), bc
	ld	a, (ix - 36)
	rlc	a
	sbc	a, a
	ld	hl, (ix - 62)
	ld	e, (ix - 80)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 80), hl
	ld	(ix - 83), e                    ; 1-byte Folded Spill
	ld	bc, (ix - 74)
	ld	(ix - 35), bc
	ld	a, (ix - 33)
	rlc	a
	sbc	a, a
	ld	(ix - 104), iy
	lea	hl, iy + 0
	push	bc
	pop	iy
	ld	e, d
	call	__lmulu
	ld	bc, (ix - 80)
	ld	a, (ix - 83)                    ; 1-byte Folded Reload
	call	__ladd
	push	hl
	pop	bc
	ld	d, e
	call	__lcmpzero
	jp	p, .LBB3_38
; %bb.37:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	(ix - 12), iy
	ld	a, (ix - 10)
	rlc	a
	sbc	a, a
	ld	d, a
	ld	bc, (ix - 68)
	ld	(ix - 9), bc
	ld	a, (ix - 7)
	rlc	a
	sbc	a, a
	push	bc
	pop	hl
	ld	e, a
	call	__lmulu
	lea	bc, iy + 0
	push	hl
	pop	iy
	ld	(ix - 62), e                    ; 1-byte Folded Spill
	push	bc
	pop	hl
	ld	e, d
	ld	a, d
	call	__lmulu
	lea	bc, iy + 0
	ld	a, (ix - 62)                    ; 1-byte Folded Reload
	jr	.LBB3_40
	.local	.LBB3_38
.LBB3_38:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	hl, (ix - 92)
	ld	e, (ix - 95)                    ; 1-byte Folded Reload
	ld	a, d
	call	__lcmps
	call	pe, __setflag
	jp	p, .LBB3_41
; %bb.39:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	hl, (ix + 6)
	ld	de, (ix - 107)
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	hl, (ix + 9)
	ld	de, (ix - 110)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	(ix - 18), bc
	ld	a, (ix - 16)
	rlc	a
	sbc	a, a
	push	bc
	pop	hl
	ld	e, a
	call	__lmulu
	ld	(ix - 62), hl
	ld	d, e
	ld	(ix - 15), iy
	ld	a, (ix - 13)
	rlc	a
	sbc	a, a
	lea	hl, iy + 0
	ld	e, a
	lea	bc, iy + 0
	call	__lmulu
	ld	bc, (ix - 62)
	ld	a, d
	.local	.LBB3_40
.LBB3_40:                               ;   in Loop: Header=BB3_14 Depth=3
	call	__ladd
	ld	bc, 256
	xor	a, a
	call	__lcmpu
	ld	iy, (ix - 59)
	jp	nc, .LBB3_43
	jp	.LBB3_64
	.local	.LBB3_41
.LBB3_41:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	hl, (ix - 92)
	ld	e, (ix - 95)                    ; 1-byte Folded Reload
	call	__lcmpzero
	ld	iy, (ix - 59)
	jp	z, .LBB3_43
; %bb.42:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	hl, (ix - 104)
	ld	(ix - 32), hl
	ld	a, (ix - 30)
	rlc	a
	sbc	a, a
	ld	(ix - 83), a                    ; 1-byte Folded Spill
	ld	hl, (ix - 62)
	ld	(ix - 29), hl
	ld	a, (ix - 27)
	rlc	a
	sbc	a, a
	ld	(ix - 107), a                   ; 1-byte Folded Spill
	xor	a, a
	ld	(ix - 26), a
	ld	iy, (ix - 28)
	ld	iyh, a
	ld	iyl, d
	sbc	hl, hl
	ld	(ix - 80), hl
	ld	hl, 8
	push	hl
	push	bc
	pop	hl
	lea	de, iy + 0
	ld	bc, (ix - 80)
                                        ; kill: def $bc killed $bc killed $ubc
	call	__llshl
	ld	(ix - 110), hl
	pop	iy
	ld	(ix - 25), a
	ld	hl, (ix - 27)
	ld	h, a
	ld	l, (ix - 95)                    ; 1-byte Folded Reload
	ld	iy, (ix - 80)
	push	iy
	push	hl
	ld	iy, (ix - 92)
	push	iy
	ld	hl, (ix - 110)
	call	__lldivu
	ld	(ix - 80), hl
	ld	iy, 9
	add	iy, sp
	ld	sp, iy
	ld	d, e
	ld	e, d
	ld	bc, (ix - 62)
	ld	a, (ix - 107)                   ; 1-byte Folded Reload
	call	__lmulu
	push	hl
	pop	iy
	lea	bc, iy + 0
	ld	a, e
	ld	l, 31
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	ld	hl, (ix - 68)
	or	a, a
	sbc	hl, bc
	ld	(ix - 62), hl
	ld	hl, (ix - 80)
	ld	e, d
	ld	bc, (ix - 104)
	ld	a, (ix - 83)                    ; 1-byte Folded Reload
	call	__lmulu
	push	hl
	pop	iy
	lea	bc, iy + 0
	ld	a, e
	ld	l, 31
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	ld	hl, (ix - 74)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	ld	hl, (ix - 62)
	ld	(ix - 24), hl
	ld	a, (ix - 22)
	rlc	a
	sbc	a, a
	push	hl
	pop	bc
	ld	e, a
	call	__lmulu
	ld	(ix - 62), hl
	ld	d, e
	ld	(ix - 21), iy
	ld	a, (ix - 19)
	rlc	a
	sbc	a, a
	lea	hl, iy + 0
	ld	e, a
	lea	bc, iy + 0
	ld	iy, (ix - 59)
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	hl, (ix - 62)
	ld	e, d
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	hl, 255
	ld	e, h
	call	__lcmpu
	jp	nc, .LBB3_64
	.local	.LBB3_43
.LBB3_43:                               ;   in Loop: Header=BB3_14 Depth=3
	ld	hl, (iy)
	ld	de, 0
	ld	e, l
	ld	d, h
	lea	iy, iy + 2
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	bc, -1
	or	a, a
	sbc.sis	hl, bc
	lea	hl, iy + 0
	jp	nz, .LBB3_14
	.local	.LBB3_44
.LBB3_44:                               ;   in Loop: Header=BB3_12 Depth=2
	ld	hl, (ix - 71)
	push	hl
	pop	iy
	inc	iy
	ld	de, (ix - 56)
	or	a, a
	sbc	hl, de
	jp	nz, .LBB3_12
; %bb.45:                               ;   in Loop: Header=BB3_11 Depth=1
	ld	hl, (ix - 53)
	push	hl
	pop	de
	inc	de
	ld	bc, (ix - 98)
	or	a, a
	sbc	hl, bc
	ld	(ix - 53), de
	jp	nz, .LBB3_11
	.local	.LBB3_46
.LBB3_46:
	ld	de, 235
	ld	hl, (_nodes)
	ld	(ix - 50), hl
	.local	.LBB3_47
.LBB3_47:                               ; =>This Inner Loop Header: Depth=1
	ex	de, hl
	ld	bc, 255
	call	__iand
	add	hl, hl
	ex	de, hl
	ld	hl, _node_offsets
	add	hl, de
	ld	hl, (hl)
	ld	bc, 0
	push	bc
	pop	de
	ld	e, l
	ld	d, h
	ld	iy, (ix - 50)
	add	iy, de
	ld	de, (iy + 4)
	ld	(ix - 53), de
	sbc.sis	hl, hl
	adc.sis	hl, de
	ld	(ix - 47), iy
	jp	nz, .LBB3_50
; %bb.48:                               ;   in Loop: Header=BB3_47 Depth=1
	ld	de, (iy)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, (iy + 6)
	ld	(ix - 53), de
	ld	iy, (ix + 6)
	ld	de, -8388608
	add	iy, de
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	nc, .LBB3_54
; %bb.49:                               ;   in Loop: Header=BB3_47 Depth=1
	ld	hl, (ix - 53)
                                        ; kill: def $hl killed $hl killed $uhl
	push	bc
	pop	de
	ld	c, 15
	call	__sshru
	push	de
	pop	bc
	ld	iy, 0
	jr	.LBB3_53
	.local	.LBB3_50
.LBB3_50:                               ;   in Loop: Header=BB3_47 Depth=1
	ld	de, (iy + 6)
	sbc.sis	hl, hl
	adc.sis	hl, de
	jp	nz, .LBB3_55
; %bb.51:                               ;   in Loop: Header=BB3_47 Depth=1
	ld	bc, (iy + 2)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	iy, (ix - 53)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	c, 15
	call	__sshru
	ld	(ix - 56), l
	ld	(ix - 55), h
	ld.sis	bc, -32768
	add.sis	iy, bc
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	inc.sis	bc
	or	a, a
	sbc.sis	hl, bc
	sbc	hl, hl
	push	hl
	pop	iy
	ld	hl, (ix + 9)
	ld	bc, -8388608
	add	hl, bc
	push	hl
	pop	bc
	ex	de, hl
	ld	de, -8388608
	add	hl, de
	or	a, a
	sbc	hl, bc
	jp	c, .LBB3_57
; %bb.52:                               ;   in Loop: Header=BB3_47 Depth=1
	ld	bc, 0
	push	bc
	pop	iy
	ld	l, (ix - 56)
	ld	h, (ix - 55)
	.local	.LBB3_53
.LBB3_53:                               ;   in Loop: Header=BB3_47 Depth=1
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	jp	.LBB3_59
	.local	.LBB3_54
.LBB3_54:                               ;   in Loop: Header=BB3_47 Depth=1
	ld.sis	de, -32768
	ld	hl, (ix - 53)
	add.sis	hl, de
                                        ; kill: def $hl killed $hl killed $uhl
	inc.sis	de
	or	a, a
	sbc.sis	hl, de
	sbc	hl, hl
	push	hl
	pop	iy
	inc	iy
	jp	.LBB3_59
	.local	.LBB3_55
.LBB3_55:                               ;   in Loop: Header=BB3_47 Depth=1
	ld	iy, (iy)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	ld	hl, (ix + 6)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	ld	(ix - 6), iy
	ld	a, (ix - 4)
	rlc	a
	sbc	a, a
	ld	(ix - 56), a                    ; 1-byte Folded Spill
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	rlc	d
	sbc	a, a
	lea	hl, iy + 0
	ld	e, (ix - 56)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 56), hl
	ld	(ix - 59), e                    ; 1-byte Folded Spill
	ld	iy, (ix - 47)
	ld	bc, (iy + 2)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	hl, (ix + 9)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	(ix - 3), iy
	ld	a, (ix - 1)
	rlc	a
	sbc	a, a
	ld	(ix - 62), a                    ; 1-byte Folded Spill
	ld	de, (ix - 53)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	rlc	d
	sbc	a, a
	lea	hl, iy + 0
	ld	e, (ix - 62)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	bc, (ix - 56)
	ld	a, (ix - 59)                    ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	iy, 1
	jp	p, .LBB3_58
; %bb.56:                               ;   in Loop: Header=BB3_47 Depth=1
	ld	iy, 0
	jr	.LBB3_58
	.local	.LBB3_57
.LBB3_57:                               ;   in Loop: Header=BB3_47 Depth=1
	inc	iy
	.local	.LBB3_58
.LBB3_58:                               ;   in Loop: Header=BB3_47 Depth=1
	ld	bc, 0
	.local	.LBB3_59
.LBB3_59:                               ;   in Loop: Header=BB3_47 Depth=1
	add	iy, iy
	lea	de, iy + 0
	ld	iy, (ix - 47)
	add	iy, de
	ld	iy, (iy + 24)
	push	bc
	pop	de
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	bc, -32768
	add.sis	hl, bc
	or	a, a
	sbc.sis	hl, bc
	jp	nc, .LBB3_47
; %bb.60:
	ld	bc, (_subsectors)
	ld	l, 127
	ld	a, iyh
	and	a, l
	ld	iyh, a
	or	a, a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	de, (_segs)
	ld	(ix - 47), de
	add	hl, hl
	add	hl, hl
	ex	de, hl
	push	bc
	pop	iy
	add	iy, de
	ld	de, (iy + 2)
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	bc, 14
	call	__imulu
	ex	de, hl
	ld	iy, (ix - 47)
	add	iy, de
	ld	hl, (_sides)
	ld	(ix - 47), hl
	ld	hl, (_map_lines)
	ld	(ix - 50), hl
	ld	de, (iy + 6)
	ld	bc, 0
	push	bc
	pop	hl
	ld	l, e
	ld	h, d
	ld	de, (iy + 8)
	push	bc
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	bc, 14
	call	__imulu
	ex	de, hl
	ld	hl, (ix - 50)
	add	hl, de
	add	iy, iy
	lea	de, iy + 0
	push	hl
	pop	iy
	add	iy, de
	ld	de, (iy + 10)
	ld	bc, 0
	push	bc
	pop	hl
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	iy, (ix - 47)
	add	iy, de
	ld	a, (iy + 7)
	push	bc
	pop	hl
	ld	l, a
	add	hl, hl
	ld	(ix - 47), hl
	ex	de, hl
	ld	hl, _sector_floor
	add	hl, de
	ld	bc, (hl)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	iy, (ix + 12)
	lea	bc, iy + 0
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	ld	bc, -8388608
	add	hl, bc
	ld	bc, -8388583
	or	a, a
	sbc	hl, bc
	ld	a, b
	jp	nc, .LBB3_2
; %bb.61:
	ld	bc, (ix - 47)
	ld	hl, _sector_ceiling
	add	hl, bc
	ld	bc, (hl)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	(ix - 47), hl
	lea	hl, iy + 0
	push	de
	pop	iy
	ld	bc, -8388608
	add	iy, bc
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jr	c, .LBB3_63
; %bb.62:
	ld	de, (ix + 12)
	.local	.LBB3_63
.LBB3_63:
	ld	hl, (ix - 47)
	or	a, a
	sbc	hl, de
	ld	de, -8388608
	add	hl, de
	ld	de, -8388552
	or	a, a
	sbc	hl, de
	ccf
                                        ; kill: def $a killed $a
	sbc	a, a
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB3_64
.LBB3_64:
	xor	a, a
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end3
.Lfunc_end3:
	.size	_engine_can_move, .Lfunc_end3-_engine_can_move
                                        ; -- End function
	.section	.text._engine_tick,"ax",@progbits
	.globl	_engine_tick                    ; -- Begin function engine_tick
	.type	_engine_tick,@function
_engine_tick:                           ; @engine_tick
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	ld	hl, -178
	add	hl, sp
	ld	sp, hl
	or	a, a
	sbc	hl, hl
	ld	a, (_player+30)
	bit	0, a
	jr	nz, .LBB4_2
; %bb.1:
	ld	a, (_player+29)
	bit	0, a
	jr	z, .LBB4_3
	.local	.LBB4_2
.LBB4_2:
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB4_3
.LBB4_3:
	ld	de, -141
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	d, (ix + 6)
	ld	iy, _player+24
	or	a, a
	sbc	hl, hl
	ld	(ix - 108), hl
	ld	e, 1
	ld	hl, (iy)
	inc.sis	hl
	ld	(iy), l
	ld	(iy + 1), h
	ld	a, (_player+27)
	ld	l, a
	or	a, a
	jp	z, .LBB4_38
; %bb.4:
	ld	iyl, 0
	dec	l
	ld	a, l
	ld	(_player+27), a
	cp	a, 15
	jp	nz, .LBB4_33
; %bb.5:
	ld	hl, _player+16
	ld	bc, (hl)
	sbc.sis	hl, hl
	adc.sis	hl, bc
	jp	z, .LBB4_37
; %bb.6:
	scf
	sbc	hl, hl
	ld	(ix - 99), hl
	ld	hl, 2048
	ld	(ix - 117), hl
	ld	(ix - 123), bc
	ld	l, c
	ld	h, b
	dec.sis	hl
	ld	iy, _player+16
	ld	(iy), l
	ld	(iy + 1), h
	ld	hl, _player+18
	ld	iy, (hl)
	ld	de, 0
	push	de
	pop	hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	bc, 256
	add	hl, bc
	ld	bc, 1023
	call	__iand
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _sine_table
	add	hl, bc
	ld	hl, (hl)
	ld	(ix - 111), hl
	ld	l, 3
	ld	a, iyh
	and	a, l
	ld	iyh, a
	add.sis	iy, iy
	ld	e, iyl
	ld	d, iyh
	ld	hl, _sine_table
	add	hl, de
	ld	hl, (hl)
	ld	(ix - 114), hl
	ld	iy, (_player)
	ld	a, (_player+3)
	ld	e, a
	ld	l, 31
	lea	bc, iy + 0
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	d, 8
	ld	l, d
	call	__lshrs
	ld	(ix - 102), bc
	ld	iy, (_player+4)
	ld	a, (_player+7)
	ld	e, a
	lea	bc, iy + 0
	ld	l, 31
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, d
	call	__lshrs
	ld	(ix - 105), bc
	ld	bc, -8388608
	ld	hl, _player+8
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 120), hl
	ld	iy, _actors+5
	or	a, a
	sbc	hl, hl
	ld	(ix - 93), hl
	.local	.LBB4_7
.LBB4_7:                                ; =>This Inner Loop Header: Depth=1
	ld	a, (iy)
	or	a, a
	ld	(ix - 96), iy
	jp	z, .LBB4_19
; %bb.8:                                ;   in Loop: Header=BB4_7 Depth=1
	ld	a, (iy + 1)
	or	a, a
	jp	nz, .LBB4_19
; %bb.9:                                ;   in Loop: Header=BB4_7 Depth=1
	ld	a, (iy + 3)
	or	a, a
	jp	nz, .LBB4_19
; %bb.10:                               ;   in Loop: Header=BB4_7 Depth=1
	ld	de, (ix - 114)
	ld	a, d
	ld	l, a
	rlc	l
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 126), hl
	rlc	a
	sbc	a, a
	ld	de, -132
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), a                         ; 1-byte Folded Spill
	ld	de, (ix - 111)
	ld	a, d
	ld	l, a
	rlc	l
	sbc	hl, hl
	ld	l, e
	ld	h, d
	push	ix
	lea	ix, ix - 128
	ld	(ix - 1), hl
	pop	ix
	rlc	a
	sbc	a, a
	ld	de, -135
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), a                         ; 1-byte Folded Spill
	ld	de, (iy - 5)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	push	ix
	lea	ix, ix - 128
	ld	(ix - 28), hl
	pop	ix
	ld	de, (ix - 102)
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	de, (iy - 3)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, -159
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, (ix - 105)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	de, -147
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), bc
	ld	(ix - 90), bc
	ld	a, (ix - 88)
	rlc	a
	sbc	a, a
	ld	de, -144
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), a
	push	bc
	pop	hl
	ld	e, a
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 1)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 7)                     ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	(ix - 10), hl
	pop	ix
	ld	d, e
	ld	bc, -150
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), iy
	ld	(ix - 87), iy
	ld	a, (ix - 85)
	rlc	a
	sbc	a, a
	ld	bc, -153
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), a
	lea	hl, iy + 0
	ld	e, a
	ld	bc, (ix - 126)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 4
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	call	__lmulu
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 10
	ld	bc, (iy + 0)
	ld	a, d
	call	__ladd
	push	hl
	pop	iy
	lea	bc, iy + 0
	ld	a, e
	ld	l, 31
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	ld	de, -138
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), bc
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	bc, -144
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	ld	bc, (ix - 126)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 4
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	call	__lmulu
	push	hl
	pop	iy
	ld	d, e
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 22)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 25)                    ; 1-byte Folded Reload
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 1)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 7)                     ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	lea	hl, iy + 0
	ld	e, d
	call	__lsub
	push	hl
	pop	iy
	lea	bc, iy + 0
	ld	a, e
	ld	l, 31
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	push	bc
	pop	iy
	lea	hl, iy + 0
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	call	__ixor
	ld	bc, -8388608
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 10)
	pop	ix
	add	iy, bc
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	jr	c, .LBB4_19
; %bb.11:                               ;   in Loop: Header=BB4_7 Depth=1
	ld	hl, (ix - 117)
	add	hl, bc
	push	hl
	pop	bc
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB4_13
; %bb.12:                               ;   in Loop: Header=BB4_7 Depth=1
	ex	de, hl
	ld	de, 21
	or	a, a
	sbc	hl, de
	ld	hl, (ix - 120)
	jr	c, .LBB4_14
	.local	.LBB4_13
.LBB4_13:                               ;   in Loop: Header=BB4_7 Depth=1
	ld	bc, -8388608
	jr	.LBB4_19
	.local	.LBB4_14
.LBB4_14:                               ;   in Loop: Header=BB4_7 Depth=1
	push	hl
	ld	de, -159
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	ld	de, -156
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	ld	hl, (ix - 105)
	push	hl
	ld	hl, (ix - 102)
	push	hl
	call	_sight
	ld	hl, 15
	add	hl, sp
	ld	sp, hl
	bit	0, a
	ld	hl, (ix - 93)
	jr	nz, .LBB4_16
; %bb.15:                               ;   in Loop: Header=BB4_7 Depth=1
	ld	hl, (ix - 99)
	.local	.LBB4_16
.LBB4_16:                               ;   in Loop: Header=BB4_7 Depth=1
	bit	0, a
	ld	bc, -8388608
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 10
	ld	de, (iy + 0)
	jr	nz, .LBB4_18
; %bb.17:                               ;   in Loop: Header=BB4_7 Depth=1
	ld	de, (ix - 117)
	.local	.LBB4_18
.LBB4_18:                               ;   in Loop: Header=BB4_7 Depth=1
	ld	(ix - 99), hl
	ld	(ix - 117), de
	.local	.LBB4_19
.LBB4_19:                               ;   in Loop: Header=BB4_7 Depth=1
	ld	hl, (ix - 93)
	inc	hl
	ld	iy, (ix - 96)
	lea	iy, iy + 12
	ld	(ix - 93), hl
	ld	de, 91
	or	a, a
	sbc	hl, de
	jp	nz, .LBB4_7
; %bb.20:
	ld	de, (ix - 99)
	push	de
	pop	hl
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	c, .LBB4_28
; %bb.21:
	ld	iy, _random_state
	ld	hl, (iy)
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	bc, 25173
	call	__smulu
	ld	(ix - 99), de
	ld.sis	de, 13849
	add.sis	hl, de
	ld	(iy), l
	ld	(iy + 1), h
	ld.sis	bc, 3
	call	__sremu
	ld.sis	bc, 5
	call	__smulu
	add.sis	hl, bc
	ld	(ix - 93), l
	ld	(ix - 92), h
	ld	bc, 12
	ld	hl, (ix - 99)
	call	__imulu
	ex	de, hl
	ld	iy, _actors
	add	iy, de
	ld	e, (iy + 5)
	ld	a, e
	or	a, a
	jr	z, .LBB4_28
; %bb.22:
	ld	a, (iy + 6)
	or	a, a
	jr	nz, .LBB4_28
; %bb.23:
	ld	a, (iy + 8)
	or	a, a
	jr	nz, .LBB4_28
; %bb.24:
	ld	(ix - 96), iy
	ld	a, (iy + 10)
	or	a, a
	jr	nz, .LBB4_28
; %bb.25:
	ld	iy, (_map_actors)
	ld	d, 0
	ld	bc, 14
	ld	hl, (ix - 99)
	call	__imulu
	push	hl
	pop	bc
	add	iy, bc
	ld	(ix - 102), iy
	ld	c, (ix - 93)
	ld	b, (ix - 92)
	ld	l, c
	ld	h, b
	or	a, a
	sbc.sis	hl, de
	jr	nc, .LBB4_29
; %bb.26:
	ld	l, c
	ld	a, e
	sub	a, l
	ld	l, a
	ld	iy, (ix - 96)
	lea	de, iy + 0
	ld	(iy + 5), l
	ld	iy, (ix - 102)
	ld	a, (iy + 12)
	cp	a, 1
	jr	nz, .LBB4_28
; %bb.27:
	push	de
	pop	iy
	ld	(iy + 9), 12
	.local	.LBB4_28
.LBB4_28:
	ld	e, 0
	ld	d, (ix + 6)
	ld	a, (_player+28)
	ld	l, a
	or	a, a
	jp	nz, .LBB4_39
	jp	.LBB4_40
	.local	.LBB4_29
.LBB4_29:
	ld	iy, (ix - 96)
	ld	(iy + 5), 0
	lea	hl, iy + 0
	ld	(iy + 9), 0
	ld	iy, (ix - 102)
	ld	a, (iy + 12)
	cp	a, 1
	ld	d, (ix + 6)
	jr	nz, .LBB4_31
; %bb.30:
	push	hl
	pop	iy
	ld	(iy + 10), 1
	ld	iy, _player+20
	ld	hl, (iy)
	inc.sis	hl
	ld	(iy), l
	ld	(iy + 1), h
	ld	iy, (ix - 123)
	ld.sis	bc, 4
	add.sis	iy, bc
	ld	hl, _player+16
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld	e, b
	ld	a, (_player+28)
	ld	l, a
	or	a, a
	jr	nz, .LBB4_39
	jr	.LBB4_40
	.local	.LBB4_31
.LBB4_31:
	cp	a, 3
	jp	nz, .LBB4_327
; %bb.32:
	ld	hl, (ix - 99)
	push	hl
	call	_explode_barrel
	ld	d, (ix + 6)
	pop	hl
	ld	a, (_player+27)
	ld	l, a
	ld	e, 1
	ld	c, 0
	ld	iyl, c
	.local	.LBB4_33
.LBB4_33:
	ld	a, l
	or	a, a
	jr	nz, .LBB4_37
; %bb.34:
	bit	5, d
	jr	z, .LBB4_38
; %bb.35:
	ld	hl, _player+16
	ld	hl, (hl)
	add.sis	hl, bc
	or	a, a
	sbc.sis	hl, bc
	jr	z, .LBB4_38
; %bb.36:
	ld	a, 19
	ld	(_player+27), a
	.local	.LBB4_37
.LBB4_37:
	ld	e, iyl
	.local	.LBB4_38
.LBB4_38:
	ld	a, (_player+28)
	ld	l, a
	or	a, a
	jr	z, .LBB4_40
	.local	.LBB4_39
.LBB4_39:
	dec	l
	ld	a, l
	ld	(_player+28), a
	.local	.LBB4_40
.LBB4_40:
	ld	a, 1
	ld	bc, 3
	ld	iy, 0
	ld	iyl, d
	bit	4, d
	push	ix
	lea	ix, ix - 128
	ld	(ix - 7), e
	pop	ix
	jr	nz, .LBB4_44
; %bb.41:
	ld	a, d
	add	a, -128
	cp	a, -128
	jr	nc, .LBB4_45
; %bb.42:
	ld	bc, 6
	bit	2, d
	jr	z, .LBB4_46
	.local	.LBB4_43
.LBB4_43:
	ld	hl, _player+18
	ld	hl, (hl)
	add.sis	hl, bc
	ld	e, 3
	ld	a, h
	and	a, e
	ld	h, a
	ld	(ix - 93), hl
	ld	hl, _player+18
	ld	(ix - 96), bc
	ld	bc, (ix - 93)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	ld	bc, (ix - 96)
	bit	3, d
	jr	nz, .LBB4_47
	jp	.LBB4_48
	.local	.LBB4_44
.LBB4_44:
	ld	l, a
	ld	a, d
	and	a, l
	ld	l, a
	ld	de, 0
	ld	e, l
	ld	c, 22
	lea	hl, iy + 0
	call	__ishl
	add	hl, hl
	sbc	hl, hl
	add	hl, de
	ld	(ix - 93), hl
	ld	c, 3
	lea	hl, iy + 0
	call	__ishru
	ld	bc, 1
	call	__iand
	ex	de, hl
	ld	c, 21
	lea	hl, iy + 0
	call	__ishl
	add	hl, hl
	sbc	hl, hl
	add	hl, de
	jp	.LBB4_49
	.local	.LBB4_45
.LBB4_45:
	bit	2, d
	jr	nz, .LBB4_43
	.local	.LBB4_46
.LBB4_46:
	bit	3, d
	jp	z, .LBB4_48
	.local	.LBB4_47
.LBB4_47:
	ld	hl, _player+18
	ld	hl, (hl)
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, bc
	ld	e, 3
	ld	a, h
	and	a, e
	ld	h, a
	lea	bc, iy + 0
	ld	iy, _player+18
	ld	(iy), l
	ld	(iy + 1), h
	push	bc
	pop	iy
	.local	.LBB4_48
.LBB4_48:
	ld	l, 1
	ld	a, d
	and	a, l
	ld	l, a
	ld	de, 0
	ld	e, l
	ld	c, 22
	lea	hl, iy + 0
	call	__ishl
	add	hl, hl
	sbc	hl, hl
	add	hl, de
	ld	(ix - 93), hl
	or	a, a
	sbc	hl, hl
	.local	.LBB4_49
.LBB4_49:
	ld	(ix - 102), hl
	ld	iy, (_player)
	ld	a, (_player+3)
	ld	e, a
	ld	d, 31
	lea	bc, iy + 0
	ld	l, d
	call	__lshrs
	ld	l, 24
	call	__lshru
	ld	(ix - 114), iy
	lea	hl, iy + 0
	ld	(ix - 123), e                   ; 1-byte Folded Spill
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	ld	(ix - 96), bc
	ld	(ix - 117), a                   ; 1-byte Folded Spill
	ld	iy, (_player+4)
	ld	a, (_player+7)
	ld	e, a
	lea	bc, iy + 0
	ld	l, d
	call	__lshrs
	ld	l, 24
	call	__lshru
	push	ix
	lea	ix, ix - 128
	ld	(ix - 1), iy
	pop	ix
	lea	hl, iy + 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 4
	ld	(iy + 0), e                     ; 1-byte Folded Spill
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	ld	(ix - 99), bc
	ld	d, a
	ld	hl, (ix - 93)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	ld	(ix - 126), d                   ; 1-byte Folded Spill
	jr	nz, .LBB4_54
; %bb.50:
	ld	hl, (ix - 102)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jr	nz, .LBB4_52
; %bb.51:
	ld	a, 0
	jr	.LBB4_53
	.local	.LBB4_52
.LBB4_52:
	ld	a, -1
	.local	.LBB4_53
.LBB4_53:
	bit	0, a
	ld	iy, (ix - 96)
	ld	a, (ix - 117)                   ; 1-byte Folded Reload
	ld	(ix - 105), a
	ld	hl, (ix - 99)
	ld	(ix - 111), hl
	ld	(ix - 120), d                   ; 1-byte Folded Spill
	jp	z, .LBB4_62
	.local	.LBB4_54
.LBB4_54:
	ld	hl, _player+18
	ld	iy, (hl)
	or	a, a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	de, 256
	add	hl, de
	ld	bc, 1023
	call	__iand
	add	hl, hl
	ex	de, hl
	ld	bc, _sine_table
	push	bc
	pop	hl
	add	hl, de
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 105), hl
	ld	l, 3
	ld	a, iyh
	and	a, l
	ld	iyh, a
	add.sis	iy, iy
	ld	de, 0
	ld	e, iyl
	ld	d, iyh
	push	bc
	pop	hl
	add	hl, de
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	hl, (ix - 93)
	ld	bc, (ix - 105)
	call	__imulu
	ex	de, hl
	ld	hl, (ix - 102)
	lea	bc, iy + 0
	call	__imulu
	add	hl, de
	ex	de, hl
	ld	(ix - 120), de
	ld	a, (ix + 6)
	add	a, -128
	cp	a, -128
	ccf
                                        ; kill: def $a killed $a
	sbc	a, a
	ld	hl, 3
                                        ; kill: def $l killed $l killed $uhl
	add	a, l
	ld	c, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 10), c
	pop	ix
	ex	de, hl
	call	__ishl
	push	hl
	pop	bc
	ld	(ix - 84), bc
	ld	a, (ix - 82)
	rlc	a
	sbc	a, a
	ld	hl, (ix - 114)
	ld	e, (ix - 123)                   ; 1-byte Folded Reload
	call	__ladd
	push	ix
	lea	ix, ix - 128
	ld	(ix - 16), hl
	pop	ix
	ld	bc, -147
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), e                         ; 1-byte Folded Spill
	ld	hl, (ix - 93)
	lea	bc, iy + 0
	call	__imulu
	ex	de, hl
	ld	hl, (ix - 102)
	ld	bc, (ix - 105)
	call	__imulu
	push	hl
	pop	bc
	ld	(ix - 102), de
	ex	de, hl
	ld	(ix - 111), bc
	or	a, a
	sbc	hl, bc
	ld	de, -138
	lea	iy, ix + 0
	add	iy, de
	ld	c, (iy + 0)                     ; 1-byte Folded Reload
	call	__ishl
	push	hl
	pop	bc
	ld	(ix - 81), bc
	ld	a, (ix - 79)
	rlc	a
	sbc	a, a
	ld	de, -129
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 4
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	call	__ladd
	push	hl
	pop	bc
	ld	hl, (ix - 120)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 1
	ld	(iy + 0), bc
	ld	(ix - 93), e
	jp	z, .LBB4_57
; %bb.55:
	ld	l, 31
	ld	bc, -144
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	push	de
	pop	bc
	push	ix
	lea	ix, ix - 128
	push	af
	ld	a, (ix - 19)                    ; 1-byte Folded Reload
	ld	iyl, a
	pop	af
	pop	ix
	ld	a, iyl
	call	__lshrs
	ld	l, 24
	call	__lshru
	ex	de, hl
	ld	e, iyl
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	ld	hl, _player+10
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	push	hl
	ld	hl, (ix - 99)
	push	hl
	push	bc
	call	_engine_can_move
	ld	hl, 9
	add	hl, sp
	ld	sp, hl
	bit	0, a
	jr	z, .LBB4_57
; %bb.56:
	ld	de, -144
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	(_player), hl
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	ld	(_player+3), a
	ld	(ix - 114), hl
	ld	(ix - 123), a                   ; 1-byte Folded Spill
	.local	.LBB4_57
.LBB4_57:
	ld	l, 31
	ld	de, (ix - 114)
	push	de
	pop	bc
	push	af
	ld	a, (ix - 123)                   ; 1-byte Folded Reload
	ld	iyl, a
	pop	af
	ld	a, iyl
	call	__lshrs
	ld	l, 24
	call	__lshru
	ex	de, hl
	ld	e, iyl
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	push	bc
	pop	iy
	ld	(ix - 105), a                   ; 1-byte Folded Spill
	ld	hl, (ix - 102)
	ld	de, (ix - 111)
	or	a, a
	sbc	hl, de
	jr	nz, .LBB4_59
; %bb.58:
	ld	hl, (ix - 99)
	ld	(ix - 111), hl
	ld	d, (ix - 126)                   ; 1-byte Folded Reload
	ld	(ix - 120), d                   ; 1-byte Folded Spill
	jp	.LBB4_62
	.local	.LBB4_59
.LBB4_59:
	ld	l, 31
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 1)
	pop	ix
	push	de
	pop	bc
	ld	a, (ix - 93)                    ; 1-byte Folded Reload
	call	__lshrs
	ld	l, 24
	call	__lshru
	ex	de, hl
	ld	e, (ix - 93)                    ; 1-byte Folded Reload
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	ld	(ix - 120), a                   ; 1-byte Folded Spill
	ld	hl, _player+10
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	push	hl
	ld	(ix - 111), bc
	push	bc
	ld	(ix - 102), iy
	push	iy
	call	_engine_can_move
	ld	hl, 9
	add	hl, sp
	ld	sp, hl
	bit	0, a
	jr	z, .LBB4_61
; %bb.60:
	ld	de, -129
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	(_player+4), hl
	ld	a, (ix - 93)                    ; 1-byte Folded Reload
	ld	(_player+7), a
	ld	iy, (ix - 102)
	ld	d, (ix - 126)                   ; 1-byte Folded Reload
	jr	.LBB4_62
	.local	.LBB4_61
.LBB4_61:
	ld	hl, (ix - 99)
	ld	(ix - 111), hl
	ld	d, (ix - 126)                   ; 1-byte Folded Reload
	ld	(ix - 120), d                   ; 1-byte Folded Spill
	ld	iy, (ix - 102)
	.local	.LBB4_62
.LBB4_62:
	ld	(ix - 102), iy
	lea	hl, iy + 0
	ld	e, (ix - 105)                   ; 1-byte Folded Reload
	ld	bc, (ix - 96)
	ld	a, (ix - 117)                   ; 1-byte Folded Reload
	call	__lcmpu
	jr	nz, .LBB4_65
; %bb.63:
	ld	hl, (ix - 111)
	ld	e, (ix - 120)                   ; 1-byte Folded Reload
	ld	bc, (ix - 99)
	ld	a, d
	call	__lcmpu
	jr	nz, .LBB4_65
; %bb.64:
	ld	a, (_player+26)
	or	a, a
	sbc	hl, hl
	ld	l, a
	jp	.LBB4_83
	.local	.LBB4_65
.LBB4_65:
	ld	de, 235
	ld	hl, (_nodes)
	ld	(ix - 93), hl
	ld	iy, 0
	.local	.LBB4_66
.LBB4_66:                               ; =>This Inner Loop Header: Depth=1
	ex	de, hl
	ld	bc, 255
	call	__iand
	add	hl, hl
	ex	de, hl
	ld	hl, _node_offsets
	add	hl, de
	ld	hl, (hl)
	lea	de, iy + 0
	ld	e, l
	ld	d, h
	ld	iy, (ix - 93)
	add	iy, de
	ld	de, (iy + 4)
	ld	(ix - 114), de
	sbc.sis	hl, hl
	adc.sis	hl, de
	jp	nz, .LBB4_71
; %bb.67:                               ;   in Loop: Header=BB4_66 Depth=1
	ld	de, (iy)
	ld	a, d
	ld	l, a
	rlc	l
	sbc	hl, hl
	ld	l, e
	ld	h, d
	rlc	a
	sbc	a, a
	ld	e, a
	ld	bc, (ix - 102)
	ld	a, (ix - 105)                   ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	a, 1
	jp	m, .LBB4_69
; %bb.68:                               ;   in Loop: Header=BB4_66 Depth=1
	ld	a, 0
	.local	.LBB4_69
.LBB4_69:                               ;   in Loop: Header=BB4_66 Depth=1
	ld	hl, (iy + 6)
	bit	0, a
	jp	z, .LBB4_76
; %bb.70:                               ;   in Loop: Header=BB4_66 Depth=1
                                        ; kill: def $hl killed $hl killed $uhl
	ld	c, 15
	call	__sshru
	ex.sis	de, hl
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	jp	.LBB4_81
	.local	.LBB4_71
.LBB4_71:                               ;   in Loop: Header=BB4_66 Depth=1
	ld	de, (iy + 6)
	sbc.sis	hl, hl
	adc.sis	hl, de
	ld	(ix - 123), iy
	jp	nz, .LBB4_77
; %bb.72:                               ;   in Loop: Header=BB4_66 Depth=1
	ld	de, (iy + 2)
	ld	a, d
	ld	l, a
	rlc	l
	sbc	hl, hl
	ld	l, e
	ld	h, d
	rlc	a
	sbc	a, a
	ld	e, a
	ld	bc, (ix - 111)
	ld	a, (ix - 120)                   ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	a, 1
	jp	m, .LBB4_74
; %bb.73:                               ;   in Loop: Header=BB4_66 Depth=1
	ld	a, 0
	.local	.LBB4_74
.LBB4_74:                               ;   in Loop: Header=BB4_66 Depth=1
	ld	iy, (ix - 114)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	c, 15
	call	__sshru
	ex.sis	de, hl
	ld.sis	bc, -32768
	add.sis	iy, bc
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	inc.sis	bc
	or	a, a
	sbc.sis	hl, bc
	sbc	hl, hl
	bit	0, a
	jp	nz, .LBB4_79
; %bb.75:                               ;   in Loop: Header=BB4_66 Depth=1
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	jp	.LBB4_80
	.local	.LBB4_76
.LBB4_76:                               ;   in Loop: Header=BB4_66 Depth=1
	ld.sis	de, -32768
	add.sis	hl, de
                                        ; kill: def $hl killed $hl killed $uhl
	inc.sis	de
	or	a, a
	sbc.sis	hl, de
	sbc	hl, hl
	inc	hl
	jp	.LBB4_81
	.local	.LBB4_77
.LBB4_77:                               ;   in Loop: Header=BB4_66 Depth=1
	ld	hl, (iy)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 1), hl
	pop	ix
	ld	a, h
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 1)
	pop	ix
	ld	c, l
	ld	b, h
	ld	hl, (ix - 102)
	or	a, a
	sbc	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 1), hl
	pop	ix
	ld	(ix - 78), hl
	ld	a, (ix - 76)
	rlc	a
	sbc	a, a
	ld	bc, -132
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), a                         ; 1-byte Folded Spill
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	rlc	d
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 1)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 4)                     ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	(ix - 1), hl
	pop	ix
	ld	bc, -132
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), e                         ; 1-byte Folded Spill
	ld	bc, (iy + 2)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	hl, (ix - 111)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	(ix - 75), iy
	ld	a, (ix - 73)
	rlc	a
	sbc	a, a
	ld	de, -138
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), a                         ; 1-byte Folded Spill
	ld	de, (ix - 114)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	rlc	d
	sbc	a, a
	lea	hl, iy + 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 10
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	call	__lmulu
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 1
	ld	bc, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 4
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	hl, 1
	jp	p, .LBB4_80
; %bb.78:                               ;   in Loop: Header=BB4_66 Depth=1
	ld	hl, 0
	jr	.LBB4_80
	.local	.LBB4_79
.LBB4_79:                               ;   in Loop: Header=BB4_66 Depth=1
	inc	hl
	.local	.LBB4_80
.LBB4_80:                               ;   in Loop: Header=BB4_66 Depth=1
	ld	iy, (ix - 123)
	.local	.LBB4_81
.LBB4_81:                               ;   in Loop: Header=BB4_66 Depth=1
	add	hl, hl
	ex	de, hl
	add	iy, de
	ld	hl, (iy + 24)
	ld	iy, 0
	lea	de, iy + 0
	ld	e, l
	ld	d, h
	ld	(ix - 114), hl
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	bc, -32768
	add.sis	hl, bc
	or	a, a
	sbc.sis	hl, bc
	jp	nc, .LBB4_66
; %bb.82:
	lea	de, iy + 0
	ld	iy, (_subsectors)
	ld	l, 127
	ld	bc, (ix - 114)
	ld	a, b
	and	a, l
	ld	b, a
	ex	de, hl
	ld	l, c
	ld	h, b
	ld	de, (_segs)
	ld	(ix - 93), de
	add	hl, hl
	add	hl, hl
	ex	de, hl
	add	iy, de
	ld	bc, (iy + 2)
	ld	de, 0
	push	de
	pop	hl
	ld	l, c
	ld	h, b
	ld	bc, 14
	call	__imulu
	push	hl
	pop	bc
	ld	iy, (ix - 93)
	add	iy, bc
	ld	hl, (_sides)
	ld	(ix - 93), hl
	ld	hl, (_map_lines)
	ld	(ix - 114), hl
	ld	bc, (iy + 6)
	push	de
	pop	hl
	ld	l, c
	ld	h, b
	ld	bc, (iy + 8)
	push	de
	pop	iy
	ld	iyl, c
	ld	iyh, b
	ld	bc, 14
	call	__imulu
	push	hl
	pop	bc
	ld	hl, (ix - 114)
	add	hl, bc
	add	iy, iy
	lea	bc, iy + 0
	push	hl
	pop	iy
	add	iy, bc
	ld	hl, (iy + 10)
	ld	e, l
	ld	d, h
	ex	de, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	iy, (ix - 93)
	add	iy, de
	ld	a, (iy + 7)
	or	a, a
	sbc	hl, hl
	ld	l, a
	ld	(_player+26), a
	.local	.LBB4_83
.LBB4_83:
	add	hl, hl
	ld	de, -132
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ex	de, hl
	ld	hl, _sector_floor
	add	hl, de
	ld	de, (hl)
	ld	hl, _player+10
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	de, 41
	add	iy, de
	ld	hl, _player+8
	ld	bc, (hl)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	(ix - 114), bc
	ld	e, c
	ld	d, b
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	push	hl
	pop	de
	ld	bc, -8388608
	add	hl, bc
	ld	bc, 8388601
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB4_85
; %bb.84:
	ld	de, -8
	.local	.LBB4_85
.LBB4_85:
	push	de
	pop	hl
	ld	bc, -8388608
	add	hl, bc
	ld	bc, -8388600
	or	a, a
	sbc	hl, bc
	jr	c, .LBB4_87
; %bb.86:
	ld	de, 8
	.local	.LBB4_87
.LBB4_87:
	ld	hl, _floor_wait
	ld	(ix - 93), hl
	ld	hl, 80
	ld	bc, -153
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
                                        ; kill: def $de killed $de killed $ude
	ld	iy, (ix - 114)
	add.sis	iy, de
	ld	(ix - 114), iy
	ld	hl, _player+8
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld	hl, (_map_sectors)
	ld	de, -129
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	hl, (ix - 102)
	ld	e, (ix - 105)                   ; 1-byte Folded Reload
	ld	bc, (ix - 96)
	ld	a, (ix - 117)                   ; 1-byte Folded Reload
	call	__lcmpu
	jr	nz, .LBB4_89
; %bb.88:
	ld	hl, (ix - 111)
	ld	e, (ix - 120)                   ; 1-byte Folded Reload
	ld	bc, (ix - 99)
	ld	a, (ix - 126)                   ; 1-byte Folded Reload
	call	__lcmpu
	jp	z, .LBB4_177
	.local	.LBB4_89
.LBB4_89:
	ld	iy, (ix - 96)
	ld	bc, -8388608
	push	bc
	pop	de
	add	iy, de
	ld	bc, (ix - 102)
	push	bc
	pop	hl
	add	hl, de
	ld	(ix - 105), iy
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	ld	hl, (ix - 96)
	jr	c, .LBB4_91
; %bb.90:
	push	bc
	pop	hl
	.local	.LBB4_91
.LBB4_91:
	ld	(ix - 120), hl
	push	bc
	pop	iy
	ld	de, -8388608
	add	iy, de
	ld	hl, (ix - 105)
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	ld	hl, (ix - 96)
	ld	(ix - 123), hl
	jr	c, .LBB4_93
; %bb.92:
	ld	hl, (ix - 102)
	ld	(ix - 123), hl
	.local	.LBB4_93
.LBB4_93:
	ld	iy, (ix - 99)
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	ld	bc, (ix - 111)
	push	bc
	pop	hl
	add	hl, de
	ld	(ix - 126), iy
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	push	bc
	pop	iy
	ld	bc, (ix - 99)
	jr	c, .LBB4_95
; %bb.94:
	lea	bc, iy + 0
	.local	.LBB4_95
.LBB4_95:
	ld	de, -144
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), bc
	ld	hl, (_map_lines)
	ld	(ix - 117), hl
	ld	hl, (_map_vertices)
	ld	(ix - 105), hl
	ld	de, -8388608
	add	iy, de
	ld	hl, (ix - 126)
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	ld	hl, (ix - 99)
	jr	c, .LBB4_97
; %bb.96:
	ld	hl, (ix - 111)
	.local	.LBB4_97
.LBB4_97:
	ld	de, -156
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, 2730
	ld	hl, (ix - 117)
	add	hl, de
	ld	de, (hl)
	ld	bc, 0
	push	bc
	pop	hl
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	ld	de, (ix - 105)
	push	de
	pop	iy
	add	iy, bc
	ld	bc, 2732
	ld	hl, (ix - 117)
	add	hl, bc
	ld	bc, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	ex	de, hl
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 31), iy
	pop	ix
	ld	bc, (iy)
	ld	de, -162
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	hl, (hl)
	ld	(ix - 126), hl
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld.sis	hl, -32768
	ex.sis	de, hl
	add.sis	iy, de
	ld	l, c
	ld	h, b
	add.sis	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 22), l
	ld	(ix - 21), h
	pop	ix
	push	ix
	lea	ix, ix - 128
	push	hl
	lea	hl, iy + 0
	ld	(ix - 19), l
	ld	(ix - 18), h
	pop	hl
	pop	ix
	ld	e, iyl
	ld	d, iyh
	or	a, a
	sbc.sis	hl, de
	ld	hl, (ix - 126)
	ld	de, -138
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	(iy + 0), bc
	ld	e, c
	ld	d, b
	jr	c, .LBB4_99
; %bb.98:
	ld	e, l
	ld	d, h
	.local	.LBB4_99
.LBB4_99:
	ld	hl, (_sides)
	ld	bc, -165
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	ld	hl, (ix - 120)
	add	hl, de
	ld	(ix - 120), hl
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	c, .LBB4_137
; %bb.100:
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	bc, -150
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)
	ld	d, (iy + 1)
	or	a, a
	sbc.sis	hl, de
	ld	de, -138
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	ld	e, l
	ld	d, h
	jr	c, .LBB4_102
; %bb.101:
	ld	hl, (ix - 126)
	ld	e, l
	ld	d, h
	.local	.LBB4_102
.LBB4_102:
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	iy, (ix - 123)
	ld	de, -8388608
	add	iy, de
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	c, .LBB4_137
; %bb.103:
	ld	de, -159
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	bc, (iy + 2)
	ld	de, -162
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	hl, (iy + 2)
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld.sis	hl, -32768
	ex.sis	de, hl
	add.sis	iy, de
	ld	l, c
	ld	h, b
	add.sis	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 34), l
	ld	(ix - 33), h
	pop	ix
	push	ix
	lea	ix, ix - 128
	push	hl
	lea	hl, iy + 0
	ld	(ix - 31), l
	ld	(ix - 30), h
	pop	hl
	pop	ix
	ld	e, iyl
	ld	d, iyh
	or	a, a
	sbc.sis	hl, de
	ld	de, -147
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	ld	de, -150
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	(iy + 0), bc
	ld	e, c
	ld	d, b
	jr	c, .LBB4_105
; %bb.104:
	ld	e, l
	ld	d, h
	.local	.LBB4_105
.LBB4_105:
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 16)
	pop	ix
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	c, .LBB4_137
; %bb.106:
	ld	de, -159
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	bc, -162
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)
	ld	d, (iy + 1)
	or	a, a
	sbc.sis	hl, de
	ld	de, -150
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	ld	e, l
	ld	d, h
	ld	bc, -156
	lea	hl, ix + 0
	push	af
	add	hl, bc
	pop	af
	ld	iy, (hl)
	jr	c, .LBB4_108
; %bb.107:
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 19)
	pop	ix
	ld	e, l
	ld	d, h
	.local	.LBB4_108
.LBB4_108:
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, -8388608
	add	iy, de
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	c, .LBB4_137
; %bb.109:
	ld	de, (ix - 126)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	bc, -138
	lea	hl, ix + 0
	add	hl, bc
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	ld	de, -138
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), bc
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	ld	de, -159
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -147
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ld	bc, -150
	lea	hl, ix + 0
	add	hl, bc
	ld	iy, (hl)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	ld	(ix - 126), bc
	ex	de, hl
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	ld	hl, (ix - 96)
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 10)
	pop	ix
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	(ix - 72), bc
	ld	a, (ix - 70)
	rlc	a
	sbc	a, a
	ld	d, a
	ld	(ix - 69), iy
	ld	a, (ix - 67)
	rlc	a
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 43), a
	pop	ix
	lea	hl, iy + 0
	ld	e, a
	ld	a, d
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	(ix - 19), hl
	pop	ix
	ld	bc, -150
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), e                         ; 1-byte Folded Spill
	ld	hl, (ix - 99)
	ld	de, (ix - 126)
	or	a, a
	sbc	hl, de
	ld	(ix - 66), hl
	ld	a, (ix - 64)
	rlc	a
	sbc	a, a
	ld	e, a
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 31)
	pop	ix
	ld	(ix - 63), bc
	ld	a, (ix - 61)
	rlc	a
	sbc	a, a
	ld	d, a
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	(ix - 34), hl
	pop	ix
	ld	bc, -168
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), e                         ; 1-byte Folded Spill
	ld	hl, (ix - 102)
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 10)
	pop	ix
	or	a, a
	sbc	hl, bc
	push	hl
	pop	bc
	ld	(ix - 60), bc
	ld	a, (ix - 58)
	rlc	a
	sbc	a, a
	lea	hl, iy + 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 43
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	call	__lmulu
	ld	bc, -138
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	bc, -171
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), e                     ; 1-byte Folded Spill
	ld	hl, (ix - 111)
	ld	bc, (ix - 126)
	or	a, a
	sbc	hl, bc
	ld	(ix - 57), hl
	ld	a, (ix - 55)
	rlc	a
	sbc	a, a
	ld	e, a
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 31
	ld	bc, (iy + 0)
	ld	a, d
	call	__lmulu
	ld	(ix - 126), hl
	ld	bc, -159
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), e                     ; 1-byte Folded Spill
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	bc, -150
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 34
	ld	bc, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 40
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	d, 1
	ld	iyh, 0
	ld	iyl, d
	jp	m, .LBB4_111
; %bb.110:
	ld	iyl, iyh
	.local	.LBB4_111
.LBB4_111:
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 10)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 43)                    ; 1-byte Folded Reload
	pop	ix
	ld	bc, (ix - 126)
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 31)                    ; 1-byte Folded Reload
	pop	ix
	call	__lcmps
	call	pe, __setflag
	jp	p, .LBB4_113
; %bb.112:
	ld	d, iyh
	.local	.LBB4_113
.LBB4_113:
	ld	a, iyl
	xor	a, d
	ld	l, a
	bit	0, l
	jp	nz, .LBB4_137
; %bb.114:
	ld	de, 2738
	ld	hl, (ix - 117)
	add	hl, de
	ld	de, (hl)
	ld	bc, -138
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	sbc.sis	hl, hl
	adc.sis	hl, de
	jp	z, .LBB4_137
; %bb.115:
	ld	bc, 0
	.local	.LBB4_116
.LBB4_116:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_118 Depth 2
	push	bc
	pop	hl
	add	hl, hl
	ld	de, -150
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ex	de, hl
	ld	hl, _sector_offsets
	add	hl, de
	ld	hl, (hl)
	ld	de, 0
	ld	e, l
	ld	d, h
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 1)
	pop	ix
	add	iy, de
	ld	de, -162
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	ld	e, (iy + 8)
	inc	d
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 10
	ld	hl, (iy + 0)
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, de
	jp	nz, .LBB4_136
; %bb.117:                              ;   in Loop: Header=BB4_116 Depth=1
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), bc
	ld	bc, -150
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	ld	hl, _sector_floor
	add	hl, de
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 49
	ld	(iy + 0), de
	ld	c, e
	ld	b, d
	or	a, a
	sbc	hl, hl
	ex	de, hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 43
	ld	(iy + 0), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 31
	ld	(iy + 0), bc
	.local	.LBB4_118
.LBB4_118:                              ;   Parent Loop BB4_116 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	iy, (ix - 117)
	ld	(ix - 126), de
	add	iy, de
	ld	de, (iy + 12)
	ld	l, e
	ld	h, d
	ld.sis	bc, -1
	or	a, a
	sbc.sis	hl, bc
	jr	nz, .LBB4_120
	.local	.LBB4_119
.LBB4_119:                              ;   in Loop: Header=BB4_118 Depth=2
	ld	iy, (ix - 126)
	jp	.LBB4_128
	.local	.LBB4_120
.LBB4_120:                              ;   in Loop: Header=BB4_118 Depth=2
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	ld	de, (iy + 10)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 37)
	pop	ix
	add	iy, de
	ld	a, (iy + 7)
	ld	de, 0
	ld	e, a
	push	bc
	pop	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 37)
	pop	ix
	add	iy, bc
	ld	a, (iy + 7)
	ld	bc, 0
	ld	c, a
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 19
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 46
	ld	(iy + 0), de
	or	a, a
	sbc	hl, de
	ld	de, -168
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	(iy + 0), bc
	jr	nz, .LBB4_124
; %bb.121:                              ;   in Loop: Header=BB4_118 Depth=2
	push	bc
	pop	hl
	add	hl, hl
	ex	de, hl
	ld	hl, _sector_floor
	add	hl, de
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	push	bc
	pop	iy
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 31)
	pop	ix
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jr	c, .LBB4_123
; %bb.122:                              ;   in Loop: Header=BB4_118 Depth=2
	ld	de, -159
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), bc
	.local	.LBB4_123
.LBB4_123:                              ;   in Loop: Header=BB4_118 Depth=2
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	iy, (ix - 126)
	jr	.LBB4_125
	.local	.LBB4_124
.LBB4_124:                              ;   in Loop: Header=BB4_118 Depth=2
	ld	iy, (ix - 126)
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 19)
	pop	ix
	.local	.LBB4_125
.LBB4_125:                              ;   in Loop: Header=BB4_118 Depth=2
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 40)
	pop	ix
	or	a, a
	sbc	hl, de
	jr	nz, .LBB4_128
; %bb.126:                              ;   in Loop: Header=BB4_118 Depth=2
	ld	de, -174
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	add	hl, hl
	ex	de, hl
	ld	hl, _sector_floor
	add	hl, de
	ld	bc, (hl)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	push	de
	pop	iy
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 31)
	pop	ix
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	c, .LBB4_119
; %bb.127:                              ;   in Loop: Header=BB4_118 Depth=2
	ld	bc, -159
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	jp	.LBB4_119
	.local	.LBB4_128
.LBB4_128:                              ;   in Loop: Header=BB4_118 Depth=2
	ld	de, 14
	add	iy, de
	lea	hl, iy + 0
	ld	de, 6650
	or	a, a
	sbc	hl, de
	lea	de, iy + 0
	jp	nz, .LBB4_118
; %bb.129:                              ;   in Loop: Header=BB4_116 Depth=1
	ld	hl, (ix - 117)
	ld	de, 2736
	add	hl, de
	ld	hl, (hl)
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	de, 36
	or	a, a
	sbc.sis	hl, de
	jr	nz, .LBB4_133
; %bb.130:                              ;   in Loop: Header=BB4_116 Depth=1
	ld	de, 8
	ld	bc, -159
	lea	hl, ix + 0
	add	hl, bc
	ld	iy, (hl)
	add	iy, de
	ld	de, -171
	lea	hl, ix + 0
	add	hl, de
	ld	bc, (hl)
	ld	hl, -8388608
	ex	de, hl
	push	bc
	pop	hl
	add	hl, de
	push	hl
	pop	bc
	lea	hl, iy + 0
	add	hl, de
	or	a, a
	sbc	hl, bc
	jr	c, .LBB4_132
; %bb.131:                              ;   in Loop: Header=BB4_116 Depth=1
	ld	de, -171
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	.local	.LBB4_132
.LBB4_132:                              ;   in Loop: Header=BB4_116 Depth=1
	ld	bc, -150
	lea	hl, ix + 0
	add	hl, bc
	ld	de, (hl)
	ld	hl, _floor_target
	add	hl, de
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	jp	.LBB4_136
	.local	.LBB4_133
.LBB4_133:                              ;   in Loop: Header=BB4_116 Depth=1
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	push	bc
	pop	de
	ld	hl, _floor_wait
	add	hl, de
	ld	a, (hl)
	or	a, a
	ld	de, -150
	lea	hl, ix + 0
	push	af
	add	hl, de
	pop	af
	ld	iy, (hl)
	jp	nz, .LBB4_136
; %bb.134:                              ;   in Loop: Header=BB4_116 Depth=1
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 34)
	pop	ix
	ld	de, (hl)
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 49)
	pop	ix
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, de
	jr	nz, .LBB4_136
; %bb.135:                              ;   in Loop: Header=BB4_116 Depth=1
	lea	de, iy + 0
	ld	hl, _floor_target
	add	hl, de
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 31
	ld	de, (iy + 0)
	ld	(hl), e
	inc	hl
	ld	(hl), d
	push	bc
	pop	de
	ld	hl, _floor_wait
	add	hl, de
	ld	(hl), -1
	.local	.LBB4_136
.LBB4_136:                              ;   in Loop: Header=BB4_116 Depth=1
	inc	bc
	push	bc
	pop	hl
	ld	de, 85
	or	a, a
	sbc	hl, de
	jp	nz, .LBB4_116
	.local	.LBB4_137
.LBB4_137:
	ld	bc, 4312
	ld	de, (ix - 117)
	push	de
	pop	hl
	add	hl, bc
	ld	iy, (hl)
	ld	bc, 0
	push	bc
	pop	hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	ld	iy, (ix - 105)
	lea	hl, iy + 0
	add	hl, bc
	push	hl
	pop	bc
	ex	de, hl
	ld	de, 4314
	add	hl, de
	ld	de, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ex	de, hl
	add	iy, de
	push	bc
	pop	hl
	push	ix
	lea	ix, ix - 128
	ld	(ix - 31), hl
	pop	ix
	ld	bc, (hl)
	ld	(ix - 105), iy
	ld	hl, (iy)
	ld	(ix - 126), hl
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld.sis	hl, -32768
	ex.sis	de, hl
	add.sis	iy, de
	ld	l, c
	ld	h, b
	add.sis	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 22), l
	ld	(ix - 21), h
	pop	ix
	push	ix
	lea	ix, ix - 128
	push	hl
	lea	hl, iy + 0
	ld	(ix - 19), l
	ld	(ix - 18), h
	pop	hl
	pop	ix
	ld	e, iyl
	ld	d, iyh
	or	a, a
	sbc.sis	hl, de
	ld	hl, (ix - 126)
	ld	de, -138
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	(iy + 0), bc
	ld	e, c
	ld	d, b
	jr	c, .LBB4_139
; %bb.138:
	ld	e, l
	ld	d, h
	.local	.LBB4_139
.LBB4_139:
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	de, -8388608
	add	iy, de
	ld	hl, (ix - 120)
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	c, .LBB4_177
; %bb.140:
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	l, (iy + 0)
	ld	h, (iy + 1)
	ld	bc, -150
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)
	ld	d, (iy + 1)
	or	a, a
	sbc.sis	hl, de
	ld	de, -138
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	bc, (iy + 0)
	ld	e, c
	ld	d, b
	jr	c, .LBB4_142
; %bb.141:
	ld	hl, (ix - 126)
	ld	e, l
	ld	d, h
	.local	.LBB4_142
.LBB4_142:
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, -8388608
	ld	iy, (ix - 123)
	add	iy, de
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	c, .LBB4_177
; %bb.143:
	ld	de, -159
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	bc, (iy + 2)
	ld	iy, (ix - 105)
	ld	hl, (iy + 2)
	ld	(ix - 105), hl
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld.sis	hl, -32768
	ex.sis	de, hl
	add.sis	iy, de
	ld	l, c
	ld	h, b
	add.sis	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 19), l
	ld	(ix - 18), h
	pop	ix
	push	hl
	lea	hl, iy + 0
	ld	(ix - 123), l
	ld	(ix - 122), h
	pop	hl
	ld	e, iyl
	ld	d, iyh
	or	a, a
	sbc.sis	hl, de
	ld	hl, (ix - 105)
	ld	(ix - 120), bc
	ld	e, c
	ld	d, b
	jr	c, .LBB4_145
; %bb.144:
	ld	e, l
	ld	d, h
	.local	.LBB4_145
.LBB4_145:
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 16)
	pop	ix
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	c, .LBB4_177
; %bb.146:
	ld	l, (ix - 123)
	ld	h, (ix - 122)
	ld	bc, -147
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)
	ld	d, (iy + 1)
	or	a, a
	sbc.sis	hl, de
	ld	hl, (ix - 120)
	ld	e, l
	ld	d, h
	jr	c, .LBB4_148
; %bb.147:
	ld	hl, (ix - 105)
	ld	e, l
	ld	d, h
	.local	.LBB4_148
.LBB4_148:
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, -8388608
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 28)
	pop	ix
	add	iy, de
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	ld	de, -138
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	bc, (iy + 0)
	jp	c, .LBB4_177
; %bb.149:
	ld	de, (ix - 126)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	(ix - 123), de
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	ld	(ix - 126), hl
	ld	bc, (ix - 105)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	iy, (ix - 120)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	ld	(ix - 105), bc
	ex	de, hl
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	ld	hl, (ix - 96)
	ld	de, (ix - 123)
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	(ix - 54), bc
	ld	a, (ix - 52)
	rlc	a
	sbc	a, a
	ld	d, a
	ld	(ix - 51), iy
	ld	a, (ix - 49)
	rlc	a
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 16), a
	pop	ix
	lea	hl, iy + 0
	ld	e, a
	ld	a, d
	call	__lmulu
	ld	(ix - 96), hl
	ld	(ix - 120), e                   ; 1-byte Folded Spill
	ld	hl, (ix - 99)
	ld	de, (ix - 105)
	or	a, a
	sbc	hl, de
	ld	(ix - 48), hl
	ld	a, (ix - 46)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	bc, (ix - 126)
	ld	(ix - 45), bc
	ld	a, (ix - 43)
	rlc	a
	sbc	a, a
	ld	d, a
	call	__lmulu
	ld	(ix - 99), hl
	ld	bc, -138
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), e                         ; 1-byte Folded Spill
	ld	hl, (ix - 102)
	ld	bc, (ix - 123)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	bc
	ld	(ix - 42), bc
	ld	a, (ix - 40)
	rlc	a
	sbc	a, a
	lea	hl, iy + 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 16
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 123), hl
	ld	bc, -144
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), e                     ; 1-byte Folded Spill
	ld	hl, (ix - 111)
	ld	bc, (ix - 105)
	or	a, a
	sbc	hl, bc
	ld	(ix - 39), hl
	ld	a, (ix - 37)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	bc, (ix - 126)
	ld	a, d
	call	__lmulu
	ld	(ix - 105), hl
	ld	(ix - 126), e                   ; 1-byte Folded Spill
	ld	hl, (ix - 96)
	ld	e, (ix - 120)                   ; 1-byte Folded Reload
	ld	bc, (ix - 99)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 10
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	d, 1
	ld	iyh, 0
	ld	iyl, d
	jp	m, .LBB4_151
; %bb.150:
	ld	iyl, iyh
	.local	.LBB4_151
.LBB4_151:
	ld	hl, (ix - 123)
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 16)                    ; 1-byte Folded Reload
	pop	ix
	ld	bc, (ix - 105)
	ld	a, (ix - 126)                   ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	jp	p, .LBB4_153
; %bb.152:
	ld	d, iyh
	.local	.LBB4_153
.LBB4_153:
	ld	a, iyl
	xor	a, d
	ld	l, a
	bit	0, l
	jp	nz, .LBB4_177
; %bb.154:
	ld	de, 4320
	ld	hl, (ix - 117)
	add	hl, de
	ld	de, (hl)
	ld	(ix - 99), de
	sbc.sis	hl, hl
	adc.sis	hl, de
	jp	z, .LBB4_177
; %bb.155:
	ld	iy, 0
	.local	.LBB4_156
.LBB4_156:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_158 Depth 2
	lea	hl, iy + 0
	add	hl, hl
	push	hl
	pop	bc
	ex	de, hl
	ld	hl, _sector_offsets
	add	hl, de
	ld	hl, (hl)
	ld	de, 0
	ld	e, l
	ld	d, h
	lea	hl, iy + 0
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 1)
	pop	ix
	add	iy, de
	ld	(ix - 123), iy
	ld	e, (iy + 8)
	push	hl
	pop	iy
	ld	d, 0
	ld	hl, (ix - 99)
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, de
	jp	nz, .LBB4_176
; %bb.157:                              ;   in Loop: Header=BB4_156 Depth=1
	ld	(ix - 105), iy
	ld	(ix - 126), bc
	ld	hl, _sector_floor
	add	hl, bc
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 22
	ld	(iy + 0), de
	ld	c, e
	ld	b, d
	or	a, a
	sbc	hl, hl
	ex	de, hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 10
	ld	(iy + 0), bc
	ld	(ix - 120), bc
	.local	.LBB4_158
.LBB4_158:                              ;   Parent Loop BB4_156 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	iy, (ix - 117)
	ld	(ix - 96), de
	add	iy, de
	ld	de, (iy + 12)
	ld	l, e
	ld	h, d
	ld.sis	bc, -1
	or	a, a
	sbc.sis	hl, bc
	jr	nz, .LBB4_160
	.local	.LBB4_159
.LBB4_159:                              ;   in Loop: Header=BB4_158 Depth=2
	ld	iy, (ix - 96)
	jp	.LBB4_168
	.local	.LBB4_160
.LBB4_160:                              ;   in Loop: Header=BB4_158 Depth=2
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	ld	de, (iy + 10)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 37)
	pop	ix
	add	iy, de
	ld	a, (iy + 7)
	ld	de, 0
	ld	e, a
	push	bc
	pop	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 37)
	pop	ix
	add	iy, bc
	ld	a, (iy + 7)
	ld	bc, 0
	ld	c, a
	ld	hl, (ix - 105)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 19
	ld	(iy + 0), de
	or	a, a
	sbc	hl, de
	ld	de, -144
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	(iy + 0), bc
	jr	nz, .LBB4_164
; %bb.161:                              ;   in Loop: Header=BB4_158 Depth=2
	push	bc
	pop	hl
	add	hl, hl
	ex	de, hl
	ld	hl, _sector_floor
	add	hl, de
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	push	bc
	pop	iy
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	ld	hl, (ix - 120)
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jr	c, .LBB4_163
; %bb.162:                              ;   in Loop: Header=BB4_158 Depth=2
	ld	(ix - 120), bc
	.local	.LBB4_163
.LBB4_163:                              ;   in Loop: Header=BB4_158 Depth=2
	ld	hl, (ix - 105)
	ld	iy, (ix - 96)
	jr	.LBB4_165
	.local	.LBB4_164
.LBB4_164:                              ;   in Loop: Header=BB4_158 Depth=2
	ld	iy, (ix - 96)
	ld	hl, (ix - 105)
	.local	.LBB4_165
.LBB4_165:                              ;   in Loop: Header=BB4_158 Depth=2
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 16)
	pop	ix
	or	a, a
	sbc	hl, de
	jr	nz, .LBB4_168
; %bb.166:                              ;   in Loop: Header=BB4_158 Depth=2
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	add	hl, hl
	ex	de, hl
	ld	hl, _sector_floor
	add	hl, de
	ld	bc, (hl)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	push	de
	pop	iy
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	ld	hl, (ix - 120)
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	c, .LBB4_159
; %bb.167:                              ;   in Loop: Header=BB4_158 Depth=2
	ld	(ix - 120), de
	jp	.LBB4_159
	.local	.LBB4_168
.LBB4_168:                              ;   in Loop: Header=BB4_158 Depth=2
	ld	de, 14
	add	iy, de
	lea	hl, iy + 0
	ld	de, 6650
	or	a, a
	sbc	hl, de
	lea	de, iy + 0
	jp	nz, .LBB4_158
; %bb.169:                              ;   in Loop: Header=BB4_156 Depth=1
	ld	hl, (ix - 117)
	ld	de, 4318
	add	hl, de
	ld	hl, (hl)
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	de, 36
	or	a, a
	sbc.sis	hl, de
	ld	de, -138
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	bc, (iy + 0)
	jr	nz, .LBB4_173
; %bb.170:                              ;   in Loop: Header=BB4_156 Depth=1
	ld	de, 8
	ld	iy, (ix - 120)
	add	iy, de
	ld	(ix - 96), bc
	ld	hl, -8388608
	ex	de, hl
	ld	hl, (ix - 96)
	add	hl, de
	ld	(ix - 96), hl
	lea	hl, iy + 0
	add	hl, de
	ld	de, (ix - 96)
	or	a, a
	sbc	hl, de
	jr	c, .LBB4_172
; %bb.171:                              ;   in Loop: Header=BB4_156 Depth=1
	push	bc
	pop	iy
	.local	.LBB4_172
.LBB4_172:                              ;   in Loop: Header=BB4_156 Depth=1
	ld	de, (ix - 126)
	ld	hl, _floor_target
	add	hl, de
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld	iy, (ix - 105)
	jp	.LBB4_176
	.local	.LBB4_173
.LBB4_173:                              ;   in Loop: Header=BB4_156 Depth=1
	ld	iy, (ix - 105)
	lea	de, iy + 0
	ld	hl, _floor_wait
	add	hl, de
	ld	a, (hl)
	or	a, a
	ld	bc, (ix - 126)
	jp	nz, .LBB4_176
; %bb.174:                              ;   in Loop: Header=BB4_156 Depth=1
	ld	hl, (ix - 123)
	ld	de, (hl)
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 22)
	pop	ix
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, de
	jr	nz, .LBB4_176
; %bb.175:                              ;   in Loop: Header=BB4_156 Depth=1
	push	bc
	pop	de
	ld	hl, _floor_target
	add	hl, de
	ld	de, (ix - 120)
	ld	(hl), e
	inc	hl
	ld	(hl), d
	lea	de, iy + 0
	ld	hl, _floor_wait
	add	hl, de
	ld	(hl), -1
	.local	.LBB4_176
.LBB4_176:                              ;   in Loop: Header=BB4_156 Depth=1
	inc	iy
	lea	hl, iy + 0
	ld	de, 85
	or	a, a
	sbc	hl, de
	jp	nz, .LBB4_156
	.local	.LBB4_177
.LBB4_177:
	or	a, a
	sbc	hl, hl
	ex	de, hl
	.local	.LBB4_178
.LBB4_178:                              ; =>This Inner Loop Header: Depth=1
	ld	hl, _sector_ceiling
	add	hl, de
	ld	(ix - 117), hl
	ld	iy, (hl)
	ld	hl, _sector_target
	add	hl, de
	ld	bc, (hl)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	or	a, a
	sbc.sis	hl, bc
	ld	(ix - 99), de
	jp	nz, .LBB4_181
; %bb.179:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	(ix - 120), bc
	ld	hl, _sector_floor
	add	hl, de
	ld	bc, (hl)
	ld	hl, _floor_target
	add	hl, de
	ld	de, (hl)
	ld	(ix - 96), bc
	ld	l, c
	ld	h, b
	ld	(ix - 105), de
	or	a, a
	sbc.sis	hl, de
	jp	nz, .LBB4_182
; %bb.180:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	hl, (ix - 93)
	ld	a, (hl)
	or	a, a
	ld	hl, (ix - 96)
                                        ; kill: def $hl killed $hl killed $uhl def $uhl
	ld	(ix - 105), hl
	ld	bc, (ix - 120)
	jr	nz, .LBB4_183
	jp	.LBB4_197
	.local	.LBB4_181
.LBB4_181:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	hl, _floor_target
	add	hl, de
	ld	hl, (hl)
	ld	(ix - 105), hl
	ld	hl, _sector_floor
	add	hl, de
	ld	hl, (hl)
	ld	(ix - 96), hl
	jr	.LBB4_183
	.local	.LBB4_182
.LBB4_182:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	bc, (ix - 120)
	.local	.LBB4_183
.LBB4_183:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	ex	de, hl
	or	a, a
	sbc	hl, bc
	push	hl
	pop	de
	ld	bc, -8388608
	add	hl, bc
	inc	bc
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB4_185
; %bb.184:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	de, 0
	.local	.LBB4_185
.LBB4_185:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	bc, 2
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jr	c, .LBB4_187
; %bb.186:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	de, 2
	.local	.LBB4_187
.LBB4_187:                              ;   in Loop: Header=BB4_178 Depth=1
                                        ; kill: def $de killed $de killed $ude
	add.sis	iy, de
	ld	hl, (ix - 117)
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld	bc, (ix - 105)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	iy, _sector_floor
	ld	bc, (ix - 99)
	add	iy, bc
	ld	(ix - 117), iy
	ld	iy, (ix - 96)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	ex	de, hl
	or	a, a
	sbc	hl, bc
	push	hl
	pop	de
	ld	bc, -8388608
	add	hl, bc
	ld	bc, 8388605
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB4_189
; %bb.188:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	de, -4
	.local	.LBB4_189
.LBB4_189:                              ;   in Loop: Header=BB4_178 Depth=1
	push	de
	pop	hl
	ld	bc, -8388608
	add	hl, bc
	ld	bc, -8388604
	or	a, a
	sbc	hl, bc
	jr	c, .LBB4_191
; %bb.190:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	de, 4
	.local	.LBB4_191
.LBB4_191:                              ;   in Loop: Header=BB4_178 Depth=1
                                        ; kill: def $de killed $de killed $ude
	ld	iy, (ix - 96)
	add.sis	iy, de
	ld	hl, (ix - 117)
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	lea	bc, iy + 0
	ld	hl, (ix - 93)
	ld	e, (hl)
	ld	a, e
	cp	a, -1
	jr	nz, .LBB4_194
; %bb.192:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	l, c
	ld	h, b
	ld	de, (ix - 105)
	or	a, a
	sbc.sis	hl, de
	jr	nz, .LBB4_197
; %bb.193:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	hl, (ix - 93)
	ld	(hl), 105
	jr	.LBB4_197
	.local	.LBB4_194
.LBB4_194:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	a, e
	or	a, a
	jr	z, .LBB4_197
; %bb.195:                              ;   in Loop: Header=BB4_178 Depth=1
	dec	e
	ld	hl, (ix - 93)
	ld	(hl), e
	ld	a, e
	or	a, a
	jr	nz, .LBB4_197
; %bb.196:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	hl, _sector_offsets
	ld	bc, (ix - 99)
	add	hl, bc
	ld	hl, (hl)
	ld	de, 0
	ld	e, l
	ld	d, h
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 1
	ld	hl, (iy + 0)
	add	hl, de
	ld	de, (hl)
	ld	hl, _floor_target
	add	hl, bc
	ld	(hl), e
	inc	hl
	ld	(hl), d
	.local	.LBB4_197
.LBB4_197:                              ;   in Loop: Header=BB4_178 Depth=1
	ld	iy, (ix - 99)
	ld	de, 2
	add	iy, de
	ld	hl, (ix - 93)
	inc	hl
	ld	(ix - 93), hl
	ld	de, 170
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	lea	de, iy + 0
	jp	nz, .LBB4_178
; %bb.198:
	ld	l, 64
	ld	a, (ix + 6)
	and	a, l
	ld	e, a
	ld	iy, 0
	lea	hl, iy + 0
	ld	l, e
	ld	(ix - 93), hl
	ld	a, (_use_held)
	ld	l, a
	ld	a, e
	or	a, a
	jp	z, .LBB4_237
; %bb.199:
	ld	a, l
	or	a, a
	jp	nz, .LBB4_237
; %bb.200:
	ld	hl, _player+18
	ld	iy, (hl)
	or	a, a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	de, 256
	add	hl, de
	ld	bc, 1023
	call	__iand
	add	hl, hl
	ex	de, hl
	ld	hl, _sine_table
	push	hl
	pop	bc
	add	hl, de
	ld	hl, (hl)
	ld	(ix - 105), hl
	ld	l, 3
	ld	a, iyh
	and	a, l
	ld	iyh, a
	add.sis	iy, iy
	ld	de, 0
	ld	e, iyl
	ld	d, iyh
	push	bc
	pop	hl
	add	hl, de
	ld	hl, (hl)
	ld	(ix - 117), hl
	ld	hl, (_map_lines)
	ld	(ix - 99), hl
	ld	hl, (_map_vertices)
	ld	(ix - 120), hl
	ld	bc, 6650
	or	a, a
	sbc	hl, hl
	ex	de, hl
	.local	.LBB4_201
.LBB4_201:                              ; =>This Inner Loop Header: Depth=1
	ld	iy, (ix - 99)
	ld	(ix - 96), de
	add	iy, de
	ld	de, (iy + 6)
	sbc.sis	hl, hl
	adc.sis	hl, de
	jr	z, .LBB4_203
; %bb.202:                              ;   in Loop: Header=BB4_201 Depth=1
	ld	l, e
	ld	h, d
	ld.sis	de, 48
	or	a, a
	sbc.sis	hl, de
	jr	nz, .LBB4_205
	.local	.LBB4_203
.LBB4_203:                              ;   in Loop: Header=BB4_201 Depth=1
	ld	iy, (ix - 96)
	.local	.LBB4_204
.LBB4_204:                              ;   in Loop: Header=BB4_201 Depth=1
	ld	de, 14
	add	iy, de
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	lea	de, iy + 0
	jr	nz, .LBB4_201
	jp	.LBB4_213
	.local	.LBB4_205
.LBB4_205:                              ;   in Loop: Header=BB4_201 Depth=1
	ld	de, -168
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	ld	de, (ix - 105)
	ld	a, d
	ld	l, a
	rlc	l
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 123), hl
	rlc	a
	sbc	a, a
	ld	(ix - 126), a                   ; 1-byte Folded Spill
	ld	de, (ix - 117)
	ld	a, d
	ld	l, a
	rlc	l
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, -138
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	rlc	a
	sbc	a, a
	ld	de, -144
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	ld	iy, (ix - 99)
	ld	de, (ix - 96)
	add	iy, de
	ld	de, (iy)
	ld	bc, 0
	push	bc
	pop	hl
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	ld	de, (ix - 120)
	push	de
	pop	hl
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 19), hl
	pop	ix
	ld	iy, (iy + 2)
	or	a, a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	ex	de, hl
	add	hl, bc
	ld	de, -150
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -147
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	de, (iy)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	bc, (ix - 102)
	or	a, a
	sbc	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 28), hl
	pop	ix
	ld	de, (iy + 2)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, (ix - 111)
	or	a, a
	sbc	hl, de
	ld	de, -159
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -150
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	de, (iy)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	or	a, a
	sbc	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 19), hl
	pop	ix
	ld	de, (iy + 2)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, (ix - 111)
	or	a, a
	sbc	hl, de
	ld	de, -150
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -156
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	(ix - 36), hl
	ld	a, (ix - 34)
	rlc	a
	sbc	a, a
	ld	e, a
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 10
	ld	bc, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 16
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	call	__lmulu
	push	hl
	pop	iy
	ld	d, e
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 31)
	pop	ix
	ld	(ix - 33), hl
	ld	a, (ix - 31)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	bc, (ix - 123)
	ld	a, (ix - 126)                   ; 1-byte Folded Reload
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	lea	hl, iy + 0
	ld	e, d
	call	__lsub
	push	hl
	pop	iy
	lea	bc, iy + 0
	ld	a, e
	ld	l, 31
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	ld	de, -162
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), bc
	ld	de, -165
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	(ix - 30), hl
	ld	a, (ix - 28)
	rlc	a
	sbc	a, a
	ld	e, a
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 10
	ld	bc, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 16
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	call	__lmulu
	push	hl
	pop	iy
	ld	d, e
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 22)
	pop	ix
	ld	(ix - 27), hl
	ld	a, (ix - 25)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	bc, (ix - 123)
	ld	a, (ix - 126)                   ; 1-byte Folded Reload
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	lea	hl, iy + 0
	ld	e, d
	call	__lsub
	push	hl
	pop	iy
	lea	bc, iy + 0
	ld	a, e
	ld	l, 31
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	push	bc
	pop	iy
	lea	hl, iy + 0
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 34)
	pop	ix
	call	__ixor
	ld	(ix - 123), hl
	push	bc
	pop	hl
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 37)                    ; 1-byte Folded Reload
	pop	ix
	ld	(ix - 126), iy
	lea	bc, iy + 0
	call	__lcmpu
	jr	z, .LBB4_207
; %bb.206:                              ;   in Loop: Header=BB4_201 Depth=1
	ld	hl, -8388608
	ex	de, hl
	ld	hl, (ix - 123)
	add	hl, de
	or	a, a
	sbc	hl, de
	jr	c, .LBB4_208
	.local	.LBB4_207
.LBB4_207:                              ;   in Loop: Header=BB4_201 Depth=1
	ld	bc, 6650
	ld	iy, (ix - 96)
	jp	.LBB4_204
	.local	.LBB4_208
.LBB4_208:                              ;   in Loop: Header=BB4_201 Depth=1
	ld	de, -150
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	(ix - 24), hl
	ld	a, (ix - 22)
	rlc	a
	sbc	a, a
	ld	de, -171
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	(ix - 21), hl
	ld	a, (ix - 19)
	rlc	a
	sbc	a, a
	ld	de, -174
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	ld	de, -159
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	(ix - 18), hl
	ld	a, (ix - 16)
	rlc	a
	sbc	a, a
	ld	iyh, a
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 28)
	pop	ix
	ld	(ix - 15), hl
	ld	a, (ix - 13)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	bc, (ix - 105)
	ld	a, b
	ld	l, a
	rlc	l
	sbc	hl, hl
	ld	l, c
	ld	h, b
	push	ix
	lea	ix, ix - 128
	ld	(ix - 10), hl
	pop	ix
	rlc	a
	sbc	a, a
	ld	iyl, a
	ld	bc, -177
	lea	hl, ix + 0
	add	hl, bc
	push	af
	ld	a, iyl
	ld	(hl), a
	pop	af
	ld	bc, (ix - 117)
	ld	a, b
	ld	l, a
	rlc	l
	sbc	hl, hl
	ld	l, c
	ld	h, b
	push	ix
	lea	ix, ix - 128
	ld	(ix - 16), hl
	pop	ix
	rlc	a
	sbc	a, a
	ld	d, a
	ld	bc, -178
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), d
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 28)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 10)
	pop	ix
	ld	a, iyl
	call	__lmulu
	ld	(ix - 123), hl
	ld	iyl, e
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 31)
	pop	ix
	ld	e, iyh
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 16)
	pop	ix
	ld	a, d
	call	__lmulu
	ld	bc, (ix - 123)
	ld	a, iyl
	call	__ladd
	push	hl
	pop	iy
	lea	bc, iy + 0
	ld	a, e
	ld	l, 31
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	ld	(ix - 123), bc
	ld	de, -147
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	bc, -174
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 10
	ld	bc, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 49
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	call	__lmulu
	push	hl
	pop	iy
	ld	d, e
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 22)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 43)                    ; 1-byte Folded Reload
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 16)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 50)                    ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	lea	bc, iy + 0
	ld	a, d
	call	__ladd
	push	hl
	pop	iy
	lea	bc, iy + 0
	ld	a, e
	ld	l, 31
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	push	bc
	pop	hl
	ld	de, (ix - 123)
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	(ix - 12), bc
	ld	a, (ix - 10)
	rlc	a
	sbc	a, a
	ld	de, -162
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	lea	hl, iy + 0
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 37)                    ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	(ix - 10), hl
	pop	ix
	lea	hl, iy + 0
	ld	bc, (ix - 126)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	bc
	ld	(ix - 9), bc
	ld	a, (ix - 7)
	rlc	a
	sbc	a, a
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 10
	ld	hl, (iy + 0)
	call	__ldivs
	ld	de, -8388608
	ld	bc, (ix - 123)
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 25)
	pop	ix
	add	iy, de
	lea	bc, iy + 0
	ld	(ix - 123), hl
	push	hl
	pop	iy
	add	iy, de
	lea	hl, iy + 0
	push	bc
	pop	de
	or	a, a
	sbc	hl, de
                                        ; kill: def $a killed $a
	sbc	a, a
	ld	e, a
	lea	hl, iy + 0
	ld	bc, -8388607
	or	a, a
	sbc	hl, bc
	ccf
                                        ; kill: def $a killed $a
	sbc	a, a
	and	a, e
	ld	l, a
	bit	0, l
	jr	nz, .LBB4_210
; %bb.209:                              ;   in Loop: Header=BB4_201 Depth=1
	ld	bc, -141
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	ld	bc, -168
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	.local	.LBB4_210
.LBB4_210:                              ;   in Loop: Header=BB4_201 Depth=1
	bit	0, l
	ld	bc, 6650
	ld	iy, (ix - 96)
	jr	nz, .LBB4_212
; %bb.211:                              ;   in Loop: Header=BB4_201 Depth=1
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 25)
	pop	ix
	ld	(ix - 123), hl
	.local	.LBB4_212
.LBB4_212:                              ;   in Loop: Header=BB4_201 Depth=1
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 40)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 13), hl
	pop	ix
	ld	hl, (ix - 123)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 25), hl
	pop	ix
	jp	.LBB4_204
	.local	.LBB4_213
.LBB4_213:
	ld	de, -141
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	z, .LBB4_237
; %bb.214:
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	lea	bc, iy + 0
	ld	hl, (iy + 6)
	ld.sis	de, 11
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, de
	jr	nz, .LBB4_216
; %bb.215:
	ld	a, 1
	ld	(_player+29), a
	jp	.LBB4_237
	.local	.LBB4_216
.LBB4_216:
	push	bc
	pop	iy
	ld	de, (iy + 12)
	ld.sis	bc, -1
	ld	l, e
	ld	h, d
	or	a, a
	sbc.sis	hl, bc
	jp	z, .LBB4_237
; %bb.217:
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	iy, (_sides)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	(ix - 120), iy
	add	iy, de
	ld	a, (iy + 7)
	ld	(ix - 123), a
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	de, 32767
	ld	(ix - 117), de
	.local	.LBB4_218
.LBB4_218:                              ; =>This Inner Loop Header: Depth=1
	ld	(ix - 96), de
	ld	iy, (ix - 99)
	ld	(ix - 105), bc
	add	iy, bc
	ld	bc, (iy + 12)
	ld	l, c
	ld	h, b
	ld.sis	de, -1
	or	a, a
	sbc.sis	hl, de
	jr	nz, .LBB4_220
; %bb.219:                              ;   in Loop: Header=BB4_218 Depth=1
	ld	iy, (ix - 105)
	ld	de, (ix - 96)
	jp	.LBB4_229
	.local	.LBB4_220
.LBB4_220:                              ;   in Loop: Header=BB4_218 Depth=1
	or	a, a
	sbc	hl, hl
	push	hl
	pop	de
	ld	e, c
	ld	d, b
	ld	bc, (iy + 10)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	ld	iy, (ix - 120)
	add	iy, bc
	ld	c, (iy + 7)
	ex	de, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	iy, (ix - 120)
	add	iy, de
	ld	e, (iy + 7)
	ld	a, c
	ld	l, (ix - 123)                   ; 1-byte Folded Reload
	cp	a, l
	jr	z, .LBB4_222
; %bb.221:                              ;   in Loop: Header=BB4_218 Depth=1
	ld	a, e
	cp	a, l
	jr	nz, .LBB4_228
	.local	.LBB4_222
.LBB4_222:                              ;   in Loop: Header=BB4_218 Depth=1
	ld	a, c
	cp	a, l
	jr	z, .LBB4_224
; %bb.223:                              ;   in Loop: Header=BB4_218 Depth=1
	ld	e, c
	.local	.LBB4_224
.LBB4_224:                              ;   in Loop: Header=BB4_218 Depth=1
	or	a, a
	sbc	hl, hl
	ld	l, e
	add	hl, hl
	ex	de, hl
	ld	hl, _sector_ceiling
	ld	(ix - 126), de
	add	hl, de
	ld	bc, (hl)
	ld	a, b
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, c
	ld	iyh, b
	ld	bc, -4
	add	iy, bc
	lea	bc, iy + 0
	ld	de, -8388608
	push	bc
	pop	hl
	add	hl, de
	push	hl
	pop	bc
	ld	hl, (ix - 96)
	add	hl, de
	or	a, a
	sbc	hl, bc
	jr	c, .LBB4_226
; %bb.225:                              ;   in Loop: Header=BB4_218 Depth=1
	ld	(ix - 96), iy
	.local	.LBB4_226
.LBB4_226:                              ;   in Loop: Header=BB4_218 Depth=1
	ld	hl, _sector_floor
	ld	de, (ix - 126)
	add	hl, de
	ld	bc, (hl)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	push	de
	pop	iy
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	ld	hl, (ix - 117)
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jr	c, .LBB4_228
; %bb.227:                              ;   in Loop: Header=BB4_218 Depth=1
	ld	(ix - 117), de
	.local	.LBB4_228
.LBB4_228:                              ;   in Loop: Header=BB4_218 Depth=1
	ld	de, (ix - 96)
	ld	iy, (ix - 105)
	.local	.LBB4_229
.LBB4_229:                              ;   in Loop: Header=BB4_218 Depth=1
	ld	bc, 14
	add	iy, bc
	lea	hl, iy + 0
	ld	bc, 6650
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jp	nz, .LBB4_218
; %bb.230:
	ld	iy, 0
	lea	hl, iy + 0
	ld	l, (ix - 123)                   ; 1-byte Folded Reload
	ld	(ix - 99), hl
	ld	bc, 32767
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jp	z, .LBB4_234
; %bb.231:
	ld	hl, (ix - 99)
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _sector_ceiling
	ld	(ix - 105), bc
	add	hl, bc
	ld	(ix - 96), de
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	ld	hl, (ix - 96)
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	c, .LBB4_233
; %bb.232:
	ld	de, (ix - 96)
                                        ; kill: def $de killed $de killed $ude def $ude
	.local	.LBB4_233
.LBB4_233:
	ld	hl, _sector_target
	ld	bc, (ix - 105)
	add	hl, bc
	ld	(hl), e
	inc	hl
	ld	(hl), d
	.local	.LBB4_234
.LBB4_234:
	ld	bc, (ix - 117)
	push	bc
	pop	hl
	ld	de, 32767
	or	a, a
	sbc	hl, de
	jr	z, .LBB4_237
; %bb.235:
	ld	hl, (ix - 99)
	add	hl, hl
	ld	(ix - 99), hl
	ex	de, hl
	ld	hl, _sector_floor
	add	hl, de
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	push	bc
	pop	hl
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jr	nc, .LBB4_237
; %bb.236:
	ld	de, (ix - 99)
	ld	hl, _floor_target
	add	hl, de
	ld	(hl), c
	inc	hl
	ld	(hl), b
	.local	.LBB4_237
.LBB4_237:
	ld	c, 6
	ld	hl, (ix - 93)
	call	__ishru
	ld	a, l
	ld	(_use_held), a
	bit	5, (ix + 6)
	jr	z, .LBB4_244
; %bb.238:
	ld	de, -135
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	bit	0, (iy + 0)                     ; 1-byte Folded Reload
	jr	z, .LBB4_244
; %bb.239:
	ld	hl, _player+16
	ld	hl, (hl)
	add.sis	hl, bc
	or	a, a
	sbc.sis	hl, bc
	jr	nz, .LBB4_241
; %bb.240:
	ld	a, 0
	jr	.LBB4_242
	.local	.LBB4_241
.LBB4_241:
	ld	a, -1
	.local	.LBB4_242
.LBB4_242:
	bit	0, a
	jr	z, .LBB4_244
; %bb.243:
	ld	a, 19
	ld	(_player+27), a
	.local	.LBB4_244
.LBB4_244:
	ld	hl, _player+24
	ld	bc, (hl)
	ld	l, 31
	ld	a, c
	and	a, l
	ld	l, a
	or	a, a
	jp	nz, .LBB4_251
; %bb.245:
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 4
	ld	de, (iy + 0)
	ld	hl, _sector_offsets
	add	hl, de
	ld	hl, (hl)
	ld	de, 0
	ld	e, l
	ld	d, h
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 1)
	pop	ix
	add	iy, de
	ld	a, (iy + 7)
	cp	a, 17
	jp	nc, .LBB4_251
; %bb.246:
	ld	hl, 1
	ld	(ix - 123), bc
	ld	c, a
	call	__ishl
	ld	bc, 65696
	call	__iand
	ld	bc, (ix - 123)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jr	z, .LBB4_251
; %bb.247:
	ld	hl, _player+14
	ld	de, (hl)
	ld	l, e
	ld	h, d
	ld.sis	bc, -32768
	add.sis	hl, bc
	inc.sis	bc
	or	a, a
	sbc.sis	hl, bc
	ld	c, e
	ld	b, d
	jr	c, .LBB4_249
; %bb.248:
	ld.sis	bc, 1
	.local	.LBB4_249
.LBB4_249:
	ld	l, e
	ld	h, d
	or	a, a
	sbc.sis	hl, bc
	ld	iy, _player+14
	ld	(iy), l
	ld	(iy + 1), h
	ld	iy, _player+12
	ld	de, (iy)
	ld	l, c
	ld	h, b
	add.sis	hl, de
	ld.sis	de, -5
	add.sis	hl, de
	ld	(iy), l
	ld	(iy + 1), h
	ld	a, 5
	ld	(_player+28), a
	ld.sis	de, -32768
	add.sis	hl, de
	inc.sis	de
	or	a, a
	sbc.sis	hl, de
	ld	bc, (ix - 123)
	jr	nc, .LBB4_251
; %bb.250:
	ld.sis	hl, 0
	ld	(iy), l
	ld	(iy + 1), h
	ld	a, 1
	ld	(_player+30), a
	.local	.LBB4_251
.LBB4_251:
	ld	iy, (_map_actors)
	ld	hl, _random_state
	ld	hl, (hl)
	ld	(ix - 117), hl
	ld	hl, _player+14
	ld	hl, (hl)
	ld	(ix - 105), hl
	ld	hl, _player+12
	ld	hl, (hl)
	ld	(ix - 99), hl
	ld	hl, _player+16
	ld	hl, (hl)
	ld	(ix - 96), hl
	ld	de, (ix - 114)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 114), hl
	lea	hl, iy + 12
	ld	(ix - 93), hl
	ld	h, 0
	ld	(ix - 120), l
	ld	(ix - 119), h
	ld	iy, _actors+5
	.local	.LBB4_252
.LBB4_252:                              ; =>This Inner Loop Header: Depth=1
	ld	a, (iy + 1)
	or	a, a
	jp	nz, .LBB4_271
; %bb.253:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	l, (iy + 4)
	ld	a, l
	or	a, a
	jr	z, .LBB4_255
; %bb.254:                              ;   in Loop: Header=BB4_252 Depth=1
	dec	l
	ld	(iy + 4), l
	.local	.LBB4_255
.LBB4_255:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	e, (iy + 5)
	ld	l, e
	inc	l
	ld	a, l
	cp	a, 2
	jp	nc, .LBB4_268
; %bb.256:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	l, (iy + 3)
	ld	a, l
	or	a, a
	jp	nz, .LBB4_272
; %bb.257:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, (ix - 93)
	ld	l, (hl)
	ld	a, l
	dec	a
	cp	a, 2
	jp	nc, .LBB4_271
; %bb.258:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	a, l
	cp	a, 1
	jr	nz, .LBB4_260
; %bb.259:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	a, (iy)
	or	a, a
	jp	z, .LBB4_271
	.local	.LBB4_260
.LBB4_260:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	(ix - 126), l                   ; 1-byte Folded Spill
	ld	(ix - 123), bc
	ld	de, (iy - 5)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	ld	hl, (ix - 102)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 10), bc
	pop	ix
	or	a, a
	sbc	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 7), hl
	pop	ix
	ld	bc, (iy - 3)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	hl, (ix - 111)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 13), de
	pop	ix
	or	a, a
	sbc	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 4), hl
	pop	ix
	ld	bc, -135
	lea	hl, ix + 0
	add	hl, bc
	ld	de, (hl)
	push	de
	pop	hl
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	ex	de, hl
	add	hl, bc
	call	__ixor
	push	ix
	lea	ix, ix - 128
	ld	(ix - 1), hl
	pop	ix
	ld	bc, -132
	lea	hl, ix + 0
	add	hl, bc
	ld	de, (hl)
	push	de
	pop	hl
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 1)
	pop	ix
	add	hl, bc
	call	__ixor
	push	hl
	pop	bc
	or	a, a
	sbc	hl, de
	jr	c, .LBB4_262
; %bb.261:                              ;   in Loop: Header=BB4_252 Depth=1
	push	bc
	pop	de
	.local	.LBB4_262
.LBB4_262:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	a, (ix - 126)                   ; 1-byte Folded Reload
	cp	a, 2
	jp	nz, .LBB4_274
; %bb.263:                              ;   in Loop: Header=BB4_252 Depth=1
	push	de
	pop	hl
	ld	bc, 28
	or	a, a
	sbc	hl, bc
	ld	a, (ix - 126)                   ; 1-byte Folded Reload
	jp	nc, .LBB4_274
; %bb.264:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	(ix - 126), iy
	ld	iy, (ix - 93)
	ld	hl, (iy - 8)
	ld	de, -129
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	bc, -2011
	add.sis	hl, bc
	ld	bc, 0
	ld	c, l
	ld	b, h
	push	bc
	pop	hl
	ld	de, 9
	or	a, a
	sbc	hl, de
	ld	iy, _player+16
	jp	c, .LBB4_288
	.local	.LBB4_265
.LBB4_265:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	bc, (ix - 96)
	ld	l, c
	ld	h, b
	ld.sis	de, -32768
	add.sis	hl, de
	ld.sis	de, -32578
	or	a, a
	sbc.sis	hl, de
	push	bc
	pop	hl
	jp	c, .LBB4_267
; %bb.266:                              ;   in Loop: Header=BB4_252 Depth=1
	ld.sis	hl, 190
                                        ; kill: def $hl killed $hl def $uhl
	.local	.LBB4_267
.LBB4_267:                              ;   in Loop: Header=BB4_252 Depth=1
	ld.sis	de, 10
	add.sis	hl, de
	ld	(ix - 96), hl
	ld	(iy), l
	ld	(iy + 1), h
	jp	.LBB4_303
	.local	.LBB4_268
.LBB4_268:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	a, e
	cp	a, 13
	ld	a, -1
	jr	nc, .LBB4_270
; %bb.269:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	a, l
	.local	.LBB4_270
.LBB4_270:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	(iy + 5), a
	.local	.LBB4_271
.LBB4_271:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, (ix - 108)
	inc	hl
	lea	iy, iy + 12
	lea	de, iy + 0
	ld	iy, (ix - 93)
	lea	iy, iy + 14
	ld	(ix - 93), iy
	push	de
	pop	iy
	ld	(ix - 108), hl
	ld	de, 91
	or	a, a
	sbc	hl, de
	jp	nz, .LBB4_252
	jp	.LBB4_2
	.local	.LBB4_272
.LBB4_272:                              ;   in Loop: Header=BB4_252 Depth=1
	inc	l
	ld	(iy + 3), l
	ld	a, l
	cp	a, 16
	jr	c, .LBB4_271
; %bb.273:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	(iy + 1), 1
	jr	.LBB4_271
	.local	.LBB4_274
.LBB4_274:                              ;   in Loop: Header=BB4_252 Depth=1
	cp	a, 1
	jp	nz, .LBB4_304
; %bb.275:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	bc, -129
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), de
	ex	de, hl
	ld	de, 769
	or	a, a
	sbc	hl, de
	ld	bc, (ix - 123)
	jr	nc, .LBB4_271
; %bb.276:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	a, (iy)
	or	a, a
	jr	z, .LBB4_271
; %bb.277:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	l, (iy + 2)
	ld	a, l
	or	a, a
	ld	a, 0
	ld	de, (ix - 102)
	jr	z, .LBB4_279
; %bb.278:                              ;   in Loop: Header=BB4_252 Depth=1
	dec	l
	ld	(iy + 2), l
	ld	a, l
	.local	.LBB4_279
.LBB4_279:                              ;   in Loop: Header=BB4_252 Depth=1
	push	ix
	lea	ix, ix - 128
	ld	(ix - 16), a
	pop	ix
	ld	hl, (ix - 108)
                                        ; kill: def $l killed $l killed $uhl
	ld	a, c
	add	a, l
	ld	l, a
	ld	h, 7
	ld	a, l
	and	a, h
	ld	l, a
	or	a, a
	jp	nz, .LBB4_271
; %bb.280:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	(ix - 126), iy
	ld	hl, (ix - 114)
	push	hl
	ld	hl, (ix - 111)
	push	hl
	push	de
	ld	de, -141
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	ld	de, -138
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_sight
	ld	hl, 15
	add	hl, sp
	ld	sp, hl
	bit	0, a
	jp	z, .LBB4_290
; %bb.281:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	de, -129
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, 384
	or	a, a
	sbc	hl, de
	ld	hl, (ix - 99)
	jp	nc, .LBB4_310
; %bb.282:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	de, -144
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	or	a, a
	jp	nz, .LBB4_311
; %bb.283:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, (ix - 117)
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	bc, 25173
	call	__smulu
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld.sis	de, 13849
	add.sis	iy, de
	ld	hl, _random_state
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld	(ix - 117), iy
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	bc, 7
	call	__sremu
	ld.sis	de, 2
	add.sis	hl, de
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld	bc, (ix - 105)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	push	ix
	lea	ix, ix - 128
	ld	(ix - 16), hl
	pop	ix
	ld	e, (ix - 120)
	ld	d, (ix - 119)
	ld	bc, -147
	lea	hl, ix + 0
	add	hl, bc
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	pop	de
	ld	e, iyl
	ld	l, e
	ld	h, d
	ld.sis	bc, 171
	call	__smulu
	ld	(ix - 120), e
	ld	(ix - 119), d
	ld	b, d
	ld	c, h
	ld	a, c
	srl	a
	ld	iy, 0
	ld	iyl, a
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 16)
	pop	ix
	ld	de, -8388608
	add	hl, de
	push	hl
	pop	bc
	lea	hl, iy + 0
	add	hl, de
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jr	c, .LBB4_285
; %bb.284:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	de, -144
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	.local	.LBB4_285
.LBB4_285:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, (ix - 105)
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, bc
	ld	e, l
	ld	d, h
	ld	hl, _player+14
	ld	(ix - 105), de
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	l, c
	ld	h, b
	ld	bc, -147
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)
	ld	d, (iy + 1)
	or	a, a
	sbc.sis	hl, de
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld	hl, (ix - 99)
	ld	e, l
	ld	d, h
	add.sis	iy, de
	ld	hl, _player+12
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld	a, 5
	ld	(_player+28), a
	push	hl
	lea	hl, iy + 0
	ld	(ix - 99), l
	ld	(ix - 98), h
	pop	hl
	ld.sis	de, -32768
	add.sis	iy, de
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	inc.sis	de
	or	a, a
	sbc.sis	hl, de
	ld	iy, (ix - 126)
	jr	nc, .LBB4_287
; %bb.286:                              ;   in Loop: Header=BB4_252 Depth=1
	ld.sis	hl, 0
	ex.sis	de, hl
	ld	hl, _player+12
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	a, 1
	ld	(_player+30), a
	ld	(ix - 99), e
	ld	(ix - 98), d
	.local	.LBB4_287
.LBB4_287:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	(iy + 2), 35
	jp	.LBB4_312
	.local	.LBB4_288
.LBB4_288:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, JTI4_0
	add	hl, bc
	add	hl, bc
	add	hl, bc
	ld	hl, (hl)
	jp	(hl)
	.local	.LBB4_289
.LBB4_289:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	iy, (ix - 99)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	bc, -32768
	add.sis	hl, bc
	ld.sis	de, -32668
	or	a, a
	sbc.sis	hl, de
	jp	c, .LBB4_305
	.local	.LBB4_290
.LBB4_290:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	iy, (ix - 126)
	jp	.LBB4_304
	.local	.LBB4_291
.LBB4_291:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	iy, (ix - 105)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 1)
	pop	ix
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	de, 2018
	or	a, a
	sbc.sis	hl, de
	ld	hl, 100
	jr	z, .LBB4_293
; %bb.292:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, 200
	.local	.LBB4_293
.LBB4_293:                              ;   in Loop: Header=BB4_252 Depth=1
	push	ix
	lea	ix, ix - 128
	ld	(ix - 1), hl
	pop	ix
	ld	c, iyl
	ld	b, iyh
	push	hl
	pop	iy
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	push	bc
	pop	hl
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 1
	ld	de, (iy + 0)
	jr	c, .LBB4_295
; %bb.294:                              ;   in Loop: Header=BB4_252 Depth=1
	push	bc
	pop	de
	.local	.LBB4_295
.LBB4_295:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, _player+14
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	iy, (ix - 126)
	ld	(iy + 1), 1
	ld	l, e
	ld	h, d
	ld	(ix - 105), hl
	jr	.LBB4_304
	.local	.LBB4_296
.LBB4_296:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	bc, (ix - 99)
	ld	l, c
	ld	h, b
	ld.sis	de, -32768
	add.sis	hl, de
	ld.sis	de, -32569
	or	a, a
	sbc.sis	hl, de
	jr	c, .LBB4_298
; %bb.297:                              ;   in Loop: Header=BB4_252 Depth=1
	ld.sis	hl, 199
	ld	c, l
	ld	b, h
	.local	.LBB4_298
.LBB4_298:                              ;   in Loop: Header=BB4_252 Depth=1
	inc.sis	bc
	ld	hl, _player+12
	ld	(ix - 99), bc
	jr	.LBB4_302
	.local	.LBB4_299
.LBB4_299:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	bc, (ix - 105)
	ld	l, c
	ld	h, b
	ld.sis	de, -32768
	add.sis	hl, de
	ld.sis	de, -32569
	or	a, a
	sbc.sis	hl, de
	jr	c, .LBB4_301
; %bb.300:                              ;   in Loop: Header=BB4_252 Depth=1
	ld.sis	hl, 199
	ld	c, l
	ld	b, h
	.local	.LBB4_301
.LBB4_301:                              ;   in Loop: Header=BB4_252 Depth=1
	inc.sis	bc
	ld	hl, _player+14
	ld	(ix - 105), bc
	.local	.LBB4_302
.LBB4_302:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	(hl), c
	inc	hl
	ld	(hl), b
	.local	.LBB4_303
.LBB4_303:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	iy, (ix - 126)
	ld	(iy + 1), 1
	.local	.LBB4_304
.LBB4_304:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	bc, (ix - 123)
	jp	.LBB4_271
	.local	.LBB4_305
.LBB4_305:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	ld	de, -129
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	de, 2011
	or	a, a
	sbc.sis	hl, de
	ld	hl, 10
	push	hl
	pop	iy
	jr	z, .LBB4_307
; %bb.306:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, 25
	push	hl
	pop	iy
	.local	.LBB4_307
.LBB4_307:                              ;   in Loop: Header=BB4_252 Depth=1
	add	iy, bc
	lea	hl, iy + 0
	ld	de, -8388608
	add	hl, de
	ld	de, -8388508
	or	a, a
	sbc	hl, de
	jr	c, .LBB4_309
; %bb.308:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, 100
	push	hl
	pop	iy
	.local	.LBB4_309
.LBB4_309:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, _player+12
	ld	(ix - 99), iy
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	jp	.LBB4_303
	.local	.LBB4_310
.LBB4_310:                              ;   in Loop: Header=BB4_252 Depth=1
                                        ; kill: def $hl killed $hl killed $uhl
	ld	(ix - 99), l
	ld	(ix - 98), h
	ld	iy, (ix - 126)
	jp	.LBB4_313
	.local	.LBB4_311
.LBB4_311:                              ;   in Loop: Header=BB4_252 Depth=1
                                        ; kill: def $hl killed $hl killed $uhl
	ld	(ix - 99), l
	ld	(ix - 98), h
	ld	iy, (ix - 126)
	.local	.LBB4_312
.LBB4_312:                              ;   in Loop: Header=BB4_252 Depth=1
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 1)
	pop	ix
	ld	bc, 49
	or	a, a
	sbc	hl, bc
	jp	c, .LBB4_326
	.local	.LBB4_313
.LBB4_313:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	bc, -135
	lea	hl, ix + 0
	add	hl, bc
	ld	de, (hl)
	push	de
	pop	hl
	ld	bc, -8388608
	add	hl, bc
	ld	bc, 8388605
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB4_315
; %bb.314:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, -4
	ex	de, hl
	.local	.LBB4_315
.LBB4_315:                              ;   in Loop: Header=BB4_252 Depth=1
	push	de
	pop	hl
	ld	bc, -8388608
	add	hl, bc
	ld	bc, -8388604
	or	a, a
	sbc	hl, bc
	ex	de, hl
	jr	c, .LBB4_317
; %bb.316:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, 4
	.local	.LBB4_317
.LBB4_317:                              ;   in Loop: Header=BB4_252 Depth=1
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 10)
	pop	ix
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 7), hl
	pop	ix
	ld	bc, -132
	lea	hl, ix + 0
	add	hl, bc
	ld	de, (hl)
	push	de
	pop	hl
	ld	bc, -8388608
	add	hl, bc
	ld	bc, 8388605
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB4_319
; %bb.318:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	de, -4
	.local	.LBB4_319
.LBB4_319:                              ;   in Loop: Header=BB4_252 Depth=1
	push	de
	pop	bc
	push	bc
	pop	hl
	ld	de, -8388608
	add	hl, de
	ld	de, -8388604
	or	a, a
	sbc	hl, de
	push	bc
	pop	hl
	jr	c, .LBB4_321
; %bb.320:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	hl, 4
	.local	.LBB4_321
.LBB4_321:                              ;   in Loop: Header=BB4_252 Depth=1
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 13)
	pop	ix
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 4), hl
	pop	ix
	ld	a, (iy - 1)
	or	a, a
	sbc	hl, hl
	ld	l, a
	add	hl, hl
	ex	de, hl
	ld	hl, _sector_floor
	add	hl, de
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, -129
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	push	hl
	push	bc
	ld	de, -135
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_engine_can_move
	ld	hl, 9
	add	hl, sp
	ld	sp, hl
	bit	0, a
	jr	z, .LBB4_323
; %bb.322:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	de, -135
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	e, l
	ld	d, h
	ld	iy, (ix - 126)
	ld	(iy - 5), e
	ld	(iy - 4), d
	ld	c, 8
	call	__ishl
	call	__ishrs
	ld	de, -138
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	.local	.LBB4_323
.LBB4_323:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	de, -129
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	ld	de, -132
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	ld	de, -138
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_engine_can_move
	ld	hl, 9
	add	hl, sp
	ld	sp, hl
	bit	0, a
	ld	de, -141
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	jr	z, .LBB4_325
; %bb.324:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	de, -132
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	e, l
	ld	d, h
	ld	iy, (ix - 126)
	ld	(iy - 3), e
	ld	(iy - 2), d
	ld	c, 8
	call	__ishl
	call	__ishrs
	.local	.LBB4_325
.LBB4_325:                              ;   in Loop: Header=BB4_252 Depth=1
	push	hl
	ld	de, -138
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	call	_engine_sector
	ld	hl, 6
	add	hl, sp
	ld	sp, hl
	ld	iy, (ix - 126)
	ld	(iy - 1), a
	.local	.LBB4_326
.LBB4_326:                              ;   in Loop: Header=BB4_252 Depth=1
	ld	l, (ix - 99)
	ld	h, (ix - 98)
                                        ; kill: def $hl killed $hl def $uhl
	ld	(ix - 99), hl
	jp	.LBB4_304
	.local	.LBB4_327
.LBB4_327:
	ld	e, 0
	ld	a, (_player+28)
	ld	l, a
	or	a, a
	jp	nz, .LBB4_39
	jp	.LBB4_40
	.local	.Lfunc_end4
.Lfunc_end4:
	.size	_engine_tick, .Lfunc_end4-_engine_tick
	.section	.rodata._engine_tick,"a",@progbits
JTI4_0:
	d24	.LBB4_289
	d24	.LBB4_289
	d24	.LBB4_265
	d24	.LBB4_296
	d24	.LBB4_299
	d24	.LBB4_265
	d24	.LBB4_265
	d24	.LBB4_291
	d24	.LBB4_291
                                        ; -- End function
	.section	.text._sight,"ax",@progbits
	.type	_sight,@function                ; -- Begin function sight
_sight:                                 ; @sight
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 96
	ld	sp, hl
	ld	de, (ix + 6)
	ld	iy, (ix + 9)
	ld	hl, (ix + 12)
	ld	bc, (ix + 15)
	sbc	hl, de
	ld	(ix - 75), hl
	push	bc
	pop	hl
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	ld	(ix - 78), hl
	ld	bc, -8388608
	push	de
	pop	iy
	add	iy, bc
	ld	hl, (ix + 12)
	add	hl, bc
	push	de
	pop	bc
	ld	(ix - 39), hl
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	push	bc
	pop	de
	ld	(ix - 51), bc
	jr	c, .LBB5_2
; %bb.1:
	ld	hl, (ix + 12)
	ld	(ix - 51), hl
	.local	.LBB5_2
.LBB5_2:
	push	de
	pop	bc
	push	bc
	pop	hl
	ld	de, -8388608
	add	hl, de
	ld	de, (ix - 39)
	or	a, a
	sbc	hl, de
	ld	(ix - 66), bc
	jr	c, .LBB5_4
; %bb.3:
	ld	hl, (ix + 12)
	ld	(ix - 66), hl
	.local	.LBB5_4
.LBB5_4:
	ld	bc, (ix + 9)
	push	bc
	pop	iy
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	ld	hl, (ix + 15)
	add	hl, de
	ld	(ix - 39), hl
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jr	c, .LBB5_6
; %bb.5:
	ld	hl, (ix + 15)
	push	hl
	pop	bc
	.local	.LBB5_6
.LBB5_6:
	ld	(ix - 72), bc
	ld	iy, (_map_lines)
	ld	bc, (ix + 9)
	push	bc
	pop	hl
	ld	de, -8388608
	add	hl, de
	ld	de, (ix - 39)
	or	a, a
	sbc	hl, de
	jr	c, .LBB5_8
; %bb.7:
	ld	hl, (ix + 15)
	push	hl
	pop	bc
	.local	.LBB5_8
.LBB5_8:
	ld	(ix - 81), bc
	xor	a, a
	ld	hl, (_map_vertices)
	ld	(ix - 57), hl
	ld	hl, (_sides)
	ld	(ix - 84), hl
	lea	hl, iy + 12
	ld	(ix - 39), hl
	ld	de, 0
	.local	.LBB5_9
.LBB5_9:                                ; =>This Inner Loop Header: Depth=1
	ld	(ix - 48), de
	ld	iy, (ix - 39)
	ld	de, (iy - 12)
	ld	bc, 0
	push	bc
	pop	hl
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	bc, (ix - 57)
	push	bc
	pop	hl
	add	hl, de
	ld	(ix - 45), hl
	ld	iy, (ix - 39)
	ld	de, (iy - 10)
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ex	de, hl
	push	bc
	pop	iy
	add	iy, de
	ld	hl, (ix - 45)
	ld	de, (hl)
	ld	(ix - 69), iy
	ld	hl, (iy)
	ld	(ix - 42), hl
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld.sis	hl, -32768
	ld	c, l
	ld	b, h
	add.sis	iy, bc
	ld	l, e
	ld	h, d
	add.sis	hl, bc
	ld	(ix - 63), l
	ld	(ix - 62), h
	push	hl
	lea	hl, iy + 0
	ld	(ix - 60), l
	ld	(ix - 59), h
	pop	hl
	ld	c, iyl
	ld	b, iyh
	or	a, a
	sbc.sis	hl, bc
	ld	hl, (ix - 42)
	ld	(ix - 54), de
	ld	c, e
	ld	b, d
	jr	c, .LBB5_11
; %bb.10:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	c, l
	ld	b, h
	.local	.LBB5_11
.LBB5_11:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	l, b
	rlc	l
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, c
	ld	iyh, b
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	ld	hl, (ix - 51)
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	c, .LBB5_38
; %bb.12:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	l, (ix - 60)
	ld	h, (ix - 59)
	ld	c, (ix - 63)
	ld	b, (ix - 62)
	or	a, a
	sbc.sis	hl, bc
	ld	hl, (ix - 54)
	ld	c, l
	ld	b, h
	jr	c, .LBB5_14
; %bb.13:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	hl, (ix - 42)
	ld	c, l
	ld	b, h
	.local	.LBB5_14
.LBB5_14:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	l, b
	rlc	l
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	iy, (ix - 66)
	ld	bc, -8388608
	add	iy, bc
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	c, .LBB5_38
; %bb.15:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	iy, (ix - 45)
	ld	de, (iy + 2)
	ld	iy, (ix - 69)
	ld	hl, (iy + 2)
	ld	(ix - 45), hl
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld.sis	hl, -32768
	ld	c, l
	ld	b, h
	add.sis	iy, bc
	ld	l, e
	ld	h, d
	add.sis	hl, bc
	ld	(ix - 69), l
	ld	(ix - 68), h
	push	hl
	lea	hl, iy + 0
	ld	(ix - 63), l
	ld	(ix - 62), h
	pop	hl
	ld	c, iyl
	ld	b, iyh
	or	a, a
	sbc.sis	hl, bc
	ld	(ix - 60), de
	ld	c, e
	ld	b, d
	jr	c, .LBB5_17
; %bb.16:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	hl, (ix - 45)
	ld	c, l
	ld	b, h
	.local	.LBB5_17
.LBB5_17:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	l, b
	rlc	l
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, c
	ld	iyh, b
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	ld	hl, (ix - 72)
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	c, .LBB5_38
; %bb.18:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	l, (ix - 63)
	ld	h, (ix - 62)
	ld	c, (ix - 69)
	ld	b, (ix - 68)
	or	a, a
	sbc.sis	hl, bc
	ld	hl, (ix - 60)
	ld	c, l
	ld	b, h
	jr	c, .LBB5_20
; %bb.19:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	hl, (ix - 45)
	ld	c, l
	ld	b, h
	.local	.LBB5_20
.LBB5_20:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	l, b
	rlc	l
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	iy, (ix - 81)
	ld	bc, -8388608
	add	iy, bc
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	c, .LBB5_38
; %bb.21:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	hl, (ix - 39)
	ld	iy, (hl)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	bc, -1
	or	a, a
	sbc.sis	hl, bc
	jp	z, .LBB5_28
; %bb.22:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	de, 0
	push	de
	pop	hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	(ix - 69), hl
	ld	iy, (ix - 39)
	ld	bc, (iy - 2)
	push	de
	pop	hl
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	ld	iy, (ix - 84)
	add	iy, bc
	ld	l, (iy + 7)
	push	de
	pop	bc
	ld	c, l
	ld	(ix - 63), bc
	ld	hl, (ix - 69)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	ld	iy, (ix - 84)
	add	iy, bc
	ld	l, (iy + 7)
	ld	e, l
	ld	hl, (ix - 63)
	add	hl, hl
	ld	(ix - 63), hl
	push	hl
	pop	bc
	ld	iy, _sector_floor
	lea	hl, iy + 0
	add	hl, bc
	ld	bc, (hl)
	ld	(ix - 69), bc
	ex	de, hl
	add	hl, hl
	ld	(ix - 87), hl
	ex	de, hl
	lea	hl, iy + 0
	add	hl, de
	ld	de, (hl)
	ld	iyl, c
	ld	iyh, b
	ld.sis	hl, -32768
	ld	c, l
	ld	b, h
	add.sis	iy, bc
	ld	(ix - 90), de
	ld	l, e
	ld	h, d
	add.sis	hl, bc
	ld	c, iyl
	ld	b, iyh
	or	a, a
	sbc.sis	hl, bc
	ld	bc, (ix - 69)
	jp	c, .LBB5_24
; %bb.23:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	bc, (ix - 90)
                                        ; kill: def $bc killed $bc killed $ubc def $ubc
	.local	.LBB5_24
.LBB5_24:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	l, b
	rlc	l
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	bc, (ix + 18)
	push	bc
	pop	iy
	ld	bc, -8388608
	add	iy, bc
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB5_28
; %bb.25:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	(ix - 69), iy
	ld	bc, (ix - 63)
	ld	iy, _sector_ceiling
	lea	hl, iy + 0
	add	hl, bc
	ld	hl, (hl)
	ld	bc, (ix - 87)
	ex	de, hl
	lea	hl, iy + 0
	add	hl, bc
	ld	hl, (hl)
	ld	(ix - 63), hl
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld.sis	hl, -32768
	ld	c, l
	ld	b, h
	add.sis	iy, bc
	ld	l, e
	ld	h, d
	add.sis	hl, bc
	ld	c, iyl
	ld	b, iyh
	or	a, a
	sbc.sis	hl, bc
	jp	c, .LBB5_27
; %bb.26:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	de, (ix - 63)
                                        ; kill: def $de killed $de killed $ude def $ude
	.local	.LBB5_27
.LBB5_27:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	l, d
	rlc	l
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	bc, -8388608
	add	iy, bc
	ld	hl, (ix - 69)
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	c, .LBB5_38
	.local	.LBB5_28
.LBB5_28:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	(ix - 93), a                    ; 1-byte Folded Spill
	ld	hl, (ix - 75)
	ld	(ix - 36), hl
	ld	a, (ix - 34)
	rlc	a
	sbc	a, a
	ld	(ix - 63), a                    ; 1-byte Folded Spill
	ld	hl, (ix - 78)
	ld	(ix - 33), hl
	ld	a, (ix - 31)
	rlc	a
	sbc	a, a
	ld	iyl, a
	ld	bc, (ix - 54)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	(ix - 54), hl
	ld	de, (ix + 6)
	or	a, a
	sbc	hl, de
	ld	(ix - 30), hl
	ld	a, (ix - 28)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	bc, (ix - 78)
	ld	a, iyl
	call	__lmulu
	ld	(ix - 69), hl
	ld	(ix - 87), e                    ; 1-byte Folded Spill
	ld	de, (ix - 60)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 60), hl
	ld	de, (ix + 9)
	or	a, a
	sbc	hl, de
	ld	(ix - 27), hl
	ld	a, (ix - 25)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	bc, (ix - 75)
	ld	a, (ix - 63)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 90), hl
	ld	(ix - 91), e                    ; 1-byte Folded Spill
	ld	de, (ix - 42)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 96), hl
	ld	de, (ix + 6)
	or	a, a
	sbc	hl, de
	ld	(ix - 24), hl
	ld	a, (ix - 22)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	bc, (ix - 78)
	ld	a, iyl
	call	__lmulu
	ld	(ix - 42), hl
	ld	(ix - 92), e                    ; 1-byte Folded Spill
	ld	de, (ix - 45)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	lea	hl, iy + 0
	ld	de, (ix + 9)
	or	a, a
	sbc	hl, de
	ld	(ix - 21), hl
	ld	a, (ix - 19)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	bc, (ix - 75)
	ld	a, (ix - 63)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 45), hl
	ld	(ix - 63), e                    ; 1-byte Folded Spill
	ld	hl, (ix - 69)
	ld	e, (ix - 87)                    ; 1-byte Folded Reload
	ld	bc, (ix - 90)
	ld	a, (ix - 91)                    ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	d, 1
	jp	m, .LBB5_30
; %bb.29:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	d, 0
	.local	.LBB5_30
.LBB5_30:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	hl, (ix - 42)
	ld	e, (ix - 92)                    ; 1-byte Folded Reload
	ld	bc, (ix - 45)
	ld	a, (ix - 63)                    ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	l, 1
	jp	p, .LBB5_32
; %bb.31:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	l, 0
	.local	.LBB5_32
.LBB5_32:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	a, d
	xor	a, l
	ld	l, a
	bit	0, l
	jp	nz, .LBB5_38
; %bb.33:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	hl, (ix + 12)
	ld	de, (ix - 54)
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	(ix - 18), bc
	ld	a, (ix - 16)
	rlc	a
	sbc	a, a
	ld	(ix - 42), a                    ; 1-byte Folded Spill
	lea	hl, iy + 0
	ld	de, (ix - 60)
	or	a, a
	sbc	hl, de
	ld	(ix - 87), hl
	ld	(ix - 15), hl
	ld	a, (ix - 13)
	rlc	a
	sbc	a, a
	ld	(ix - 90), a
	ld	e, a
	ld	a, (ix - 42)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 42), hl
	ld	(ix - 45), e                    ; 1-byte Folded Spill
	ld	hl, (ix + 15)
	ld	de, (ix - 60)
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	(ix - 12), bc
	ld	a, (ix - 10)
	rlc	a
	sbc	a, a
	ld	(ix - 63), a                    ; 1-byte Folded Spill
	ld	hl, (ix - 96)
	ld	de, (ix - 54)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	(ix - 9), iy
	ld	a, (ix - 7)
	rlc	a
	sbc	a, a
	ld	d, a
	push	bc
	pop	hl
	ld	e, (ix - 63)                    ; 1-byte Folded Reload
	lea	bc, iy + 0
	call	__lmulu
	ld	(ix - 63), hl
	ld	(ix - 69), e                    ; 1-byte Folded Spill
	ld	hl, (ix + 6)
	ld	bc, (ix - 54)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	bc
	ld	(ix - 6), bc
	ld	a, (ix - 4)
	rlc	a
	sbc	a, a
	ld	hl, (ix - 87)
	ld	e, (ix - 90)                    ; 1-byte Folded Reload
	call	__lmulu
	ld	(ix - 54), hl
	ld	(ix - 87), e                    ; 1-byte Folded Spill
	ld	hl, (ix + 9)
	ld	bc, (ix - 60)
	or	a, a
	sbc	hl, bc
	ld	(ix - 3), hl
	ld	a, (ix - 1)
	rlc	a
	sbc	a, a
	ld	e, a
	lea	bc, iy + 0
	ld	a, d
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	hl, (ix - 54)
	ld	e, (ix - 87)                    ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	d, 1
	jp	m, .LBB5_35
; %bb.34:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	d, 0
	.local	.LBB5_35
.LBB5_35:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	hl, (ix - 42)
	ld	e, (ix - 45)                    ; 1-byte Folded Reload
	ld	bc, (ix - 63)
	ld	a, (ix - 69)                    ; 1-byte Folded Reload
	call	__lcmps
	call	pe, __setflag
	ld	l, 1
	jp	p, .LBB5_37
; %bb.36:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	l, 0
	.local	.LBB5_37
.LBB5_37:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	a, d
	xor	a, l
	ld	l, a
	bit	0, l
	ld	a, (ix - 93)                    ; 1-byte Folded Reload
	jp	z, .LBB5_39
	.local	.LBB5_38
.LBB5_38:                               ;   in Loop: Header=BB5_9 Depth=1
	ld	hl, (ix - 48)
	push	hl
	pop	de
	inc	de
	ld	bc, 474
	or	a, a
	sbc	hl, bc
	ccf
                                        ; kill: def $a killed $a
	sbc	a, a
	ld	iy, (ix - 39)
	lea	iy, iy + 14
	ld	(ix - 39), iy
	push	de
	pop	hl
	inc	bc
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB5_9
	.local	.LBB5_39
.LBB5_39:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end5
.Lfunc_end5:
	.size	_sight, .Lfunc_end5-_sight
                                        ; -- End function
	.section	.text._d84_draw_seg,"ax",@progbits
	.globl	_d84_draw_seg                   ; -- Begin function d84_draw_seg
	.type	_d84_draw_seg,@function
_d84_draw_seg:                          ; @d84_draw_seg
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	ld	hl, -268
	add	hl, sp
	ld	sp, hl
	ld	iy, (ix + 9)
	ld	a, (iy)
	ld	bc, 0
	push	bc
	pop	hl
	push	ix
	lea	ix, ix - 128
	ld	(ix - 71), a                    ; 1-byte Folded Spill
	pop	ix
	ld	l, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 66), hl
	pop	ix
	ld	a, (iy + 1)
	push	bc
	pop	hl
	ld	l, a
	ld	de, -197
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	dec	de
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	cp	a, d
	jp	z, .LBB6_5
; %bb.1:
	ld	iy, (ix + 9)
	ld	a, (iy + 5)
	add	a, -128
	cp	a, -128
	jp	nc, .LBB6_5
; %bb.2:
	ld	de, -194
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	add	hl, hl
	ex	de, hl
	ld	iy, _sector_floor
	lea	hl, iy + 0
	add	hl, de
	ld	hl, (hl)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 48), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 69)
	pop	ix
	add	hl, hl
	push	ix
	lea	ix, ix - 128
	ld	(ix - 51), hl
	pop	ix
	ex	de, hl
	add	iy, de
	ld	de, (iy)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 48
	ld	hl, (iy + 0)
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, de
	jp	nz, .LBB6_5
; %bb.3:
	ld	de, -194
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	add	hl, hl
	ex	de, hl
	ld	iy, _sector_ceiling
	lea	hl, iy + 0
	add	hl, de
	ld	hl, (hl)
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 51)
	pop	ix
	add	iy, de
	ld	de, (iy)
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, de
	jr	nz, .LBB6_5
; %bb.4:
	ld	iy, (ix + 9)
	ld	a, (iy + 2)
	cp	a, -1
	jp	z, .LBB6_77
	.local	.LBB6_5
.LBB6_5:
	ld	hl, (ix + 6)
	ld	de, (hl)
	push	bc
	pop	iy
	ld	iyl, e
	ld	iyh, d
	lea	bc, iy + 0
	ld	hl, _vertex_stamp
	add	hl, bc
	ld	a, (hl)
	ld	l, -2
	and	a, l
	ld	l, a
	ld	a, (_frame_stamp)
	ld	c, a
	ld	a, l
	push	ix
	lea	ix, ix - 128
	ld	(ix - 48), c                    ; 1-byte Folded Spill
	pop	ix
	cp	a, c
	jr	nz, .LBB6_7
; %bb.6:
	add	iy, iy
	lea	de, iy + 0
	ld	hl, _vertex_side
	add	hl, de
	ld	bc, (hl)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	bc, -185
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	hl, _vertex_depth
	add	hl, de
	ld	bc, (hl)
	ld	de, _vertex_stamp
	jp	.LBB6_10
	.local	.LBB6_7
.LBB6_7:
	ld	hl, (_map_vertices)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 51), hl
	pop	ix
	ld	bc, -188
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), iy
	lea	hl, iy + 0
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 51
	ld	hl, (iy + 0)
	add	hl, bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 51
	ld	(iy + 0), hl
	ld	iy, _extra_points
	add	iy, bc
	ld	bc, -1868
	add	iy, bc
	ld	l, e
	ld	h, d
	ld.sis	de, 467
	or	a, a
	sbc.sis	hl, de
	jr	c, .LBB6_9
; %bb.8:
	ld	de, -179
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	.local	.LBB6_9
.LBB6_9:
	ld	de, -179
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	de, (iy)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, (_camx)
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	de, -182
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), bc
	ld	de, (iy + 2)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, (_camy)
	or	a, a
	sbc	hl, de
	ex	de, hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 63
	ld	(iy + 0), de
	ld	hl, (_camsin)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 51
	ld	(iy + 0), hl
	call	__imulu
	push	hl
	pop	iy
	ld	hl, (_camcos)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 74), hl
	pop	ix
	push	de
	pop	bc
	call	__imulu
	push	hl
	pop	bc
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	ld	a, 8
	ld	c, a
	call	__ishru
	push	hl
	pop	de
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 77
	ld	(iy + 0), de
	call	__ishl
	call	__ishrs
	ld	bc, -185
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	hl, _d84_rotated
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	de, -202
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	call	__imulu
	push	hl
	pop	iy
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 51)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 63)
	pop	ix
	call	__imulu
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	ld	c, a
	call	__ishru
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	iy, _d84_rotated+2
	ld	(iy), l
	ld	(iy + 1), h
	ld	de, -188
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	pop	iy
	add	iy, iy
	lea	bc, iy + 0
	ld	iy, _vertex_side
	add	iy, bc
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 77)
	pop	ix
	ld	(iy), e
	ld	(iy + 1), d
	ld	iy, _vertex_depth
	add	iy, bc
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 54)
	pop	ix
	ld	(iy), c
	ld	(iy + 1), b
	push	hl
	pop	iy
	ld	de, _vertex_stamp
	ex	de, hl
	lea	de, iy + 0
	add	hl, de
	ld	de, _vertex_stamp
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 48
	ld	a, (iy + 0)
	ld	(hl), a
	.local	.LBB6_10
.LBB6_10:
	ld	a, b
	rlc	a
	sbc	hl, hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 54
	ld	(iy + 0), bc
	ld	l, c
	ld	h, b
	ld	bc, -179
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	iy, (ix + 6)
	ld	bc, (iy + 2)
	ld	iy, 0
	push	ix
	lea	ix, ix - 128
	ld	(ix - 60), bc
	pop	ix
	ld	iyl, c
	ld	iyh, b
	lea	bc, iy + 0
	ex	de, hl
	add	hl, bc
	ld	a, (hl)
	ld	l, -2
	and	a, l
	ld	l, a
	push	ix
	lea	ix, ix - 128
	ld	l, (ix - 48)
	pop	ix
	cp	a, l
	jr	nz, .LBB6_12
; %bb.11:
	add	iy, iy
	lea	de, iy + 0
	ld	hl, _vertex_side
	add	hl, de
	ld	bc, (hl)
	ld	a, b
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, c
	ld	iyh, b
	ld	hl, _vertex_depth
	add	hl, de
	ld	bc, (hl)
	jp	.LBB6_15
	.local	.LBB6_12
.LBB6_12:
	ld	de, (_map_vertices)
	ld	bc, -202
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), iy
	lea	hl, iy + 0
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	ex	de, hl
	add	hl, bc
	ld	de, -191
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	iy, _extra_points
	add	iy, bc
	ld	de, -1868
	add	iy, de
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 60)
	pop	ix
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	de, 467
	or	a, a
	sbc.sis	hl, de
	jr	c, .LBB6_14
; %bb.13:
	ld	de, -191
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	.local	.LBB6_14
.LBB6_14:
	ld	de, -191
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	de, (iy)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, (_camx)
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	de, -205
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), bc
	ld	de, (iy + 2)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, (_camy)
	or	a, a
	sbc	hl, de
	ex	de, hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 80
	ld	(iy + 0), de
	ld	hl, (_camsin)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 63
	ld	(iy + 0), hl
	call	__imulu
	push	hl
	pop	iy
	ld	hl, (_camcos)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 83), hl
	pop	ix
	push	de
	pop	bc
	call	__imulu
	push	hl
	pop	bc
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	ld	a, 8
	ld	c, a
	call	__ishru
	push	hl
	pop	de
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 86
	ld	(iy + 0), de
	call	__ishl
	call	__ishrs
	ld	bc, -188
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	hl, _d84_rotated
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, -205
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	call	__imulu
	push	hl
	pop	iy
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 63)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 80)
	pop	ix
	call	__imulu
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	ld	c, a
	call	__ishru
	ex	de, hl
	ld	bc, -191
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	ld	hl, _d84_rotated+2
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	bc, -202
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	push	de
	pop	hl
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _vertex_side
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 86)
	pop	ix
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld	hl, _vertex_depth
	add	hl, bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 63
	ld	bc, (iy + 0)
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 60)
	pop	ix
	ld	(hl), c
	inc	hl
	ld	(hl), b
	ld	hl, _vertex_stamp
	add	hl, de
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 48)
	pop	ix
	ld	(hl), a
	.local	.LBB6_15
.LBB6_15:
	ld	a, b
	rlc	a
	sbc	hl, hl
	push	ix
	lea	ix, ix - 128
	ld	(ix - 63), bc
	pop	ix
	ld	l, c
	ld	h, b
	push	ix
	lea	ix, ix - 128
	ld	(ix - 48), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 57)
	pop	ix
	call	__imulu
	ex	de, hl
	ld	bc, -188
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), iy
	lea	hl, iy + 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 51
	ld	bc, (iy + 0)
	call	__imulu
	push	hl
	pop	bc
	ex	de, hl
	or	a, a
	sbc	hl, bc
	ld	de, -8388608
	add	hl, de
	or	a, a
	sbc	hl, de
	jp	nc, .LBB6_77
; %bb.16:
	ld.sis	bc, -32768
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 54
	ld	hl, (iy + 0)
                                        ; kill: def $hl killed $hl killed $uhl
	add.sis	hl, bc
	ld.sis	bc, -32764
	or	a, a
	sbc.sis	hl, bc
	jp	nc, .LBB6_18
; %bb.17:
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 63
	ld	hl, (iy + 0)
                                        ; kill: def $hl killed $hl killed $uhl
	ld	iyl, c
	ld	iyh, b
	ld.sis	bc, -32768
	add.sis	hl, bc
	ld	c, iyl
	ld	b, iyh
	or	a, a
	sbc.sis	hl, bc
	jp	c, .LBB6_77
	.local	.LBB6_18
.LBB6_18:
	ld	bc, 0
	ld	(ix - 9), bc
	ld	(ix - 12), bc
	ld	a, (_player+32)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 80
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	bit	0, a
	push	bc
	pop	hl
	jr	nz, .LBB6_20
; %bb.19:
	ld	iy, (ix + 9)
	ld	hl, (iy + 6)
	ld	bc, 0
	push	bc
	pop	de
	ld	e, l
	ld	d, h
	ld	hl, (ix + 6)
	push	hl
	pop	iy
	ld	iy, (iy + 10)
	push	bc
	pop	hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	add	hl, de
	ld	bc, 1023
	call	__iand
	push	hl
	pop	bc
	ld	(ix - 9), bc
	ld	iy, (ix + 6)
	ld	hl, (iy + 12)
	ld	de, 0
	ld	e, l
	ld	d, h
	push	bc
	pop	hl
	add	hl, de
	ld	de, -8388608
	ld	(ix - 12), hl
	.local	.LBB6_20
.LBB6_20:
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 86
	ld	(iy + 0), bc
	ld	bc, -211
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	bc, -179
	lea	hl, ix + 0
	add	hl, bc
	ld	iy, (hl)
	ld	hl, -4
	push	hl
	pop	bc
	add	iy, bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 48)
	pop	ix
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 77), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 74), iy
	pop	ix
	lea	bc, iy + 0
	call	__iand
	add	hl, de
	or	a, a
	sbc	hl, de
	jp	c, .LBB6_77
; %bb.21:
	ld	bc, -173
	lea	hl, ix + 0
	add	hl, bc
	ld	bc, -217
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	lea	hl, ix - 9
	ld	bc, -220
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	lea	hl, ix - 12
	ld	bc, -223
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	bc, -205
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 74
	ld	bc, (iy + 0)
	call	__ior
	add	hl, de
	or	a, a
	sbc	hl, de
	jp	c, .LBB6_39
; %bb.22:
	ld	bc, -176
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	ld	bc, -179
	lea	hl, ix + 0
	add	hl, bc
	ld	iy, (hl)
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 57)
	.local	.LBB6_23
.LBB6_23:
	pop	ix
	.local	.LBB6_24
.LBB6_24:
	push	ix
	lea	ix, ix - 128
	ld	(ix - 51), iy
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 57), bc
	pop	ix
	add	iy, bc
	lea	bc, iy + 0
	push	ix
	lea	ix, ix - 128
	ld	(ix - 48), de
	pop	ix
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 60)
	pop	ix
	add	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 54), hl
	pop	ix
	call	__iand
	ld	de, -8388608
	add	hl, de
	or	a, a
	sbc	hl, de
	jp	c, .LBB6_77
; %bb.25:
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 54)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 63), bc
	pop	ix
	call	__ior
	add	hl, de
	or	a, a
	sbc	hl, de
	jp	c, .LBB6_46
; %bb.26:
	ld	bc, -176
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	ld	bc, -179
	lea	hl, ix + 0
	add	hl, bc
	ld	iy, (hl)
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 57)
	.local	.LBB6_27
.LBB6_27:
	pop	ix
	.local	.LBB6_28
.LBB6_28:
	push	ix
	lea	ix, ix - 128
	ld	(ix - 51), iy
	pop	ix
	lea	hl, iy + 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 57
	ld	(iy + 0), bc
	or	a, a
	sbc	hl, bc
	push	hl
	pop	bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 48
	ld	(iy + 0), de
	ex	de, hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 60
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	push	ix
	lea	ix, ix - 128
	ld	(ix - 54), bc
	pop	ix
	call	__iand
	ld	de, -8388608
	add	hl, de
	or	a, a
	sbc	hl, de
	jp	c, .LBB6_77
; %bb.29:
	ld	bc, -191
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), iy
	lea	hl, iy + 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 54
	ld	bc, (iy + 0)
	call	__ior
	add	hl, de
	or	a, a
	sbc	hl, de
	jp	c, .LBB6_53
; %bb.30:
	ld	de, -179
	.local	.LBB6_31
.LBB6_31:
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	.local	.LBB6_32
.LBB6_32:
	ld	de, 2049
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	ld	de, -191
	lea	hl, ix + 0
	push	af
	add	hl, de
	pop	af
	ld	(hl), iy
	ld	de, 0
	jr	c, .LBB6_35
; %bb.33:
	ld	de, 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 63
	ld	bc, (iy + 0)
	.local	.LBB6_34
.LBB6_34:                               ; =>This Inner Loop Header: Depth=1
	push	bc
	pop	hl
	call	__ishru_1
	push	hl
	pop	iy
	inc	de
	push	bc
	pop	hl
	ld	bc, 4098
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jr	nc, .LBB6_34
	.local	.LBB6_35
.LBB6_35:
	ld	bc, 17
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB6_56
; %bb.36:
	ld	bc, 2
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB6_38
; %bb.37:
	ld	iy, 1
	.local	.LBB6_38
.LBB6_38:
	ld	bc, 3
	lea	hl, iy + 0
	call	__imulu
	push	hl
	pop	bc
	ld	hl, _small_reciprocals
	add	hl, bc
	ld	hl, (hl)
	jp	.LBB6_57
	.local	.LBB6_39
.LBB6_39:
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	ld	l, c
	ld	h, b
	ld.sis	de, -32768
	add.sis	hl, de
	ld.sis	de, -32764
	or	a, a
	sbc.sis	hl, de
	jp	nc, .LBB6_42
; %bb.40:
	ld	l, c
	ld	h, b
	ld	bc, -191
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	or	a, a
	sbc.sis	hl, de
	ld	de, -202
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	bc, (iy + 0)
	jp	z, .LBB6_77
; %bb.41:
	ld	de, -179
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 48
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -188
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 57
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 89)
	pop	ix
	ld	(iy + 12), hl
	ld	a, (iy + 14)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	(iy + 15), bc
	ld	a, (iy + 17)
	rlc	a
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 63), a
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 74)
	pop	ix
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 54)
	pop	ix
	ld	(iy + 18), bc
	ld	a, (iy + 20)
	rlc	a
	sbc	a, a
	ld	d, a
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 54)
	pop	ix
	call	__ldivs
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 57)
	pop	ix
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 98), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 48)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 51)
	pop	ix
	or	a, a
	sbc	hl, bc
	ld	(iy + 21), hl
	ld	a, (iy + 23)
	rlc	a
	sbc	a, a
	ld	e, a
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 74
	ld	bc, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 63
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	call	__lmulu
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 54
	ld	bc, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 104
	ld	(iy + 0), d                     ; 1-byte Folded Spill
	ld	a, d
	call	__ldivs
	ld	bc, -176
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	push	hl
	pop	iy
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 51)
	pop	ix
	add	iy, bc
	ld	bc, -208
	lea	hl, ix + 0
	push	af
	add	hl, bc
	pop	af
	bit	0, (hl)                         ; 1-byte Folded Reload
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 86)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 101), bc
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 92)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 107), bc
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 98)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 86), iy
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 74)
	jp	.LBB6_44
	.local	.LBB6_42
.LBB6_42:
	ld	de, -191
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, bc
	ld	de, -205
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	bc, (iy + 0)
	jp	z, .LBB6_77
; %bb.43:
	ld	de, -176
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 51
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -185
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 60
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 89)
	pop	ix
	ld	(iy + 0), hl
	ld	a, (iy + 2)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	(iy + 3), bc
	ld	a, (iy + 5)
	rlc	a
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 63), a
	pop	ix
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 54)
	pop	ix
	ld	(iy + 6), bc
	ld	a, (iy + 8)
	rlc	a
	sbc	a, a
	ld	d, a
	call	__ldivs
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 60)
	pop	ix
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 60), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 51)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 48)
	pop	ix
	or	a, a
	sbc	hl, bc
	ld	(iy + 9), hl
	ld	a, (iy + 11)
	rlc	a
	sbc	a, a
	ld	e, a
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 77
	ld	bc, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 63
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	call	__lmulu
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 54
	ld	bc, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 104
	ld	(iy + 0), d                     ; 1-byte Folded Spill
	ld	a, d
	call	__ldivs
	ld	bc, -176
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	add	hl, de
	ld	de, -208
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	bit	0, (iy + 0)                     ; 1-byte Folded Reload
	ld	bc, -211
	lea	iy, ix + 0
	push	af
	add	iy, bc
	pop	af
	ld	de, (iy + 0)
	ld	bc, -229
	lea	iy, ix + 0
	push	af
	add	iy, bc
	pop	af
	ld	(iy + 0), de
	ld	de, -214
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	bc, (iy + 0)
	ld	de, -211
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	(iy + 0), bc
	ld	de, -185
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	bc, (iy + 0)
	ld	de, -226
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	(iy + 0), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 51
	ld	de, (iy + 0)
	push	de
	pop	iy
	push	ix
	lea	ix, ix - 128
	ld	(ix - 86), de
	pop	ix
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 95)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 107), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 77)
	.local	.LBB6_44
.LBB6_44:
	pop	ix
	jp	nz, .LBB6_24
; %bb.45:
	ld	bc, -176
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	ex	de, hl
	ld	bc, -211
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 101
	ld	bc, (iy + 0)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	bc
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 89)
	pop	ix
	ld	(iy + 24), bc
	ld	a, (iy + 26)
	rlc	a
	sbc	a, a
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 63
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	call	__lmulu
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 54
	ld	bc, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 104
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	call	__ldivs
	ld	bc, -176
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	push	hl
	pop	bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 101
	ld	hl, (iy + 0)
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 107)
	pop	ix
	ld	(iy), hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 98
	ld	bc, (iy + 0)
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 86)
	jp	.LBB6_23
	.local	.LBB6_46
.LBB6_46:
	add	iy, de
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	jp	nc, .LBB6_49
; %bb.47:
	ld	de, -191
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	lea	hl, iy + 0
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 54)
	pop	ix
	or	a, a
	sbc	hl, de
	jp	z, .LBB6_77
; %bb.48:
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 74), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 60)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 57)
	pop	ix
	or	a, a
	sbc	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 6), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 4)
	pop	ix
	rlc	a
	sbc	a, a
	ld	e, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 3), iy
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 1)
	pop	ix
	rlc	a
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 77), a
	pop	ix
	lea	bc, iy + 0
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 74)
	pop	ix
	ld	(ix - 128), iy
	ld	a, (ix - 126)
	rlc	a
	sbc	a, a
	ld	d, a
	lea	bc, iy + 0
	call	__ldivs
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 57)
	pop	ix
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 86), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 48)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 51)
	pop	ix
	or	a, a
	sbc	hl, bc
	ld	(ix - 125), hl
	ld	a, (ix - 123)
	rlc	a
	sbc	a, a
	ld	e, a
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 63)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 77)                    ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	lea	bc, iy + 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 83
	ld	(iy + 0), d                     ; 1-byte Folded Spill
	ld	a, d
	call	__ldivs
	push	hl
	pop	bc
	ld	de, -179
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	add	iy, bc
	ld	bc, -176
	lea	hl, ix + 0
	push	af
	add	hl, bc
	pop	af
	ld	de, (hl)
	ld	bc, -208
	lea	hl, ix + 0
	push	af
	add	hl, bc
	pop	af
	bit	0, (hl)                         ; 1-byte Folded Reload
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 95)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 92)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 98), bc
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 86)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 89), iy
	jp	.LBB6_51
	.local	.LBB6_49
.LBB6_49:
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	push	bc
	pop	hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 63
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	jp	z, .LBB6_77
; %bb.50:
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	ld	de, -202
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -185
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 60
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	push	bc
	pop	de
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 89)
	pop	ix
	ld	(iy + 27), bc
	ld	a, (iy + 29)
	rlc	a
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 63), a                    ; 1-byte Folded Spill
	pop	ix
	ld	(iy + 30), de
	ld	a, (iy + 32)
	rlc	a
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 77), a
	pop	ix
	ex	de, hl
	ld	e, a
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 63)                    ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 74)
	pop	ix
	ld	(iy + 33), bc
	ld	a, (iy + 35)
	rlc	a
	sbc	a, a
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 83
	ld	(iy + 0), a
	call	__ldivs
	push	hl
	pop	bc
	ld	de, -188
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	add	hl, bc
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	bc, -179
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	push	de
	pop	hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 48
	ld	bc, (iy + 0)
	or	a, a
	sbc	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 89)
	pop	ix
	ld	(iy + 36), hl
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 89)
	pop	ix
	ld	a, (iy + 38)
	push	de
	pop	iy
	rlc	a
	sbc	a, a
	ld	e, a
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 54)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 77)                    ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 74)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 83)                    ; 1-byte Folded Reload
	pop	ix
	call	__ldivs
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 48)
	pop	ix
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 57)
	pop	ix
	push	ix
	lea	ix, ix - 128
	bit	0, (ix - 80)                    ; 1-byte Folded Reload
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 86), bc
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 89), iy
	pop	ix
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 92)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 48), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 95)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 98), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 54)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 63), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 48)
	.local	.LBB6_51
.LBB6_51:
	pop	ix
	jp	nz, .LBB6_28
; %bb.52:
	ld	bc, -176
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	ld	hl, (hl)
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 98)
	pop	ix
	ld	de, (iy)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 51), de
	pop	ix
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	(ix - 122), bc
	ld	a, (ix - 120)
	rlc	a
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 63)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 77)                    ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 74)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 83)                    ; 1-byte Folded Reload
	pop	ix
	call	__ldivs
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 48)
	pop	ix
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 51)
	pop	ix
	add	hl, bc
	ld	(iy), hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 86
	ld	bc, (iy + 0)
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 89)
	jp	.LBB6_27
	.local	.LBB6_53
.LBB6_53:
	ld	bc, -182
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	add	hl, de
	or	a, a
	sbc	hl, de
	jp	nc, .LBB6_76
; %bb.54:
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	bc, -191
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	jp	z, .LBB6_77
; %bb.55:
	ld	bc, -182
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	push	hl
	pop	bc
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 60)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 57)
	pop	ix
	or	a, a
	sbc	hl, de
	ld	(ix - 107), hl
	ld	a, (ix - 105)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	(ix - 104), bc
	ld	a, (ix - 102)
	rlc	a
	sbc	a, a
	ld	d, a
	call	__lmulu
	ld	(ix - 101), iy
	lea	bc, iy + 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 74
	ld	(iy + 0), bc
	ld	a, (ix - 99)
	rlc	a
	sbc	a, a
	ld	iyl, a
	call	__ldivs
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 57)
	pop	ix
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 57), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 48)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 51)
	pop	ix
	or	a, a
	sbc	hl, bc
	ld	(ix - 98), hl
	ld	a, (ix - 96)
	rlc	a
	sbc	a, a
	ld	e, a
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 54)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 77), d                    ; 1-byte Folded Spill
	pop	ix
	ld	a, d
	ld	d, iyl
	call	__lmulu
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 74
	ld	bc, (iy + 0)
	ld	a, d
	call	__ldivs
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 51)
	pop	ix
	add	iy, bc
	ld	bc, -208
	lea	hl, ix + 0
	push	af
	add	hl, bc
	pop	af
	bit	0, (hl)                         ; 1-byte Folded Reload
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 95)
	jp	.LBB6_79
	.local	.LBB6_56
.LBB6_56:
	add	iy, iy
	lea	bc, iy + 0
	ld	hl, _reciprocal_table
	add	hl, bc
	ld	bc, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	.local	.LBB6_57
.LBB6_57:
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 57)
	pop	ix
	ld	(ix - 92), iy
	ld	a, (ix - 90)
	rlc	a
	sbc	a, a
	ld	c, e
	call	__ishru
	ld	de, 0
	push	ix
	lea	ix, ix - 128
	ld	(ix - 54), e                    ; 1-byte Folded Spill
	pop	ix
	lea	bc, iy + 0
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 14
	call	__lshrs
	ld	de, -185
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	ld	de, -179
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), bc
	push	bc
	pop	hl
	ld	de, 64
	add	hl, de
	ld	de, -202
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -176
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	lea	hl, iy + 0
	ld	de, 2049
	or	a, a
	sbc	hl, de
	ld	de, 0
	jr	c, .LBB6_60
; %bb.58:
	ld	de, 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 48
	ld	bc, (iy + 0)
	.local	.LBB6_59
.LBB6_59:                               ; =>This Inner Loop Header: Depth=1
	push	bc
	pop	hl
	call	__ishru_1
	push	hl
	pop	iy
	inc	de
	push	bc
	pop	hl
	ld	bc, 4098
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jr	nc, .LBB6_59
	.local	.LBB6_60
.LBB6_60:
	lea	hl, iy + 0
	ld	bc, 17
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB6_64
; %bb.61:
	ld	bc, 2
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB6_63
; %bb.62:
	ld	iy, 1
	.local	.LBB6_63
.LBB6_63:
	ld	bc, 3
	lea	hl, iy + 0
	call	__imulu
	push	hl
	pop	bc
	ld	hl, _small_reciprocals
	add	hl, bc
	ld	hl, (hl)
	jr	.LBB6_65
	.local	.LBB6_64
.LBB6_64:
	add	iy, iy
	lea	bc, iy + 0
	ld	hl, _reciprocal_table
	add	hl, bc
	ld	bc, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	.local	.LBB6_65
.LBB6_65:
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 60)
	pop	ix
	ld	(ix - 89), iy
	ld	a, (ix - 87)
	rlc	a
	sbc	a, a
	ld	c, e
	call	__ishru
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 54)                    ; 1-byte Folded Reload
	pop	ix
	lea	bc, iy + 0
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 14
	call	__lshrs
	ld	de, -179
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	lea	hl, iy + 0
	ld	de, -8388608
	add	hl, de
	ld	de, -8388544
	or	a, a
	sbc	hl, de
	jp	nc, .LBB6_77
; %bb.66:
	lea	hl, iy + 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 57
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	call	__lcmps
	ld	de, -8388608
	call	pe, __setflag
	jp	p, .LBB6_77
; %bb.67:
	push	bc
	pop	hl
	add	hl, de
	ld	de, 8388545
	or	a, a
	sbc	hl, de
	jp	c, .LBB6_77
; %bb.68:
	ld	de, -202
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	pop	de
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 83
	ld	(iy + 0), bc
	push	bc
	pop	iy
	ld	bc, 64
	add	iy, bc
	push	ix
	lea	ix, ix - 128
	ld	(ix - 57), iy
	pop	ix
	ld	bc, -8388608
	add	hl, bc
	inc	bc
	or	a, a
	sbc	hl, bc
	ld	bc, -214
	lea	iy, ix + 0
	push	af
	add	iy, bc
	pop	af
	ld	(iy + 0), de
	jr	nc, .LBB6_70
; %bb.69:
	ld	de, 0
	.local	.LBB6_70
.LBB6_70:
	ld	iy, 128
	ld	bc, 128
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 57)
	pop	ix
	or	a, a
	sbc	hl, bc
	jr	c, .LBB6_72
; %bb.71:
	ld	bc, -185
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), iy
	.local	.LBB6_72
.LBB6_72:
	ld	bc, -188
	lea	hl, ix + 0
	push	af
	add	hl, bc
	pop	af
	ld	(hl), de
	ld	de, -208
	lea	hl, ix + 0
	push	af
	add	hl, de
	pop	af
	bit	0, (hl)                         ; 1-byte Folded Reload
	ld	bc, 1
	jr	nz, .LBB6_74
; %bb.73:
	ld	bc, (_render_detail)
	.local	.LBB6_74
.LBB6_74:
	ld	de, 2
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	ld	de, -205
	lea	hl, ix + 0
	push	af
	add	hl, de
	pop	af
	ld	(hl), bc
	ld	de, -223
	lea	hl, ix + 0
	push	af
	add	hl, de
	pop	af
	ld	(hl), iy
	jp	c, .LBB6_81
; %bb.75:
	push	bc
	pop	iy
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 60)
	pop	ix
	add	iy, de
	dec	iy
	lea	hl, iy + 0
	call	__irems
	ex	de, hl
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	ex	de, hl
	jp	.LBB6_82
	.local	.LBB6_76
.LBB6_76:
	ld	de, -191
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	push	bc
	pop	hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 54
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	jr	nz, .LBB6_78
	.local	.LBB6_77
.LBB6_77:
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB6_78
.LBB6_78:
	push	bc
	pop	hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 54
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	de, -202
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 57)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 60)
	pop	ix
	or	a, a
	sbc	hl, de
	push	bc
	pop	de
	push	hl
	pop	bc
	ld	(ix - 119), bc
	ld	a, (ix - 117)
	rlc	a
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 54), a                    ; 1-byte Folded Spill
	pop	ix
	ld	(ix - 116), de
	ex	de, hl
	ld	a, (ix - 114)
	rlc	a
	sbc	a, a
	ld	d, a
	ld	e, d
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 54)                    ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	ld	(ix - 113), iy
	ld	a, (ix - 111)
	rlc	a
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 83), a
	pop	ix
	lea	bc, iy + 0
	call	__ldivs
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 60)
	pop	ix
	add	iy, bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 51)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 48)
	pop	ix
	or	a, a
	sbc	hl, bc
	ld	(ix - 110), hl
	ld	a, (ix - 108)
	rlc	a
	sbc	a, a
	ld	e, a
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 63)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 77), d                    ; 1-byte Folded Spill
	pop	ix
	ld	a, d
	push	ix
	lea	ix, ix - 128
	ld	d, (ix - 83)                    ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 74)
	pop	ix
	ld	a, d
	call	__ldivs
	push	hl
	pop	bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 48)
	pop	ix
	add	hl, bc
	push	ix
	lea	ix, ix - 128
	bit	0, (ix - 80)                    ; 1-byte Folded Reload
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 51)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 60), iy
	pop	ix
	push	bc
	pop	iy
	push	ix
	lea	ix, ix - 128
	ld	(ix - 48), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 92)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 95)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 92), bc
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 63)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 54), bc
	.local	.LBB6_79
.LBB6_79:
	pop	ix
	jp	nz, .LBB6_32
; %bb.80:
	push	ix
	lea	ix, ix - 128
	ld	(ix - 63), iy
	pop	ix
	ld	hl, (hl)
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 92)
	pop	ix
	ld	bc, (iy)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 51), bc
	pop	ix
	or	a, a
	sbc	hl, bc
	push	hl
	pop	bc
	ld	(ix - 95), bc
	ld	a, (ix - 93)
	rlc	a
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 54)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 77)                    ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 74)
	pop	ix
	ld	a, d
	call	__ldivs
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 51)
	pop	ix
	add	hl, de
	ld	(iy), hl
	ld	de, -191
	jp	.LBB6_31
	.local	.LBB6_81
.LBB6_81:
	ld	bc, -188
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	.local	.LBB6_82
.LBB6_82:
	ld	bc, -185
	lea	hl, ix + 0
	add	hl, bc
	ld	iy, (hl)
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	push	de
	pop	hl
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB6_85
	.local	.LBB6_83
.LBB6_83:                               ; =>This Inner Loop Header: Depth=1
	lea	bc, iy + 0
	ld	hl, _cliptop
	add	hl, de
	ld	iy, _clipbottom
	add	iy, de
	ld	a, (iy)
	ld	iyl, a
	ld	a, (hl)
	cp	a, iyl
	jr	c, .LBB6_85
; %bb.84:                               ;   in Loop: Header=BB6_83 Depth=1
	ex	de, hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 77
	ld	de, (iy + 0)
	add	hl, de
	ld	de, -188
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -8388608
	add	hl, de
	push	bc
	pop	iy
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	ld	bc, -188
	lea	hl, ix + 0
	push	af
	add	hl, bc
	pop	af
	ld	de, (hl)
	jr	c, .LBB6_83
	.local	.LBB6_85
.LBB6_85:
	ld	a, 1
	ld	bc, -217
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), a
	ld	bc, -188
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	ld	bc, -202
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), de
	ld	bc, -185
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	.local	.LBB6_86
.LBB6_86:                               ; =>This Inner Loop Header: Depth=1
	push	de
	pop	bc
	push	bc
	pop	iy
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 74)
	pop	ix
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	nc, .LBB6_77
; %bb.87:                               ;   in Loop: Header=BB6_86 Depth=1
	push	bc
	pop	de
	dec	de
	ld	iy, _cliptop-1
	add	iy, bc
	ld	hl, _clipbottom-1
	push	ix
	lea	ix, ix - 128
	ld	(ix - 98), bc
	pop	ix
	add	hl, bc
	ld	l, (hl)
	ld	a, (iy)
	cp	a, l
	jr	nc, .LBB6_86
; %bb.88:
	ld	de, -191
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	push	bc
	pop	hl
	ld	de, 2049
	or	a, a
	sbc	hl, de
	jr	c, .LBB6_91
; %bb.89:
	ld	de, 0
	.local	.LBB6_90
.LBB6_90:                               ; =>This Inner Loop Header: Depth=1
	push	bc
	pop	hl
	call	__ishru_1
	push	hl
	pop	iy
	inc	de
	push	bc
	pop	hl
	ld	bc, 4098
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jr	nc, .LBB6_90
	jr	.LBB6_92
	.local	.LBB6_91
.LBB6_91:
	push	bc
	pop	iy
	ld	de, 0
	.local	.LBB6_92
.LBB6_92:
	lea	hl, iy + 0
	ld	bc, 17
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB6_96
; %bb.93:
	ld	hl, _planes
	push	ix
	ld	bc, -257
	add	ix, bc
	ld	(ix + 0), hl
	pop	ix
	lea	hl, iy + 0
	ld	bc, 2
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB6_95
; %bb.94:
	ld	iy, 1
	.local	.LBB6_95
.LBB6_95:
	ld	bc, 3
	lea	hl, iy + 0
	call	__imulu
	push	hl
	pop	bc
	ld	hl, _small_reciprocals
	add	hl, bc
	ld	hl, (hl)
	jr	.LBB6_97
	.local	.LBB6_96
.LBB6_96:
	ld	hl, _planes
	push	ix
	ld	bc, -257
	add	ix, bc
	ld	(ix + 0), hl
	pop	ix
	add	iy, iy
	lea	bc, iy + 0
	ld	hl, _reciprocal_table
	add	hl, bc
	ld	bc, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	.local	.LBB6_97
.LBB6_97:
	ld	c, e
	call	__ishru
	ld	c, 2
	call	__ishru
	ld	de, -185
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -176
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	push	bc
	pop	hl
	ld	de, 2049
	or	a, a
	sbc	hl, de
	jr	c, .LBB6_100
; %bb.98:
	ld	de, 0
	.local	.LBB6_99
.LBB6_99:                               ; =>This Inner Loop Header: Depth=1
	push	bc
	pop	hl
	call	__ishru_1
	push	hl
	pop	iy
	inc	de
	push	bc
	pop	hl
	ld	bc, 4098
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jr	nc, .LBB6_99
	jr	.LBB6_101
	.local	.LBB6_100
.LBB6_100:
	push	bc
	pop	iy
	ld	de, 0
	.local	.LBB6_101
.LBB6_101:
	lea	hl, iy + 0
	ld	bc, 17
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB6_105
; %bb.102:
	lea	hl, iy + 0
	ld	bc, 2
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB6_104
; %bb.103:
	ld	iy, 1
	.local	.LBB6_104
.LBB6_104:
	ld	bc, 3
	lea	hl, iy + 0
	call	__imulu
	push	hl
	pop	bc
	ld	hl, _small_reciprocals
	add	hl, bc
	ld	hl, (hl)
	jr	.LBB6_106
	.local	.LBB6_105
.LBB6_105:
	add	iy, iy
	lea	bc, iy + 0
	ld	hl, _reciprocal_table
	add	hl, bc
	ld	bc, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	.local	.LBB6_106
.LBB6_106:
	ld	c, e
	call	__ishru
	ld	c, 2
	call	__ishru
	push	hl
	pop	bc
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 51
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	de, -191
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), bc
	push	bc
	pop	hl
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 57)
	pop	ix
	or	a, a
	sbc	hl, de
	push	hl
	pop	de
	lea	bc, iy + 0
	call	__idivs
	push	ix
	lea	ix, ix - 128
	ld	(ix - 74), hl
	pop	ix
	ld	(ix - 86), de
	ld	a, (ix - 84)
	rlc	a
	sbc	a, a
	ld	bc, -176
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), a                         ; 1-byte Folded Spill
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 60)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 86)
	pop	ix
	or	a, a
	sbc	hl, bc
	push	hl
	pop	bc
	ld	(ix - 83), bc
	ld	a, (ix - 81)
	rlc	a
	sbc	a, a
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 48)                    ; 1-byte Folded Reload
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 48), bc
	pop	ix
	call	__lmulu
	ld	(ix - 80), iy
	ld	a, (ix - 78)
	rlc	a
	sbc	a, a
	lea	bc, iy + 0
	call	__ldivs
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 57)
	pop	ix
	ex	de, hl
	push	bc
	pop	hl
	add	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 51), hl
	pop	ix
	ld	de, -208
	lea	hl, ix + 0
	push	af
	add	hl, de
	pop	af
	bit	0, (hl)                         ; 1-byte Folded Reload
	ld	hl, 0
	push	ix
	lea	ix, ix - 128
	ld	(ix - 107), hl
	pop	ix
	jp	nz, .LBB6_108
; %bb.107:
	ld	(ix - 77), iy
	ld	a, (ix - 75)
	rlc	a
	sbc	a, a
	ld	de, -211
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), a                         ; 1-byte Folded Spill
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 48)
	pop	ix
	ld	(ix - 74), hl
	ld	a, (ix - 72)
	rlc	a
	sbc	a, a
	ld	de, -214
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), a                         ; 1-byte Folded Spill
	ld	hl, (ix - 9)
	ld	(ix - 71), hl
	ld	a, (ix - 69)
	rlc	a
	sbc	a, a
	ld	e, a
	push	ix
	lea	ix, ix - 128
	ld	d, (ix - 54)                    ; 1-byte Folded Reload
	pop	ix
	ld	a, d
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 4
	call	__lshru
	push	ix
	lea	ix, ix - 128
	ld	(ix - 57), bc
	pop	ix
	ld	hl, (ix - 12)
	ld	(ix - 68), hl
	ld	a, (ix - 66)
	rlc	a
	sbc	a, a
	ld	e, a
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 63)
	pop	ix
	ld	a, d
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 4
	call	__lshru
	push	bc
	pop	hl
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 57)
	pop	ix
	or	a, a
	sbc	hl, de
	push	hl
	pop	de
	lea	bc, iy + 0
	call	__idivs
	push	ix
	lea	ix, ix - 128
	ld	(ix - 107), hl
	pop	ix
	ld	(ix - 65), de
	ld	a, (ix - 63)
	rlc	a
	sbc	a, a
	ex	de, hl
	ld	e, a
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 48)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 86)                    ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	lea	bc, iy + 0
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 83
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	call	__ldivs
	ex	de, hl
	ld	bc, -185
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	add	hl, de
	.local	.LBB6_108
.LBB6_108:
	ld	de, -252
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -194
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	lea	hl, iy + 0
	add	hl, hl
	ex	de, hl
	ld	hl, _sector_ceiling
	add	hl, de
	ld	hl, (hl)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 54), hl
	pop	ix
	ld	hl, _sector_floor
	add	hl, de
	ld	hl, (hl)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 57), hl
	pop	ix
                                        ; kill: def $hl killed $hl killed $uhl
	push	ix
	lea	ix, ix - 128
	ld	(ix - 111), l
	ld	(ix - 110), h
	pop	ix
	ld	a, h
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	de, -198
	lea	hl, ix + 0
	add	hl, de
	ld	a, (hl)                         ; 1-byte Folded Reload
	cp	a, d
	jp	z, .LBB6_112
; %bb.109:
	ld	de, -176
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), bc
	ld	hl, (_map_sectors)
	push	ix
	lea	ix, ix - 128
	ld	(ix - 63), hl
	pop	ix
	lea	hl, iy + 0
	add	hl, hl
	ex	de, hl
	ld	hl, _sector_offsets
	add	hl, de
	ld	hl, (hl)
	ld	bc, 0
	push	bc
	pop	de
	ld	e, l
	ld	d, h
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 63)
	pop	ix
	add	iy, de
	ld	a, (iy + 5)
	cp	a, -1
	jp	nz, .LBB6_113
; %bb.110:
	ld	de, -197
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	add	hl, hl
	ld	de, -211
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ex	de, hl
	ld	hl, _sector_offsets
	add	hl, de
	ld	de, (hl)
	ld	c, e
	ld	b, d
	ld	de, -191
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	add	iy, bc
	ld	a, (iy + 5)
	cp	a, d
	ld	a, 0
	ld	de, -249
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	ld	a, 1
	jr	nz, .LBB6_114
; %bb.111:
	ld	bc, -211
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	ld	hl, _sector_ceiling
	add	hl, de
	ld	hl, (hl)
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -249
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	xor	a, a
	jr	.LBB6_114
	.local	.LBB6_112
.LBB6_112:
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld	a, 1
	ld	l, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 125), l                   ; 1-byte Folded Spill
	pop	ix
	dec	a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 121), a                   ; 1-byte Folded Spill
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 108), l                   ; 1-byte Folded Spill
	pop	ix
	jp	.LBB6_118
	.local	.LBB6_113
.LBB6_113:
	xor	a, a
	ld	de, -249
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	inc	a
	.local	.LBB6_114
.LBB6_114:
	ld	de, -253
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), a
	ld	de, -197
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	add	hl, hl
	ld	de, -191
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ex	de, hl
	ld	hl, _sector_ceiling
	add	hl, de
	ld	iy, (hl)
	ld.sis	bc, -32768
	add.sis	iy, bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 57)
	pop	ix
	add.sis	hl, bc
                                        ; kill: def $hl killed $hl killed $uhl
	push	ix
	lea	ix, ix - 128
	ld	(ix - 57), iy
	pop	ix
	ld	e, iyl
	ld	d, iyh
	or	a, a
	sbc.sis	hl, de
	jp	nc, .LBB6_116
; %bb.115:
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 63
	ld	de, (iy + 0)
	ld	hl, _sector_floor
	add	hl, de
	ld	de, (hl)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 54
	ld	hl, (iy + 0)
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	add.sis	iy, bc
	ex	de, hl
	add.sis	hl, bc
	push	hl
	pop	bc
	ld	e, iyl
	ld	d, iyh
	or	a, a
	sbc.sis	hl, de
	ccf
                                        ; kill: def $a killed $a
	sbc	a, a
	ld	iyl, a
	ld	l, c
	ld	h, b
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 57)
	pop	ix
                                        ; kill: def $de killed $de killed $ude
	or	a, a
	sbc.sis	hl, de
	ccf
                                        ; kill: def $a killed $a
	sbc	a, a
	ld	l, a
	ld	a, iyl
	or	a, l
	ld	l, a
	ld	de, -236
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	jr	.LBB6_117
	.local	.LBB6_116
.LBB6_116:
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld	a, 1
	ld	de, -236
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), a                         ; 1-byte Folded Spill
	.local	.LBB6_117
.LBB6_117:
	ld	de, -176
	lea	hl, ix + 0
	add	hl, de
	ld	bc, (hl)
	.local	.LBB6_118
.LBB6_118:
	push	ix
	lea	ix, ix - 128
	ld	l, (ix - 111)
	ld	h, (ix - 110)
	pop	ix
	ld	c, l
	ld	b, h
	ld	de, -176
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), bc
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	bc, -259
	lea	hl, ix + 0
	add	hl, bc
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	pop	de
	ld	e, iyl
	ld	d, iyh
	ld	hl, _player+8
	ld	iy, (hl)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 54
	ld	(iy + 0), de
	ex	de, hl
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 51)
	pop	ix
	ld	de, 16384
	add	hl, de
	ld	de, 32768
	push	ix
	lea	ix, ix - 128
	lea	ix, ix - 128
	lea	ix, ix - 9
	ld	(ix + 0), hl
	pop	ix
	or	a, a
	sbc	hl, de
	ld	de, -220
	lea	hl, ix + 0
	push	af
	add	hl, de
	pop	af
	ld	(hl), bc
	ld	de, -185
	lea	hl, ix + 0
	push	af
	add	hl, de
	pop	af
	ld	(hl), iy
	jr	nc, .LBB6_120
; %bb.119:
	lea	hl, iy + 0
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 51)
	pop	ix
	lea	bc, iy + 0
	call	__imulu
	ld	a, 4
	ld	c, a
	call	__ishrs
	push	ix
	lea	ix, ix - 128
	ld	(ix - 83), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 48)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 92)
	pop	ix
	or	a, a
	sbc	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 63), hl
	pop	ix
	lea	bc, iy + 0
	call	__imulu
	ld	c, a
	call	__ishrs
	push	hl
	pop	bc
	jr	.LBB6_121
	.local	.LBB6_120
.LBB6_120:
	ld	(ix - 62), iy
	ld	a, (ix - 60)
	rlc	a
	sbc	a, a
	ld	e, a
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 51)
	pop	ix
	ld	(ix - 59), hl
	push	hl
	pop	bc
	ld	a, (ix - 57)
	rlc	a
	sbc	a, a
	ld	d, a
	lea	hl, iy + 0
	push	bc
	pop	iy
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 4
	call	__lshru
	push	ix
	lea	ix, ix - 128
	ld	(ix - 83), bc
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 48)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 92)
	pop	ix
	or	a, a
	sbc	hl, bc
	ld	(ix - 56), hl
	ld	a, (ix - 54)
	rlc	a
	sbc	a, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 63), hl
	pop	ix
	ld	e, a
	lea	bc, iy + 0
	ld	a, d
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 4
	call	__lshru
	.local	.LBB6_121
.LBB6_121:
	ld	iy, 10240
	lea	hl, iy + 0
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 83)
	pop	ix
	or	a, a
	sbc	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 83), hl
	pop	ix
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	ld	de, -214
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -202
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	lea	hl, iy + 0
	ld	de, 16384
	add	hl, de
	push	ix
	ld	de, -262
	add	ix, de
	ld	(ix + 0), hl
	pop	ix
	ld	de, 32768
	or	a, a
	sbc	hl, de
	jr	nc, .LBB6_123
; %bb.122:
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 57)
	pop	ix
	lea	bc, iy + 0
	call	__imulu
	ld	a, 4
	ld	c, a
	call	__ishrs
	push	ix
	lea	ix, ix - 128
	ld	(ix - 57), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 63)
	pop	ix
	lea	bc, iy + 0
	call	__imulu
	ld	c, a
	call	__ishrs
	ld	de, -191
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	jr	.LBB6_124
	.local	.LBB6_123
.LBB6_123:
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 57)
	pop	ix
	ld	(ix - 53), hl
	ld	a, (ix - 51)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	(ix - 50), iy
	ld	a, (ix - 48)
	rlc	a
	sbc	a, a
	ld	d, a
	lea	bc, iy + 0
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 4
	call	__lshru
	push	ix
	lea	ix, ix - 128
	ld	(ix - 57), bc
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 63)
	pop	ix
	ld	(ix - 47), hl
	ld	a, (ix - 45)
	rlc	a
	sbc	a, a
	ld	e, a
	lea	bc, iy + 0
	ld	a, d
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 4
	call	__lshru
	ld	de, -191
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), bc
	.local	.LBB6_124
.LBB6_124:
	ld	l, 1
	ld	de, -236
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)
	and	a, l
	ld	l, a
	ld	de, -254
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), l
	ld	bc, 0
	push	bc
	pop	hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 57
	ld	de, (iy + 0)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	push	bc
	pop	hl
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 63)
	pop	ix
	or	a, a
	sbc	hl, de
	push	ix
	lea	ix, ix - 128
	ld	a, (ix - 70)                    ; 1-byte Folded Reload
	pop	ix
	cp	a, -1
	push	ix
	lea	ix, ix - 128
	ld	(ix - 114), iy
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 83)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 101), bc
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 54)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 63), de
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 48)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 57), de
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 86)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 104), de
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 120), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 117), hl
	pop	ix
	ld	bc, -205
	lea	hl, ix + 0
	push	af
	add	hl, bc
	pop	af
	ld	de, (hl)
	jp	z, .LBB6_146
; %bb.125:
	ld	de, -268
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	ld	de, -197
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	add	hl, hl
	ex	de, hl
	ld	hl, _sector_ceiling
	add	hl, de
	ld	bc, (hl)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 69
	ld	(iy + 0), bc
	ld	a, b
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, c
	ld	iyh, b
	ld	hl, _sector_floor
	add	hl, de
	ld	bc, (hl)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	(ix - 101), bc
	pop	ix
	ld	e, c
	ld	d, b
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 69)
	pop	ix
                                        ; kill: def $hl killed $hl killed $uhl
	push	ix
	lea	ix, ix - 128
	lea	ix, ix - 128
	lea	ix, ix - 3
	ld	c, (ix + 0)
	ld	b, (ix + 1)
	pop	ix
	or	a, a
	sbc.sis	hl, bc
	lea	bc, iy + 0
	push	ix
	lea	ix, ix - 128
	ld	(ix - 63), iy
	pop	ix
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 57
	ld	(iy + 0), de
	ld	de, -229
	jp	nz, .LBB6_128
; %bb.126:
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
                                        ; kill: def $hl killed $hl killed $uhl
	ld	bc, -239
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)
	ld	d, (iy + 1)
	or	a, a
	sbc.sis	hl, de
	ld	de, -211
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	ld	de, -229
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	(iy + 0), hl
	ld	de, -179
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 74)
	pop	ix
	push	hl
	pop	bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 92
	ld	de, (iy + 0)
	jp	nz, .LBB6_132
; %bb.127:
	ld	de, -268
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	de, -242
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	ld	de, -211
	lea	hl, ix + 0
	add	hl, de
	ld	bc, (hl)
	ld	de, -229
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 86)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 104), hl
	pop	ix
	ld	bc, -248
	lea	hl, ix + 0
	add	hl, bc
	ld	de, (hl)
	ld	bc, -245
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), de
	ld	bc, -205
	lea	hl, ix + 0
	add	hl, bc
	ld	de, (hl)
	jp	.LBB6_146
	.local	.LBB6_128
.LBB6_128:
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	push	bc
	pop	hl
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 92)
	pop	ix
	or	a, a
	sbc	hl, de
	ex	de, hl
	push	ix
	ld	bc, -265
	add	ix, bc
	ld	hl, (ix + 0)
	pop	ix
	ld	bc, 32768
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB6_130
; %bb.129:
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 51)
	pop	ix
	call	__imulu
	ld	c, 4
	call	__ishrs
	push	hl
	pop	bc
	jr	.LBB6_131
	.local	.LBB6_130
.LBB6_130:
	ld	(ix - 44), de
	ld	a, (ix - 42)
	rlc	a
	sbc	a, a
	ld	bc, -232
	lea	hl, ix + 0
	add	hl, bc
	ld	(hl), a                         ; 1-byte Folded Spill
	push	ix
	lea	ix, ix - 128
	ld	bc, (ix - 51)
	pop	ix
	ld	(ix - 41), bc
	ld	a, (ix - 39)
	rlc	a
	sbc	a, a
	ex	de, hl
	push	ix
	lea	ix, ix - 128
	ld	e, (ix - 104)                   ; 1-byte Folded Reload
	pop	ix
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 4
	call	__lshru
	.local	.LBB6_131
.LBB6_131:
	lea	de, iy + 0
	ld	hl, 10240
	or	a, a
	sbc	hl, bc
	ld	bc, -229
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	l, e
	ld	h, d
	ld	bc, -239
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)
	ld	d, (iy + 1)
	or	a, a
	sbc.sis	hl, de
	ld	de, -214
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	hl, (iy + 0)
	ld	de, -232
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	(iy + 0), hl
	ld	de, -179
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	bc, (iy + 0)
	ld	de, -202
	lea	hl, ix + 0
	push	af
	add	hl, de
	pop	af
	ld	iy, (hl)
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 92)
	pop	ix
	jp	z, .LBB6_136
	.local	.LBB6_132
.LBB6_132:
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 57
	ld	hl, (iy + 0)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	push	ix
	ld	de, -265
	add	ix, de
	ld	hl, (ix + 0)
	pop	ix
	ld	de, 32768
	or	a, a
	sbc	hl, de
	ld	de, -239
	lea	hl, ix + 0
	push	af
	add	hl, de
	pop	af
	ld	(hl), iy
	jr	nc, .LBB6_134
; %bb.133:
	lea	hl, iy + 0
	call	__imulu
	ld	c, 4
	call	__ishrs
	push	hl
	pop	bc
	jr	.LBB6_135
	.local	.LBB6_134
.LBB6_134:
	ld	(ix - 38), iy
	ld	a, (ix - 36)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	(ix - 35), bc
	ld	a, (ix - 33)
	rlc	a
	sbc	a, a
	lea	hl, iy + 0
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 4
	call	__lshru
	.local	.LBB6_135
.LBB6_135:
	ld	hl, 10240
	or	a, a
	sbc	hl, bc
	ld	de, -232
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -197
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
                                        ; kill: def $hl killed $hl killed $uhl
	ld	bc, -259
	lea	iy, ix + 0
	add	iy, bc
	ld	e, (iy + 0)
	ld	d, (iy + 1)
	or	a, a
	sbc.sis	hl, de
	ld	a, 0
	ld	de, -217
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	(iy + 0), a                     ; 1-byte Folded Spill
	ld	de, -268
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	bc, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 92
	ld	de, (iy + 0)
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 74)
	pop	ix
	jp	z, .LBB6_142
	.local	.LBB6_136
.LBB6_136:
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 63)
	pop	ix
	or	a, a
	sbc	hl, de
	ex	de, hl
	push	ix
	ld	bc, -262
	add	ix, bc
	ld	hl, (ix + 0)
	pop	ix
	ld	bc, 32768
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB6_138
; %bb.137:
	ex	de, hl
	lea	bc, iy + 0
	call	__imulu
	ld	c, 4
	call	__ishrs
	push	hl
	pop	bc
	jr	.LBB6_139
	.local	.LBB6_138
.LBB6_138:
	ld	(ix - 32), de
	ld	a, (ix - 30)
	rlc	a
	sbc	a, a
	ld	c, a
	ld	(ix - 29), iy
	ld	a, (ix - 27)
	rlc	a
	sbc	a, a
	ex	de, hl
	ld	e, c
	lea	bc, iy + 0
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 4
	call	__lshru
	.local	.LBB6_139
.LBB6_139:
	or	a, a
	sbc	hl, hl
	sbc	hl, bc
	push	hl
	pop	bc
	ld	de, -217
	lea	hl, ix + 0
	push	af
	add	hl, de
	pop	af
	bit	0, (hl)                         ; 1-byte Folded Reload
	jr	z, .LBB6_141
; %bb.140:
	ld	de, -248
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	de, -245
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 77
	ld	de, (iy + 0)
	push	bc
	pop	hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 83
	ld	bc, (iy + 0)
	push	ix
	ld	bc, -268
	add	ix, bc
	ld	iy, (ix + 0)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	(ix - 114), hl
	pop	ix
	jp	.LBB6_146
	.local	.LBB6_141
.LBB6_141:
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 57)
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	de, (ix - 92)
	pop	ix
	or	a, a
	sbc	hl, de
	push	ix
	lea	ix, ix - 128
	ld	(ix - 111), hl
	pop	ix
	.local	.LBB6_142
.LBB6_142:
	ld	de, -242
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), bc
	push	ix
	ld	de, -262
	add	ix, de
	ld	hl, (ix + 0)
	pop	ix
	ld	de, 32768
	or	a, a
	sbc	hl, de
	jr	nc, .LBB6_144
; %bb.143:
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 111)
	pop	ix
	lea	bc, iy + 0
	call	__imulu
	ld	c, 4
	call	__ishrs
	push	hl
	pop	bc
	jr	.LBB6_145
	.local	.LBB6_144
.LBB6_144:
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 111)
	pop	ix
	ld	(ix - 26), hl
	ld	a, (ix - 24)
	rlc	a
	sbc	a, a
	ld	e, a
	ld	(ix - 23), iy
	ld	a, (ix - 21)
	rlc	a
	sbc	a, a
	lea	bc, iy + 0
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 4
	call	__lshru
	.local	.LBB6_145
.LBB6_145:
	or	a, a
	sbc	hl, hl
	sbc	hl, bc
	ld	de, -245
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	bc, -205
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 83
	ld	bc, (iy + 0)
	ld	bc, -268
	lea	hl, ix + 0
	add	hl, bc
	ld	iy, (hl)
	.local	.LBB6_146
.LBB6_146:
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 74)
	pop	ix
	push	de
	pop	bc
	call	__imulu
	push	ix
	lea	ix, ix - 128
	ld	(ix - 69), hl
	pop	ix
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 107)
	pop	ix
	call	__imulu
	push	ix
	lea	ix, ix - 128
	ld	(ix - 74), hl
	pop	ix
	push	de
	pop	hl
	lea	bc, iy + 0
	call	__imulu
	ld	bc, -217
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	push	de
	pop	hl
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 120
	ld	bc, (iy + 0)
	call	__imulu
	ld	bc, -235
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	bc, -242
	lea	iy, ix + 0
	add	iy, bc
	ld	hl, (iy + 0)
	push	de
	pop	bc
	call	__imulu
	ld	de, -239
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	de, -245
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	call	__imulu
	ld	de, -242
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	hl, (_colormaps)
	ld	de, -220
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	ld	iy, _render_stats
	ld	hl, (iy)
	inc.sis	hl
	ld	(iy), l
	ld	(iy + 1), h
	ld	bc, -194
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	ld	hl, _sector_shades
	add	hl, de
	ld	a, (hl)
	or	a, a
	sbc	hl, hl
	ld	bc, -245
	lea	iy, ix + 0
	add	iy, bc
	ld	(iy + 0), hl
	ld	l, a
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 60
	ld	bc, (iy + 0)
	ld	(_d84_rw), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 98
	ld	bc, (iy + 0)
	ld	(_d84_rw+3), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 51
	ld	bc, (iy + 0)
	ld	(_d84_rw+6), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 69
	ld	bc, (iy + 0)
	ld	(_d84_rw+9), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 124
	ld	bc, (iy + 0)
	ld	(_d84_rw+12), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 74
	ld	bc, (iy + 0)
	ld	(_d84_rw+15), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 83
	ld	bc, (iy + 0)
	ld	(_d84_rw+18), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 89
	ld	bc, (iy + 0)
	ld	(_d84_rw+21), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 86
	ld	bc, (iy + 0)
	ld	(_d84_rw+24), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 107
	ld	bc, (iy + 0)
	ld	(_d84_rw+27), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 101
	ld	bc, (iy + 0)
	ld	(_d84_rw+30), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 111
	ld	bc, (iy + 0)
	ld	(_d84_rw+33), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 104
	ld	bc, (iy + 0)
	ld	(_d84_rw+36), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 114
	ld	bc, (iy + 0)
	ld	(_d84_rw+39), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 54
	ld	bc, (iy + 0)
	ld	(_d84_rw+42), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 48
	ld	bc, (iy + 0)
	ld	(_d84_rw+45), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 63
	ld	bc, (iy + 0)
	ld	(_d84_rw+48), bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 57
	ld	bc, (iy + 0)
	ld	(_d84_rw+51), bc
	ld	(_d84_rw+54), de
	ld	(_d84_rw+57), hl
	ld	de, -254
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	ld	(_d84_rw+60), a
	ld	de, -249
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	ld	(_d84_rw+61), a
	ld	hl, (ix + 9)
	ld	(_d84_rw+62), hl
	ld	de, -220
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	(_d84_rw+65), hl
	ld	hl, _cliptop
	ld	bc, -188
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	add	hl, de
	ld	de, -179
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	xor	a, a
	ld	(_d84_rw+68), a
	ld	hl, _d84_rw+68
	push	hl
	pop	iy
	inc	iy
	ld	bc, 59
	lea	de, iy + 0
	ldir
	ld	de, -179
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	(_d84_rw+99), hl
	ld	hl, _clipbottom
	ld	bc, -188
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	add	hl, de
	ld	(_d84_rw+102), hl
	ld	de, -182
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	ld	bc, -8388608
	add	iy, bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 63)
	pop	ix
	add	hl, bc
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
                                        ; kill: def $a killed $a
	sbc	a, a
	ld	l, a
	ld	de, -253
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)
	and	a, l
	ld	e, a
	ld	(_d84_rw+105), a
	push	ix
	lea	ix, ix - 128
	ld	iy, (ix - 57)
	pop	ix
	add	iy, bc
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 48)
	pop	ix
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	ccf
                                        ; kill: def $a killed $a
	sbc	a, a
	inc	a
	ld	(_d84_rw+106), a
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 77)
	pop	ix
	ld	a, l
	ld	(_d84_rw+112), a
	ld	bc, -208
	lea	hl, ix + 0
	push	af
	add	hl, bc
	pop	af
	bit	0, (hl)                         ; 1-byte Folded Reload
	jr	z, .LBB6_148
; %bb.147:
	call	_render_wire_columns
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB6_148
.LBB6_148:
	ld	bc, -236
	lea	hl, ix + 0
	push	af
	add	hl, bc
	pop	af
	bit	0, (hl)                         ; 1-byte Folded Reload
	jp	z, .LBB6_159
; %bb.149:
	ld	iy, (ix + 9)
	ld	l, (iy + 2)
	ld	de, -198
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	cp	a, d
	ld	bc, 0
	jr	z, .LBB6_152
; %bb.150:
	ld	a, l
	cp	a, -1
	jr	nz, .LBB6_152
; %bb.151:
	ld	iy, (ix + 9)
	ld	l, (iy + 3)
	.local	.LBB6_152
.LBB6_152:
	lea	iy, ix + 0
	add	iy, de
	ld	a, (iy + 0)                     ; 1-byte Folded Reload
	cp	a, -1
	jr	z, .LBB6_155
; %bb.153:
	ld	a, l
	cp	a, -1
	jr	nz, .LBB6_155
; %bb.154:
	ld	iy, (ix + 9)
	ld	l, (iy + 4)
	.local	.LBB6_155
.LBB6_155:
	ld	c, l
	ld	a, l
	cp	a, -1
	jr	z, .LBB6_158
; %bb.156:
	ld	iy, (ix + 9)
	bit	4, (iy + 5)
	jr	z, .LBB6_158
; %bb.157:
	push	bc
	pop	de
	ld	bc, 3
	push	de
	pop	hl
	call	__imulu
	push	hl
	pop	bc
	ld	iy, _tile_info
	add	iy, bc
	ld	hl, 1
	ld	c, (iy + 2)
	call	__ishl
	push	de
	pop	bc
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 48
	ld	de, (iy + 0)
	add	hl, de
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	.local	.LBB6_158
.LBB6_158:
	ld	iy, (ix + 9)
	ld	de, (iy + 8)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	push	hl
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	push	bc
	pea	ix - 20
	call	_wall_style
	ld	hl, 12
	add	hl, sp
	ld	sp, hl
	ld	hl, (ix - 20)
	ld	de, (ix - 17)
	ld	bc, (ix - 14)
	ld	(_d84_rw+68), hl
	ld	(_d84_rw+71), de
	ld	iy, _d84_rw+68
	jp	.LBB6_169
	.local	.LBB6_159
.LBB6_159:
	bit	0, e
	jp	z, .LBB6_165
; %bb.160:
	ld	de, -188
	lea	hl, ix + 0
	add	hl, de
	ld	(hl), iy
	ld	hl, (ix + 9)
	push	hl
	pop	iy
	ld	a, (iy + 3)
	or	a, a
	sbc	hl, hl
	ld	l, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 51), hl
	pop	ix
	bit	3, (iy + 5)
	ld	de, -182
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	bc, (iy + 0)
	jr	nz, .LBB6_164
; %bb.161:
	cp	a, -1
	jr	z, .LBB6_163
; %bb.162:
	ld	bc, 3
	ld	de, -179
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	call	__imulu
	push	hl
	pop	bc
	ld	iy, _tile_info
	add	iy, bc
	ld	hl, 1
	ld	c, (iy + 2)
	call	__ishl
	ld	de, -223
	lea	iy, ix + 0
	add	iy, de
	ld	(iy + 0), hl
	.local	.LBB6_163
.LBB6_163:
	ld	de, -223
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	ld	bc, -191
	lea	iy, ix + 0
	add	iy, bc
	ld	de, (iy + 0)
	add	hl, de
	push	hl
	pop	bc
	.local	.LBB6_164
.LBB6_164:
	ld	iy, (ix + 9)
	ld	de, (iy + 8)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	push	hl
	push	bc
	ld	de, -179
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	pea	ix - 20
	call	_wall_style
	ld	hl, 12
	add	hl, sp
	ld	sp, hl
	ld	hl, (ix - 20)
	ld	de, (ix - 17)
	ld	bc, (ix - 14)
	ld	(_d84_rw+76), hl
	ld	(_d84_rw+79), de
	ld	iy, _d84_rw+76
	lea	hl, iy + 6
	ld	(hl), c
	inc	hl
	ld	(hl), b
	ld	de, -188
	lea	hl, ix + 0
	add	hl, de
	ld	iy, (hl)
	.local	.LBB6_165
.LBB6_165:
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 48)
	pop	ix
	ld	de, -8388608
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	nc, .LBB6_170
; %bb.166:
	ld	iy, (ix + 9)
	ld	a, (iy + 4)
	push	ix
	lea	ix, ix - 128
	ld	hl, (ix - 117)
	pop	ix
	ld	l, a
	push	ix
	lea	ix, ix - 128
	ld	(ix - 117), hl
	pop	ix
	bit	4, (iy + 5)
	ld	de, -185
	lea	iy, ix + 0
	push	af
	add	iy, de
	pop	af
	ld	bc, (iy + 0)
	jr	z, .LBB6_168
; %bb.167:
	ld	de, -182
	lea	iy, ix + 0
	add	iy, de
	ld	bc, (iy + 0)
	.local	.LBB6_168
.LBB6_168:
	ld	iy, (ix + 9)
	ld	de, (iy + 8)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	push	hl
	push	bc
	ld	de, -245
	lea	iy, ix + 0
	add	iy, de
	ld	hl, (iy + 0)
	push	hl
	pea	ix - 20
	call	_wall_style
	ld	hl, 12
	add	hl, sp
	ld	sp, hl
	ld	hl, (ix - 20)
	ld	de, (ix - 17)
	ld	bc, (ix - 14)
	ld	(_d84_rw+84), hl
	ld	(_d84_rw+87), de
	ld	iy, _d84_rw+84
	.local	.LBB6_169
.LBB6_169:
	lea	hl, iy + 6
	ld	(hl), c
	inc	hl
	ld	(hl), b
	.local	.LBB6_170
.LBB6_170:
	ld	a, (_player+31)
	bit	0, a
	ld	bc, -199
	lea	iy, ix + 0
	push	af
	add	iy, bc
	pop	af
	ld	e, (iy + 0)                     ; 1-byte Folded Reload
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 66
	ld	bc, (iy + 0)
	jr	nz, .LBB6_172
; %bb.171:
	ld	hl, _engine_view+2
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 128
	lea	iy, iy - 1
	ld	(iy + 0), hl
	.local	.LBB6_172
.LBB6_172:
	lea	iy, ix + 0
	lea	iy, iy - 128
	lea	iy, iy - 128
	lea	iy, iy - 1
	ld	hl, (iy + 0)
	ld	(_d84_rw+107), hl
	bit	0, a
	jr	z, .LBB6_174
; %bb.173:
	ld	l, -128
	ld	a, e
	or	a, l
	ld	l, a
	jr	.LBB6_175
	.local	.LBB6_174
.LBB6_174:
	ld	hl, _plane_colors
	push	hl
	pop	iy
	add	iy, bc
	ld	l, (iy + 85)
	ld	e, (iy)
	.local	.LBB6_175
.LBB6_175:
	ld	a, l
	ld	(_d84_rw+110), a
	ld	a, e
	ld	(_d84_rw+111), a
	call	_render_columns
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end6
.Lfunc_end6:
	.size	_d84_draw_seg, .Lfunc_end6-_d84_draw_seg
                                        ; -- End function
	.section	.text._render_wire_columns,"ax",@progbits
	.type	_render_wire_columns,@function  ; -- Begin function render_wire_columns
_render_wire_columns:                   ; @render_wire_columns
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 73
	ld	sp, hl
	ld	a, (_d84_rw+60)
	bit	0, a
	jr	nz, .LBB7_2
; %bb.1:
	ld	l, -60
	jr	.LBB7_3
	.local	.LBB7_2
.LBB7_2:
	ld	l, 4
	.local	.LBB7_3
.LBB7_3:
	ld	(ix - 44), l
	ld	bc, (_d84_rw)
	ld	iy, (_d84_rw+3)
	ld	de, -8388608
	add	iy, de
	push	bc
	pop	hl
	add	hl, de
	ld	(ix - 24), iy
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	nc, .LBB7_106
; %bb.4:
	ld	(ix - 48), a                    ; 1-byte Folded Spill
	ld	hl, (_d84_rw+36)
	ld	(ix - 12), hl
	ld	hl, (_d84_rw+30)
	ld	(ix - 15), hl
	ld	hl, (_d84_rw+24)
	ld	(ix - 3), hl
	ld	hl, (_d84_rw+18)
	ld	(ix - 6), hl
	ld	de, (_d84_rw+6)
	ld	a, (_d84_rw+105)
	ld	(ix - 53), a                    ; 1-byte Folded Spill
	ld	a, (_d84_rw+106)
	ld	(ix - 54), a                    ; 1-byte Folded Spill
	ld	a, (_d84_rw+112)
	or	a, a
	sbc	hl, hl
	ld	(ix - 52), a                    ; 1-byte Folded Spill
	ld	l, a
	ld	(ix - 28), hl
	ld	hl, (_d84_rw+9)
	ld	(ix - 31), hl
	ld	hl, (_d84_rw+21)
	ld	(ix - 34), hl
	ld	hl, (_d84_rw+27)
	ld	(ix - 37), hl
	ld	hl, (_d84_rw+33)
	ld	(ix - 40), hl
	ld	hl, (_d84_rw+39)
	ld	(ix - 43), hl
	ld	(ix - 51), bc
	.local	.LBB7_5
.LBB7_5:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB7_67 Depth 2
                                        ;     Child Loop BB7_78 Depth 2
                                        ;     Child Loop BB7_35 Depth 2
                                        ;     Child Loop BB7_96 Depth 2
	ld	(ix - 18), de
	ld	hl, _cliptop
	push	hl
	pop	iy
	add	iy, bc
	ld	a, (iy)
	ld	hl, _clipbottom
	ld	(ix - 9), bc
	add	hl, bc
	ld	l, (hl)
	ld	(ix - 21), a                    ; 1-byte Folded Spill
	ld	(ix - 25), l                    ; 1-byte Folded Spill
	cp	a, l
	jp	nc, .LBB7_98
; %bb.6:                                ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, (ix - 18)
	ld	bc, -8388608
	add	hl, bc
	ld	de, -8388607
	or	a, a
	sbc	hl, de
	jp	c, .LBB7_98
; %bb.7:                                ;   in Loop: Header=BB7_5 Depth=1
	ld	(ix - 68), iy
	ld	iy, (ix - 6)
	lea	hl, iy + 0
	add	hl, bc
	or	a, a
	sbc	hl, de
	ld	e, 0
	ld	a, e
	jr	c, .LBB7_10
; %bb.8:                                ;   in Loop: Header=BB7_5 Depth=1
	lea	hl, iy + 0
	ld	de, 20480
	or	a, a
	sbc	hl, de
	ld	a, d
	jr	nc, .LBB7_10
; %bb.9:                                ;   in Loop: Header=BB7_5 Depth=1
	ld	a, iyh
	.local	.LBB7_10
.LBB7_10:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	(ix - 58), a
	ld	de, (ix - 3)
	push	de
	pop	hl
	add	hl, bc
	ld	bc, -8388607
	or	a, a
	sbc	hl, bc
	ld	iyl, b
	jr	c, .LBB7_13
; %bb.11:                               ;   in Loop: Header=BB7_5 Depth=1
	push	de
	pop	hl
	ld	bc, 20480
	or	a, a
	sbc	hl, bc
	ld	a, b
	ld	iyl, a
	jr	nc, .LBB7_13
; %bb.12:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	iyl, d
	.local	.LBB7_13
.LBB7_13:                               ;   in Loop: Header=BB7_5 Depth=1
	or	a, a
	sbc	hl, hl
	ld	a, (ix - 58)                    ; 1-byte Folded Reload
	ld	l, a
	ld	(ix - 64), hl
	ld	l, (ix - 21)
	cp	a, l
	jr	c, .LBB7_18
; %bb.14:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	l, (ix - 25)
	cp	a, l
	jr	nc, .LBB7_18
; %bb.15:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, (ix - 9)
	ld	de, 128
	or	a, a
	sbc	hl, de
	ld	a, (ix - 58)                    ; 1-byte Folded Reload
	jr	nc, .LBB7_18
; %bb.16:                               ;   in Loop: Header=BB7_5 Depth=1
	cp	a, 80
	jr	nc, .LBB7_18
; %bb.17:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, (ix - 64)
	ld	c, 7
	call	__ishl
	ld	bc, (ix - 9)
	call	__ior
	push	hl
	pop	bc
	ld	hl, _engine_view+2
	add	hl, bc
	ld	a, (ix - 44)
	ld	(hl), a
	.local	.LBB7_18
.LBB7_18:                               ;   in Loop: Header=BB7_5 Depth=1
	or	a, a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ex	de, hl
	ld	(ix - 47), hl
	ld	a, (ix - 21)                    ; 1-byte Folded Reload
	cp	a, iyl
	jr	nc, .LBB7_23
; %bb.19:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, (ix - 25)                    ; 1-byte Folded Reload
	cp	a, iyl
	jr	c, .LBB7_23
; %bb.20:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, (ix - 9)
	ld	de, 128
	or	a, a
	sbc	hl, de
	jr	nc, .LBB7_23
; %bb.21:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	bc, (ix - 47)
	dec	bc
	push	bc
	pop	hl
	ld	de, 80
	or	a, a
	sbc	hl, de
	jr	nc, .LBB7_23
; %bb.22:                               ;   in Loop: Header=BB7_5 Depth=1
	push	bc
	pop	hl
	ld	c, 7
	call	__ishl
	ld	bc, (ix - 9)
	call	__ior
	push	hl
	pop	bc
	ld	hl, _engine_view+2
	add	hl, bc
	ld	a, (ix - 44)
	ld	(hl), a
	.local	.LBB7_23
.LBB7_23:                               ;   in Loop: Header=BB7_5 Depth=1
	or	a, a
	sbc	hl, hl
	push	hl
	pop	de
	ld	e, (ix - 21)                    ; 1-byte Folded Reload
	ld	(ix - 57), de
	ld	l, (ix - 25)                    ; 1-byte Folded Reload
	ld	(ix - 61), hl
	bit	0, (ix - 48)                    ; 1-byte Folded Reload
	jp	z, .LBB7_39
; %bb.24:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, (ix - 9)
	push	hl
	pop	iy
	ld	de, (ix - 28)
	add	iy, de
	ld	bc, (ix - 51)
	or	a, a
	sbc	hl, bc
	jr	z, .LBB7_26
; %bb.25:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	bc, -8388608
	add	iy, bc
	lea	hl, iy + 0
	ld	bc, (ix - 24)
	or	a, a
	sbc	hl, bc
	jp	c, .LBB7_38
	.local	.LBB7_26
.LBB7_26:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	bc, (ix - 64)
	push	bc
	pop	hl
	ld	de, (ix - 57)
	or	a, a
	sbc	hl, de
	jr	c, .LBB7_28
; %bb.27:                               ;   in Loop: Header=BB7_5 Depth=1
	push	bc
	pop	de
	.local	.LBB7_28
.LBB7_28:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	(ix - 21), de
	ld	de, (ix - 61)
	dec	de
	ld	iy, (ix - 47)
	dec	iy
	ld	(ix - 47), iy
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	push	de
	pop	hl
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	push	de
	pop	bc
	jr	c, .LBB7_30
; %bb.29:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	bc, (ix - 47)
	.local	.LBB7_30
.LBB7_30:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	iy, (ix - 21)
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	ld	(ix - 47), bc
	push	bc
	pop	hl
	add	hl, de
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jr	c, .LBB7_38
; %bb.31:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, (ix - 9)
	ld	de, 128
	or	a, a
	sbc	hl, de
	jr	nc, .LBB7_38
; %bb.32:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	iy, (ix - 21)
	lea	hl, iy + 0
	ld	de, (ix - 47)
	or	a, a
	sbc	hl, de
	jr	c, .LBB7_34
; %bb.33:                               ;   in Loop: Header=BB7_5 Depth=1
	lea	de, iy + 0
	.local	.LBB7_34
.LBB7_34:                               ;   in Loop: Header=BB7_5 Depth=1
	inc	de
	ld	(ix - 47), de
	lea	hl, iy + 0
	ld	c, 7
	call	__ishl
	push	hl
	pop	bc
	ld	hl, (ix - 9)
	add	hl, bc
	push	hl
	pop	bc
	lea	hl, iy + 0
	ld	iy, _engine_view+2
	add	iy, bc
	push	hl
	pop	bc
	.local	.LBB7_35
.LBB7_35:                               ;   Parent Loop BB7_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	push	bc
	pop	hl
	ld	de, 80
	or	a, a
	sbc	hl, de
	jr	nc, .LBB7_37
; %bb.36:                               ;   in Loop: Header=BB7_35 Depth=2
	ld	a, (ix - 44)
	ld	(iy), a
	.local	.LBB7_37
.LBB7_37:                               ;   in Loop: Header=BB7_35 Depth=2
	inc	bc
	ld	de, 128
	add	iy, de
	ld	hl, (ix - 47)
	or	a, a
	sbc	hl, bc
	jr	nz, .LBB7_35
	.local	.LBB7_38
.LBB7_38:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, _cliptop
	ld	de, (ix - 9)
	add	hl, de
	ld	a, (ix - 25)                    ; 1-byte Folded Reload
	ld	(hl), a
	ld	(ix - 21), a                    ; 1-byte Folded Spill
	ld	a, (ix - 52)                    ; 1-byte Folded Reload
	cp	a, 2
	jp	nc, .LBB7_94
	jp	.LBB7_98
	.local	.LBB7_39
.LBB7_39:                               ;   in Loop: Header=BB7_5 Depth=1
	push	af
	ld	a, iyl
	ld	(ix - 70), a                    ; 1-byte Folded Spill
	pop	af
	ld	iy, (ix - 15)
	lea	hl, iy + 0
	ld	bc, -8388608
	add	hl, bc
	ld	de, -8388607
	or	a, a
	sbc	hl, de
	ld	a, b
	jr	c, .LBB7_42
; %bb.40:                               ;   in Loop: Header=BB7_5 Depth=1
	lea	hl, iy + 0
	ld	de, 20480
	or	a, a
	sbc	hl, de
	ld	a, d
	jr	nc, .LBB7_42
; %bb.41:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, iyh
	.local	.LBB7_42
.LBB7_42:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	(ix - 65), a
	ld	de, (ix - 12)
	push	de
	pop	hl
	add	hl, bc
	push	de
	pop	bc
	ld	de, -8388607
	or	a, a
	sbc	hl, de
	ld	iyl, d
	jr	c, .LBB7_45
; %bb.43:                               ;   in Loop: Header=BB7_5 Depth=1
	push	bc
	pop	hl
	ld	de, 20480
	or	a, a
	sbc	hl, de
	ld	iyl, d
	jr	nc, .LBB7_45
; %bb.44:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	iyl, b
	.local	.LBB7_45
.LBB7_45:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, (ix - 53)                    ; 1-byte Folded Reload
	or	a, a
	ld	hl, (ix - 9)
	ld	bc, (ix - 57)
	jr	z, .LBB7_51
; %bb.46:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, (ix - 65)                    ; 1-byte Folded Reload
	ld	e, (ix - 21)
	cp	a, e
	jr	c, .LBB7_51
; %bb.47:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, (ix - 65)                    ; 1-byte Folded Reload
	ld	e, (ix - 25)
	cp	a, e
	jr	nc, .LBB7_51
; %bb.48:                               ;   in Loop: Header=BB7_5 Depth=1
	push	hl
	pop	bc
	ld	de, 128
	or	a, a
	sbc	hl, de
	push	bc
	pop	hl
	ld	bc, (ix - 57)
	jr	nc, .LBB7_51
; %bb.49:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, (ix - 65)                    ; 1-byte Folded Reload
	cp	a, 80
	jr	nc, .LBB7_51
; %bb.50:                               ;   in Loop: Header=BB7_5 Depth=1
	or	a, a
	sbc	hl, hl
	ld	l, (ix - 65)                    ; 1-byte Folded Reload
	ld	c, 7
	call	__ishl
	ld	bc, (ix - 9)
	call	__ior
	push	hl
	pop	bc
	ld	hl, _engine_view+2
	add	hl, bc
	ld	bc, (ix - 57)
	ld	de, (ix - 9)
	ld	(hl), -60
	ex	de, hl
	.local	.LBB7_51
.LBB7_51:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, (ix - 54)                    ; 1-byte Folded Reload
	or	a, a
	jr	z, .LBB7_57
; %bb.52:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, iyl
	ld	e, (ix - 21)
	cp	a, e
	jr	c, .LBB7_57
; %bb.53:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, iyl
	ld	e, (ix - 25)
	cp	a, e
	jr	nc, .LBB7_57
; %bb.54:                               ;   in Loop: Header=BB7_5 Depth=1
	push	hl
	pop	bc
	ld	de, 128
	or	a, a
	sbc	hl, de
	push	bc
	pop	hl
	ld	bc, (ix - 57)
	jr	nc, .LBB7_57
; %bb.55:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, iyl
	cp	a, 80
	jr	nc, .LBB7_57
; %bb.56:                               ;   in Loop: Header=BB7_5 Depth=1
	or	a, a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ex	de, hl
	ld	c, 7
	call	__ishl
	ld	bc, (ix - 9)
	call	__ior
	push	hl
	pop	bc
	ld	hl, _engine_view+2
	add	hl, bc
	ld	bc, (ix - 57)
	ld	de, (ix - 9)
	ld	(hl), -60
	ex	de, hl
	.local	.LBB7_57
.LBB7_57:                               ;   in Loop: Header=BB7_5 Depth=1
	push	af
	ld	a, iyl
	ld	(ix - 69), a                    ; 1-byte Folded Spill
	pop	af
	push	hl
	pop	iy
	ld	de, (ix - 28)
	add	iy, de
	ld	de, (ix - 51)
	or	a, a
	sbc	hl, de
	ld	de, (ix - 47)
	jr	z, .LBB7_59
; %bb.58:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	bc, -8388608
	add	iy, bc
	lea	hl, iy + 0
	ld	bc, (ix - 24)
	or	a, a
	sbc	hl, bc
	ld	bc, (ix - 57)
	jp	c, .LBB7_81
	.local	.LBB7_59
.LBB7_59:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, (ix - 53)                    ; 1-byte Folded Reload
	or	a, a
	jp	z, .LBB7_70
; %bb.60:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	de, (ix - 64)
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jr	c, .LBB7_62
; %bb.61:                               ;   in Loop: Header=BB7_5 Depth=1
	push	de
	pop	bc
	.local	.LBB7_62
.LBB7_62:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	(ix - 73), bc
	ld	bc, (ix - 61)
	dec	bc
	ld	iy, 0
	push	af
	ld	a, (ix - 65)                    ; 1-byte Folded Reload
	ld	iyl, a
	pop	af
	dec	iy
	lea	de, iy + 0
	ex	de, hl
	ld	de, -8388608
	add	hl, de
	ex	de, hl
	ld	(ix - 64), bc
	push	bc
	pop	hl
	ld	bc, -8388608
	add	hl, bc
	or	a, a
	sbc	hl, de
	jr	c, .LBB7_64
; %bb.63:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	(ix - 64), iy
	.local	.LBB7_64
.LBB7_64:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	iy, (ix - 73)
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	ld	hl, (ix - 64)
	add	hl, bc
	ld	(ix - 64), hl
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	ld	hl, (ix - 9)
	ld	bc, (ix - 57)
	ld	de, (ix - 47)
	jr	c, .LBB7_70
; %bb.65:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	de, 128
	or	a, a
	sbc	hl, de
	ld	de, (ix - 47)
	jr	nc, .LBB7_70
; %bb.66:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, (ix - 73)
	ld	c, 7
	call	__ishl
	push	hl
	pop	bc
	ld	hl, (ix - 9)
	add	hl, bc
	push	hl
	pop	bc
	ld	iy, _engine_view+2
	add	iy, bc
	.local	.LBB7_67
.LBB7_67:                               ;   Parent Loop BB7_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	hl, (ix - 73)
	push	hl
	pop	bc
	ld	de, 80
	or	a, a
	sbc	hl, de
	jr	nc, .LBB7_69
; %bb.68:                               ;   in Loop: Header=BB7_67 Depth=2
	ld	a, (ix - 44)
	ld	(iy), a
	.local	.LBB7_69
.LBB7_69:                               ;   in Loop: Header=BB7_67 Depth=2
	ld	de, 2
	push	bc
	pop	hl
	add	hl, de
	ld	de, 256
	add	iy, de
	ld	(ix - 73), hl
	ld	bc, -8388608
	add	hl, bc
	push	hl
	pop	bc
	ld	hl, (ix - 64)
	or	a, a
	sbc	hl, bc
	ld	bc, (ix - 57)
	ld	de, (ix - 47)
	jr	nc, .LBB7_67
	.local	.LBB7_70
.LBB7_70:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, (ix - 54)                    ; 1-byte Folded Reload
	or	a, a
	jp	z, .LBB7_81
; %bb.71:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, (ix - 69)                    ; 1-byte Folded Reload
	ld	l, (ix - 21)                    ; 1-byte Folded Reload
	cp	a, l
	jr	c, .LBB7_73
; %bb.72:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	l, a
	.local	.LBB7_73
.LBB7_73:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, l
	ld	iy, (ix - 61)
	dec	iy
	dec	de
	ld	(ix - 47), de
	push	de
	pop	bc
	ld	hl, -8388608
	ex	de, hl
	push	bc
	pop	hl
	add	hl, de
	push	hl
	pop	bc
	lea	hl, iy + 0
	add	hl, de
	or	a, a
	sbc	hl, bc
	jr	c, .LBB7_75
; %bb.74:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	iy, (ix - 47)
	.local	.LBB7_75
.LBB7_75:                               ;   in Loop: Header=BB7_5 Depth=1
	or	a, a
	sbc	hl, hl
	ld	l, a
	ld	(ix - 47), hl
	push	hl
	pop	bc
	ld	hl, -8388608
	ex	de, hl
	push	bc
	pop	hl
	add	hl, de
	push	hl
	pop	bc
	add	iy, de
	ld	(ix - 61), iy
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	ld	hl, (ix - 9)
	ld	bc, (ix - 57)
	jr	c, .LBB7_81
; %bb.76:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	de, 128
	or	a, a
	sbc	hl, de
	jr	nc, .LBB7_81
; %bb.77:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, (ix - 47)
	ld	c, 7
	call	__ishl
	push	hl
	pop	bc
	ld	hl, (ix - 9)
	add	hl, bc
	push	hl
	pop	bc
	ld	iy, _engine_view+2
	add	iy, bc
	.local	.LBB7_78
.LBB7_78:                               ;   Parent Loop BB7_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	hl, (ix - 47)
	push	hl
	pop	bc
	ld	de, 80
	or	a, a
	sbc	hl, de
	jr	nc, .LBB7_80
; %bb.79:                               ;   in Loop: Header=BB7_78 Depth=2
	ld	a, (ix - 44)
	ld	(iy), a
	.local	.LBB7_80
.LBB7_80:                               ;   in Loop: Header=BB7_78 Depth=2
	ld	de, 2
	push	bc
	pop	hl
	add	hl, de
	ld	de, 256
	add	iy, de
	ld	(ix - 47), hl
	ld	bc, -8388608
	add	hl, bc
	push	hl
	pop	bc
	ld	hl, (ix - 61)
	or	a, a
	sbc	hl, bc
	ld	bc, (ix - 57)
	jr	nc, .LBB7_78
	.local	.LBB7_81
.LBB7_81:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, (ix - 65)                    ; 1-byte Folded Reload
	ld	e, (ix - 58)                    ; 1-byte Folded Reload
	cp	a, e
	jr	c, .LBB7_83
; %bb.82:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	e, a
	.local	.LBB7_83
.LBB7_83:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, e
	ld	d, (ix - 21)                    ; 1-byte Folded Reload
	cp	a, d
	ld	iy, (ix - 68)
	jp	nc, .LBB7_99
; %bb.84:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, (ix - 21)                    ; 1-byte Folded Reload
	cp	a, e
	jp	c, .LBB7_100
	.local	.LBB7_85
.LBB7_85:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	e, (ix - 25)                    ; 1-byte Folded Reload
	ld	a, c
	cp	a, e
	jr	c, .LBB7_87
	.local	.LBB7_86
.LBB7_86:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	d, e
	.local	.LBB7_87
.LBB7_87:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	(iy), d
	ld	l, (ix - 70)                    ; 1-byte Folded Reload
	ld	a, l
	ld	c, (ix - 69)                    ; 1-byte Folded Reload
	cp	a, c
	jp	nc, .LBB7_101
; %bb.88:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, e
	cp	a, l
	ld	c, e
	jp	nc, .LBB7_102
	.local	.LBB7_89
.LBB7_89:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, d
	cp	a, c
	ld	l, c
	jp	nc, .LBB7_103
	.local	.LBB7_90
.LBB7_90:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	a, d
	cp	a, c
	jp	nc, .LBB7_104
	.local	.LBB7_91
.LBB7_91:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	(ix - 21), d                    ; 1-byte Folded Spill
	ld	a, l
	cp	a, e
	jr	c, .LBB7_93
	.local	.LBB7_92
.LBB7_92:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	c, e
	.local	.LBB7_93
.LBB7_93:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, _clipbottom
	ld	de, (ix - 9)
	add	hl, de
	ld	(hl), c
	ld	(ix - 25), c                    ; 1-byte Folded Spill
	ld	a, (ix - 52)                    ; 1-byte Folded Reload
	cp	a, 2
	jr	c, .LBB7_98
	.local	.LBB7_94
.LBB7_94:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, (ix - 9)
	ld	bc, -8388608
	add	hl, bc
	ld	de, -8388481
	or	a, a
	sbc	hl, de
	jr	nc, .LBB7_98
; %bb.95:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, _clipbottom+1
	ld	de, (ix - 9)
	add	hl, de
	ld	(ix - 47), hl
	ld	hl, _cliptop+1
	add	hl, de
	ld	(ix - 57), hl
	ld	bc, 0
	.local	.LBB7_96
.LBB7_96:                               ;   Parent Loop BB7_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	hl, (ix - 57)
	add	hl, bc
	ld	a, (ix - 21)
	ld	(hl), a
	ld	hl, (ix - 47)
	add	hl, bc
	ld	a, (ix - 25)
	ld	(hl), a
	push	bc
	pop	hl
	ld	de, 2
	add	hl, de
	ld	iy, (ix - 9)
	add	iy, bc
	add	iy, de
	ld	de, (ix - 28)
	or	a, a
	sbc	hl, de
	jr	nc, .LBB7_98
; %bb.97:                               ;   in Loop: Header=BB7_96 Depth=2
	inc	bc
	ld	de, -8388608
	add	iy, de
	lea	hl, iy + 0
	ld	de, -8388480
	or	a, a
	sbc	hl, de
	jr	c, .LBB7_96
	.local	.LBB7_98
.LBB7_98:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	hl, (ix - 9)
	ld	de, (ix - 28)
	add	hl, de
	push	hl
	pop	bc
	ld	iy, (ix - 31)
	ld	de, (ix - 18)
	add	iy, de
	ld	hl, (ix - 6)
	ld	de, (ix - 34)
	add	hl, de
	ld	(ix - 6), hl
	ld	hl, (ix - 3)
	ld	de, (ix - 37)
	add	hl, de
	ld	(ix - 3), hl
	ld	hl, (ix - 15)
	ld	de, (ix - 40)
	add	hl, de
	ld	(ix - 15), hl
	ld	hl, (ix - 12)
	ld	de, (ix - 43)
	add	hl, de
	ld	(ix - 12), hl
	push	bc
	pop	hl
	ld	de, -8388608
	add	hl, de
	ld	de, (ix - 24)
	or	a, a
	sbc	hl, de
	lea	de, iy + 0
	jr	nc, .LBB7_105
	jp	.LBB7_5
	.local	.LBB7_99
.LBB7_99:                               ;   in Loop: Header=BB7_5 Depth=1
	ld	d, e
	ld	a, (ix - 21)                    ; 1-byte Folded Reload
	cp	a, e
	jp	nc, .LBB7_85
	.local	.LBB7_100
.LBB7_100:                              ;   in Loop: Header=BB7_5 Depth=1
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, d
	ld	e, (ix - 25)                    ; 1-byte Folded Reload
	ld	a, c
	cp	a, e
	jp	nc, .LBB7_86
	jp	.LBB7_87
	.local	.LBB7_101
.LBB7_101:                              ;   in Loop: Header=BB7_5 Depth=1
	ld	l, c
	ld	a, e
	cp	a, l
	ld	c, e
	jp	c, .LBB7_89
	.local	.LBB7_102
.LBB7_102:                              ;   in Loop: Header=BB7_5 Depth=1
	ld	c, l
	ld	a, d
	cp	a, c
	ld	l, c
	jp	c, .LBB7_90
	.local	.LBB7_103
.LBB7_103:                              ;   in Loop: Header=BB7_5 Depth=1
	ld	l, d
	ld	a, d
	cp	a, c
	jp	c, .LBB7_91
	.local	.LBB7_104
.LBB7_104:                              ;   in Loop: Header=BB7_5 Depth=1
	ld	c, d
	ld	(ix - 21), d                    ; 1-byte Folded Spill
	ld	a, l
	cp	a, e
	jp	nc, .LBB7_92
	jp	.LBB7_93
	.local	.LBB7_105
.LBB7_105:
	ld	(_d84_rw+6), iy
	ld	hl, (ix - 6)
	ld	(_d84_rw+18), hl
	ld	hl, (ix - 3)
	ld	(_d84_rw+24), hl
	ld	hl, (ix - 15)
	ld	(_d84_rw+30), hl
	ld	hl, (ix - 12)
	ld	(_d84_rw+36), hl
	.local	.LBB7_106
.LBB7_106:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end7
.Lfunc_end7:
	.size	_render_wire_columns, .Lfunc_end7-_render_wire_columns
                                        ; -- End function
	.section	.text._wall_style,"ax",@progbits
	.type	_wall_style,@function           ; -- Begin function wall_style
_wall_style:                            ; @wall_style
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 4
	ld	sp, hl
	ld	iy, (ix + 6)
	ld	de, (ix + 9)
	ld	bc, 0
	ld.sis	hl, 0
	ld	(iy), bc
	ld	(iy + 3), bc
	ld	(iy + 6), l
	ld	(iy + 7), h
	ld	bc, 255
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jp	z, .LBB8_4
; %bb.1:
	ld	bc, 3
	ex	de, hl
	call	__imulu
	ex	de, hl
	ld	hl, _images
	add	hl, de
	ld	hl, (hl)
	ld	(iy), hl
	ld	iy, _tile_info
	add	iy, de
	ld	a, (iy + 1)
	lea	bc, iy + 0
	ld	e, -5
	add	a, e
	ld	l, a
	ld	iy, (ix + 6)
	ld	(iy + 6), l
	push	bc
	pop	iy
	ld	a, (iy + 2)
	add	a, e
	ld	l, a
	ld	(ix - 1), l
	ld	iy, (ix + 6)
	ld	(iy + 7), l
	ld	hl, _player+8
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	ld	de, (ix + 12)
	ld	hl, (ix + 15)
	add	hl, de
	or	a, a
	sbc	hl, bc
	ld	c, 8
	call	__ishl
	push	hl
	pop	iy
	ld	e, (ix - 1)                     ; 1-byte Folded Reload
	ld	c, e
	call	__ishrs
	ld	(ix - 4), hl
	or	a, a
	sbc	hl, hl
	ld	a, l
	sub	a, e
	ld	c, a
	lea	hl, iy + 0
	call	__ishl
	ld	a, e
	add	a, -128
	cp	a, -128
	jr	c, .LBB8_3
; %bb.2:
	ld	hl, (ix - 4)
	.local	.LBB8_3
.LBB8_3:
	ld	iy, (ix + 6)
	ld	(iy + 3), hl
	.local	.LBB8_4
.LBB8_4:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end8
.Lfunc_end8:
	.size	_wall_style, .Lfunc_end8-_wall_style
                                        ; -- End function
	.section	.text._render_columns,"ax",@progbits
	.type	_render_columns,@function       ; -- Begin function render_columns
_render_columns:                        ; @render_columns
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 45
	ld	sp, hl
	ld	a, (_player+32)
	bit	0, a
	jr	z, .LBB9_2
; %bb.1:
	call	_render_wire_columns
	jp	.LBB9_87
	.local	.LBB9_2
.LBB9_2:
	ld	hl, (_d84_rw)
	ld	iy, (_d84_rw+3)
	ld	de, -8388608
	add	iy, de
	push	hl
	pop	bc
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	nc, .LBB9_87
; %bb.3:
	ld	hl, (_d84_rw+6)
	ld	(ix - 6), hl
	push	bc
	pop	de
	.local	.LBB9_4
.LBB9_4:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB9_21 Depth 2
                                        ;     Child Loop BB9_18 Depth 2
                                        ;     Child Loop BB9_32 Depth 2
                                        ;     Child Loop BB9_27 Depth 2
                                        ;     Child Loop BB9_77 Depth 2
	ld	hl, _cliptop
	push	hl
	pop	iy
	add	iy, de
	ld	a, (iy)
	ld	hl, _clipbottom
	add	hl, de
	ld	(ix - 16), hl
	ld	l, (hl)
	ld	(ix - 10), a                    ; 1-byte Folded Spill
	ld	(ix - 7), l                     ; 1-byte Folded Spill
	cp	a, l
	jr	nc, .LBB9_6
; %bb.5:                                ;   in Loop: Header=BB9_4 Depth=1
	ld	hl, (ix - 6)
	ld	bc, -8388608
	add	hl, bc
	ld	(ix - 3), de
	ld	de, -8388607
	or	a, a
	sbc	hl, de
	ld	de, (ix - 3)
	jr	nc, .LBB9_7
	.local	.LBB9_6
.LBB9_6:                                ;   in Loop: Header=BB9_4 Depth=1
	ld	hl, (_render_detail)
	jp	.LBB9_82
	.local	.LBB9_7
.LBB9_7:                                ;   in Loop: Header=BB9_4 Depth=1
	ld	hl, (_d84_rw+18)
	push	hl
	pop	bc
	ld	de, -8388608
	add	hl, de
	inc	de
	or	a, a
	sbc	hl, de
	ld	a, d
	ld	(ix - 17), a                    ; 1-byte Folded Spill
	jr	c, .LBB9_10
; %bb.8:                                ;   in Loop: Header=BB9_4 Depth=1
	push	bc
	pop	hl
	ld	de, 20480
	or	a, a
	sbc	hl, de
	ld	a, d
	ld	(ix - 17), a                    ; 1-byte Folded Spill
	jr	nc, .LBB9_10
; %bb.9:                                ;   in Loop: Header=BB9_4 Depth=1
	ld	a, b
	ld	(ix - 17), a
	.local	.LBB9_10
.LBB9_10:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	(ix - 42), iy
	ld	iy, 0
	lea	bc, iy + 0
	push	bc
	pop	hl
	ld	l, (ix - 7)                     ; 1-byte Folded Reload
	ld	(ix - 24), hl
	ld	iy, (_d84_rw+24)
	lea	hl, iy + 0
	ld	de, -8388608
	add	hl, de
	inc	de
	or	a, a
	sbc	hl, de
	ld	a, d
	jr	c, .LBB9_13
; %bb.11:                               ;   in Loop: Header=BB9_4 Depth=1
	lea	hl, iy + 0
	ld	de, 20480
	or	a, a
	sbc	hl, de
	ld	a, d
	jr	nc, .LBB9_13
; %bb.12:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, iyh
	.local	.LBB9_13
.LBB9_13:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	(ix - 18), a
	ld	iy, (ix - 24)
	dec	iy
	push	bc
	pop	hl
	ld	l, (ix - 17)                    ; 1-byte Folded Reload
	ld	(ix - 39), hl
	dec	hl
	ld	(ix - 13), hl
	push	hl
	pop	bc
	ld	hl, -8388608
	ex	de, hl
	push	bc
	pop	hl
	add	hl, de
	push	hl
	pop	bc
	lea	hl, iy + 0
	add	hl, de
	ld	(ix - 33), hl
	or	a, a
	sbc	hl, bc
	ld	(ix - 21), iy
	lea	de, iy + 0
	jr	c, .LBB9_15
; %bb.14:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	de, (ix - 13)
	.local	.LBB9_15
.LBB9_15:                               ;   in Loop: Header=BB9_4 Depth=1
	or	a, a
	sbc	hl, hl
	push	hl
	pop	iy
	push	af
	ld	a, (ix - 10)                    ; 1-byte Folded Reload
	ld	iyl, a
	pop	af
	ld	hl, (_d84_rw+54)
	ld	(ix - 27), hl
	ld	(ix - 30), l                    ; 1-byte Folded Spill
	ld	(ix - 13), iy
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	push	de
	pop	hl
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	c, .LBB9_22
; %bb.16:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, (_player+31)
	bit	0, a
	jr	z, .LBB9_19
; %bb.17:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	l, -128
	ld	a, (ix - 30)
	or	a, l
	ld	l, a
	ld	hl, (ix - 13)
	ld	c, 7
	call	__ishl
	push	hl
	pop	bc
	ld	hl, (ix - 3)
	add	hl, bc
	push	hl
	pop	bc
	ld	iy, _planes
	add	iy, bc
	inc	de
	ex	de, hl
	ld	de, (ix - 13)
	or	a, a
	sbc	hl, de
	ex	de, hl
	.local	.LBB9_18
.LBB9_18:                               ;   Parent Loop BB9_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	(iy), a
	ld	bc, 128
	add	iy, bc
	dec	de
	sbc	hl, hl
	adc	hl, de
	jr	nz, .LBB9_18
	jr	.LBB9_22
	.local	.LBB9_19
.LBB9_19:                               ;   in Loop: Header=BB9_4 Depth=1
	push	de
	pop	hl
	ld	bc, (ix - 13)
	or	a, a
	sbc	hl, bc
	inc	hl
	ld	(ix - 36), hl
	ld	hl, (ix - 27)
	ld	bc, 127
	call	__iand
	push	hl
	pop	bc
	ld	iy, _plane_colors
	add	iy, bc
	ld	hl, (ix - 36)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jr	z, .LBB9_22
; %bb.20:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, (iy + 85)
	ld	hl, (ix - 13)
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _row_offsets
	add	hl, bc
	ld	hl, (hl)
	ld	bc, 0
	ld	c, l
	ld	b, h
	ld	iy, _engine_view+2
	add	iy, bc
	ld	bc, (ix - 3)
	add	iy, bc
	ld	bc, (ix - 13)
	dec	bc
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	.local	.LBB9_21
.LBB9_21:                               ;   Parent Loop BB9_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	(iy), a
	ld	de, 128
	add	iy, de
	ld	de, 1
	add	hl, de
	jr	nc, .LBB9_21
	.local	.LBB9_22
.LBB9_22:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	bc, 0
	ld	c, (ix - 18)                    ; 1-byte Folded Reload
	push	bc
	pop	hl
	ld	de, (ix - 13)
	or	a, a
	sbc	hl, de
	jr	c, .LBB9_24
; %bb.23:                               ;   in Loop: Header=BB9_4 Depth=1
	push	bc
	pop	de
	.local	.LBB9_24
.LBB9_24:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	(ix - 36), bc
	ld	a, e
	ld	l, (ix - 7)
	cp	a, l
	ld	bc, -8388608
	jp	nc, .LBB9_33
; %bb.25:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, (_player+31)
	bit	0, a
	jr	z, .LBB9_28
; %bb.26:                               ;   in Loop: Header=BB9_4 Depth=1
	push	de
	pop	hl
	ld	c, 7
	call	__ishl
	push	hl
	pop	bc
	ld	hl, (ix - 3)
	add	hl, bc
	push	hl
	pop	bc
	ld	iy, _planes
	add	iy, bc
	ld	hl, (ix - 24)
	or	a, a
	sbc	hl, de
	ex	de, hl
	ld	bc, -8388608
	.local	.LBB9_27
.LBB9_27:                               ;   Parent Loop BB9_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	a, (ix - 30)
	ld	(iy), a
	push	bc
	pop	hl
	ld	bc, 128
	add	iy, bc
	push	hl
	pop	bc
	dec	de
	sbc	hl, hl
	adc	hl, de
	jr	nz, .LBB9_27
	jr	.LBB9_33
	.local	.LBB9_28
.LBB9_28:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	hl, (ix - 21)
	or	a, a
	sbc	hl, de
	inc	hl
	ld	(ix - 45), hl
	ld	hl, (ix - 27)
	ld	bc, 127
	call	__iand
	push	hl
	pop	bc
	ld	a, (ix - 30)                    ; 1-byte Folded Reload
	add	a, -128
	cp	a, -128
	ld	hl, 0
	jr	nc, .LBB9_30
; %bb.29:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	hl, 85
	.local	.LBB9_30
.LBB9_30:                               ;   in Loop: Header=BB9_4 Depth=1
	add	hl, bc
	push	hl
	pop	bc
	ld	iy, _plane_colors
	add	iy, bc
	ld	hl, (ix - 45)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	ld	bc, -8388608
	jr	z, .LBB9_33
; %bb.31:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, (iy)
	push	de
	pop	hl
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _row_offsets
	add	hl, bc
	ld	hl, (hl)
	ld	bc, 0
	ld	c, l
	ld	b, h
	ld	iy, _engine_view+2
	add	iy, bc
	ld	bc, -8388608
	push	bc
	pop	hl
	ld	bc, (ix - 3)
	add	iy, bc
	push	hl
	pop	bc
	ex	de, hl
	ld	de, (ix - 24)
	or	a, a
	sbc	hl, de
	.local	.LBB9_32
.LBB9_32:                               ;   Parent Loop BB9_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	(iy), a
	ld	de, 128
	add	iy, de
	ld	de, 1
	add	hl, de
	jr	nc, .LBB9_32
	.local	.LBB9_33
.LBB9_33:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, (_d84_rw+60)
	bit	0, a
	jr	z, .LBB9_39
; %bb.34:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	bc, (ix - 39)
	push	bc
	pop	hl
	ld	de, (ix - 13)
	or	a, a
	sbc	hl, de
	jr	c, .LBB9_36
; %bb.35:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	(ix - 13), bc
	.local	.LBB9_36
.LBB9_36:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	bc, (ix - 36)
	dec	bc
	push	bc
	pop	iy
	ld	de, -8388608
	add	iy, de
	ld	hl, (ix - 33)
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jr	c, .LBB9_38
; %bb.37:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	(ix - 21), bc
	.local	.LBB9_38
.LBB9_38:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	hl, (_d84_rw+12)
	ld	de, (ix - 27)
	push	de
	push	hl
	ld	hl, (ix - 6)
	push	hl
	ld	hl, _d84_rw+68
	push	hl
	ld	hl, (ix - 21)
	push	hl
	ld	hl, (ix - 13)
	push	hl
	ld	hl, (ix - 3)
	push	hl
	call	_d84_wall_column
	ld	hl, 21
	add	hl, sp
	ld	sp, hl
	ld	hl, (ix - 16)
	ld	b, (hl)
	ld	hl, _cliptop
	ld	de, (ix - 3)
	add	hl, de
	ld	(hl), b
	ld	(ix - 7), b                     ; 1-byte Folded Spill
	ld	(ix - 6), b                     ; 1-byte Folded Spill
	jp	.LBB9_74
	.local	.LBB9_39
.LBB9_39:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	iy, (_d84_rw+30)
	lea	hl, iy + 0
	add	hl, bc
	ld	de, -8388607
	or	a, a
	sbc	hl, de
	ld	a, d
	ld	(ix - 16), a                    ; 1-byte Folded Spill
	jr	c, .LBB9_42
; %bb.40:                               ;   in Loop: Header=BB9_4 Depth=1
	lea	hl, iy + 0
	ld	de, 20480
	or	a, a
	sbc	hl, de
	ld	a, d
	ld	(ix - 16), a                    ; 1-byte Folded Spill
	jr	nc, .LBB9_42
; %bb.41:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, iyh
	ld	(ix - 16), a
	.local	.LBB9_42
.LBB9_42:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	iy, (_d84_rw+36)
	lea	hl, iy + 0
	add	hl, bc
	ld	de, -8388607
	or	a, a
	sbc	hl, de
	ld	a, d
	jr	c, .LBB9_45
; %bb.43:                               ;   in Loop: Header=BB9_4 Depth=1
	lea	hl, iy + 0
	ld	de, 20480
	or	a, a
	sbc	hl, de
	ld	a, d
	jr	nc, .LBB9_45
; %bb.44:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, iyh
	.local	.LBB9_45
.LBB9_45:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	(ix - 24), a
	ld	hl, (_d84_rw+48)
	ld	iy, (_d84_rw+42)
	ld	bc, -8388608
	add	iy, bc
	add	hl, bc
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jr	nc, .LBB9_52
; %bb.46:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, (_d84_rw+61)
	bit	0, a
	jr	nz, .LBB9_52
; %bb.47:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	bc, (ix - 39)
	push	bc
	pop	hl
	ld	de, (ix - 13)
	or	a, a
	sbc	hl, de
	jr	c, .LBB9_49
; %bb.48:                               ;   in Loop: Header=BB9_4 Depth=1
	push	bc
	pop	de
	.local	.LBB9_49
.LBB9_49:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	(ix - 30), de
	ld	bc, 0
	ld	c, (ix - 16)                    ; 1-byte Folded Reload
	dec	bc
	push	bc
	pop	iy
	ld	de, -8388608
	add	iy, de
	ld	hl, (ix - 33)
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	ld	hl, (ix - 21)
	jr	c, .LBB9_51
; %bb.50:                               ;   in Loop: Header=BB9_4 Depth=1
	push	bc
	pop	hl
	.local	.LBB9_51
.LBB9_51:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	de, (_d84_rw+12)
	ld	bc, (ix - 27)
	push	bc
	push	de
	ld	de, (ix - 6)
	push	de
	ld	de, _d84_rw+76
	push	de
	push	hl
	ld	hl, (ix - 30)
	push	hl
	ld	hl, (ix - 3)
	push	hl
	call	_d84_wall_column
	ld	hl, 21
	add	hl, sp
	ld	sp, hl
	ld	bc, -8388608
	.local	.LBB9_52
.LBB9_52:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	iy, (_d84_rw+51)
	ld	hl, (_d84_rw+45)
	add	iy, bc
	add	hl, bc
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jr	nc, .LBB9_58
; %bb.53:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, (ix - 24)                    ; 1-byte Folded Reload
	ld	l, (ix - 10)                    ; 1-byte Folded Reload
	cp	a, l
	ld	de, 0
	jr	c, .LBB9_55
; %bb.54:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	l, a
	.local	.LBB9_55
.LBB9_55:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	e, l
	ld	iy, (ix - 36)
	dec	iy
	lea	hl, iy + 0
	add	hl, bc
	push	hl
	pop	bc
	ld	hl, (ix - 33)
	or	a, a
	sbc	hl, bc
	jr	c, .LBB9_57
; %bb.56:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	(ix - 21), iy
	.local	.LBB9_57
.LBB9_57:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	iy, (_d84_rw+6)
	ld	bc, (_d84_rw+12)
	ld	hl, (_d84_rw+54)
	push	hl
	push	bc
	push	iy
	ld	hl, _d84_rw+84
	push	hl
	ld	hl, (ix - 21)
	push	hl
	push	de
	ld	hl, (ix - 3)
	push	hl
	call	_d84_wall_column
	ld	hl, 21
	add	hl, sp
	ld	sp, hl
	.local	.LBB9_58
.LBB9_58:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, (ix - 16)                    ; 1-byte Folded Reload
	ld	l, (ix - 17)                    ; 1-byte Folded Reload
	cp	a, l
	ld	c, (ix - 7)                     ; 1-byte Folded Reload
	ld	de, 0
	push	af
	ld	a, (ix - 24)                    ; 1-byte Folded Reload
	ld	iyh, a
	pop	af
	jr	c, .LBB9_60
; %bb.59:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	l, a
	.local	.LBB9_60
.LBB9_60:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, l
	ld	b, (ix - 10)                    ; 1-byte Folded Reload
	cp	a, b
	ld	(ix - 6), b                     ; 1-byte Folded Spill
	jr	c, .LBB9_62
; %bb.61:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	(ix - 6), l                     ; 1-byte Folded Spill
	.local	.LBB9_62
.LBB9_62:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, (ix - 10)                    ; 1-byte Folded Reload
	cp	a, l
	jr	c, .LBB9_64
; %bb.63:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	de, (ix - 13)
	jr	.LBB9_65
	.local	.LBB9_64
.LBB9_64:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	e, (ix - 6)                     ; 1-byte Folded Reload
	.local	.LBB9_65
.LBB9_65:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, e
	cp	a, c
	jr	c, .LBB9_67
; %bb.66:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	(ix - 6), c                     ; 1-byte Folded Spill
	.local	.LBB9_67
.LBB9_67:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	hl, (ix - 42)
	ld	a, (ix - 6)
	ld	(hl), a
	ld	l, (ix - 18)                    ; 1-byte Folded Reload
	ld	a, l
	cp	a, iyh
	jp	nc, .LBB9_83
; %bb.68:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, c
	cp	a, l
	ld	e, c
	jp	nc, .LBB9_84
	.local	.LBB9_69
.LBB9_69:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, (ix - 6)                     ; 1-byte Folded Reload
	cp	a, e
	ld	l, e
	jp	nc, .LBB9_85
	.local	.LBB9_70
.LBB9_70:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, (ix - 6)                     ; 1-byte Folded Reload
	cp	a, e
	jp	nc, .LBB9_86
	.local	.LBB9_71
.LBB9_71:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	a, l
	cp	a, c
	jr	c, .LBB9_73
	.local	.LBB9_72
.LBB9_72:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	e, c
	.local	.LBB9_73
.LBB9_73:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	hl, _clipbottom
	ld	bc, (ix - 3)
	add	hl, bc
	ld	(ix - 7), e                     ; 1-byte Folded Spill
	ld	(hl), e
	.local	.LBB9_74
.LBB9_74:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	bc, (_render_detail)
	push	bc
	pop	hl
	ld	de, 2
	or	a, a
	sbc	hl, de
	jr	c, .LBB9_80
; %bb.75:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	hl, (ix - 3)
	ld	de, -8388608
	add	hl, de
	ld	de, -8388481
	or	a, a
	sbc	hl, de
	jr	nc, .LBB9_80
; %bb.76:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	(ix - 10), bc
	ld	iy, _clipbottom+1
	ld	de, (ix - 3)
	add	iy, de
	ld	hl, _cliptop+1
	add	hl, de
	ld	de, 0
	ld	(ix - 13), iy
	ld	(ix - 16), hl
	.local	.LBB9_77
.LBB9_77:                               ;   Parent Loop BB9_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	add	hl, de
	ld	a, (ix - 6)                     ; 1-byte Folded Reload
	ld	(hl), a
	add	iy, de
	ld	c, (ix - 7)
	ld	(iy), c
	push	de
	pop	hl
	ld	bc, 2
	add	hl, bc
	ld	iy, (ix - 3)
	add	iy, de
	add	iy, bc
	ld	bc, (ix - 10)
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB9_80
; %bb.78:                               ;   in Loop: Header=BB9_77 Depth=2
	inc	de
	ld	bc, -8388608
	add	iy, bc
	lea	hl, iy + 0
	ld	bc, -8388480
	or	a, a
	sbc	hl, bc
	ld	iy, (ix - 13)
	ld	hl, (ix - 16)
	jr	c, .LBB9_77
; %bb.79:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	hl, (ix - 10)
	jr	.LBB9_81
	.local	.LBB9_80
.LBB9_80:                               ;   in Loop: Header=BB9_4 Depth=1
	push	bc
	pop	hl
	.local	.LBB9_81
.LBB9_81:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	de, (ix - 3)
	.local	.LBB9_82
.LBB9_82:                               ;   in Loop: Header=BB9_4 Depth=1
	add	hl, de
	ld	de, (_d84_rw+9)
	push	hl
	pop	bc
	ld	hl, (_d84_rw+6)
	add	hl, de
	ld	(ix - 6), hl
	ld	(_d84_rw+6), hl
	ld	de, (_d84_rw+15)
	ld	hl, (_d84_rw+12)
	add	hl, de
	ld	(_d84_rw+12), hl
	ld	de, (_d84_rw+21)
	ld	hl, (_d84_rw+18)
	add	hl, de
	ld	(_d84_rw+18), hl
	ld	de, (_d84_rw+27)
	ld	hl, (_d84_rw+24)
	add	hl, de
	ld	(_d84_rw+24), hl
	ld	de, (_d84_rw+33)
	ld	hl, (_d84_rw+30)
	add	hl, de
	ld	(_d84_rw+30), hl
	ld	de, (_d84_rw+39)
	ld	hl, (_d84_rw+36)
	add	hl, de
	ld	(_d84_rw+36), hl
	ld	iy, (_d84_rw+3)
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	push	bc
	pop	hl
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	push	bc
	pop	de
	jp	c, .LBB9_4
	jr	.LBB9_87
	.local	.LBB9_83
.LBB9_83:                               ;   in Loop: Header=BB9_4 Depth=1
	ex	de, hl
	ld	e, iyh
	ex	de, hl
	ld	a, c
	cp	a, l
	ld	e, c
	jp	c, .LBB9_69
	.local	.LBB9_84
.LBB9_84:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	e, l
	ld	a, (ix - 6)                     ; 1-byte Folded Reload
	cp	a, e
	ld	l, e
	jp	c, .LBB9_70
	.local	.LBB9_85
.LBB9_85:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	l, (ix - 6)                     ; 1-byte Folded Reload
	ld	a, (ix - 6)                     ; 1-byte Folded Reload
	cp	a, e
	jp	c, .LBB9_71
	.local	.LBB9_86
.LBB9_86:                               ;   in Loop: Header=BB9_4 Depth=1
	ld	e, (ix - 6)                     ; 1-byte Folded Reload
	ld	a, l
	cp	a, c
	jp	nc, .LBB9_72
	jp	.LBB9_73
	.local	.LBB9_87
.LBB9_87:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end9
.Lfunc_end9:
	.size	_render_columns, .Lfunc_end9-_render_columns
                                        ; -- End function
	.section	.text._d84_bbox_visible,"ax",@progbits
	.globl	_d84_bbox_visible               ; -- Begin function d84_bbox_visible
	.type	_d84_bbox_visible,@function
_d84_bbox_visible:                      ; @d84_bbox_visible
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 44
	ld	sp, hl
	ld	iy, (ix + 6)
	ld	bc, (_camx)
	ld	de, (iy + 4)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, -8388608
	ld	(ix - 5), bc
	push	bc
	pop	iy
	add	iy, de
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	ld	hl, 0
	jr	nc, .LBB10_2
; %bb.1:
	ld	iy, (ix + 6)
	ld	de, (iy + 6)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	ld	hl, (ix - 5)
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	sbc	hl, hl
	ld	de, 2
	add	hl, de
	.local	.LBB10_2
.LBB10_2:
	ld	(ix - 11), hl
	ld	bc, (_camy)
	ld	hl, (ix + 6)
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	iy
	ld	iyl, e
	ld	iyh, d
	ld	hl, -8388608
	ex	de, hl
	add	iy, de
	ld	(ix - 8), bc
	push	bc
	pop	hl
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	ld	hl, 0
	jr	nc, .LBB10_6
; %bb.3:
	ld	iy, (ix + 6)
	ld	de, (iy + 2)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	iy, (ix - 8)
	ld	de, -8388608
	add	iy, de
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jr	c, .LBB10_5
; %bb.4:
	ld	hl, 8
	jr	.LBB10_6
	.local	.LBB10_5
.LBB10_5:
	ld	hl, 4
	.local	.LBB10_6
.LBB10_6:
	ld	bc, (ix - 11)
	call	__ior
	push	hl
	pop	iy
	ld	de, 5
	or	a, a
	sbc	hl, de
	jr	nz, .LBB10_9
; %bb.7:
	ld	a, 1
	.local	.LBB10_8
.LBB10_8:
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB10_9
.LBB10_9:
	ld	hl, (ix + 9)
	ld	bc, _box_points
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	push	bc
	pop	hl
	add	hl, de
	push	hl
	pop	bc
	add	iy, iy
	lea	de, iy + 0
	ld	hl, _d84_bbox_visible.corners
	add	hl, de
	ld	(ix - 11), hl
	ld	a, (hl)
	ld	de, 0
	push	de
	pop	hl
	push	de
	pop	iy
	ld	l, a
	add	hl, hl
	ex	de, hl
	ld	(ix - 14), bc
	push	bc
	pop	hl
	add	hl, de
	ld	hl, (hl)
	lea	de, iy + 0
	lea	bc, iy + 0
	ld	(ix - 17), hl
	ld	e, l
	ld	d, h
	ld	iy, (ix - 11)
	ld	a, (iy + 1)
	push	bc
	pop	iy
	lea	hl, iy + 0
	ld	l, a
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, (ix - 14)
	add	hl, bc
	ld	hl, (hl)
	ld	(ix - 29), hl
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	ld	hl, _vertex_stamp
	add	hl, de
	ld	(ix - 44), hl
	ld	a, (hl)
	ld	l, -2
	and	a, l
	ld	l, a
	ld	a, (_frame_stamp)
	ld	h, a
	ld	a, l
	ld	(ix - 11), h                    ; 1-byte Folded Spill
	cp	a, h
	ld	(ix - 23), iy
	ld	(ix - 26), de
	jr	nz, .LBB10_11
; %bb.10:
	ex	de, hl
	add	hl, hl
	ex	de, hl
	ld	(ix - 14), de
	ld	hl, _vertex_side
	add	hl, de
	ld	de, (hl)
	ld	hl, _vertex_depth
	ld	bc, (ix - 14)
	add	hl, bc
	lea	bc, iy + 0
	ld	iy, (hl)
	jp	.LBB10_14
	.local	.LBB10_11
.LBB10_11:
	ld	iy, (_map_vertices)
	ex	de, hl
	add	hl, hl
	add	hl, hl
	push	hl
	pop	bc
	add	iy, bc
	lea	de, iy + 0
	ld	iy, _extra_points
	add	iy, bc
	ld	bc, -1868
	add	iy, bc
	ld	hl, (ix - 17)
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	bc, 467
	or	a, a
	sbc.sis	hl, bc
	jr	c, .LBB10_13
; %bb.12:
	lea	de, iy + 0
	.local	.LBB10_13
.LBB10_13:
	push	de
	pop	iy
	ld	de, (iy)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, (ix - 5)
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	(ix - 17), bc
	ld	de, (iy + 2)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, (ix - 8)
	or	a, a
	sbc	hl, de
	ex	de, hl
	ld	(ix - 32), de
	ld	hl, (_camsin)
	ld	(ix - 14), hl
	call	__imulu
	ld	(ix - 20), hl
	ld	iy, (_camcos)
	lea	hl, iy + 0
	push	de
	pop	bc
	call	__imulu
	push	hl
	pop	bc
	ld	hl, (ix - 20)
	or	a, a
	sbc	hl, bc
	ld	a, 8
	ld	c, a
	call	__ishru
	ex	de, hl
	ld	(ix - 20), de
	ld	hl, _d84_rotated
	ld	(hl), e
	inc	hl
	ld	(hl), d
	lea	hl, iy + 0
	ld	bc, (ix - 17)
	call	__imulu
	push	hl
	pop	iy
	ld	hl, (ix - 32)
	ld	bc, (ix - 14)
	call	__imulu
	ex	de, hl
	add	iy, de
	lea	hl, iy + 0
	ld	c, a
	call	__ishru
	ex	de, hl
	ld	hl, _d84_rotated+2
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	hl, (ix - 26)
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _vertex_side
	add	hl, bc
	push	bc
	pop	iy
	ld	bc, (ix - 20)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	ld	hl, _vertex_depth
	lea	bc, iy + 0
	add	hl, bc
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	iy, _vertex_stamp
	lea	hl, iy + 0
	push	de
	pop	iy
	ld	de, (ix - 20)
	ld	bc, (ix - 26)
	add	hl, bc
	ld	a, (ix - 11)
	ld	(hl), a
	ld	bc, (ix - 23)
	.local	.LBB10_14
.LBB10_14:
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	(ix - 20), de
	ld	l, e
	ld	h, d
	ld	(ix - 17), hl
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	ld	(ix - 38), iy
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	(ix - 14), hl
	ld	hl, _vertex_stamp
	add	hl, bc
	ld	(ix - 41), hl
	ld	a, (hl)
	ld	l, -2
	and	a, l
	ld	l, a
	ld	l, (ix - 11)
	cp	a, l
	jr	nz, .LBB10_16
; %bb.15:
	push	bc
	pop	hl
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _vertex_side
	add	hl, bc
	ld	iy, (hl)
	ld	hl, _vertex_depth
	add	hl, bc
	ld	bc, (hl)
	jp	.LBB10_19
	.local	.LBB10_16
.LBB10_16:
	ld	iy, (_map_vertices)
	push	bc
	pop	hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	add	iy, de
	lea	bc, iy + 0
	ld	iy, _extra_points
	add	iy, de
	ld	de, -1868
	add	iy, de
	ld	hl, (ix - 29)
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	de, 467
	or	a, a
	sbc.sis	hl, de
	jr	c, .LBB10_18
; %bb.17:
	lea	bc, iy + 0
	.local	.LBB10_18
.LBB10_18:
	push	bc
	pop	iy
	ld	de, (iy)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, (ix - 5)
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	ld	(ix - 29), bc
	ld	de, (iy + 2)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	de, (ix - 8)
	or	a, a
	sbc	hl, de
	ex	de, hl
	ld	hl, (_camsin)
	ld	(ix - 5), hl
	call	__imulu
	ld	(ix - 8), hl
	ld	iy, (_camcos)
	lea	hl, iy + 0
	push	de
	pop	bc
	call	__imulu
	push	hl
	pop	bc
	ld	hl, (ix - 8)
	or	a, a
	sbc	hl, bc
	ld	a, 8
	ld	c, a
	call	__ishru
	push	hl
	pop	bc
	ld	(ix - 8), bc
	ld	hl, _d84_rotated
	ld	(hl), c
	inc	hl
	ld	(hl), b
	lea	hl, iy + 0
	ld	bc, (ix - 29)
	call	__imulu
	push	hl
	pop	iy
	ex	de, hl
	ld	bc, (ix - 5)
	call	__imulu
	ex	de, hl
	add	iy, de
	lea	hl, iy + 0
	ld	iy, (ix - 8)
	ld	c, a
	call	__ishru
	push	hl
	pop	bc
	ld	hl, _d84_rotated+2
	ld	(hl), c
	inc	hl
	ld	(hl), b
	ld	hl, (ix - 23)
	add	hl, hl
	ex	de, hl
	ld	hl, _vertex_side
	add	hl, de
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld	hl, _vertex_depth
	add	hl, de
	ld	(hl), c
	inc	hl
	ld	(hl), b
	ld	hl, _vertex_stamp
	ld	de, (ix - 23)
	add	hl, de
	ld	a, (ix - 11)
	ld	(hl), a
	.local	.LBB10_19
.LBB10_19:
	ex	de, hl
	ld	e, iyh
	ex	de, hl
	rlc	l
	sbc	hl, hl
	ld	(ix - 8), iy
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	(ix - 5), hl
	ld	l, b
	rlc	l
	sbc	hl, hl
	ex	de, hl
	ld	(ix - 35), bc
	ld	e, c
	ld	d, b
	ld	iy, (ix - 14)
	lea	hl, iy + 0
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	lea	hl, iy + 0
	add	hl, bc
	call	__ixor
	ld	a, 6
	ld	c, a
	call	__ishru
	ld	(ix - 29), hl
	push	de
	pop	hl
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	ld	(ix - 11), de
	ex	de, hl
	add	hl, bc
	call	__ixor
	ld	c, a
	call	__ishru
	ld	(ix - 32), hl
	lea	bc, iy + 0
	ld	iy, (ix - 17)
	add	iy, bc
	ld	hl, -2
	ld	de, (ix - 29)
	or	a, a
	sbc	hl, de
	ld	bc, -8388608
	add	hl, bc
	ex	de, hl
	add	iy, bc
	lea	hl, iy + 0
	ld	(ix - 29), de
	or	a, a
	sbc	hl, de
	jr	nc, .LBB10_22
; %bb.20:
	ld	de, (ix - 11)
	ld	iy, (ix - 5)
	add	iy, de
	ld	hl, -2
	ld	de, (ix - 32)
	or	a, a
	sbc	hl, de
	add	hl, bc
	ex	de, hl
	add	iy, bc
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	jr	nc, .LBB10_22
; %bb.21:
	xor	a, a
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB10_22
.LBB10_22:
	ld	iy, (ix - 5)
	ld	hl, (ix - 14)
	ld	de, (ix - 17)
	or	a, a
	sbc	hl, de
	add	hl, bc
	ld	de, (ix - 29)
	or	a, a
	sbc	hl, de
	jr	nc, .LBB10_25
; %bb.23:
	ld	hl, (ix - 11)
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	ld	(ix - 5), hl
	ld	hl, -2
	ld	de, (ix - 32)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	add	iy, bc
	ld	hl, (ix - 5)
	add	hl, bc
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jr	nc, .LBB10_25
; %bb.24:
	xor	a, a
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB10_25
.LBB10_25:
	ld.sis	bc, -32768
	ld	hl, (ix - 38)
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	add.sis	iy, bc
	ld.sis	de, -32764
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	or	a, a
	sbc.sis	hl, de
	jp	c, .LBB10_27
; %bb.26:
	ld	hl, (ix - 35)
                                        ; kill: def $hl killed $hl killed $uhl
	add.sis	hl, bc
	ld	(ix - 17), l
	ld	(ix - 16), h
	or	a, a
	sbc.sis	hl, de
	jp	nc, .LBB10_28
	.local	.LBB10_27
.LBB10_27:
	ld	hl, (ix - 35)
	add.sis	hl, bc
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, de
	ccf
                                        ; kill: def $a killed $a
	sbc	a, a
	ld	c, a
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	or	a, a
	sbc.sis	hl, de
	ccf
                                        ; kill: def $a killed $a
	sbc	a, a
	or	a, c
	ld	l, a
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB10_28
.LBB10_28:
	ld	c, 1
	ld.sis	de, 32
	ld	iy, (ix - 38)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	or	a, a
	sbc.sis	hl, de
	ld.sis	de, 17
	jr	nc, .LBB10_31
; %bb.29:
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	or	a, a
	sbc.sis	hl, de
	jp	nc, .LBB10_39
; %bb.30:
	ld	bc, 3
	ld	hl, (ix - 14)
	call	__imulu
	ex	de, hl
	ld	hl, _small_reciprocals
	add	hl, de
	ld	de, (hl)
	jp	.LBB10_40
	.local	.LBB10_31
.LBB10_31:
	ld	hl, (ix - 44)
	ld	e, (hl)
	ld	a, e
	and	a, c
	ld	l, a
	bit	0, l
	ld	bc, -8388608
	ld	iy, (ix - 20)
	jp	nz, .LBB10_41
; %bb.32:
	ld	(ix - 5), e                     ; 1-byte Folded Spill
	ld.sis	de, 2049
	ld	hl, (ix - 38)
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, de
	jp	c, .LBB10_42
; %bb.33:
	ld	de, 0
	.local	.LBB10_34
.LBB10_34:                              ; =>This Inner Loop Header: Depth=1
	ld	bc, (ix - 14)
	push	bc
	pop	hl
	call	__ishru_1
	ld	(ix - 14), hl
	inc	de
	push	bc
	pop	hl
	push	de
	pop	iy
	ld	de, 4098
	or	a, a
	sbc	hl, de
	lea	de, iy + 0
	jr	nc, .LBB10_34
; %bb.35:
	ld	iy, 34
	push	bc
	pop	hl
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB10_43
; %bb.36:
	ld	iy, (ix - 14)
	lea	hl, iy + 0
	ld	bc, 2
	or	a, a
	sbc	hl, bc
	lea	hl, iy + 0
	ld	iy, (ix - 20)
	jr	nc, .LBB10_38
; %bb.37:
	ld	hl, 1
	.local	.LBB10_38
.LBB10_38:
	ld	bc, 3
	call	__imulu
	push	hl
	pop	bc
	ld	hl, _small_reciprocals
	add	hl, bc
	ld	hl, (hl)
	ld	(ix - 14), hl
	jp	.LBB10_45
	.local	.LBB10_39
.LBB10_39:
	ld	hl, (ix - 14)
	add	hl, hl
	ex	de, hl
	ld	hl, _reciprocal_table
	add	hl, de
	ld	hl, (hl)
	xor	a, a
	ld	(ix - 2), a
	ld	de, (ix - 4)
	ld	d, h
	ld	e, l
	.local	.LBB10_40
.LBB10_40:
	or	a, a
	sbc	hl, hl
	ld	a, l
	ld	(ix - 5), a
	ld	iy, (ix - 20)
	ld	a, iyh
	ld	l, a
	rlc	l
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	rlc	a
	sbc	a, a
	ex	de, hl
	ld	e, (ix - 5)                     ; 1-byte Folded Reload
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 14
	call	__lshrs
	push	bc
	pop	hl
	ld	de, 64
	add	hl, de
	ld	(ix - 5), hl
	ld	bc, -8388608
	jp	.LBB10_47
	.local	.LBB10_41
.LBB10_41:
	ld	hl, (ix - 26)
	add	hl, hl
	ex	de, hl
	ld	hl, _vertex_screen
	add	hl, de
	ld	iy, (hl)
	jp	.LBB10_46
	.local	.LBB10_42
.LBB10_42:
	ld	de, 0
	ld	hl, (ix - 14)
	jr	.LBB10_44
	.local	.LBB10_43
.LBB10_43:
	ld	hl, (ix - 14)
	ld	iy, (ix - 20)
	.local	.LBB10_44
.LBB10_44:
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _reciprocal_table
	add	hl, bc
	ld	hl, (hl)
	ld	bc, 0
	ld	c, l
	ld	b, h
	ld	(ix - 14), bc
	.local	.LBB10_45
.LBB10_45:
	ld	a, iyh
	ld	l, a
	rlc	l
	sbc	hl, hl
	lea	bc, iy + 0
	push	hl
	pop	iy
	ld	iyl, c
	ld	iyh, b
	rlc	a
	sbc	a, a
	ld	hl, (ix - 14)
	ld	c, e
	call	__ishru
	ld	de, 0
	lea	bc, iy + 0
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 14
	call	__lshru
	push	bc
	pop	iy
	ld.sis	de, 64
	add.sis	iy, de
	ld	bc, (ix - 26)
	push	bc
	pop	hl
	add	hl, hl
	ex	de, hl
	ld	hl, _vertex_screen
	add	hl, de
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld	l, 1
	ld	a, (ix - 5)
	or	a, l
	ld	e, a
	ld	hl, _vertex_stamp
	add	hl, bc
	ld	(hl), e
	ld	bc, -8388608
	.local	.LBB10_46
.LBB10_46:
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	(ix - 5), hl
	.local	.LBB10_47
.LBB10_47:
	ld.sis	de, -32736
	ld	l, (ix - 17)
	ld	h, (ix - 16)
	or	a, a
	sbc.sis	hl, de
	ld	iy, (ix - 8)
	jp	nc, .LBB10_52
; %bb.48:
	ld	hl, (ix - 35)
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	de, 17
	or	a, a
	sbc.sis	hl, de
	jp	nc, .LBB10_60
; %bb.49:
	ld	iy, (ix - 11)
	lea	hl, iy + 0
	ld	de, 2
	or	a, a
	sbc	hl, de
	jr	nc, .LBB10_51
; %bb.50:
	ld	iy, 1
	.local	.LBB10_51
.LBB10_51:
	ld	bc, 3
	lea	hl, iy + 0
	call	__imulu
	ex	de, hl
	ld	hl, _small_reciprocals
	add	hl, de
	ld	de, (hl)
	jp	.LBB10_61
	.local	.LBB10_52
.LBB10_52:
	ld	hl, (ix - 41)
	ld	e, (hl)
	ld	l, 1
	ld	a, e
	and	a, l
	ld	l, a
	bit	0, l
	jp	nz, .LBB10_62
; %bb.53:
	ld	(ix - 14), e                    ; 1-byte Folded Spill
	ld.sis	de, 2049
	ld	hl, (ix - 35)
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, de
	jp	c, .LBB10_63
; %bb.54:
	ld	de, 0
	.local	.LBB10_55
.LBB10_55:                              ; =>This Inner Loop Header: Depth=1
	ld	bc, (ix - 11)
	push	bc
	pop	hl
	call	__ishru_1
	ld	(ix - 11), hl
	inc	de
	push	bc
	pop	hl
	push	de
	pop	iy
	ld	de, 4098
	or	a, a
	sbc	hl, de
	lea	de, iy + 0
	jr	nc, .LBB10_55
; %bb.56:
	ld	iy, 34
	push	bc
	pop	hl
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB10_64
; %bb.57:
	ld	iy, (ix - 11)
	lea	hl, iy + 0
	ld	bc, 2
	or	a, a
	sbc	hl, bc
	lea	hl, iy + 0
	ld	iy, (ix - 8)
	jr	nc, .LBB10_59
; %bb.58:
	ld	hl, 1
	.local	.LBB10_59
.LBB10_59:
	ld	bc, 3
	call	__imulu
	push	hl
	pop	bc
	ld	hl, _small_reciprocals
	add	hl, bc
	ld	hl, (hl)
	ld	(ix - 11), hl
	jr	.LBB10_66
	.local	.LBB10_60
.LBB10_60:
	ld	hl, (ix - 11)
	add	hl, hl
	ex	de, hl
	ld	hl, _reciprocal_table
	add	hl, de
	ld	hl, (hl)
	xor	a, a
	ld	(ix - 1), a
	ld	de, (ix - 3)
	ld	d, h
	ld	e, l
	.local	.LBB10_61
.LBB10_61:
	or	a, a
	sbc	hl, hl
	ld	a, l
	ld	(ix - 11), a
	ld	iy, (ix - 8)
	ld	a, iyh
	ld	l, a
	rlc	l
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	rlc	a
	sbc	a, a
	ex	de, hl
	ld	e, (ix - 11)                    ; 1-byte Folded Reload
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 14
	call	__lshrs
	push	bc
	pop	hl
	ld	de, 64
	add	hl, de
	xor	a, a
	ld	bc, -8388608
	jp	.LBB10_68
	.local	.LBB10_62
.LBB10_62:
	ld	hl, (ix - 23)
	add	hl, hl
	ex	de, hl
	ld	hl, _vertex_screen
	add	hl, de
	ld	iy, (hl)
	xor	a, a
	jr	.LBB10_67
	.local	.LBB10_63
.LBB10_63:
	ld	de, 0
	jr	.LBB10_65
	.local	.LBB10_64
.LBB10_64:
	ld	iy, (ix - 8)
	.local	.LBB10_65
.LBB10_65:
	ld	hl, (ix - 11)
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _reciprocal_table
	add	hl, bc
	ld	hl, (hl)
	ld	bc, 0
	ld	c, l
	ld	b, h
	ld	(ix - 11), bc
	.local	.LBB10_66
.LBB10_66:
	ld	a, iyh
	ld	l, a
	rlc	l
	sbc	hl, hl
	lea	bc, iy + 0
	push	hl
	pop	iy
	ld	iyl, c
	ld	iyh, b
	rlc	a
	sbc	a, a
	ld	hl, (ix - 11)
	ld	c, e
	call	__ishru
	ld	de, 0
	lea	bc, iy + 0
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 14
	call	__lshru
	push	bc
	pop	iy
	ld.sis	de, 64
	add.sis	iy, de
	ld	bc, (ix - 23)
	push	bc
	pop	hl
	add	hl, hl
	ex	de, hl
	ld	hl, _vertex_screen
	add	hl, de
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld	l, 1
	ld	a, (ix - 14)
	or	a, l
	ld	e, a
	ld	hl, _vertex_stamp
	add	hl, bc
	ld	(hl), e
	xor	a, a
	ld	bc, -8388608
	.local	.LBB10_67
.LBB10_67:
	ex	de, hl
	ld	e, iyh
	ex	de, hl
	rlc	l
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	.local	.LBB10_68
.LBB10_68:
	ld	(ix - 11), hl
	push	hl
	pop	iy
	add	iy, bc
	push	bc
	pop	de
	ld	bc, (ix - 5)
	push	bc
	pop	hl
	add	hl, de
	ld	(ix - 17), hl
	ld	(ix - 14), iy
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jr	c, .LBB10_70
; %bb.69:
	ld	bc, (ix - 11)
	.local	.LBB10_70
.LBB10_70:
	ld	(ix - 8), bc
	push	bc
	pop	hl
	ld	bc, -8388608
	add	hl, bc
	ld	de, -8388607
	or	a, a
	sbc	hl, de
	jr	nc, .LBB10_72
; %bb.71:
	or	a, a
	sbc	hl, hl
	ld	(ix - 8), hl
	.local	.LBB10_72
.LBB10_72:
	ld	hl, (ix - 14)
	ld	de, (ix - 17)
	or	a, a
	sbc	hl, de
	ld	de, (ix - 5)
	jr	c, .LBB10_74
; %bb.73:
	ld	de, (ix - 11)
	.local	.LBB10_74
.LBB10_74:
	push	de
	pop	hl
	add	hl, bc
	ld	bc, -8388481
	or	a, a
	sbc	hl, bc
	jr	c, .LBB10_76
; %bb.75:
	ld	de, 127
	.local	.LBB10_76
.LBB10_76:
	ex	de, hl
	ld	iy, (ix - 8)
	ld	bc, -8388608
	add	iy, bc
	add	hl, bc
	ld	(ix - 5), hl
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	c, .LBB10_8
; %bb.77:
	ld	hl, _cliptop
	.local	.LBB10_78
.LBB10_78:                              ; =>This Inner Loop Header: Depth=1
	ld	iy, (ix - 8)
	ld	(ix - 11), iy
	ld	de, (ix - 11)
	add	hl, de
	ld	a, (hl)
	ld	hl, _clipbottom
	ld	de, (ix - 11)
	add	hl, de
	ld	d, (hl)
	ld	e, a
	cp	a, d
                                        ; kill: def $a killed $a
	sbc	a, a
	lea	hl, iy + 0
	add	hl, bc
	ld	bc, (ix - 5)
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB10_8
; %bb.79:                               ;   in Loop: Header=BB10_78 Depth=1
	inc	iy
	ld	(ix - 8), iy
	ld	l, a
	ld	a, e
	cp	a, d
	ld	a, l
	ld	bc, -8388608
	ld	hl, _cliptop
	jp	nc, .LBB10_78
	jp	.LBB10_8
	.local	.Lfunc_end10
.Lfunc_end10:
	.size	_d84_bbox_visible, .Lfunc_end10-_d84_bbox_visible
                                        ; -- End function
	.section	.text._engine_render,"ax",@progbits
	.globl	_engine_render                  ; -- Begin function engine_render
	.type	_engine_render,@function
_engine_render:                         ; @engine_render
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 16
	ld	sp, hl
	ld	hl, _render_stats
	xor	a, a
	ld	iy, _engine_view+2
	ld	de, 0
	ld	(ix - 9), de
	ld	(_render_stats), a
	push	hl
	pop	de
	inc	de
	ld	bc, 9
	ldir
	ld	(_engine_view+2), a
	lea	de, iy + 0
	inc	de
	ld	bc, 10239
	lea	hl, iy + 0
	ldir
	ld	a, (_player+32)
	bit	0, a
	jr	nz, .LBB11_3
; %bb.1:
	ld	hl, _depthbuffer
	ld	iyl, -1
	ld	a, iyl
	ld	(_depthbuffer), a
	push	hl
	pop	de
	inc	de
	ld	bc, 10239
	ldir
	ld	a, (_player+31)
	bit	0, a
	jr	z, .LBB11_3
; %bb.2:
	ld	a, iyl
	ld	(_planes), a
	ld	hl, _planes
	push	hl
	pop	iy
	inc	iy
	ld	bc, 10239
	lea	de, iy + 0
	ldir
	.local	.LBB11_3
.LBB11_3:
	xor	a, a
	ld	(_cliptop), a
	ld	hl, _cliptop
	push	hl
	pop	de
	inc	de
	ld	iy, 127
	lea	bc, iy + 0
	ldir
	ld	a, 80
	ld	(_clipbottom), a
	ld	hl, _clipbottom
	push	hl
	pop	de
	inc	de
	lea	bc, iy + 0
	ldir
	ld	a, (_frame_stamp)
	ld	e, 2
	add	a, e
	ld	l, a
	ld	(_frame_stamp), a
	or	a, a
	jr	nz, .LBB11_5
; %bb.4:
	ld	hl, _vertex_stamp
	xor	a, a
	ld	(_vertex_stamp), a
	ld	a, e
	push	hl
	pop	de
	inc	de
	ld	bc, 796
	ldir
	ld	(_frame_stamp), a
	.local	.LBB11_5
.LBB11_5:
	ld	iy, (_player)
	ld	a, (_player+3)
	ld	e, a
	ld	l, 31
	lea	bc, iy + 0
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	d, 8
	ld	l, d
	call	__lshrs
	ld	(_camx), bc
	ld	iy, (_player+4)
	ld	a, (_player+7)
	ld	e, a
	lea	bc, iy + 0
	ld	l, 31
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, d
	call	__lshrs
	ld	(_camy), bc
	ld	hl, _player+18
	ld	iy, (hl)
	or	a, a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	de, 256
	add	hl, de
	ld	bc, 1023
	call	__iand
	add	hl, hl
	ex	de, hl
	ld	bc, _sine_table
	push	bc
	pop	hl
	add	hl, de
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(_camcos), hl
	ld	l, 3
	ld	a, iyh
	and	a, l
	ld	iyh, a
	add.sis	iy, iy
	ld	bc, 0
	push	bc
	pop	de
	ld	e, iyl
	ld	d, iyh
	ld	hl, _sine_table
	add	hl, de
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(_camsin), hl
	push	bc
	ld	hl, 235
	push	hl
	call	_bsp
	ld	hl, 6
	add	hl, sp
	ld	sp, hl
	ld	a, (_player+32)
	bit	0, a
	jp	nz, .LBB11_161
; %bb.6:
	ld	a, (_player+31)
	bit	0, a
	jp	z, .LBB11_17
; %bb.7:
	ld	de, (_render_detail)
	ld	bc, 2
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jr	nz, .LBB11_10
; %bb.8:
	ld	bc, 0
	ld	de, _planes
	.local	.LBB11_9
.LBB11_9:                               ; =>This Inner Loop Header: Depth=1
	push	de
	pop	iy
	add	iy, bc
	ld	a, (iy)
	ld	(iy + 1), a
	push	bc
	pop	iy
	ld	bc, 2
	add	iy, bc
	lea	hl, iy + 0
	ld	bc, 10240
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jr	nz, .LBB11_9
	jp	.LBB11_16
	.local	.LBB11_10
.LBB11_10:
	ld	bc, 3
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB11_13
; %bb.11:
	ld	bc, 0
	ld	de, _planes
	.local	.LBB11_12
.LBB11_12:                              ; =>This Inner Loop Header: Depth=1
	push	de
	pop	iy
	add	iy, bc
	ld	a, (iy)
	ld	(iy + 1), a
	ld	(iy + 2), a
	ld	a, (iy + 3)
	ld	(iy + 4), a
	ld	(iy + 5), a
	ld	a, (iy + 6)
	ld	(iy + 7), a
	ld	(iy + 8), a
	ld	a, (iy + 9)
	ld	(iy + 10), a
	ld	(iy + 11), a
	ld	a, (iy + 12)
	ld	(iy + 13), a
	ld	(iy + 14), a
	ld	a, (iy + 15)
	ld	(iy + 16), a
	ld	(iy + 17), a
	ld	a, (iy + 18)
	ld	(iy + 19), a
	ld	(iy + 20), a
	ld	a, (iy + 21)
	ld	(iy + 22), a
	ld	(iy + 23), a
	ld	a, (iy + 24)
	ld	(iy + 25), a
	ld	(iy + 26), a
	ld	a, (iy + 27)
	ld	(iy + 28), a
	ld	(iy + 29), a
	ld	a, (iy + 30)
	ld	(iy + 31), a
	ld	(iy + 32), a
	ld	a, (iy + 33)
	ld	(iy + 34), a
	ld	(iy + 35), a
	ld	a, (iy + 36)
	ld	(iy + 37), a
	ld	(iy + 38), a
	ld	a, (iy + 39)
	ld	(iy + 40), a
	ld	(iy + 41), a
	ld	a, (iy + 42)
	ld	(iy + 43), a
	ld	(iy + 44), a
	ld	a, (iy + 45)
	ld	(iy + 46), a
	ld	(iy + 47), a
	ld	a, (iy + 48)
	ld	(iy + 49), a
	ld	(iy + 50), a
	ld	a, (iy + 51)
	ld	(iy + 52), a
	ld	(iy + 53), a
	ld	a, (iy + 54)
	ld	(iy + 55), a
	ld	(iy + 56), a
	ld	a, (iy + 57)
	ld	(iy + 58), a
	ld	(iy + 59), a
	ld	a, (iy + 60)
	ld	(iy + 61), a
	ld	(iy + 62), a
	ld	a, (iy + 63)
	ld	(iy + 64), a
	ld	(iy + 65), a
	ld	a, (iy + 66)
	ld	(iy + 67), a
	ld	(iy + 68), a
	ld	a, (iy + 69)
	ld	(iy + 70), a
	ld	(iy + 71), a
	ld	a, (iy + 72)
	ld	(iy + 73), a
	ld	(iy + 74), a
	ld	a, (iy + 75)
	ld	(iy + 76), a
	ld	(iy + 77), a
	ld	a, (iy + 78)
	ld	(iy + 79), a
	ld	(iy + 80), a
	ld	a, (iy + 81)
	ld	(iy + 82), a
	ld	(iy + 83), a
	ld	a, (iy + 84)
	ld	(iy + 85), a
	ld	(iy + 86), a
	ld	a, (iy + 87)
	ld	(iy + 88), a
	ld	(iy + 89), a
	ld	a, (iy + 90)
	ld	(iy + 91), a
	ld	(iy + 92), a
	ld	a, (iy + 93)
	ld	(iy + 94), a
	ld	(iy + 95), a
	ld	a, (iy + 96)
	ld	(iy + 97), a
	ld	(iy + 98), a
	ld	a, (iy + 99)
	ld	(iy + 100), a
	ld	(iy + 101), a
	ld	a, (iy + 102)
	ld	(iy + 103), a
	ld	(iy + 104), a
	ld	a, (iy + 105)
	ld	(iy + 106), a
	ld	(iy + 107), a
	ld	a, (iy + 108)
	ld	(iy + 109), a
	ld	(iy + 110), a
	ld	a, (iy + 111)
	ld	(iy + 112), a
	ld	(iy + 113), a
	ld	a, (iy + 114)
	ld	(iy + 115), a
	ld	(iy + 116), a
	ld	a, (iy + 117)
	ld	(iy + 118), a
	ld	(iy + 119), a
	ld	a, (iy + 120)
	ld	(iy + 121), a
	ld	(iy + 122), a
	ld	a, (iy + 123)
	ld	(iy + 124), a
	ld	(iy + 125), a
	ld	a, (iy + 126)
	ld	(iy + 127), a
	push	bc
	pop	iy
	ld	bc, 128
	add	iy, bc
	lea	hl, iy + 0
	ld	bc, 10240
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jp	nz, .LBB11_12
	jr	.LBB11_16
	.local	.LBB11_13
.LBB11_13:
	ex	de, hl
	ld	de, 4
	or	a, a
	sbc	hl, de
	ld	de, _planes
	jr	nz, .LBB11_16
; %bb.14:
	ld	bc, 0
	.local	.LBB11_15
.LBB11_15:                              ; =>This Inner Loop Header: Depth=1
	push	de
	pop	iy
	add	iy, bc
	ld	a, (iy)
	ld	(iy + 3), a
	ld	(iy + 2), a
	ld	(iy + 1), a
	push	bc
	pop	iy
	ld	bc, 4
	add	iy, bc
	lea	hl, iy + 0
	ld	bc, 10240
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jr	nz, .LBB11_15
	.local	.LBB11_16
.LBB11_16:
	call	_draw_planes
	.local	.LBB11_17
.LBB11_17:
	call	_draw_sprites
	ld	de, (_render_detail)
	ld	bc, 2
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jr	nz, .LBB11_20
; %bb.18:
	ld	de, 2
	push	de
	pop	bc
	.local	.LBB11_19
.LBB11_19:                              ; =>This Inner Loop Header: Depth=1
	ld	iy, _engine_view
	add	iy, bc
	ld	a, (iy)
	ld	(iy + 1), a
	push	bc
	pop	iy
	add	iy, de
	lea	hl, iy + 0
	ld	bc, 10242
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jr	nz, .LBB11_19
	jp	.LBB11_25
	.local	.LBB11_20
.LBB11_20:
	ld	bc, 3
	push	de
	pop	hl
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB11_23
; %bb.21:
	ld	de, 10240
	ld	bc, 0
	.local	.LBB11_22
.LBB11_22:                              ; =>This Inner Loop Header: Depth=1
	ld	iy, _engine_view+64
	add	iy, bc
	ld	a, (iy - 62)
	ld	(iy - 61), a
	ld	(iy - 60), a
	ld	a, (iy - 59)
	ld	(iy - 58), a
	ld	(iy - 57), a
	ld	a, (iy - 56)
	ld	(iy - 55), a
	ld	(iy - 54), a
	ld	a, (iy - 53)
	ld	(iy - 52), a
	ld	(iy - 51), a
	ld	a, (iy - 50)
	ld	(iy - 49), a
	ld	(iy - 48), a
	ld	a, (iy - 47)
	ld	(iy - 46), a
	ld	(iy - 45), a
	ld	a, (iy - 44)
	ld	(iy - 43), a
	ld	(iy - 42), a
	ld	a, (iy - 41)
	ld	(iy - 40), a
	ld	(iy - 39), a
	ld	a, (iy - 38)
	ld	(iy - 37), a
	ld	(iy - 36), a
	ld	a, (iy - 35)
	ld	(iy - 34), a
	ld	(iy - 33), a
	ld	a, (iy - 32)
	ld	(iy - 31), a
	ld	(iy - 30), a
	ld	a, (iy - 29)
	ld	(iy - 28), a
	ld	(iy - 27), a
	ld	a, (iy - 26)
	ld	(iy - 25), a
	ld	(iy - 24), a
	ld	a, (iy - 23)
	ld	(iy - 22), a
	ld	(iy - 21), a
	ld	a, (iy - 20)
	ld	(iy - 19), a
	ld	(iy - 18), a
	ld	a, (iy - 17)
	ld	(iy - 16), a
	ld	(iy - 15), a
	ld	a, (iy - 14)
	ld	(iy - 13), a
	ld	(iy - 12), a
	ld	a, (iy - 11)
	ld	(iy - 10), a
	ld	(iy - 9), a
	ld	a, (iy - 8)
	ld	(iy - 7), a
	ld	(iy - 6), a
	ld	a, (iy - 5)
	ld	(iy - 4), a
	ld	(iy - 3), a
	ld	a, (iy - 2)
	ld	(iy - 1), a
	ld	(iy), a
	ld	a, (iy + 1)
	ld	(iy + 2), a
	ld	(iy + 3), a
	ld	a, (iy + 4)
	ld	(iy + 5), a
	ld	(iy + 6), a
	ld	a, (iy + 7)
	ld	(iy + 8), a
	ld	(iy + 9), a
	ld	a, (iy + 10)
	ld	(iy + 11), a
	ld	(iy + 12), a
	ld	a, (iy + 13)
	ld	(iy + 14), a
	ld	(iy + 15), a
	ld	a, (iy + 16)
	ld	(iy + 17), a
	ld	(iy + 18), a
	ld	a, (iy + 19)
	ld	(iy + 20), a
	ld	(iy + 21), a
	ld	a, (iy + 22)
	ld	(iy + 23), a
	ld	(iy + 24), a
	ld	a, (iy + 25)
	ld	(iy + 26), a
	ld	(iy + 27), a
	ld	a, (iy + 28)
	ld	(iy + 29), a
	ld	(iy + 30), a
	ld	a, (iy + 31)
	ld	(iy + 32), a
	ld	(iy + 33), a
	ld	a, (iy + 34)
	ld	(iy + 35), a
	ld	(iy + 36), a
	ld	a, (iy + 37)
	ld	(iy + 38), a
	ld	(iy + 39), a
	ld	a, (iy + 40)
	ld	(iy + 41), a
	ld	(iy + 42), a
	ld	a, (iy + 43)
	ld	(iy + 44), a
	ld	(iy + 45), a
	ld	a, (iy + 46)
	ld	(iy + 47), a
	ld	(iy + 48), a
	ld	a, (iy + 49)
	ld	(iy + 50), a
	ld	(iy + 51), a
	ld	a, (iy + 52)
	ld	(iy + 53), a
	ld	(iy + 54), a
	ld	a, (iy + 55)
	ld	(iy + 56), a
	ld	(iy + 57), a
	ld	a, (iy + 58)
	ld	(iy + 59), a
	ld	(iy + 60), a
	ld	a, (iy + 61)
	ld	(iy + 62), a
	ld	(iy + 63), a
	ld	a, (iy + 64)
	ld	(iy + 65), a
	push	bc
	pop	iy
	ld	bc, 128
	add	iy, bc
	lea	hl, iy + 0
	push	de
	pop	bc
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jp	nz, .LBB11_22
	jr	.LBB11_25
	.local	.LBB11_23
.LBB11_23:
	ex	de, hl
	ld	de, 4
	or	a, a
	sbc	hl, de
	ld	bc, 2
	jr	nz, .LBB11_25
	.local	.LBB11_24
.LBB11_24:                              ; =>This Inner Loop Header: Depth=1
	ld	iy, _engine_view
	add	iy, bc
	ld	a, (iy)
	ld	(iy + 3), a
	ld	(iy + 2), a
	ld	(iy + 1), a
	push	bc
	pop	iy
	add	iy, de
	lea	hl, iy + 0
	ld	bc, 10242
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jr	nz, .LBB11_24
	.local	.LBB11_25
.LBB11_25:
	ld	iy, _gun_frames
	ld	a, (_player+27)
	ld	e, a
	ld	l, -16
	ld	a, e
	add	a, l
	ld	l, a
	cp	a, -15
	ld	(ix - 13), e
	jr	nc, .LBB11_28
; %bb.26:
	ld	a, e
	or	a, a
	jr	nz, .LBB11_30
; %bb.27:
	ld	hl, _player+24
	ld.sis	de, 40
	ld	bc, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc, 2016
	call	__iand
	push	hl
	pop	bc
	ld	hl, _sine_table
	add	hl, bc
	ld	iy, (hl)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	add.sis	hl, hl
	sbc.sis	hl, hl
	ld	c, 9
	call	__sshru
	ld	c, l
	ld	b, h
	add.sis	iy, bc
	ld	c, 7
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	call	__sshrs
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	add.sis	iy, de
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	jr	.LBB11_31
	.local	.LBB11_28
.LBB11_28:
	ld	a, e
	cp	a, 6
	sbc	hl, hl
	cp	a, 10
	jr	nc, .LBB11_32
; %bb.29:
	inc	hl
	inc	hl
	jr	.LBB11_33
	.local	.LBB11_30
.LBB11_30:
	ld	hl, 40
	.local	.LBB11_31
.LBB11_31:
	ld	de, _gun_frames
	ld	(ix - 16), de
	jr	.LBB11_34
	.local	.LBB11_32
.LBB11_32:
	ld	hl, 1
	.local	.LBB11_33
.LBB11_33:
	ld	bc, 1200
	call	__imulu
	push	hl
	pop	bc
	add	iy, bc
	ld	(ix - 16), iy
	ld	hl, 40
	.local	.LBB11_34
.LBB11_34:
	ld	de, _gun_flash+14
	ld	(ix - 6), de
	ld	c, 7
	ld	(ix - 12), hl
	call	__ishl
	push	hl
	pop	bc
	ld	iy, _engine_view
	add	iy, bc
	lea	hl, iy + 75
	ld	(ix - 3), hl
	ld	iy, (ix - 16)
	lea	iy, iy + 14
	ld	bc, 0
	.local	.LBB11_35
.LBB11_35:                              ; =>This Inner Loop Header: Depth=1
	ld	hl, (ix - 12)
	add	hl, bc
	ld	de, 80
	or	a, a
	sbc	hl, de
	jp	nc, .LBB11_67
; %bb.36:                               ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 14)
	cp	a, -1
	lea	hl, iy + 0
	jp	nz, .LBB11_68
; %bb.37:                               ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 13)
	cp	a, -1
	jp	nz, .LBB11_69
	.local	.LBB11_38
.LBB11_38:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 12)
	cp	a, -1
	jp	nz, .LBB11_70
	.local	.LBB11_39
.LBB11_39:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 11)
	cp	a, -1
	jp	nz, .LBB11_71
	.local	.LBB11_40
.LBB11_40:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 10)
	cp	a, -1
	jp	nz, .LBB11_72
	.local	.LBB11_41
.LBB11_41:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 9)
	cp	a, -1
	jp	nz, .LBB11_73
	.local	.LBB11_42
.LBB11_42:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 8)
	cp	a, -1
	jp	nz, .LBB11_74
	.local	.LBB11_43
.LBB11_43:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 7)
	cp	a, -1
	jp	nz, .LBB11_75
	.local	.LBB11_44
.LBB11_44:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 6)
	cp	a, -1
	jp	nz, .LBB11_76
	.local	.LBB11_45
.LBB11_45:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 5)
	cp	a, -1
	jp	nz, .LBB11_77
	.local	.LBB11_46
.LBB11_46:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 4)
	cp	a, -1
	jp	nz, .LBB11_78
	.local	.LBB11_47
.LBB11_47:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 3)
	cp	a, -1
	jp	nz, .LBB11_79
	.local	.LBB11_48
.LBB11_48:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 2)
	cp	a, -1
	jp	nz, .LBB11_80
	.local	.LBB11_49
.LBB11_49:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy - 1)
	cp	a, -1
	jp	nz, .LBB11_81
	.local	.LBB11_50
.LBB11_50:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy)
	cp	a, -1
	jp	nz, .LBB11_82
	.local	.LBB11_51
.LBB11_51:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 1)
	cp	a, -1
	jp	nz, .LBB11_83
	.local	.LBB11_52
.LBB11_52:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 2)
	cp	a, -1
	jp	nz, .LBB11_84
	.local	.LBB11_53
.LBB11_53:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 3)
	cp	a, -1
	jp	nz, .LBB11_85
	.local	.LBB11_54
.LBB11_54:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 4)
	cp	a, -1
	jp	nz, .LBB11_86
	.local	.LBB11_55
.LBB11_55:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 5)
	cp	a, -1
	jp	nz, .LBB11_87
	.local	.LBB11_56
.LBB11_56:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 6)
	cp	a, -1
	jp	nz, .LBB11_88
	.local	.LBB11_57
.LBB11_57:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 7)
	cp	a, -1
	jp	nz, .LBB11_89
	.local	.LBB11_58
.LBB11_58:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 8)
	cp	a, -1
	jp	nz, .LBB11_90
	.local	.LBB11_59
.LBB11_59:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 9)
	cp	a, -1
	jp	nz, .LBB11_91
	.local	.LBB11_60
.LBB11_60:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 10)
	cp	a, -1
	jp	nz, .LBB11_92
	.local	.LBB11_61
.LBB11_61:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 11)
	cp	a, -1
	jp	nz, .LBB11_93
	.local	.LBB11_62
.LBB11_62:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 12)
	cp	a, -1
	jp	nz, .LBB11_94
	.local	.LBB11_63
.LBB11_63:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 13)
	cp	a, -1
	jp	nz, .LBB11_95
	.local	.LBB11_64
.LBB11_64:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 14)
	cp	a, -1
	jp	nz, .LBB11_96
	.local	.LBB11_65
.LBB11_65:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	a, (iy + 15)
	cp	a, -1
	jr	z, .LBB11_67
	.local	.LBB11_66
.LBB11_66:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	hl, (ix - 3)
	ld	(hl), a
	.local	.LBB11_67
.LBB11_67:                              ;   in Loop: Header=BB11_35 Depth=1
	inc	bc
	ld	de, 128
	ld	hl, (ix - 3)
	add	hl, de
	ld	(ix - 3), hl
	lea	iy, iy + 30
	push	bc
	pop	hl
	ld	de, 40
	or	a, a
	sbc	hl, de
	jp	nz, .LBB11_35
	jp	.LBB11_97
	.local	.LBB11_68
.LBB11_68:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 29), a
	push	hl
	pop	iy
	ld	a, (iy - 13)
	cp	a, -1
	jp	z, .LBB11_38
	.local	.LBB11_69
.LBB11_69:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 28), a
	push	hl
	pop	iy
	ld	a, (iy - 12)
	cp	a, -1
	jp	z, .LBB11_39
	.local	.LBB11_70
.LBB11_70:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 27), a
	push	hl
	pop	iy
	ld	a, (iy - 11)
	cp	a, -1
	jp	z, .LBB11_40
	.local	.LBB11_71
.LBB11_71:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 26), a
	push	hl
	pop	iy
	ld	a, (iy - 10)
	cp	a, -1
	jp	z, .LBB11_41
	.local	.LBB11_72
.LBB11_72:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 25), a
	push	hl
	pop	iy
	ld	a, (iy - 9)
	cp	a, -1
	jp	z, .LBB11_42
	.local	.LBB11_73
.LBB11_73:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 24), a
	push	hl
	pop	iy
	ld	a, (iy - 8)
	cp	a, -1
	jp	z, .LBB11_43
	.local	.LBB11_74
.LBB11_74:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 23), a
	push	hl
	pop	iy
	ld	a, (iy - 7)
	cp	a, -1
	jp	z, .LBB11_44
	.local	.LBB11_75
.LBB11_75:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 22), a
	push	hl
	pop	iy
	ld	a, (iy - 6)
	cp	a, -1
	jp	z, .LBB11_45
	.local	.LBB11_76
.LBB11_76:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 21), a
	push	hl
	pop	iy
	ld	a, (iy - 5)
	cp	a, -1
	jp	z, .LBB11_46
	.local	.LBB11_77
.LBB11_77:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 20), a
	push	hl
	pop	iy
	ld	a, (iy - 4)
	cp	a, -1
	jp	z, .LBB11_47
	.local	.LBB11_78
.LBB11_78:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 19), a
	push	hl
	pop	iy
	ld	a, (iy - 3)
	cp	a, -1
	jp	z, .LBB11_48
	.local	.LBB11_79
.LBB11_79:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 18), a
	push	hl
	pop	iy
	ld	a, (iy - 2)
	cp	a, -1
	jp	z, .LBB11_49
	.local	.LBB11_80
.LBB11_80:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 17), a
	push	hl
	pop	iy
	ld	a, (iy - 1)
	cp	a, -1
	jp	z, .LBB11_50
	.local	.LBB11_81
.LBB11_81:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 16), a
	push	hl
	pop	iy
	ld	a, (iy)
	cp	a, -1
	jp	z, .LBB11_51
	.local	.LBB11_82
.LBB11_82:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 15), a
	push	hl
	pop	iy
	ld	a, (iy + 1)
	cp	a, -1
	jp	z, .LBB11_52
	.local	.LBB11_83
.LBB11_83:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 14), a
	push	hl
	pop	iy
	ld	a, (iy + 2)
	cp	a, -1
	jp	z, .LBB11_53
	.local	.LBB11_84
.LBB11_84:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 13), a
	push	hl
	pop	iy
	ld	a, (iy + 3)
	cp	a, -1
	jp	z, .LBB11_54
	.local	.LBB11_85
.LBB11_85:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 12), a
	push	hl
	pop	iy
	ld	a, (iy + 4)
	cp	a, -1
	jp	z, .LBB11_55
	.local	.LBB11_86
.LBB11_86:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 11), a
	push	hl
	pop	iy
	ld	a, (iy + 5)
	cp	a, -1
	jp	z, .LBB11_56
	.local	.LBB11_87
.LBB11_87:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 10), a
	push	hl
	pop	iy
	ld	a, (iy + 6)
	cp	a, -1
	jp	z, .LBB11_57
	.local	.LBB11_88
.LBB11_88:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 9), a
	push	hl
	pop	iy
	ld	a, (iy + 7)
	cp	a, -1
	jp	z, .LBB11_58
	.local	.LBB11_89
.LBB11_89:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 8), a
	push	hl
	pop	iy
	ld	a, (iy + 8)
	cp	a, -1
	jp	z, .LBB11_59
	.local	.LBB11_90
.LBB11_90:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 7), a
	push	hl
	pop	iy
	ld	a, (iy + 9)
	cp	a, -1
	jp	z, .LBB11_60
	.local	.LBB11_91
.LBB11_91:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 6), a
	push	hl
	pop	iy
	ld	a, (iy + 10)
	cp	a, -1
	jp	z, .LBB11_61
	.local	.LBB11_92
.LBB11_92:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 5), a
	push	hl
	pop	iy
	ld	a, (iy + 11)
	cp	a, -1
	jp	z, .LBB11_62
	.local	.LBB11_93
.LBB11_93:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 4), a
	push	hl
	pop	iy
	ld	a, (iy + 12)
	cp	a, -1
	jp	z, .LBB11_63
	.local	.LBB11_94
.LBB11_94:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 3), a
	push	hl
	pop	iy
	ld	a, (iy + 13)
	cp	a, -1
	jp	z, .LBB11_64
	.local	.LBB11_95
.LBB11_95:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 2), a
	push	hl
	pop	iy
	ld	a, (iy + 14)
	cp	a, -1
	jp	z, .LBB11_65
	.local	.LBB11_96
.LBB11_96:                              ;   in Loop: Header=BB11_35 Depth=1
	ld	iy, (ix - 3)
	ld	(iy - 1), a
	push	hl
	pop	iy
	ld	a, (iy + 15)
	cp	a, -1
	jp	nz, .LBB11_66
	jp	.LBB11_67
	.local	.LBB11_97
.LBB11_97:
	ld	a, (ix - 13)
	ld	l, -10
	add	a, l
	ld	l, a
	cp	a, 6
	jp	nc, .LBB11_161
; %bb.98:
	ld	c, 7
	ld	hl, (ix - 12)
	call	__ishl
	ex	de, hl
	ld	hl, _engine_view
	push	hl
	pop	iy
	add	iy, de
	lea	de, iy + 75
	.local	.LBB11_99
.LBB11_99:                              ; =>This Inner Loop Header: Depth=1
	ld	hl, (ix - 12)
	ld	bc, (ix - 9)
	add	hl, bc
	ld	bc, 80
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB11_131
; %bb.100:                              ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 14)
	cp	a, -1
	jp	nz, .LBB11_132
; %bb.101:                              ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 13)
	cp	a, -1
	jp	nz, .LBB11_133
	.local	.LBB11_102
.LBB11_102:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 12)
	cp	a, -1
	jp	nz, .LBB11_134
	.local	.LBB11_103
.LBB11_103:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 11)
	cp	a, -1
	jp	nz, .LBB11_135
	.local	.LBB11_104
.LBB11_104:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 10)
	cp	a, -1
	jp	nz, .LBB11_136
	.local	.LBB11_105
.LBB11_105:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 9)
	cp	a, -1
	jp	nz, .LBB11_137
	.local	.LBB11_106
.LBB11_106:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 8)
	cp	a, -1
	jp	nz, .LBB11_138
	.local	.LBB11_107
.LBB11_107:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 7)
	cp	a, -1
	jp	nz, .LBB11_139
	.local	.LBB11_108
.LBB11_108:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 6)
	cp	a, -1
	jp	nz, .LBB11_140
	.local	.LBB11_109
.LBB11_109:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 5)
	cp	a, -1
	jp	nz, .LBB11_141
	.local	.LBB11_110
.LBB11_110:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 4)
	cp	a, -1
	jp	nz, .LBB11_142
	.local	.LBB11_111
.LBB11_111:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 3)
	cp	a, -1
	jp	nz, .LBB11_143
	.local	.LBB11_112
.LBB11_112:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 2)
	cp	a, -1
	jp	nz, .LBB11_144
	.local	.LBB11_113
.LBB11_113:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 1)
	cp	a, -1
	jp	nz, .LBB11_145
	.local	.LBB11_114
.LBB11_114:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	hl, (ix - 6)
	ld	a, (hl)
	cp	a, -1
	jp	nz, .LBB11_146
	.local	.LBB11_115
.LBB11_115:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 1)
	cp	a, -1
	jp	nz, .LBB11_147
	.local	.LBB11_116
.LBB11_116:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 2)
	cp	a, -1
	jp	nz, .LBB11_148
	.local	.LBB11_117
.LBB11_117:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 3)
	cp	a, -1
	jp	nz, .LBB11_149
	.local	.LBB11_118
.LBB11_118:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 4)
	cp	a, -1
	jp	nz, .LBB11_150
	.local	.LBB11_119
.LBB11_119:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 5)
	cp	a, -1
	jp	nz, .LBB11_151
	.local	.LBB11_120
.LBB11_120:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 6)
	cp	a, -1
	jp	nz, .LBB11_152
	.local	.LBB11_121
.LBB11_121:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 7)
	cp	a, -1
	jp	nz, .LBB11_153
	.local	.LBB11_122
.LBB11_122:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 8)
	cp	a, -1
	jp	nz, .LBB11_154
	.local	.LBB11_123
.LBB11_123:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 9)
	cp	a, -1
	jp	nz, .LBB11_155
	.local	.LBB11_124
.LBB11_124:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 10)
	cp	a, -1
	jp	nz, .LBB11_156
	.local	.LBB11_125
.LBB11_125:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 11)
	cp	a, -1
	jp	nz, .LBB11_157
	.local	.LBB11_126
.LBB11_126:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 12)
	cp	a, -1
	jp	nz, .LBB11_158
	.local	.LBB11_127
.LBB11_127:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 13)
	cp	a, -1
	jp	nz, .LBB11_159
	.local	.LBB11_128
.LBB11_128:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 14)
	cp	a, -1
	jp	nz, .LBB11_160
	.local	.LBB11_129
.LBB11_129:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy + 15)
	cp	a, -1
	jr	z, .LBB11_131
	.local	.LBB11_130
.LBB11_130:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	hl
	ld	(hl), a
	.local	.LBB11_131
.LBB11_131:                             ;   in Loop: Header=BB11_99 Depth=1
	ld	hl, (ix - 9)
	inc	hl
	ld	bc, 128
	push	de
	pop	iy
	add	iy, bc
	lea	de, iy + 0
	ld	iy, (ix - 6)
	lea	iy, iy + 30
	ld	(ix - 6), iy
	ld	(ix - 9), hl
	ld	bc, 40
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB11_99
	jp	.LBB11_161
	.local	.LBB11_132
.LBB11_132:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 29), a
	ld	iy, (ix - 6)
	ld	a, (iy - 13)
	cp	a, -1
	jp	z, .LBB11_102
	.local	.LBB11_133
.LBB11_133:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 28), a
	ld	iy, (ix - 6)
	ld	a, (iy - 12)
	cp	a, -1
	jp	z, .LBB11_103
	.local	.LBB11_134
.LBB11_134:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 27), a
	ld	iy, (ix - 6)
	ld	a, (iy - 11)
	cp	a, -1
	jp	z, .LBB11_104
	.local	.LBB11_135
.LBB11_135:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 26), a
	ld	iy, (ix - 6)
	ld	a, (iy - 10)
	cp	a, -1
	jp	z, .LBB11_105
	.local	.LBB11_136
.LBB11_136:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 25), a
	ld	iy, (ix - 6)
	ld	a, (iy - 9)
	cp	a, -1
	jp	z, .LBB11_106
	.local	.LBB11_137
.LBB11_137:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 24), a
	ld	iy, (ix - 6)
	ld	a, (iy - 8)
	cp	a, -1
	jp	z, .LBB11_107
	.local	.LBB11_138
.LBB11_138:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 23), a
	ld	iy, (ix - 6)
	ld	a, (iy - 7)
	cp	a, -1
	jp	z, .LBB11_108
	.local	.LBB11_139
.LBB11_139:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 22), a
	ld	iy, (ix - 6)
	ld	a, (iy - 6)
	cp	a, -1
	jp	z, .LBB11_109
	.local	.LBB11_140
.LBB11_140:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 21), a
	ld	iy, (ix - 6)
	ld	a, (iy - 5)
	cp	a, -1
	jp	z, .LBB11_110
	.local	.LBB11_141
.LBB11_141:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 20), a
	ld	iy, (ix - 6)
	ld	a, (iy - 4)
	cp	a, -1
	jp	z, .LBB11_111
	.local	.LBB11_142
.LBB11_142:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 19), a
	ld	iy, (ix - 6)
	ld	a, (iy - 3)
	cp	a, -1
	jp	z, .LBB11_112
	.local	.LBB11_143
.LBB11_143:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 18), a
	ld	iy, (ix - 6)
	ld	a, (iy - 2)
	cp	a, -1
	jp	z, .LBB11_113
	.local	.LBB11_144
.LBB11_144:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 17), a
	ld	iy, (ix - 6)
	ld	a, (iy - 1)
	cp	a, -1
	jp	z, .LBB11_114
	.local	.LBB11_145
.LBB11_145:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 16), a
	ld	hl, (ix - 6)
	ld	a, (hl)
	cp	a, -1
	jp	z, .LBB11_115
	.local	.LBB11_146
.LBB11_146:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 15), a
	ld	iy, (ix - 6)
	ld	a, (iy + 1)
	cp	a, -1
	jp	z, .LBB11_116
	.local	.LBB11_147
.LBB11_147:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 14), a
	ld	iy, (ix - 6)
	ld	a, (iy + 2)
	cp	a, -1
	jp	z, .LBB11_117
	.local	.LBB11_148
.LBB11_148:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 13), a
	ld	iy, (ix - 6)
	ld	a, (iy + 3)
	cp	a, -1
	jp	z, .LBB11_118
	.local	.LBB11_149
.LBB11_149:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 12), a
	ld	iy, (ix - 6)
	ld	a, (iy + 4)
	cp	a, -1
	jp	z, .LBB11_119
	.local	.LBB11_150
.LBB11_150:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 11), a
	ld	iy, (ix - 6)
	ld	a, (iy + 5)
	cp	a, -1
	jp	z, .LBB11_120
	.local	.LBB11_151
.LBB11_151:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 10), a
	ld	iy, (ix - 6)
	ld	a, (iy + 6)
	cp	a, -1
	jp	z, .LBB11_121
	.local	.LBB11_152
.LBB11_152:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 9), a
	ld	iy, (ix - 6)
	ld	a, (iy + 7)
	cp	a, -1
	jp	z, .LBB11_122
	.local	.LBB11_153
.LBB11_153:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 8), a
	ld	iy, (ix - 6)
	ld	a, (iy + 8)
	cp	a, -1
	jp	z, .LBB11_123
	.local	.LBB11_154
.LBB11_154:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 7), a
	ld	iy, (ix - 6)
	ld	a, (iy + 9)
	cp	a, -1
	jp	z, .LBB11_124
	.local	.LBB11_155
.LBB11_155:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 6), a
	ld	iy, (ix - 6)
	ld	a, (iy + 10)
	cp	a, -1
	jp	z, .LBB11_125
	.local	.LBB11_156
.LBB11_156:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 5), a
	ld	iy, (ix - 6)
	ld	a, (iy + 11)
	cp	a, -1
	jp	z, .LBB11_126
	.local	.LBB11_157
.LBB11_157:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 4), a
	ld	iy, (ix - 6)
	ld	a, (iy + 12)
	cp	a, -1
	jp	z, .LBB11_127
	.local	.LBB11_158
.LBB11_158:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 3), a
	ld	iy, (ix - 6)
	ld	a, (iy + 13)
	cp	a, -1
	jp	z, .LBB11_128
	.local	.LBB11_159
.LBB11_159:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 2), a
	ld	iy, (ix - 6)
	ld	a, (iy + 14)
	cp	a, -1
	jp	z, .LBB11_129
	.local	.LBB11_160
.LBB11_160:                             ;   in Loop: Header=BB11_99 Depth=1
	push	de
	pop	iy
	ld	(iy - 1), a
	ld	iy, (ix - 6)
	ld	a, (iy + 15)
	cp	a, -1
	jp	nz, .LBB11_130
	jp	.LBB11_131
	.local	.LBB11_161
.LBB11_161:
	ld	a, 4
	ld	(_engine_view+5058), a
	ld	(_engine_view+5314), a
	ld	(_engine_view+5185), a
	ld	(_engine_view+5187), a
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end11
.Lfunc_end11:
	.size	_engine_render, .Lfunc_end11-_engine_render
                                        ; -- End function
	.section	.text._bsp,"ax",@progbits
	.type	_d84_node_side_camera,@function
_d84_node_side_camera:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 17
	ld	sp, hl
	ld	iy, (ix + 6)
	ld	bc, (_camx)
	ld	de, (iy + 4)
	ld	(ix - 9), de
	sbc.sis	hl, hl
	adc.sis	hl, de
	jp	nz, .Lnode_side_y
	lea	hl, iy + 0
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	push	bc
	pop	de
	ld	bc, (iy + 6)
	ld	(ix - 9), bc
	ld	bc, -8388608
	push	de
	pop	iy
	add	iy, bc
	add	hl, bc
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	nc, .Lnode_side_ge
	ld	a, 15
	ld	hl, (ix - 9)
	ld	c, a
	call	__sshru
	ex.sis	de, hl
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	sp, ix
	pop	ix
	ret
.Lnode_side_y:
	ld	(ix - 15), bc
	ld	hl, (_camy)
	ld	(ix - 12), hl
	ld	de, (iy + 6)
	sbc.sis	hl, hl
	adc.sis	hl, de
	jp	nz, .Lnode_side_cross
	ld	de, (iy + 2)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 15), hl
	ld	c, 15
	ld	iy, (ix - 9)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	call	__sshru
	ld	(ix - 17), l
	ld	(ix - 16), h
	ld	de, 0
	ld.sis	bc, -32768
	add.sis	iy, bc
	inc.sis	bc
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	or	a, a
	sbc.sis	hl, bc
	sbc	hl, hl
	ld	(ix - 9), hl
	ld	bc, -8388608
	ld	iy, (ix - 12)
	add	iy, bc
	ld	hl, (ix - 15)
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	c, .Lnode_side_inc
	ld	l, (ix - 17)
	ld	h, (ix - 16)
	ld	e, l
	ld	d, h
	ex	de, hl
	ld	sp, ix
	pop	ix
	ret
.Lnode_side_ge:
	ld.sis	de, -32768
	ld	hl, (ix - 9)
	add.sis	hl, de
	inc.sis	de
	or	a, a
	sbc.sis	hl, de
	sbc	hl, hl
	inc	hl
	ld	sp, ix
	pop	ix
	ret
.Lnode_side_cross:
	ld	hl, (ix + 6)
	ld	iy, (hl)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	ld	hl, (ix - 15)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	ld	(ix - 6), iy
	ld	a, (ix - 4)
	rlc	a
	sbc	a, a
	ld	(ix - 15), a
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	rlc	d
	sbc	a, a
	lea	hl, iy + 0
	ld	e, (ix - 15)
	call	__lmulu
	ld	(ix - 15), hl
	ld	(ix - 17), e
	ld	iy, (ix + 6)
	ld	bc, (iy + 2)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, c
	ld	d, b
	ld	hl, (ix - 12)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	ld	(ix - 3), iy
	ld	a, (ix - 1)
	rlc	a
	sbc	a, a
	ld	(ix - 12), a
	ld	de, (ix - 9)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	rlc	d
	sbc	a, a
	lea	hl, iy + 0
	ld	e, (ix - 12)
	call	__lmulu
	ld	bc, (ix - 15)
	ld	a, (ix - 17)
	call	__lcmps
	call	pe, __setflag
	jp	p, .Lnode_side_one
	ld	hl, 0
	ld	sp, ix
	pop	ix
	ret
.Lnode_side_inc:
	ld	hl, (ix - 9)
	inc	hl
	ld	sp, ix
	pop	ix
	ret
.Lnode_side_one:
	ld	hl, 1
	ld	sp, ix
	pop	ix
	ret

	.type	_bsp,@function                  ; -- Begin function bsp
_bsp:                                   ; @bsp
	push	ix
	ld	ix, 0
	add	ix, sp
	ld	hl, -9
	add	hl, sp
	ld	sp, hl
	ld	a, (_render_stats+8)
	ld	b, a
	ld	a, (ix + 9)
	cp	a, b
	jr	c, .Lbsp_depth_done
	ld	(_render_stats+8), a
.Lbsp_depth_done:
	ld	hl, (ix + 6)
	bit	7, h
	jp	nz, .Lbsp_leaf
	add	hl, hl
	ld	de, _node_offsets
	add	hl, de
	ld	de, 0
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, (_nodes)
	add	hl, de
	ld	(ix - 3), hl
	push	hl
	call	_d84_node_side_camera
	pop	de
	ld	(ix - 6), hl
	ld	a, l
	call	.Lbsp_child
	ld	hl, (ix + 9)
	inc	hl
	push	hl
	push	de
	call	_bsp
	ld	hl, 6
	add	hl, sp
	ld	sp, hl

	ld	a, (ix - 6)
	xor	a, 1
	ld	e, a
	ld	d, 0
	ld	hl, (ix + 6)
	add	hl, hl
	ld	bc, 0
	ld	c, a
	add	hl, bc
	push	hl
	ld	hl, 0
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, 8
	add	hl, de
	ld	de, (ix - 3)
	add	hl, de
	push	hl
	call	_d84_bbox_visible
	ld	hl, 6
	add	hl, sp
	ld	sp, hl
	or	a, a
	jr	z, .Lbsp_return
	ld	a, (ix - 6)
	xor	a, 1
	call	.Lbsp_child
	ld	(ix + 6), de
	ld	hl, (ix + 9)
	inc	hl
	ld	(ix + 9), hl
	ld	sp, ix
	pop	ix
	jp	_bsp
.Lbsp_return:
	ld	sp, ix
	pop	ix
	ret
.Lbsp_child:
	add	a, a
	add	a, 24
	ld	hl, (ix - 3)
	ld	de, 0
	ld	e, a
	add	hl, de
	ld	de, 0
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ret
.Lbsp_leaf:
	res	7, h
	add	hl, hl
	add	hl, hl
	ld	de, (_subsectors)
	add	hl, de
	ld	de, 0
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	(ix - 9), de
	inc	hl
	ld	bc, 0
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, _render_stats+2
	inc	(hl)
	jr	nz, .Lbsp_leaf_counted
	inc	hl
	inc	(hl)
.Lbsp_leaf_counted:
	push	bc
	pop	hl
	add	hl, hl
	push	hl
	pop	de
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	ld	de, (_segs)
	add	hl, de
	ld	(ix - 3), hl
	push	bc
	pop	hl
	add	hl, hl
	push	hl
	pop	de
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	de, _materials
	add	hl, de
	ld	(ix - 6), hl
.Lbsp_seg:
	ld	hl, (ix - 9)
	ld	de, 0
	or	a, a
	sbc	hl, de
	jr	z, .Lbsp_return
	dec	hl
	ld	(ix - 9), hl
	ld	hl, (ix - 6)
	push	hl
	ld	hl, (ix - 3)
	push	hl
	call	_d84_draw_seg
	ld	hl, 6
	add	hl, sp
	ld	sp, hl
	ld	hl, (ix - 3)
	ld	de, 14
	add	hl, de
	ld	(ix - 3), hl
	ld	hl, (ix - 6)
	ld	de, 10
	add	hl, de
	ld	(ix - 6), hl
	jr	.Lbsp_seg
	.local	.Lfunc_end12
.Lfunc_end12:
	.size	_bsp, .Lfunc_end12-_bsp
                                        ; -- End function

	.section	.text._draw_planes,"ax",@progbits
	.type	_draw_planes,@function          ; -- Begin function draw_planes
_draw_planes:                           ; @draw_planes
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 57
	ld	sp, hl
	sbc	hl, hl
	ld	de, _engine_view+2
	ld	(ix - 9), de
	ld	de, _depthbuffer
	ld	(ix - 15), de
	ld	bc, _planes
	ld	de, (_images+237)
	ld	(ix - 48), de
	ld	(ix - 18), bc
	push	bc
	pop	iy
	push	hl
	pop	bc
	.local	.LBB13_1
.LBB13_1:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB13_2 Depth 2
                                        ;       Child Loop BB13_5 Depth 3
                                        ;       Child Loop BB13_51 Depth 3
                                        ;       Child Loop BB13_48 Depth 3
                                        ;       Child Loop BB13_44 Depth 3
                                        ;       Child Loop BB13_35 Depth 3
                                        ;       Child Loop BB13_14 Depth 3
	ld	(ix - 3), iy
	ld	hl, 40
	or	a, a
	sbc	hl, bc
	ld	(ix - 36), hl
	ld	(ix - 27), bc
	push	bc
	pop	hl
	ld	bc, 24
	call	__imulu
	ld	iy, 0
	lea	de, iy + 0
	ld	bc, -3355443
	call	__i48mulu
	ld	c, 24
	call	__i48shru
	ld	c, 6
	call	__ishru
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	(ix - 33), hl
	lea	bc, iy + 0
	ld	iy, (ix - 3)
	.local	.LBB13_2
.LBB13_2:                               ;   Parent Loop BB13_1 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB13_5 Depth 3
                                        ;       Child Loop BB13_51 Depth 3
                                        ;       Child Loop BB13_48 Depth 3
                                        ;       Child Loop BB13_44 Depth 3
                                        ;       Child Loop BB13_35 Depth 3
                                        ;       Child Loop BB13_14 Depth 3
	ld	a, (iy)
	push	bc
	pop	hl
	ld	de, -8388608
	add	hl, de
	ld	de, -8388480
	or	a, a
	sbc	hl, de
	ld	(ix - 3), bc
	push	bc
	pop	iy
	jr	nc, .LBB13_4
; %bb.3:                                ;   in Loop: Header=BB13_2 Depth=2
	ld	iy, 127
	.local	.LBB13_4
.LBB13_4:                               ;   in Loop: Header=BB13_2 Depth=2
	lea	bc, iy + 0
	inc	bc
	ld	hl, (ix - 3)
	ld	(ix - 12), a
	.local	.LBB13_5
.LBB13_5:                               ;   Parent Loop BB13_1 Depth=1
                                        ;     Parent Loop BB13_2 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ex	de, hl
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	jr	z, .LBB13_8
; %bb.6:                                ;   in Loop: Header=BB13_5 Depth=3
	push	de
	pop	hl
	inc	hl
	ld	(ix - 6), bc
	lea	bc, iy + 0
	ld	iy, (ix - 18)
	add	iy, de
	ld	a, (iy + 1)
	push	bc
	pop	iy
	ld	c, (ix - 12)
	cp	a, c
	ld	bc, (ix - 6)
	ld	a, (ix - 12)                    ; 1-byte Folded Reload
	jr	z, .LBB13_5
; %bb.7:                                ;   in Loop: Header=BB13_2 Depth=2
	ld	(ix - 21), de
	push	hl
	pop	bc
	jr	.LBB13_9
	.local	.LBB13_8
.LBB13_8:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	(ix - 21), iy
	.local	.LBB13_9
.LBB13_9:                               ;   in Loop: Header=BB13_2 Depth=2
	push	bc
	pop	hl
	ld	de, (ix - 3)
	or	a, a
	sbc	hl, de
	ld	(ix - 6), hl
	ld	e, a
	cp	a, -1
	jr	nz, .LBB13_11
	.local	.LBB13_10
.LBB13_10:                              ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, (ix - 9)
	ld	de, (ix - 6)
	add	hl, de
	ld	(ix - 9), hl
	ld	hl, (ix - 15)
	add	hl, de
	ld	(ix - 15), hl
	ld	iy, (ix - 18)
	add	iy, bc
	ld	de, -8388608
	ld	hl, (ix - 21)
	add	hl, de
	ld	de, -8388481
	or	a, a
	sbc	hl, de
	jp	c, .LBB13_2
	jp	.LBB13_52
	.local	.LBB13_11
.LBB13_11:                              ;   in Loop: Header=BB13_2 Depth=2
	ld	(ix - 24), bc
	ld	iy, _render_stats+6
	ld	hl, (iy)
	inc.sis	hl
	ld	(iy), l
	ld	(iy + 1), h
	ld	l, 127
	ld	a, e
	and	a, l
	ld	l, a
	ld	iy, (_map_sectors)
	ld	(ix - 45), l                    ; 1-byte Folded Spill
	add	a, a
	ld	bc, 0
	ld	c, a
	ld	hl, _sector_offsets
	ld	(ix - 42), bc
	add	hl, bc
	ld	hl, (hl)
	ld	bc, 0
	ld	c, l
	ld	b, h
	add	iy, bc
	ld	a, e
	add	a, -128
	cp	a, -128
	ccf
	sbc	hl, hl
	push	hl
	pop	bc
	add	iy, bc
	ld	a, (iy + 5)
	cp	a, -1
	jp	nz, .LBB13_15
; %bb.12:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, (ix - 6)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	ld	bc, (ix - 24)
	jp	z, .LBB13_10
; %bb.13:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	iy, (ix - 9)
	ld	de, (ix - 3)
	.local	.LBB13_14
.LBB13_14:                              ;   Parent Loop BB13_1 Depth=1
                                        ;     Parent Loop BB13_2 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ld	(ix - 3), de
	ld	hl, _player+18
	ld	hl, (hl)
                                        ; kill: def $hl killed $hl killed $uhl
	ld	c, 3
	call	__sshru
	ld	de, 0
	ld	e, l
	ld	d, h
	ld	(ix - 12), de
	ld	de, (ix - 3)
	push	de
	pop	hl
	add	hl, hl
	sbc	hl, hl
	ld	c, 22
	call	__ishru
	push	hl
	pop	bc
	ex	de, hl
	add	hl, bc
	ld	c, 2
	call	__ishrs
	ld	de, (ix - 12)
	add	hl, de
	ld	bc, 31
	call	__iand
	ld	bc, (ix - 24)
	ld	de, (ix - 33)
	add	hl, de
	ex	de, hl
	ld	hl, (ix - 48)
	add	hl, de
	ld	a, (hl)
	ld	(iy), a
	ld	de, (ix - 3)
	inc	de
	inc	iy
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	jp	nz, .LBB13_14
	jp	.LBB13_10
	.local	.LBB13_15
.LBB13_15:                              ;   in Loop: Header=BB13_2 Depth=2
	or	a, a
	sbc	hl, hl
	ld	l, a
	ld	(ix - 51), hl
	ld	hl, (ix - 27)
	ld	bc, 40
	sbc	hl, bc
	ld	hl, 8192
	ld	(ix - 30), hl
	ld	(ix - 39), hl
	ld	hl, _shade_rows+93
	jp	z, .LBB13_27
; %bb.16:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	a, (ix - 12)                    ; 1-byte Folded Reload
	add	a, -128
	cp	a, -128
	ld	hl, _sector_floor
	jr	nc, .LBB13_18
; %bb.17:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, _sector_ceiling
	.local	.LBB13_18
.LBB13_18:                              ;   in Loop: Header=BB13_2 Depth=2
	ld	de, (ix - 42)
	add	hl, de
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	ld	hl, _player+8
	ld	iy, (hl)
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc, (ix - 36)
	call	__idivs
	push	hl
	pop	bc
	push	bc
	pop	iy
	ld	de, -8388608
	add	iy, de
	lea	hl, iy + 0
	ld	de, -8388606
	or	a, a
	sbc	hl, de
	ld	(ix - 39), bc
	jr	nc, .LBB13_20
; %bb.19:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	bc, 1
	.local	.LBB13_20
.LBB13_20:                              ;   in Loop: Header=BB13_2 Depth=2
	ld	(ix - 30), bc
	push	bc
	pop	hl
	ld	de, 8192
	or	a, a
	sbc	hl, de
	ld	bc, 0
	jr	c, .LBB13_22
; %bb.21:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, 8192
	ld	(ix - 30), hl
	.local	.LBB13_22
.LBB13_22:                              ;   in Loop: Header=BB13_2 Depth=2
	lea	hl, iy + 0
	ld	de, -8384512
	or	a, a
	sbc	hl, de
	jr	c, .LBB13_24
; %bb.23:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, _shade_rows+93
	jp	.LBB13_27
	.local	.LBB13_24
.LBB13_24:                              ;   in Loop: Header=BB13_2 Depth=2
	push	bc
	pop	de
	ld	e, (ix - 45)                    ; 1-byte Folded Reload
	ld	hl, (ix - 30)
	ld	c, 7
	call	__ishru
	ld	iy, _sector_shades
	add	iy, de
	ld	a, (iy)
                                        ; kill: def $l killed $l killed $uhl
	add	a, l
	ld	c, a
	cp	a, 31
	jr	c, .LBB13_26
; %bb.25:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	c, 31
	.local	.LBB13_26
.LBB13_26:                              ;   in Loop: Header=BB13_2 Depth=2
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	bc, 3
	call	__imulu
	ex	de, hl
	ld	hl, _shade_rows
	add	hl, de
	.local	.LBB13_27
.LBB13_27:                              ;   in Loop: Header=BB13_2 Depth=2
	ld	iy, (hl)
	ld	hl, (ix - 51)
	ld	bc, 3
	call	__imulu
	ex	de, hl
	ld	hl, _images
	add	hl, de
	ld	hl, (hl)
	ld	a, (_player+31)
	bit	0, a
	jp	z, .LBB13_36
; %bb.28:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	(ix - 57), hl
	ld	(ix - 54), iy
	ld	hl, (_camsin)
	ld	de, (ix - 30)
	push	de
	pop	bc
	ld	(ix - 30), de
	call	__imulu
	ld	(ix - 12), hl
	ld	a, 6
	ld	c, a
	call	__ishrs
	ld	(ix - 45), hl
	ld	hl, (_camcos)
	push	de
	pop	bc
	call	__imulu
	ex	de, hl
	or	a, a
	sbc	hl, hl
	sbc	hl, de
	ld	c, a
	call	__ishrs
	ld	(ix - 51), hl
	ld	bc, (_player)
	push	de
	pop	iy
	add	iy, bc
	ld	hl, (ix - 3)
	ld	de, -64
	add	hl, de
	push	hl
	pop	bc
	ld	hl, (ix - 45)
	call	__imulu
	ex	de, hl
	add	iy, de
	ld	(ix - 42), iy
	ld	de, (_player+4)
	ld	iy, (ix - 12)
	add	iy, de
	ld	hl, (ix - 51)
	call	__imulu
	ex	de, hl
	lea	hl, iy + 0
	add	hl, de
	ld	(ix - 12), hl
	ld	hl, (ix - 30)
	ld	c, 4
	call	__ishru
	push	hl
	pop	bc
	ld	de, 254
	or	a, a
	sbc	hl, de
	jr	c, .LBB13_30
; %bb.29:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	bc, 254
	.local	.LBB13_30
.LBB13_30:                              ;   in Loop: Header=BB13_2 Depth=2
	ld	de, -8388608
	ld	hl, (ix - 39)
	add	hl, de
	ld	de, -8388576
	or	a, a
	sbc	hl, de
	ld	de, 3
	push	de
	pop	iy
	jr	nc, .LBB13_32
; %bb.31:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	bc, 1
	.local	.LBB13_32
.LBB13_32:                              ;   in Loop: Header=BB13_2 Depth=2
	ld	(ix - 30), bc
	ld	bc, (_render_detail)
	push	bc
	pop	hl
	ld	de, 2
	or	a, a
	sbc	hl, de
	jp	nz, .LBB13_41
; %bb.33:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, (ix - 6)
	or	a, a
	sbc	hl, de
	ld	bc, (ix - 24)
	jp	c, .LBB13_10
; %bb.34:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, (ix - 6)
	call	__ishru_1
	ex	de, hl
	ld	hl, (ix - 45)
	add	hl, hl
	ld	(ix - 39), hl
	ld	hl, (ix - 51)
	add	hl, hl
	ld	(ix - 45), hl
	ld	hl, (ix - 30)
	ld	a, l
	ld	hl, (ix - 9)
	ld	(ix - 3), hl
	ld	hl, (ix - 15)
	ld	(ix - 30), hl
	.local	.LBB13_35
.LBB13_35:                              ;   Parent Loop BB13_1 Depth=1
                                        ;     Parent Loop BB13_2 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	dec	de
	ld	hl, (ix - 12)
	ld	c, 4
	call	__ishru
	ld	bc, 992
	call	__iand
	push	hl
	pop	iy
	ld	hl, (ix - 42)
	ld	c, 9
	call	__ishru
	ld	bc, 31
	call	__iand
	lea	bc, iy + 0
	add	hl, bc
	push	hl
	pop	bc
	ld	hl, (ix - 57)
	add	hl, bc
	ld	l, (hl)
	ld	bc, 0
	ld	c, l
	ld	hl, (ix - 54)
	add	hl, bc
	ld	bc, (ix - 24)
	ld	l, (hl)
	ld	iy, (ix - 3)
	ld	(iy), l
	ld	hl, (ix - 30)
	ld	(hl), a
	lea	iy, iy + 2
	ld	(ix - 3), iy
	push	hl
	pop	iy
	lea	iy, iy + 2
	ld	(ix - 30), iy
	push	de
	pop	iy
	ld	de, (ix - 39)
	ld	hl, (ix - 42)
	add	hl, de
	ld	(ix - 42), hl
	lea	hl, iy + 0
	ld	de, (ix - 45)
	ld	iy, (ix - 12)
	add	iy, de
	ld	(ix - 12), iy
	push	hl
	pop	de
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jr	nz, .LBB13_35
	jp	.LBB13_10
	.local	.LBB13_36
.LBB13_36:                              ;   in Loop: Header=BB13_2 Depth=2
	ld	de, 528
	add	hl, de
	push	hl
	pop	bc
	or	a, a
	sbc	hl, hl
	ex	de, hl
	push	bc
	pop	hl
	ld	e, (hl)
	add	iy, de
	ld	a, (iy)
	ld	hl, (ix - 6)
	push	hl
	ld	l, a
	push	hl
	ld	hl, (ix - 9)
	push	hl
	call	_memset
	ld	hl, 9
	add	hl, sp
	ld	sp, hl
	ld	hl, (ix - 30)
	ld	c, 4
	call	__ishru
	push	hl
	pop	de
	ld	bc, 254
	or	a, a
	sbc	hl, bc
	jr	c, .LBB13_38
; %bb.37:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	de, 254
	.local	.LBB13_38
.LBB13_38:                              ;   in Loop: Header=BB13_2 Depth=2
	ld	bc, -8388608
	ld	hl, (ix - 39)
	add	hl, bc
	ld	bc, -8388576
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB13_40
; %bb.39:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	a, 1
	ld	e, a
	.local	.LBB13_40
.LBB13_40:                              ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, (ix - 6)
	push	hl
	push	de
	ld	hl, (ix - 15)
	push	hl
	call	_memset
	ld	hl, 9
	add	hl, sp
	ld	sp, hl
	ld	bc, (ix - 24)
	jp	.LBB13_10
	.local	.LBB13_41
.LBB13_41:                              ;   in Loop: Header=BB13_2 Depth=2
	push	bc
	pop	hl
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	nz, .LBB13_45
; %bb.42:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, (ix - 6)
	or	a, a
	sbc	hl, de
	ld	bc, (ix - 24)
	jp	c, .LBB13_10
; %bb.43:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, (ix - 6)
	ld	de, 0
	ld	bc, -5592405
	push	de
	pop	iy
	call	__i48mulu
	ld	c, 24
	call	__i48shru
	call	__ishru_1
	ex	de, hl
	ld	hl, (ix - 45)
	ld	bc, 3
	call	__imulu
	ld	(ix - 39), hl
	ld	hl, (ix - 51)
	call	__imulu
	ld	(ix - 45), hl
	ld	hl, (ix - 30)
	ld	a, l
	ld	hl, (ix - 9)
	ld	(ix - 3), hl
	ld	hl, (ix - 15)
	ld	(ix - 30), hl
	.local	.LBB13_44
.LBB13_44:                              ;   Parent Loop BB13_1 Depth=1
                                        ;     Parent Loop BB13_2 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	dec	de
	ld	hl, (ix - 12)
	ld	c, 4
	call	__ishru
	ld	bc, 992
	call	__iand
	push	hl
	pop	iy
	ld	hl, (ix - 42)
	ld	c, 9
	call	__ishru
	ld	bc, 31
	call	__iand
	lea	bc, iy + 0
	add	hl, bc
	push	hl
	pop	bc
	ld	hl, (ix - 57)
	add	hl, bc
	ld	l, (hl)
	ld	bc, 0
	ld	c, l
	ld	hl, (ix - 54)
	add	hl, bc
	ld	bc, (ix - 24)
	ld	l, (hl)
	ld	iy, (ix - 3)
	ld	(iy), l
	ld	hl, (ix - 30)
	ld	(hl), a
	lea	iy, iy + 3
	ld	(ix - 3), iy
	push	hl
	pop	iy
	lea	iy, iy + 3
	ld	(ix - 30), iy
	push	de
	pop	iy
	ld	de, (ix - 39)
	ld	hl, (ix - 42)
	add	hl, de
	ld	(ix - 42), hl
	lea	hl, iy + 0
	ld	de, (ix - 45)
	ld	iy, (ix - 12)
	add	iy, de
	ld	(ix - 12), iy
	push	hl
	pop	de
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jr	nz, .LBB13_44
	jp	.LBB13_10
	.local	.LBB13_45
.LBB13_45:                              ;   in Loop: Header=BB13_2 Depth=2
	push	bc
	pop	hl
	ld	de, 4
	or	a, a
	sbc	hl, de
	jp	nz, .LBB13_49
; %bb.46:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, (ix - 6)
	or	a, a
	sbc	hl, de
	ld	bc, (ix - 24)
	jp	c, .LBB13_10
; %bb.47:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, (ix - 6)
	ld	c, 2
	call	__ishru
	ex	de, hl
	ld	hl, (ix - 45)
	add	hl, hl
	add	hl, hl
	ld	(ix - 39), hl
	ld	hl, (ix - 51)
	add	hl, hl
	add	hl, hl
	ld	(ix - 45), hl
	ld	hl, (ix - 30)
	ld	a, l
	ld	hl, (ix - 9)
	ld	(ix - 3), hl
	ld	hl, (ix - 15)
	ld	(ix - 30), hl
	.local	.LBB13_48
.LBB13_48:                              ;   Parent Loop BB13_1 Depth=1
                                        ;     Parent Loop BB13_2 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	dec	de
	ld	hl, (ix - 12)
	ld	c, 4
	call	__ishru
	ld	bc, 992
	call	__iand
	push	hl
	pop	iy
	ld	hl, (ix - 42)
	ld	c, 9
	call	__ishru
	ld	bc, 31
	call	__iand
	lea	bc, iy + 0
	add	hl, bc
	push	hl
	pop	bc
	ld	hl, (ix - 57)
	add	hl, bc
	ld	l, (hl)
	ld	bc, 0
	ld	c, l
	ld	hl, (ix - 54)
	add	hl, bc
	ld	bc, (ix - 24)
	ld	l, (hl)
	ld	iy, (ix - 3)
	ld	(iy), l
	ld	hl, (ix - 30)
	ld	(hl), a
	lea	iy, iy + 4
	ld	(ix - 3), iy
	push	hl
	pop	iy
	lea	iy, iy + 4
	ld	(ix - 30), iy
	push	de
	pop	iy
	ld	de, (ix - 39)
	ld	hl, (ix - 42)
	add	hl, de
	ld	(ix - 42), hl
	lea	hl, iy + 0
	ld	de, (ix - 45)
	ld	iy, (ix - 12)
	add	iy, de
	ld	(ix - 12), iy
	push	hl
	pop	de
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jr	nz, .LBB13_48
	jp	.LBB13_10
	.local	.LBB13_49
.LBB13_49:                              ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, (ix - 6)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	ld	bc, (ix - 24)
	jp	z, .LBB13_10
; %bb.50:                               ;   in Loop: Header=BB13_2 Depth=2
	ld	hl, (ix - 30)
	ld	a, l
	ld	hl, (ix - 3)
	or	a, a
	sbc	hl, bc
	ld	de, (ix - 9)
	ld	(ix - 3), de
	ld	de, (ix - 15)
	ld	(ix - 30), de
	.local	.LBB13_51
.LBB13_51:                              ;   Parent Loop BB13_1 Depth=1
                                        ;     Parent Loop BB13_2 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ld	(ix - 39), hl
	ld	hl, (ix - 12)
	ld	c, 4
	call	__ishru
	ld	bc, 992
	call	__iand
	ex	de, hl
	ld	hl, (ix - 42)
	ld	c, 9
	call	__ishru
	ld	bc, 31
	call	__iand
	ld	bc, (ix - 24)
	add	hl, de
	ex	de, hl
	ld	hl, (ix - 57)
	add	hl, de
	ld	l, (hl)
	ld	de, 0
	ld	e, l
	ld	hl, (ix - 54)
	add	hl, de
	ld	l, (hl)
	ld	iy, (ix - 3)
	ld	(iy), l
	ld	hl, (ix - 39)
	inc	iy
	ld	(ix - 3), iy
	ld	iy, (ix - 30)
	ld	(iy), a
	inc	iy
	ld	(ix - 30), iy
	ld	de, (ix - 45)
	ld	iy, (ix - 42)
	add	iy, de
	ld	(ix - 42), iy
	ld	de, (ix - 51)
	ld	iy, (ix - 12)
	add	iy, de
	ld	(ix - 12), iy
	ld	de, 1
	add	hl, de
	jr	nc, .LBB13_51
	jp	.LBB13_10
	.local	.LBB13_52
.LBB13_52:                              ;   in Loop: Header=BB13_1 Depth=1
	ld	bc, (ix - 27)
	inc	bc
	push	bc
	pop	hl
	ld	de, 80
	or	a, a
	sbc	hl, de
	ld	(ix - 18), iy
	jp	nz, .LBB13_1
; %bb.53:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end13
.Lfunc_end13:
	.size	_draw_planes, .Lfunc_end13-_draw_planes
                                        ; -- End function
	.section	.text._draw_sprites,"ax",@progbits
	.type	_draw_sprites,@function         ; -- Begin function draw_sprites
_draw_sprites:                          ; @draw_sprites
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 69
	ld	sp, hl
	ld	de, 0
	ld	hl, (_camx)
	ld	(ix - 12), hl
	ld	hl, (_camy)
	ld	(ix - 15), hl
	ld	hl, (_camsin)
	ld	(ix - 6), hl
	ld	hl, (_camcos)
	ld	(ix - 21), hl
	ld	(ix - 18), de
	.local	.LBB14_1
.LBB14_1:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB14_6 Depth 2
	push	de
	pop	hl
	ld	bc, 12
	call	__imulu
	push	hl
	pop	bc
	ld	iy, _actors
	add	iy, bc
	ld	a, (iy + 6)
	or	a, a
	jp	nz, .LBB14_11
; %bb.2:                                ;   in Loop: Header=BB14_1 Depth=1
	ld	(ix - 24), de
	ld	bc, (iy)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	bc, (ix - 12)
	or	a, a
	sbc	hl, bc
	ld	(ix - 9), hl
	ld	bc, (iy + 2)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	bc, (ix - 15)
	or	a, a
	sbc	hl, bc
	ex	de, hl
	ld	hl, (ix - 6)
	ld	bc, (ix - 9)
	call	__imulu
	ld	(ix - 27), hl
	ld	iy, (ix - 21)
	lea	hl, iy + 0
	push	de
	pop	bc
	call	__imulu
	push	hl
	pop	bc
	ld	hl, (ix - 27)
	or	a, a
	sbc	hl, bc
	ld	a, 8
	ld	c, a
	call	__ishru
	push	hl
	pop	bc
	ld	hl, _d84_rotated
	ld	(ix - 27), bc
	ld	(hl), c
	inc	hl
	ld	(hl), b
	lea	hl, iy + 0
	ld	bc, (ix - 9)
	call	__imulu
	push	hl
	pop	iy
	ld	hl, (ix - 6)
	push	de
	pop	bc
	call	__imulu
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	ld	c, a
	call	__ishru
	push	hl
	pop	iy
	ld	hl, _d84_rotated+2
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	bc, -32768
	add.sis	hl, bc
	ld	(ix - 9), l
	ld	(ix - 8), h
	ld.sis	bc, -32760
	or	a, a
	sbc.sis	hl, bc
	jr	nc, .LBB14_4
; %bb.3:                                ;   in Loop: Header=BB14_1 Depth=1
	ld	de, (ix - 24)
	jp	.LBB14_11
	.local	.LBB14_4
.LBB14_4:                               ;   in Loop: Header=BB14_1 Depth=1
	ld	bc, (ix - 27)
	ld	l, c
	ld	h, b
	add.sis	hl, hl
	sbc.sis	hl, hl
	ex.sis	de, hl
	ld	l, c
	ld	h, b
	add.sis	hl, de
	ld	a, l
	xor	a, e
	ld	c, a
	ld	a, h
	xor	a, d
	ld	b, a
	ld	e, c
	ld	d, b
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	bc, 64
	add.sis	hl, bc
	or	a, a
	sbc.sis	hl, de
	ld	de, (ix - 24)
	jp	c, .LBB14_11
; %bb.5:                                ;   in Loop: Header=BB14_1 Depth=1
	push	de
	pop	hl
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _sprite_z
	add	hl, bc
	push	de
	lea	de, iy + 0
	ld	(hl), e
	inc	hl
	ld	(hl), d
	pop	de
	ld	hl, _sprite_x
	add	hl, bc
	ld	bc, (ix - 27)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	ld	bc, (ix - 18)
	sbc	hl, hl
	adc	hl, bc
	ld	hl, 0
	ld	(ix - 27), hl
	jp	z, .LBB14_10
	.local	.LBB14_6
.LBB14_6:                               ;   Parent Loop BB14_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ld	(ix - 27), bc
	ld	hl, _sprite_order
	push	hl
	pop	iy
	add	iy, bc
	ld	(ix - 30), iy
	ld	a, (iy - 1)
	or	a, a
	sbc	hl, hl
	ld	l, a
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _sprite_z
	add	hl, bc
	ld	hl, (hl)
	ld.sis	bc, -32768
	add.sis	hl, bc
                                        ; kill: def $hl killed $hl killed $uhl
	ld	c, (ix - 9)
	ld	b, (ix - 8)
	or	a, a
	sbc.sis	hl, bc
	jr	nc, .LBB14_9
; %bb.7:                                ;   in Loop: Header=BB14_6 Depth=2
	ld	bc, (ix - 27)
	dec	bc
	ld	hl, (ix - 30)
	ld	(hl), a
	sbc	hl, hl
	adc	hl, bc
	jp	nz, .LBB14_6
; %bb.8:                                ;   in Loop: Header=BB14_1 Depth=1
	or	a, a
	sbc	hl, hl
	ld	(ix - 27), hl
	.local	.LBB14_9
.LBB14_9:                               ;   in Loop: Header=BB14_1 Depth=1
	ld	bc, (ix - 18)
	.local	.LBB14_10
.LBB14_10:                              ;   in Loop: Header=BB14_1 Depth=1
	ld	a, e
	ld	hl, _sprite_order
	push	bc
	pop	iy
	ld	bc, (ix - 27)
	add	hl, bc
	ld	(hl), a
	inc	iy
	ld	(ix - 18), iy
	.local	.LBB14_11
.LBB14_11:                              ;   in Loop: Header=BB14_1 Depth=1
	inc	de
	push	de
	pop	hl
	ld	bc, 91
	or	a, a
	sbc	hl, bc
	jp	nz, .LBB14_1
; %bb.12:
	ld	hl, (ix - 18)
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jr	nz, .LBB14_14
	.local	.LBB14_13
.LBB14_13:
	ld	sp, ix
	pop	ix
	ret
	.local	.LBB14_14
.LBB14_14:
	ld	a, (_player+24)
	bit	3, a
	jr	z, .LBB14_16
; %bb.15:
	ld	hl, 0
	jr	.LBB14_17
	.local	.LBB14_16
.LBB14_16:
	ld	hl, -1
	.local	.LBB14_17
.LBB14_17:
	ld	(ix - 62), hl
	ld	hl, (_map_actors)
	ld	(ix - 47), hl
	ld	hl, _player+8
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 50), hl
	ld	hl, (_render_detail)
	ld	(ix - 27), hl
	ld	h, 0
	ld	(ix - 21), hl
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	.local	.LBB14_18
.LBB14_18:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB14_66 Depth 2
                                        ;       Child Loop BB14_69 Depth 3
	ld	hl, _sprite_order
	ld	(ix - 39), bc
	add	hl, bc
	ld	a, (hl)
	ld	iy, 0
	ld	iyl, a
	lea	hl, iy + 0
	ld	bc, 14
	call	__imulu
	ex	de, hl
	ld	hl, (ix - 47)
	add	hl, de
	ld	(ix - 12), hl
	lea	hl, iy + 0
	ld	bc, 12
	call	__imulu
	ex	de, hl
	ld	hl, _actors
	add	hl, de
	ld	(ix - 15), hl
	add	iy, iy
	lea	de, iy + 0
	ld	hl, _sprite_z
	add	hl, de
	ld	iy, (hl)
	ld	(ix - 9), iy
	ld	a, iyh
	rlc	a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, iyl
	ld	b, iyh
	ld	hl, _sprite_x
	add	hl, de
	ld	de, (hl)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	(ix - 24), bc
	call	__idivs
	ld	de, 64
	add	hl, de
	ld	(ix - 30), hl
	ld	iy, (ix - 12)
	ld	a, (iy + 9)
	ld	hl, (ix - 21)
	ld	l, a
	ld	(ix - 21), hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc, (ix - 9)
                                        ; kill: def $bc killed $bc killed $ubc
	call	__sdivs
	ld	e, l
	ld	d, h
	ld.sis	bc, -32768
	add.sis	hl, bc
	ld.sis	bc, -32766
	or	a, a
	sbc.sis	hl, bc
	jr	nc, .LBB14_20
; %bb.19:                               ;   in Loop: Header=BB14_18 Depth=1
	ld.sis	de, 1
	.local	.LBB14_20
.LBB14_20:                              ;   in Loop: Header=BB14_18 Depth=1
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	c, e
	ld	b, d
	ld	(ix - 6), bc
	ld	iy, (ix - 12)
	ld	a, (iy + 10)
	push	hl
	pop	bc
	ld	(ix - 36), a                    ; 1-byte Folded Spill
	ld	c, a
	ld	iy, (ix - 15)
	ld	l, (iy + 8)
	ld	a, l
	or	a, a
	ld	de, (ix - 9)
	jr	nz, .LBB14_25
; %bb.21:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	iy, (ix - 12)
	ld	a, (iy + 11)
	or	a, a
	jp	nz, .LBB14_28
	.local	.LBB14_22
.LBB14_22:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	iy, (ix - 15)
	ld	a, (iy + 9)
	or	a, a
	jp	nz, .LBB14_34
; %bb.23:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	de, (ix - 62)
	ld	iy, (ix - 12)
	add	iy, de
	ld	a, (iy + 7)
	ld	iy, (ix - 9)
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld.sis	de, -32768
	add.sis	hl, de
	ld.sis	de, -28672
	or	a, a
	sbc.sis	hl, de
	jp	c, .LBB14_40
; %bb.24:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	hl, _shade_rows+93
	push	bc
	pop	iy
	jp	.LBB14_44
	.local	.LBB14_25
.LBB14_25:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	(ix - 33), bc
	ld	iy, 0
	lea	de, iy + 0
	ld	e, l
	dec	de
	ld	(ix - 3), de
	ld	a, (ix - 1)
	ld	l, e
	ld	bc, (ix - 21)
	ld	h, b
	ld.sis	bc, 171
	call	__smulu
	ld	c, l
	ld	b, h
	ex	de, hl
	ld	de, 15
	or	a, a
	sbc	hl, de
	ld	de, 4
	jp	nc, .LBB14_27
; %bb.26:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	hl, (ix - 21)
                                        ; kill: def $h killed $h killed $uhl def $hl
	ld	l, b
	ld	a, l
	srl	a
	ld	iyl, a
	lea	de, iy + 0
	.local	.LBB14_27
.LBB14_27:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	hl, _barrel_explode
	add	hl, de
	ld	a, (hl)
	ld	de, (ix - 6)
	push	de
	pop	hl
	ld	c, 2
	call	__ishru
	add	hl, de
	ld	(ix - 6), hl
	ld	de, (ix - 33)
	push	de
	pop	hl
	call	__ishru
	push	hl
	pop	iy
	add	iy, de
	ld	hl, _shade_rows
	jp	.LBB14_44
	.local	.LBB14_28
.LBB14_28:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	iy, (ix - 15)
	ld	d, (iy + 10)
	ld	a, d
	inc	a
	cp	a, 2
	jr	nc, .LBB14_35
; %bb.29:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	a, (iy + 5)
	or	a, a
	jp	nz, .LBB14_22
; %bb.30:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	iy, (ix - 12)
	ld	a, (iy + 8)
	ld	(ix - 12), a
	push	bc
	pop	hl
	ld	c, 2
	call	__ishru
	ld	a, (ix - 36)                    ; 1-byte Folded Reload
	cp	a, 4
	ld	iy, 1
	jr	c, .LBB14_32
; %bb.31:                               ;   in Loop: Header=BB14_18 Depth=1
	push	hl
	pop	iy
	.local	.LBB14_32
.LBB14_32:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	bc, (ix - 9)
	ld	l, c
	ld	h, b
	ld.sis	de, -32768
	add.sis	hl, de
	ld.sis	de, -28672
	or	a, a
	sbc.sis	hl, de
	jp	c, .LBB14_75
; %bb.33:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	hl, _shade_rows+93
	jp	.LBB14_43
	.local	.LBB14_34
.LBB14_34:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	iy, (ix - 12)
	ld	a, (iy + 7)
	ld	hl, _shade_rows
	push	bc
	pop	iy
	jp	.LBB14_44
	.local	.LBB14_35
.LBB14_35:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	(ix - 33), bc
	ld	a, d
	cp	a, 9
	sbc	hl, hl
	ld	bc, 8
	add	hl, bc
	cp	a, 5
	ld	bc, 6
	jr	c, .LBB14_37
; %bb.36:                               ;   in Loop: Header=BB14_18 Depth=1
	push	hl
	pop	bc
	.local	.LBB14_37
.LBB14_37:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	iy, 0
	ld	iyl, d
	ld	hl, (ix - 12)
	add	hl, bc
	ld	a, (hl)
	ld	(ix - 12), a
	ld	hl, (ix - 33)
	ld	c, 2
	call	__ishru
	ld	a, (ix - 36)                    ; 1-byte Folded Reload
	cp	a, 4
	ld	de, 1
	jr	c, .LBB14_39
; %bb.38:                               ;   in Loop: Header=BB14_18 Depth=1
	ex	de, hl
	.local	.LBB14_39
.LBB14_39:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	hl, (ix - 33)
	or	a, a
	sbc	hl, de
	push	hl
	pop	bc
	dec	iy
	lea	hl, iy + 0
	call	__imulu
	ld	bc, -13
	call	__idivs
	push	hl
	pop	iy
	ld	de, (ix - 33)
	add	iy, de
	ld	hl, _shade_rows
	jp	.LBB14_43
	.local	.LBB14_40
.LBB14_40:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	(ix - 12), a                    ; 1-byte Folded Spill
	ld	(ix - 33), bc
	lea	bc, iy + 0
	ld	iy, (ix - 15)
	ld	a, (iy + 4)
	ld	de, 0
	ld	e, a
	ld	hl, _sector_shades
	add	hl, de
	ld	a, (hl)
	ld	l, c
	ld	h, b
	ld	c, 7
	call	__sshru
                                        ; kill: def $l killed $l killed $hl
	add	a, l
	ld	e, a
	cp	a, 31
	jr	c, .LBB14_42
; %bb.41:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	e, 31
	.local	.LBB14_42
.LBB14_42:                              ;   in Loop: Header=BB14_18 Depth=1
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	bc, 3
	call	__imulu
	ex	de, hl
	ld	hl, _shade_rows
	add	hl, de
	ld	iy, (ix - 33)
	.local	.LBB14_43
.LBB14_43:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	a, (ix - 12)                    ; 1-byte Folded Reload
	.local	.LBB14_44
.LBB14_44:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	hl, (hl)
	ld	(ix - 56), hl
	ld	de, 0
	ld	e, a
	ld	(ix - 33), de
	lea	hl, iy + 0
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc, (ix - 24)
	call	__idivs
	push	hl
	pop	iy
	ld	bc, -8388608
	add	hl, bc
	ld	bc, -8388606
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB14_46
; %bb.45:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	iy, 1
	.local	.LBB14_46
.LBB14_46:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	hl, (ix - 6)
	call	__ishru_1
	lea	de, iy + 0
	push	hl
	pop	bc
	ld	hl, (ix - 30)
	or	a, a
	sbc	hl, bc
	ld	(ix - 12), hl
	ld	iy, (ix - 15)
	ld	a, (iy + 4)
	or	a, a
	sbc	hl, hl
	ld	l, a
	add	hl, hl
	push	hl
	pop	bc
	ld	hl, _sector_floor
	add	hl, bc
	ld	bc, (hl)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	bc, (ix - 50)
	or	a, a
	sbc	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc, (ix - 24)
	call	__idivs
	push	hl
	pop	bc
	ld	hl, 40
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	ld	(ix - 42), de
	or	a, a
	sbc	hl, de
	ld	(ix - 36), hl
	ld	hl, (ix - 33)
	ld	bc, 3
	call	__imulu
	ex	de, hl
	ld	hl, _images
	add	hl, de
	ld	hl, (hl)
	ld	(ix - 53), hl
	ld	de, (ix - 9)
	ld	l, e
	ld	h, d
	add.sis	hl, hl
	sbc.sis	hl, hl
	ld	c, 12
	call	__sshru
	ld	c, l
	ld	b, h
	ld	l, e
	ld	h, d
	add.sis	hl, bc
	ld	c, 4
	call	__sshrs
	ld	c, l
	ld	b, h
	ld.sis	de, -32768
	add.sis	hl, de
	ld.sis	de, -32514
	or	a, a
	sbc.sis	hl, de
	jr	c, .LBB14_48
; %bb.47:                               ;   in Loop: Header=BB14_18 Depth=1
	ld.sis	bc, 254
	.local	.LBB14_48
.LBB14_48:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	(ix - 44), c
	ld	(ix - 43), b
	ld	bc, (ix - 12)
	push	bc
	pop	hl
	ld	de, -8388608
	add	hl, de
	inc	de
	or	a, a
	sbc	hl, de
	jr	nc, .LBB14_50
; %bb.49:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	de, 0
	push	de
	pop	bc
	.local	.LBB14_50
.LBB14_50:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	(ix - 33), bc
	ld	hl, (ix - 12)
	ld	de, (ix - 6)
	add	hl, de
	ld	(ix - 15), hl
	ld	bc, -8388608
	add	hl, bc
	ld	bc, -8388480
	or	a, a
	sbc	hl, bc
	jr	c, .LBB14_52
; %bb.51:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	hl, 128
	ld	(ix - 15), hl
	.local	.LBB14_52
.LBB14_52:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	de, (ix - 36)
	push	de
	pop	hl
	ld	bc, -8388608
	add	hl, bc
	inc	bc
	or	a, a
	sbc	hl, bc
	ld	(ix - 24), de
	jr	nc, .LBB14_54
; %bb.53:                               ;   in Loop: Header=BB14_18 Depth=1
	or	a, a
	sbc	hl, hl
	ld	(ix - 24), hl
	.local	.LBB14_54
.LBB14_54:                              ;   in Loop: Header=BB14_18 Depth=1
	lea	hl, iy + 0
	ld	bc, -8388608
	add	hl, bc
	ld	bc, -8388528
	or	a, a
	sbc	hl, bc
	ld	(ix - 30), iy
	jr	c, .LBB14_56
; %bb.55:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	hl, 80
	ld	(ix - 30), hl
	.local	.LBB14_56
.LBB14_56:                              ;   in Loop: Header=BB14_18 Depth=1
	ld.sis	hl, 16384
	ld	bc, (ix - 6)
                                        ; kill: def $bc killed $bc killed $ubc
	call	__sdivu
	ld	(ix - 59), l
	ld	(ix - 58), h
	ld	hl, 16384
	ld	bc, (ix - 42)
	call	__idivu
	ld	(ix - 6), hl
	ld	bc, (ix - 27)
	push	bc
	pop	hl
	ld	de, 2
	or	a, a
	sbc	hl, de
	jr	c, .LBB14_58
; %bb.57:                               ;   in Loop: Header=BB14_18 Depth=1
	push	bc
	pop	iy
	ld	de, (ix - 33)
	add	iy, de
	dec	iy
	lea	hl, iy + 0
	call	__irems
	ex	de, hl
	lea	hl, iy + 0
	or	a, a
	sbc	hl, de
	ex	de, hl
	jr	.LBB14_59
	.local	.LBB14_58
.LBB14_58:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	de, (ix - 33)
	.local	.LBB14_59
.LBB14_59:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	iy, (ix - 15)
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	push	de
	pop	hl
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB14_74
; %bb.60:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	iy, (ix - 30)
	ld	hl, -8388608
	push	hl
	pop	bc
	add	iy, bc
	ld	hl, (ix - 24)
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jp	nc, .LBB14_74
; %bb.61:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	bc, (ix - 27)
	ld	hl, (ix - 15)
	add	hl, bc
	dec	hl
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	call	__idivu
	ld	(ix - 42), hl
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	jp	c, .LBB14_74
; %bb.62:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	iy, 0
	ld	l, (ix - 59)
	ld	h, (ix - 58)
	ex	de, hl
	ld	iyl, e
	ld	iyh, d
	ex	de, hl
	push	de
	pop	hl
	ld	(ix - 33), de
	ld	de, (ix - 12)
	or	a, a
	sbc	hl, de
	lea	bc, iy + 0
	call	__imulu
	ld	(ix - 68), hl
	ld	de, (ix - 24)
	push	de
	pop	hl
	ld	c, 7
	call	__ishl
	push	hl
	pop	bc
	ld	hl, (ix - 33)
	add	hl, bc
	ld	(ix - 12), hl
	ex	de, hl
	ld	de, (ix - 36)
	or	a, a
	sbc	hl, de
	ld	bc, (ix - 6)
	call	__imulu
	ex	de, hl
	ld	hl, (ix - 27)
	lea	bc, iy + 0
	call	__imulu
	ld	(ix - 36), hl
	ld.sis	bc, -32768
	ld	hl, (ix - 9)
	add.sis	hl, bc
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	bc, -32736
	or	a, a
	sbc.sis	hl, bc
	jr	nc, .LBB14_64
; %bb.63:                               ;   in Loop: Header=BB14_18 Depth=1
	ld.sis	hl, 1
	ld	c, l
	ld	b, h
	jr	.LBB14_65
	.local	.LBB14_64
.LBB14_64:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	hl, (ix - 21)
	ld	c, (ix - 44)
	ld	b, (ix - 43)
	ld	b, h
	.local	.LBB14_65
.LBB14_65:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	(ix - 44), c
	ld	(ix - 43), b
	ld	(ix - 69), c                    ; 1-byte Folded Spill
	ld	hl, _engine_view+2
	ld	bc, (ix - 12)
	add	hl, bc
	ld	(ix - 33), hl
	ld	hl, _depthbuffer
	add	hl, bc
	ld	(ix - 9), hl
	push	de
	pop	iy
	.local	.LBB14_66
.LBB14_66:                              ;   Parent Loop BB14_18 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB14_69 Depth 3
	lea	hl, iy + 0
	ld	c, 8
	call	__ishru
	push	hl
	pop	de
	ld	bc, 63
	or	a, a
	sbc	hl, bc
	jr	c, .LBB14_68
; %bb.67:                               ;   in Loop: Header=BB14_66 Depth=2
	ld	de, 63
	.local	.LBB14_68
.LBB14_68:                              ;   in Loop: Header=BB14_66 Depth=2
	ld	(ix - 59), iy
	ex	de, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, (ix - 53)
	add	hl, de
	ld	(ix - 65), hl
	or	a, a
	sbc	hl, hl
	push	hl
	pop	bc
	ld	de, (ix - 42)
	ld	iy, (ix - 68)
	.local	.LBB14_69
.LBB14_69:                              ;   Parent Loop BB14_18 Depth=1
                                        ;     Parent Loop BB14_66 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ld	(ix - 12), bc
	ld	hl, (ix - 9)
	add	hl, bc
	ld	l, (hl)
	ld	c, (ix - 44)
	ld	b, (ix - 43)
	ld	a, c
	cp	a, l
	jr	nc, .LBB14_72
; %bb.70:                               ;   in Loop: Header=BB14_69 Depth=3
	lea	hl, iy + 0
	ld	c, 8
	call	__ishru
	push	hl
	pop	bc
	ld	hl, (ix - 65)
	add	hl, bc
	ld	a, (hl)
	cp	a, -1
	jr	z, .LBB14_72
; %bb.71:                               ;   in Loop: Header=BB14_69 Depth=3
	ld	bc, 0
	ld	c, a
	ld	hl, (ix - 56)
	add	hl, bc
	ld	a, (hl)
	ld	hl, (ix - 33)
	ld	bc, (ix - 12)
	add	hl, bc
	ld	(hl), a
	ld	hl, (ix - 9)
	add	hl, bc
	ld	a, (ix - 69)
	ld	(hl), a
	.local	.LBB14_72
.LBB14_72:                              ;   in Loop: Header=BB14_69 Depth=3
	dec	de
	ld	bc, (ix - 36)
	add	iy, bc
	ld	(ix - 15), iy
	ld	iy, (ix - 12)
	ld	bc, (ix - 27)
	add	iy, bc
	sbc	hl, hl
	adc	hl, de
	lea	hl, iy + 0
	ld	iy, (ix - 15)
	push	hl
	pop	bc
	jr	nz, .LBB14_69
; %bb.73:                               ;   in Loop: Header=BB14_66 Depth=2
	ld	bc, (ix - 24)
	inc	bc
	ld	de, (ix - 6)
	ld	iy, (ix - 59)
	add	iy, de
	ld	hl, 128
	ex	de, hl
	ld	hl, (ix - 33)
	add	hl, de
	ld	(ix - 33), hl
	ld	hl, (ix - 9)
	add	hl, de
	ld	(ix - 9), hl
	ld	(ix - 24), bc
	push	bc
	pop	hl
	ld	de, (ix - 30)
	or	a, a
	sbc	hl, de
	jp	nz, .LBB14_66
	.local	.LBB14_74
.LBB14_74:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	bc, (ix - 39)
	inc	bc
	push	bc
	pop	hl
	ld	de, (ix - 18)
	or	a, a
	sbc	hl, de
	jp	nz, .LBB14_18
	jp	.LBB14_13
	.local	.LBB14_75
.LBB14_75:                              ;   in Loop: Header=BB14_18 Depth=1
	ld	(ix - 33), iy
	ld	iy, (ix - 15)
	ld	a, (iy + 4)
	ld	de, 0
	ld	e, a
	ld	hl, _sector_shades
	add	hl, de
	ld	a, (hl)
	ld	l, c
	ld	h, b
	ld	c, 7
	call	__sshru
                                        ; kill: def $l killed $l killed $hl
	add	a, l
	ld	e, a
	cp	a, 31
	jr	c, .LBB14_77
; %bb.76:                               ;   in Loop: Header=BB14_18 Depth=1
	ld	e, 31
	.local	.LBB14_77
.LBB14_77:                              ;   in Loop: Header=BB14_18 Depth=1
	or	a, a
	sbc	hl, hl
	ld	l, e
	ld	bc, 3
	call	__imulu
	ex	de, hl
	ld	hl, _shade_rows
	add	hl, de
	ld	a, (ix - 12)                    ; 1-byte Folded Reload
	ld	iy, (ix - 33)
	jp	.LBB14_44
	.local	.Lfunc_end14
.Lfunc_end14:
	.size	_draw_sprites, .Lfunc_end14-_draw_sprites
                                        ; -- End function
	.section	.text._d84_blit_viewport,"ax",@progbits
	.globl	_d84_blit_viewport              ; -- Begin function d84_blit_viewport
	.type	_d84_blit_viewport,@function
_d84_blit_viewport:                     ; @d84_blit_viewport
	push	ix
	push	iy
	ld	iy, 0
	add	iy, sp
	ld	hl, (iy + 9)
	ld	ix, (iy + 12)
	xor	a, a
.Lblit_rows:
	push	af
	call	.Lblit_src_row
	call	.Lblit_dup_row
	pop	af
	bit	0, a
	jr	z, .Lblit_row_next
	push	af
	call	.Lblit_dup_row
	pop	af
.Lblit_row_next:
	inc	a
	cp	a, 80
	jp	nz, .Lblit_rows
	pop	iy
	pop	ix
	ret

.Lblit_src_row:
	ld	b, 64
.Lblit_pair_px:
	ld	a, (hl)
	inc	hl
	ld	(ix + 0), a
	ld	(ix + 1), a
	ld	a, (hl)
	inc	hl
	ld	(ix + 2), a
	ld	(ix + 3), a
	ld	(ix + 4), a
	lea	ix, ix + 5
	djnz	.Lblit_pair_px
	ret

.Lblit_dup_row:
	push	hl
	ld	de, -320
	add	ix, de
	push	ix
	pop	hl
	ld	de, 320
	add	ix, de
	push	ix
	pop	de
	ld	bc, 320
	ldir
	push	de
	pop	ix
	pop	hl
	ret
	.local	.Lfunc_end15
.Lfunc_end15:
	.size	_d84_blit_viewport, .Lfunc_end15-_d84_blit_viewport
                                        ; -- End function
	.section	.text._explode_barrel,"ax",@progbits
	.type	_explode_barrel,@function       ; -- Begin function explode_barrel
_explode_barrel:                        ; @explode_barrel
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 24
	ld	sp, hl
	ld	hl, (ix + 6)
	ld	iy, _actors
	ld	bc, 12
	call	__imulu
	ex	de, hl
	add	iy, de
	ld	a, (iy + 6)
	or	a, a
	jp	nz, .LBB16_25
; %bb.1:
	ld	a, (iy + 8)
	or	a, a
	jp	nz, .LBB16_25
; %bb.2:
	ld	(iy + 5), 0
	ld	(iy + 8), 1
	ld	de, (iy)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 12), hl
	ld	de, (iy + 2)
	ld	a, d
	rlc	a
	sbc	hl, hl
	ld	l, e
	ld	h, d
	ld	(ix - 15), hl
	ld	iy, (_player)
	ld	a, (_player+3)
	ld	e, a
	ld	d, 31
	lea	bc, iy + 0
	ld	l, d
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	ld	(ix - 6), bc
	ld	iy, (_player+4)
	ld	a, (_player+7)
	ld	e, a
	lea	bc, iy + 0
	ld	l, d
	call	__lshrs
	ld	l, 24
	call	__lshru
	lea	hl, iy + 0
	call	__ladd
	push	hl
	pop	bc
	ld	a, e
	ld	l, 8
	call	__lshrs
	push	bc
	pop	de
	ld	hl, (ix - 6)
	ld	bc, (ix - 12)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	call	__ixor
	ld	(ix - 6), hl
	ex	de, hl
	ld	de, (ix - 15)
	or	a, a
	sbc	hl, de
	push	hl
	pop	iy
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	call	__ixor
	ld	bc, (ix - 6)
	push	hl
	pop	de
	or	a, a
	sbc	hl, bc
	jr	c, .LBB16_4
; %bb.3:
	push	de
	pop	bc
	.local	.LBB16_4
.LBB16_4:
	push	bc
	pop	hl
	ld	de, 128
	or	a, a
	sbc	hl, de
	jp	nc, .LBB16_9
; %bb.5:
	ld	a, 5
	ld	hl, 128
	or	a, a
	sbc	hl, bc
	ld	c, 2
	call	__ishru
	ld	(ix - 6), hl
	ld	hl, _random_state
	ld	hl, (hl)
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	bc, 25173
	call	__smulu
	ld.sis	de, 13849
	add.sis	hl, de
	ld	iy, _random_state
	ld	(iy), l
	ld	(iy + 1), h
	ld.sis	bc, 5
	call	__sremu
	ld	de, 0
	push	de
	pop	bc
	ld	c, l
	ld	b, h
	ld	iy, (ix - 6)
	add	iy, bc
	inc	iy
	ld	hl, _player+14
	ld	bc, (hl)
	ld	l, b
	rlc	l
	sbc	hl, hl
	ld	(ix - 9), bc
	ld	l, c
	ld	h, b
	ld	(ix - 6), hl
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	ld	(ix - 18), l
	ld	(ix - 17), h
	ld	(ix - 3), iy
	ld	l, (ix - 1)
	ld	iyh, d
	ld.sis	bc, 171
	ex	de, hl
	ld	e, iyl
	ld	d, iyh
	ex	de, hl
	call	__smulu
	ex	de, hl
	ld	iyl, d
	ld	e, iyl
	ex	de, hl
	srl	l
	ld	e, l
	ld	bc, -8388608
	ld	iy, (ix - 6)
	add	iy, bc
	push	de
	pop	hl
	add	hl, bc
	lea	bc, iy + 0
	or	a, a
	sbc	hl, bc
	jr	c, .LBB16_7
; %bb.6:
	ld	de, (ix - 6)
	.local	.LBB16_7
.LBB16_7:
	ld	hl, (ix - 9)
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, de
	ld	iy, _player+14
	ld	(iy), l
	ld	(iy + 1), h
	ld	l, e
	ld	h, d
	ld	e, (ix - 18)
	ld	d, (ix - 17)
	or	a, a
	sbc.sis	hl, de
	ex.sis	de, hl
	ld	iy, _player+12
	ld	hl, (iy)
	add.sis	hl, de
	ld	(iy), l
	ld	(iy + 1), h
	ld	(_player+28), a
	ld.sis	de, -32768
	add.sis	hl, de
	inc.sis	de
                                        ; kill: def $hl killed $hl killed $uhl
	or	a, a
	sbc.sis	hl, de
	jr	nc, .LBB16_9
; %bb.8:
	ld	a, 1
	ld.sis	hl, 0
	ld	(iy), l
	ld	(iy + 1), h
	ld	(_player+30), a
	.local	.LBB16_9
.LBB16_9:
	ld	bc, 12
	ld	hl, _actors+10
	ld	(ix - 6), hl
	ld	de, 0
	.local	.LBB16_10
.LBB16_10:                              ; =>This Inner Loop Header: Depth=1
	ld	hl, (ix + 6)
	ld	(ix - 9), de
	or	a, a
	sbc	hl, de
	jp	z, .LBB16_24
; %bb.11:                               ;   in Loop: Header=BB16_10 Depth=1
	ld	iy, (ix - 6)
	ld	e, (iy - 5)
	ld	a, e
	or	a, a
	jp	z, .LBB16_24
; %bb.12:                               ;   in Loop: Header=BB16_10 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 4)
	or	a, a
	jp	nz, .LBB16_24
; %bb.13:                               ;   in Loop: Header=BB16_10 Depth=1
	ld	iy, (ix - 6)
	ld	a, (iy - 2)
	or	a, a
	jp	nz, .LBB16_24
; %bb.14:                               ;   in Loop: Header=BB16_10 Depth=1
	ld	(ix - 21), bc
	ld	iy, (ix - 6)
	ld	bc, (iy - 10)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	bc, (ix - 12)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	call	__ixor
	ld	(ix - 18), hl
	ld	iy, (ix - 6)
	ld	bc, (iy - 8)
	ld	a, b
	rlc	a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	bc, (ix - 15)
	or	a, a
	sbc	hl, bc
	push	hl
	pop	iy
	add	hl, hl
	sbc	hl, hl
	push	hl
	pop	bc
	add	iy, bc
	lea	hl, iy + 0
	call	__ixor
	push	hl
	pop	iy
	ld	bc, (ix - 18)
	or	a, a
	sbc	hl, bc
	jr	c, .LBB16_16
; %bb.15:                               ;   in Loop: Header=BB16_10 Depth=1
	ld	(ix - 18), iy
	.local	.LBB16_16
.LBB16_16:                              ;   in Loop: Header=BB16_10 Depth=1
	ld	hl, (ix - 18)
	ld	bc, 128
	or	a, a
	sbc	hl, bc
	ld	bc, (ix - 21)
	jp	nc, .LBB16_24
; %bb.17:                               ;   in Loop: Header=BB16_10 Depth=1
	ld	hl, 128
	ld	bc, (ix - 18)
	or	a, a
	sbc	hl, bc
	call	__ishru_1
	ld	(ix - 18), hl
	ld	hl, _random_state
	ld	hl, (hl)
                                        ; kill: def $hl killed $hl killed $uhl
	ld.sis	bc, 25173
	call	__smulu
	ld.sis	bc, 13849
	add.sis	hl, bc
	ld	iy, _random_state
	ld	(iy), l
	ld	(iy + 1), h
	ld	iy, (ix - 18)
	ld.sis	bc, 5
	call	__sremu
	ld	bc, 0
	ld	c, l
	ld	b, h
	add	iy, bc
	ld	bc, (ix - 21)
	ld	hl, (ix - 6)
	ld	a, (hl)
	or	a, a
	jp	nz, .LBB16_24
; %bb.18:                               ;   in Loop: Header=BB16_10 Depth=1
	inc	iy
	ld	hl, (_map_actors)
	ld	(ix - 24), hl
	or	a, a
	sbc	hl, hl
	ld	(ix - 18), hl
	ld	hl, (ix - 18)
	ld	l, e
	ld	(ix - 18), hl
	lea	hl, iy + 0
	ld	a, e
	ld	de, (ix - 18)
	sbc	hl, de
	jr	nc, .LBB16_21
; %bb.19:                               ;   in Loop: Header=BB16_10 Depth=1
	ex	de, hl
	ld	e, iyl
	ex	de, hl
	sub	a, l
	ld	l, a
	ld	iy, (ix - 6)
	ld	(iy - 5), l
	ld	hl, (ix - 24)
	add	hl, bc
	ld	a, (hl)
	cp	a, 1
	jr	nz, .LBB16_24
; %bb.20:                               ;   in Loop: Header=BB16_10 Depth=1
	ld	iy, (ix - 6)
	ld	(iy - 1), 12
	jr	.LBB16_24
	.local	.LBB16_21
.LBB16_21:                              ;   in Loop: Header=BB16_10 Depth=1
	ld	iy, (ix - 6)
	ld	(iy - 5), 0
	ld	(iy - 1), 0
	ld	hl, (ix - 24)
	add	hl, bc
	ld	a, (hl)
	cp	a, 1
	jr	nz, .LBB16_23
; %bb.22:                               ;   in Loop: Header=BB16_10 Depth=1
	ld	(iy), 1
	ld	(ix - 6), iy
	ld	iy, _player+20
	ld	hl, (iy)
	inc.sis	hl
	ld	(iy), l
	ld	(iy + 1), h
	ld	iy, _player+16
	ld	hl, (iy)
	ld.sis	de, 5
	add.sis	hl, de
	ld	(iy), l
	ld	(iy + 1), h
	jr	.LBB16_24
	.local	.LBB16_23
.LBB16_23:                              ;   in Loop: Header=BB16_10 Depth=1
	cp	a, 3
	ld	hl, (ix - 9)
	push	hl
	call	z, _explode_barrel
	pop	hl
	ld	bc, (ix - 21)
	.local	.LBB16_24
.LBB16_24:                              ;   in Loop: Header=BB16_10 Depth=1
	ld	de, (ix - 9)
	inc	de
	push	bc
	pop	hl
	ld	bc, 14
	add	hl, bc
	ld	iy, (ix - 6)
	lea	iy, iy + 12
	ld	(ix - 6), iy
	push	hl
	pop	iy
	ld	bc, 1286
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jp	nz, .LBB16_10
	.local	.LBB16_25
.LBB16_25:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end16
.Lfunc_end16:
	.size	_explode_barrel, .Lfunc_end16-_explode_barrel
                                        ; -- End function
	.section	.text._d84_wall_column,"ax",@progbits
	.type	_d84_wall_column,@function      ; -- Begin function d84_wall_column
_d84_wall_column:                       ; @d84_wall_column
; %bb.0:
	push	ix
	ld	ix, 0
	add	ix, sp
	lea	hl, ix - 27
	ld	sp, hl
	ld	iy, (ix + 9)
	ld	hl, (ix + 12)
	ld	de, -8388608
	add	iy, de
	add	hl, de
	lea	de, iy + 0
	or	a, a
	sbc	hl, de
	jp	c, .LBB17_37
; %bb.1:
	ld	hl, (ix + 15)
	ld	de, (hl)
	sbc	hl, hl
	adc	hl, de
	jp	z, .LBB17_37
; %bb.2:
	ld	(ix - 6), de
	ld	bc, (ix + 18)
	ld	hl, _render_stats+4
	ld	iy, 0
	ld	de, (hl)
	inc.sis	de
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	de, 2049
	push	bc
	pop	hl
	or	a, a
	sbc	hl, de
	jr	c, .LBB17_5
; %bb.3:
	lea	de, iy + 0
	.local	.LBB17_4
.LBB17_4:                               ; =>This Inner Loop Header: Depth=1
	push	bc
	pop	hl
	call	__ishru_1
	push	hl
	pop	iy
	inc	de
	push	bc
	pop	hl
	ld	bc, 4098
	or	a, a
	sbc	hl, bc
	lea	bc, iy + 0
	jr	nc, .LBB17_4
	jr	.LBB17_6
	.local	.LBB17_5
.LBB17_5:
	lea	de, iy + 0
	push	bc
	pop	iy
	.local	.LBB17_6
.LBB17_6:
	ld	bc, 17
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB17_10
; %bb.7:
	lea	hl, iy + 0
	ld	bc, 2
	or	a, a
	sbc	hl, bc
	jr	nc, .LBB17_9
; %bb.8:
	ld	iy, 1
	.local	.LBB17_9
.LBB17_9:
	ld	bc, 3
	lea	hl, iy + 0
	call	__imulu
	push	hl
	pop	bc
	ld	hl, _small_reciprocals
	add	hl, bc
	ld	hl, (hl)
	jr	.LBB17_11
	.local	.LBB17_10
.LBB17_10:
	ld	hl, _reciprocal_table
	add	iy, iy
	lea	bc, iy + 0
	add	hl, bc
	ld	bc, (hl)
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	.local	.LBB17_11
.LBB17_11:
	ld	c, e
	call	__ishru
	push	hl
	pop	iy
	ld	c, 2
	call	__ishru
	ld	(ix - 9), hl
	ld	bc, (ix + 21)
	ld	(ix - 3), bc
	ld	a, (ix - 1)
	rlc	a
	sbc	a, a
	or	a, a
	sbc	hl, hl
	ld	e, l
	lea	hl, iy + 0
	call	__lmulu
	push	hl
	pop	bc
	ld	a, e
	ld	l, 16
	call	__lshrs
	push	bc
	pop	de
	ld	bc, 16384
	lea	hl, iy + 0
	or	a, a
	sbc	hl, bc
	ld	(ix - 15), iy
	jr	c, .LBB17_13
; %bb.12:
	ld	hl, _shade_rows+93
	jp	.LBB17_16
	.local	.LBB17_13
.LBB17_13:
	ld	c, 9
	lea	hl, iy + 0
	call	__ishru
	ld	bc, (ix + 24)
	ld	iy, _sector_shades
	add	iy, bc
	ld	a, (iy)
                                        ; kill: def $l killed $l killed $uhl
	add	a, l
	ld	c, a
	cp	a, 31
	jr	c, .LBB17_15
; %bb.14:
	ld	c, 31
	.local	.LBB17_15
.LBB17_15:
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	bc, 3
	call	__imulu
	push	hl
	pop	bc
	ld	hl, _shade_rows
	add	hl, bc
	.local	.LBB17_16
.LBB17_16:
	ld	hl, (hl)
	ld	(ix - 24), hl
	ld	iy, (ix + 15)
	ld	b, (iy + 6)
	push	de
	pop	hl
	ld	c, b
	call	__ishru
	push	hl
	pop	iy
	or	a, a
	sbc	hl, hl
	ld	a, l
	sub	a, b
	ld	c, a
	ex	de, hl
	call	__ishl
	ld	a, b
	add	a, -128
	cp	a, -128
	jr	c, .LBB17_18
; %bb.17:
	lea	hl, iy + 0
	.local	.LBB17_18
.LBB17_18:
	ld	bc, 31
	call	__iand
	ld	(ix - 12), hl
	ld	iy, (ix + 9)
	ld	de, -40
	add	iy, de
	ld	hl, (ix - 9)
	lea	bc, iy + 0
	call	__imulu
	ld	iy, (ix + 15)
	ld	c, (iy + 7)
	ld	e, 2
	ld	a, c
	add	a, e
	ld	e, a
	cp	a, 5
	jp	c, .LBB17_21
; %bb.19:
	ld	a, c
	add	a, -128
	cp	a, -125
	jp	c, .LBB17_23
; %bb.20:
	ld	de, -2
                                        ; kill: def $e killed $e killed $ude
	ld	a, c
	add	a, e
	ld	c, a
	call	__ishrs
	ex	de, hl
	ld	hl, (ix - 9)
	call	__ishru
	jr	.LBB17_28
	.local	.LBB17_21
.LBB17_21:
	ld	bc, 0
	ld	c, e
	ld	iy, JTI17_0
	add	iy, bc
	add	iy, bc
	add	iy, bc
	ld	iy, (iy)
	push	hl
	pop	de
	ld	bc, (ix - 9)
	ld	(ix - 21), bc
	jp	(iy)
	.local	.LBB17_22
.LBB17_22:
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, (ix - 9)
	add	hl, hl
	jr	.LBB17_26
	.local	.LBB17_23
.LBB17_23:
	ld	de, 2
	ld	a, e
	sub	a, c
	ld	c, a
	call	__ishl
	ex	de, hl
	ld	hl, (ix - 9)
	call	__ishl
	jr	.LBB17_28
	.local	.LBB17_24
.LBB17_24:
	add	hl, hl
	ld	iy, (ix - 9)
	add	iy, iy
	ex	de, hl
	ld	(ix - 21), iy
	jr	.LBB17_29
	.local	.LBB17_25
.LBB17_25:
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, (ix - 9)
	.local	.LBB17_26
.LBB17_26:
	add	hl, hl
	add	hl, hl
	add	hl, hl
	jr	.LBB17_28
	.local	.LBB17_27
.LBB17_27:
	ld	bc, -4
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, (ix - 15)
	call	__iand
	.local	.LBB17_28
.LBB17_28:
	ld	(ix - 21), hl
	.local	.LBB17_29
.LBB17_29:
	ld	(ix - 18), de
	ld	iy, (ix - 6)
	ld	de, (ix - 12)
	add	iy, de
	ld	hl, (ix + 12)
	ld	bc, (ix + 9)
	or	a, a
	sbc	hl, bc
	inc	hl
	add	hl, bc
	or	a, a
	sbc	hl, bc
	jp	z, .LBB17_37
; %bb.30:
	ld	(ix - 6), iy
	push	bc
	pop	hl
	ld	bc, 255
	ld	iy, _row_offsets
	ld	de, _engine_view+2
	ld	(ix - 9), de
	call	__iand
	add	hl, hl
	push	hl
	pop	bc
	add	iy, bc
	ld	bc, (iy)
	ld	iy, _depthbuffer
	or	a, a
	sbc	hl, hl
	ld	l, c
	ld	h, b
	ld	de, (ix + 6)
	add	hl, de
	ex	de, hl
	add	iy, de
	ld	hl, (ix - 9)
	add	hl, de
	ld	(ix - 9), hl
	ld	c, 6
	ld	de, (ix - 15)
	push	de
	pop	hl
	call	__ishru
	ld	(ix - 27), hl
	ld	bc, 128
	ex	de, hl
	or	a, a
	sbc	hl, bc
	ld	(ix - 12), iy
	jr	c, .LBB17_32
; %bb.31:
	ld	hl, (ix - 27)
	ld	a, l
	jr	.LBB17_33
	.local	.LBB17_32
.LBB17_32:
	ld	a, 1
	.local	.LBB17_33
.LBB17_33:
	ld	de, (ix - 18)
	ld	iy, (ix + 15)
	ld	hl, (iy + 3)
	add	hl, de
	push	hl
	pop	bc
	ld	de, 16256
	ld	hl, (ix - 15)
	or	a, a
	sbc	hl, de
	jr	c, .LBB17_35
; %bb.34:
	ld	a, -2
	.local	.LBB17_35
.LBB17_35:
	ld	(.Lwall_depth+3), a
	ld	hl, (ix - 24)
	ld	(.Lwall_light+1), hl
	ld	hl, (ix - 6)
	ld	(.Lwall_image+1), hl
	ld	hl, (ix + 12)
	ld	de, (ix + 9)
	or	a, a
	sbc	hl, de
	inc	hl
	ld	a, l
	ex	af, af'
	ld	de, (ix - 21)
	push	bc
	pop	hl
	ld	iy, (ix - 12)
	ld	bc, (ix - 9)
	push	ix
	push	bc
	pop	ix
.Lwall_fast_loop:
	push	hl
	ld	a, h
	and	31
	ld	l, a
	ld	h, 32
	mlt	hl
.Lwall_image:
	ld	bc, 0
	add	hl, bc
	ld	a, (hl)
.Lwall_light:
	ld	hl, 0
	ld	l, a
	ld	a, (hl)
	ld	(ix + 0), a
.Lwall_depth:
	ld	(iy + 0), 0
	ld	bc, 128
	add	ix, bc
	add	iy, bc
	pop	hl
	add	hl, de
	ex	af, af'
	dec	a
	jr	z, .Lwall_fast_done
	ex	af, af'
	jr	.Lwall_fast_loop
.Lwall_fast_done:
	pop	ix
	.local	.LBB17_37
.LBB17_37:
	ld	sp, ix
	pop	ix
	ret
	.local	.Lfunc_end17
.Lfunc_end17:
	.size	_d84_wall_column, .Lfunc_end17-_d84_wall_column
	.section	.rodata._d84_wall_column,"a",@progbits
JTI17_0:
	d24	.LBB17_22
	d24	.LBB17_25
	d24	.LBB17_27
	d24	.LBB17_24
	d24	.LBB17_29
                                        ; -- End function
	.section	.data._render_detail,"aw",@progbits
	.balign	1
	.globl	_render_detail
_render_detail:
	d24	1                               ; 0x1

	.section	.bss._nodes,"aw",@nobits
	.balign	1
	.globl	_nodes
_nodes:
	.zero	3

	.section	.rodata._node_offsets,"a",@progbits
	.balign	2
	.local	_node_offsets
_node_offsets:
	dw	0                               ; 0x0
	dw	28                              ; 0x1c
	dw	56                              ; 0x38
	dw	84                              ; 0x54
	dw	112                             ; 0x70
	dw	140                             ; 0x8c
	dw	168                             ; 0xa8
	dw	196                             ; 0xc4
	dw	224                             ; 0xe0
	dw	252                             ; 0xfc
	dw	280                             ; 0x118
	dw	308                             ; 0x134
	dw	336                             ; 0x150
	dw	364                             ; 0x16c
	dw	392                             ; 0x188
	dw	420                             ; 0x1a4
	dw	448                             ; 0x1c0
	dw	476                             ; 0x1dc
	dw	504                             ; 0x1f8
	dw	532                             ; 0x214
	dw	560                             ; 0x230
	dw	588                             ; 0x24c
	dw	616                             ; 0x268
	dw	644                             ; 0x284
	dw	672                             ; 0x2a0
	dw	700                             ; 0x2bc
	dw	728                             ; 0x2d8
	dw	756                             ; 0x2f4
	dw	784                             ; 0x310
	dw	812                             ; 0x32c
	dw	840                             ; 0x348
	dw	868                             ; 0x364
	dw	896                             ; 0x380
	dw	924                             ; 0x39c
	dw	952                             ; 0x3b8
	dw	980                             ; 0x3d4
	dw	1008                            ; 0x3f0
	dw	1036                            ; 0x40c
	dw	1064                            ; 0x428
	dw	1092                            ; 0x444
	dw	1120                            ; 0x460
	dw	1148                            ; 0x47c
	dw	1176                            ; 0x498
	dw	1204                            ; 0x4b4
	dw	1232                            ; 0x4d0
	dw	1260                            ; 0x4ec
	dw	1288                            ; 0x508
	dw	1316                            ; 0x524
	dw	1344                            ; 0x540
	dw	1372                            ; 0x55c
	dw	1400                            ; 0x578
	dw	1428                            ; 0x594
	dw	1456                            ; 0x5b0
	dw	1484                            ; 0x5cc
	dw	1512                            ; 0x5e8
	dw	1540                            ; 0x604
	dw	1568                            ; 0x620
	dw	1596                            ; 0x63c
	dw	1624                            ; 0x658
	dw	1652                            ; 0x674
	dw	1680                            ; 0x690
	dw	1708                            ; 0x6ac
	dw	1736                            ; 0x6c8
	dw	1764                            ; 0x6e4
	dw	1792                            ; 0x700
	dw	1820                            ; 0x71c
	dw	1848                            ; 0x738
	dw	1876                            ; 0x754
	dw	1904                            ; 0x770
	dw	1932                            ; 0x78c
	dw	1960                            ; 0x7a8
	dw	1988                            ; 0x7c4
	dw	2016                            ; 0x7e0
	dw	2044                            ; 0x7fc
	dw	2072                            ; 0x818
	dw	2100                            ; 0x834
	dw	2128                            ; 0x850
	dw	2156                            ; 0x86c
	dw	2184                            ; 0x888
	dw	2212                            ; 0x8a4
	dw	2240                            ; 0x8c0
	dw	2268                            ; 0x8dc
	dw	2296                            ; 0x8f8
	dw	2324                            ; 0x914
	dw	2352                            ; 0x930
	dw	2380                            ; 0x94c
	dw	2408                            ; 0x968
	dw	2436                            ; 0x984
	dw	2464                            ; 0x9a0
	dw	2492                            ; 0x9bc
	dw	2520                            ; 0x9d8
	dw	2548                            ; 0x9f4
	dw	2576                            ; 0xa10
	dw	2604                            ; 0xa2c
	dw	2632                            ; 0xa48
	dw	2660                            ; 0xa64
	dw	2688                            ; 0xa80
	dw	2716                            ; 0xa9c
	dw	2744                            ; 0xab8
	dw	2772                            ; 0xad4
	dw	2800                            ; 0xaf0
	dw	2828                            ; 0xb0c
	dw	2856                            ; 0xb28
	dw	2884                            ; 0xb44
	dw	2912                            ; 0xb60
	dw	2940                            ; 0xb7c
	dw	2968                            ; 0xb98
	dw	2996                            ; 0xbb4
	dw	3024                            ; 0xbd0
	dw	3052                            ; 0xbec
	dw	3080                            ; 0xc08
	dw	3108                            ; 0xc24
	dw	3136                            ; 0xc40
	dw	3164                            ; 0xc5c
	dw	3192                            ; 0xc78
	dw	3220                            ; 0xc94
	dw	3248                            ; 0xcb0
	dw	3276                            ; 0xccc
	dw	3304                            ; 0xce8
	dw	3332                            ; 0xd04
	dw	3360                            ; 0xd20
	dw	3388                            ; 0xd3c
	dw	3416                            ; 0xd58
	dw	3444                            ; 0xd74
	dw	3472                            ; 0xd90
	dw	3500                            ; 0xdac
	dw	3528                            ; 0xdc8
	dw	3556                            ; 0xde4
	dw	3584                            ; 0xe00
	dw	3612                            ; 0xe1c
	dw	3640                            ; 0xe38
	dw	3668                            ; 0xe54
	dw	3696                            ; 0xe70
	dw	3724                            ; 0xe8c
	dw	3752                            ; 0xea8
	dw	3780                            ; 0xec4
	dw	3808                            ; 0xee0
	dw	3836                            ; 0xefc
	dw	3864                            ; 0xf18
	dw	3892                            ; 0xf34
	dw	3920                            ; 0xf50
	dw	3948                            ; 0xf6c
	dw	3976                            ; 0xf88
	dw	4004                            ; 0xfa4
	dw	4032                            ; 0xfc0
	dw	4060                            ; 0xfdc
	dw	4088                            ; 0xff8
	dw	4116                            ; 0x1014
	dw	4144                            ; 0x1030
	dw	4172                            ; 0x104c
	dw	4200                            ; 0x1068
	dw	4228                            ; 0x1084
	dw	4256                            ; 0x10a0
	dw	4284                            ; 0x10bc
	dw	4312                            ; 0x10d8
	dw	4340                            ; 0x10f4
	dw	4368                            ; 0x1110
	dw	4396                            ; 0x112c
	dw	4424                            ; 0x1148
	dw	4452                            ; 0x1164
	dw	4480                            ; 0x1180
	dw	4508                            ; 0x119c
	dw	4536                            ; 0x11b8
	dw	4564                            ; 0x11d4
	dw	4592                            ; 0x11f0
	dw	4620                            ; 0x120c
	dw	4648                            ; 0x1228
	dw	4676                            ; 0x1244
	dw	4704                            ; 0x1260
	dw	4732                            ; 0x127c
	dw	4760                            ; 0x1298
	dw	4788                            ; 0x12b4
	dw	4816                            ; 0x12d0
	dw	4844                            ; 0x12ec
	dw	4872                            ; 0x1308
	dw	4900                            ; 0x1324
	dw	4928                            ; 0x1340
	dw	4956                            ; 0x135c
	dw	4984                            ; 0x1378
	dw	5012                            ; 0x1394
	dw	5040                            ; 0x13b0
	dw	5068                            ; 0x13cc
	dw	5096                            ; 0x13e8
	dw	5124                            ; 0x1404
	dw	5152                            ; 0x1420
	dw	5180                            ; 0x143c
	dw	5208                            ; 0x1458
	dw	5236                            ; 0x1474
	dw	5264                            ; 0x1490
	dw	5292                            ; 0x14ac
	dw	5320                            ; 0x14c8
	dw	5348                            ; 0x14e4
	dw	5376                            ; 0x1500
	dw	5404                            ; 0x151c
	dw	5432                            ; 0x1538
	dw	5460                            ; 0x1554
	dw	5488                            ; 0x1570
	dw	5516                            ; 0x158c
	dw	5544                            ; 0x15a8
	dw	5572                            ; 0x15c4
	dw	5600                            ; 0x15e0
	dw	5628                            ; 0x15fc
	dw	5656                            ; 0x1618
	dw	5684                            ; 0x1634
	dw	5712                            ; 0x1650
	dw	5740                            ; 0x166c
	dw	5768                            ; 0x1688
	dw	5796                            ; 0x16a4
	dw	5824                            ; 0x16c0
	dw	5852                            ; 0x16dc
	dw	5880                            ; 0x16f8
	dw	5908                            ; 0x1714
	dw	5936                            ; 0x1730
	dw	5964                            ; 0x174c
	dw	5992                            ; 0x1768
	dw	6020                            ; 0x1784
	dw	6048                            ; 0x17a0
	dw	6076                            ; 0x17bc
	dw	6104                            ; 0x17d8
	dw	6132                            ; 0x17f4
	dw	6160                            ; 0x1810
	dw	6188                            ; 0x182c
	dw	6216                            ; 0x1848
	dw	6244                            ; 0x1864
	dw	6272                            ; 0x1880
	dw	6300                            ; 0x189c
	dw	6328                            ; 0x18b8
	dw	6356                            ; 0x18d4
	dw	6384                            ; 0x18f0
	dw	6412                            ; 0x190c
	dw	6440                            ; 0x1928
	dw	6468                            ; 0x1944
	dw	6496                            ; 0x1960
	dw	6524                            ; 0x197c
	dw	6552                            ; 0x1998
	dw	6580                            ; 0x19b4

	.section	.bss._subsectors,"aw",@nobits
	.balign	1
	.globl	_subsectors
_subsectors:
	.zero	3

	.section	.bss._segs,"aw",@nobits
	.balign	1
	.globl	_segs
_segs:
	.zero	3

	.section	.bss._sides,"aw",@nobits
	.balign	1
	.local	_sides
_sides:
	.zero	3

	.section	.bss._map_lines,"aw",@nobits
	.balign	1
	.globl	_map_lines
_map_lines:
	.zero	3

	.section	.rodata._.str,"a",@progbits
	.balign	1
	.local	_.str
_.str:
	.asciz	"D84MAP01"

	.section	.rodata._asset_id,"a",@progbits
	.balign	1
	.local	_asset_id
_asset_id:
	.ascii	"\300\200\213u\017\240\306\320"

	.section	.rodata._.str.1,"a",@progbits
	.balign	1
	.local	_.str.1
_.str.1:
	.asciz	"D84TEX01"

	.section	.bss._map_vertices,"aw",@nobits
	.balign	1
	.globl	_map_vertices
_map_vertices:
	.zero	3

	.section	.bss._map_sectors,"aw",@nobits
	.balign	1
	.globl	_map_sectors
_map_sectors:
	.zero	3

	.section	.bss._map_actors,"aw",@nobits
	.balign	1
	.local	_map_actors
_map_actors:
	.zero	3

	.section	.bss._blockmap,"aw",@nobits
	.balign	1
	.local	_blockmap
_blockmap:
	.zero	3

	.section	.bss._map_palette,"aw",@nobits
	.balign	1
	.globl	_map_palette
_map_palette:
	.zero	3

	.section	.bss._ram_colormaps,"aw",@nobits
	.balign	256
	.local	_ram_colormaps
_ram_colormaps:
	.zero	8192

	.section	.bss._colormaps,"aw",@nobits
	.balign	1
	.local	_colormaps
_colormaps:
	.zero	3

	.section	.bss._shade_rows,"aw",@nobits
	.balign	1
	.local	_shade_rows
_shade_rows:
	.zero	96

	.section	.bss._reciprocal_table,"aw",@nobits
	.balign	2
	.globl	_reciprocal_table
_reciprocal_table:
	.zero	4098

	.section	.bss._small_reciprocals,"aw",@nobits
	.balign	1
	.globl	_small_reciprocals
_small_reciprocals:
	.zero	51

	.section	.rodata._tile_bank,"a",@progbits
	.balign	1
	.local	_tile_bank
_tile_bank:
	.ascii	"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\002\002\002\002\002\002\002\002\002\002\002\002\002\002\003\003"

	.section	.rodata._tile_offset,"a",@progbits
	.balign	2
	.local	_tile_offset
_tile_offset:
	dw	16                              ; 0x10
	dw	1040                            ; 0x410
	dw	2064                            ; 0x810
	dw	3088                            ; 0xc10
	dw	4112                            ; 0x1010
	dw	5136                            ; 0x1410
	dw	6160                            ; 0x1810
	dw	7184                            ; 0x1c10
	dw	8208                            ; 0x2010
	dw	9232                            ; 0x2410
	dw	10256                           ; 0x2810
	dw	11280                           ; 0x2c10
	dw	12304                           ; 0x3010
	dw	13328                           ; 0x3410
	dw	14352                           ; 0x3810
	dw	15376                           ; 0x3c10
	dw	16400                           ; 0x4010
	dw	17424                           ; 0x4410
	dw	18448                           ; 0x4810
	dw	19472                           ; 0x4c10
	dw	20496                           ; 0x5010
	dw	21520                           ; 0x5410
	dw	22544                           ; 0x5810
	dw	23568                           ; 0x5c10
	dw	24592                           ; 0x6010
	dw	25616                           ; 0x6410
	dw	26640                           ; 0x6810
	dw	27664                           ; 0x6c10
	dw	28688                           ; 0x7010
	dw	29712                           ; 0x7410
	dw	30736                           ; 0x7810
	dw	31760                           ; 0x7c10
	dw	32784                           ; 0x8010
	dw	33808                           ; 0x8410
	dw	34832                           ; 0x8810
	dw	35856                           ; 0x8c10
	dw	36880                           ; 0x9010
	dw	37904                           ; 0x9410
	dw	38928                           ; 0x9810
	dw	39952                           ; 0x9c10
	dw	40976                           ; 0xa010
	dw	42000                           ; 0xa410
	dw	43024                           ; 0xa810
	dw	44048                           ; 0xac10
	dw	45072                           ; 0xb010
	dw	46096                           ; 0xb410
	dw	47120                           ; 0xb810
	dw	48144                           ; 0xbc10
	dw	49168                           ; 0xc010
	dw	50192                           ; 0xc410
	dw	51216                           ; 0xc810
	dw	52240                           ; 0xcc10
	dw	53264                           ; 0xd010
	dw	54288                           ; 0xd410
	dw	16                              ; 0x10
	dw	4112                            ; 0x1010
	dw	8208                            ; 0x2010
	dw	12304                           ; 0x3010
	dw	16400                           ; 0x4010
	dw	20496                           ; 0x5010
	dw	24592                           ; 0x6010
	dw	28688                           ; 0x7010
	dw	32784                           ; 0x8010
	dw	36880                           ; 0x9010
	dw	40976                           ; 0xa010
	dw	45072                           ; 0xb010
	dw	49168                           ; 0xc010
	dw	53264                           ; 0xd010
	dw	57360                           ; 0xe010
	dw	16                              ; 0x10
	dw	4112                            ; 0x1010
	dw	8208                            ; 0x2010
	dw	12304                           ; 0x3010
	dw	16400                           ; 0x4010
	dw	20496                           ; 0x5010
	dw	24592                           ; 0x6010
	dw	28688                           ; 0x7010
	dw	32784                           ; 0x8010
	dw	36880                           ; 0x9010
	dw	40976                           ; 0xa010
	dw	42000                           ; 0xa410
	dw	46096                           ; 0xb410
	dw	50192                           ; 0xc410
	dw	54288                           ; 0xd410
	dw	16                              ; 0x10
	dw	4112                            ; 0x1010

	.section	.bss._images,"aw",@nobits
	.balign	1
	.local	_images
_images:
	.zero	258

	.section	.bss._materials,"aw",@nobits
	.balign	1
	.globl	_materials
_materials:
	.zero	7320

	.section	.bss._sky_flat,"aw",@nobits
	.balign	1
	.local	_sky_flat
_sky_flat:
	.zero	1

	.section	.bss._sector_shades,"aw",@nobits
	.balign	1
	.local	_sector_shades
_sector_shades:
	.zero	85

	.section	.bss._plane_colors,"aw",@nobits
	.balign	1
	.local	_plane_colors
_plane_colors:
	.zero	170

	.section	.bss._engine_view,"aw",@nobits
	.balign	1
	.globl	_engine_view
_engine_view:
	.zero	10242

	.section	.bss._player,"aw",@nobits
	.balign	2
	.globl	_player
_player:
	.zero	34

	.section	.bss._random_state,"aw",@nobits
	.balign	2
	.local	_random_state
_random_state:
	.zero	2

	.section	.bss._use_held,"aw",@nobits
	.balign	1
	.local	_use_held
_use_held:
	.zero	1

	.section	.bss._floor_wait,"aw",@nobits
	.balign	1
	.local	_floor_wait
_floor_wait:
	.zero	85

	.section	.bss._sector_ceiling,"aw",@nobits
	.balign	2
	.local	_sector_ceiling
_sector_ceiling:
	.zero	170

	.section	.bss._sector_target,"aw",@nobits
	.balign	2
	.local	_sector_target
_sector_target:
	.zero	170

	.section	.bss._sector_floor,"aw",@nobits
	.balign	2
	.local	_sector_floor
_sector_floor:
	.zero	170

	.section	.bss._floor_target,"aw",@nobits
	.balign	2
	.local	_floor_target
_floor_target:
	.zero	170

	.section	.bss._actors,"aw",@nobits
	.balign	2
	.local	_actors
_actors:
	.zero	1092

	.section	.bss._cliptop,"aw",@nobits
	.balign	1
	.local	_cliptop
_cliptop:
	.zero	128

	.section	.bss._clipbottom,"aw",@nobits
	.balign	1
	.local	_clipbottom
_clipbottom:
	.zero	128

	.section	.bss._render_stats,"aw",@nobits
	.balign	2
	.globl	_render_stats
_render_stats:
	.zero	10

	.section	.bss._d84_rw,"aw",@nobits
	.balign	1
	.globl	_d84_rw
_d84_rw:
	.zero	128

	.section	.rodata._tile_info,"a",@progbits
	.balign	1
	.local	_tile_info
_tile_info:
	.ascii	" \006\006"
	.ascii	" \005\007"
	.ascii	" \007\007"
	.ascii	" \007\007"
	.ascii	" \003\007"
	.ascii	" \b\005"
	.ascii	" \005\004"
	.ascii	" \007\007"
	.ascii	" \006\007"
	.ascii	" \007\007"
	.ascii	" \003\007"
	.ascii	" \006\007"
	.ascii	" \007\007"
	.ascii	" \007\007"
	.ascii	" \006\007"
	.ascii	" \006\007"
	.ascii	" \006\004"
	.ascii	" \007\007"
	.ascii	" \005\007"
	.ascii	" \005\007"
	.ascii	" \007\007"
	.ascii	" \006\007"
	.ascii	" \007\006"
	.ascii	" \006\007"
	.ascii	" \007\007"
	.ascii	" \006\004"
	.ascii	" \007\007"
	.ascii	" \b\007"
	.ascii	" \005\007"
	.ascii	" \b\007"
	.ascii	" \007\007"
	.ascii	" \005\003"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	" \006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	" \b\007"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"
	.ascii	"@\006\006"

	.section	.bss._planes,"aw",@nobits
	.balign	1
	.local	_planes
_planes:
	.zero	10240

	.section	.rodata._d84_bbox_visible.corners,"a",@progbits
	.balign	1
	.local	_d84_bbox_visible.corners
_d84_bbox_visible.corners:
	.ascii	"\002\001"
	.asciz	"\002"
	.asciz	"\003"
	.zero	2
	.ascii	"\000\001"
	.zero	2
	.ascii	"\003\002"
	.zero	2
	.ascii	"\000\003"
	.ascii	"\001\003"
	.ascii	"\001\002"
	.zero	2

	.section	.bss._camx,"aw",@nobits
	.balign	1
	.globl	_camx
_camx:
	.zero	3

	.section	.bss._camy,"aw",@nobits
	.balign	1
	.globl	_camy
_camy:
	.zero	3

	.section	.rodata._box_points,"a",@progbits
	.balign	2
	.local	_box_points
_box_points:
	dw	124                             ; 0x7c
	dw	123                             ; 0x7b
	dw	126                             ; 0x7e
	dw	125                             ; 0x7d
	dw	300                             ; 0x12c
	dw	291                             ; 0x123
	dw	301                             ; 0x12d
	dw	290                             ; 0x122
	dw	467                             ; 0x1d3
	dw	468                             ; 0x1d4
	dw	120                             ; 0x78
	dw	119                             ; 0x77
	dw	120                             ; 0x78
	dw	119                             ; 0x77
	dw	121                             ; 0x79
	dw	122                             ; 0x7a
	dw	467                             ; 0x1d3
	dw	468                             ; 0x1d4
	dw	121                             ; 0x79
	dw	122                             ; 0x7a
	dw	121                             ; 0x79
	dw	122                             ; 0x7a
	dw	124                             ; 0x7c
	dw	123                             ; 0x7b
	dw	469                             ; 0x1d5
	dw	123                             ; 0x7b
	dw	301                             ; 0x12d
	dw	125                             ; 0x7d
	dw	467                             ; 0x1d3
	dw	468                             ; 0x1d4
	dw	124                             ; 0x7c
	dw	123                             ; 0x7b
	dw	470                             ; 0x1d6
	dw	29                              ; 0x1d
	dw	118                             ; 0x76
	dw	471                             ; 0x1d7
	dw	472                             ; 0x1d8
	dw	118                             ; 0x76
	dw	119                             ; 0x77
	dw	473                             ; 0x1d9
	dw	293                             ; 0x125
	dw	307                             ; 0x133
	dw	294                             ; 0x126
	dw	306                             ; 0x132
	dw	468                             ; 0x1d4
	dw	29                              ; 0x1d
	dw	119                             ; 0x77
	dw	41                              ; 0x29
	dw	474                             ; 0x1da
	dw	386                             ; 0x182
	dw	387                             ; 0x183
	dw	475                             ; 0x1db
	dw	468                             ; 0x1d4
	dw	29                              ; 0x1d
	dw	125                             ; 0x7d
	dw	387                             ; 0x183
	dw	476                             ; 0x1dc
	dw	468                             ; 0x1d4
	dw	301                             ; 0x12d
	dw	125                             ; 0x7d
	dw	468                             ; 0x1d4
	dw	477                             ; 0x1dd
	dw	125                             ; 0x7d
	dw	475                             ; 0x1db
	dw	389                             ; 0x185
	dw	388                             ; 0x184
	dw	327                             ; 0x147
	dw	334                             ; 0x14e
	dw	327                             ; 0x147
	dw	334                             ; 0x14e
	dw	328                             ; 0x148
	dw	333                             ; 0x14d
	dw	392                             ; 0x188
	dw	390                             ; 0x186
	dw	391                             ; 0x187
	dw	298                             ; 0x12a
	dw	388                             ; 0x184
	dw	392                             ; 0x188
	dw	335                             ; 0x14f
	dw	322                             ; 0x142
	dw	389                             ; 0x185
	dw	388                             ; 0x184
	dw	328                             ; 0x148
	dw	333                             ; 0x14d
	dw	388                             ; 0x184
	dw	390                             ; 0x186
	dw	333                             ; 0x14d
	dw	298                             ; 0x12a
	dw	393                             ; 0x189
	dw	396                             ; 0x18c
	dw	394                             ; 0x18a
	dw	395                             ; 0x18b
	dw	396                             ; 0x18c
	dw	389                             ; 0x185
	dw	325                             ; 0x145
	dw	326                             ; 0x146
	dw	389                             ; 0x185
	dw	390                             ; 0x186
	dw	328                             ; 0x148
	dw	298                             ; 0x12a
	dw	393                             ; 0x189
	dw	389                             ; 0x185
	dw	394                             ; 0x18a
	dw	328                             ; 0x148
	dw	317                             ; 0x13d
	dw	403                             ; 0x193
	dw	314                             ; 0x13a
	dw	400                             ; 0x190
	dw	316                             ; 0x13c
	dw	317                             ; 0x13d
	dw	315                             ; 0x13b
	dw	314                             ; 0x13a
	dw	402                             ; 0x192
	dw	344                             ; 0x158
	dw	316                             ; 0x13c
	dw	403                             ; 0x193
	dw	316                             ; 0x13c
	dw	403                             ; 0x193
	dw	315                             ; 0x13b
	dw	400                             ; 0x190
	dw	347                             ; 0x15b
	dw	402                             ; 0x192
	dw	401                             ; 0x191
	dw	315                             ; 0x13b
	dw	402                             ; 0x192
	dw	344                             ; 0x158
	dw	315                             ; 0x13b
	dw	400                             ; 0x190
	dw	401                             ; 0x191
	dw	400                             ; 0x190
	dw	346                             ; 0x15a
	dw	345                             ; 0x159
	dw	347                             ; 0x15b
	dw	344                             ; 0x158
	dw	401                             ; 0x191
	dw	400                             ; 0x190
	dw	399                             ; 0x18f
	dw	397                             ; 0x18d
	dw	347                             ; 0x15b
	dw	344                             ; 0x158
	dw	347                             ; 0x15b
	dw	344                             ; 0x158
	dw	346                             ; 0x15a
	dw	345                             ; 0x159
	dw	304                             ; 0x130
	dw	399                             ; 0x18f
	dw	393                             ; 0x189
	dw	346                             ; 0x15a
	dw	399                             ; 0x18f
	dw	397                             ; 0x18d
	dw	346                             ; 0x15a
	dw	345                             ; 0x159
	dw	397                             ; 0x18d
	dw	398                             ; 0x18e
	dw	345                             ; 0x159
	dw	340                             ; 0x154
	dw	304                             ; 0x130
	dw	397                             ; 0x18d
	dw	393                             ; 0x189
	dw	345                             ; 0x159
	dw	339                             ; 0x153
	dw	408                             ; 0x198
	dw	336                             ; 0x150
	dw	406                             ; 0x196
	dw	338                             ; 0x152
	dw	339                             ; 0x153
	dw	337                             ; 0x151
	dw	336                             ; 0x150
	dw	407                             ; 0x197
	dw	342                             ; 0x156
	dw	338                             ; 0x152
	dw	408                             ; 0x198
	dw	338                             ; 0x152
	dw	408                             ; 0x198
	dw	337                             ; 0x151
	dw	406                             ; 0x196
	dw	341                             ; 0x155
	dw	407                             ; 0x197
	dw	405                             ; 0x195
	dw	337                             ; 0x151
	dw	407                             ; 0x197
	dw	342                             ; 0x156
	dw	337                             ; 0x151
	dw	406                             ; 0x196
	dw	405                             ; 0x195
	dw	406                             ; 0x196
	dw	340                             ; 0x154
	dw	343                             ; 0x157
	dw	341                             ; 0x155
	dw	342                             ; 0x156
	dw	405                             ; 0x195
	dw	406                             ; 0x196
	dw	342                             ; 0x156
	dw	404                             ; 0x194
	dw	343                             ; 0x157
	dw	390                             ; 0x186
	dw	341                             ; 0x155
	dw	342                             ; 0x156
	dw	340                             ; 0x154
	dw	343                             ; 0x157
	dw	398                             ; 0x18e
	dw	309                             ; 0x135
	dw	341                             ; 0x155
	dw	404                             ; 0x194
	dw	341                             ; 0x155
	dw	404                             ; 0x194
	dw	340                             ; 0x154
	dw	390                             ; 0x186
	dw	304                             ; 0x130
	dw	398                             ; 0x18e
	dw	393                             ; 0x189
	dw	340                             ; 0x154
	dw	398                             ; 0x18e
	dw	309                             ; 0x135
	dw	340                             ; 0x154
	dw	390                             ; 0x186
	dw	393                             ; 0x189
	dw	390                             ; 0x186
	dw	394                             ; 0x18a
	dw	298                             ; 0x12a
	dw	304                             ; 0x130
	dw	309                             ; 0x135
	dw	393                             ; 0x189
	dw	390                             ; 0x186
	dw	304                             ; 0x130
	dw	309                             ; 0x135
	dw	394                             ; 0x18a
	dw	298                             ; 0x12a
	dw	301                             ; 0x12d
	dw	304                             ; 0x130
	dw	409                             ; 0x199
	dw	394                             ; 0x18a
	dw	478                             ; 0x1de
	dw	479                             ; 0x1df
	dw	410                             ; 0x19a
	dw	480                             ; 0x1e0
	dw	387                             ; 0x183
	dw	481                             ; 0x1e1
	dw	482                             ; 0x1e2
	dw	131                             ; 0x83
	dw	387                             ; 0x183
	dw	483                             ; 0x1e3
	dw	484                             ; 0x1e4
	dw	480                             ; 0x1e0
	dw	309                             ; 0x135
	dw	306                             ; 0x132
	dw	298                             ; 0x12a
	dw	299                             ; 0x12b
	dw	301                             ; 0x12d
	dw	309                             ; 0x135
	dw	409                             ; 0x199
	dw	298                             ; 0x12a
	dw	309                             ; 0x135
	dw	483                             ; 0x1e3
	dw	298                             ; 0x12a
	dw	480                             ; 0x1e0
	dw	476                             ; 0x1dc
	dw	477                             ; 0x1dd
	dw	301                             ; 0x12d
	dw	475                             ; 0x1db
	dw	301                             ; 0x12d
	dw	483                             ; 0x1e3
	dw	409                             ; 0x199
	dw	480                             ; 0x1e0
	dw	485                             ; 0x1e5
	dw	486                             ; 0x1e6
	dw	487                             ; 0x1e7
	dw	488                             ; 0x1e8
	dw	140                             ; 0x8c
	dw	489                             ; 0x1e9
	dw	490                             ; 0x1ea
	dw	139                             ; 0x8b
	dw	485                             ; 0x1e5
	dw	486                             ; 0x1e6
	dw	487                             ; 0x1e7
	dw	488                             ; 0x1e8
	dw	491                             ; 0x1eb
	dw	138                             ; 0x8a
	dw	137                             ; 0x89
	dw	492                             ; 0x1ec
	dw	485                             ; 0x1e5
	dw	486                             ; 0x1e6
	dw	487                             ; 0x1e7
	dw	488                             ; 0x1e8
	dw	485                             ; 0x1e5
	dw	133                             ; 0x85
	dw	134                             ; 0x86
	dw	493                             ; 0x1ed
	dw	485                             ; 0x1e5
	dw	486                             ; 0x1e6
	dw	487                             ; 0x1e7
	dw	488                             ; 0x1e8
	dw	494                             ; 0x1ee
	dw	412                             ; 0x19c
	dw	495                             ; 0x1ef
	dw	411                             ; 0x19b
	dw	485                             ; 0x1e5
	dw	496                             ; 0x1f0
	dw	497                             ; 0x1f1
	dw	411                             ; 0x19b
	dw	32                              ; 0x20
	dw	35                              ; 0x23
	dw	498                             ; 0x1f2
	dw	412                             ; 0x19c
	dw	32                              ; 0x20
	dw	35                              ; 0x23
	dw	497                             ; 0x1f1
	dw	411                             ; 0x19b
	dw	136                             ; 0x88
	dw	499                             ; 0x1f3
	dw	500                             ; 0x1f4
	dw	137                             ; 0x89
	dw	32                              ; 0x20
	dw	35                              ; 0x23
	dw	497                             ; 0x1f1
	dw	411                             ; 0x19b
	dw	386                             ; 0x182
	dw	32                              ; 0x20
	dw	501                             ; 0x1f5
	dw	135                             ; 0x87
	dw	27                              ; 0x1b
	dw	26                              ; 0x1a
	dw	34                              ; 0x22
	dw	33                              ; 0x21
	dw	30                              ; 0x1e
	dw	28                              ; 0x1c
	dw	32                              ; 0x20
	dw	31                              ; 0x1f
	dw	386                             ; 0x182
	dw	35                              ; 0x23
	dw	502                             ; 0x1f6
	dw	411                             ; 0x19b
	dw	30                              ; 0x1e
	dw	26                              ; 0x1a
	dw	32                              ; 0x20
	dw	33                              ; 0x21
	dw	184                             ; 0xb8
	dw	503                             ; 0x1f7
	dw	186                             ; 0xba
	dw	413                             ; 0x19d
	dw	183                             ; 0xb7
	dw	184                             ; 0xb8
	dw	185                             ; 0xb9
	dw	186                             ; 0xba
	dw	182                             ; 0xb6
	dw	183                             ; 0xb7
	dw	179                             ; 0xb3
	dw	185                             ; 0xb9
	dw	180                             ; 0xb4
	dw	182                             ; 0xb6
	dw	178                             ; 0xb2
	dw	179                             ; 0xb3
	dw	183                             ; 0xb7
	dw	503                             ; 0x1f7
	dw	185                             ; 0xb9
	dw	413                             ; 0x19d
	dw	180                             ; 0xb4
	dw	183                             ; 0xb7
	dw	178                             ; 0xb2
	dw	185                             ; 0xb9
	dw	35                              ; 0x23
	dw	504                             ; 0x1f8
	dw	211                             ; 0xd3
	dw	130                             ; 0x82
	dw	43                              ; 0x2b
	dw	505                             ; 0x1f9
	dw	414                             ; 0x19e
	dw	130                             ; 0x82
	dw	414                             ; 0x19e
	dw	130                             ; 0x82
	dw	175                             ; 0xaf
	dw	506                             ; 0x1fa
	dw	176                             ; 0xb0
	dw	181                             ; 0xb5
	dw	174                             ; 0xae
	dw	177                             ; 0xb1
	dw	211                             ; 0xd3
	dw	414                             ; 0x19e
	dw	411                             ; 0x19b
	dw	174                             ; 0xae
	dw	414                             ; 0x19e
	dw	130                             ; 0x82
	dw	174                             ; 0xae
	dw	177                             ; 0xb1
	dw	181                             ; 0xb5
	dw	180                             ; 0xb4
	dw	177                             ; 0xb1
	dw	178                             ; 0xb2
	dw	211                             ; 0xd3
	dw	130                             ; 0x82
	dw	411                             ; 0x19b
	dw	177                             ; 0xb1
	dw	35                              ; 0x23
	dw	504                             ; 0x1f8
	dw	211                             ; 0xd3
	dw	130                             ; 0x82
	dw	211                             ; 0xd3
	dw	507                             ; 0x1fb
	dw	411                             ; 0x19b
	dw	178                             ; 0xb2
	dw	180                             ; 0xb4
	dw	503                             ; 0x1f7
	dw	178                             ; 0xb2
	dw	413                             ; 0x19d
	dw	35                              ; 0x23
	dw	508                             ; 0x1fc
	dw	411                             ; 0x19b
	dw	178                             ; 0xb2
	dw	477                             ; 0x1dd
	dw	509                             ; 0x1fd
	dw	502                             ; 0x1f6
	dw	411                             ; 0x19b
	dw	35                              ; 0x23
	dw	510                             ; 0x1fe
	dw	411                             ; 0x19b
	dw	413                             ; 0x19d
	dw	476                             ; 0x1dc
	dw	511                             ; 0x1ff
	dw	409                             ; 0x199
	dw	480                             ; 0x1e0
	dw	477                             ; 0x1dd
	dw	512                             ; 0x200
	dw	502                             ; 0x1f6
	dw	413                             ; 0x19d
	dw	71                              ; 0x47
	dw	64                              ; 0x40
	dw	70                              ; 0x46
	dw	65                              ; 0x41
	dw	72                              ; 0x48
	dw	63                              ; 0x3f
	dw	71                              ; 0x47
	dw	64                              ; 0x40
	dw	72                              ; 0x48
	dw	63                              ; 0x3f
	dw	70                              ; 0x46
	dw	65                              ; 0x41
	dw	73                              ; 0x49
	dw	62                              ; 0x3e
	dw	72                              ; 0x48
	dw	63                              ; 0x3f
	dw	417                             ; 0x1a1
	dw	73                              ; 0x49
	dw	418                             ; 0x1a2
	dw	70                              ; 0x46
	dw	73                              ; 0x49
	dw	62                              ; 0x3e
	dw	70                              ; 0x46
	dw	65                              ; 0x41
	dw	62                              ; 0x3e
	dw	416                             ; 0x1a0
	dw	65                              ; 0x41
	dw	415                             ; 0x19f
	dw	417                             ; 0x1a1
	dw	62                              ; 0x3e
	dw	418                             ; 0x1a2
	dw	65                              ; 0x41
	dw	513                             ; 0x201
	dw	87                              ; 0x57
	dw	421                             ; 0x1a5
	dw	85                              ; 0x55
	dw	87                              ; 0x57
	dw	84                              ; 0x54
	dw	85                              ; 0x55
	dw	86                              ; 0x56
	dw	84                              ; 0x54
	dw	288                             ; 0x120
	dw	86                              ; 0x56
	dw	514                             ; 0x202
	dw	513                             ; 0x201
	dw	84                              ; 0x54
	dw	421                             ; 0x1a5
	dw	86                              ; 0x56
	dw	289                             ; 0x121
	dw	515                             ; 0x203
	dw	516                             ; 0x204
	dw	282                             ; 0x11a
	dw	517                             ; 0x205
	dw	515                             ; 0x203
	dw	518                             ; 0x206
	dw	519                             ; 0x207
	dw	517                             ; 0x205
	dw	288                             ; 0x120
	dw	287                             ; 0x11f
	dw	520                             ; 0x208
	dw	517                             ; 0x205
	dw	515                             ; 0x203
	dw	518                             ; 0x206
	dw	519                             ; 0x207
	dw	287                             ; 0x11f
	dw	287                             ; 0x11f
	dw	286                             ; 0x11e
	dw	286                             ; 0x11e
	dw	517                             ; 0x205
	dw	515                             ; 0x203
	dw	518                             ; 0x206
	dw	519                             ; 0x207
	dw	285                             ; 0x11d
	dw	284                             ; 0x11c
	dw	285                             ; 0x11d
	dw	284                             ; 0x11c
	dw	517                             ; 0x205
	dw	515                             ; 0x203
	dw	518                             ; 0x206
	dw	519                             ; 0x207
	dw	521                             ; 0x209
	dw	283                             ; 0x11b
	dw	284                             ; 0x11c
	dw	519                             ; 0x207
	dw	517                             ; 0x205
	dw	515                             ; 0x203
	dw	518                             ; 0x206
	dw	519                             ; 0x207
	dw	282                             ; 0x11a
	dw	282                             ; 0x11a
	dw	283                             ; 0x11b
	dw	283                             ; 0x11b
	dw	517                             ; 0x205
	dw	515                             ; 0x203
	dw	518                             ; 0x206
	dw	519                             ; 0x207
	dw	513                             ; 0x201
	dw	288                             ; 0x120
	dw	421                             ; 0x1a5
	dw	514                             ; 0x202
	dw	517                             ; 0x205
	dw	515                             ; 0x203
	dw	518                             ; 0x206
	dw	519                             ; 0x207
	dw	423                             ; 0x1a7
	dw	422                             ; 0x1a6
	dw	92                              ; 0x5c
	dw	91                              ; 0x5b
	dw	92                              ; 0x5c
	dw	91                              ; 0x5b
	dw	83                              ; 0x53
	dw	82                              ; 0x52
	dw	83                              ; 0x53
	dw	82                              ; 0x52
	dw	522                             ; 0x20a
	dw	523                             ; 0x20b
	dw	423                             ; 0x1a7
	dw	422                             ; 0x1a6
	dw	83                              ; 0x53
	dw	82                              ; 0x52
	dw	524                             ; 0x20c
	dw	424                             ; 0x1a8
	dw	420                             ; 0x1a4
	dw	87                              ; 0x57
	dw	424                             ; 0x1a8
	dw	423                             ; 0x1a7
	dw	93                              ; 0x5d
	dw	92                              ; 0x5c
	dw	525                             ; 0x20d
	dw	83                              ; 0x53
	dw	84                              ; 0x54
	dw	522                             ; 0x20a
	dw	524                             ; 0x20c
	dw	423                             ; 0x1a7
	dw	420                             ; 0x1a4
	dw	522                             ; 0x20a
	dw	423                             ; 0x1a7
	dw	422                             ; 0x1a6
	dw	522                             ; 0x20a
	dw	523                             ; 0x20b
	dw	524                             ; 0x20c
	dw	423                             ; 0x1a7
	dw	420                             ; 0x1a4
	dw	522                             ; 0x20a
	dw	513                             ; 0x201
	dw	515                             ; 0x203
	dw	421                             ; 0x1a5
	dw	526                             ; 0x20e
	dw	524                             ; 0x20c
	dw	422                             ; 0x1a6
	dw	420                             ; 0x1a4
	dw	523                             ; 0x20b
	dw	81                              ; 0x51
	dw	81                              ; 0x51
	dw	89                              ; 0x59
	dw	89                              ; 0x59
	dw	81                              ; 0x51
	dw	88                              ; 0x58
	dw	89                              ; 0x59
	dw	90                              ; 0x5a
	dw	88                              ; 0x58
	dw	527                             ; 0x20f
	dw	90                              ; 0x5a
	dw	425                             ; 0x1a9
	dw	81                              ; 0x51
	dw	88                              ; 0x58
	dw	89                              ; 0x59
	dw	90                              ; 0x5a
	dw	422                             ; 0x1a6
	dw	528                             ; 0x210
	dw	91                              ; 0x5b
	dw	427                             ; 0x1ab
	dw	94                              ; 0x5e
	dw	529                             ; 0x211
	dw	88                              ; 0x58
	dw	426                             ; 0x1aa
	dw	82                              ; 0x52
	dw	530                             ; 0x212
	dw	523                             ; 0x20b
	dw	81                              ; 0x51
	dw	422                             ; 0x1a6
	dw	531                             ; 0x213
	dw	523                             ; 0x20b
	dw	426                             ; 0x1aa
	dw	81                              ; 0x51
	dw	527                             ; 0x20f
	dw	89                              ; 0x59
	dw	425                             ; 0x1a9
	dw	422                             ; 0x1a6
	dw	531                             ; 0x213
	dw	523                             ; 0x20b
	dw	426                             ; 0x1aa
	dw	532                             ; 0x214
	dw	422                             ; 0x1a6
	dw	421                             ; 0x1a5
	dw	533                             ; 0x215
	dw	422                             ; 0x1a6
	dw	534                             ; 0x216
	dw	533                             ; 0x215
	dw	425                             ; 0x1a9
	dw	79                              ; 0x4f
	dw	78                              ; 0x4e
	dw	79                              ; 0x4f
	dw	78                              ; 0x4e
	dw	535                             ; 0x217
	dw	536                             ; 0x218
	dw	75                              ; 0x4b
	dw	76                              ; 0x4c
	dw	537                             ; 0x219
	dw	85                              ; 0x55
	dw	99                              ; 0x63
	dw	538                             ; 0x21a
	dw	86                              ; 0x56
	dw	86                              ; 0x56
	dw	79                              ; 0x4f
	dw	79                              ; 0x4f
	dw	535                             ; 0x217
	dw	536                             ; 0x218
	dw	75                              ; 0x4b
	dw	76                              ; 0x4c
	dw	537                             ; 0x219
	dw	86                              ; 0x56
	dw	99                              ; 0x63
	dw	539                             ; 0x21b
	dw	90                              ; 0x5a
	dw	540                             ; 0x21c
	dw	541                             ; 0x21d
	dw	100                             ; 0x64
	dw	89                              ; 0x59
	dw	89                              ; 0x59
	dw	78                              ; 0x4e
	dw	78                              ; 0x4e
	dw	537                             ; 0x219
	dw	542                             ; 0x21e
	dw	99                              ; 0x63
	dw	76                              ; 0x4c
	dw	89                              ; 0x59
	dw	540                             ; 0x21c
	dw	543                             ; 0x21f
	dw	100                             ; 0x64
	dw	532                             ; 0x214
	dw	534                             ; 0x216
	dw	421                             ; 0x1a5
	dw	425                             ; 0x1a9
	dw	537                             ; 0x219
	dw	540                             ; 0x21c
	dw	99                              ; 0x63
	dw	100                             ; 0x64
	dw	104                             ; 0x68
	dw	106                             ; 0x6a
	dw	99                              ; 0x63
	dw	98                              ; 0x62
	dw	104                             ; 0x68
	dw	101                             ; 0x65
	dw	99                              ; 0x63
	dw	100                             ; 0x64
	dw	104                             ; 0x68
	dw	101                             ; 0x65
	dw	99                              ; 0x63
	dw	100                             ; 0x64
	dw	544                             ; 0x220
	dw	102                             ; 0x66
	dw	104                             ; 0x68
	dw	105                             ; 0x69
	dw	58                              ; 0x3a
	dw	74                              ; 0x4a
	dw	417                             ; 0x1a1
	dw	73                              ; 0x49
	dw	74                              ; 0x4a
	dw	61                              ; 0x3d
	dw	73                              ; 0x49
	dw	62                              ; 0x3e
	dw	61                              ; 0x3d
	dw	57                              ; 0x39
	dw	62                              ; 0x3e
	dw	416                             ; 0x1a0
	dw	58                              ; 0x3a
	dw	61                              ; 0x3d
	dw	417                             ; 0x1a1
	dw	62                              ; 0x3e
	dw	545                             ; 0x221
	dw	546                             ; 0x222
	dw	61                              ; 0x3d
	dw	57                              ; 0x39
	dw	75                              ; 0x4b
	dw	76                              ; 0x4c
	dw	547                             ; 0x223
	dw	548                             ; 0x224
	dw	549                             ; 0x225
	dw	550                             ; 0x226
	dw	58                              ; 0x3a
	dw	74                              ; 0x4a
	dw	75                              ; 0x4b
	dw	546                             ; 0x222
	dw	547                             ; 0x223
	dw	57                              ; 0x39
	dw	58                              ; 0x3a
	dw	57                              ; 0x39
	dw	417                             ; 0x1a1
	dw	416                             ; 0x1a0
	dw	549                             ; 0x225
	dw	546                             ; 0x222
	dw	58                              ; 0x3a
	dw	57                              ; 0x39
	dw	544                             ; 0x220
	dw	551                             ; 0x227
	dw	99                              ; 0x63
	dw	100                             ; 0x64
	dw	549                             ; 0x225
	dw	546                             ; 0x222
	dw	417                             ; 0x1a1
	dw	416                             ; 0x1a0
	dw	419                             ; 0x1a3
	dw	551                             ; 0x227
	dw	552                             ; 0x228
	dw	100                             ; 0x64
	dw	544                             ; 0x220
	dw	551                             ; 0x227
	dw	553                             ; 0x229
	dw	554                             ; 0x22a
	dw	417                             ; 0x1a1
	dw	416                             ; 0x1a0
	dw	418                             ; 0x1a2
	dw	415                             ; 0x19f
	dw	544                             ; 0x220
	dw	551                             ; 0x227
	dw	553                             ; 0x229
	dw	554                             ; 0x22a
	dw	12                              ; 0xc
	dw	11                              ; 0xb
	dw	17                              ; 0x11
	dw	14                              ; 0xe
	dw	11                              ; 0xb
	dw	11                              ; 0xb
	dw	14                              ; 0xe
	dw	14                              ; 0xe
	dw	45                              ; 0x2d
	dw	9                               ; 0x9
	dw	13                              ; 0xd
	dw	555                             ; 0x22b
	dw	10                              ; 0xa
	dw	10                              ; 0xa
	dw	11                              ; 0xb
	dw	11                              ; 0xb
	dw	12                              ; 0xc
	dw	11                              ; 0xb
	dw	17                              ; 0x11
	dw	14                              ; 0xe
	dw	45                              ; 0x2d
	dw	9                               ; 0x9
	dw	12                              ; 0xc
	dw	556                             ; 0x22c
	dw	14                              ; 0xe
	dw	14                              ; 0xe
	dw	15                              ; 0xf
	dw	15                              ; 0xf
	dw	16                              ; 0x10
	dw	15                              ; 0xf
	dw	26                              ; 0x1a
	dw	557                             ; 0x22d
	dw	17                              ; 0x11
	dw	14                              ; 0xe
	dw	26                              ; 0x1a
	dw	557                             ; 0x22d
	dw	16                              ; 0x10
	dw	558                             ; 0x22e
	dw	26                              ; 0x1a
	dw	8                               ; 0x8
	dw	45                              ; 0x2d
	dw	9                               ; 0x9
	dw	17                              ; 0x11
	dw	559                             ; 0x22f
	dw	17                              ; 0x11
	dw	559                             ; 0x22f
	dw	26                              ; 0x1a
	dw	8                               ; 0x8
	dw	7                               ; 0x7
	dw	560                             ; 0x230
	dw	6                               ; 0x6
	dw	561                             ; 0x231
	dw	2                               ; 0x2
	dw	1                               ; 0x1
	dw	3                               ; 0x3
	dw	0                               ; 0x0
	dw	45                              ; 0x2d
	dw	9                               ; 0x9
	dw	26                              ; 0x1a
	dw	8                               ; 0x8
	dw	7                               ; 0x7
	dw	562                             ; 0x232
	dw	6                               ; 0x6
	dw	563                             ; 0x233
	dw	19                              ; 0x13
	dw	13                              ; 0xd
	dw	20                              ; 0x14
	dw	12                              ; 0xc
	dw	46                              ; 0x2e
	dw	45                              ; 0x2d
	dw	19                              ; 0x13
	dw	13                              ; 0xd
	dw	20                              ; 0x14
	dw	12                              ; 0xc
	dw	30                              ; 0x1e
	dw	26                              ; 0x1a
	dw	46                              ; 0x2e
	dw	45                              ; 0x2d
	dw	20                              ; 0x14
	dw	12                              ; 0xc
	dw	21                              ; 0x15
	dw	20                              ; 0x14
	dw	23                              ; 0x17
	dw	24                              ; 0x18
	dw	21                              ; 0x15
	dw	21                              ; 0x15
	dw	23                              ; 0x17
	dw	23                              ; 0x17
	dw	23                              ; 0x17
	dw	23                              ; 0x17
	dw	22                              ; 0x16
	dw	22                              ; 0x16
	dw	22                              ; 0x16
	dw	25                              ; 0x19
	dw	564                             ; 0x234
	dw	30                              ; 0x1e
	dw	21                              ; 0x15
	dw	20                              ; 0x14
	dw	23                              ; 0x17
	dw	24                              ; 0x18
	dw	23                              ; 0x17
	dw	24                              ; 0x18
	dw	564                             ; 0x234
	dw	30                              ; 0x1e
	dw	37                              ; 0x25
	dw	46                              ; 0x2e
	dw	565                             ; 0x235
	dw	19                              ; 0x13
	dw	18                              ; 0x12
	dw	18                              ; 0x12
	dw	21                              ; 0x15
	dw	21                              ; 0x15
	dw	21                              ; 0x15
	dw	20                              ; 0x14
	dw	564                             ; 0x234
	dw	30                              ; 0x1e
	dw	37                              ; 0x25
	dw	46                              ; 0x2e
	dw	566                             ; 0x236
	dw	20                              ; 0x14
	dw	567                             ; 0x237
	dw	568                             ; 0x238
	dw	29                              ; 0x1d
	dw	30                              ; 0x1e
	dw	37                              ; 0x25
	dw	37                              ; 0x25
	dw	38                              ; 0x26
	dw	38                              ; 0x26
	dw	569                             ; 0x239
	dw	46                              ; 0x2e
	dw	29                              ; 0x1d
	dw	30                              ; 0x1e
	dw	570                             ; 0x23a
	dw	40                              ; 0x28
	dw	385                             ; 0x181
	dw	29                              ; 0x1d
	dw	37                              ; 0x25
	dw	46                              ; 0x2e
	dw	571                             ; 0x23b
	dw	30                              ; 0x1e
	dw	572                             ; 0x23c
	dw	46                              ; 0x2e
	dw	385                             ; 0x181
	dw	30                              ; 0x1e
	dw	46                              ; 0x2e
	dw	45                              ; 0x2d
	dw	30                              ; 0x1e
	dw	26                              ; 0x1a
	dw	572                             ; 0x23c
	dw	46                              ; 0x2e
	dw	385                             ; 0x181
	dw	30                              ; 0x1e
	dw	45                              ; 0x2d
	dw	573                             ; 0x23d
	dw	26                              ; 0x1a
	dw	574                             ; 0x23e
	dw	572                             ; 0x23c
	dw	45                              ; 0x2d
	dw	385                             ; 0x181
	dw	26                              ; 0x1a
	dw	575                             ; 0x23f
	dw	576                             ; 0x240
	dw	46                              ; 0x2e
	dw	45                              ; 0x2d
	dw	53                              ; 0x35
	dw	54                              ; 0x36
	dw	49                              ; 0x31
	dw	48                              ; 0x30
	dw	69                              ; 0x45
	dw	66                              ; 0x42
	dw	68                              ; 0x44
	dw	67                              ; 0x43
	dw	70                              ; 0x46
	dw	65                              ; 0x41
	dw	69                              ; 0x45
	dw	66                              ; 0x42
	dw	109                             ; 0x6d
	dw	70                              ; 0x46
	dw	110                             ; 0x6e
	dw	68                              ; 0x44
	dw	70                              ; 0x46
	dw	65                              ; 0x41
	dw	68                              ; 0x44
	dw	67                              ; 0x43
	dw	65                              ; 0x41
	dw	116                             ; 0x74
	dw	67                              ; 0x43
	dw	115                             ; 0x73
	dw	109                             ; 0x6d
	dw	65                              ; 0x41
	dw	110                             ; 0x6e
	dw	67                              ; 0x43
	dw	110                             ; 0x6e
	dw	115                             ; 0x73
	dw	60                              ; 0x3c
	dw	55                              ; 0x37
	dw	109                             ; 0x6d
	dw	116                             ; 0x74
	dw	110                             ; 0x6e
	dw	115                             ; 0x73
	dw	115                             ; 0x73
	dw	114                             ; 0x72
	dw	55                              ; 0x37
	dw	577                             ; 0x241
	dw	116                             ; 0x74
	dw	113                             ; 0x71
	dw	115                             ; 0x73
	dw	114                             ; 0x72
	dw	113                             ; 0x71
	dw	415                             ; 0x19f
	dw	428                             ; 0x1ac
	dw	578                             ; 0x242
	dw	116                             ; 0x74
	dw	113                             ; 0x71
	dw	55                              ; 0x37
	dw	577                             ; 0x241
	dw	109                             ; 0x6d
	dw	116                             ; 0x74
	dw	60                              ; 0x3c
	dw	55                              ; 0x37
	dw	116                             ; 0x74
	dw	415                             ; 0x19f
	dw	55                              ; 0x37
	dw	579                             ; 0x243
	dw	418                             ; 0x1a2
	dw	112                             ; 0x70
	dw	429                             ; 0x1ad
	dw	111                             ; 0x6f
	dw	112                             ; 0x70
	dw	109                             ; 0x6d
	dw	111                             ; 0x6f
	dw	110                             ; 0x6e
	dw	429                             ; 0x1ad
	dw	110                             ; 0x6e
	dw	580                             ; 0x244
	dw	60                              ; 0x3c
	dw	418                             ; 0x1a2
	dw	109                             ; 0x6d
	dw	429                             ; 0x1ad
	dw	110                             ; 0x6e
	dw	109                             ; 0x6d
	dw	415                             ; 0x19f
	dw	60                              ; 0x3c
	dw	579                             ; 0x243
	dw	418                             ; 0x1a2
	dw	109                             ; 0x6d
	dw	580                             ; 0x244
	dw	60                              ; 0x3c
	dw	581                             ; 0x245
	dw	582                             ; 0x246
	dw	46                              ; 0x2e
	dw	45                              ; 0x2d
	dw	418                             ; 0x1a2
	dw	415                             ; 0x19f
	dw	580                             ; 0x244
	dw	579                             ; 0x243
	dw	572                             ; 0x23c
	dw	573                             ; 0x23d
	dw	385                             ; 0x181
	dw	574                             ; 0x23e
	dw	418                             ; 0x1a2
	dw	415                             ; 0x19f
	dw	583                             ; 0x247
	dw	584                             ; 0x248
	dw	544                             ; 0x220
	dw	551                             ; 0x227
	dw	585                             ; 0x249
	dw	586                             ; 0x24a
	dw	587                             ; 0x24b
	dw	588                             ; 0x24c
	dw	385                             ; 0x181
	dw	574                             ; 0x23e
	dw	476                             ; 0x1dc
	dw	512                             ; 0x200
	dw	409                             ; 0x199
	dw	413                             ; 0x19d
	dw	589                             ; 0x24d
	dw	590                             ; 0x24e
	dw	385                             ; 0x181
	dw	574                             ; 0x23e
	dw	221                             ; 0xdd
	dw	591                             ; 0x24f
	dw	222                             ; 0xde
	dw	154                             ; 0x9a
	dw	220                             ; 0xdc
	dw	592                             ; 0x250
	dw	593                             ; 0x251
	dw	221                             ; 0xdd
	dw	410                             ; 0x19a
	dw	594                             ; 0x252
	dw	595                             ; 0x253
	dw	220                             ; 0xdc
	dw	220                             ; 0xdc
	dw	596                             ; 0x254
	dw	597                             ; 0x255
	dw	154                             ; 0x9a
	dw	410                             ; 0x19a
	dw	598                             ; 0x256
	dw	599                             ; 0x257
	dw	154                             ; 0x9a
	dw	222                             ; 0xde
	dw	154                             ; 0x9a
	dw	223                             ; 0xdf
	dw	153                             ; 0x99
	dw	600                             ; 0x258
	dw	210                             ; 0xd2
	dw	154                             ; 0x9a
	dw	127                             ; 0x7f
	dw	210                             ; 0xd2
	dw	129                             ; 0x81
	dw	127                             ; 0x7f
	dw	601                             ; 0x259
	dw	430                             ; 0x1ae
	dw	602                             ; 0x25a
	dw	210                             ; 0xd2
	dw	129                             ; 0x81
	dw	411                             ; 0x19b
	dw	174                             ; 0xae
	dw	603                             ; 0x25b
	dw	173                             ; 0xad
	dw	411                             ; 0x19b
	dw	411                             ; 0x19b
	dw	210                             ; 0xd2
	dw	210                             ; 0xd2
	dw	411                             ; 0x19b
	dw	177                             ; 0xb1
	dw	210                             ; 0xd2
	dw	129                             ; 0x81
	dw	600                             ; 0x258
	dw	129                             ; 0x81
	dw	154                             ; 0x9a
	dw	601                             ; 0x259
	dw	411                             ; 0x19b
	dw	177                             ; 0xb1
	dw	210                             ; 0xd2
	dw	129                             ; 0x81
	dw	410                             ; 0x19a
	dw	598                             ; 0x256
	dw	604                             ; 0x25c
	dw	153                             ; 0x99
	dw	598                             ; 0x256
	dw	177                             ; 0xb1
	dw	154                             ; 0x9a
	dw	601                             ; 0x259
	dw	605                             ; 0x25d
	dw	431                             ; 0x1af
	dw	606                             ; 0x25e
	dw	205                             ; 0xcd
	dw	607                             ; 0x25f
	dw	190                             ; 0xbe
	dw	212                             ; 0xd4
	dw	608                             ; 0x260
	dw	609                             ; 0x261
	dw	190                             ; 0xbe
	dw	606                             ; 0x25e
	dw	610                             ; 0x262
	dw	214                             ; 0xd6
	dw	611                             ; 0x263
	dw	612                             ; 0x264
	dw	189                             ; 0xbd
	dw	613                             ; 0x265
	dw	614                             ; 0x266
	dw	615                             ; 0x267
	dw	616                             ; 0x268
	dw	202                             ; 0xca
	dw	617                             ; 0x269
	dw	200                             ; 0xc8
	dw	201                             ; 0xc9
	dw	618                             ; 0x26a
	dw	611                             ; 0x263
	dw	606                             ; 0x25e
	dw	610                             ; 0x262
	dw	613                             ; 0x265
	dw	614                             ; 0x266
	dw	200                             ; 0xc8
	dw	619                             ; 0x26b
	dw	410                             ; 0x19a
	dw	177                             ; 0xb1
	dw	604                             ; 0x25c
	dw	200                             ; 0xc8
	dw	177                             ; 0xb1
	dw	611                             ; 0x263
	dw	200                             ; 0xc8
	dw	620                             ; 0x26c
	dw	328                             ; 0x148
	dw	333                             ; 0x14d
	dw	329                             ; 0x149
	dw	332                             ; 0x14c
	dw	329                             ; 0x149
	dw	332                             ; 0x14c
	dw	330                             ; 0x14a
	dw	331                             ; 0x14b
	dw	394                             ; 0x18a
	dw	395                             ; 0x18b
	dw	433                             ; 0x1b1
	dw	324                             ; 0x144
	dw	328                             ; 0x148
	dw	333                             ; 0x14d
	dw	330                             ; 0x14a
	dw	331                             ; 0x14b
	dw	433                             ; 0x1b1
	dw	434                             ; 0x1b2
	dw	305                             ; 0x131
	dw	313                             ; 0x139
	dw	394                             ; 0x18a
	dw	333                             ; 0x14d
	dw	433                             ; 0x1b1
	dw	434                             ; 0x1b2
	dw	434                             ; 0x1b2
	dw	435                             ; 0x1b3
	dw	313                             ; 0x139
	dw	311                             ; 0x137
	dw	391                             ; 0x187
	dw	298                             ; 0x12a
	dw	323                             ; 0x143
	dw	435                             ; 0x1b3
	dw	394                             ; 0x18a
	dw	333                             ; 0x14d
	dw	305                             ; 0x131
	dw	313                             ; 0x139
	dw	333                             ; 0x14d
	dw	298                             ; 0x12a
	dw	313                             ; 0x139
	dw	311                             ; 0x137
	dw	394                             ; 0x18a
	dw	298                             ; 0x12a
	dw	305                             ; 0x131
	dw	311                             ; 0x137
	dw	409                             ; 0x199
	dw	394                             ; 0x18a
	dw	302                             ; 0x12e
	dw	305                             ; 0x131
	dw	313                             ; 0x139
	dw	621                             ; 0x26d
	dw	144                             ; 0x90
	dw	141                             ; 0x8d
	dw	436                             ; 0x1b4
	dw	310                             ; 0x136
	dw	622                             ; 0x26e
	dw	312                             ; 0x138
	dw	623                             ; 0x26f
	dw	142                             ; 0x8e
	dw	144                             ; 0x90
	dw	141                             ; 0x8d
	dw	313                             ; 0x139
	dw	621                             ; 0x26d
	dw	144                             ; 0x90
	dw	141                             ; 0x8d
	dw	313                             ; 0x139
	dw	621                             ; 0x26d
	dw	144                             ; 0x90
	dw	141                             ; 0x8d
	dw	302                             ; 0x12e
	dw	297                             ; 0x129
	dw	303                             ; 0x12f
	dw	296                             ; 0x128
	dw	409                             ; 0x199
	dw	298                             ; 0x12a
	dw	302                             ; 0x12e
	dw	311                             ; 0x137
	dw	302                             ; 0x12e
	dw	621                             ; 0x26d
	dw	624                             ; 0x270
	dw	141                             ; 0x8d
	dw	410                             ; 0x19a
	dw	611                             ; 0x263
	dw	604                             ; 0x25c
	dw	620                             ; 0x26c
	dw	409                             ; 0x199
	dw	625                             ; 0x271
	dw	624                             ; 0x270
	dw	141                             ; 0x8d
	dw	626                             ; 0x272
	dw	627                             ; 0x273
	dw	158                             ; 0x9e
	dw	165                             ; 0xa5
	dw	165                             ; 0xa5
	dw	437                             ; 0x1b5
	dw	165                             ; 0xa5
	dw	437                             ; 0x1b5
	dw	153                             ; 0x99
	dw	152                             ; 0x98
	dw	628                             ; 0x274
	dw	629                             ; 0x275
	dw	626                             ; 0x272
	dw	630                             ; 0x276
	dw	158                             ; 0x9e
	dw	437                             ; 0x1b5
	dw	169                             ; 0xa9
	dw	356                             ; 0x164
	dw	169                             ; 0xa9
	dw	356                             ; 0x164
	dw	356                             ; 0x164
	dw	631                             ; 0x277
	dw	632                             ; 0x278
	dw	439                             ; 0x1b7
	dw	633                             ; 0x279
	dw	634                             ; 0x27a
	dw	635                             ; 0x27b
	dw	636                             ; 0x27c
	dw	169                             ; 0xa9
	dw	631                             ; 0x277
	dw	637                             ; 0x27d
	dw	439                             ; 0x1b7
	dw	638                             ; 0x27e
	dw	639                             ; 0x27f
	dw	640                             ; 0x280
	dw	641                             ; 0x281
	dw	642                             ; 0x282
	dw	169                             ; 0xa9
	dw	219                             ; 0xdb
	dw	643                             ; 0x283
	dw	644                             ; 0x284
	dw	645                             ; 0x285
	dw	646                             ; 0x286
	dw	647                             ; 0x287
	dw	638                             ; 0x27e
	dw	639                             ; 0x27f
	dw	640                             ; 0x280
	dw	641                             ; 0x281
	dw	633                             ; 0x279
	dw	634                             ; 0x27a
	dw	648                             ; 0x288
	dw	649                             ; 0x289
	dw	644                             ; 0x284
	dw	650                             ; 0x28a
	dw	651                             ; 0x28b
	dw	641                             ; 0x281
	dw	652                             ; 0x28c
	dw	634                             ; 0x27a
	dw	651                             ; 0x28b
	dw	653                             ; 0x28d
	dw	219                             ; 0xdb
	dw	654                             ; 0x28e
	dw	655                             ; 0x28f
	dw	441                             ; 0x1b9
	dw	652                             ; 0x28c
	dw	634                             ; 0x27a
	dw	656                             ; 0x290
	dw	657                             ; 0x291
	dw	658                             ; 0x292
	dw	659                             ; 0x293
	dw	660                             ; 0x294
	dw	661                             ; 0x295
	dw	150                             ; 0x96
	dw	443                             ; 0x1bb
	dw	662                             ; 0x296
	dw	663                             ; 0x297
	dw	664                             ; 0x298
	dw	665                             ; 0x299
	dw	444                             ; 0x1bc
	dw	666                             ; 0x29a
	dw	667                             ; 0x29b
	dw	626                             ; 0x272
	dw	668                             ; 0x29c
	dw	669                             ; 0x29d
	dw	628                             ; 0x274
	dw	670                             ; 0x29e
	dw	671                             ; 0x29f
	dw	672                             ; 0x2a0
	dw	673                             ; 0x2a1
	dw	674                             ; 0x2a2
	dw	675                             ; 0x2a3
	dw	160                             ; 0xa0
	dw	676                             ; 0x2a4
	dw	677                             ; 0x2a5
	dw	156                             ; 0x9c
	dw	678                             ; 0x2a6
	dw	676                             ; 0x2a4
	dw	679                             ; 0x2a7
	dw	675                             ; 0x2a3
	dw	160                             ; 0xa0
	dw	680                             ; 0x2a8
	dw	681                             ; 0x2a9
	dw	682                             ; 0x2aa
	dw	683                             ; 0x2ab
	dw	667                             ; 0x29b
	dw	684                             ; 0x2ac
	dw	685                             ; 0x2ad
	dw	672                             ; 0x2a0
	dw	686                             ; 0x2ae
	dw	681                             ; 0x2a9
	dw	675                             ; 0x2a3
	dw	683                             ; 0x2ab
	dw	664                             ; 0x298
	dw	443                             ; 0x1bb
	dw	444                             ; 0x1bc
	dw	687                             ; 0x2af
	dw	665                             ; 0x299
	dw	684                             ; 0x2ac
	dw	675                             ; 0x2a3
	dw	688                             ; 0x2b0
	dw	689                             ; 0x2b1
	dw	659                             ; 0x293
	dw	656                             ; 0x290
	dw	690                             ; 0x2b2
	dw	664                             ; 0x298
	dw	684                             ; 0x2ac
	dw	691                             ; 0x2b3
	dw	688                             ; 0x2b0
	dw	692                             ; 0x2b4
	dw	693                             ; 0x2b5
	dw	694                             ; 0x2b6
	dw	170                             ; 0xaa
	dw	155                             ; 0x9b
	dw	695                             ; 0x2b7
	dw	696                             ; 0x2b8
	dw	218                             ; 0xda
	dw	692                             ; 0x2b4
	dw	693                             ; 0x2b5
	dw	694                             ; 0x2b6
	dw	170                             ; 0xaa
	dw	171                             ; 0xab
	dw	647                             ; 0x287
	dw	170                             ; 0xaa
	dw	697                             ; 0x2b9
	dw	692                             ; 0x2b4
	dw	698                             ; 0x2ba
	dw	694                             ; 0x2b6
	dw	697                             ; 0x2b9
	dw	149                             ; 0x95
	dw	699                             ; 0x2bb
	dw	700                             ; 0x2bc
	dw	701                             ; 0x2bd
	dw	155                             ; 0x9b
	dw	155                             ; 0x9b
	dw	381                             ; 0x17d
	dw	381                             ; 0x17d
	dw	702                             ; 0x2be
	dw	381                             ; 0x17d
	dw	447                             ; 0x1bf
	dw	703                             ; 0x2bf
	dw	704                             ; 0x2c0
	dw	705                             ; 0x2c1
	dw	148                             ; 0x94
	dw	149                             ; 0x95
	dw	706                             ; 0x2c2
	dw	155                             ; 0x9b
	dw	447                             ; 0x1bf
	dw	703                             ; 0x2bf
	dw	149                             ; 0x95
	dw	707                             ; 0x2c3
	dw	708                             ; 0x2c4
	dw	697                             ; 0x2b9
	dw	704                             ; 0x2c0
	dw	709                             ; 0x2c5
	dw	710                             ; 0x2c6
	dw	703                             ; 0x2bf
	dw	711                             ; 0x2c7
	dw	712                             ; 0x2c8
	dw	713                             ; 0x2c9
	dw	714                             ; 0x2ca
	dw	715                             ; 0x2cb
	dw	375                             ; 0x177
	dw	716                             ; 0x2cc
	dw	717                             ; 0x2cd
	dw	377                             ; 0x179
	dw	718                             ; 0x2ce
	dw	719                             ; 0x2cf
	dw	720                             ; 0x2d0
	dw	721                             ; 0x2d1
	dw	218                             ; 0xda
	dw	379                             ; 0x17b
	dw	722                             ; 0x2d2
	dw	710                             ; 0x2c6
	dw	723                             ; 0x2d3
	dw	724                             ; 0x2d4
	dw	451                             ; 0x1c3
	dw	721                             ; 0x2d1
	dw	725                             ; 0x2d5
	dw	719                             ; 0x2cf
	dw	720                             ; 0x2d0
	dw	726                             ; 0x2d6
	dw	712                             ; 0x2c8
	dw	716                             ; 0x2cc
	dw	727                             ; 0x2d7
	dw	710                             ; 0x2c6
	dw	728                             ; 0x2d8
	dw	729                             ; 0x2d9
	dw	720                             ; 0x2d0
	dw	704                             ; 0x2c0
	dw	730                             ; 0x2da
	dw	731                             ; 0x2db
	dw	697                             ; 0x2b9
	dw	710                             ; 0x2c6
	dw	732                             ; 0x2dc
	dw	733                             ; 0x2dd
	dw	727                             ; 0x2d7
	dw	664                             ; 0x298
	dw	627                             ; 0x273
	dw	734                             ; 0x2de
	dw	690                             ; 0x2b2
	dw	704                             ; 0x2c0
	dw	735                             ; 0x2df
	dw	733                             ; 0x2dd
	dw	727                             ; 0x2d7
	dw	158                             ; 0x9e
	dw	165                             ; 0xa5
	dw	736                             ; 0x2e0
	dw	164                             ; 0xa4
	dw	737                             ; 0x2e1
	dw	627                             ; 0x273
	dw	733                             ; 0x2dd
	dw	738                             ; 0x2e2
	dw	153                             ; 0x99
	dw	630                             ; 0x276
	dw	628                             ; 0x274
	dw	437                             ; 0x1b5
	dw	737                             ; 0x2e1
	dw	627                             ; 0x273
	dw	733                             ; 0x2dd
	dw	738                             ; 0x2e2
	dw	200                             ; 0xc8
	dw	201                             ; 0xc9
	dw	198                             ; 0xc6
	dw	199                             ; 0xc7
	dw	198                             ; 0xc6
	dw	199                             ; 0xc7
	dw	196                             ; 0xc4
	dw	197                             ; 0xc5
	dw	196                             ; 0xc4
	dw	197                             ; 0xc5
	dw	194                             ; 0xc2
	dw	195                             ; 0xc3
	dw	194                             ; 0xc2
	dw	195                             ; 0xc3
	dw	192                             ; 0xc0
	dw	193                             ; 0xc1
	dw	200                             ; 0xc8
	dw	201                             ; 0xc9
	dw	196                             ; 0xc4
	dw	197                             ; 0xc5
	dw	196                             ; 0xc4
	dw	197                             ; 0xc5
	dw	192                             ; 0xc0
	dw	193                             ; 0xc1
	dw	192                             ; 0xc0
	dw	193                             ; 0xc1
	dw	206                             ; 0xce
	dw	207                             ; 0xcf
	dw	206                             ; 0xce
	dw	207                             ; 0xcf
	dw	167                             ; 0xa7
	dw	208                             ; 0xd0
	dw	165                             ; 0xa5
	dw	453                             ; 0x1c5
	dw	164                             ; 0xa4
	dw	452                             ; 0x1c4
	dw	192                             ; 0xc0
	dw	193                             ; 0xc1
	dw	167                             ; 0xa7
	dw	208                             ; 0xd0
	dw	200                             ; 0xc8
	dw	201                             ; 0xc9
	dw	192                             ; 0xc0
	dw	193                             ; 0xc1
	dw	739                             ; 0x2e3
	dw	740                             ; 0x2e4
	dw	164                             ; 0xa4
	dw	452                             ; 0x1c4
	dw	741                             ; 0x2e5
	dw	349                             ; 0x15d
	dw	742                             ; 0x2e6
	dw	743                             ; 0x2e7
	dw	439                             ; 0x1b7
	dw	744                             ; 0x2e8
	dw	745                             ; 0x2e9
	dw	353                             ; 0x161
	dw	741                             ; 0x2e5
	dw	349                             ; 0x15d
	dw	742                             ; 0x2e6
	dw	743                             ; 0x2e7
	dw	351                             ; 0x15f
	dw	350                             ; 0x15e
	dw	352                             ; 0x160
	dw	349                             ; 0x15d
	dw	365                             ; 0x16d
	dw	348                             ; 0x15c
	dw	369                             ; 0x171
	dw	367                             ; 0x16f
	dw	369                             ; 0x171
	dw	367                             ; 0x16f
	dw	746                             ; 0x2ea
	dw	366                             ; 0x16e
	dw	747                             ; 0x2eb
	dw	369                             ; 0x171
	dw	370                             ; 0x172
	dw	748                             ; 0x2ec
	dw	749                             ; 0x2ed
	dw	750                             ; 0x2ee
	dw	449                             ; 0x1c1
	dw	751                             ; 0x2ef
	dw	365                             ; 0x16d
	dw	348                             ; 0x15c
	dw	746                             ; 0x2ea
	dw	366                             ; 0x16e
	dw	749                             ; 0x2ed
	dw	752                             ; 0x2f0
	dw	449                             ; 0x1c1
	dw	746                             ; 0x2ea
	dw	753                             ; 0x2f1
	dw	348                             ; 0x15c
	dw	449                             ; 0x1c1
	dw	366                             ; 0x16e
	dw	374                             ; 0x176
	dw	366                             ; 0x16e
	dw	754                             ; 0x2f2
	dw	755                             ; 0x2f3
	dw	756                             ; 0x2f4
	dw	350                             ; 0x15e
	dw	742                             ; 0x2e6
	dw	743                             ; 0x2e7
	dw	753                             ; 0x2f1
	dw	348                             ; 0x15c
	dw	757                             ; 0x2f5
	dw	755                             ; 0x2f3
	dw	627                             ; 0x273
	dw	620                             ; 0x26c
	dw	164                             ; 0xa4
	dw	452                             ; 0x1c4
	dw	758                             ; 0x2f6
	dw	350                             ; 0x15e
	dw	757                             ; 0x2f5
	dw	759                             ; 0x2f7
	dw	737                             ; 0x2e1
	dw	630                             ; 0x276
	dw	733                             ; 0x2dd
	dw	760                             ; 0x2f8
	dw	761                             ; 0x2f9
	dw	620                             ; 0x26c
	dw	757                             ; 0x2f5
	dw	759                             ; 0x2f7
	dw	151                             ; 0x97
	dw	150                             ; 0x96
	dw	762                             ; 0x2fa
	dw	763                             ; 0x2fb
	dw	147                             ; 0x93
	dw	146                             ; 0x92
	dw	147                             ; 0x93
	dw	146                             ; 0x92
	dw	764                             ; 0x2fc
	dw	765                             ; 0x2fd
	dw	766                             ; 0x2fe
	dw	767                             ; 0x2ff
	dw	737                             ; 0x2e1
	dw	150                             ; 0x96
	dw	768                             ; 0x300
	dw	763                             ; 0x2fb
	dw	764                             ; 0x2fc
	dw	150                             ; 0x96
	dw	766                             ; 0x2fe
	dw	769                             ; 0x301
	dw	144                             ; 0x90
	dw	141                             ; 0x8d
	dw	770                             ; 0x302
	dw	771                             ; 0x303
	dw	737                             ; 0x2e1
	dw	620                             ; 0x26c
	dw	733                             ; 0x2dd
	dw	772                             ; 0x304
	dw	144                             ; 0x90
	dw	150                             ; 0x96
	dw	773                             ; 0x305
	dw	769                             ; 0x301
	dw	409                             ; 0x199
	dw	611                             ; 0x263
	dw	624                             ; 0x270
	dw	620                             ; 0x26c
	dw	144                             ; 0x90
	dw	620                             ; 0x26c
	dw	774                             ; 0x306
	dw	772                             ; 0x304
	dw	229                             ; 0xe5
	dw	241                             ; 0xf1
	dw	232                             ; 0xe8
	dw	234                             ; 0xea
	dw	230                             ; 0xe6
	dw	229                             ; 0xe5
	dw	231                             ; 0xe7
	dw	232                             ; 0xe8
	dw	230                             ; 0xe6
	dw	241                             ; 0xf1
	dw	231                             ; 0xe7
	dw	234                             ; 0xea
	dw	241                             ; 0xf1
	dw	456                             ; 0x1c8
	dw	234                             ; 0xea
	dw	455                             ; 0x1c7
	dw	242                             ; 0xf2
	dw	245                             ; 0xf5
	dw	229                             ; 0xe5
	dw	241                             ; 0xf1
	dw	228                             ; 0xe4
	dw	238                             ; 0xee
	dw	242                             ; 0xf2
	dw	245                             ; 0xf5
	dw	239                             ; 0xef
	dw	457                             ; 0x1c9
	dw	240                             ; 0xf0
	dw	456                             ; 0x1c8
	dw	228                             ; 0xe4
	dw	238                             ; 0xee
	dw	229                             ; 0xe5
	dw	241                             ; 0xf1
	dw	226                             ; 0xe2
	dw	253                             ; 0xfd
	dw	775                             ; 0x307
	dw	457                             ; 0x1c9
	dw	228                             ; 0xe4
	dw	457                             ; 0x1c9
	dw	229                             ; 0xe5
	dw	456                             ; 0x1c8
	dw	230                             ; 0xe6
	dw	456                             ; 0x1c8
	dw	231                             ; 0xe7
	dw	455                             ; 0x1c7
	dw	226                             ; 0xe2
	dw	253                             ; 0xfd
	dw	230                             ; 0xe6
	dw	456                             ; 0x1c8
	dw	232                             ; 0xe8
	dw	234                             ; 0xea
	dw	244                             ; 0xf4
	dw	243                             ; 0xf3
	dw	244                             ; 0xf4
	dw	243                             ; 0xf3
	dw	233                             ; 0xe9
	dw	237                             ; 0xed
	dw	235                             ; 0xeb
	dw	455                             ; 0x1c7
	dw	236                             ; 0xec
	dw	458                             ; 0x1ca
	dw	232                             ; 0xe8
	dw	234                             ; 0xea
	dw	233                             ; 0xe9
	dw	237                             ; 0xed
	dw	776                             ; 0x308
	dw	458                             ; 0x1ca
	dw	225                             ; 0xe1
	dw	250                             ; 0xfa
	dw	232                             ; 0xe8
	dw	455                             ; 0x1c7
	dw	233                             ; 0xe9
	dw	458                             ; 0x1ca
	dw	226                             ; 0xe2
	dw	253                             ; 0xfd
	dw	231                             ; 0xe7
	dw	455                             ; 0x1c7
	dw	231                             ; 0xe7
	dw	455                             ; 0x1c7
	dw	225                             ; 0xe1
	dw	250                             ; 0xfa
	dw	453                             ; 0x1c5
	dw	209                             ; 0xd1
	dw	452                             ; 0x1c4
	dw	166                             ; 0xa6
	dw	209                             ; 0xd1
	dw	270                             ; 0x10e
	dw	166                             ; 0xa6
	dw	271                             ; 0x10f
	dw	272                             ; 0x110
	dw	777                             ; 0x309
	dw	778                             ; 0x30a
	dw	231                             ; 0xe7
	dw	270                             ; 0x10e
	dw	272                             ; 0x110
	dw	271                             ; 0x10f
	dw	273                             ; 0x111
	dw	453                             ; 0x1c5
	dw	270                             ; 0x10e
	dw	452                             ; 0x1c4
	dw	271                             ; 0x10f
	dw	270                             ; 0x10e
	dw	777                             ; 0x309
	dw	779                             ; 0x30b
	dw	231                             ; 0xe7
	dw	189                             ; 0xbd
	dw	187                             ; 0xbb
	dw	190                             ; 0xbe
	dw	191                             ; 0xbf
	dw	611                             ; 0x263
	dw	780                             ; 0x30c
	dw	189                             ; 0xbd
	dw	187                             ; 0xbb
	dw	190                             ; 0xbe
	dw	191                             ; 0xbf
	dw	432                             ; 0x1b0
	dw	781                             ; 0x30d
	dw	782                             ; 0x30e
	dw	230                             ; 0xe6
	dw	272                             ; 0x110
	dw	777                             ; 0x309
	dw	611                             ; 0x263
	dw	780                             ; 0x30c
	dw	190                             ; 0xbe
	dw	191                             ; 0xbf
	dw	190                             ; 0xbe
	dw	783                             ; 0x30f
	dw	453                             ; 0x1c5
	dw	777                             ; 0x309
	dw	453                             ; 0x1c5
	dw	777                             ; 0x309
	dw	784                             ; 0x310
	dw	231                             ; 0xe7
	dw	611                             ; 0x263
	dw	785                             ; 0x311
	dw	453                             ; 0x1c5
	dw	777                             ; 0x309
	dw	226                             ; 0xe2
	dw	253                             ; 0xfd
	dw	225                             ; 0xe1
	dw	250                             ; 0xfa
	dw	611                             ; 0x263
	dw	785                             ; 0x311
	dw	784                             ; 0x310
	dw	231                             ; 0xe7
	dw	462                             ; 0x1ce
	dw	460                             ; 0x1cc
	dw	275                             ; 0x113
	dw	276                             ; 0x114
	dw	275                             ; 0x113
	dw	276                             ; 0x114
	dw	274                             ; 0x112
	dw	277                             ; 0x115
	dw	252                             ; 0xfc
	dw	462                             ; 0x1ce
	dw	461                             ; 0x1cd
	dw	274                             ; 0x112
	dw	462                             ; 0x1ce
	dw	460                             ; 0x1cc
	dw	274                             ; 0x112
	dw	277                             ; 0x115
	dw	461                             ; 0x1cd
	dw	277                             ; 0x115
	dw	251                             ; 0xfb
	dw	459                             ; 0x1cb
	dw	252                             ; 0xfc
	dw	460                             ; 0x1cc
	dw	461                             ; 0x1cd
	dw	277                             ; 0x115
	dw	460                             ; 0x1cc
	dw	255                             ; 0xff
	dw	459                             ; 0x1cb
	dw	254                             ; 0xfe
	dw	252                             ; 0xfc
	dw	460                             ; 0x1cc
	dw	251                             ; 0xfb
	dw	459                             ; 0x1cb
	dw	257                             ; 0x101
	dw	258                             ; 0x102
	dw	256                             ; 0x100
	dw	259                             ; 0x103
	dw	258                             ; 0x102
	dw	263                             ; 0x107
	dw	259                             ; 0x103
	dw	260                             ; 0x104
	dw	252                             ; 0xfc
	dw	255                             ; 0xff
	dw	251                             ; 0xfb
	dw	254                             ; 0xfe
	dw	257                             ; 0x101
	dw	263                             ; 0x107
	dw	256                             ; 0x100
	dw	260                             ; 0x104
	dw	464                             ; 0x1d0
	dw	466                             ; 0x1d2
	dw	279                             ; 0x117
	dw	280                             ; 0x118
	dw	279                             ; 0x117
	dw	280                             ; 0x118
	dw	278                             ; 0x116
	dw	281                             ; 0x119
	dw	466                             ; 0x1d2
	dw	267                             ; 0x10b
	dw	281                             ; 0x119
	dw	465                             ; 0x1d1
	dw	464                             ; 0x1d0
	dw	466                             ; 0x1d2
	dw	278                             ; 0x116
	dw	281                             ; 0x119
	dw	278                             ; 0x116
	dw	465                             ; 0x1d1
	dw	463                             ; 0x1cf
	dw	266                             ; 0x10a
	dw	464                             ; 0x1d0
	dw	267                             ; 0x10b
	dw	278                             ; 0x116
	dw	465                             ; 0x1d1
	dw	265                             ; 0x109
	dw	464                             ; 0x1d0
	dw	264                             ; 0x108
	dw	463                             ; 0x1cf
	dw	464                             ; 0x1d0
	dw	267                             ; 0x10b
	dw	463                             ; 0x1cf
	dw	266                             ; 0x10a
	dw	265                             ; 0x109
	dw	267                             ; 0x10b
	dw	264                             ; 0x108
	dw	266                             ; 0x10a
	dw	263                             ; 0x107
	dw	262                             ; 0x106
	dw	260                             ; 0x104
	dw	261                             ; 0x105
	dw	252                             ; 0xfc
	dw	786                             ; 0x312
	dw	251                             ; 0xfb
	dw	787                             ; 0x313
	dw	788                             ; 0x314
	dw	267                             ; 0x10b
	dw	789                             ; 0x315
	dw	266                             ; 0x10a
	dw	611                             ; 0x263
	dw	790                             ; 0x316
	dw	349                             ; 0x15d
	dw	250                             ; 0xfa
	dw	456                             ; 0x1c8
	dw	267                             ; 0x10b
	dw	455                             ; 0x1c7
	dw	266                             ; 0x10a
	dw	409                             ; 0x199
	dw	611                             ; 0x263
	dw	791                             ; 0x317
	dw	772                             ; 0x304
	dw	611                             ; 0x263
	dw	792                             ; 0x318
	dw	349                             ; 0x15d
	dw	793                             ; 0x319
	dw	794                             ; 0x31a
	dw	795                             ; 0x31b
	dw	409                             ; 0x199
	dw	413                             ; 0x19d
	dw	409                             ; 0x199
	dw	792                             ; 0x318
	dw	791                             ; 0x317
	dw	796                             ; 0x31c

	.section	.bss._depthbuffer,"aw",@nobits
	.balign	1
	.globl	_depthbuffer
_depthbuffer:
	.zero	10240

	.section	.bss._frame_stamp,"aw",@nobits
	.balign	1
	.local	_frame_stamp
_frame_stamp:
	.zero	1

	.section	.bss._vertex_stamp,"aw",@nobits
	.balign	1
	.local	_vertex_stamp
_vertex_stamp:
	.zero	797

	.section	.bss._camcos,"aw",@nobits
	.balign	1
	.globl	_camcos
_camcos:
	.zero	3

	.section	.bss._camsin,"aw",@nobits
	.balign	1
	.globl	_camsin
_camsin:
	.zero	3

	.section	.rodata._gun_frames,"a",@progbits
	.balign	1
	.local	_gun_frames
_gun_frames:
	.ascii	"\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377l\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\226\006\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377je\006\237\005\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377n\007mn\000\013\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377l\237fm\t\f\005\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\013\n\232\217n\n\n~\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377klf\000\000\000\too\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377c[f]hn\005\nf\006\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\217\006\006^]\000\000\000\000hn\236\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377n\006l`\000\013\005\000\000\013\005\013\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\006jem\000\000\000\000\013\236\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377Efk`ko\000\000\000\237\n\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377DIalgko\177\013\013o\013\000\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377IBBA\006om\000\000\000\000\000\000\000\000\377\377\377\377\377\377\377\377\377\377\377\377\377\377ICBC<H\006eo\006l\000\000\007KEGI\377\377\377\377\377\377\377\377\377\377\377\377ECADB<;BHMOMD68<>EH\377\377\377\377\377\377\377\377\377\377\377HCCADB?>AFC;<96>BKF\377\377\377\377\377\377\377\377\377\377HJFEDACE@@A@?B><CE\002\005\377\377\377\377\377\377\377\377\377\377LLIGEDDBAB=:;@@?EF\002M\377\377\377\377\377\377\377\377\377\377\002MGHIEEBDB>@BEAAGLO\377\377\377\377\377\377\377\377\377\377\377MKBBAABDC>AFEMCE\227\002\377\377\377\377\377\377\377\377\377\377\377\377MIH>>FIGB@ACLG\225L\002\000\377\377\377\377\377\377\377\377\377\377\377\377KJBE>8>>BEHDG\001M\002\b\002\377\377\377\377\377\377\377\377\377\377\377JADJJJIC<FKDDOI\b\000\000\377\377\377\377\377\377\377\377\377\377JOMKKJJA;>ALECCI\000\000\000\377\377\377\377"
	.ascii	"\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377l\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\226\006\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377je\006\237\005\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\007n\000\000\f\n\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377mojn\n\000\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\005\005\233fl\t\n~\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\013l\230\000n\n\n\000\005\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\n\nbX\227m\n\tk\005\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377c[f]hn\005\nf\006\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377jj^j\234\237\013\000ko\t\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377n\006l`\000\013\005\000\000\013\005\013\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\006jem\000\000\000\000\013\236\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\006n\\flO\000\000\t\t\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377DIalgko\177\013\013o\013\000\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377DBF\005ooihkM\n\007\000\000\377\377\377\377\377\377\377\377\377\377\377\377\377\377HECC@J\006bo\000n\000\000\000OIIM\377\377\377\377\377\377\377\377\377\377\377\377ECCC>?EO\000\000o\000\000IDDEEM\377\377\377\377\377\377\377\377\377\377\377DBABC>=>>DE?:86>AIF\377\377\377\377\377\377\377\377\377\377JFCC@AEBABD???;8@CMI\377\377\377\377\377\377\377\377\377HKHFEDACE@@A@?B>=CE\002\005\377\377\377\377\377\377\377\377\377DNJIFEDDBAB=:;@@?EF\002M\377\377\377\377\377\377\377\377\377K\002JGHIEEBDB>@BEAAGLO\377\377\377\377\377\377\377\377\377\377\377NFBCEA@@;>EBFJDEJO\377\377\377\377\377\377\377\377\377\377\377\377MADA<>GB:>AAFJHJO\000\377\377\377\377\377\377\377\377\377\377\377\377MIFBFDDDFFDBLKLO\b\001\377\377\377\377\377\377\377\377\377\377\377OKDDE>8<AIDBHJIN\000\002\000\377\377\377\377\377\377\377\377\377\377JID=:9>EIC>FGBLKO\002\000\000\377\377\377\377\377\377\377\377\377OOFBFEHJJ>?DI=CHO\000\000\377\377\377\377\377\377\377\377\377\377\377O@B<A>DFHMF=AKAHO\000\000\377\377\377\377\377\377\377\377\377HIB>DDF<>B>HKJEAMHO\000\377\377\377\377\377\377\377\377\377GHB=;:C>;BECII\005JBLM\000\377\377\377\377\377\377\377\377IGCE;<>:<D:DHIHJN\001IJ\000\b\377\377\377\377\377\377FGDHB6:;A><F:HHHF\001N\001KM\377\377\377\377\377\377\377\377"
	.ascii	"\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\006\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377l`n\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\006f\006\237\237\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377oge\n\237\237\005\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377lj\007\007\006\013\013\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377l\007mlo\000\013\005\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\000\013^gim\t\f~\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\000\tYgim\t\n~\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\017h\232\217\003a\n\n\000o\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\005ki\000\000\000\000\n\005\005\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\n\005if\227\227o\n\t\t\006\000\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377m\017fbdko\n\t\t\b\000\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\016\r\016\\Ygkn\005\005jne\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\006j\005S]jn\000\000\000k\005\005\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377El\006l`j\237\t\013\005\000\007\n\006\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377EB\006\000og\005\000\000\000\000\000\007\007\000\377\377\377\377\377\377\377\377\377\377\377\377\377\377FCC\017\006o\005\000\000\007\000\000\000\007O\000L\377\377\377\377\377\377\377\377\377\377\377\377EFBD\006\006\006O\000\000i\000\000OKGIADL\377\377\377\377\377\377\377\377\377\377HAABBDCGKMOOK<6;=BIF\377\377\377\377\377\377\377\377\377JHCCCADB=ADFB;<9=AFOJ\377\377\377\377\377\377\377\377\377FJFDD@>EFDDB@>?=@CG\002M\377\377\377\377\377\377\377\377\377GLIEEC@CD@AA>?@>BDH\002\000\377\377\377\377\377\377\377\377\377LNIHFEDBAA>=9;C@CG\225\002\005\377\377\377\377\377\377\377\377\377MNHFGAE><ABBBDGADI\227\002\377\377\377\377\377\377\377\377\377\377\377LDBEABBD>>AAEMEI\227\002O\377\377\377\377\377\377\377\377\377\377\377LCD;EFICB>ACLKIM\002\000\377\377\377\377\377\377\377\377\377\377\377\377KJBE>8>@BHHDG\001L\002\b\000\005\377\377\377\377\377\377\377\377\377\377JADJJJIC;FFFDJIO\000\b\000\000\377\377\377\377\377\377\377\377\377JJD=:9>EIH>BIBIKO\002\000\000\377\377\377\377\377\377\377\377\377\377OIBFEGJJ>?DE?C?O\000\000\000\377\377\377\377\377\377\377\377\377\377\377@D<F>>FHMB=GLACO\000\000\000\377\377\377\377\377\377\377\377\377IB>ADA<<B>H\005JA<MFO\000\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377"

	.section	.rodata._gun_flash,"a",@progbits
	.balign	1
	.local	_gun_flash
_gun_flash:
	.ascii	"\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\032\033\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\032\377\024:!\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\032\257\021\323\254\261\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377 \256\021\341\254\257%\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\033\265\256\2541\004\021\255\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\264\255\25410\00403\256\261\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\257\255\2530\004\321\0041\255\256\261\261\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\266\256\0210\341\32190\3412\254\261\261\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\256\252\3415\326L910\254\257\261\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\335\257\255\253\341\341\353\226\354\354\352\321\251\254\260\257\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\257\256\2542\200O\355\247\002O\323\020\255\256\257\377\377\377\377\377\377\377\377\377\377\377\377\377\377\034\261\257\255\202O\355E\333\247\356$\021\257\261\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\036\257\256\005\356\246B\337\247\356O\034\257\262\266\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377m\ni\000\000\000\n\000o\264\035\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377"

	.section	.bss._d84_rotated,"aw",@nobits
	.balign	2
	.globl	_d84_rotated
_d84_rotated:
	.zero	6

	.section	.rodata._sector_offsets,"a",@progbits
	.balign	2
	.local	_sector_offsets
_sector_offsets:
	dw	0                               ; 0x0
	dw	10                              ; 0xa
	dw	20                              ; 0x14
	dw	30                              ; 0x1e
	dw	40                              ; 0x28
	dw	50                              ; 0x32
	dw	60                              ; 0x3c
	dw	70                              ; 0x46
	dw	80                              ; 0x50
	dw	90                              ; 0x5a
	dw	100                             ; 0x64
	dw	110                             ; 0x6e
	dw	120                             ; 0x78
	dw	130                             ; 0x82
	dw	140                             ; 0x8c
	dw	150                             ; 0x96
	dw	160                             ; 0xa0
	dw	170                             ; 0xaa
	dw	180                             ; 0xb4
	dw	190                             ; 0xbe
	dw	200                             ; 0xc8
	dw	210                             ; 0xd2
	dw	220                             ; 0xdc
	dw	230                             ; 0xe6
	dw	240                             ; 0xf0
	dw	250                             ; 0xfa
	dw	260                             ; 0x104
	dw	270                             ; 0x10e
	dw	280                             ; 0x118
	dw	290                             ; 0x122
	dw	300                             ; 0x12c
	dw	310                             ; 0x136
	dw	320                             ; 0x140
	dw	330                             ; 0x14a
	dw	340                             ; 0x154
	dw	350                             ; 0x15e
	dw	360                             ; 0x168
	dw	370                             ; 0x172
	dw	380                             ; 0x17c
	dw	390                             ; 0x186
	dw	400                             ; 0x190
	dw	410                             ; 0x19a
	dw	420                             ; 0x1a4
	dw	430                             ; 0x1ae
	dw	440                             ; 0x1b8
	dw	450                             ; 0x1c2
	dw	460                             ; 0x1cc
	dw	470                             ; 0x1d6
	dw	480                             ; 0x1e0
	dw	490                             ; 0x1ea
	dw	500                             ; 0x1f4
	dw	510                             ; 0x1fe
	dw	520                             ; 0x208
	dw	530                             ; 0x212
	dw	540                             ; 0x21c
	dw	550                             ; 0x226
	dw	560                             ; 0x230
	dw	570                             ; 0x23a
	dw	580                             ; 0x244
	dw	590                             ; 0x24e
	dw	600                             ; 0x258
	dw	610                             ; 0x262
	dw	620                             ; 0x26c
	dw	630                             ; 0x276
	dw	640                             ; 0x280
	dw	650                             ; 0x28a
	dw	660                             ; 0x294
	dw	670                             ; 0x29e
	dw	680                             ; 0x2a8
	dw	690                             ; 0x2b2
	dw	700                             ; 0x2bc
	dw	710                             ; 0x2c6
	dw	720                             ; 0x2d0
	dw	730                             ; 0x2da
	dw	740                             ; 0x2e4
	dw	750                             ; 0x2ee
	dw	760                             ; 0x2f8
	dw	770                             ; 0x302
	dw	780                             ; 0x30c
	dw	790                             ; 0x316
	dw	800                             ; 0x320
	dw	810                             ; 0x32a
	dw	820                             ; 0x334
	dw	830                             ; 0x33e
	dw	840                             ; 0x348

	.section	.rodata._sine_table,"a",@progbits
	.balign	2
	.local	_sine_table
_sine_table:
	dw	0                               ; 0x0
	dw	2                               ; 0x2
	dw	3                               ; 0x3
	dw	5                               ; 0x5
	dw	6                               ; 0x6
	dw	8                               ; 0x8
	dw	9                               ; 0x9
	dw	11                              ; 0xb
	dw	13                              ; 0xd
	dw	14                              ; 0xe
	dw	16                              ; 0x10
	dw	17                              ; 0x11
	dw	19                              ; 0x13
	dw	20                              ; 0x14
	dw	22                              ; 0x16
	dw	24                              ; 0x18
	dw	25                              ; 0x19
	dw	27                              ; 0x1b
	dw	28                              ; 0x1c
	dw	30                              ; 0x1e
	dw	31                              ; 0x1f
	dw	33                              ; 0x21
	dw	34                              ; 0x22
	dw	36                              ; 0x24
	dw	38                              ; 0x26
	dw	39                              ; 0x27
	dw	41                              ; 0x29
	dw	42                              ; 0x2a
	dw	44                              ; 0x2c
	dw	45                              ; 0x2d
	dw	47                              ; 0x2f
	dw	48                              ; 0x30
	dw	50                              ; 0x32
	dw	51                              ; 0x33
	dw	53                              ; 0x35
	dw	55                              ; 0x37
	dw	56                              ; 0x38
	dw	58                              ; 0x3a
	dw	59                              ; 0x3b
	dw	61                              ; 0x3d
	dw	62                              ; 0x3e
	dw	64                              ; 0x40
	dw	65                              ; 0x41
	dw	67                              ; 0x43
	dw	68                              ; 0x44
	dw	70                              ; 0x46
	dw	71                              ; 0x47
	dw	73                              ; 0x49
	dw	74                              ; 0x4a
	dw	76                              ; 0x4c
	dw	77                              ; 0x4d
	dw	79                              ; 0x4f
	dw	80                              ; 0x50
	dw	82                              ; 0x52
	dw	83                              ; 0x53
	dw	85                              ; 0x55
	dw	86                              ; 0x56
	dw	88                              ; 0x58
	dw	89                              ; 0x59
	dw	91                              ; 0x5b
	dw	92                              ; 0x5c
	dw	94                              ; 0x5e
	dw	95                              ; 0x5f
	dw	97                              ; 0x61
	dw	98                              ; 0x62
	dw	99                              ; 0x63
	dw	101                             ; 0x65
	dw	102                             ; 0x66
	dw	104                             ; 0x68
	dw	105                             ; 0x69
	dw	107                             ; 0x6b
	dw	108                             ; 0x6c
	dw	109                             ; 0x6d
	dw	111                             ; 0x6f
	dw	112                             ; 0x70
	dw	114                             ; 0x72
	dw	115                             ; 0x73
	dw	117                             ; 0x75
	dw	118                             ; 0x76
	dw	119                             ; 0x77
	dw	121                             ; 0x79
	dw	122                             ; 0x7a
	dw	123                             ; 0x7b
	dw	125                             ; 0x7d
	dw	126                             ; 0x7e
	dw	128                             ; 0x80
	dw	129                             ; 0x81
	dw	130                             ; 0x82
	dw	132                             ; 0x84
	dw	133                             ; 0x85
	dw	134                             ; 0x86
	dw	136                             ; 0x88
	dw	137                             ; 0x89
	dw	138                             ; 0x8a
	dw	140                             ; 0x8c
	dw	141                             ; 0x8d
	dw	142                             ; 0x8e
	dw	144                             ; 0x90
	dw	145                             ; 0x91
	dw	146                             ; 0x92
	dw	147                             ; 0x93
	dw	149                             ; 0x95
	dw	150                             ; 0x96
	dw	151                             ; 0x97
	dw	152                             ; 0x98
	dw	154                             ; 0x9a
	dw	155                             ; 0x9b
	dw	156                             ; 0x9c
	dw	157                             ; 0x9d
	dw	159                             ; 0x9f
	dw	160                             ; 0xa0
	dw	161                             ; 0xa1
	dw	162                             ; 0xa2
	dw	164                             ; 0xa4
	dw	165                             ; 0xa5
	dw	166                             ; 0xa6
	dw	167                             ; 0xa7
	dw	168                             ; 0xa8
	dw	170                             ; 0xaa
	dw	171                             ; 0xab
	dw	172                             ; 0xac
	dw	173                             ; 0xad
	dw	174                             ; 0xae
	dw	175                             ; 0xaf
	dw	177                             ; 0xb1
	dw	178                             ; 0xb2
	dw	179                             ; 0xb3
	dw	180                             ; 0xb4
	dw	181                             ; 0xb5
	dw	182                             ; 0xb6
	dw	183                             ; 0xb7
	dw	184                             ; 0xb8
	dw	185                             ; 0xb9
	dw	186                             ; 0xba
	dw	188                             ; 0xbc
	dw	189                             ; 0xbd
	dw	190                             ; 0xbe
	dw	191                             ; 0xbf
	dw	192                             ; 0xc0
	dw	193                             ; 0xc1
	dw	194                             ; 0xc2
	dw	195                             ; 0xc3
	dw	196                             ; 0xc4
	dw	197                             ; 0xc5
	dw	198                             ; 0xc6
	dw	199                             ; 0xc7
	dw	200                             ; 0xc8
	dw	201                             ; 0xc9
	dw	202                             ; 0xca
	dw	203                             ; 0xcb
	dw	204                             ; 0xcc
	dw	205                             ; 0xcd
	dw	206                             ; 0xce
	dw	207                             ; 0xcf
	dw	207                             ; 0xcf
	dw	208                             ; 0xd0
	dw	209                             ; 0xd1
	dw	210                             ; 0xd2
	dw	211                             ; 0xd3
	dw	212                             ; 0xd4
	dw	213                             ; 0xd5
	dw	214                             ; 0xd6
	dw	215                             ; 0xd7
	dw	215                             ; 0xd7
	dw	216                             ; 0xd8
	dw	217                             ; 0xd9
	dw	218                             ; 0xda
	dw	219                             ; 0xdb
	dw	220                             ; 0xdc
	dw	220                             ; 0xdc
	dw	221                             ; 0xdd
	dw	222                             ; 0xde
	dw	223                             ; 0xdf
	dw	224                             ; 0xe0
	dw	224                             ; 0xe0
	dw	225                             ; 0xe1
	dw	226                             ; 0xe2
	dw	227                             ; 0xe3
	dw	227                             ; 0xe3
	dw	228                             ; 0xe4
	dw	229                             ; 0xe5
	dw	229                             ; 0xe5
	dw	230                             ; 0xe6
	dw	231                             ; 0xe7
	dw	231                             ; 0xe7
	dw	232                             ; 0xe8
	dw	233                             ; 0xe9
	dw	233                             ; 0xe9
	dw	234                             ; 0xea
	dw	235                             ; 0xeb
	dw	235                             ; 0xeb
	dw	236                             ; 0xec
	dw	237                             ; 0xed
	dw	237                             ; 0xed
	dw	238                             ; 0xee
	dw	238                             ; 0xee
	dw	239                             ; 0xef
	dw	239                             ; 0xef
	dw	240                             ; 0xf0
	dw	241                             ; 0xf1
	dw	241                             ; 0xf1
	dw	242                             ; 0xf2
	dw	242                             ; 0xf2
	dw	243                             ; 0xf3
	dw	243                             ; 0xf3
	dw	244                             ; 0xf4
	dw	244                             ; 0xf4
	dw	245                             ; 0xf5
	dw	245                             ; 0xf5
	dw	245                             ; 0xf5
	dw	246                             ; 0xf6
	dw	246                             ; 0xf6
	dw	247                             ; 0xf7
	dw	247                             ; 0xf7
	dw	248                             ; 0xf8
	dw	248                             ; 0xf8
	dw	248                             ; 0xf8
	dw	249                             ; 0xf9
	dw	249                             ; 0xf9
	dw	249                             ; 0xf9
	dw	250                             ; 0xfa
	dw	250                             ; 0xfa
	dw	250                             ; 0xfa
	dw	251                             ; 0xfb
	dw	251                             ; 0xfb
	dw	251                             ; 0xfb
	dw	252                             ; 0xfc
	dw	252                             ; 0xfc
	dw	252                             ; 0xfc
	dw	252                             ; 0xfc
	dw	253                             ; 0xfd
	dw	253                             ; 0xfd
	dw	253                             ; 0xfd
	dw	253                             ; 0xfd
	dw	254                             ; 0xfe
	dw	254                             ; 0xfe
	dw	254                             ; 0xfe
	dw	254                             ; 0xfe
	dw	254                             ; 0xfe
	dw	255                             ; 0xff
	dw	255                             ; 0xff
	dw	255                             ; 0xff
	dw	255                             ; 0xff
	dw	255                             ; 0xff
	dw	255                             ; 0xff
	dw	255                             ; 0xff
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	256                             ; 0x100
	dw	255                             ; 0xff
	dw	255                             ; 0xff
	dw	255                             ; 0xff
	dw	255                             ; 0xff
	dw	255                             ; 0xff
	dw	255                             ; 0xff
	dw	255                             ; 0xff
	dw	254                             ; 0xfe
	dw	254                             ; 0xfe
	dw	254                             ; 0xfe
	dw	254                             ; 0xfe
	dw	254                             ; 0xfe
	dw	253                             ; 0xfd
	dw	253                             ; 0xfd
	dw	253                             ; 0xfd
	dw	253                             ; 0xfd
	dw	252                             ; 0xfc
	dw	252                             ; 0xfc
	dw	252                             ; 0xfc
	dw	252                             ; 0xfc
	dw	251                             ; 0xfb
	dw	251                             ; 0xfb
	dw	251                             ; 0xfb
	dw	250                             ; 0xfa
	dw	250                             ; 0xfa
	dw	250                             ; 0xfa
	dw	249                             ; 0xf9
	dw	249                             ; 0xf9
	dw	249                             ; 0xf9
	dw	248                             ; 0xf8
	dw	248                             ; 0xf8
	dw	248                             ; 0xf8
	dw	247                             ; 0xf7
	dw	247                             ; 0xf7
	dw	246                             ; 0xf6
	dw	246                             ; 0xf6
	dw	245                             ; 0xf5
	dw	245                             ; 0xf5
	dw	245                             ; 0xf5
	dw	244                             ; 0xf4
	dw	244                             ; 0xf4
	dw	243                             ; 0xf3
	dw	243                             ; 0xf3
	dw	242                             ; 0xf2
	dw	242                             ; 0xf2
	dw	241                             ; 0xf1
	dw	241                             ; 0xf1
	dw	240                             ; 0xf0
	dw	239                             ; 0xef
	dw	239                             ; 0xef
	dw	238                             ; 0xee
	dw	238                             ; 0xee
	dw	237                             ; 0xed
	dw	237                             ; 0xed
	dw	236                             ; 0xec
	dw	235                             ; 0xeb
	dw	235                             ; 0xeb
	dw	234                             ; 0xea
	dw	233                             ; 0xe9
	dw	233                             ; 0xe9
	dw	232                             ; 0xe8
	dw	231                             ; 0xe7
	dw	231                             ; 0xe7
	dw	230                             ; 0xe6
	dw	229                             ; 0xe5
	dw	229                             ; 0xe5
	dw	228                             ; 0xe4
	dw	227                             ; 0xe3
	dw	227                             ; 0xe3
	dw	226                             ; 0xe2
	dw	225                             ; 0xe1
	dw	224                             ; 0xe0
	dw	224                             ; 0xe0
	dw	223                             ; 0xdf
	dw	222                             ; 0xde
	dw	221                             ; 0xdd
	dw	220                             ; 0xdc
	dw	220                             ; 0xdc
	dw	219                             ; 0xdb
	dw	218                             ; 0xda
	dw	217                             ; 0xd9
	dw	216                             ; 0xd8
	dw	215                             ; 0xd7
	dw	215                             ; 0xd7
	dw	214                             ; 0xd6
	dw	213                             ; 0xd5
	dw	212                             ; 0xd4
	dw	211                             ; 0xd3
	dw	210                             ; 0xd2
	dw	209                             ; 0xd1
	dw	208                             ; 0xd0
	dw	207                             ; 0xcf
	dw	207                             ; 0xcf
	dw	206                             ; 0xce
	dw	205                             ; 0xcd
	dw	204                             ; 0xcc
	dw	203                             ; 0xcb
	dw	202                             ; 0xca
	dw	201                             ; 0xc9
	dw	200                             ; 0xc8
	dw	199                             ; 0xc7
	dw	198                             ; 0xc6
	dw	197                             ; 0xc5
	dw	196                             ; 0xc4
	dw	195                             ; 0xc3
	dw	194                             ; 0xc2
	dw	193                             ; 0xc1
	dw	192                             ; 0xc0
	dw	191                             ; 0xbf
	dw	190                             ; 0xbe
	dw	189                             ; 0xbd
	dw	188                             ; 0xbc
	dw	186                             ; 0xba
	dw	185                             ; 0xb9
	dw	184                             ; 0xb8
	dw	183                             ; 0xb7
	dw	182                             ; 0xb6
	dw	181                             ; 0xb5
	dw	180                             ; 0xb4
	dw	179                             ; 0xb3
	dw	178                             ; 0xb2
	dw	177                             ; 0xb1
	dw	175                             ; 0xaf
	dw	174                             ; 0xae
	dw	173                             ; 0xad
	dw	172                             ; 0xac
	dw	171                             ; 0xab
	dw	170                             ; 0xaa
	dw	168                             ; 0xa8
	dw	167                             ; 0xa7
	dw	166                             ; 0xa6
	dw	165                             ; 0xa5
	dw	164                             ; 0xa4
	dw	162                             ; 0xa2
	dw	161                             ; 0xa1
	dw	160                             ; 0xa0
	dw	159                             ; 0x9f
	dw	157                             ; 0x9d
	dw	156                             ; 0x9c
	dw	155                             ; 0x9b
	dw	154                             ; 0x9a
	dw	152                             ; 0x98
	dw	151                             ; 0x97
	dw	150                             ; 0x96
	dw	149                             ; 0x95
	dw	147                             ; 0x93
	dw	146                             ; 0x92
	dw	145                             ; 0x91
	dw	144                             ; 0x90
	dw	142                             ; 0x8e
	dw	141                             ; 0x8d
	dw	140                             ; 0x8c
	dw	138                             ; 0x8a
	dw	137                             ; 0x89
	dw	136                             ; 0x88
	dw	134                             ; 0x86
	dw	133                             ; 0x85
	dw	132                             ; 0x84
	dw	130                             ; 0x82
	dw	129                             ; 0x81
	dw	128                             ; 0x80
	dw	126                             ; 0x7e
	dw	125                             ; 0x7d
	dw	123                             ; 0x7b
	dw	122                             ; 0x7a
	dw	121                             ; 0x79
	dw	119                             ; 0x77
	dw	118                             ; 0x76
	dw	117                             ; 0x75
	dw	115                             ; 0x73
	dw	114                             ; 0x72
	dw	112                             ; 0x70
	dw	111                             ; 0x6f
	dw	109                             ; 0x6d
	dw	108                             ; 0x6c
	dw	107                             ; 0x6b
	dw	105                             ; 0x69
	dw	104                             ; 0x68
	dw	102                             ; 0x66
	dw	101                             ; 0x65
	dw	99                              ; 0x63
	dw	98                              ; 0x62
	dw	97                              ; 0x61
	dw	95                              ; 0x5f
	dw	94                              ; 0x5e
	dw	92                              ; 0x5c
	dw	91                              ; 0x5b
	dw	89                              ; 0x59
	dw	88                              ; 0x58
	dw	86                              ; 0x56
	dw	85                              ; 0x55
	dw	83                              ; 0x53
	dw	82                              ; 0x52
	dw	80                              ; 0x50
	dw	79                              ; 0x4f
	dw	77                              ; 0x4d
	dw	76                              ; 0x4c
	dw	74                              ; 0x4a
	dw	73                              ; 0x49
	dw	71                              ; 0x47
	dw	70                              ; 0x46
	dw	68                              ; 0x44
	dw	67                              ; 0x43
	dw	65                              ; 0x41
	dw	64                              ; 0x40
	dw	62                              ; 0x3e
	dw	61                              ; 0x3d
	dw	59                              ; 0x3b
	dw	58                              ; 0x3a
	dw	56                              ; 0x38
	dw	55                              ; 0x37
	dw	53                              ; 0x35
	dw	51                              ; 0x33
	dw	50                              ; 0x32
	dw	48                              ; 0x30
	dw	47                              ; 0x2f
	dw	45                              ; 0x2d
	dw	44                              ; 0x2c
	dw	42                              ; 0x2a
	dw	41                              ; 0x29
	dw	39                              ; 0x27
	dw	38                              ; 0x26
	dw	36                              ; 0x24
	dw	34                              ; 0x22
	dw	33                              ; 0x21
	dw	31                              ; 0x1f
	dw	30                              ; 0x1e
	dw	28                              ; 0x1c
	dw	27                              ; 0x1b
	dw	25                              ; 0x19
	dw	24                              ; 0x18
	dw	22                              ; 0x16
	dw	20                              ; 0x14
	dw	19                              ; 0x13
	dw	17                              ; 0x11
	dw	16                              ; 0x10
	dw	14                              ; 0xe
	dw	13                              ; 0xd
	dw	11                              ; 0xb
	dw	9                               ; 0x9
	dw	8                               ; 0x8
	dw	6                               ; 0x6
	dw	5                               ; 0x5
	dw	3                               ; 0x3
	dw	2                               ; 0x2
	dw	0                               ; 0x0
	dw	65534                           ; 0xfffe
	dw	65533                           ; 0xfffd
	dw	65531                           ; 0xfffb
	dw	65530                           ; 0xfffa
	dw	65528                           ; 0xfff8
	dw	65527                           ; 0xfff7
	dw	65525                           ; 0xfff5
	dw	65523                           ; 0xfff3
	dw	65522                           ; 0xfff2
	dw	65520                           ; 0xfff0
	dw	65519                           ; 0xffef
	dw	65517                           ; 0xffed
	dw	65516                           ; 0xffec
	dw	65514                           ; 0xffea
	dw	65512                           ; 0xffe8
	dw	65511                           ; 0xffe7
	dw	65509                           ; 0xffe5
	dw	65508                           ; 0xffe4
	dw	65506                           ; 0xffe2
	dw	65505                           ; 0xffe1
	dw	65503                           ; 0xffdf
	dw	65502                           ; 0xffde
	dw	65500                           ; 0xffdc
	dw	65498                           ; 0xffda
	dw	65497                           ; 0xffd9
	dw	65495                           ; 0xffd7
	dw	65494                           ; 0xffd6
	dw	65492                           ; 0xffd4
	dw	65491                           ; 0xffd3
	dw	65489                           ; 0xffd1
	dw	65488                           ; 0xffd0
	dw	65486                           ; 0xffce
	dw	65485                           ; 0xffcd
	dw	65483                           ; 0xffcb
	dw	65481                           ; 0xffc9
	dw	65480                           ; 0xffc8
	dw	65478                           ; 0xffc6
	dw	65477                           ; 0xffc5
	dw	65475                           ; 0xffc3
	dw	65474                           ; 0xffc2
	dw	65472                           ; 0xffc0
	dw	65471                           ; 0xffbf
	dw	65469                           ; 0xffbd
	dw	65468                           ; 0xffbc
	dw	65466                           ; 0xffba
	dw	65465                           ; 0xffb9
	dw	65463                           ; 0xffb7
	dw	65462                           ; 0xffb6
	dw	65460                           ; 0xffb4
	dw	65459                           ; 0xffb3
	dw	65457                           ; 0xffb1
	dw	65456                           ; 0xffb0
	dw	65454                           ; 0xffae
	dw	65453                           ; 0xffad
	dw	65451                           ; 0xffab
	dw	65450                           ; 0xffaa
	dw	65448                           ; 0xffa8
	dw	65447                           ; 0xffa7
	dw	65445                           ; 0xffa5
	dw	65444                           ; 0xffa4
	dw	65442                           ; 0xffa2
	dw	65441                           ; 0xffa1
	dw	65439                           ; 0xff9f
	dw	65438                           ; 0xff9e
	dw	65437                           ; 0xff9d
	dw	65435                           ; 0xff9b
	dw	65434                           ; 0xff9a
	dw	65432                           ; 0xff98
	dw	65431                           ; 0xff97
	dw	65429                           ; 0xff95
	dw	65428                           ; 0xff94
	dw	65427                           ; 0xff93
	dw	65425                           ; 0xff91
	dw	65424                           ; 0xff90
	dw	65422                           ; 0xff8e
	dw	65421                           ; 0xff8d
	dw	65419                           ; 0xff8b
	dw	65418                           ; 0xff8a
	dw	65417                           ; 0xff89
	dw	65415                           ; 0xff87
	dw	65414                           ; 0xff86
	dw	65413                           ; 0xff85
	dw	65411                           ; 0xff83
	dw	65410                           ; 0xff82
	dw	65408                           ; 0xff80
	dw	65407                           ; 0xff7f
	dw	65406                           ; 0xff7e
	dw	65404                           ; 0xff7c
	dw	65403                           ; 0xff7b
	dw	65402                           ; 0xff7a
	dw	65400                           ; 0xff78
	dw	65399                           ; 0xff77
	dw	65398                           ; 0xff76
	dw	65396                           ; 0xff74
	dw	65395                           ; 0xff73
	dw	65394                           ; 0xff72
	dw	65392                           ; 0xff70
	dw	65391                           ; 0xff6f
	dw	65390                           ; 0xff6e
	dw	65389                           ; 0xff6d
	dw	65387                           ; 0xff6b
	dw	65386                           ; 0xff6a
	dw	65385                           ; 0xff69
	dw	65384                           ; 0xff68
	dw	65382                           ; 0xff66
	dw	65381                           ; 0xff65
	dw	65380                           ; 0xff64
	dw	65379                           ; 0xff63
	dw	65377                           ; 0xff61
	dw	65376                           ; 0xff60
	dw	65375                           ; 0xff5f
	dw	65374                           ; 0xff5e
	dw	65372                           ; 0xff5c
	dw	65371                           ; 0xff5b
	dw	65370                           ; 0xff5a
	dw	65369                           ; 0xff59
	dw	65368                           ; 0xff58
	dw	65366                           ; 0xff56
	dw	65365                           ; 0xff55
	dw	65364                           ; 0xff54
	dw	65363                           ; 0xff53
	dw	65362                           ; 0xff52
	dw	65361                           ; 0xff51
	dw	65359                           ; 0xff4f
	dw	65358                           ; 0xff4e
	dw	65357                           ; 0xff4d
	dw	65356                           ; 0xff4c
	dw	65355                           ; 0xff4b
	dw	65354                           ; 0xff4a
	dw	65353                           ; 0xff49
	dw	65352                           ; 0xff48
	dw	65351                           ; 0xff47
	dw	65350                           ; 0xff46
	dw	65348                           ; 0xff44
	dw	65347                           ; 0xff43
	dw	65346                           ; 0xff42
	dw	65345                           ; 0xff41
	dw	65344                           ; 0xff40
	dw	65343                           ; 0xff3f
	dw	65342                           ; 0xff3e
	dw	65341                           ; 0xff3d
	dw	65340                           ; 0xff3c
	dw	65339                           ; 0xff3b
	dw	65338                           ; 0xff3a
	dw	65337                           ; 0xff39
	dw	65336                           ; 0xff38
	dw	65335                           ; 0xff37
	dw	65334                           ; 0xff36
	dw	65333                           ; 0xff35
	dw	65332                           ; 0xff34
	dw	65331                           ; 0xff33
	dw	65330                           ; 0xff32
	dw	65329                           ; 0xff31
	dw	65329                           ; 0xff31
	dw	65328                           ; 0xff30
	dw	65327                           ; 0xff2f
	dw	65326                           ; 0xff2e
	dw	65325                           ; 0xff2d
	dw	65324                           ; 0xff2c
	dw	65323                           ; 0xff2b
	dw	65322                           ; 0xff2a
	dw	65321                           ; 0xff29
	dw	65321                           ; 0xff29
	dw	65320                           ; 0xff28
	dw	65319                           ; 0xff27
	dw	65318                           ; 0xff26
	dw	65317                           ; 0xff25
	dw	65316                           ; 0xff24
	dw	65316                           ; 0xff24
	dw	65315                           ; 0xff23
	dw	65314                           ; 0xff22
	dw	65313                           ; 0xff21
	dw	65312                           ; 0xff20
	dw	65312                           ; 0xff20
	dw	65311                           ; 0xff1f
	dw	65310                           ; 0xff1e
	dw	65309                           ; 0xff1d
	dw	65309                           ; 0xff1d
	dw	65308                           ; 0xff1c
	dw	65307                           ; 0xff1b
	dw	65307                           ; 0xff1b
	dw	65306                           ; 0xff1a
	dw	65305                           ; 0xff19
	dw	65305                           ; 0xff19
	dw	65304                           ; 0xff18
	dw	65303                           ; 0xff17
	dw	65303                           ; 0xff17
	dw	65302                           ; 0xff16
	dw	65301                           ; 0xff15
	dw	65301                           ; 0xff15
	dw	65300                           ; 0xff14
	dw	65299                           ; 0xff13
	dw	65299                           ; 0xff13
	dw	65298                           ; 0xff12
	dw	65298                           ; 0xff12
	dw	65297                           ; 0xff11
	dw	65297                           ; 0xff11
	dw	65296                           ; 0xff10
	dw	65295                           ; 0xff0f
	dw	65295                           ; 0xff0f
	dw	65294                           ; 0xff0e
	dw	65294                           ; 0xff0e
	dw	65293                           ; 0xff0d
	dw	65293                           ; 0xff0d
	dw	65292                           ; 0xff0c
	dw	65292                           ; 0xff0c
	dw	65291                           ; 0xff0b
	dw	65291                           ; 0xff0b
	dw	65291                           ; 0xff0b
	dw	65290                           ; 0xff0a
	dw	65290                           ; 0xff0a
	dw	65289                           ; 0xff09
	dw	65289                           ; 0xff09
	dw	65288                           ; 0xff08
	dw	65288                           ; 0xff08
	dw	65288                           ; 0xff08
	dw	65287                           ; 0xff07
	dw	65287                           ; 0xff07
	dw	65287                           ; 0xff07
	dw	65286                           ; 0xff06
	dw	65286                           ; 0xff06
	dw	65286                           ; 0xff06
	dw	65285                           ; 0xff05
	dw	65285                           ; 0xff05
	dw	65285                           ; 0xff05
	dw	65284                           ; 0xff04
	dw	65284                           ; 0xff04
	dw	65284                           ; 0xff04
	dw	65284                           ; 0xff04
	dw	65283                           ; 0xff03
	dw	65283                           ; 0xff03
	dw	65283                           ; 0xff03
	dw	65283                           ; 0xff03
	dw	65282                           ; 0xff02
	dw	65282                           ; 0xff02
	dw	65282                           ; 0xff02
	dw	65282                           ; 0xff02
	dw	65282                           ; 0xff02
	dw	65281                           ; 0xff01
	dw	65281                           ; 0xff01
	dw	65281                           ; 0xff01
	dw	65281                           ; 0xff01
	dw	65281                           ; 0xff01
	dw	65281                           ; 0xff01
	dw	65281                           ; 0xff01
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65280                           ; 0xff00
	dw	65281                           ; 0xff01
	dw	65281                           ; 0xff01
	dw	65281                           ; 0xff01
	dw	65281                           ; 0xff01
	dw	65281                           ; 0xff01
	dw	65281                           ; 0xff01
	dw	65281                           ; 0xff01
	dw	65282                           ; 0xff02
	dw	65282                           ; 0xff02
	dw	65282                           ; 0xff02
	dw	65282                           ; 0xff02
	dw	65282                           ; 0xff02
	dw	65283                           ; 0xff03
	dw	65283                           ; 0xff03
	dw	65283                           ; 0xff03
	dw	65283                           ; 0xff03
	dw	65284                           ; 0xff04
	dw	65284                           ; 0xff04
	dw	65284                           ; 0xff04
	dw	65284                           ; 0xff04
	dw	65285                           ; 0xff05
	dw	65285                           ; 0xff05
	dw	65285                           ; 0xff05
	dw	65286                           ; 0xff06
	dw	65286                           ; 0xff06
	dw	65286                           ; 0xff06
	dw	65287                           ; 0xff07
	dw	65287                           ; 0xff07
	dw	65287                           ; 0xff07
	dw	65288                           ; 0xff08
	dw	65288                           ; 0xff08
	dw	65288                           ; 0xff08
	dw	65289                           ; 0xff09
	dw	65289                           ; 0xff09
	dw	65290                           ; 0xff0a
	dw	65290                           ; 0xff0a
	dw	65291                           ; 0xff0b
	dw	65291                           ; 0xff0b
	dw	65291                           ; 0xff0b
	dw	65292                           ; 0xff0c
	dw	65292                           ; 0xff0c
	dw	65293                           ; 0xff0d
	dw	65293                           ; 0xff0d
	dw	65294                           ; 0xff0e
	dw	65294                           ; 0xff0e
	dw	65295                           ; 0xff0f
	dw	65295                           ; 0xff0f
	dw	65296                           ; 0xff10
	dw	65297                           ; 0xff11
	dw	65297                           ; 0xff11
	dw	65298                           ; 0xff12
	dw	65298                           ; 0xff12
	dw	65299                           ; 0xff13
	dw	65299                           ; 0xff13
	dw	65300                           ; 0xff14
	dw	65301                           ; 0xff15
	dw	65301                           ; 0xff15
	dw	65302                           ; 0xff16
	dw	65303                           ; 0xff17
	dw	65303                           ; 0xff17
	dw	65304                           ; 0xff18
	dw	65305                           ; 0xff19
	dw	65305                           ; 0xff19
	dw	65306                           ; 0xff1a
	dw	65307                           ; 0xff1b
	dw	65307                           ; 0xff1b
	dw	65308                           ; 0xff1c
	dw	65309                           ; 0xff1d
	dw	65309                           ; 0xff1d
	dw	65310                           ; 0xff1e
	dw	65311                           ; 0xff1f
	dw	65312                           ; 0xff20
	dw	65312                           ; 0xff20
	dw	65313                           ; 0xff21
	dw	65314                           ; 0xff22
	dw	65315                           ; 0xff23
	dw	65316                           ; 0xff24
	dw	65316                           ; 0xff24
	dw	65317                           ; 0xff25
	dw	65318                           ; 0xff26
	dw	65319                           ; 0xff27
	dw	65320                           ; 0xff28
	dw	65321                           ; 0xff29
	dw	65321                           ; 0xff29
	dw	65322                           ; 0xff2a
	dw	65323                           ; 0xff2b
	dw	65324                           ; 0xff2c
	dw	65325                           ; 0xff2d
	dw	65326                           ; 0xff2e
	dw	65327                           ; 0xff2f
	dw	65328                           ; 0xff30
	dw	65329                           ; 0xff31
	dw	65329                           ; 0xff31
	dw	65330                           ; 0xff32
	dw	65331                           ; 0xff33
	dw	65332                           ; 0xff34
	dw	65333                           ; 0xff35
	dw	65334                           ; 0xff36
	dw	65335                           ; 0xff37
	dw	65336                           ; 0xff38
	dw	65337                           ; 0xff39
	dw	65338                           ; 0xff3a
	dw	65339                           ; 0xff3b
	dw	65340                           ; 0xff3c
	dw	65341                           ; 0xff3d
	dw	65342                           ; 0xff3e
	dw	65343                           ; 0xff3f
	dw	65344                           ; 0xff40
	dw	65345                           ; 0xff41
	dw	65346                           ; 0xff42
	dw	65347                           ; 0xff43
	dw	65348                           ; 0xff44
	dw	65350                           ; 0xff46
	dw	65351                           ; 0xff47
	dw	65352                           ; 0xff48
	dw	65353                           ; 0xff49
	dw	65354                           ; 0xff4a
	dw	65355                           ; 0xff4b
	dw	65356                           ; 0xff4c
	dw	65357                           ; 0xff4d
	dw	65358                           ; 0xff4e
	dw	65359                           ; 0xff4f
	dw	65361                           ; 0xff51
	dw	65362                           ; 0xff52
	dw	65363                           ; 0xff53
	dw	65364                           ; 0xff54
	dw	65365                           ; 0xff55
	dw	65366                           ; 0xff56
	dw	65368                           ; 0xff58
	dw	65369                           ; 0xff59
	dw	65370                           ; 0xff5a
	dw	65371                           ; 0xff5b
	dw	65372                           ; 0xff5c
	dw	65374                           ; 0xff5e
	dw	65375                           ; 0xff5f
	dw	65376                           ; 0xff60
	dw	65377                           ; 0xff61
	dw	65379                           ; 0xff63
	dw	65380                           ; 0xff64
	dw	65381                           ; 0xff65
	dw	65382                           ; 0xff66
	dw	65384                           ; 0xff68
	dw	65385                           ; 0xff69
	dw	65386                           ; 0xff6a
	dw	65387                           ; 0xff6b
	dw	65389                           ; 0xff6d
	dw	65390                           ; 0xff6e
	dw	65391                           ; 0xff6f
	dw	65392                           ; 0xff70
	dw	65394                           ; 0xff72
	dw	65395                           ; 0xff73
	dw	65396                           ; 0xff74
	dw	65398                           ; 0xff76
	dw	65399                           ; 0xff77
	dw	65400                           ; 0xff78
	dw	65402                           ; 0xff7a
	dw	65403                           ; 0xff7b
	dw	65404                           ; 0xff7c
	dw	65406                           ; 0xff7e
	dw	65407                           ; 0xff7f
	dw	65408                           ; 0xff80
	dw	65410                           ; 0xff82
	dw	65411                           ; 0xff83
	dw	65413                           ; 0xff85
	dw	65414                           ; 0xff86
	dw	65415                           ; 0xff87
	dw	65417                           ; 0xff89
	dw	65418                           ; 0xff8a
	dw	65419                           ; 0xff8b
	dw	65421                           ; 0xff8d
	dw	65422                           ; 0xff8e
	dw	65424                           ; 0xff90
	dw	65425                           ; 0xff91
	dw	65427                           ; 0xff93
	dw	65428                           ; 0xff94
	dw	65429                           ; 0xff95
	dw	65431                           ; 0xff97
	dw	65432                           ; 0xff98
	dw	65434                           ; 0xff9a
	dw	65435                           ; 0xff9b
	dw	65437                           ; 0xff9d
	dw	65438                           ; 0xff9e
	dw	65439                           ; 0xff9f
	dw	65441                           ; 0xffa1
	dw	65442                           ; 0xffa2
	dw	65444                           ; 0xffa4
	dw	65445                           ; 0xffa5
	dw	65447                           ; 0xffa7
	dw	65448                           ; 0xffa8
	dw	65450                           ; 0xffaa
	dw	65451                           ; 0xffab
	dw	65453                           ; 0xffad
	dw	65454                           ; 0xffae
	dw	65456                           ; 0xffb0
	dw	65457                           ; 0xffb1
	dw	65459                           ; 0xffb3
	dw	65460                           ; 0xffb4
	dw	65462                           ; 0xffb6
	dw	65463                           ; 0xffb7
	dw	65465                           ; 0xffb9
	dw	65466                           ; 0xffba
	dw	65468                           ; 0xffbc
	dw	65469                           ; 0xffbd
	dw	65471                           ; 0xffbf
	dw	65472                           ; 0xffc0
	dw	65474                           ; 0xffc2
	dw	65475                           ; 0xffc3
	dw	65477                           ; 0xffc5
	dw	65478                           ; 0xffc6
	dw	65480                           ; 0xffc8
	dw	65481                           ; 0xffc9
	dw	65483                           ; 0xffcb
	dw	65485                           ; 0xffcd
	dw	65486                           ; 0xffce
	dw	65488                           ; 0xffd0
	dw	65489                           ; 0xffd1
	dw	65491                           ; 0xffd3
	dw	65492                           ; 0xffd4
	dw	65494                           ; 0xffd6
	dw	65495                           ; 0xffd7
	dw	65497                           ; 0xffd9
	dw	65498                           ; 0xffda
	dw	65500                           ; 0xffdc
	dw	65502                           ; 0xffde
	dw	65503                           ; 0xffdf
	dw	65505                           ; 0xffe1
	dw	65506                           ; 0xffe2
	dw	65508                           ; 0xffe4
	dw	65509                           ; 0xffe5
	dw	65511                           ; 0xffe7
	dw	65512                           ; 0xffe8
	dw	65514                           ; 0xffea
	dw	65516                           ; 0xffec
	dw	65517                           ; 0xffed
	dw	65519                           ; 0xffef
	dw	65520                           ; 0xfff0
	dw	65522                           ; 0xfff2
	dw	65523                           ; 0xfff3
	dw	65525                           ; 0xfff5
	dw	65527                           ; 0xfff7
	dw	65528                           ; 0xfff8
	dw	65530                           ; 0xfffa
	dw	65531                           ; 0xfffb
	dw	65533                           ; 0xfffd
	dw	65534                           ; 0xfffe

	.section	.rodata._extra_points,"a",@progbits
	.balign	1
	.local	_extra_points
_extra_points:
	dw	1344                            ; 0x540
	dw	63104                           ; 0xf680
	dw	1344                            ; 0x540
	dw	62976                           ; 0xf600
	dw	1552                            ; 0x610
	dw	63488                           ; 0xf800
	dw	1344                            ; 0x540
	dw	62944                           ; 0xf5e0
	dw	1384                            ; 0x568
	dw	62656                           ; 0xf4c0
	dw	1384                            ; 0x568
	dw	62976                           ; 0xf600
	dw	1472                            ; 0x5c0
	dw	62944                           ; 0xf5e0
	dw	1376                            ; 0x560
	dw	62656                           ; 0xf4c0
	dw	1664                            ; 0x680
	dw	62577                           ; 0xf471
	dw	1344                            ; 0x540
	dw	63488                           ; 0xf800
	dw	1344                            ; 0x540
	dw	62577                           ; 0xf471
	dw	1896                            ; 0x768
	dw	62616                           ; 0xf498
	dw	1896                            ; 0x768
	dw	62392                           ; 0xf3b8
	dw	2176                            ; 0x880
	dw	62392                           ; 0xf3b8
	dw	1664                            ; 0x680
	dw	62616                           ; 0xf498
	dw	1920                            ; 0x780
	dw	62656                           ; 0xf4c0
	dw	1664                            ; 0x680
	dw	62392                           ; 0xf3b8
	dw	2176                            ; 0x880
	dw	62656                           ; 0xf4c0
	dw	1520                            ; 0x5f0
	dw	62432                           ; 0xf3e0
	dw	1520                            ; 0x5f0
	dw	62088                           ; 0xf288
	dw	2128                            ; 0x850
	dw	62432                           ; 0xf3e0
	dw	2128                            ; 0x850
	dw	62088                           ; 0xf288
	dw	1544                            ; 0x608
	dw	62088                           ; 0xf288
	dw	1784                            ; 0x6f8
	dw	62152                           ; 0xf2c8
	dw	2064                            ; 0x810
	dw	62264                           ; 0xf338
	dw	2128                            ; 0x850
	dw	62128                           ; 0xf2b0
	dw	1672                            ; 0x688
	dw	62368                           ; 0xf3a0
	dw	1573                            ; 0x625
	dw	62128                           ; 0xf2b0
	dw	2176                            ; 0x880
	dw	62128                           ; 0xf2b0
	dw	1520                            ; 0x5f0
	dw	61888                           ; 0xf1c0
	dw	2176                            ; 0x880
	dw	62432                           ; 0xf3e0
	dw	1573                            ; 0x625
	dw	62432                           ; 0xf3e0
	dw	2040                            ; 0x7f8
	dw	62264                           ; 0xf338
	dw	2128                            ; 0x850
	dw	62392                           ; 0xf3b8
	dw	1896                            ; 0x768
	dw	62577                           ; 0xf471
	dw	2176                            ; 0x880
	dw	62577                           ; 0xf471
	dw	2048                            ; 0x800
	dw	61472                           ; 0xf020
	dw	1376                            ; 0x560
	dw	61760                           ; 0xf140
	dw	1528                            ; 0x5f8
	dw	61760                           ; 0xf140
	dw	2016                            ; 0x7e0
	dw	61760                           ; 0xf140
	dw	1984                            ; 0x7c0
	dw	61728                           ; 0xf120
	dw	1376                            ; 0x560
	dw	61728                           ; 0xf120
	dw	1344                            ; 0x540
	dw	61888                           ; 0xf1c0
	dw	1376                            ; 0x560
	dw	61472                           ; 0xf020
	dw	1344                            ; 0x540
	dw	62392                           ; 0xf3b8
	dw	1344                            ; 0x540
	dw	61472                           ; 0xf020
	dw	65280                           ; 0xff00
	dw	62685                           ; 0xf4dd
	dw	65408                           ; 0xff80
	dw	62320                           ; 0xf370
	dw	65280                           ; 0xff00
	dw	62272                           ; 0xf340
	dw	65296                           ; 0xff10
	dw	62288                           ; 0xf350
	dw	65280                           ; 0xff00
	dw	62336                           ; 0xf380
	dw	65344                           ; 0xff40
	dw	62336                           ; 0xf380
	dw	65344                           ; 0xff40
	dw	62272                           ; 0xf340
	dw	65296                           ; 0xff10
	dw	62320                           ; 0xf370
	dw	65328                           ; 0xff30
	dw	62288                           ; 0xf350
	dw	65280                           ; 0xff00
	dw	62368                           ; 0xf3a0
	dw	65280                           ; 0xff00
	dw	62240                           ; 0xf320
	dw	64896                           ; 0xfd80
	dw	62662                           ; 0xf4c6
	dw	65216                           ; 0xfec0
	dw	62400                           ; 0xf3c0
	dw	65408                           ; 0xff80
	dw	62272                           ; 0xf340
	dw	65280                           ; 0xff00
	dw	61923                           ; 0xf1e3
	dw	64896                           ; 0xfd80
	dw	61961                           ; 0xf209
	dw	65200                           ; 0xfeb0
	dw	61947                           ; 0xf1fb
	dw	65216                           ; 0xfec0
	dw	62208                           ; 0xf300
	dw	64896                           ; 0xfd80
	dw	61947                           ; 0xf1fb
	dw	64896                           ; 0xfd80
	dw	62685                           ; 0xf4dd
	dw	65408                           ; 0xff80
	dw	62240                           ; 0xf320
	dw	64896                           ; 0xfd80
	dw	61923                           ; 0xf1e3
	dw	65472                           ; 0xffc0
	dw	62464                           ; 0xf400
	dw	65472                           ; 0xffc0
	dw	62144                           ; 0xf2c0
	dw	65408                           ; 0xff80
	dw	62720                           ; 0xf500
	dw	64                              ; 0x40
	dw	62416                           ; 0xf3d0
	dw	64                              ; 0x40
	dw	62400                           ; 0xf3c0
	dw	65408                           ; 0xff80
	dw	61888                           ; 0xf1c0
	dw	64                              ; 0x40
	dw	62192                           ; 0xf2f0
	dw	65408                           ; 0xff80
	dw	62144                           ; 0xf2c0
	dw	64                              ; 0x40
	dw	62208                           ; 0xf300
	dw	64768                           ; 0xfd00
	dw	62720                           ; 0xf500
	dw	64                              ; 0x40
	dw	62272                           ; 0xf340
	dw	64                              ; 0x40
	dw	62080                           ; 0xf280
	dw	128                             ; 0x80
	dw	62464                           ; 0xf400
	dw	128                             ; 0x80
	dw	62144                           ; 0xf2c0
	dw	64                              ; 0x40
	dw	62528                           ; 0xf440
	dw	64                              ; 0x40
	dw	62336                           ; 0xf380
	dw	64768                           ; 0xfd00
	dw	61888                           ; 0xf1c0
	dw	64                              ; 0x40
	dw	62040                           ; 0xf258
	dw	160                             ; 0xa0
	dw	62720                           ; 0xf500
	dw	160                             ; 0xa0
	dw	61888                           ; 0xf1c0
	dw	896                             ; 0x380
	dw	61984                           ; 0xf220
	dw	928                             ; 0x3a0
	dw	61984                           ; 0xf220
	dw	1344                            ; 0x540
	dw	62144                           ; 0xf2c0
	dw	1216                            ; 0x4c0
	dw	61984                           ; 0xf220
	dw	1184                            ; 0x4a0
	dw	61984                           ; 0xf220
	dw	832                             ; 0x340
	dw	61888                           ; 0xf1c0
	dw	1280                            ; 0x500
	dw	61888                           ; 0xf1c0
	dw	832                             ; 0x340
	dw	61856                           ; 0xf1a0
	dw	1280                            ; 0x500
	dw	61856                           ; 0xf1a0
	dw	1344                            ; 0x540
	dw	62464                           ; 0xf400
	dw	896                             ; 0x380
	dw	62592                           ; 0xf480
	dw	928                             ; 0x3a0
	dw	62592                           ; 0xf480
	dw	832                             ; 0x340
	dw	62656                           ; 0xf4c0
	dw	832                             ; 0x340
	dw	62432                           ; 0xf3e0
	dw	704                             ; 0x2c0
	dw	62656                           ; 0xf4c0
	dw	1216                            ; 0x4c0
	dw	63050                           ; 0xf64a
	dw	1344                            ; 0x540
	dw	62592                           ; 0xf480
	dw	704                             ; 0x2c0
	dw	63050                           ; 0xf64a
	dw	704                             ; 0x2c0
	dw	61856                           ; 0xf1a0
	dw	1344                            ; 0x540
	dw	61856                           ; 0xf1a0
	dw	512                             ; 0x200
	dw	62432                           ; 0xf3e0
	dw	512                             ; 0x200
	dw	62176                           ; 0xf2e0
	dw	496                             ; 0x1f0
	dw	62144                           ; 0xf2c0
	dw	472                             ; 0x1d8
	dw	62080                           ; 0xf280
	dw	496                             ; 0x1f0
	dw	62080                           ; 0xf280
	dw	496                             ; 0x1f0
	dw	62528                           ; 0xf440
	dw	496                             ; 0x1f0
	dw	62432                           ; 0xf3e0
	dw	496                             ; 0x1f0
	dw	62176                           ; 0xf2e0
	dw	704                             ; 0x2c0
	dw	62528                           ; 0xf440
	dw	704                             ; 0x2c0
	dw	62080                           ; 0xf280
	dw	256                             ; 0x100
	dw	62720                           ; 0xf500
	dw	256                             ; 0x100
	dw	61888                           ; 0xf1c0
	dw	256                             ; 0x100
	dw	63050                           ; 0xf64a
	dw	256                             ; 0x100
	dw	61856                           ; 0xf1a0
	dw	64768                           ; 0xfd00
	dw	63050                           ; 0xf64a
	dw	64768                           ; 0xfd00
	dw	61856                           ; 0xf1a0
	dw	2432                            ; 0x980
	dw	62176                           ; 0xf2e0
	dw	2272                            ; 0x8e0
	dw	62424                           ; 0xf3d8
	dw	2432                            ; 0x980
	dw	62528                           ; 0xf440
	dw	2176                            ; 0x880
	dw	62528                           ; 0xf440
	dw	2272                            ; 0x8e0
	dw	62616                           ; 0xf498
	dw	2272                            ; 0x8e0
	dw	62176                           ; 0xf2e0
	dw	2736                            ; 0xab0
	dw	62528                           ; 0xf440
	dw	2176                            ; 0x880
	dw	62176                           ; 0xf2e0
	dw	2736                            ; 0xab0
	dw	62616                           ; 0xf498
	dw	2240                            ; 0x8c0
	dw	62176                           ; 0xf2e0
	dw	2736                            ; 0xab0
	dw	61760                           ; 0xf140
	dw	2197                            ; 0x895
	dw	61760                           ; 0xf140
	dw	2208                            ; 0x8a0
	dw	61888                           ; 0xf1c0
	dw	2752                            ; 0xac0
	dw	62616                           ; 0xf498
	dw	2435                            ; 0x983
	dw	61744                           ; 0xf130
	dw	2688                            ; 0xa80
	dw	61744                           ; 0xf130
	dw	2368                            ; 0x940
	dw	61616                           ; 0xf0b0
	dw	2672                            ; 0xa70
	dw	61568                           ; 0xf080
	dw	2368                            ; 0x940
	dw	61744                           ; 0xf130
	dw	2688                            ; 0xa80
	dw	61568                           ; 0xf080
	dw	2176                            ; 0x880
	dw	61568                           ; 0xf080
	dw	2240                            ; 0x8c0
	dw	61616                           ; 0xf0b0
	dw	2632                            ; 0xa48
	dw	61760                           ; 0xf140
	dw	2632                            ; 0xa48
	dw	61616                           ; 0xf0b0
	dw	2720                            ; 0xaa0
	dw	61760                           ; 0xf140
	dw	2720                            ; 0xaa0
	dw	61616                           ; 0xf0b0
	dw	2688                            ; 0xa80
	dw	61632                           ; 0xf0c0
	dw	2176                            ; 0x880
	dw	61744                           ; 0xf130
	dw	2752                            ; 0xac0
	dw	61616                           ; 0xf0b0
	dw	2752                            ; 0xac0
	dw	61568                           ; 0xf080
	dw	2496                            ; 0x9c0
	dw	62752                           ; 0xf520
	dw	2520                            ; 0x9d8
	dw	62871                           ; 0xf597
	dw	2624                            ; 0xa40
	dw	62976                           ; 0xf600
	dw	2752                            ; 0xac0
	dw	63488                           ; 0xf800
	dw	2176                            ; 0x880
	dw	62752                           ; 0xf520
	dw	2752                            ; 0xac0
	dw	62000                           ; 0xf230
	dw	2752                            ; 0xac0
	dw	61888                           ; 0xf1c0
	dw	2944                            ; 0xb80
	dw	62176                           ; 0xf2e0
	dw	2944                            ; 0xb80
	dw	61952                           ; 0xf200
	dw	2752                            ; 0xac0
	dw	61867                           ; 0xf1ab
	dw	3352                            ; 0xd18
	dw	61935                           ; 0xf1ef
	dw	3353                            ; 0xd19
	dw	61944                           ; 0xf1f8
	dw	3104                            ; 0xc20
	dw	62166                           ; 0xf2d6
	dw	3104                            ; 0xc20
	dw	61920                           ; 0xf1e0
	dw	3352                            ; 0xd18
	dw	62166                           ; 0xf2d6
	dw	3352                            ; 0xd18
	dw	61920                           ; 0xf1e0
	dw	3353                            ; 0xd19
	dw	61968                           ; 0xf210
	dw	3312                            ; 0xcf0
	dw	62104                           ; 0xf298
	dw	3312                            ; 0xcf0
	dw	61968                           ; 0xf210
	dw	3454                            ; 0xd7e
	dw	62104                           ; 0xf298
	dw	3454                            ; 0xd7e
	dw	61968                           ; 0xf210
	dw	3352                            ; 0xd18
	dw	62016                           ; 0xf240
	dw	3448                            ; 0xd78
	dw	61968                           ; 0xf210
	dw	3242                            ; 0xcaa
	dw	62216                           ; 0xf308
	dw	3242                            ; 0xcaa
	dw	62040                           ; 0xf258
	dw	3408                            ; 0xd50
	dw	62216                           ; 0xf308
	dw	3408                            ; 0xd50
	dw	62040                           ; 0xf258
	dw	3353                            ; 0xd19
	dw	62166                           ; 0xf2d6
	dw	3353                            ; 0xd19
	dw	61920                           ; 0xf1e0
	dw	3242                            ; 0xcaa
	dw	61968                           ; 0xf210
	dw	3454                            ; 0xd7e
	dw	62216                           ; 0xf308
	dw	3104                            ; 0xc20
	dw	62216                           ; 0xf308
	dw	3454                            ; 0xd7e
	dw	61920                           ; 0xf1e0
	dw	3448                            ; 0xd78
	dw	61962                           ; 0xf20a
	dw	3512                            ; 0xdb8
	dw	62016                           ; 0xf240
	dw	3512                            ; 0xdb8
	dw	62216                           ; 0xf308
	dw	3512                            ; 0xdb8
	dw	61920                           ; 0xf1e0
	dw	3047                            ; 0xbe7
	dw	61984                           ; 0xf220
	dw	3047                            ; 0xbe7
	dw	61888                           ; 0xf1c0
	dw	3264                            ; 0xcc0
	dw	61984                           ; 0xf220
	dw	3264                            ; 0xcc0
	dw	61888                           ; 0xf1c0
	dw	2976                            ; 0xba0
	dw	62488                           ; 0xf418
	dw	2976                            ; 0xba0
	dw	62240                           ; 0xf320
	dw	2752                            ; 0xac0
	dw	62634                           ; 0xf4aa
	dw	2752                            ; 0xac0
	dw	62464                           ; 0xf400
	dw	3008                            ; 0xbc0
	dw	62464                           ; 0xf400
	dw	2752                            ; 0xac0
	dw	62304                           ; 0xf360
	dw	3112                            ; 0xc28
	dw	62304                           ; 0xf360
	dw	3112                            ; 0xc28
	dw	62000                           ; 0xf230
	dw	2944                            ; 0xb80
	dw	61910                           ; 0xf1d6
	dw	3215                            ; 0xc8f
	dw	62176                           ; 0xf2e0
	dw	3215                            ; 0xc8f
	dw	61910                           ; 0xf1d6
	dw	2984                            ; 0xba8
	dw	62464                           ; 0xf400
	dw	2984                            ; 0xba8
	dw	62216                           ; 0xf308
	dw	3280                            ; 0xcd0
	dw	62464                           ; 0xf400
	dw	2887                            ; 0xb47
	dw	62464                           ; 0xf400
	dw	2887                            ; 0xb47
	dw	62336                           ; 0xf380
	dw	3136                            ; 0xc40
	dw	62336                           ; 0xf380
	dw	2887                            ; 0xb47
	dw	62216                           ; 0xf308
	dw	2816                            ; 0xb00
	dw	62376                           ; 0xf3a8
	dw	2816                            ; 0xb00
	dw	62132                           ; 0xf2b4
	dw	3280                            ; 0xcd0
	dw	62376                           ; 0xf3a8
	dw	3280                            ; 0xcd0
	dw	62132                           ; 0xf2b4
	dw	2752                            ; 0xac0
	dw	61910                           ; 0xf1d6
	dw	3215                            ; 0xc8f
	dw	62304                           ; 0xf360
	dw	2816                            ; 0xb00
	dw	62464                           ; 0xf400
	dw	3008                            ; 0xbc0
	dw	62240                           ; 0xf320
	dw	3280                            ; 0xcd0
	dw	61910                           ; 0xf1d6
	dw	3047                            ; 0xbe7
	dw	62216                           ; 0xf308
	dw	3512                            ; 0xdb8
	dw	61888                           ; 0xf1c0
	dw	3280                            ; 0xcd0
	dw	62634                           ; 0xf4aa
	dw	3136                            ; 0xc40
	dw	62496                           ; 0xf420
	dw	3136                            ; 0xc40
	dw	62104                           ; 0xf298
	dw	3472                            ; 0xd90
	dw	62496                           ; 0xf420
	dw	3304                            ; 0xce8
	dw	62384                           ; 0xf3b0
	dw	3400                            ; 0xd48
	dw	62496                           ; 0xf420
	dw	3472                            ; 0xd90
	dw	62040                           ; 0xf258
	dw	3136                            ; 0xc40
	dw	62040                           ; 0xf258
	dw	3048                            ; 0xbe8
	dw	62464                           ; 0xf400
	dw	3304                            ; 0xce8
	dw	62592                           ; 0xf480
	dw	3304                            ; 0xce8
	dw	62464                           ; 0xf400
	dw	3320                            ; 0xcf8
	dw	62597                           ; 0xf485
	dw	3345                            ; 0xd11
	dw	62496                           ; 0xf420
	dw	3008                            ; 0xbc0
	dw	62656                           ; 0xf4c0
	dw	3008                            ; 0xbc0
	dw	62592                           ; 0xf480
	dw	3304                            ; 0xce8
	dw	62597                           ; 0xf485
	dw	3048                            ; 0xbe8
	dw	62040                           ; 0xf258
	dw	3472                            ; 0xd90
	dw	62592                           ; 0xf480
	dw	3008                            ; 0xbc0
	dw	62496                           ; 0xf420
	dw	3345                            ; 0xd11
	dw	62656                           ; 0xf4c0
	dw	3552                            ; 0xde0
	dw	62272                           ; 0xf340
	dw	3552                            ; 0xde0
	dw	61969                           ; 0xf211
	dw	3680                            ; 0xe60
	dw	62272                           ; 0xf340
	dw	3680                            ; 0xe60
	dw	61969                           ; 0xf211
	dw	3680                            ; 0xe60
	dw	62392                           ; 0xf3b8
	dw	3808                            ; 0xee0
	dw	62392                           ; 0xf3b8
	dw	3808                            ; 0xee0
	dw	62144                           ; 0xf2c0
	dw	3496                            ; 0xda8
	dw	62272                           ; 0xf340
	dw	3738                            ; 0xe9a
	dw	62504                           ; 0xf428
	dw	3738                            ; 0xe9a
	dw	62272                           ; 0xf340
	dw	3400                            ; 0xd48
	dw	62504                           ; 0xf428
	dw	3456                            ; 0xd80
	dw	62384                           ; 0xf3b0
	dw	3345                            ; 0xd11
	dw	62504                           ; 0xf428
	dw	3672                            ; 0xe58
	dw	62656                           ; 0xf4c0
	dw	3400                            ; 0xd48
	dw	62272                           ; 0xf340
	dw	3552                            ; 0xde0
	dw	62392                           ; 0xf3b8
	dw	3808                            ; 0xee0
	dw	61969                           ; 0xf211
	dw	3345                            ; 0xd11
	dw	62272                           ; 0xf340
	dw	3738                            ; 0xe9a
	dw	62656                           ; 0xf4c0
	dw	3008                            ; 0xbc0
	dw	62040                           ; 0xf258
	dw	3472                            ; 0xd90
	dw	62656                           ; 0xf4c0
	dw	3345                            ; 0xd11
	dw	61969                           ; 0xf211
	dw	3808                            ; 0xee0
	dw	62656                           ; 0xf4c0
	dw	3512                            ; 0xdb8
	dw	62634                           ; 0xf4aa
	dw	3008                            ; 0xbc0
	dw	61969                           ; 0xf211
	dw	3072                            ; 0xc00
	dw	62000                           ; 0xf230
	dw	2752                            ; 0xac0
	dw	62656                           ; 0xf4c0
	dw	3808                            ; 0xee0
	dw	61888                           ; 0xf1c0
	dw	2880                            ; 0xb40
	dw	61888                           ; 0xf1c0
	dw	2880                            ; 0xb40
	dw	61568                           ; 0xf080
	dw	3328                            ; 0xd00
	dw	61962                           ; 0xf20a
	dw	3520                            ; 0xdc0
	dw	61962                           ; 0xf20a
	dw	3520                            ; 0xdc0
	dw	61568                           ; 0xf080
	dw	3353                            ; 0xd19
	dw	61888                           ; 0xf1c0
	dw	3360                            ; 0xd20
	dw	61935                           ; 0xf1ef
	dw	3680                            ; 0xe60
	dw	61696                           ; 0xf100
	dw	3584                            ; 0xe00
	dw	61760                           ; 0xf140
	dw	3616                            ; 0xe20
	dw	61696                           ; 0xf100
	dw	3556                            ; 0xde4
	dw	61990                           ; 0xf226
	dw	3556                            ; 0xde4
	dw	61760                           ; 0xf140
	dw	3680                            ; 0xe60
	dw	61760                           ; 0xf140
	dw	3556                            ; 0xde4
	dw	61696                           ; 0xf100
	dw	3520                            ; 0xdc0
	dw	61990                           ; 0xf226
	dw	3744                            ; 0xea0
	dw	61984                           ; 0xf220
	dw	3744                            ; 0xea0
	dw	61632                           ; 0xf0c0
	dw	3200                            ; 0xc80
	dw	61962                           ; 0xf20a
	dw	3744                            ; 0xea0
	dw	61990                           ; 0xf226
	dw	3200                            ; 0xc80
	dw	61990                           ; 0xf226
	dw	3744                            ; 0xea0
	dw	61568                           ; 0xf080
	dw	3808                            ; 0xee0
	dw	61867                           ; 0xf1ab
	dw	2752                            ; 0xac0
	dw	61990                           ; 0xf226
	dw	2960                            ; 0xb90
	dw	62624                           ; 0xf4a0
	dw	2960                            ; 0xb90
	dw	62488                           ; 0xf418
	dw	2752                            ; 0xac0
	dw	62880                           ; 0xf5a0
	dw	2752                            ; 0xac0
	dw	62606                           ; 0xf48e
	dw	3048                            ; 0xbe8
	dw	62880                           ; 0xf5a0
	dw	3048                            ; 0xbe8
	dw	62606                           ; 0xf48e
	dw	2960                            ; 0xb90
	dw	62656                           ; 0xf4c0
	dw	3048                            ; 0xbe8
	dw	62488                           ; 0xf418
	dw	2944                            ; 0xb80
	dw	62976                           ; 0xf600
	dw	2944                            ; 0xb80
	dw	62752                           ; 0xf520
	dw	3808                            ; 0xee0
	dw	61568                           ; 0xf080
	dw	3048                            ; 0xbe8
	dw	62976                           ; 0xf600
	dw	3808                            ; 0xee0
	dw	62976                           ; 0xf600
	dw	2856                            ; 0xb28
	dw	61408                           ; 0xefe0
	dw	3160                            ; 0xc58
	dw	61408                           ; 0xefe0
	dw	2944                            ; 0xb80
	dw	61408                           ; 0xefe0
	dw	3104                            ; 0xc20
	dw	61504                           ; 0xf040
	dw	3104                            ; 0xc20
	dw	61520                           ; 0xf050
	dw	2176                            ; 0x880
	dw	61440                           ; 0xf000
	dw	2589                            ; 0xa1d
	dw	61440                           ; 0xf000
	dw	2912                            ; 0xb60
	dw	61504                           ; 0xf040
	dw	2368                            ; 0x940
	dw	61408                           ; 0xefe0
	dw	3104                            ; 0xc20
	dw	61568                           ; 0xf080
	dw	2176                            ; 0x880
	dw	61408                           ; 0xefe0
	dw	2944                            ; 0xb80
	dw	60888                           ; 0xedd8
	dw	3072                            ; 0xc00
	dw	60888                           ; 0xedd8
	dw	2912                            ; 0xb60
	dw	60888                           ; 0xedd8
	dw	3104                            ; 0xc20
	dw	60888                           ; 0xedd8
	dw	2176                            ; 0x880
	dw	60992                           ; 0xee40
	dw	3808                            ; 0xee0
	dw	63488                           ; 0xf800
	dw	2176                            ; 0x880
	dw	60672                           ; 0xed00
	dw	3328                            ; 0xd00
	dw	60672                           ; 0xed00
	dw	64768                           ; 0xfd00
	dw	63488                           ; 0xf800
	dw	64768                           ; 0xfd00
	dw	61472                           ; 0xf020
	dw	3808                            ; 0xee0
	dw	60672                           ; 0xed00

	.section	.bss._vertex_side,"aw",@nobits
	.balign	2
	.local	_vertex_side
_vertex_side:
	.zero	1594

	.section	.bss._vertex_depth,"aw",@nobits
	.balign	2
	.local	_vertex_depth
_vertex_depth:
	.zero	1594

	.section	.rodata._row_offsets,"a",@progbits
	.balign	2
	.local	_row_offsets
_row_offsets:
	dw	0                               ; 0x0
	dw	128                             ; 0x80
	dw	256                             ; 0x100
	dw	384                             ; 0x180
	dw	512                             ; 0x200
	dw	640                             ; 0x280
	dw	768                             ; 0x300
	dw	896                             ; 0x380
	dw	1024                            ; 0x400
	dw	1152                            ; 0x480
	dw	1280                            ; 0x500
	dw	1408                            ; 0x580
	dw	1536                            ; 0x600
	dw	1664                            ; 0x680
	dw	1792                            ; 0x700
	dw	1920                            ; 0x780
	dw	2048                            ; 0x800
	dw	2176                            ; 0x880
	dw	2304                            ; 0x900
	dw	2432                            ; 0x980
	dw	2560                            ; 0xa00
	dw	2688                            ; 0xa80
	dw	2816                            ; 0xb00
	dw	2944                            ; 0xb80
	dw	3072                            ; 0xc00
	dw	3200                            ; 0xc80
	dw	3328                            ; 0xd00
	dw	3456                            ; 0xd80
	dw	3584                            ; 0xe00
	dw	3712                            ; 0xe80
	dw	3840                            ; 0xf00
	dw	3968                            ; 0xf80
	dw	4096                            ; 0x1000
	dw	4224                            ; 0x1080
	dw	4352                            ; 0x1100
	dw	4480                            ; 0x1180
	dw	4608                            ; 0x1200
	dw	4736                            ; 0x1280
	dw	4864                            ; 0x1300
	dw	4992                            ; 0x1380
	dw	5120                            ; 0x1400
	dw	5248                            ; 0x1480
	dw	5376                            ; 0x1500
	dw	5504                            ; 0x1580
	dw	5632                            ; 0x1600
	dw	5760                            ; 0x1680
	dw	5888                            ; 0x1700
	dw	6016                            ; 0x1780
	dw	6144                            ; 0x1800
	dw	6272                            ; 0x1880
	dw	6400                            ; 0x1900
	dw	6528                            ; 0x1980
	dw	6656                            ; 0x1a00
	dw	6784                            ; 0x1a80
	dw	6912                            ; 0x1b00
	dw	7040                            ; 0x1b80
	dw	7168                            ; 0x1c00
	dw	7296                            ; 0x1c80
	dw	7424                            ; 0x1d00
	dw	7552                            ; 0x1d80
	dw	7680                            ; 0x1e00
	dw	7808                            ; 0x1e80
	dw	7936                            ; 0x1f00
	dw	8064                            ; 0x1f80
	dw	8192                            ; 0x2000
	dw	8320                            ; 0x2080
	dw	8448                            ; 0x2100
	dw	8576                            ; 0x2180
	dw	8704                            ; 0x2200
	dw	8832                            ; 0x2280
	dw	8960                            ; 0x2300
	dw	9088                            ; 0x2380
	dw	9216                            ; 0x2400
	dw	9344                            ; 0x2480
	dw	9472                            ; 0x2500
	dw	9600                            ; 0x2580
	dw	9728                            ; 0x2600
	dw	9856                            ; 0x2680
	dw	9984                            ; 0x2700
	dw	10112                           ; 0x2780

	.section	.bss._vertex_screen,"aw",@nobits
	.balign	2
	.local	_vertex_screen
_vertex_screen:
	.zero	1594

	.section	.bss._sprite_z,"aw",@nobits
	.balign	2
	.local	_sprite_z
_sprite_z:
	.zero	182

	.section	.bss._sprite_x,"aw",@nobits
	.balign	2
	.local	_sprite_x
_sprite_x:
	.zero	182

	.section	.bss._sprite_order,"aw",@nobits
	.balign	1
	.local	_sprite_order
_sprite_order:
	.zero	91

	.section	.rodata._barrel_explode,"a",@progbits
	.balign	1
	.local	_barrel_explode
_barrel_explode:
	.ascii	"DRSTU"

	.ident	"clang version 19.1.0 (https://github.com/CE-Programming/llvm-project ef28e9c54cd1333a6091ab2ffbd315b465fc5090)"
	.section	".note.GNU-stack","",@progbits
	.extern	_llvm.smin.i24
	.extern	_llvm.uadd.with.overflow.i24
	.extern	_llvm.lifetime.end.p0
	.extern	__ishru
	.extern	__Unwind_SjLj_Unregister
	.extern	__lldivu
	.extern	__idivs
	.extern	__lshrs
	.extern	_memset
	.extern	__sremu
	.extern	_llvm.memset.p0.i64
	.extern	_llvm.umax.i8
	.extern	_llvm.smax.i16
	.extern	__ior
	.extern	__lsub
	.extern	__llshru
	.extern	__lcmpzero
	.extern	_llvm.abs.i24
	.extern	__ladd
	.extern	_llvm.umin.i24
	.extern	__idivu
	.extern	__ldivs
	.extern	__irems
	.extern	_llvm.eh.sjlj.lsda
	.extern	__iand
	.extern	__setflag
	.extern	_llvm.stacksave.p0
	.extern	_memcmp
	.extern	_llvm.lifetime.start.p0
	.extern	_llvm.smin.i16
	.extern	__lshru
	.extern	__ixor
	.extern	__sdivs
	.extern	_llvm.eh.sjlj.functioncontext
	.extern	__sdivu
	.extern	__llmulu
	.extern	_llvm.umax.i24
	.extern	__bshru
	.extern	_llvm.umin.i8
	.extern	_llvm.memset.p0.i24
	.extern	_llvm.memcpy.p0.p0.i24
	.extern	_llvm.eh.sjlj.setup.dispatch
	.extern	_llvm.abs.i16
	.extern	__i48mulu
	.extern	_llvm.frameaddress.p0
	.extern	_llvm.stackrestore.p0
	.extern	__lcmpu
	.extern	_llvm.smax.i24
	.extern	__ishru_1
	.extern	__lcmps
	.extern	__sshru
	.extern	__sshrs
	.extern	__llshl
	.extern	__imulu
	.extern	_llvm.eh.sjlj.callsite
	.extern	__lmulu
	.extern	__i48shru
	.extern	__Unwind_SjLj_Register
	.extern	__ishrs
	.extern	__smulu
	.extern	__ishl
