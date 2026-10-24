#include "engine.h"
#include "generated.h"
#include <fileioc.h>
#include <graphx.h>
#include <keypadc.h>
#include <tice.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

static const uint8_t *banks[NUM_BANKS];
static unsigned bank_lengths[NUM_BANKS];

static const uint8_t *open_asset(const char *name,unsigned expected,unsigned *length) {
    uint8_t handle=ti_Open(name,"r");
    if (!handle) return NULL;
    const uint8_t *data=NULL;
    *length=ti_GetSize(handle);
    /* No allocation or archive writes occur after these pointers are cached. */
    if (*length==expected && ti_IsArchived(handle)) data=ti_GetDataPtr(handle);
    ti_Close(handle);
    return data;
}

static uint8_t input(void) {
    uint8_t result=0;
    if(kb_Data[7]&kb_Up) result|=INPUT_FORWARD;
    if(kb_Data[7]&kb_Down) result|=INPUT_BACK;
    if(kb_Data[7]&kb_Left) result|=INPUT_LEFT;
    if(kb_Data[7]&kb_Right) result|=INPUT_RIGHT;
    if(kb_Data[2]&kb_Alpha) result|=INPUT_STRAFE;
    if(kb_Data[1]&kb_2nd) result|=INPUT_FIRE;
    if(kb_Data[6]&kb_Enter) result|=INPUT_USE;
    if(kb_Data[1]&kb_Mode) result|=INPUT_RUN;
    return result;
}

static void text(const char *s,int x,int y) {gfx_PrintStringXY(s,x,y);}

static void automap(void) {
    gfx_SetClipRegion(32,24,288,184);
    gfx_SetColor(0);gfx_FillRectangle_NoClip(32,24,256,160);
    int px=(int)(player.x/256),py=(int)(player.y/256);
    for(unsigned i=0;i<NUM_LINES;++i) {
        const Line *l=&map_lines[i];
        const Vertex *a=&map_vertices[l->v1],*b=&map_vertices[l->v2];
        gfx_SetColor(l->side[1]==65535u?176:96);
        gfx_Line(160+(a->x-px)/16,104-(a->y-py)/16,160+(b->x-px)/16,104-(b->y-py)/16);
    }
    gfx_SetColor(4);gfx_FillCircle(160,104,2);
    int c=sine_table[(player.angle+256)&1023],s=sine_table[player.angle&1023];
    gfx_Line(160,104,160+c/32,104-s/32);
    gfx_SetClipRegion(0,0,320,240);
}

