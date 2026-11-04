#ifndef DOOMDEF_H
#define DOOMDEF_H

#include <stdbool.h>
#include <stdint.h>

#define VIEW_W 128
#define VIEW_H 80
#define FOCAL 64
#define CENTER 40
#define NEAR_Z 4

#ifndef D84_FRUSTUM_CULL
#define D84_FRUSTUM_CULL 1
#endif

#define INPUT_FORWARD 1
#define INPUT_BACK 2
#define INPUT_LEFT 4
#define INPUT_RIGHT 8
#define INPUT_STRAFE 16
#define INPUT_FIRE 32
#define INPUT_USE 64
#define INPUT_RUN 128

/* All serialized structures use explicit widths: eZ80 int is 24 bits. */
typedef struct __attribute__((packed)) { int16_t x,y; } Vertex;
typedef struct __attribute__((packed)) { uint16_t v1,v2,flags,special,tag,side[2]; } Line;
typedef struct __attribute__((packed)) { int16_t x,y; uint8_t upper,lower,middle,sector; } Side;
typedef struct __attribute__((packed)) { int16_t floor,ceiling; uint8_t flat,ceiltex,light,special,tag,pad; } Sector;
typedef struct __attribute__((packed)) { uint16_t v1,v2,angle,line,side,offset,length; } Seg;
typedef struct __attribute__((packed)) { uint16_t count,first; } Subsector;
typedef struct __attribute__((packed)) { int16_t x,y,dx,dy,bbox[2][4]; uint16_t child[2]; } Node;
typedef struct __attribute__((packed)) { int16_t x,y; uint16_t type; uint8_t image,walk,death,width,height,hp,kind,pad; } MapActor;

_Static_assert(sizeof(Vertex)==4,"Vertex disk layout");
_Static_assert(sizeof(Line)==14,"Line disk layout");
_Static_assert(sizeof(Side)==8,"Side disk layout");
_Static_assert(sizeof(Sector)==10,"Sector disk layout");
_Static_assert(sizeof(Seg)==14,"Seg disk layout");
_Static_assert(sizeof(Subsector)==4,"Subsector disk layout");
_Static_assert(sizeof(Node)==28,"Node disk layout");
_Static_assert(sizeof(MapActor)==14,"Actor disk layout");

typedef struct {
    int32_t x,y; /* 24.8 world position, explicitly 32 bit on CE */
    int16_t eye,floor,health,armor,ammo;
    uint16_t angle,kills,total,ticks;
    uint8_t sector,fire,damage;
    bool exited,dead,texture_planes,wireframe;
} Player;

typedef struct {
    uint16_t segs,subsectors,wall_columns,plane_spans;
    uint8_t bsp_depth;
} RenderStats;

typedef struct {
    uint8_t width,height,pixels[VIEW_W*VIEW_H];
} View;

#endif /* DOOMDEF_H */
