/* Isolated production mixer entry points; no calculator ROM/USB hardware. */
#include "../src/usb_audio.c"
uint8_t sound_music_active,bench_voices;
int16_t bench_output[128];
void bench_init(void) {
    memset(voices,0,sizeof voices);active_voices=bench_voices;
    sample_data=(const uint8_t*)0x100000;
    for(unsigned int i=0;i<D84_MUSIC_BANKS;i++)music_banks[i]=(const uint8_t*)(0x110000+i*0x10000);
    music_bank=0;music_reset_bank();sound_music_active=1;
    for(unsigned int i=0;i<bench_voices;i++){for(unsigned int x=0;x<256;x++)scales[i][x]=((int)x-128)*15;voices[i]=(Voice){sample_data,34134,0,256,0,scales[i]};}
}
void bench_frame(void) {for(unsigned int i=0;i<128;i++)bench_output[i]=mix_sample();}
