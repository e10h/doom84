/* GPL-2.0-or-later. Isolated eZ80 renderer cycle test using CEmu's core.
 * No TI ROM is needed or supplied. No TI-OS or graphics-library calls run.
 * See tools/cemu_bench.py for symbol generation, build and invocation.
 */
#include "emu.h"
#include "asic.h"
#include "cpu.h"
#include "mem.h"
#include "control.h"
#include "flash.h"
#include "engine.h"
#include "generated.h"
#include "cemu_symbols.h"
#include <stddef.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>

void gui_console_clear(void) {}
void gui_console_printf(const char *format,...) {(void)format;}
void gui_console_err_printf(const char *format,...) {(void)format;}
asic_rev_t gui_handle_reset(const boot_ver_t *v,asic_rev_t l,asic_rev_t d,emu_device_t dev,bool *python) {
    (void)v;(void)l;(void)d;(void)dev;*python=false;return ASIC_REV_I;
}
static unsigned load(const char *path,unsigned address) {
    FILE *f=fopen(path,"rb");if(!f){perror(path);exit(1);}
    fseek(f,0,SEEK_END);long size=ftell(f);rewind(f);
    void *memory=phys_mem_ptr(address,(int32_t)size);
    if(!memory || fread(memory,1,(size_t)size,f)!=(size_t)size) {fprintf(stderr,"Cannot load %s\n",path);exit(1);}
    fclose(f);return (unsigned)size;
}
static void word(unsigned address,unsigned value) {mem_poke_word(address,value,true);}
static void player_word(size_t offset,int value,unsigned width) {
    for(unsigned i=0;i<width;++i) mem_poke_byte(SYM_player+(unsigned)offset+i,(uint8_t)((uint32_t)value>>(i*8)));
}
static uint32_t run(unsigned pc,const unsigned *args,unsigned count) {
    cpu_clear_signals();cpu.halted=false;
    cpu.ADL=cpu.MADL=cpu.L=cpu.IL=true;cpu.IEF1=cpu.IEF2=false;
    cpu.registers.SPL=0xD17F00;word(0xD17F00,0xD18020);
    for(unsigned i=0;i<count;++i) word(0xD17F03+i*3,args[i]);
    cpu_flush(pc,true);
    uint32_t start=cpu.cycles;
    for(unsigned i=0;i<300000;++i) {
        sched.event.next_cycle=cpu.cycles+1000;
        cpu_execute();
        if(cpu.halted) return cpu.cycles-start;
        if(cpu_check_signals() & (CPU_SIGNAL_RESET|CPU_SIGNAL_EXIT)) break;
    }
    fprintf(stderr,"Benchmark failed at PC=%06x SP=%06x\n",cpu.registers.PC,cpu.registers.SPL);exit(1);
}
static int signed16(unsigned address) {return (int16_t)((unsigned)mem_peek_byte(address)|((unsigned)mem_peek_byte(address+1)<<8));}
static unsigned reference_reciprocal(unsigned z) {unsigned shift=0;while(z>2048){z>>=1;++shift;}return (1048576u/z)>>shift;}
static unsigned check_arithmetic(void) {
    unsigned checks=0;
    const int points[][2]={{4576,-2816},{-4576,2816},{-6144,-5119},{0,0},{1,-1}};
    for(unsigned angle=0;angle<1024;++angle) {
        int c=sine_table[(angle+256)&1023],s=sine_table[angle];
        word(SYM_camcos,(unsigned)c);word(SYM_camsin,(unsigned)s);
        run(SYM_d84_set_camera,NULL,0);
        for(unsigned i=0;i<sizeof(points)/sizeof(*points);++i) {
            int x=points[i][0],y=points[i][1];unsigned args[]={(unsigned)x,(unsigned)y};
            run(SYM_d84_rotate,args,2);
            int r=(x*s-y*c)>>8,z=(x*c+y*s)>>8;
            if(signed16(SYM_d84_rotated)!=r || signed16(SYM_d84_rotated+2)!=z) {
                fprintf(stderr,"Rotation mismatch: angle %u point %d,%d\n",angle,x,y);exit(1);
            }
            ++checks;
        }
    }
    uint32_t random=0x8431993u;
    for(unsigned i=0;i<4096;++i) {
        random=random*1664525u+1013904223u;int r=(int)(random%12289)-6144;
        random=random*1664525u+1013904223u;unsigned z=4+random%8189;
        /* Include near-plane, small-table and normalization boundaries. */
        static const unsigned edges[]={4,5,16,31,32,33,255,256,2048,2049,8192};
        if(i<sizeof(edges)/sizeof(*edges)) z=edges[i];
        int64_t product=(int64_t)r*reference_reciprocal(z);
        int expected=64+(int)(product<0?-((-product+16383)/16384):product/16384);
        unsigned args[]={(unsigned)r,z};run(SYM_d84_screen_x,args,2);
        unsigned value=cpu.registers.HL;
        int actual=(int32_t)(value<<8)>>8;
        if(actual!=expected) {fprintf(stderr,"Projection mismatch: %d/%u: %d != %d\n",r,z,actual,expected);exit(1);}
        ++checks;
    }
    return checks;
}

