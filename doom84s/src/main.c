#include "engine.h"
#include "generated.h"
#ifdef __TICE__
#include "usb_hud.h"
#else
#include "hud.h"
#endif
#include "sound.h"
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
    if(kb_Data[1]&kb_2nd) result|=INPUT_FIRE;
    if(kb_Data[2]&kb_Math) result|=INPUT_USE;
    if(kb_Data[2]&kb_Alpha) result|=INPUT_RUN;
    return result;
}

static void text(const char *s,int x,int y) {gfx_PrintStringXY(s,x,y);}

static void blit_trans(const uint8_t *src,int dx,int dy,int w,int h,int stride) {
    for(int row=0;row<h;++row) {
        uint8_t *dst=gfx_vbuffer[dy+row]+dx;
        const uint8_t *line=src+row*stride;
        for(int x=0;x<w;++x) if(line[x]!=255) dst[x]=line[x];
    }
}

/* Doom ST_* big numbers are right-aligned to the given x. */
static void draw_stt(int value,int x,int y,bool percent) {
    char buf[8];
    int n=0;
    if(value<0) value=0;
    if(value>999) value=999;
    if(value>=100) buf[n++]=(char)('0'+value/100);
    if(value>=10) buf[n++]=(char)('0'+(value/10)%10);
    buf[n++]=(char)('0'+value%10);
    if(percent) buf[n++]='%';
    for(int i=n-1;i>=0;--i) {
        int digit=buf[i]=='%'?10:buf[i]-'0';
        int w=stt_w[digit];
        x-=w;
        blit_trans(stt_digits[digit],x,y,w,STT_H,STT_W);
    }
}

static void draw_sty(int value,int x,int y) {
    char buf[4];
    int n=0;
    if(value<0) value=0;
    if(value>999) value=999;
    if(value>=100) buf[n++]=(char)('0'+value/100);
    if(value>=10) buf[n++]=(char)('0'+(value/10)%10);
    buf[n++]=(char)('0'+value%10);
    for(int i=n-1;i>=0;--i) {
        int digit=buf[i]-'0';
        int w=sty_w[digit];
        x-=w;
        blit_trans(sty_digits[digit],x,y,w,STY_H,STY_W);
    }
}

static unsigned face_index(void) {
    if(player.dead) return 5;
    if(player.damage) return 6;
    int health=player.health;
    if(health>100) health=100;
    unsigned pain=(health<=0)?4:(unsigned)((100-health)*5/100);
    if(pain>4) pain=4;
    return pain;
}

static void draw_status(int y) {
    /* STBAR is 320px wide; gfx_sprite_t only stores 8-bit dimensions. */
    for(int row=0;row<STBAR_H;++row)
        memcpy(gfx_vbuffer[y+row],stbar+row*STBAR_W,STBAR_W);

    draw_stt(player.ammo,ST_AMMO_X,y+ST_NUM_Y,false);
    draw_stt(player.health,ST_HEALTH_X,y+ST_NUM_Y,true);
    draw_stt(player.armor,ST_ARMOR_X,y+ST_NUM_Y,true);

    blit_trans(st_faces[face_index()],ST_FACE_X,y+ST_FACE_Y,FACE_W,FACE_H,FACE_W);

    /* Current / max ammo on the right; only bullets are tracked in-sim. */
    draw_sty(player.ammo,ST_AMMO0_X,y+ST_AMMO0_Y);
    draw_sty(200,ST_MAXAMMO0_X,y+ST_AMMO0_Y);
    draw_sty(0,ST_AMMO0_X,y+ST_AMMO1_Y);
    draw_sty(50,ST_MAXAMMO0_X,y+ST_AMMO1_Y);
    draw_sty(0,ST_AMMO0_X,y+ST_AMMO2_Y);
    draw_sty(50,ST_MAXAMMO0_X,y+ST_AMMO2_Y);
    draw_sty(0,ST_AMMO0_X,y+ST_AMMO3_Y);
    draw_sty(300,ST_MAXAMMO0_X,y+ST_AMMO3_Y);
}

/* Doom-like on 320×240: full-width 320×200 view + STBAR (8px top for FPS). */
#define VIEW_Y 8
#define VIEW_H_DST 200
#define STBAR_Y 208

static void automap(void) {
    gfx_SetClipRegion(0,VIEW_Y,320,VIEW_Y+VIEW_H_DST);
    gfx_SetColor(0);gfx_FillRectangle_NoClip(0,VIEW_Y,320,VIEW_H_DST);
    int px=(int)(player.x/256),py=(int)(player.y/256);
    int cx=160,cy=VIEW_Y+VIEW_H_DST/2;
    for(unsigned i=0;i<NUM_LINES;++i) {
        const Line *l=&map_lines[i];
        const Vertex *a=&map_vertices[l->v1],*b=&map_vertices[l->v2];
        gfx_SetColor(l->side[1]==65535u?176:96);
        gfx_Line(cx+(a->x-px)/16,cy-(a->y-py)/16,cx+(b->x-px)/16,cy-(b->y-py)/16);
    }
    gfx_SetColor(4);gfx_FillCircle(cx,cy,2);
    int c=sine_table[(player.angle+256)&1023],s=sine_table[player.angle&1023];
    gfx_Line(cx,cy,cx+c/32,cy-s/32);
    gfx_SetClipRegion(0,0,320,240);
}

