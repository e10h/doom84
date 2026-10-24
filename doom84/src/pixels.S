/* GPL-2.0-or-later. eZ80 ADL pixel kernels, executed from program RAM.
 * IX/IY are preserved. Other registers, including alternate AF, are scratch.
 * Immediate operands are patched once per span/column, never per pixel.
 * Shade tables must be 256-byte aligned. Count is 1..128.
 */
.assume ADL=1
.section .text._d84_fill_column,"ax",@progbits
.global _d84_fill_column
_d84_fill_column:
    push ix
    ld ix,0
    add ix,sp
    ld hl,(ix+6)
    ld b,(ix+9)
    ld a,(ix+12)
    ld de,128
.Lfill_loop:
    ld (hl),a
    add hl,de
    djnz .Lfill_loop
    pop ix
    ret
.section .text._d84_double_columns,"ax",@progbits
.global _d84_double_columns
/* Count is a multiple of eight; the renderer passes 5120 pairs. */
_d84_double_columns:
    push ix
    ld ix,0
    add ix,sp
    ld hl,(ix+6)
    ld bc,(ix+9)
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
.Ldouble_loop:
    .rept 8
    ld a,(hl)
    inc hl
    ld (hl),a
    inc hl
    .endr
    dec bc
    ld a,b
    or c
    jr nz,.Ldouble_loop
    pop ix
    ret
.section .text._d84_span,"ax",@progbits
.global _d84_span
.global _d84_span2
.global _d84_span4
_d84_span:
    xor a,a
    ld (.Lspan_stride),a
    ld (.Lspan_stride+1),a
    ld (.Lspan_stride+2),a
    ld (.Lspan_stride+3),a
    ld hl,0
    ld (.Lspan_stride+4),hl
    ld (.Lspan_stride+7),hl
    ld (.Lspan_stride+9),hl
    jr .Lspan_start
_d84_span2:
    ld hl,0
    ld (.Lspan_stride+4),hl
    ld (.Lspan_stride+7),hl
    ld (.Lspan_stride+9),hl
    ld a,0xdd
    ld (.Lspan_stride),a
    ld a,0x23
    ld (.Lspan_stride+1),a
    ld (.Lspan_stride+3),a
    ld a,0xfd
    ld (.Lspan_stride+2),a
    jr .Lspan_start
_d84_span4:
    ld hl,0xfd23dd
    ld (.Lspan_stride),hl
    ld (.Lspan_stride+4),hl
    ld (.Lspan_stride+8),hl
    ld a,0x23
    ld (.Lspan_stride+3),a
    ld (.Lspan_stride+7),a
    ld (.Lspan_stride+11),a
.Lspan_start:
    push ix
    push iy
    ld ix,0
    add ix,sp
    ld hl,(ix+15)
    ld (.Lspan_image+1),hl
    ld hl,(ix+18)
    ld (.Lspan_light+1),hl
    ld hl,(ix+30)
    ld (.Lspan_stepx+1),hl
    ld hl,(ix+33)
    ld (.Lspan_stepy+1),hl
    ld a,(ix+36)
    ld (.Lspan_depth+3),a
    ld a,(ix+21)
    ex af,af'
    ld hl,(ix+24)
    ld de,(ix+27)
    ld iy,(ix+12)
    ld ix,(ix+9)
.Lspan_loop:
    push hl
    push de
    ex de,hl
    ld a,h
    and 62
    ld l,a
    ld h,16
    mlt hl
    ld a,d
    rrca
    and 31
    or l
    ld l,a
.Lspan_image:
    ld bc,0
    add hl,bc
    ld a,(hl)
.Lspan_light:
    ld hl,0
    ld l,a
    ld a,(hl)
    ld (ix+0),a
.Lspan_depth:
    ld (iy+0),0
    inc ix
    inc iy
.Lspan_stride:
    .rept 12
    .byte 0
    .endr
    pop de
    pop hl
.Lspan_stepx:
    ld bc,0
    add hl,bc
    ex de,hl
.Lspan_stepy:
    ld bc,0
    add hl,bc
    ex de,hl
    ex af,af'
    dec a
    jr z,.Lspan_done
    ex af,af'
    jr .Lspan_loop
.Lspan_done:
    pop iy
    pop ix
    ret

.section .text._d84_wall,"ax",@progbits
.global _d84_wall
_d84_wall:
    push ix
    push iy
    ld ix,0
    add ix,sp
    ld hl,(ix+15)
    ld (.Lwall_image+1),hl
    ld hl,(ix+18)
    ld (.Lwall_light+1),hl
    ld a,(ix+30)
    ld (.Lwall_depth+3),a
    ld a,(ix+21)
    ex af,af'
    ld hl,(ix+24)
    ld de,(ix+27)
    ld iy,(ix+12)
    ld ix,(ix+9)