int main(void) {
    unsigned map_length=0;
    const uint8_t *map=open_asset("D84MAP",MAP_SIZE,&map_length);
    bool valid=map!=NULL;
    for(unsigned i=0;i<NUM_BANKS;++i) {
        char name[]="D84T0";name[4]=(char)('0'+i);
        banks[i]=open_asset(name,bank_sizes[i],&bank_lengths[i]);
        if(!banks[i]) valid=false;
    }
    if(!valid || !engine_init(map,map_length,banks,bank_lengths)) {
        os_ClrHome();
        os_PutStrFull("E1M1 assets missing,");os_NewLine();
        os_PutStrFull("unarchived or outdated.");os_NewLine();
        os_PutStrFull("Send ALL D84*.8xv");os_NewLine();
        os_PutStrFull("files to Archive.");os_NewLine();
        os_PutStrFull("Press any key.");
        while(!os_GetCSC());
        return 1;
    }
    gfx_Begin();
    render_detail=2;player.texture_planes=false;
    for(unsigned i=0;i<256;++i) gfx_palette[i]=gfx_RGBTo1555(map_palette[i*3],map_palette[i*3+1],map_palette[i*3+2]);
    gfx_SetDrawBuffer();
    gfx_SetTextFGColor(4);gfx_SetTextBGColor(0);gfx_SetTextTransparentColor(0);
    /* Initialize both physical buffers once. The opaque world replaces the
     * viewport; subsequent clears only erase changing HUD text. */
    for(unsigned i=0;i<2;++i) {
        gfx_FillScreen(0);
        text("2nd FIRE  ENTER USE  ALPHA STRAFE",8,219);
        text("TRACE DETAIL  WINDOW FLATS  CLEAR EXIT",8,230);
        gfx_SwapDraw();
    }
    bool showmap=false,flatheld=false,mapheld=false,resetheld=false,paused=false,pauseheld=false,detailheld=false;
    clock_t last=clock(),accumulator=0,fps_start=last;
    unsigned frames=0,fps=0,render_ms=0;
    for(;;) {
        kb_Scan();
        if(kb_Data[6]&kb_Clear) break;
        bool mapkey=(kb_Data[1]&kb_Graph)!=0;
        if(mapkey && !mapheld) showmap=!showmap;
        mapheld=mapkey;
        bool flatkey=(kb_Data[1]&kb_Window)!=0;
        if(flatkey && !flatheld) player.texture_planes=!player.texture_planes;
        flatheld=flatkey;
        bool detailkey=(kb_Data[1]&kb_Trace)!=0;
        if(detailkey && !detailheld) render_detail=render_detail==2?4:render_detail==4?1:2;
        detailheld=detailkey;
        bool resetkey=(kb_Data[1]&kb_Zoom)!=0;
        if(resetkey && !resetheld) {bool textured=player.texture_planes;engine_reset();player.texture_planes=textured;}
        resetheld=resetkey;
        bool pausekey=(kb_Data[1]&kb_Yequ)!=0;
        if(pausekey && !pauseheld) paused=!paused;
        pauseheld=pausekey;
        clock_t now=clock(),elapsed=now-last;last=now;
        /* Limit catch-up to six 35 Hz tics. Prevents a slow frame from
         * causing a long unresponsive simulation burst. */
        accumulator+=elapsed;
        if(accumulator>CLOCKS_PER_SEC*6/35) accumulator=CLOCKS_PER_SEC*6/35;
        uint8_t keys=input();
        while(accumulator>=CLOCKS_PER_SEC/35) {
            if(!paused && !showmap) engine_tick(keys);
            accumulator-=CLOCKS_PER_SEC/35;
        }
        clock_t begin=clock();
        if(!showmap) engine_render();
        render_ms=showmap?0:(unsigned)((clock()-begin)*1000/CLOCKS_PER_SEC);
        gfx_SetColor(0);
        gfx_FillRectangle_NoClip(0,0,320,24);
        gfx_FillRectangle_NoClip(0,184,320,32);
        if(showmap) automap();
        else {
            gfx_ScaledSprite_NoClip((const gfx_sprite_t *)&engine_view,32,24,2,2);
        }
        char line[64];
        snprintf(line,sizeof(line),"E1M1  %u FPS  render %u ms",fps,render_ms);text(line,8,7);
        snprintf(line,sizeof(line),"HP %d  ARM %d  AMMO %d",player.health,player.armor,player.ammo);text(line,18,192);
        snprintf(line,sizeof(line),"%ux80 %s  K %u/%u",128/render_detail,player.texture_planes?"TEXTURED":"FAST",player.kills,player.total);text(line,18,204);
        if(paused) text("PAUSED",136,96);
        if(player.dead) text("YOU DIED - ZOOM RESTART",64,96);
        if(player.exited) text("E1M1 EXIT - ZOOM RESTART",64,96);
        if(player.damage) {gfx_SetColor(176);gfx_Rectangle_NoClip(32,24,256,160);}
        gfx_SwapDraw();
        ++frames;
        if(clock()-fps_start>=CLOCKS_PER_SEC) {clock_t duration=clock()-fps_start;fps=(unsigned)((uint32_t)frames*CLOCKS_PER_SEC/duration);frames=0;fps_start=clock();}
    }
    gfx_End();
    return 0;
}