int main(void) {
    unsigned map_length=0;
    const uint8_t *map=open_asset("D84MAP",MAP_SIZE,&map_length);
    unsigned ui_length=0;
    d84_ui_data=open_asset("D84UI",23141,&ui_length);
    unsigned sound_length=0;
    bool valid=map!=NULL && d84_ui_data!=NULL && open_asset("D84SFX",34134,&sound_length)!=NULL;
    for(unsigned i=0;i<NUM_BANKS;++i) {
        char name[]="D84T0";name[4]=(char)('0'+i);
        banks[i]=open_asset(name,bank_sizes[i],&bank_lengths[i]);
        if(!banks[i]) valid=false;
    }
    if(valid)valid=d84_music_open()!=0;
    if(!valid || !engine_init(map,map_length,banks,bank_lengths)) {
        os_ClrHome();
        os_PutStrFull("Doom assets missing,");os_NewLine();
        os_PutStrFull("unarchived or outdated.");os_NewLine();
        os_PutStrFull("Send ALL D84*.8xv");os_NewLine();
        os_PutStrFull("files to Archive.");os_NewLine();
        os_PutStrFull("Press any key.");
        while(!os_GetCSC());
        return 1;
    }
    d84_audio_start();
    gfx_Begin();
    render_detail=2;player.texture_planes=false;
    for(unsigned i=0;i<256;++i) gfx_palette[i]=gfx_RGBTo1555(map_palette[i*3],map_palette[i*3+1],map_palette[i*3+2]);
    gfx_SetDrawBuffer();
    gfx_SetTextFGColor(4);gfx_SetTextBGColor(0);gfx_SetTextTransparentColor(0);
    for(unsigned i=0;i<2;++i) {
        gfx_FillScreen(0);
        draw_status(STBAR_Y);
        gfx_SwapDraw();
    }
    bool showmap=false,flatheld=false,mapheld=false,resetheld=false,paused=false,pauseheld=false,detailheld=false;
    clock_t last=clock(),accumulator=0,fps_start=last;
    unsigned frames=0,fps=0,render_ms=0;
    int hud_health=-1,hud_armor=-1,hud_ammo=-1;unsigned hud_face=999,hud_dirty=0;
    for(;;) {
        d84_audio_poll();
        kb_Scan();
        if(kb_Data[6]&kb_Clear) break;
        bool mapkey=(kb_Data[1]&kb_Graph)!=0;
        if(mapkey && !mapheld) showmap=!showmap;
        mapheld=mapkey;
        bool flatkey=(kb_Data[1]&kb_Window)!=0;
        /* Window cycles FAST (flat) -> TEXTURED -> WIRE (edge-only). */
        if(flatkey && !flatheld) {
            if(player.wireframe) {player.wireframe=false;player.texture_planes=false;}
            else if(!player.texture_planes) player.texture_planes=true;
            else {player.texture_planes=false;player.wireframe=true;}
        }
        flatheld=flatkey;
        bool detailkey=(kb_Data[1]&kb_Trace)!=0;
        /* 64 → ~43 (every 3rd) → 32 → 128 → 64 */
        if(detailkey && !detailheld)
            render_detail=render_detail==2?3:render_detail==3?4:render_detail==4?1:2;
        detailheld=detailkey;
        bool resetkey=(kb_Data[1]&kb_Zoom)!=0;
        if(resetkey && !resetheld) {
            bool textured=player.texture_planes,wire=player.wireframe;
            engine_reset();
            player.texture_planes=textured;player.wireframe=wire;
        }
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
        gfx_FillRectangle_NoClip(0,0,320,VIEW_Y);
        sound_frame_step();
        if(showmap) automap();
        else {
#ifdef __TICE__
            d84_blit_viewport(engine_view.pixels,(uint8_t *)gfx_vbuffer+VIEW_Y*320);
#else
            gfx_ScaledSprite_NoClip((const gfx_sprite_t *)&engine_view,32,VIEW_Y,2,2);
#endif
        }
        /* STBAR only when stats change; dirty=2 covers both LCD buffers. */
        unsigned face=face_index();
        if(player.health!=hud_health || player.armor!=hud_armor || player.ammo!=hud_ammo || face!=hud_face) {
            hud_health=player.health;hud_armor=player.armor;hud_ammo=player.ammo;hud_face=face;hud_dirty=2;
        }
        if(hud_dirty) {draw_status(STBAR_Y);--hud_dirty;}
        char line[40];
        snprintf(line,sizeof(line),"E1M1 %uFPS %ums %s",fps,render_ms,
                 player.wireframe?"WIRE":player.texture_planes?"TEX":"FAST");
        text(line,4,198);
        if(paused) text("PAUSED",136,VIEW_Y+90);
        if(player.dead) text("YOU DIED - ZOOM RESTART",64,VIEW_Y+90);
        if(player.exited) text("E1M1 EXIT - ZOOM RESTART",64,VIEW_Y+90);
        if(player.damage) {gfx_SetColor(176);gfx_Rectangle_NoClip(0,VIEW_Y,320,VIEW_H_DST);}
        gfx_SwapDraw();
        ++frames;
        if(clock()-fps_start>=CLOCKS_PER_SEC) {clock_t duration=clock()-fps_start;fps=(unsigned)((uint32_t)frames*CLOCKS_PER_SEC/duration);frames=0;fps_start=clock();}
    }
    d84_audio_stop();
    gfx_End();
    return 0;
}
