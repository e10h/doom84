#ifndef R_BSP_H
#define R_BSP_H

#include "doomdef.h"

void R_RenderBSPNode(unsigned index, unsigned depth);
unsigned node_side(int x, int y, const Node *n);

#endif /* R_BSP_H */
