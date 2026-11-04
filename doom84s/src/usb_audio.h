#ifndef D84_USB_AUDIO_H
#define D84_USB_AUDIO_H
#include <stdint.h>
#ifdef __TICE__
extern const uint8_t *d84_ui_data;
int d84_music_open(void);
void d84_audio_start(void);
void d84_audio_stop(void);
void d84_audio_poll(void);
void d84_audio_trigger(uint8_t id,uint8_t volume,uint8_t pitch);
#else
static inline void d84_audio_poll(void) {}
static inline void d84_audio_trigger(uint8_t id,uint8_t volume,uint8_t pitch) {(void)id;(void)volume;(void)pitch;}
#endif
#endif
