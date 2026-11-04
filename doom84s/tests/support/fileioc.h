#include <stdint.h>
uint8_t ti_Open(const char *,const char *);
int ti_IsArchived(uint8_t);
unsigned int ti_GetSize(uint8_t);
void *ti_GetDataPtr(uint8_t);
void ti_Close(uint8_t);
