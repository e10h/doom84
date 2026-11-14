/* Host reference for the isolated native mixer timing test. */
#define main mixer_tests_main
#include "../tests/usb_audio.c"
#undef main
int main(void) {
    FILE *f=fopen("build/usb-sfx.raw","rb");assert(f);assert(fread(raw,1,sizeof raw,f)==sizeof raw);fclose(f);
    for(unsigned i=0;i<D84_MUSIC_BANKS;i++){char path[64];snprintf(path,sizeof path,"build/music%u.raw",i);f=fopen(path,"rb");assert(f);assert(fread(music_raw[i],1,music_sizes[i],f)==music_sizes[i]);fclose(f);}
    assert(d84_music_open());sample_data=raw;sound_music_active=1;active_voices=4;
    for(unsigned i=0;i<4;i++){for(unsigned x=0;x<256;x++)scales[i][x]=((int)x-128)*15;voices[i]=(Voice){raw,34134,0,256,0,scales[i]};}
    f=fopen("build/usb-bench/reference.pcm","wb");assert(f);
    for(unsigned i=0;i<120*128;i++){int16_t sample=mix_sample();fputc((uint8_t)sample,f);fputc((uint16_t)sample>>8,f);}fclose(f);return 0;
}
