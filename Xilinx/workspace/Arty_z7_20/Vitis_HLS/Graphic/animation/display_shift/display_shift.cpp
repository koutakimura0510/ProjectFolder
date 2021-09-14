#include "ap_int.h"

#define BUFFER      (640)

enum
{
    RIGHT,
    LEFT,
    UP,
    DOWN,
};

typedef ap_uint<32>  u32;

/*          xs  xe  ys  ye  wd  he
 * RIGHT:   1   0   0   0   639 480
 * LEFT :   0   1   0   0   639 480
 * UP   :   0   0   0   1   640 479
 * DOWN :   0   0   1   0   640 479
 */
void display_shift(
    volatile u32 *ddr_copy,
    volatile u32 *ddr_update,
    u32 width,
    u32 height,
    u32 xstart,
    u32 xend,
    u32 ystart,
    u32 yend,
    u32 frame_size
)
{
    u32 copy[BUFFER];

    display_shift_label0:for (int y = 0; y < height; y++)
    {
        display_shift_label1:for (int x = 0; x < width; x++)
        {
            copy[x] = ddr_copy[x + xstart + ((y + ystart) * frame_size)];
        }

        display_shift_label2:for (int x = 0; x < width; x++)
        {
            ddr_update[x + xend + ((y + yend) * frame_size)] = copy[x];
        }
    }
}
