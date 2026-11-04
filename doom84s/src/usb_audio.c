#include "usb_audio.h"
#include <usbdrvce.h>
#include <string.h>
#include <fileioc.h>
#include "usb_samples.h"
#include "usb_music_data.h"
typedef struct {uint8_t data[272],busy;} Slot;
#define SLOT_COUNT 12
/* Initialized storage stays in program RAM, outside the nearly full BSS heap. */
static Slot slots[SLOT_COUNT]={{{1},0}};
static Slot *filling;
static const uint8_t *sample_data;
const uint8_t *d84_ui_data;
static const uint8_t *music_banks[D84_MUSIC_BANKS];
static uint8_t music_bank;
static unsigned int music_position;
static const uint8_t *music_cursor,*music_end;
extern uint8_t sound_music_active;
static void music_reset_bank(void) {music_position=0;music_cursor=music_banks[music_bank]+12;music_end=music_cursor+music_counts[music_bank];}
int d84_music_open(void) {
    for(unsigned int i=0;i<D84_MUSIC_BANKS;i++) {
        char name[]="D84M0";name[4]+=(char)i;
        uint8_t h=ti_Open(name,"r");
        if(!h)return 0;
        const uint8_t *data=ti_GetDataPtr(h);
        int valid=ti_IsArchived(h)&&ti_GetSize(h)==music_sizes[i]&&!memcmp(data,"D84P",4);
        if(valid)music_banks[i]=data;
        ti_Close(h);
        if(!valid)return 0;
    }
    music_bank=0;music_reset_bank();
    return 1;
}
static const int16_t music_volume[256]={-8192,-8128,-8064,-8000,-7936,-7872,-7808,-7744,-7680,-7616,-7552,-7488,-7424,-7360,-7296,-7232,-7168,-7104,-7040,-6976,-6912,-6848,-6784,-6720,-6656,-6592,-6528,-6464,-6400,-6336,-6272,-6208,-6144,-6080,-6016,-5952,-5888,-5824,-5760,-5696,-5632,-5568,-5504,-5440,-5376,-5312,-5248,-5184,-5120,-5056,-4992,-4928,-4864,-4800,-4736,-4672,-4608,-4544,-4480,-4416,-4352,-4288,-4224,-4160,-4096,-4032,-3968,-3904,-3840,-3776,-3712,-3648,-3584,-3520,-3456,-3392,-3328,-3264,-3200,-3136,-3072,-3008,-2944,-2880,-2816,-2752,-2688,-2624,-2560,-2496,-2432,-2368,-2304,-2240,-2176,-2112,-2048,-1984,-1920,-1856,-1792,-1728,-1664,-1600,-1536,-1472,-1408,-1344,-1280,-1216,-1152,-1088,-1024,-960,-896,-832,-768,-704,-640,-576,-512,-448,-384,-320,-256,-192,-128,-64,0,64,128,192,256,320,384,448,512,576,640,704,768,832,896,960,1024,1088,1152,1216,1280,1344,1408,1472,1536,1600,1664,1728,1792,1856,1920,1984,2048,2112,2176,2240,2304,2368,2432,2496,2560,2624,2688,2752,2816,2880,2944,3008,3072,3136,3200,3264,3328,3392,3456,3520,3584,3648,3712,3776,3840,3904,3968,4032,4096,4160,4224,4288,4352,4416,4480,4544,4608,4672,4736,4800,4864,4928,4992,5056,5120,5184,5248,5312,5376,5440,5504,5568,5632,5696,5760,5824,5888,5952,6016,6080,6144,6208,6272,6336,6400,6464,6528,6592,6656,6720,6784,6848,6912,6976,7040,7104,7168,7232,7296,7360,7424,7488,7552,7616,7680,7744,7808,7872,7936,8000,8064,8128};
static int music_sample(void) {
    if(!sound_music_active||!music_banks[0])return 0;
    int result=music_volume[*music_cursor++];
    if(++music_position, music_cursor==music_end) {
        if(++music_bank==D84_MUSIC_BANKS)music_bank=0;
        music_reset_bank();
    }
    return result;
}
static usb_endpoint_t endpoint;
static uint8_t started,servicing,synced;
static unsigned int last_tick,position,last_service_tick;
static uint8_t service_synced;
static uint32_t sequence;
static uint8_t packet[272];
typedef union {uint16_t value;uint8_t bytes[2];} Fraction;
typedef struct {const uint8_t *data;uint16_t length,position,step;uint8_t fraction;const int16_t *scale;} Voice;
static int16_t scales[4][256]={{1}};
static Voice voices[4];
static uint8_t active_voices;
static const uint8_t config[25]={9,2,25,0,1,1,0,128,50,9,4,0,0,1,255,68,1,0,7,5,129,2,64,0,0};
static const usb_device_descriptor_t device={18,1,0x0200,0,0,0,64,0x0451,0xe008,0x0300,0,1,0,1};
static const usb_configuration_descriptor_t *configs[]={(const usb_configuration_descriptor_t*)config};
static const usb_string_descriptor_t product={.bLength=30,.bDescriptorType=3,.bString=L"Doom84 USB PCM"};
static const usb_string_descriptor_t lang={.bLength=4,.bDescriptorType=3,.bString={0x0409}};
static const usb_string_descriptor_t *strings[]={&product};
static const usb_standard_descriptors_t descriptors={&device,configs,&lang,1,strings};

