/* GPL-2.0-or-later. Native ADL column clipping and projected-height DDAs.
 * IX holds the verified RenderWall packet across calls into C. All screen
 * bounds are bytes, avoiding general 24-bit shifts, masks and comparisons.
 */
#include "render_abi.h"
.assume ADL=1
.section .text._d84_render_columns,"ax",@progbits
.global _d84_render_columns
.macro clamp_y value, output
    ld a,(ix+\value+2)
    or a,a
    jr z,.Lymiddle\@
    jp m,.Lyzero\@
    ld a,80
    jr .Lystore\@
.Lymiddle\@:
    ld a,(ix+\value+1)
    cp a,80
    jr c,.Lystore\@
    ld a,80
    jr .Lystore\@
.Lyzero\@:
    xor a,a
.Lystore\@:
    ld (ix+\output),a
.endm
.macro advance value, step
    ld hl,(ix+\value)
    ld de,(ix+\step)
    add hl,de
    ld (ix+\value),hl
.endm
_d84_render_columns:
    push ix
    push iy
    ld ix,_d84_rw
    ld a,(ix+RW_START)
    ld (ix+RW_X),a
.Lcolumn_loop:
    ld hl,(ix+RW_TOPPTR)
    ld a,(hl)
    ld (ix+RW_TOP),a
    ld b,a
    ld hl,(ix+RW_BOTTOMPTR)
    ld a,(hl)
    ld (ix+RW_BOTTOM),a
    cp a,b
    jp z,.Lcolumn_next
    jp c,.Lcolumn_next
    ld a,(ix+RW_IZ+2)
    bit 7,a
    jp nz,.Lcolumn_next
    or a,(ix+RW_IZ+1)
    or a,(ix+RW_IZ)
    jp z,.Lcolumn_next
    clamp_y RW_CYQ,RW_CY
    clamp_y RW_FYQ,RW_FY

    /* Ceiling [top,min(cy,bottom)), floor [max(fy,top),bottom). */
    ld a,(ix+RW_CY)
    cp a,(ix+RW_BOTTOM)
    jr c,.Lceil_end
    ld a,(ix+RW_BOTTOM)
.Lceil_end:
    sub a,(ix+RW_TOP)
    jr z,.Lfloor
    jr c,.Lfloor
    ld b,a
    ld c,(ix+RW_TOP)
    ld a,(ix+RW_CEILCOLOR)
    call .Lcolumn_fill
.Lfloor:
    ld a,(ix+RW_FY)
    cp a,(ix+RW_TOP)
    jr nc,.Lfloor_start
    ld a,(ix+RW_TOP)
.Lfloor_start:
    ld c,a
    ld a,(ix+RW_BOTTOM)
    sub a,c
    jr z,.Lwall
    jr c,.Lwall
    ld b,a
    ld a,(ix+RW_FLOORCOLOR)
    call .Lcolumn_fill
.Lwall:
    ld a,(ix+RW_SOLID)
    or a,a
    jp z,.Lportal
    ld a,(ix+RW_CY)
    cp a,(ix+RW_TOP)
    jr nc,.Lsolid_start
    ld a,(ix+RW_TOP)
.Lsolid_start:
    ld c,a
    ld a,(ix+RW_FY)
    cp a,(ix+RW_BOTTOM)
    jr c,.Lsolid_end
    ld a,(ix+RW_BOTTOM)
.Lsolid_end:
    ld b,a
    lea de,ix+RW_MIDDLE
    call .Lcolumn_wall
    ld a,(ix+RW_BOTTOM)
    ld (ix+RW_TOP),a
    jp .Lcolumn_write
.Lportal:
    clamp_y RW_UPPERQ,RW_UP
    clamp_y RW_LOWERQ,RW_LOW
    ld a,(ix+RW_DRAWUPPER)
    or a,a
    jr z,.Llower_wall
    ld a,(ix+RW_CY)
    cp a,(ix+RW_TOP)
    jr nc,.Lupper_start
    ld a,(ix+RW_TOP)
.Lupper_start:
    ld c,a
    ld a,(ix+RW_UP)
    cp a,(ix+RW_BOTTOM)
    jr c,.Lupper_end
    ld a,(ix+RW_BOTTOM)
.Lupper_end:
    ld b,a
    lea de,ix+RW_UPPER
    call .Lcolumn_wall
.Llower_wall:
    ld a,(ix+RW_DRAWLOWER)
    or a,a
    jr z,.Lportal_clip
    ld a,(ix+RW_LOW)
    cp a,(ix+RW_TOP)
    jr nc,.Llower_start
    ld a,(ix+RW_TOP)
.Llower_start:
    ld c,a
    ld a,(ix+RW_FY)
    cp a,(ix+RW_BOTTOM)
    jr c,.Llower_end
    ld a,(ix+RW_BOTTOM)
.Llower_end:
    ld b,a
    lea de,ix+RW_LOWER
    call .Lcolumn_wall
