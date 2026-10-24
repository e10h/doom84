/* E1M1 CE experiment, GPL-2.0-or-later.
 * This is a compact new sector renderer using the original Doom BSP/seg data.
 * Near-first BSP traversal follows id Software's R_RenderBSPNode algorithm;
 * this is not yet a port of Doom's complete renderer or game simulation.
 */
#include "engine.h"
#include "generated.h"
#include "geometry.h"
#include "gun.h"
#include <limits.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

_Static_assert(sizeof(Vertex)==4,"Vertex disk layout");
_Static_assert(sizeof(Line)==14,"Line disk layout");
_Static_assert(sizeof(Side)==8,"Side disk layout");
_Static_assert(sizeof(Sector)==10,"Sector disk layout");
_Static_assert(sizeof(Seg)==14,"Seg disk layout");
_Static_assert(sizeof(Subsector)==4,"Subsector disk layout");
_Static_assert(sizeof(Node)==28,"Node disk layout");
_Static_assert(sizeof(MapActor)==14,"Actor disk layout");

#define FOCAL 64
#define CENTER 40
#define NEAR_Z 4
#ifndef D84_FRUSTUM_CULL
#define D84_FRUSTUM_CULL 1
#endif
#define ABS(a) ((a)<0?-(a):(a))
#define MIN(a,b) ((a)<(b)?(a):(b))
#define MAX(a,b) ((a)>(b)?(a):(b))
#define CLAMP(a,l,h) MIN(MAX(a,l),h)

Player player;
RenderStats render_stats;
unsigned render_detail=1;
View engine_view;
const Vertex *map_vertices;
const Line *map_lines;
const Sector *map_sectors;
const uint8_t *map_palette;
static const Side *sides;
const Seg *segs;
const Subsector *subsectors;
const Node *nodes;
static const MapActor *map_actors;
static const int16_t *blockmap;
static const uint8_t *colormaps;
static const uint8_t *images[NUM_TILES];
/* Aligned shade rows allow the eZ80 pixel loops to replace a pointer add
 * with LD L,A. Reciprocal lookup replaces divisions inside wall columns. */
static uint8_t ram_colormaps[32*256] __attribute__((aligned(256)));
uint16_t reciprocal_table[2049];
unsigned small_reciprocals[17];
typedef struct __attribute__((packed)) {uint8_t sector,back,middle,upper,lower,flags;int16_t x,y;} Material;
Material materials[NUM_SEGS];
#ifndef __TICE__
static const uint16_t row_offsets[VIEW_H]={0,128,256,384,512,640,768,896,1024,1152,1280,1408,1536,1664,1792,1920,2048,2176,2304,2432,2560,2688,2816,2944,3072,3200,3328,3456,3584,3712,3840,3968,4096,4224,4352,4480,4608,4736,4864,4992,5120,5248,5376,5504,5632,5760,5888,6016,6144,6272,6400,6528,6656,6784,6912,7040,7168,7296,7424,7552,7680,7808,7936,8064,8192,8320,8448,8576,8704,8832,8960,9088,9216,9344,9472,9600,9728,9856,9984,10112};
#endif
static const Sector *sector_at(unsigned index) {return (const Sector *)((const uint8_t *)map_sectors+sector_offsets[index]);}
static uint8_t sector_shades[NUM_SECTORS];
static const uint8_t *shade_rows[32];
static uint8_t plane_colors[NUM_SECTORS*2];

#ifdef __TICE__
void d84_wall(uint8_t *,uint8_t *,const uint8_t *,const uint8_t *,unsigned,int,int,unsigned);
void d84_span(uint8_t *,uint8_t *,const uint8_t *,const uint8_t *,unsigned,int,int,int,int,unsigned);
void d84_span2(uint8_t *,uint8_t *,const uint8_t *,const uint8_t *,unsigned,int,int,int,int,unsigned);
void d84_span4(uint8_t *,uint8_t *,const uint8_t *,const uint8_t *,unsigned,int,int,int,int,unsigned);
void d84_fill_column(uint8_t *,unsigned,unsigned);
void d84_double_columns(uint8_t *,unsigned);
void d84_quad_columns(uint8_t *,unsigned);
void d84_sprite(uint8_t *,uint8_t *,const uint8_t *,const uint8_t *,unsigned,unsigned,unsigned,unsigned,unsigned);
#else
static void d84_wall(uint8_t *dst,uint8_t *depth,const uint8_t *image,const uint8_t *light,unsigned count,int v,int step,unsigned z) {
    while (count--) {*dst=light[image[(((unsigned)v>>8)&31)*32]];*depth=(uint8_t)z;dst+=VIEW_W;depth+=VIEW_W;v+=step;}
}
static void d84_span(uint8_t *dst,uint8_t *depth,const uint8_t *image,const uint8_t *light,unsigned count,int wx,int wy,int sx,int sy,unsigned z) {
    while(count--) {*dst++=light[image[(((unsigned)wy>>9)&31)*32+(((unsigned)wx>>9)&31)]];*depth++=(uint8_t)z;wx+=sx;wy+=sy;}
}
static void d84_span2(uint8_t *dst,uint8_t *depth,const uint8_t *image,const uint8_t *light,unsigned count,int wx,int wy,int sx,int sy,unsigned z) {
    while(count--) {*dst=light[image[(((unsigned)wy>>9)&31)*32+(((unsigned)wx>>9)&31)]];*depth=(uint8_t)z;dst+=2;depth+=2;wx+=sx;wy+=sy;}
}
static void d84_span4(uint8_t *dst,uint8_t *depth,const uint8_t *image,const uint8_t *light,unsigned count,int wx,int wy,int sx,int sy,unsigned z) {
    while(count--) {*dst=light[image[(((unsigned)wy>>9)&31)*32+(((unsigned)wx>>9)&31)]];*depth=(uint8_t)z;dst+=4;depth+=4;wx+=sx;wy+=sy;}
}
static void d84_quad_columns(uint8_t *dst,unsigned count) {while(count--) {dst[1]=dst[2]=dst[3]=dst[0];dst+=4;}}
static void d84_fill_column(uint8_t *dst,unsigned count,unsigned color) {while(count--) {*dst=(uint8_t)color;dst+=VIEW_W;}}
static void d84_double_columns(uint8_t *dst,unsigned count) {while(count--) {dst[1]=dst[0];dst+=2;}}
static void d84_sprite(uint8_t *dst,uint8_t *depth,const uint8_t *image,const uint8_t *light,unsigned count,unsigned u,unsigned step,unsigned z,unsigned stride) {
    while(count--) {if(z<*depth) {uint8_t pixel=image[u>>8];if(pixel!=255) {*dst=light[pixel];*depth=(uint8_t)z;}}dst+=stride;depth+=stride;u+=step;}
}

#endif

