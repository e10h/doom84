/* GPL-2.0-or-later. Exact signed 8.8 camera transforms for eZ80 ADL.
 * Cardinal views are permutations/sign changes. Other views use four signed
 * 16x9 products; each non-cardinal multiply uses two hardware MLTs.
 * Rotated output contains two signed words. The spare third word permits
 * native 24-bit stores without touching any other object.
 */
.assume ADL=1
.section .text._d84_set_camera,"ax",@progbits
.global _d84_set_camera
_d84_set_camera:
    ld hl,(_camcos)
    call .Lcoefficient
    ld (.Lrot_cos1+1),bc
    ld (.Lrot_cos2+1),bc
    ld hl,(_camsin)
    call .Lcoefficient
    ld (.Lrot_sin1+1),bc
    ld (.Lrot_sin2+1),bc
    ld de,0
    ld hl,(_camcos)
    or a,a
    sbc hl,de
    jr z,.Lcamera_vertical
    ld hl,(_camsin)
    or a,a
    sbc hl,de
    jr z,.Lcamera_horizontal
    ld hl,.Lrotate_general
    jr .Lcamera_route
.Lcamera_vertical:
    ld a,(_camsin+1)
    bit 7,a
    ld hl,.Lrotate_north
    jr z,.Lcamera_route
    ld hl,.Lrotate_south
    jr .Lcamera_route
.Lcamera_horizontal:
    ld a,(_camcos+1)
    bit 7,a
    ld hl,.Lrotate_east
    jr z,.Lcamera_route
    ld hl,.Lrotate_west
.Lcamera_route:
    ld (.Lrotate_dispatch+1),hl
    ret
/* BC packs sign in B bit 0, abs(coefficient)==256 in bit 1, low byte in C. */
.Lcoefficient:
    ld bc,0
    bit 7,h
    jr z,.Lcoefficient_positive
    inc b
    ld de,0
    ex de,hl
    or a,a
    sbc hl,de
.Lcoefficient_positive:
    ld c,l
    ld a,h
    or a,a
    ret z
    set 1,b
    ret

.section .text._d84_rotate,"ax",@progbits
.global _d84_rotate
_d84_rotate:
    push ix
    ld ix,0
    add ix,sp
    ld hl,(ix+6)
    ld de,(ix+9)
.Lrotate_dispatch:
    jp .Lrotate_general
.Lrotate_north:
    ld (_d84_rotated),hl
    ld (_d84_rotated+2),de
    pop ix
    ret
.Lrotate_east:
    push hl
    ex de,hl
    call .Lrotate_negate
    ld (_d84_rotated),hl
    pop hl
    ld (_d84_rotated+2),hl
    pop ix
    ret
.Lrotate_west:
    ld (_d84_rotated),de
    call .Lrotate_negate
    ld (_d84_rotated+2),hl
    pop ix
    ret
.Lrotate_south:
    push de
    call .Lrotate_negate
    ld (_d84_rotated),hl
    pop hl
    call .Lrotate_negate
    ld (_d84_rotated+2),hl
    pop ix
    ret
.Lrotate_general:
.Lrot_sin1:
    ld bc,0
    call .Lmultiply_s16_s9
    ld (.Lrotate_product),hl
    ld hl,(ix+9)
.Lrot_cos1:
    ld bc,0
    call .Lmultiply_s16_s9
    ex de,hl
    ld hl,(.Lrotate_product)
    or a,a
    sbc hl,de
    ld (.Lrotate_product),hl
    ld hl,(.Lrotate_product+1)
    ld (_d84_rotated),hl
    ld hl,(ix+6)
.Lrot_cos2:
    ld bc,0
    call .Lmultiply_s16_s9
    ld (.Lrotate_product),hl
    ld hl,(ix+9)
.Lrot_sin2:
    ld bc,0
    call .Lmultiply_s16_s9
    ld de,(.Lrotate_product)
    add hl,de
    ld (.Lrotate_product),hl
    ld hl,(.Lrotate_product+1)
    ld (_d84_rotated+2),hl
    pop ix
    ret
.Lmultiply_s16_s9:
    bit 7,h
    jr z,.Lmultiply_positive
    ld a,b
    xor a,1
    ld b,a
    call .Lrotate_negate
.Lmultiply_positive:
    bit 1,b
    jr nz,.Lmultiply_256
    ld d,h
    ld e,c
    mlt de
    ld h,l
    ld l,c
    mlt hl
    ex de,hl
.Lmultiply_256:
    .rept 8
    add hl,hl
    .endr
    bit 1,b
    jr nz,.Lmultiply_signed
    add hl,de
.Lmultiply_signed:
    bit 0,b
    ret z
.Lrotate_negate:
    ld de,0
    ex de,hl
    or a,a
    sbc hl,de
    ret

.section .data.d84_rotate_scratch,"aw",@progbits
.Lrotate_product:
    .byte 0,0,0,0

/* C ABI: exact 64 + floor(r * Q20_reciprocal(z) / 16384).
 * Six 8x8 multiplies form the relevant bytes of the unsigned 16x24 product.
 * For negative r, retain the discarded fraction to reproduce arithmetic
 * right shift exactly, including floor rather than truncation toward zero.
 */
.section .text._d84_screen_x,"ax",@progbits
.global _d84_screen_x
_d84_screen_x:
    push ix
    ld ix,0
    add ix,sp
    ld hl,-12
    add hl,sp
    ld sp,hl
    ld hl,(ix+9)
    call _d84_reciprocal
    ld (ix-6),hl
    ld hl,(ix+6)
    xor a,a
    ld (ix-12),a
    bit 7,h
    jr z,.Lproject_abs
    inc a
    ld (ix-12),a
    ld de,0
    ex de,hl
    or a,a
    sbc hl,de
.Lproject_abs:
    ld (ix-3),hl
    ld d,l
    ld e,(ix-6)
    mlt de
    ld (ix-10),e
    ld c,d
    ld h,(ix-2)
    ld l,(ix-6)
    mlt hl
    ld d,(ix-3)
    ld e,(ix-5)
    mlt de
    add hl,de
    ld de,0
    ld e,c
    add hl,de
    ld (ix-11),l
    ld (ix-9),hl
    ld de,0
    ld e,(ix-8)
    ld d,(ix-7)
    push de
    ld h,(ix-2)
    ld l,(ix-5)
    mlt hl
    ld d,(ix-3)
    ld e,(ix-4)
    mlt de
    add hl,de
    pop de
    add hl,de
    ld d,(ix-2)
    ld e,(ix-4)
    mlt de
    ld a,h
    add a,e
    ld de,0
    ld e,l
    ld d,a
    ex de,hl
    add hl,hl
    add hl,hl
    ld a,(ix-11)
    rlca
    rlca
    and a,3
    ld de,0
    ld e,a
    add hl,de
    ld a,(ix-12)
    or a,a
    jr z,.Lproject_center
    ld a,(ix-11)
    and a,63
    or a,(ix-10)
    ld b,a
    ld de,0
    ex de,hl
    or a,a
    sbc hl,de
    ld a,b
    or a,a
    jr z,.Lproject_center
    dec hl
.Lproject_center:
    ld de,64
    add hl,de
    ld sp,ix
    pop ix
    ret
