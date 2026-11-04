/* Host transport/mixer test. Uses TI-Boy's existing lightweight driver shim. */
#define __TICE__ 1
#include <assert.h>
#include <stdio.h>
#include "../src/usb_audio.c"
static uint8_t raw[34134],music_raw[D84_MUSIC_BANKS][60012];
uint8_t sound_music_active;
uint8_t ti_Open(const char *name,const char *mode) {(void)mode;if(!strcmp(name,"D84SFX"))return 1;assert(!strncmp(name,"D84M",4));return 2+name[4]-'0';}
int ti_IsArchived(uint8_t h) {(void)h;return 1;}
unsigned int ti_GetSize(uint8_t h) {return h==1?sizeof raw:music_sizes[h-2];}
void *ti_GetDataPtr(uint8_t h) {return h==1?raw:music_raw[h-2];}
void ti_Close(uint8_t h) {(void)h;}
static usb_error_t (*events)(usb_event_t,void*,void*);
static unsigned int tick,packets,nonzero;
static uint32_t next_sequence;
usb_error_t usb_Init(usb_error_t (*cb)(usb_event_t,void*,void*),void *arg,const usb_standard_descriptors_t *d,unsigned int flags) {
    (void)arg;(void)d;(void)flags;events=cb;return USB_SUCCESS;
}
void usb_Cleanup(void) {}
void usb_HandleEvents(void) {}
usb_device_t usb_FindDevice(void *a,void *b,int c) {(void)a;(void)b;(void)c;return (void*)1;}
usb_endpoint_t usb_GetDeviceEndpoint(void *d,int e) {(void)d;(void)e;return (void*)1;}
void usb_SetEndpointFlags(void *e,int f) {(void)e;(void)f;}
unsigned int usb_GetFrameNumber(void) {return tick;}
usb_error_t usb_ScheduleBulkTransfer(usb_endpoint_t ep,void *data,size_t len,usb_callback_t cb,void *arg) {
    uint8_t *p=data;uint32_t seq;
    assert(len==272&&!memcmp(p,"DVU1",4));
    memcpy(&seq,p+4,4);assert(seq==next_sequence++);
    assert(p[8]==0xa0&&p[9]==0x0f&&p[12]==128);
    for(unsigned i=16;i<272;i+=2)if(p[i]||p[i+1])nonzero++;
    packets++;return cb(ep,USB_TRANSFER_COMPLETED,len,arg);
}
static void run(unsigned ms) {while(ms--){tick=(tick+8)&0x3fff;d84_audio_poll();}}
int main(void) {
    FILE *f=fopen("build/usb-sfx.raw","rb");assert(f);
    assert(fread(raw,1,sizeof raw,f)==sizeof raw);fclose(f);
    for(unsigned i=0;i<D84_MUSIC_BANKS;i++) {
        char path[64];snprintf(path,sizeof path,"build/music%u.raw",i);
        f=fopen(path,"rb");assert(f);assert(fread(music_raw[i],1,music_sizes[i],f)==music_sizes[i]);fclose(f);
    }
    assert(d84_music_open());sound_music_active=1;
    f=fopen("build/music-decoded.pcm","rb");assert(f);
    for(unsigned bank=0;bank<D84_MUSIC_BANKS;bank++)for(uint32_t i=0;i<music_counts[bank];i++) {
        uint8_t bytes[2];assert(fread(bytes,1,2,f)==2);
        int16_t expected=(int16_t)(bytes[0]|(bytes[1]<<8));assert(music_sample()==expected/4);
    }
    assert(music_bank==0&&music_position==0);fclose(f);
    assert(music_sample()!=0||music_position==1);sound_music_active=0;
    assert(music_sample()==0&&music_position==1);
    d84_audio_start();events(USB_HOST_CONFIGURE_EVENT,NULL,NULL);d84_audio_poll();
    run(1024);assert(packets==32&&nonzero==0);
    for(unsigned id=1;id<=9;id++) {
        unsigned before=nonzero;d84_audio_trigger(id,15,7);run(2000);
        assert(nonzero>before);
        for(unsigned i=0;i<4;i++)assert(!voices[i].data);
    }
    d84_audio_trigger(1,15,7);d84_audio_trigger(2,15,7);
    d84_audio_trigger(3,15,7);d84_audio_trigger(4,15,7);run(2000);
    assert(packets>600);events(USB_DEVICE_DISCONNECTED_EVENT,NULL,NULL);
    unsigned before=packets;run(100);assert(before==packets);
    d84_audio_stop();assert(!sample_data);
    puts("PASS: full music decode parity, bank boundaries, looping, mute; 4 kHz cadence, USB timer wrap, silence, all nine SFX, four voices, disconnect and cleanup");
    return 0;
}