static unsigned reciprocal(unsigned value) {
    unsigned shift=0;
    while (value>2048) {value>>=1;++shift;}
    return (value<17?small_reciprocals[value?value:1]:reciprocal_table[value])>>shift;
}
#ifndef __TICE__
static int high_word(int32_t value) {
    union {int32_t value;struct {uint16_t low;int16_t high;} words;} bits;
    bits.value=value;
    return bits.words.high;
}
#endif
#ifndef __TICE__
__attribute__((noinline)) static int16_t shr8(int value) {
    union {int value;struct __attribute__((packed)){uint8_t low;int16_t high;} words;} bits;
    bits.value=value;
    return bits.words.high;
}
#endif
#ifdef __TICE__
int d84_screen_x(int r,int z);
#define screen_x d84_screen_x
#else
static int screen_x(int r,int z) {
    if(ABS(r)<=z*4) {
        union {int value;struct __attribute__((packed)){uint8_t b0,b1;int8_t b2;} part;} p;
        p.value=r*(int)reciprocal((unsigned)z);
        return 64+(int)p.part.b2*4+(p.part.b1>>6);
    }
    union {int32_t value;struct{uint8_t b0,b1;int16_t high;} parts;} bits;
    bits.value=(int32_t)r*reciprocal((unsigned)z);
    return 64+bits.parts.high*4+(bits.parts.b1>>6);
}

#endif

/* Only mutable data lives in RAM. Level and images stay in archived AppVars. */
static int16_t sector_ceiling[NUM_SECTORS],sector_target[NUM_SECTORS];
static int16_t sector_floor[NUM_SECTORS],floor_target[NUM_SECTORS];
static uint8_t floor_wait[NUM_SECTORS];
uint8_t depthbuffer[VIEW_W*VIEW_H];
static uint8_t planes[VIEW_W*VIEW_H];
static uint8_t cliptop[VIEW_W],clipbottom[VIEW_W];
static int16_t vertex_side[NUM_RENDER_POINTS],vertex_depth[NUM_RENDER_POINTS],vertex_screen[NUM_RENDER_POINTS];
static uint8_t vertex_stamp[NUM_RENDER_POINTS],frame_stamp;
int camx,camy;
int camcos,camsin;
int16_t d84_rotated[3];
#ifdef __TICE__
void d84_set_camera(void);
void d84_rotate(int dx,int dy);
#else
static void d84_rotate(int dx,int dy) {d84_rotated[0]=shr8(dx*camsin-dy*camcos);d84_rotated[1]=shr8(dx*camcos+dy*camsin);}
#endif
static uint8_t use_held;
static uint16_t random_state;

typedef struct { int16_t x,y; uint8_t sector,hp,removed,cooldown; } Actor;
static Actor actors[NUM_ACTORS];
static uint8_t sprite_order[NUM_ACTORS];
static int16_t sprite_z[NUM_ACTORS],sprite_x[NUM_ACTORS];

static int isin(unsigned a) { return sine_table[a&1023]; }
static int icos(unsigned a) { return sine_table[(a+256)&1023]; }
static unsigned rnd(void) { random_state=(uint16_t)(random_state*25173u+13849u); return random_state; }

/* Doom node child 0 is the right-hand side of its partition. Avoid native
 * int multiplication here: differences/products can exceed 24-bit range. */
static unsigned node_side(int x,int y,const Node *n) {
    if (!n->dx) return x<=n->x ? n->dy>0 : n->dy<0;
    if (!n->dy) return y<=n->y ? n->dx<0 : n->dx>0;
    int32_t left=(int32_t)(x-n->x)*n->dy;
    int32_t right=(int32_t)(y-n->y)*n->dx;
    return right>=left;
}

uint8_t engine_sector(int x,int y) {
    unsigned index=NUM_NODES-1;
    while (!(index&0x8000u)) {
        const Node *n=(const Node *)((const uint8_t *)nodes+node_offsets[(uint8_t)index]);
        index=n->child[node_side(x,y,n)];
    }
    const Subsector *sub=&subsectors[index&0x7fffu];
    const Seg *seg=&segs[sub->first];
    return sides[map_lines[seg->line].side[seg->side]].sector;
}

bool engine_init(const uint8_t *map,unsigned size,const uint8_t *const *banks,const unsigned *sizes) {
    if (size!=MAP_SIZE || memcmp(map,"D84MAP01",8) || memcmp(map+8,asset_id,8)) return false;
    for (unsigned i=0;i<NUM_BANKS;++i)
        if (sizes[i]!=bank_sizes[i] || memcmp(banks[i],"D84TEX01",8) || memcmp(banks[i]+8,asset_id,8)) return false;
    map_vertices=(const Vertex *)(map+OFF_VERTICES);
    map_lines=(const Line *)(map+OFF_LINES);
    sides=(const Side *)(map+OFF_SIDES);
    map_sectors=(const Sector *)(map+OFF_SECTORS);
    segs=(const Seg *)(map+OFF_SEGS);
    subsectors=(const Subsector *)(map+OFF_SUBSECTORS);
    nodes=(const Node *)(map+OFF_NODES);
    map_actors=(const MapActor *)(map+OFF_ACTORS);
    blockmap=(const int16_t *)(map+OFF_BLOCKMAP);
    map_palette=map+OFF_PALETTE;
    memcpy(ram_colormaps,map+OFF_COLORMAP,sizeof(ram_colormaps));
    colormaps=ram_colormaps;
    for(unsigned i=0;i<32;++i) shade_rows[i]=colormaps+i*256;
    for (unsigned i=1;i<=2048;++i) {unsigned value=(unsigned)(1048576L/i);reciprocal_table[i]=(uint16_t)value;if(i<17)small_reciprocals[i]=value;}
    for (unsigned i=0;i<NUM_TILES;++i) images[i]=banks[tile_bank[i]]+tile_offset[i];
    for(unsigned i=0;i<NUM_SEGS;++i) {
        const Seg *seg=&segs[i];const Line *line=&map_lines[seg->line];const Side *s=&sides[line->side[seg->side]];
        materials[i]=(Material){s->sector,line->side[seg->side^1]==65535u?255:sides[line->side[seg->side^1]].sector,s->middle,s->upper,s->lower,(uint8_t)line->flags,s->x,s->y};
        Material *m=&materials[i];m->flags&=127;
        if(m->back!=255) {
            const Sector *a=sector_at(m->sector),*b=sector_at(m->back);
            if(a->flat==b->flat && a->ceiltex==b->ceiltex && a->light==b->light) m->flags|=128;
        }
    }
    for(unsigned i=0;i<NUM_SECTORS;++i) {
        const Sector *s=&(*sector_at(i));sector_shades[i]=(uint8_t)((255-s->light)/8);const uint8_t *light=colormaps+((255-s->light)/8)*256;
        plane_colors[i]=light[images[s->flat][528]];
        plane_colors[i+NUM_SECTORS]=s->ceiltex==255?images[SKY_TILE][12*32+16]:light[images[s->ceiltex][528]];
    }
    engine_view.width=VIEW_W;engine_view.height=VIEW_H;
    engine_reset();
    return true;
}