.Lwall_loop:
    push hl
    ld a,h
    and 31
    ld l,a
    ld h,32
    mlt hl
.Lwall_image:
    ld bc,0
    add hl,bc
    ld a,(hl)
.Lwall_light:
    ld hl,0
    ld l,a
    ld a,(hl)
    ld (ix+0),a
.Lwall_depth:
    ld (iy+0),0
    ld bc,128
    add ix,bc
    add iy,bc
    pop hl
    add hl,de
    ex af,af'
    dec a
    jr z,.Lwall_done
    ex af,af'
    jr .Lwall_loop
.Lwall_done:
    pop iy
    pop ix
    ret

.section .text._d84_sprite,"ax",@progbits
.global _d84_sprite
_d84_sprite:
    push ix
    push iy
    ld ix,0
    add ix,sp
    ld hl,(ix+15)
    ld (.Lsprite_image+1),hl
    ld hl,(ix+18)
    ld (.Lsprite_light+1),hl
    ld hl,(ix+27)
    ld (.Lsprite_step+1),hl
    ld a,(ix+30)
    ld (.Lsprite_test+1),a
    ld (.Lsprite_depth+3),a
    ld hl,0
    ld (.Lsprite_stride),hl
    ld (.Lsprite_stride+3),hl
    ld (.Lsprite_stride+6),hl
    ld (.Lsprite_stride+9),hl
    ld a,(ix+33)
    dec a
    jr z,.Lsprite_start
    ld b,a
    ld hl,.Lsprite_stride
.Lsprite_patch:
    ld (hl),0xdd
    inc hl
    ld (hl),0x23
    inc hl
    ld (hl),0xfd
    inc hl
    ld (hl),0x23
    inc hl
    djnz .Lsprite_patch
.Lsprite_start:
    ld a,(ix+21)
    ex af,af'
    ld hl,(ix+24)
    ld iy,(ix+12)
    ld ix,(ix+9)
.Lsprite_loop:
.Lsprite_test:
    ld a,0
    cp a,(iy+0)
    jr nc,.Lsprite_next
    push hl
    ld l,h
    ld h,0
.Lsprite_image:
    ld bc,0
    add hl,bc
    ld a,(hl)
    cp a,255
    jr z,.Lsprite_transparent
.Lsprite_light:
    ld hl,0
    ld l,a
    ld a,(hl)
    ld (ix+0),a
.Lsprite_depth:
    ld (iy+0),0
.Lsprite_transparent:
    pop hl
.Lsprite_next:
    inc ix
    inc iy
.Lsprite_stride:
    .rept 12
    .byte 0
    .endr
.Lsprite_step:
    ld bc,0
    add hl,bc
    ex af,af'
    dec a
    jr z,.Lsprite_done
    ex af,af'
    jr .Lsprite_loop
.Lsprite_done:
    pop iy
    pop ix
    ret

.section .text._d84_quad_columns,"ax",@progbits
.global _d84_quad_columns
_d84_quad_columns:
    push ix
    ld ix,0
    add ix,sp
    ld hl,(ix+6)
    ld bc,(ix+9)
.Lquad_loop:
    ld a,(hl)
    inc hl
    ld (hl),a
    inc hl
    ld (hl),a
    inc hl
    ld (hl),a
    inc hl
    dec bc
    ld a,b
    or c
    jr nz,.Lquad_loop
    pop ix
    ret

/* 2× replicate 128×80 src into dest (points at view top-left in a 320-wide buffer). */
.section .text._d84_blit_viewport,"ax",@progbits
.global _d84_blit_viewport
_d84_blit_viewport:
    push ix
    push iy
    ld iy,0
    add iy,sp
    ld hl,(iy+9)
    ld ix,(iy+12)
    push ix
    pop iy
    ld de,320
    add iy,de
    ld a,80
.Lrow_loop:
    ex af,af'
    ld b,16
.Lgroup_loop:
    .rept 8
    ld a,(hl)
    inc hl
    ld (ix+0),a
    ld (ix+1),a
    ld (iy+0),a
    ld (iy+1),a
    lea ix,ix+2
    lea iy,iy+2
    .endr
    dec b
    jp nz,.Lgroup_loop
    ld de,384
    add ix,de
    add iy,de
    ex af,af'
    dec a
    jp nz,.Lrow_loop
    pop iy
    pop ix
    ret
