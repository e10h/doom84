// doom84 - e10h
#include <tice.h>

int main(void) {
    os_ClrHome();
    os_PutStrFull("Doom84 C++20 engine init");
    while (!os_GetCSC());
    return 0;
}