void engine_reset(void) {
    memset(&player,0,sizeof(player));
    player.x=(int32_t)START_X*256;
    player.y=(int32_t)START_Y*256;
    player.angle=START_ANGLE;
    player.health=100;
    player.ammo=50;
    player.texture_planes=true;
    player.sector=engine_sector(START_X,START_Y);
    player.floor=(*sector_at(player.sector)).floor;
    player.eye=player.floor+41;
    random_state=1;
    use_held=0;
    memset(floor_wait,0,sizeof(floor_wait));
    for (unsigned i=0;i<NUM_SECTORS;++i) {
        sector_target[i]=sector_ceiling[i]=(*sector_at(i)).ceiling;
        floor_target[i]=sector_floor[i]=(*sector_at(i)).floor;
    }
    for (unsigned i=0;i<NUM_ACTORS;++i) {
        const MapActor *m=&map_actors[i];
        actors[i]=(Actor){m->x,m->y,engine_sector(m->x,m->y),m->hp,0,0};
        if (m->kind==1) ++player.total;
    }
}

static bool line_passable(const Line *l,int floor) {
    if (l->side[1]==65535u || (l->flags&1)) return false;
    unsigned a=sides[l->side[0]].sector,b=sides[l->side[1]].sector;
    int bottom=MAX(sector_floor[a],sector_floor[b]);
    return bottom-floor<=24 && MIN(sector_ceiling[a],sector_ceiling[b])-MAX(bottom,floor)>=56;
}

static bool collision_line(unsigned i,int x,int y,int floor) {
    const int radius=16;
        const Line *l=&map_lines[i];
        const Vertex *a=&map_vertices[l->v1],*b=&map_vertices[l->v2];
        if (x<MIN(a->x,b->x)-radius || x>MAX(a->x,b->x)+radius || y<MIN(a->y,b->y)-radius || y>MAX(a->y,b->y)+radius) return true;
        if (line_passable(l,floor)) return true;
        int dx=b->x-a->x,dy=b->y-a->y,px=x-a->x,py=y-a->y;
        int32_t len2=(int32_t)dx*dx+(int32_t)dy*dy;
        int32_t dot=(int32_t)px*dx+(int32_t)py*dy;
        if (dot<0) {
            if ((int32_t)px*px+(int32_t)py*py<radius*radius) return false;
        } else if (dot>len2) {
            px=x-b->x; py=y-b->y;
            if ((int32_t)px*px+(int32_t)py*py<radius*radius) return false;
        } else if (len2) {
            /* Project to 8.8 along segment. The bbox above bounds these
             * products for E1M1; use 64-bit only in this infrequent path. */
            int32_t t=(int32_t)(((int64_t)dot*256)/len2);
            px=x-(a->x+(int)((int32_t)dx*t/256));
            py=y-(a->y+(int)((int32_t)dy*t/256));
            if ((int32_t)px*px+(int32_t)py*py<radius*radius) return false;
        }
    return true;
}

bool engine_can_move(int x,int y,int floor) {
    int left=(x-16-blockmap[0])>>7,right=(x+16-blockmap[0])>>7;
    int bottom=(y-16-blockmap[1])>>7,top=(y+16-blockmap[1])>>7;
    if (left<0 || bottom<0 || right>=blockmap[2] || top>=blockmap[3]) return false;
    for (int row=bottom;row<=top;++row) for (int col=left;col<=right;++col) {
        unsigned offset=(uint16_t)blockmap[4+row*blockmap[2]+col];
        /* Each original Doom block list starts with a dummy zero. */
        for (++offset;blockmap[offset]!=-1;++offset)
            if (!collision_line((uint16_t)blockmap[offset],x,y,floor)) return false;
    }
    uint8_t s=engine_sector(x,y);
    return sector_floor[s]-floor<=24 && sector_ceiling[s]-MAX(sector_floor[s],floor)>=56;
}

/* Segment crossing test for shooting/AI. The prototype treats the shot as
 * horizontal at eye height and respects closed doors and vertical openings. */
static bool sight(int x,int y,int tx,int ty,int eye) {
    int dx=tx-x,dy=ty-y;
    for (unsigned i=0;i<NUM_LINES;++i) {
        const Line *l=&map_lines[i];
        const Vertex *a=&map_vertices[l->v1],*b=&map_vertices[l->v2];
        if (MAX(x,tx)<MIN(a->x,b->x) || MIN(x,tx)>MAX(a->x,b->x) || MAX(y,ty)<MIN(a->y,b->y) || MIN(y,ty)>MAX(a->y,b->y)) continue;
        if (l->side[1]!=65535u) {
            unsigned sa=sides[l->side[0]].sector,sb=sides[l->side[1]].sector;
            if (eye>MAX(sector_floor[sa],sector_floor[sb]) && eye<MIN(sector_ceiling[sa],sector_ceiling[sb])) continue;
        }
        int32_t c1=(int32_t)(a->x-x)*dy-(int32_t)(a->y-y)*dx;
        int32_t c2=(int32_t)(b->x-x)*dy-(int32_t)(b->y-y)*dx;
        int32_t c3=(int32_t)(x-a->x)*(b->y-a->y)-(int32_t)(y-a->y)*(b->x-a->x);
        int32_t c4=(int32_t)(tx-a->x)*(b->y-a->y)-(int32_t)(ty-a->y)*(b->x-a->x);
        if ((c1<0)!=(c2<0) && (c3<0)!=(c4<0)) return false;
    }
    return true;
}

static void activate_sector(unsigned s) {
    int ceiling=32767,floor=32767;
    for (unsigned j=0;j<NUM_LINES;++j) {
        const Line *edge=&map_lines[j];
        if (edge->side[1]==65535u) continue;
        unsigned a=sides[edge->side[0]].sector,b=sides[edge->side[1]].sector;
        if (a!=s && b!=s) continue;
        unsigned other=a==s?b:a;
        ceiling=MIN(ceiling,sector_ceiling[other]-4);
        floor=MIN(floor,sector_floor[other]);
    }
    if (ceiling!=32767) sector_target[s]=MAX(sector_ceiling[s],ceiling);
    if (floor!=32767 && floor<sector_floor[s]) floor_target[s]=floor;
}

