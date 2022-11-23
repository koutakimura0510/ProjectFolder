#include "ap_int.h"

#define BUFFER   (640)

typedef ap_uint<32>  u32;

void framebuffer_copy(
    volatile u32 *copy,
    volatile u32 *update,
    u32 width,
    u32 height,
    u32 display_xsize,
)
{
    u32 src[BUFFER];

    height_loop:for (int y = 0; y < height; y++)
    {
        width_loop:for (int x = 0; x < width; x++)
        {
            src[x] = copy[x + y * display_xsize];
        }

        copy_loop:for (int x = 0; x < width; x++)
        {
            update[x + y * display_xsize] = src[x];
        }
    }
}
