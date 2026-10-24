/* Native harness executes the very same integer C engine as the CE build. */
#include "engine.h"
#include "generated.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

static unsigned checks;
static bool hash_frames;
static uint64_t frame_hash=14695981039346656037ull;
static void render_frame(void) {
    engine_render();
    if(hash_frames) for(unsigned i=0;i<VIEW_W*VIEW_H;++i) {frame_hash^=framebuffer[i];frame_hash*=1099511628211ull;}
}
#define CHECK(expr) do {++checks;if(!(expr)){fprintf(stderr,"FAIL %s:%d: %s\n",__FILE__,__LINE__,#expr);exit(1);}}while(0)

static uint8_t *read_file(const char *path,unsigned *size) {
    FILE *f=fopen(path,"rb");
    if(!f) {perror(path);exit(1);}
    fseek(f,0,SEEK_END);long length=ftell(f);rewind(f);
    uint8_t *p=malloc((size_t)length);
    if(!p || fread(p,1,(size_t)length,f)!=(size_t)length) exit(1);
    fclose(f);*size=(unsigned)length;return p;
}

static void screenshot(const char *path) {
    render_frame();
    FILE *f=fopen(path,"wb");if(!f){perror(path);exit(1);}
    fprintf(f,"P6\n128 80\n255\n");
    for(unsigned i=0;i<VIEW_W*VIEW_H;++i) fwrite(map_palette+framebuffer[i]*3,1,3,f);
    fclose(f);
    printf("%s: pos %ld,%ld sector %u eye %d; %u segs, %u subsectors, %u columns, %u plane spans, BSP depth %u\n",path,(long)(player.x/256),(long)(player.y/256),player.sector,player.eye,render_stats.segs,render_stats.subsectors,render_stats.wall_columns,render_stats.plane_spans,render_stats.bsp_depth);
}

static void pose(int x,int y,unsigned angle) {
    player.x=(int32_t)x*256;player.y=(int32_t)y*256;
    player.sector=engine_sector(x,y);player.floor=map_sectors[player.sector].floor;player.eye=player.floor+41;player.angle=angle;
}

static void pose_sector(unsigned sector) {
    for(unsigned i=0;i<NUM_LINES;++i) {
        const Line *l=&map_lines[i];
        const Vertex *a=&map_vertices[l->v1],*b=&map_vertices[l->v2];
        int dx=b->x-a->x,dy=b->y-a->y;
        double length=hypot(dx,dy);if(!length) continue;
        for(int sign=-1;sign<=1;sign+=2) {
            int x=(a->x+b->x)/2+(int)(sign*dy*8/length),y=(a->y+b->y)/2-(int)(sign*dx*8/length);
            if(engine_sector(x,y)==sector) {pose(x,y,0);return;}
        }
    }
    CHECK(!"No sample found in sector");
}