static void cross_triggers(int oldx,int oldy,int x,int y) {
    if (oldx==x && oldy==y) return;
    for (unsigned i=0;i<NUM_WALK_TRIGGERS;++i) {
        const Line *line=&map_lines[walk_triggers[i]];
        const Vertex *a=&map_vertices[line->v1],*b=&map_vertices[line->v2];
        if (MAX(oldx,x)<MIN(a->x,b->x) || MIN(oldx,x)>MAX(a->x,b->x) || MAX(oldy,y)<MIN(a->y,b->y) || MIN(oldy,y)>MAX(a->y,b->y)) continue;
        int dx=b->x-a->x,dy=b->y-a->y;
        int32_t before=(int32_t)(oldx-a->x)*dy-(int32_t)(oldy-a->y)*dx;
        int32_t after=(int32_t)(x-a->x)*dy-(int32_t)(y-a->y)*dx;
        if ((before<0)==(after<0)) continue;
        for (unsigned s=0;s<NUM_SECTORS;++s) {
            if (!line->tag || (*sector_at(s)).tag!=line->tag) continue;
            int lowest=sector_floor[s];
            for (unsigned j=0;j<NUM_LINES;++j) {
                const Line *edge=&map_lines[j];
                if (edge->side[1]==65535u) continue;
                unsigned sa=sides[edge->side[0]].sector,sb=sides[edge->side[1]].sector;
                if (sa==s) lowest=MIN(lowest,sector_floor[sb]);
                if (sb==s) lowest=MIN(lowest,sector_floor[sa]);
            }
            if (line->special==36) floor_target[s]=MIN(sector_floor[s],lowest+8);
            else if (!floor_wait[s] && sector_floor[s]==(*sector_at(s)).floor) {
                floor_target[s]=lowest;floor_wait[s]=255;
            }
        }
    }
}

static void use(void) {
    int x=(int)(player.x/256),y=(int)(player.y/256);
    int c=icos(player.angle),s=isin(player.angle);
    int best=80; const Line *found=NULL;
    for (unsigned i=0;i<NUM_LINES;++i) {
        const Line *l=&map_lines[i];
        if (!l->special || l->special==48) continue;
        const Vertex *a=&map_vertices[l->v1],*b=&map_vertices[l->v2];
        int ax=a->x-x,ay=a->y-y,bx=b->x-x,by=b->y-y;
        int ar=(int)(((int32_t)ax*s-(int32_t)ay*c)/256);
        int br=(int)(((int32_t)bx*s-(int32_t)by*c)/256);
        if ((ar<0)==(br<0) || ar==br) continue;
        int az=(int)(((int32_t)ax*c+(int32_t)ay*s)/256);
        int bz=(int)(((int32_t)bx*c+(int32_t)by*s)/256);
        int z=az+(int)((int32_t)(bz-az)*ar/(ar-br));
        if (z>0 && z<best) { best=z;found=l; }
    }
    if (!found) return;
    if (found->special==11) {player.exited=true;return;}
    if (found->side[1]!=65535u) activate_sector(sides[found->side[1]].sector);
}

static void hurt(int damage) {
    int absorbed=MIN(player.armor,damage/3);
    player.armor-=absorbed; player.health-=damage-absorbed; player.damage=5;
    if (player.health<=0) {player.health=0;player.dead=true;}
}

/* Doom pistol states (tics): A4 -> B6(+fire/flash) -> C4 -> B5(refire). */
#define PISTOL_TOTAL 19
#define PISTOL_FIRE_AT 15

static void fire_shot(void) {
    if (!player.ammo) return;
    --player.ammo;
    int c=icos(player.angle),s=isin(player.angle),best=2048,index=-1;
    int x=(int)(player.x/256),y=(int)(player.y/256);
    for (unsigned i=0;i<NUM_ACTORS;++i) {
        Actor *a=&actors[i];
        if (!a->hp || a->removed) continue;
        int dx=a->x-x,dy=a->y-y;
        int z=(int)(((int32_t)dx*c+(int32_t)dy*s)/256);
        int r=(int)(((int32_t)dx*s-(int32_t)dy*c)/256);
        if (z<0 || z>=best || ABS(r)>20) continue;
        if (!sight(x,y,a->x,a->y,player.eye)) continue;
        best=z;index=(int)i;
    }
    if (index>=0) {
        Actor *a=&actors[index];
        int damage=5*(1+(rnd()%3));
        if (damage>=a->hp) {
            a->hp=0;
            if (map_actors[index].kind==1) {++player.kills;player.ammo+=5;}
        } else a->hp-=damage;
    }
}

static void shoot(void) {
    if (player.fire || !player.ammo) return;
    player.fire=PISTOL_TOTAL;
}

void engine_tick(uint8_t input) {
    if (player.dead || player.exited) return;
    ++player.ticks;
    if (player.fire) {
        --player.fire;
        if (player.fire==PISTOL_FIRE_AT) fire_shot();
        /* A_ReFire: holding the trigger restarts at the end of the cycle. */
        if (player.fire==0 && (input&INPUT_FIRE) && player.ammo) player.fire=PISTOL_TOTAL;
    }
    if (player.damage) --player.damage;
    if (!(input&INPUT_STRAFE)) {
        int turn=(input&INPUT_RUN)?12:8;
        if (input&INPUT_LEFT) player.angle=(player.angle+turn)&1023;
        if (input&INPUT_RIGHT) player.angle=(player.angle-turn)&1023;
    }
    int forward=((input&INPUT_FORWARD)!=0)-((input&INPUT_BACK)!=0);
    int strafe=(input&INPUT_STRAFE)?(((input&INPUT_RIGHT)!=0)-((input&INPUT_LEFT)!=0)):0;
    int oldx=(int)(player.x/256),oldy=(int)(player.y/256);
    if(forward || strafe) {
        int c=icos(player.angle),s=isin(player.angle),speed=(input&INPUT_RUN)?8:4;
        int32_t nx=player.x+(forward*c+strafe*s)*speed;
        int32_t ny=player.y+(forward*s-strafe*c)*speed;
        if (nx!=player.x && engine_can_move((int)(nx/256),(int)(player.y/256),player.floor)) player.x=nx;
        if (ny!=player.y && engine_can_move((int)(player.x/256),(int)(ny/256),player.floor)) player.y=ny;
    }
    int x=(int)(player.x/256),y=(int)(player.y/256);
    if(x!=oldx || y!=oldy) player.sector=engine_sector(x,y);
    player.floor=sector_floor[player.sector];
    int target=player.floor+41;
    player.eye+=CLAMP(target-player.eye,-8,8);
    cross_triggers(oldx,oldy,x,y);
    for (unsigned i=0;i<NUM_SECTORS;++i) {
        if(sector_ceiling[i]==sector_target[i] && sector_floor[i]==floor_target[i] && !floor_wait[i]) continue;
        sector_ceiling[i]+=CLAMP(sector_target[i]-sector_ceiling[i],0,2);
        sector_floor[i]+=CLAMP(floor_target[i]-sector_floor[i],-4,4);
        if (floor_wait[i]==255 && sector_floor[i]==floor_target[i]) floor_wait[i]=105;
        else if (floor_wait[i] && floor_wait[i]<255 && !--floor_wait[i]) floor_target[i]=(*sector_at(i)).floor;
    }
    if ((input&INPUT_USE) && !use_held) use();
    use_held=(input&INPUT_USE)!=0;
    if (input&INPUT_FIRE) shoot();
    if (!(player.ticks&31) && ((*sector_at(player.sector)).special==5 || (*sector_at(player.sector)).special==7 || (*sector_at(player.sector)).special==16)) hurt(5);
    Actor *a=actors;const MapActor *m=map_actors;
    for (unsigned i=0;i<NUM_ACTORS;++i,++a,++m) {
        if (a->removed || (m->kind!=1 && m->kind!=2) || (m->kind==1 && !a->hp)) continue;
        int dx=x-a->x,dy=y-a->y,dist=MAX(ABS(dx),ABS(dy));
        if (m->kind==2 && dist<28) {
            bool take=true;
            switch (m->type) {
                case 2011:case 2012: if(player.health>=100)take=false; else player.health=MIN(100,player.health+(m->type==2011?10:25));break;
                case 2014:player.health=MIN(200,player.health+1);break;
                case 2015:player.armor=MIN(200,player.armor+1);break;
                case 2018:case 2019:player.armor=MAX(player.armor,m->type==2018?100:200);break;
                default:player.ammo=MIN(200,player.ammo+10);break;
            }
            if (take) a->removed=1;
        }
        if (m->kind!=1 || !a->hp || dist>768) continue;
        if (a->cooldown) --a->cooldown;
        if (((player.ticks+i)&7)!=0 || !sight(a->x,a->y,x,y,player.eye)) continue;
        if (dist<384 && !a->cooldown) {hurt(2+(rnd()%7));a->cooldown=35;}
        if (dist>48) {
            int mx=a->x+CLAMP(dx,-4,4),my=a->y+CLAMP(dy,-4,4);
            if (engine_can_move(mx,a->y,sector_floor[a->sector])) a->x=mx;
            if (engine_can_move(a->x,my,sector_floor[a->sector])) a->y=my;
            a->sector=engine_sector(a->x,a->y);
        }
    }
}

