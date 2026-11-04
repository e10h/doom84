#ifndef R_SEGS_H
#define R_SEGS_H

#include "doomdef.h"
#include "r_defs.h"

void d84_draw_seg(const Seg *seg, const Material *side);
void d84_wall_column(int x, int y1, int y2, const WallStyle *style, int iz, int uz, unsigned sector);
void render_columns(void);
void render_wire_columns(void);

#endif /* R_SEGS_H */
