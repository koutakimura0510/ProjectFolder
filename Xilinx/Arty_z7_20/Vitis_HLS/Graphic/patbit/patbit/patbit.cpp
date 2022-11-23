#include "ap_int.h"

#define XSIZE 640

void patbit(
    volatile ap_uint<32> *dstout,
    ap_uint<11> xpos,
    ap_uint<11> ypos,
    ap_uint<11> width,
    ap_uint<11> height,
    ap_uint<32> color
)
{
    height_loop: for (int y = 0; y < height; y++) {
        width_loop: for (int x = 0; x < width; x++) {
            dstout[(x + xpos) + (y + ypos) * XSIZE] = color;
        }
    }
}