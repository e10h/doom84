/* GPL-2.0-or-later. Exact near-first BSP traversal. Stack frames contain
 * the node/seg pointer, side/material pointer, and remaining leaf seg count.
 * Projection and near clipping retain their C implementation.
 */
.assume ADL=1
.section .text._d84_bsp,"ax",@progbits
.global _d84_bsp
_d84_bsp:
    ld a,(_open_columns)
    or a,a
    ret z
    push ix
    ld ix,0
    add ix,sp
    ld hl,-9
    add hl,sp
    ld sp,hl
    ld a,(_render_stats+8)
    ld b,a
    ld a,(ix+9)
    cp a,b
    jr c,.Lbsp_depth_done
    ld (_render_stats+8),a
.Lbsp_depth_done:
    ld hl,(ix+6)
    bit 7,h
    jp nz,.Lbsp_leaf
    add hl,hl
    ld de,(_d84_node_offsets)
    add hl,de
    ld de,0
    ld e,(hl)
    inc hl
    ld d,(hl)
    ld hl,(_nodes)
    add hl,de
    ld (ix-3),hl
    push hl
    call _d84_node_side_camera
    pop de
    ld (ix-6),hl
    ld a,l
    call .Lbsp_child
    ld hl,(ix+9)
    inc hl
    push hl
    push de
    call _d84_bsp
    ld hl,6
    add hl,sp
    ld sp,hl

    ld a,(_open_columns)
    or a,a
    jr z,.Lbsp_return
    ld a,(ix-6)
    xor a,1
    ld e,a
    ld d,0
    ld hl,(ix+6)
    add hl,hl
    /* DE upper byte was cleared by .Lbsp_child. Make it explicit here. */
    ld bc,0
    ld c,a
    add hl,bc
    push hl
    ld hl,0
    ld l,a
    add hl,hl
    add hl,hl
    add hl,hl
    ld de,8
    add hl,de
    ld de,(ix-3)
    add hl,de
    push hl
    call _d84_bbox_visible
    ld hl,6
    add hl,sp
    ld sp,hl
    or a,a
    jr z,.Lbsp_return
    ld a,(ix-6)
    xor a,1
    call .Lbsp_child
    /* Tail visit the far child: reuse the caller-owned argument slots. */
    ld (ix+6),de
    ld hl,(ix+9)
    inc hl
    ld (ix+9),hl
    ld sp,ix
    pop ix
    jp _d84_bsp
.Lbsp_return:
    ld sp,ix
    pop ix
    ret
/* A=child side, DE=result index. */
.Lbsp_child:
    add a,a
    add a,24
    ld hl,(ix-3)
    ld de,0
    ld e,a
    add hl,de
    ld de,0
    ld e,(hl)
    inc hl
    ld d,(hl)
    ret
.Lbsp_leaf:
    res 7,h
    add hl,hl
    add hl,hl
    ld de,(_subsectors)
    add hl,de
    ld de,0
    ld e,(hl)
    inc hl
    ld d,(hl)
    ld (ix-9),de
    inc hl
    ld bc,0
    ld c,(hl)
    inc hl
    ld b,(hl)
    ld hl,_render_stats+2
    inc (hl)
    jr nz,.Lbsp_leaf_counted
    inc hl
    inc (hl)
.Lbsp_leaf_counted:
    push bc
    pop hl
    add hl,hl
    push hl
    pop de
    add hl,hl
    add hl,de
    add hl,hl
    add hl,de
    ld de,(_segs)
    add hl,de
    ld (ix-3),hl
    push bc
    pop hl
    add hl,hl
    push hl
    pop de
    add hl,hl
    add hl,hl
    add hl,de
    ld de,_materials
    add hl,de
    ld (ix-6),hl
    ld c,(hl)
    ld a,(_player+26)
    push bc
    call _d84_pvs_test
    pop bc
    jr z,.Lbsp_return
.Lbsp_seg:
    ld a,(_open_columns)
    or a,a
    jr z,.Lbsp_return
    ld hl,(ix-9)
    ld de,0
    or a,a
    sbc hl,de
    jr z,.Lbsp_return
    dec hl
    ld (ix-9),hl
    ld hl,(ix-6)
    push hl
    ld hl,(ix-3)
    push hl
    call _d84_draw_seg
    ld hl,6
    add hl,sp
    ld sp,hl
    ld hl,(ix-3)
    ld de,14
    add hl,de
    ld (ix-3),hl
    ld hl,(ix-6)
    ld de,10
    add hl,de
    ld (ix-6),hl
    jr .Lbsp_seg

.section .text._d84_pvs_test,"ax",@progbits
.global _d84_pvs_test
_d84_pvs_test:
    cp a,85
    jr c,.Lpvs_from_ok
    or a,1
    ret
.Lpvs_from_ok:
    ld b,a
    ld a,c
    cp a,85
    jr c,.Lpvs_to_ok
    or a,1
    ret
.Lpvs_to_ok:
    ld hl,0
    ld h,11
    ld l,b
    mlt hl
    ld a,c
    rrca
    rrca
    rrca
    and a,0x1f
    ld e,a
    ld d,0
    add hl,de
    ld de,_pvs_table
    add hl,de
    ld b,(hl)
    ld a,c
    and a,7
    ld e,a
    ld d,0
    ld hl,.Lpvs_bits
    add hl,de
    ld a,(hl)
    and a,b
    ret

.Lpvs_bits:
    .byte 1, 2, 4, 8, 16, 32, 64, 128

