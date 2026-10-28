/* Native SDL2 play loop — same integer engine as the CE build. */
#include "engine.h"
#include "generated.h"
#include <SDL.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SCALE 4
#define WIN_W (VIEW_W*SCALE)
#define WIN_H (VIEW_H*SCALE)

static uint8_t *read_file(const char *path,unsigned *size) {
    FILE *f=fopen(path,"rb");
    if(!f) {perror(path);exit(1);}
    fseek(f,0,SEEK_END);long length=ftell(f);rewind(f);
    uint8_t *p=malloc((size_t)length);
    if(!p || fread(p,1,(size_t)length,f)!=(size_t)length) exit(1);
    fclose(f);*size=(unsigned)length;return p;
}

static uint8_t poll_input(const Uint8 *keys) {
    uint8_t result=0;
    if(keys[SDL_SCANCODE_UP] || keys[SDL_SCANCODE_W]) result|=INPUT_FORWARD;
    if(keys[SDL_SCANCODE_DOWN] || keys[SDL_SCANCODE_S]) result|=INPUT_BACK;
    if(keys[SDL_SCANCODE_LEFT] || keys[SDL_SCANCODE_A]) result|=INPUT_LEFT;
    if(keys[SDL_SCANCODE_RIGHT] || keys[SDL_SCANCODE_D]) result|=INPUT_RIGHT;
    if(keys[SDL_SCANCODE_LCTRL] || keys[SDL_SCANCODE_RCTRL] || keys[SDL_SCANCODE_Z]) result|=INPUT_FIRE;
    if(keys[SDL_SCANCODE_SPACE] || keys[SDL_SCANCODE_E]) result|=INPUT_USE;
    if(keys[SDL_SCANCODE_LSHIFT] || keys[SDL_SCANCODE_RSHIFT]) result|=INPUT_RUN;
    if(keys[SDL_SCANCODE_LALT] || keys[SDL_SCANCODE_RALT]) result|=INPUT_STRAFE;
    return result;
}

int main(int argc,char **argv) {
    (void)argc;(void)argv;
    unsigned length,sizes[NUM_BANKS];
    uint8_t *map=read_file("build/D84MAP.bin",&length);
    const uint8_t *banks[NUM_BANKS];
    for(unsigned i=0;i<NUM_BANKS;++i) {
        char name[64];snprintf(name,sizeof(name),"build/D84T%u.bin",i);
        banks[i]=read_file(name,&sizes[i]);
    }
    if(!engine_init(map,length,banks,sizes)) {
        fprintf(stderr,"engine_init failed (rebuild assets?)\n");
        return 1;
    }
    render_detail=2;
    player.texture_planes=false;

    if(SDL_Init(SDL_INIT_VIDEO|SDL_INIT_TIMER)!=0) {
        fprintf(stderr,"SDL_Init: %s\n",SDL_GetError());
        return 1;
    }
    SDL_Window *win=SDL_CreateWindow("doom84 E1M1",
        SDL_WINDOWPOS_CENTERED,SDL_WINDOWPOS_CENTERED,WIN_W,WIN_H,0);
    SDL_Renderer *ren=SDL_CreateRenderer(win,-1,SDL_RENDERER_ACCELERATED);
    SDL_Texture *tex=SDL_CreateTexture(ren,SDL_PIXELFORMAT_RGB24,
        SDL_TEXTUREACCESS_STREAMING,VIEW_W,VIEW_H);
    if(!win || !ren || !tex) {
        fprintf(stderr,"SDL window: %s\n",SDL_GetError());
        return 1;
    }
    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY,"0");
    SDL_RenderSetLogicalSize(ren,VIEW_W,VIEW_H);

    printf("Arrows/WASD move  Ctrl/Z fire  Space/E use  Shift run  Alt strafe\n");
    printf("T cycle FAST/TEX/WIRE  R detail  Tab pause  Esc quit\n");
    fflush(stdout);

    bool running=true,paused=false;
    Uint32 last=SDL_GetTicks(),acc=0;
    while(running) {
        SDL_Event ev;
        while(SDL_PollEvent(&ev)) {
            if(ev.type==SDL_QUIT) running=false;
            if(ev.type==SDL_KEYDOWN) {
                SDL_Keycode k=ev.key.keysym.sym;
                if(k==SDLK_ESCAPE) running=false;
                if(k==SDLK_TAB) paused=!paused;
                if(k==SDLK_t) {
                    if(player.wireframe) {player.wireframe=false;player.texture_planes=false;}
                    else if(!player.texture_planes) player.texture_planes=true;
                    else {player.texture_planes=false;player.wireframe=true;}
                }
                if(k==SDLK_r) render_detail=render_detail==2?4:render_detail==4?1:2;
                if(k==SDLK_F5) {
                    bool tex=player.texture_planes,wire=player.wireframe;
                    unsigned d=render_detail;
                    engine_reset();
                    player.texture_planes=tex;player.wireframe=wire;render_detail=d;
                }
            }
        }
        Uint32 now=SDL_GetTicks(),elapsed=now-last;last=now;
        acc+=elapsed;
        if(acc>6*(1000/35)) acc=6*(1000/35);
        const Uint8 *keys=SDL_GetKeyboardState(NULL);
        uint8_t input=poll_input(keys);
        while(acc>=1000/35) {
            if(!paused) engine_tick(input);
            acc-=1000/35;
        }
        engine_render();

        void *pixels;int pitch;
        SDL_LockTexture(tex,&(SDL_Rect){0,0,VIEW_W,VIEW_H},&pixels,&pitch);
        uint8_t *dst=pixels;
        for(int y=0;y<VIEW_H;++y) {
            uint8_t *row=dst+y*pitch;
            for(int x=0;x<VIEW_W;++x) {
                const uint8_t *c=map_palette+framebuffer[y*VIEW_W+x]*3;
                row[x*3]=c[0];row[x*3+1]=c[1];row[x*3+2]=c[2];
            }
        }
        SDL_UnlockTexture(tex);
        SDL_SetRenderDrawColor(ren,0,0,0,255);
        SDL_RenderClear(ren);
        SDL_RenderCopy(ren,tex,NULL,NULL);
        SDL_RenderPresent(ren);

        char title[96];
        snprintf(title,sizeof(title),"doom84 %s d%u%s",
                 player.wireframe?"WIRE":player.texture_planes?"TEX":"FAST",
                 render_detail,paused?" PAUSED":"");
        SDL_SetWindowTitle(win,title);
        SDL_Delay(1);
    }
    SDL_DestroyTexture(tex);
    SDL_DestroyRenderer(ren);
    SDL_DestroyWindow(win);
    SDL_Quit();
    free(map);
    for(unsigned i=0;i<NUM_BANKS;++i) free((void *)banks[i]);
    return 0;
}