static void tests(void) {
    CHECK(player.x/256==START_X && player.y/256==START_Y);
    CHECK(player.sector<NUM_SECTORS);
    CHECK(engine_can_move(START_X,START_Y,player.floor));
    /* For subsectors with at least three boundary segs, their averaged
     * vertices give an interior sample. One/two-seg leaves have implicit
     * BSP boundaries, so that average lies on an edge and is unsuitable. */
    unsigned map_size;uint8_t *map=read_file("build/D84MAP.bin",&map_size);
    const Seg *segs=(const Seg *)(map+OFF_SEGS);
    const Side *sides=(const Side *)(map+OFF_SIDES);
    const Subsector *subs=(const Subsector *)(map+OFF_SUBSECTORS);
    /* Both walk-over specials must affect the sectors named by their tags,
     * even though those sectors are away from the triggering line. */
    for(unsigned trigger=0;trigger<NUM_WALK_TRIGGERS;++trigger) {
        engine_reset();
        const Line *l=&map_lines[walk_triggers[trigger]];
        const Vertex *a=&map_vertices[l->v1],*b=&map_vertices[l->v2];
        int dx=b->x-a->x,dy=b->y-a->y;
        double length=hypot(dx,dy);
        int x=(a->x+b->x)/2+(int)(dy*40/length),y=(a->y+b->y)/2-(int)(dx*40/length);
        pose(x,y,(unsigned)(int)lround(atan2(dx,-dy)*1024/(2*3.141592653589793))&1023);
        for(unsigned tic=0;tic<40;++tic) engine_tick(INPUT_FORWARD);
        unsigned target=0;
        while(target<NUM_SECTORS && map_sectors[target].tag!=l->tag) ++target;
        CHECK(target<NUM_SECTORS);
        pose_sector(target);engine_tick(0);
        CHECK(player.floor<map_sectors[target].floor);
        if(l->special==88) {
            for(unsigned tic=0;tic<220;++tic) {player.health=200;engine_tick(0);}
            CHECK(player.floor==map_sectors[target].floor);
        }
    }
    /* Use every real E1M1 door from its front side and verify the opening
     * becomes tall enough to traverse after the ceiling rises. */
    for(unsigned i=0;i<NUM_LINES;++i) {
        const Line *l=&map_lines[i];
        if(l->special!=1) continue;
        engine_reset();
        const Vertex *a=&map_vertices[l->v1],*b=&map_vertices[l->v2];
        int dx=b->x-a->x,dy=b->y-a->y;
        double length=hypot(dx,dy);
        int mx=(a->x+b->x)/2,my=(a->y+b->y)/2;
        int x=mx+(int)(dy*40/length),y=my-(int)(dx*40/length);
        player.x=(int32_t)x*256;player.y=(int32_t)y*256;
        player.sector=engine_sector(x,y);player.floor=map_sectors[player.sector].floor;player.eye=player.floor+41;
        player.angle=(unsigned)(int)lround(atan2(dx,-dy)*1024/(2*3.141592653589793))&1023;
        CHECK(!engine_can_move(mx,my,player.floor));
        engine_tick(INPUT_USE);
        for(unsigned tic=0;tic<65;++tic) engine_tick(0);
        CHECK(engine_can_move(mx,my,player.floor));
    }
    /* The exit switch is the actual special-11 linedef. */
    engine_reset();player.x=2952L*256;player.y=-4768L*256;
    player.sector=engine_sector(2952,-4768);player.floor=map_sectors[player.sector].floor;player.eye=player.floor+41;player.angle=512;
    engine_tick(INPUT_USE);CHECK(player.exited);
    engine_reset();
    for(unsigned i=0;i<NUM_SUBSECTORS;++i) {
        if(subs[i].count<3) continue;
        int32_t x=0,y=0;
        for(unsigned j=0;j<subs[i].count;++j) {
            const Vertex *v=&map_vertices[segs[subs[i].first+j].v1];x+=v->x;y+=v->y;
        }
        unsigned expected=sides[map_lines[segs[subs[i].first].line].side[segs[subs[i].first].side]].sector;
        CHECK(engine_sector(x/subs[i].count,y/subs[i].count)==expected);
    }
    /* Full rotation and long walk exercise clipping, stamps and collision. */
    for(unsigned i=0;i<1024;i+=8) {
        player.angle=i;render_frame();
        CHECK(render_stats.segs>0);
        CHECK(render_stats.bsp_depth<32);
    }
    engine_reset();
    for(unsigned i=0;i<400;++i) {
        engine_tick(INPUT_FORWARD);
        CHECK(engine_can_move(player.x/256,player.y/256,player.floor));
    }
    /* Deterministic stress across all map sectors and all view directions. */
    unsigned frames=0;
    for(unsigned i=0;i<NUM_SUBSECTORS;i+=3) {
        int32_t x=0,y=0;
        for(unsigned j=0;j<subs[i].count;++j) {
            const Vertex *v=&map_vertices[segs[subs[i].first+j].v1];x+=v->x;y+=v->y;
        }
        x/=subs[i].count;y/=subs[i].count;
        player.x=x*256;player.y=y*256;player.sector=engine_sector(x,y);
        player.floor=map_sectors[player.sector].floor;player.eye=player.floor+41;
        for(unsigned detail=1;detail<=4;detail*=2) for(unsigned textured=0;textured<=1;++textured) {
            render_detail=detail;player.texture_planes=textured!=0;
            for(unsigned angle=0;angle<1024;angle+=128) {player.angle=angle;render_frame();++frames;}
        }
    }
    render_detail=1;
    engine_reset();
    for(unsigned i=0;i<500;++i) engine_tick((i%100<50?INPUT_FORWARD:INPUT_RIGHT)|INPUT_FIRE|((i%35==0)?INPUT_USE:0));
    CHECK(player.health>=0 && player.health<=200);
    CHECK(player.ammo>=0 && player.ammo<=200);
    CHECK(player.kills<=player.total);
    free(map);
    printf("PASS: %u checks; %u sector/direction stress frames\n",checks,frames);
}

int main(int argc,char **argv) {
    hash_frames=getenv("D84_HASH_FRAMES")!=NULL;
    unsigned length,sizes[NUM_BANKS];
    uint8_t *map=read_file("build/D84MAP.bin",&length);
    const uint8_t *banks[NUM_BANKS];
    for(unsigned i=0;i<NUM_BANKS;++i) {
        char name[64];snprintf(name,sizeof(name),"build/D84T%u.bin",i);
        banks[i]=read_file(name,&sizes[i]);
    }
    CHECK(engine_init(map,length,banks,sizes));
    CHECK(!engine_init(map,length-1,banks,sizes));
    map[8]^=1;CHECK(!engine_init(map,length,banks,sizes));map[8]^=1;
    CHECK(engine_init(map,length,banks,sizes));
    if(argc>1 && !strcmp(argv[1],"--test")) tests();
    else {
        if(argc>=6) {player.x=strtol(argv[3],NULL,10)*256;player.y=strtol(argv[4],NULL,10)*256;player.angle=(unsigned)strtol(argv[5],NULL,10);player.sector=engine_sector(player.x/256,player.y/256);player.floor=map_sectors[player.sector].floor;player.eye=player.floor+41;}
        if(argc>=7) player.texture_planes=strtol(argv[6],NULL,10)!=0;
        if(argc>=8) render_detail=(unsigned)strtol(argv[7],NULL,10);
        screenshot(argc>2?argv[2]:"build/preview.ppm");
    }
    free(map);for(unsigned i=0;i<NUM_BANKS;++i) free((void *)banks[i]);
    if(hash_frames) printf("Frame hash: %llx\n",(unsigned long long)frame_hash);
    return 0;
}
