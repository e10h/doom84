/* ROM-free isolated eZ80 timing, using the CEmu CPU core. */
#include "emu.h"
#include "asic.h"
#include "cpu.h"
#include "mem.h"
#include "control.h"
#include "flash.h"
#include "symbols.h"

#define CHECK_CHUNKS 120

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
void gui_console_clear(void){}
void gui_console_printf(const char *f,...){(void)f;}
void gui_console_err_printf(const char *f,...){(void)f;}
asic_rev_t gui_handle_reset(const boot_ver_t*v,asic_rev_t l,asic_rev_t d,emu_device_t dev,bool*python){(void)v;(void)l;(void)d;(void)dev;*python=false;return ASIC_REV_I;}
static unsigned run(unsigned pc){cpu_clear_signals();cpu.halted=false;cpu.ADL=cpu.MADL=cpu.L=cpu.IL=true;cpu.IEF1=cpu.IEF2=false;cpu.registers.SPL=0xd17f00;mem_poke_word(0xd17f00,0xd18020,true);cpu_flush(pc,true);unsigned start=cpu.cycles;for(unsigned i=0;i<1000000;i++){sched.event.next_cycle=cpu.cycles+1000;cpu_execute();if(cpu.halted)return cpu.cycles-start;}fprintf(stderr,"Timeout PC=%06x IX=%06x SP=%06x counter=%06x\n",cpu.registers.PC,cpu.registers.IX,cpu.registers.SPL,mem_peek_word(cpu.registers.IX-19,true));exit(1);}
static void load(const char *path,unsigned address) {
    FILE *f=fopen(path,"rb");if(!f){perror(path);exit(1);}fseek(f,0,SEEK_END);long n=ftell(f);rewind(f);fread(phys_mem_ptr(address,n),1,n,f);fclose(f);
}
int main(void) {
    asic_init();mem.flash.size=0x400000;mem.flash.block=calloc(mem.flash.size,1);asic_reset();set_cpu_clock(48000000);
    control.stackLimit=0;control.protectedStart=control.protectedEnd=0;
    load("build/usb-bench/bench.bin",0xd1e881);load("build/usb-sfx.raw",0x100000);
    for(unsigned i=0;i<7;i++){char path[64];snprintf(path,sizeof path,"build/music%u.raw",i);load(path,0x110000+i*0x10000);}
    mem_poke_byte(0xd18020,0x76);
    for(unsigned voices=0;voices<=4;voices+=4){
    mem_poke_byte(SYM_bench_voices,voices);run(SYM_bench_init);
    unsigned long long sum=0;unsigned max=0;FILE *f=fopen("build/usb-bench/native.pcm","wb");
    for(unsigned i=0;i<120;i++){unsigned cycles=run(SYM_bench_frame);sum+=cycles;if(cycles>max)max=cycles;fwrite(phys_mem_ptr(SYM_bench_output,256),1,256,f);}
    fclose(f);printf("%u voices + music: %.3f ms per 32 ms audio; %.1f%% CPU; max %.3f ms\n",voices,sum/(120.*48000.),sum/(120.*48000.*32)*100,max/48000.);}return 0;
}