.Lportal_clip:
    ld a,(ix+RW_CY)
    cp a,(ix+RW_UP)
    jr nc,.Ltop_max_up
    ld a,(ix+RW_UP)
.Ltop_max_up:
    cp a,(ix+RW_TOP)
    jr nc,.Ltop_max_old
    ld a,(ix+RW_TOP)
.Ltop_max_old:
    cp a,(ix+RW_BOTTOM)
    jr c,.Ltop_clipped
    ld a,(ix+RW_BOTTOM)
.Ltop_clipped:
    ld (ix+RW_TOP),a
    ld a,(ix+RW_FY)
    cp a,(ix+RW_LOW)
    jr c,.Lbottom_min_low
    ld a,(ix+RW_LOW)
.Lbottom_min_low:
    cp a,(ix+RW_BOTTOM)
    jr c,.Lbottom_min_old
    ld a,(ix+RW_BOTTOM)
.Lbottom_min_old:
    cp a,(ix+RW_TOP)
    jr nc,.Lbottom_clipped
    ld a,(ix+RW_TOP)
.Lbottom_clipped:
    ld (ix+RW_BOTTOM),a
.Lcolumn_write:
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
    djnz .Lduplicate_clip
.Lcolumn_next:
    advance RW_IZ,RW_DIZ
    advance RW_UZ,RW_DUZ
    advance RW_CYQ,RW_CYSTEP
    advance RW_FYQ,RW_FYSTEP
    advance RW_UPPERQ,RW_UPPERSTEP
    advance RW_LOWERQ,RW_LOWERSTEP
    ld bc,0
    ld c,(ix+RW_STRIDE)
    ld hl,(ix+RW_TOPPTR)
    add hl,bc
    ld (ix+RW_TOPPTR),hl
    ld hl,(ix+RW_BOTTOMPTR)
    add hl,bc
    ld (ix+RW_BOTTOMPTR),hl
    ld a,(ix+RW_X)
    add a,c
    ld (ix+RW_X),a
    cp a,(ix+RW_END)
    jp c,.Lcolumn_loop
    pop iy
    pop ix
    ret

/* A=color B=count C=y; the preselected destination is plane IDs or pixels. */
.Lcolumn_fill:
    push bc
    ld hl,0
    ld h,c
    ld l,128
    mlt hl
    ld de,0
    ld e,(ix+RW_X)
    add hl,de
    ld de,(ix+RW_FILLBASE)
    add hl,de
    pop bc
    ld de,128
.Lcolumn_fill_loop:
    ld (hl),a
    add hl,de
    djnz .Lcolumn_fill_loop
    ret

/* C=y1, B=exclusive y2, DE=style. All texture arithmetic is modular:
 * U needs bits 16..23 of U/Z * inverse, because walls are <=256 wide;
 * V needs only its low 13 bits for a repeating 32-texel column.
 */
.Lcolumn_wall:
    ld a,b
    sub a,c
    ret c
    ret z
    ld (ix+RW_COUNT),a
    ld (ix+RW_Y1),c
    push de
    pop iy
    ld hl,(iy+0)
    ld de,0
    or a,a
    sbc hl,de
    ret z
    ld hl,_render_stats+4
    inc (hl)
    jr nz,.Lwall_counted
    inc hl
    inc (hl)
.Lwall_counted:
    ld hl,(ix+RW_IZ)
    call .Lreciprocal
    ld (ix+RW_INVERSE),hl
    /* Reciprocal >> 2. Rare >16-bit values use the ADL shift helper. */
    ld a,(ix+RW_INVERSE+2)
    or a,a
    jr nz,.Lwall_z_wide
    srl h
    rr l
    srl h
    rr l
    jr .Lwall_z_ready
.Lwall_z_wide:
    call .Lshr24
    call .Lshr24
.Lwall_z_ready:
    ld (ix+RW_Z),hl
    ld (ix+RW_STEP),hl

    /* Six MLTs produce exactly the texture-relevant product byte. */
    ld d,(ix+RW_UZ)
    ld e,(ix+RW_INVERSE)
    mlt de
    ld a,d
    ld h,(ix+RW_UZ+1)
    ld l,(ix+RW_INVERSE)
    mlt hl
    ld bc,0
    ld c,a
    add hl,bc
    ld d,(ix+RW_UZ)
    ld e,(ix+RW_INVERSE+1)
    mlt de
    add hl,de
    ld a,h
    ld d,(ix+RW_UZ+2)
    ld e,(ix+RW_INVERSE)
    mlt de
    add a,e
    ld d,(ix+RW_UZ+1)
    ld e,(ix+RW_INVERSE+1)
    mlt de
    add a,e
    ld d,(ix+RW_UZ)
    ld e,(ix+RW_INVERSE+2)
    mlt de
    add a,e
    ld b,(iy+6)
    bit 7,b
    jr nz,.Lwall_u_left
    inc b
    dec b
    jr z,.Lwall_u_ready
