#ifndef D84_ENGINE_H
#define D84_ENGINE_H
#include <stdbool.h>
#include <stdint.h>

#define VIEW_W 128
#define VIEW_H 80
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

extern Player player;
extern RenderStats render_stats;
extern unsigned render_detail; /* 1:128x80; 2:64x80; 4:32x80; framebuffer remains 128x80 */
typedef struct {uint8_t width,height,pixels[VIEW_W*VIEW_H];} View;
extern View engine_view;
#define framebuffer (engine_view.pixels)
extern const Vertex *map_vertices;
extern const Line *map_lines;
extern const Sector *map_sectors;
extern const uint8_t *map_palette;

bool engine_init(const uint8_t *map, unsigned map_size,
                 const uint8_t *const *banks, const unsigned *sizes);
void engine_reset(void);
void engine_tick(uint8_t input);
void engine_render(void);
uint8_t engine_sector(int x,int y);
bool engine_can_move(int x,int y,int floor);
void d84_blit_viewport(const uint8_t *src, uint8_t *dest);
#endif