static void vertex(unsigned v,int *r,int *z) {
    if ((vertex_stamp[v]&254)!=frame_stamp) {
        const Vertex *point=v<NUM_VERTICES?map_vertices+v:extra_points+(v-NUM_VERTICES);
        int dx=point->x-camx,dy=point->y-camy;
        /* E1M1's coordinate range bounds each product and sum to 24 bits. */
        d84_rotate(dx,dy);
        vertex_side[v]=d84_rotated[0];vertex_depth[v]=d84_rotated[1];
        vertex_stamp[v]=frame_stamp;
    }
    *r=vertex_side[v];*z=vertex_depth[v];
}

static int vertex_projection(unsigned v,int r,int z) {
    if(z<32) return screen_x(r,z);
    if(!(vertex_stamp[v]&1)) {vertex_screen[v]=(int16_t)screen_x(r,z);vertex_stamp[v]|=1;}
    return vertex_screen[v];
}

static int project(int height,int z) { return CENTER-(height-player.eye)*FOCAL/z; }
static const uint8_t *lighting(unsigned sector,int z) {
    if(z>=4096) return shade_rows[31];
    union {int value;struct __attribute__((packed)){uint8_t low,high;} bytes;} bits;
    bits.value=z;
    uint8_t distance=(uint8_t)(bits.bytes.high*2)+(bits.bytes.low>>7);
    uint8_t shade=sector_shades[sector]+distance;
    return shade_rows[MIN(shade,31)];
}

#ifndef __TICE__
static uint8_t screen_y(int value) {
    if(value<=0) return 0;
    if(value>=VIEW_H*256) return VIEW_H;
    return (uint8_t)(value>>8);
}

static void plane_column(int x,int y1,int y2,uint8_t plane) {
    if(y1>y2) return;
    if(!player.texture_planes) {
        d84_fill_column(framebuffer+row_offsets[(uint8_t)y1]+x,(unsigned)(y2-y1+1),plane_colors[(plane&127)+((plane&128)?NUM_SECTORS:0)]);
        return;
    }
    for (int y=y1;y<=y2;++y) planes[y*VIEW_W+x]=plane;
}

#endif

typedef struct {const uint8_t *image; int base; int8_t shiftx,shifty;} WallStyle;
static WallStyle wall_style(unsigned tex,int anchor,int yoff) {
    WallStyle style={NULL,0,0,0};
    if(tex!=255) {
        style.image=images[tex];style.shiftx=(int8_t)tile_info[tex][1]-5;style.shifty=(int8_t)tile_info[tex][2]-5;
        style.base=(anchor-player.eye+yoff)*256;
        if(style.shifty>=0) style.base>>=style.shifty;
        else style.base*=1<<-style.shifty;
    }
    return style;
}
#ifndef __TICE__
static void d84_wall_column(int x,int y1,int y2,const WallStyle *style,int iz,int uz,unsigned sector) {
    if (y1>y2 || !style->image) return;
    ++render_stats.wall_columns;
    unsigned inv=reciprocal((unsigned)iz);
    int z=(int)(inv>>2),u=high_word((int32_t)uz*inv);
    const uint8_t *light=lighting(sector,z);
    unsigned tx=(style->shiftx>=0?((unsigned)u>>style->shiftx):((unsigned)u<<-style->shiftx))&31;
    int step=z,v=(y1-CENTER)*z;
    switch(style->shifty) {
        case 2: break;
        case 1: v*=2;step*=2;break;
        case 0: v*=4;step*=4;break;
        case -1: v*=8;step*=8;break;
        case -2: v*=16;step*=16;break;
        default: if(style->shifty>2) {v>>=style->shifty-2;step>>=style->shifty-2;}
                 else {v*=1<<(2-style->shifty);step*=1<<(2-style->shifty);}break;
    }
    v+=style->base;
    uint8_t depth=(uint8_t)CLAMP(z/16,1,254);
    unsigned offset=row_offsets[(uint8_t)y1]+x;
    d84_wall(framebuffer+offset,depthbuffer+offset,style->image+tx,light,(unsigned)(y2-y1+1),v,step,depth);
}

#endif

