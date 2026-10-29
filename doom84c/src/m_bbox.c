#include "m_bbox.h"
#include "m_fixed.h"
#include "r_state.h"
#include "r_main.h"

__attribute__((noinline)) bool d84_bbox_visible(const int16_t *box, unsigned boxindex) {
    /* Doom bbox order: top, bottom, left, right. Conservative near-plane
     * handling avoids dropping geometry when the camera intersects a box. */
    /* Doom's silhouette-corner table needs only two transformed corners. */
    static const uint8_t corners[12][2]={{2,1},{2,0},{3,0},{0,0},{0,1},{0,0},{3,2},{0,0},{0,3},{1,3},{1,2},{0,0}};
    uint8_t pos=(camx<=box[2]?0:camx<box[3]?1:2)+(camy>=box[0]?0:camy>box[1]?4:8);
    if(pos==5) return true;
    const uint16_t *points=box_points[boxindex];
    unsigned v1=points[corners[pos][0]],v2=points[corners[pos][1]];
    int r1,z1,r2,z2;
    vertex(v1,&r1,&z1);
    vertex(v2,&r2,&z2);
    /* These silhouette vectors generate the convex box's angular cone.
     * If both are outside one homogeneous frustum plane, the entire box
     * is outside. Expand by a screen column plus transform rounding to
     * conservatively cover the quantized reciprocal used by projection. */
    if(D84_FRUSTUM_CULL) {
        int margin1=2+ABS(z1)/64,margin2=2+ABS(z2)/64;
        if((r1+z1 < -margin1 && r2+z2 < -margin2) ||
           (z1-r1 < -margin1 && z2-r2 < -margin2)) return false;
    }
    if(z1<NEAR_Z || z2<NEAR_Z) return z1>=NEAR_Z || z2>=NEAR_Z;
    int x1=vertex_projection(v1,r1,z1),x2=vertex_projection(v2,r2,z2);
    int left=MAX(0,MIN(x1,x2)),right=MIN(VIEW_W-1,MAX(x1,x2));
    for (int x=left;x<=right;++x) if (cliptop[x]<clipbottom[x]) return true;
    return false;
}
