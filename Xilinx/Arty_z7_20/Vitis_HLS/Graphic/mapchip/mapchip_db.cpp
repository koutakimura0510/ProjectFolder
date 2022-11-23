#include "ap_int.h"
#include <stdio.h>

#define WIDTH  320
#define HEIGHT 240

#define XSIZE	(640 + 96 + 96)
#define YSIZE 480

#define SRC0	(0   + 0  * XSIZE)
#define SRC1	(320 + 0  * XSIZE)
#define DST0	(24  + 24 * XSIZE)
#define DST1	(48 +  48 * XSIZE)

typedef ap_uint<8>   u8;
typedef ap_uint<11>  u11;
typedef ap_uint<32>  u32;

u32 VRAM[XSIZE * YSIZE];
u32  TEX[XSIZE * YSIZE];

void mapchip(volatile u32*, volatile u32*, volatile u32*, u32, u32, u8, u32);

void patbit(
    volatile ap_uint<32> *dstout,
    ap_uint<11> xpos,
    ap_uint<11> ypos,
    ap_uint<11> width,
    ap_uint<11> height,
    ap_uint<32> color
)
{
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            dstout[(x + xpos) + (y + ypos) * XSIZE] = color;
        }
    }
}

int main()
{
	patbit(VRAM, 0, 0, XSIZE, YSIZE, 0);
	patbit(&TEX[SRC0], 96, 0, WIDTH, HEIGHT, 0x000000ff);
    patbit(&TEX[SRC1], 96, 0, WIDTH, HEIGHT, 0x00ff0000);

    mapchip(&TEX[SRC0], &VRAM[SRC0], &VRAM[SRC0], 64, 64, 255, 0);
//    mapchip(&TEX[SRC1], &VRAM[SRC0], &VRAM[SRC0], 64, 64, 255, 0);

    FILE *fp = fopen("imagedata.raw", "wb");

    for (int y = 0; y < YSIZE; y++)
    {
        for (int x = 0; x < 640; x++)
        {
            int temp = VRAM[y * XSIZE + x];
            fprintf(fp, "%c", (temp >> 16) & 0xff);
            fprintf(fp, "%c", (temp >> 8) & 0xff);
            fprintf(fp, "%c", temp & 0xff);
        }
    }

    fclose(fp);

    return 0;
}