typedef struct {
    int start,end,iz,diz,uz,duz,cyq,cy_step,fyq,fy_step,upperq,upper_step,lowerq,lower_step;
    int fceil,ffloor,bceil,bfloor,fs,base_shade;
    bool solid,skyportal;
    const Material *side;
    const uint8_t *light;
    WallStyle middle,upper,lower;
    uint8_t x,top,bottom,cy,fy,up,low;
    uint8_t *top_ptr,*bottom_ptr;
    uint8_t draw_upper,draw_lower;
    uint8_t *fill_base;
    uint8_t ceil_color,floor_color,stride;
    int inverse,z,v,step;
    uint8_t tx,count,y1;
} RenderWall;
RenderWall d84_rw;
#define rw d84_rw
#ifdef __TICE__
#include "render_abi.h"
#define CHECK_RW(field,offset) _Static_assert(offsetof(RenderWall,field)==offset,"assembly packet: " #field)
CHECK_RW(inverse,RW_INVERSE);CHECK_RW(z,RW_Z);CHECK_RW(v,RW_V);CHECK_RW(step,RW_STEP);
CHECK_RW(tx,RW_TX);CHECK_RW(count,RW_COUNT);CHECK_RW(y1,RW_Y1);CHECK_RW(base_shade,RW_SHADE);CHECK_RW(light,RW_LIGHTBASE);
CHECK_RW(start,RW_START);CHECK_RW(end,RW_END);CHECK_RW(iz,RW_IZ);CHECK_RW(diz,RW_DIZ);
CHECK_RW(uz,RW_UZ);CHECK_RW(duz,RW_DUZ);CHECK_RW(cyq,RW_CYQ);CHECK_RW(cy_step,RW_CYSTEP);
CHECK_RW(fyq,RW_FYQ);CHECK_RW(fy_step,RW_FYSTEP);CHECK_RW(upperq,RW_UPPERQ);CHECK_RW(upper_step,RW_UPPERSTEP);
CHECK_RW(lowerq,RW_LOWERQ);CHECK_RW(lower_step,RW_LOWERSTEP);CHECK_RW(fs,RW_FS);CHECK_RW(solid,RW_SOLID);
CHECK_RW(middle,RW_MIDDLE);CHECK_RW(upper,RW_UPPER);CHECK_RW(lower,RW_LOWER);CHECK_RW(x,RW_X);
CHECK_RW(top,RW_TOP);CHECK_RW(bottom,RW_BOTTOM);CHECK_RW(cy,RW_CY);CHECK_RW(fy,RW_FY);
CHECK_RW(up,RW_UP);CHECK_RW(low,RW_LOW);CHECK_RW(top_ptr,RW_TOPPTR);CHECK_RW(bottom_ptr,RW_BOTTOMPTR);
CHECK_RW(draw_upper,RW_DRAWUPPER);CHECK_RW(draw_lower,RW_DRAWLOWER);CHECK_RW(fill_base,RW_FILLBASE);
CHECK_RW(ceil_color,RW_CEILCOLOR);CHECK_RW(floor_color,RW_FLOORCOLOR);CHECK_RW(stride,RW_STRIDE);
_Static_assert(sizeof(RenderWall)==RW_SIZE,"assembly packet size");
void d84_render_columns(void);
#define render_columns d84_render_columns
#else
__attribute__((noinline)) static void render_columns(void) {
    for (int x=rw.start;x<rw.end;x+=(int)render_detail,rw.iz+=rw.diz,rw.uz+=rw.duz,rw.cyq+=rw.cy_step,rw.fyq+=rw.fy_step,rw.upperq+=rw.upper_step,rw.lowerq+=rw.lower_step) {
        int top=cliptop[x],bottom=clipbottom[x];
        if (top>=bottom || rw.iz<=0) continue;
        uint8_t cy=screen_y(rw.cyq),fy=screen_y(rw.fyq);
        plane_column(x,top,MIN(bottom-1,cy-1),(uint8_t)(rw.fs|128));
        plane_column(x,MAX(top,fy),bottom-1,(uint8_t)rw.fs);
        if (rw.solid) {
            d84_wall_column(x,MAX(top,cy),MIN(bottom-1,fy-1),&rw.middle,rw.iz,rw.uz,(unsigned)rw.fs);
            cliptop[x]=clipbottom[x];
        } else {
            uint8_t upper=screen_y(rw.upperq),lower=screen_y(rw.lowerq);
            if (rw.bceil<rw.fceil && !rw.skyportal) {
                d84_wall_column(x,MAX(top,cy),MIN(bottom-1,upper-1),&rw.upper,rw.iz,rw.uz,(unsigned)rw.fs);
            }
            if (rw.bfloor>rw.ffloor) {
                d84_wall_column(x,MAX(top,lower),MIN(bottom-1,fy-1),&rw.lower,rw.iz,rw.uz,(unsigned)rw.fs);
            }
            cliptop[x]=(uint8_t)CLAMP(MAX(top,MAX(cy,upper)),top,bottom);
            clipbottom[x]=(uint8_t)CLAMP(MIN(bottom,MIN(fy,lower)),cliptop[x],bottom);
        }
        for(unsigned k=1;k<render_detail;++k) {cliptop[x+(int)k]=cliptop[x];clipbottom[x+(int)k]=clipbottom[x];}
    }
}

#endif

static int height_product(int height,int inverse) {
    if(inverse>=-16384 && inverse<=16383) return (height*inverse)>>4;
    return (int)(((int32_t)height*inverse)>>4);
}

