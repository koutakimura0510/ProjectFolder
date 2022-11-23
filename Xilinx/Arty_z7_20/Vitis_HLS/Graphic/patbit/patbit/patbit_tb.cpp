#include <stdio.h>
#include "ap_int.h"

#define XSIZE 640
#define YSIZE 480

void patbit(volatile ap_uint<32> *, ap_uint<11>, ap_uint<11>, ap_uint<11>, ap_uint<11>, ap_uint<32>);
ap_uint<32> VRAM[XSIZE * YSIZE];

int main()
{
    for (int i = 0; i < XSIZE * YSIZE; i++) {
        VRAM[i] = 0;
    }

    patbit(VRAM,   0,   0, 320, 240, 0x00ff0000);
    patbit(VRAM, 160, 120, 320, 240, 0x0000ff00);
    patbit(VRAM, 320, 240, 320, 240, 0x000000ff);

    FILE *fd = fopen("imagedata.raw", "wb");

    for (int y = 0; y < YSIZE; y++) {
        for (int x = 0; x < XSIZE; x++) {
            int temp = VRAM[y * XSIZE + x];
            fprintf(fd, "%c", (temp >> 16) & 0xff);
            fprintf(fd, "%c", (temp >> 8) & 0xff);
            fprintf(fd, "%c", temp & 0xff);
        }
    }
    fclose(fd);

    return 0;
}