static usb_error_t complete(usb_endpoint_t ep,usb_transfer_status_t status,size_t n,void *arg) {
    (void)ep;(void)status;(void)n;((Slot*)arg)->busy=0;return USB_SUCCESS;
}
static usb_error_t event(usb_event_t e,void *data,void *arg) {
    (void)data;(void)arg;
    if(e==USB_HOST_CONFIGURE_EVENT) {
        usb_device_t host=usb_FindDevice(NULL,NULL,USB_SKIP_HUBS);
        endpoint=usb_GetDeviceEndpoint(host,0x81);
        if(endpoint)usb_SetEndpointFlags(endpoint,USB_AUTO_TERMINATE);
        position=0;synced=0;filling=NULL;
    } else if(e==USB_DEVICE_DISCONNECTED_EVENT||e==USB_DEVICE_DISABLED_EVENT) {endpoint=NULL;synced=0;}
    return USB_SUCCESS;
}
void d84_audio_start(void) {
    uint8_t h=ti_Open("D84SFX","r");
    if(!h)return;
    if(ti_IsArchived(h)&&ti_GetSize(h)==34134)sample_data=ti_GetDataPtr(h);
    ti_Close(h);
    if(!sample_data)return;
    memset(slots,0,sizeof slots);
    memset(voices,0,sizeof voices);active_voices=0;
    started=usb_Init(event,NULL,&descriptors,USB_DEFAULT_INIT_FLAGS)==USB_SUCCESS;

}
void d84_audio_stop(void) {if(started)usb_Cleanup();started=0;endpoint=NULL;sample_data=NULL;}
void d84_audio_trigger(uint8_t id,uint8_t volume,uint8_t pitch) {
    unsigned int i;
    if(!sample_data||id<1||id>9)return;
    for(i=0;i<4;i++)if(!voices[i].data)break;
    if(i==4)i=0;else ++active_voices;
    for(unsigned int x=0;x<256;x++)scales[i][x]=((int)x-128)*volume;
    voices[i]=(Voice){sample_data+d84_offsets[id-1],d84_lengths[id-1],0,(uint16_t)(128+pitch*128/7),0,scales[i]};
}
static void send_packet(Slot *s) {
    memcpy(packet,"DVU1",4);memcpy(packet+4,&sequence,4);sequence++;
    packet[8]=0xa0;packet[9]=0x0f;packet[10]=packet[11]=0;
    packet[12]=128;packet[13]=0;packet[14]=packet[15]=0;
    memcpy(s->data,packet,272);s->busy=1;
    if(usb_ScheduleBulkTransfer(endpoint,s->data,272,complete,s)!=USB_SUCCESS)s->busy=0;
}
static int16_t mix_sample(void) {
    if(!active_voices)return music_sample();
    int mix=0;
    for(unsigned int j=0;j<4;j++) {
        Voice *v=&voices[j];
        if(v->data) {
        mix+=v->scale[v->data[v->position]];
        Fraction next={(uint16_t)(v->fraction+v->step)};
        v->fraction=next.bytes[0];v->position+=next.bytes[1];
        if(v->position>=v->length){v->data=NULL;--active_voices;}
        }
    }
    /* Four full-volume voices fit signed PCM16 at this fixed gain. */
    int output=mix*4+music_sample();
    if(output>32767)output=32767;
    if(output< -32768)output=-32768;
    return (int16_t)output;
}
void d84_audio_poll(void) {
    unsigned int now,n,i;
    if(!started||servicing)return;
    now=usb_GetFrameNumber()&0x3ff8;
    if(service_synced&&now==last_service_tick)return;
    last_service_tick=now;service_synced=1;
    servicing=1;usb_HandleEvents();
    if(!endpoint){servicing=0;return;}
    now=usb_GetFrameNumber()&0x3ff8;
    if(!synced){last_tick=now;synced=1;servicing=0;return;}
    n=((now-last_tick)&0x3fff)/2;last_tick=now;
    if(n>500)n=250;
    while(n) {
        if(!filling) {
            for(i=0;i<SLOT_COUNT;i++)if(!slots[i].busy){filling=&slots[i];break;}
            if(!filling){position=0;break;}
        }
        int16_t sample=mix_sample();
        packet[16+position*2]=(uint8_t)sample;
        packet[17+position*2]=(uint16_t)sample>>8;
        if(++position==128){send_packet(filling);filling=NULL;position=0;usb_HandleEvents();}
        --n;
    }
    servicing=0;
}