__attribute__((noinline)) void d84_draw_seg(const Seg *seg,const Material *side) {
    unsigned fs=side->sector;
    int bs=side->back==255?-1:side->back;
    if(bs>=0 && (side->flags&128) && sector_floor[fs]==sector_floor[bs] && sector_ceiling[fs]==sector_ceiling[bs] && side->middle==255) return;
    int r1,z1,r2,z2;
    vertex(seg->v1,&r1,&z1);vertex(seg->v2,&r2,&z2);
    /* Backface cull before clipping, using the projected segment winding. */
    /* Cross-product magnitude is bounded by E1M1's maximum seg length
     * times level diameter (<2^23). Unsigned intermediate products may
     * wrap, but their difference is representable as signed native int. */
    if ((int)((unsigned)r1*z2-(unsigned)r2*z1)>=0 || (z1<NEAR_Z && z2<NEAR_Z)) return;
    /* All E1M1 wall texture widths divide 1024. Remove whole repeats to
     * bound U/Z accumulators to 24 bits without changing texture phase. */
    int u1=(side->x+seg->offset)&1023,u2=u1+seg->length;
    if (z1<NEAR_Z) {
        r1+=(int)((int32_t)(r2-r1)*(NEAR_Z-z1)/(z2-z1));
        u1+=(int)((int32_t)(u2-u1)*(NEAR_Z-z1)/(z2-z1));z1=NEAR_Z;
    }
    if (z2<NEAR_Z) {
        r2+=(int)((int32_t)(r1-r2)*(NEAR_Z-z2)/(z1-z2));
        u2+=(int)((int32_t)(u1-u2)*(NEAR_Z-z2)/(z1-z2));z2=NEAR_Z;
    }
    int sx1=vertex_projection(seg->v1,r1,z1),sx2=vertex_projection(seg->v2,r2,z2);
    if (sx1>=sx2 || sx2<=0 || sx1>=VIEW_W) return;
    int start=MAX(0,sx1),end=MIN(VIEW_W,sx2);
    if(render_detail>1) start=(start+(int)render_detail-1)&~((int)render_detail-1);
    while(start<end && cliptop[start]>=clipbottom[start]) start+=(int)render_detail;
    while(end>start && cliptop[end-1]>=clipbottom[end-1]) --end;
    if(start>=end) return;
    int iz1=(int)(reciprocal((unsigned)z1)>>2),iz2=(int)(reciprocal((unsigned)z2)>>2);
    int uz1=(int)(((int32_t)u1*iz1)>>4),uz2=(int)(((int32_t)u2*iz2)>>4);
    int span=sx2-sx1;
    int diz=(iz2-iz1)/span;
    int duz=(uz2-uz1)/span;
    int iz=iz1+diz*(start-sx1);
    int uz=uz1+duz*(start-sx1);
    int fceil=sector_ceiling[fs],ffloor=sector_floor[fs];
    bool skyportal=bs>=0 && (*sector_at(fs)).ceiltex==255 && (*sector_at(bs)).ceiltex==255;
    if (skyportal) fceil=sector_ceiling[bs];
    bool solid=bs<0 || sector_ceiling[bs]<=ffloor || sector_floor[bs]>=fceil || sector_ceiling[bs]<=sector_floor[bs];
    /* Projected heights are linear in inverse depth. Compute their slopes
     * once, then advance native 24-bit DDAs for each column. */
    int cyq=40*256-height_product(fceil-player.eye,iz);
    int fyq=40*256-height_product(ffloor-player.eye,iz);
    int cy_step=-height_product(fceil-player.eye,diz);
    int fy_step=-height_product(ffloor-player.eye,diz);
    int bceil=bs<0?fceil:sector_ceiling[bs],bfloor=bs<0?ffloor:sector_floor[bs];
    int upperq=bceil==fceil?cyq:40*256-height_product(bceil-player.eye,iz);
    int lowerq=bfloor==ffloor?fyq:40*256-height_product(bfloor-player.eye,iz);
    int upper_step=bceil==fceil?cy_step:-height_product(bceil-player.eye,diz);
    int lower_step=bfloor==ffloor?fy_step:-height_product(bfloor-player.eye,diz);
    diz*=(int)render_detail;duz*=(int)render_detail;cy_step*=(int)render_detail;fy_step*=(int)render_detail;upper_step*=(int)render_detail;lower_step*=(int)render_detail;
    const uint8_t *light=colormaps;
    ++render_stats.segs;
    rw=(RenderWall){start,end,iz,diz,uz,duz,cyq,cy_step,fyq,fy_step,upperq,upper_step,lowerq,lower_step,fceil,ffloor,bceil,bfloor,fs,sector_shades[fs],solid,skyportal,side,light,{0},{0},{0},0,0,0,0,0,0,0,NULL,NULL,0,0,NULL,0,0,0,0,0,0,0,0,0,0};
    if(solid) {
        unsigned tex=side->middle;
        if(tex==255 && bs>=0) tex=side->upper;
        if(tex==255 && bs>=0) tex=side->lower;
        rw.middle=wall_style(tex,tex!=255 && (side->flags&16)?ffloor+(1<<tile_info[tex][2]):fceil,side->y);
    } else {
        if(bceil<fceil && !skyportal) rw.upper=wall_style(side->upper,(side->flags&8)?fceil:bceil+(side->upper==255?128:(1<<tile_info[side->upper][2])),side->y);
        if(bfloor>ffloor) rw.lower=wall_style(side->lower,(side->flags&16)?fceil:bfloor,side->y);
    }
    rw.top_ptr=cliptop+start;rw.bottom_ptr=clipbottom+start;
    rw.draw_upper=(uint8_t)(bceil<fceil && !skyportal);rw.draw_lower=(uint8_t)(bfloor>ffloor);
    rw.fill_base=player.texture_planes?planes:framebuffer;
    rw.ceil_color=player.texture_planes?(uint8_t)(fs|128):plane_colors[fs+NUM_SECTORS];
    rw.floor_color=player.texture_planes?(uint8_t)fs:plane_colors[fs];
    rw.stride=(uint8_t)render_detail;
    render_columns();
}