.Lwall_u_right_loop:
    srl a
    djnz .Lwall_u_right_loop
    jr .Lwall_u_ready
.Lwall_u_left:
    ld c,a
    xor a,a
    sub a,b
    ld b,a
    ld a,c
.Lwall_u_left_loop:
    add a,a
    djnz .Lwall_u_left_loop
.Lwall_u_ready:
    and a,31
    ld (ix+RW_TX),a

    /* (y1-40)*z modulo 65536: signed byte times unsigned word. */
    ld a,(ix+RW_Y1)
    sub a,40
    ld c,a
    ld d,a
    ld e,(ix+RW_Z)
    mlt de
    ld h,c
    ld l,(ix+RW_Z+1)
    mlt hl
    ld a,l
    add a,d
    bit 7,c
    jr z,.Lwall_v_positive
    sub a,(ix+RW_Z)
.Lwall_v_positive:
    ld hl,0
    ld h,a
    ld l,e
    ld de,(ix+RW_STEP)
    ld a,2
    sub a,(iy+7)
    jr z,.Lwall_v_ready
    ld b,a
.Lwall_v_scale:
    add hl,hl
    ex de,hl
    add hl,hl
    ex de,hl
    djnz .Lwall_v_scale
.Lwall_v_ready:
    ld (ix+RW_STEP),de
    ld de,(iy+3)
    add hl,de
    ld (ix+RW_V),hl

    /* Quantized sprite occlusion depth, saturated to 1..254. */
    ld a,(ix+RW_Z+2)
    or a,a
    jr nz,.Lwall_far_depth
    ld a,(ix+RW_Z+1)
    cp a,16
    jr nc,.Lwall_far_depth
    rlca
    rlca
    rlca
    rlca
    and a,240
    ld c,a
    ld a,(ix+RW_Z)
    rrca
    rrca
    rrca
    rrca
    and a,15
    or a,c
    jr nz,.Lwall_depth_nonzero
    inc a
.Lwall_depth_nonzero:
    cp a,254
    jr c,.Lwall_depth_ready
.Lwall_far_depth:
    ld a,254
.Lwall_depth_ready:
    ld hl,0
    ld l,a
    push hl
    ld hl,(ix+RW_STEP)
    push hl
    ld hl,(ix+RW_V)
    push hl
    ld hl,0
    ld l,(ix+RW_COUNT)
    push hl

    /* Lighting distance is z/128, then a saturated shade-row lookup. */
    ld a,(ix+RW_Z+2)
    or a,a
    jr nz,.Lwall_dark
    ld a,(ix+RW_Z+1)
    cp a,16
    jr nc,.Lwall_dark
    add a,a
    ld c,a
    ld a,(ix+RW_Z)
    rlca
    and a,1
    add a,c
    add a,(ix+RW_SHADE)
    cp a,32
    jr c,.Lwall_light_ready
.Lwall_dark:
    ld a,31
.Lwall_light_ready:
    ld hl,0
    ld h,a
    ld de,(ix+RW_LIGHTBASE)
    add hl,de
    push hl
    ld hl,(iy+0)
    ld de,0
    ld e,(ix+RW_TX)
    add hl,de
    push hl
    ld hl,0
    ld h,(ix+RW_Y1)
    ld l,128
    mlt hl
    ld de,0
    ld e,(ix+RW_X)
    add hl,de
    push hl
    pop bc
    ld de,_depthbuffer
    add hl,de
    push hl
    push bc
    pop hl
    ld de,_engine_view+2
    add hl,de
    push hl
    call _d84_wall
    ld hl,24
    add hl,sp
    ld sp,hl
    ret

/* Register-only unsigned Q20 reciprocal, bit-for-bit with the C reference.
 * Above 2048, normalize the input; table results then fit in 16 bits.
 * Small inputs have zero normalization shifts and use the wide table.
 */
.global _d84_reciprocal
_d84_reciprocal:
.Lreciprocal:
    ld c,0
.Lrecip_normalize:
    ld de,2049
    or a,a
    sbc hl,de
    add hl,de
    jr c,.Lrecip_lookup
    call .Lshr24
    inc c
    jr .Lrecip_normalize
.Lrecip_lookup:
    ld de,17
    or a,a
    sbc hl,de
    add hl,de
    jr c,.Lrecip_small
    add hl,hl
    ld de,_reciprocal_table
    add hl,de
    ld de,0
    ld e,(hl)
    inc hl
    ld d,(hl)
    ex de,hl
    ld b,c
    inc b
    dec b
    ret z
.Lrecip_shift:
    srl h
    rr l
    djnz .Lrecip_shift
    ret
.Lrecip_small:
    push hl
    pop de
    add hl,hl
    add hl,de
    ld de,_small_reciprocals
    add hl,de
    ld hl,(hl)
    ret

/* Preserve BC, DE, IX and IY while shifting unsigned HL by one. */
.Lshr24:
    push hl
    ld hl,2
    add hl,sp
    srl (hl)
    pop hl
    rr h
    rr l
    ret