static void screenshot(const char *path) {
    FILE *f=fopen(path,"wb");if(!f){perror(path);exit(1);}
    fprintf(f,"P6\n128 80\n255\n");
    for(unsigned i=0;i<VIEW_W*VIEW_H;++i) {
        unsigned pixel=mem_peek_byte(SYM_engine_view+2+i);
        fwrite(phys_mem_ptr(0x200000+OFF_PALETTE+pixel*3,3),1,3,f);
    }
    fclose(f);
}
int main(int argc,char **argv) {
    if(argc!=2) return 1;
    asic_init();mem.flash.size=0x400000;mem.flash.block=calloc(mem.flash.size,1);
    if(!mem.flash.block) return 1;
    asic_reset();set_cpu_clock(48000000);
    control.stackLimit=0;control.protectedStart=0;control.protectedEnd=0;
    load(argv[1],0xD1A87F);
    unsigned map_size=load("build/D84MAP.bin",0x200000);
    for(unsigned i=0;i<NUM_BANKS;++i) {
        char path[80];snprintf(path,sizeof(path),"build/D84T%u.bin",i);
        unsigned size=load(path,0x210000+i*0x10000);
        word(0xD14000+i*3,0x210000+i*0x10000);word(0xD14020+i*3,size);
    }
    mem_poke_byte(0xD18020,0x76); /* HALT return sentinel */
    unsigned args[]={0x200000,map_size,0xD14000,0xD14020};
    uint32_t init=run(SYM_engine_init,args,4);
    unsigned arithmetic_checks=check_arithmetic();
    printf("{\"kernel_checks\":%u,\"init_cycles\":%u,\"clock_hz\":48000000,\"asic\":\"I\",\"frames\":[",arithmetic_checks,init);
    const struct {const char *name;int x,y,angle,sector,floor;} scenes[]={
        {"start",START_X,START_Y,START_ANGLE,38,0},
        {"courtyard",1824,-3072,768,5,-56},
        {"later",3008,-4224,768,72,-24},
        {"start-turn",START_X,START_Y,341,38,0},
        {"yard-turn",1824,-3072,597,5,-56}
    };
    bool first=true;
    for(unsigned scene=0;scene<5;++scene) {
        player_word(offsetof(Player,x),scenes[scene].x*256,4);
        player_word(offsetof(Player,y),scenes[scene].y*256,4);
        player_word(offsetof(Player,angle),scenes[scene].angle,2);
        player_word(offsetof(Player,sector),scenes[scene].sector,1);
        player_word(offsetof(Player,floor),scenes[scene].floor,2);
        player_word(offsetof(Player,eye),scenes[scene].floor+41,2);
        for(unsigned detail=1;detail<=4;detail*=2) for(unsigned textured=0;textured<=1;++textured) {
            word(SYM_render_detail,detail);
            player_word(offsetof(Player,texture_planes),(int)textured,1);
            uint32_t cycles=run(SYM_engine_render,NULL,0);
            printf("%s{\"scene\":\"%s\",\"detail\":%u,\"textured\":%u,\"cycles\":%u,\"ms\":%.3f}",first?"":",",scenes[scene].name,detail,textured,cycles,cycles/48000.0);first=false;
            char path[128];snprintf(path,sizeof(path),"build/cemu-%s-%u-%u.ppm",scenes[scene].name,detail,textured);screenshot(path);
        }
    }
    /* Sweep camera headings in both busy views, with default quality. */
    for(unsigned base=0;base<2;++base) for(unsigned angle=0;angle<1024;angle+=64) {
        player_word(offsetof(Player,x),scenes[base].x*256,4);
        player_word(offsetof(Player,y),scenes[base].y*256,4);
        player_word(offsetof(Player,sector),scenes[base].sector,1);
        player_word(offsetof(Player,floor),scenes[base].floor,2);
        player_word(offsetof(Player,eye),scenes[base].floor+41,2);
        player_word(offsetof(Player,angle),(int)angle,2);
        word(SYM_render_detail,2);player_word(offsetof(Player,texture_planes),0,1);
        uint32_t cycles=run(SYM_engine_render,NULL,0);
        printf(",{\"scene\":\"%s\",\"angle\":%u,\"detail\":2,\"textured\":0,\"cycles\":%u,\"ms\":%.3f}",scenes[base].name,angle,cycles,cycles/48000.);
        char path[128];snprintf(path,sizeof(path),"build/cemu-%s-2-0-a%u.ppm",scenes[base].name,angle);screenshot(path);
    }
    printf("],\"simulation_samples\":[");
    for(unsigned input=0;input<2;++input) {
        run(SYM_engine_reset,NULL,0);unsigned sum=0,maximum=0;
        for(unsigned tick=0;tick<32;++tick) {
            unsigned args[]={input?INPUT_FORWARD:0};unsigned cycles=run(SYM_engine_tick,args,1);
            sum+=cycles;if(cycles>maximum)maximum=cycles;
        }
        printf("%s{\"input\":\"%s\",\"ticks\":32,\"mean_ms\":%.3f,\"max_ms\":%.3f}",input?",":"",input?"forward":"idle",sum/(32.*48000.),maximum/48000.);
    }
    printf("]}\n");asic_free();return 0;
}