__attribute__((noinline)) bool d84_bbox_visible(const int16_t *box,unsigned boxindex) {
    /* Doom bbox order: top, bottom, left, right. Conservative near-plane
     * handling avoids dropping geometry when the camera intersects a box. */
    /* Doom's silhouette-corner table needs only two transformed corners. */
    static const uint8_t corners[12][2]={{2,1},{2,0},{3,0},{0,0},{0,1},{0,0},{3,2},{0,0},{0,3},{1,3},{1,2},{0,0}};
    uint8_t pos=(camx<=box[2]?0:camx<box[3]?1:2)+(camy>=box[0]?0:camy>box[1]?4:8);
    if(pos==5) return true;
    const uint16_t *points=box_points[boxindex];
    unsigned v1=points[corners[pos][0]],v2=points[corners[pos][1]];
    int r1,z1,r2,z2;vertex(v1,&r1,&z1);vertex(v2,&r2,&z2);
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

#ifdef __TICE__
const uint16_t *d84_node_offsets=node_offsets;
__attribute__((noinline)) unsigned d84_node_side_camera(const Node *n) {return node_side(camx,camy,n);}
void d84_bsp(unsigned index,unsigned depth);
#define bsp d84_bsp
#else
static void bsp(unsigned index,unsigned depth) {
    if (depth>render_stats.bsp_depth) render_stats.bsp_depth=(uint8_t)depth;
    if (index&0x8000u) {
        const Subsector *sub=&subsectors[index&0x7fffu];
        ++render_stats.subsectors;
        const Seg *seg=segs+sub->first;const Material *side=materials+sub->first;
        for (unsigned i=sub->count;i;--i,++seg,++side) d84_draw_seg(seg,side);
        return;
    }
    const Node *n=(const Node *)((const uint8_t *)nodes+node_offsets[(uint8_t)index]);
    unsigned side=node_side(camx,camy,n);
    bsp(n->child[side],depth+1);
    if (d84_bbox_visible(n->bbox[side^1],index*2+(side^1))) bsp(n->child[side^1],depth+1);
}

#endif

__attribute__((noinline)) static void draw_planes(void) {
    uint8_t *pixels=framebuffer,*depths=depthbuffer;
    const uint8_t *cursor=planes;
    for (int y=0;y<VIEW_H;++y) {
        const uint8_t *row=cursor,*endrow=row+VIEW_W;
        while(cursor<endrow) {
            const uint8_t *begin=cursor;
            uint8_t plane=*cursor++;
            while(cursor<endrow && *cursor==plane) ++cursor;
            unsigned length=(unsigned)(cursor-begin);
            if(plane==255) {pixels+=length;depths+=length;continue;}
            int x=(int)(begin-row);
            ++render_stats.plane_spans;
            unsigned sector=plane&127;
            int ceiling=plane&128;
            int texture=ceiling?(*sector_at(sector)).ceiltex:(*sector_at(sector)).flat;
            if (texture==255) {
                const uint8_t *sky=images[SKY_TILE];
                for(unsigned i=0;i<length;++i) pixels[i]=sky[(y*24/VIEW_H)*32+(((player.angle>>3)+(x+(int)i)/4)&31)];
                pixels+=length;depths+=length;
                continue;
            }
            int height=ceiling?sector_ceiling[sector]:sector_floor[sector];
            int dy=CENTER-y;
            /* Integer world depth is sufficient for 32x32 flat sampling,
             * and bounds every projection multiply to native 24 bits. */
            int z=dy?(height-player.eye)*FOCAL/dy:8192;
            z=CLAMP(z,1,8192);
            const uint8_t *light=lighting(sector,z);
            const uint8_t *image=images[texture];
            if (!player.texture_planes) {
                memset(pixels,light[image[16*32+16]],length);
                memset(depths,CLAMP(z/16,1,254),length);
                pixels+=length;depths+=length;continue;
            }
            int stepx=(z*camsin)>>6,stepy=(-z*camcos)>>6;
            int wx=(int)player.x+z*camcos+stepx*(x-64);
            int wy=(int)player.y+z*camsin+stepy*(x-64);
            uint8_t depth=(uint8_t)CLAMP(z/16,1,254);
            if(render_detail==4) d84_span4(pixels,depths,image,light,length/4,wx,wy,stepx*4,stepy*4,depth);
            else if(render_detail==2) d84_span2(pixels,depths,image,light,length/2,wx,wy,stepx*2,stepy*2,depth);
            else d84_span(pixels,depths,image,light,length,wx,wy,stepx,stepy,depth);
            pixels+=length;depths+=length;
        }
    }
}

__attribute__((noinline)) static void draw_sprites(void) {
    unsigned count=0;
    for (unsigned i=0;i<NUM_ACTORS;++i) {
        if (actors[i].removed) continue;
        int dx=actors[i].x-camx,dy=actors[i].y-camy;
        d84_rotate(dx,dy);
        int z=d84_rotated[1],r=d84_rotated[0];
        if (z<8 || ABS(r)>z+64) continue;
        sprite_z[i]=(int16_t)z;sprite_x[i]=(int16_t)r;
        unsigned j=count;
        while (j && sprite_z[sprite_order[j-1]]<z) {sprite_order[j]=sprite_order[j-1];--j;}
        sprite_order[j]=(uint8_t)i;++count;
    }
    for (unsigned k=0;k<count;++k) {
        unsigned i=sprite_order[k];
        const MapActor *m=&map_actors[i];Actor *a=&actors[i];
        int z=sprite_z[i],center=64+(int)sprite_x[i]*FOCAL/z;
        int width=MAX(1,(int)m->width*FOCAL/z);
        int height=MAX(1,(int)m->height*FOCAL/z);
        bool corpse=m->hp && !a->hp;
        if (corpse) height=MAX(1,height/4);
        int left=center-width/2,bottom=project(sector_floor[a->sector],z),top=bottom-height;
        unsigned image=corpse?m->death:((player.ticks&8)?m->walk:m->image);
        const uint8_t *pixels=images[image],*light=lighting(a->sector,z);
        uint8_t depth=(uint8_t)CLAMP(z/16,1,254);
        int x1=MAX(0,left),x2=MIN(VIEW_W,left+width),y1=MAX(0,top),y2=MIN(VIEW_H,bottom);
        unsigned sxstep=(64u*256)/width,systep=(64u*256)/height;
        if(render_detail>1) x1=(x1+(int)render_detail-1)&~((int)render_detail-1);
        if(x1>=x2 || y1>=y2) continue;
        unsigned count=(unsigned)(x2-x1+(int)render_detail-1)/render_detail;
        unsigned sxpos=(unsigned)(x1-left)*sxstep;
        unsigned sypos=(unsigned)(y1-top)*systep;
        unsigned offset=(unsigned)(y1*VIEW_W+x1);
        for (int y=y1;y<y2;++y,sypos+=systep,offset+=VIEW_W) {
            unsigned sy=MIN(63,sypos>>8);
            d84_sprite(framebuffer+offset,depthbuffer+offset,pixels+sy*64,light,count,sxpos,sxstep*render_detail,depth,render_detail);
        }
    }
}

void engine_render(void) {
    memset(&render_stats,0,sizeof(render_stats));
    memset(framebuffer,0,sizeof(framebuffer));
    memset(depthbuffer,255,sizeof(depthbuffer));
    if(player.texture_planes) memset(planes,255,sizeof(planes));
    memset(cliptop,0,sizeof(cliptop));
    memset(clipbottom,VIEW_H,sizeof(clipbottom));
    frame_stamp+=2;
    if (!frame_stamp) {memset(vertex_stamp,0,sizeof(vertex_stamp));frame_stamp=2;}
    camx=(int)(player.x/256);camy=(int)(player.y/256);
    camcos=icos(player.angle);camsin=isin(player.angle);
#ifdef __TICE__
    d84_set_camera();
#endif
    bsp(NUM_NODES-1,0);
    if(player.texture_planes) {
        if(render_detail==4) d84_quad_columns(planes,VIEW_W*VIEW_H/4);
        else if(render_detail==2) d84_double_columns(planes,VIEW_W*VIEW_H/2);
        draw_planes();
    }
    draw_sprites();
    if(render_detail==4) d84_quad_columns(framebuffer,VIEW_W*VIEW_H/4);
    else if(render_detail==2) d84_double_columns(framebuffer,VIEW_W*VIEW_H/2);
    /* Pistol frame from remaining fire tics: A / B / C / B, plus muzzle flash. */
    unsigned frame=0;
    if (player.fire) {
        if (player.fire>PISTOL_FIRE_AT) frame=0;
        else if (player.fire>9) frame=1;
        else if (player.fire>5) frame=2;
        else frame=1;
    }
    const uint8_t *gun=gun_frames[frame];
    int bob=player.fire?0:(isin(player.ticks*16)/128);
    for (int y=0;y<GUN_H;++y) {
        int dest=GUN_Y+y+bob;
        if (dest<0 || dest>=VIEW_H) continue;
        for (int x=0;x<GUN_W;++x) {
            uint8_t pixel=gun[y*GUN_W+x];
            if (pixel!=255) framebuffer[dest*VIEW_W+GUN_X+x]=pixel;
        }
    }
    if (player.fire && player.fire<=PISTOL_FIRE_AT && player.fire>9) {
        for (int y=0;y<GUN_H;++y) {
            int dest=GUN_Y+y+bob;
            if (dest<0 || dest>=VIEW_H) continue;
            for (int x=0;x<GUN_W;++x) {
                uint8_t pixel=gun_flash[y*GUN_W+x];
                if (pixel!=255) framebuffer[dest*VIEW_W+GUN_X+x]=pixel;
            }
        }
    }
    /* Subtle crosshair uses palette entry 4 (near-white in Doom PLAYPAL). */
    framebuffer[39*VIEW_W+64]=4;
    framebuffer[41*VIEW_W+64]=4;
    framebuffer[40*VIEW_W+63]=4;
    framebuffer[40*VIEW_W+65]=4;
}
