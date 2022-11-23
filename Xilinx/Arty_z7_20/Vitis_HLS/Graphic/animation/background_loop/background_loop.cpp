#include "ap_int.h"

#define BUFFER      (640)
#define WIDTH       (640)
#define WIDTH_END   (639)
#define HEIGHT      (480)
#define HEIGHT_END  (479)

enum
{
    RIGHT,
    LEFT,
    UP,
    DOWN,
};

typedef ap_uint<32>  u32;

void background_loop(
    volatile u32 *ddr_copy,
    volatile u32 *ddr_update,
    u32 width,
    u32 height,
    u32 frame_size,
	u32 direction
)
{
    u32 xcopy[BUFFER];
    u32 ycopy[BUFFER];
    u32 endpos;

    endpos = width - 1;

    copy:for (int y = 0; y < height; y++)
    {
        ycopy[y] = ddr_copy[endpos + (y * frame_size)];
    }

    right_height_loop:for (int y = 0; y < height; y++)
    {

        right_width_loop:for (int x = 0; x < endpos; x++)
        {
            xcopy[x] = ddr_copy[x + (y * frame_size)];
        }

        right_copy_loop:for (int x = 0; x < endpos; x++)
        {
            ddr_update[x + (y * frame_size) + 1] = xcopy[x];
        }
    }

    copy2:for (int y = 0; y < height; y++)
    {
        ddr_update[(y * frame_size)] = ycopy[y];
    }

    // case LEFT:
    //     endpos = width - 1;

    //     left_height_loop:for (int y = 0; y < height; y++)
    //     {
    //         ycopy[y] = ddr_copy[y * frame_size];

    //         left_width_loop:for (int x = 1; x < width; x++)
    //         {
    //             xcopy[x] = ddr_copy[x + (y * frame_size)];
    //         }

    //         left_copy_loop:for (int x = 1; x < width; x++)
    //         {
    //             ddr_update[x + (y * frame_size) - 1] = xcopy[x];
    //         }

    //         ddr_update[endpos + (y * frame_size)] = ycopy[y];
    //     }
    //     break;

    // case UP:
    //     endpos = (height - 1) * frame_size;

    //     up_height_loop:for (int y = 1; y < height; y++)
    //     {
    //         up_x_loop:for (int x = 0; x < width; x++)
    //         {
    //             xcopy[x] = ddr_copy[x];
    //         }

    //         up_width_loop:for (int x = 0; x < width; x++)
    //         {
    //             ycopy[x] = ddr_copy[x + (y * frame_size)];
    //         }

    //         up_copy_loop:for (int x = 0; x < width; x++)
    //         {
    //             ddr_update[x + ((y - 1) * frame_size)] = ycopy[x];
    //         }

    //         up_copy2_loop:for (int x = 0; x < width; x++)
    //         {
    //             ddr_update[x + endpos] = xcopy[x];
    //         }
    //     }
    //     break;

    // case DOWN:
    //     endpos = (height - 1) * frame_size;

    //     down_height_loop:for (int y = 1; y < height; y++)
    //     {
    //         down_x_loop:for (int x = 0; x < width; x++)
    //         {
    //             xcopy[x] = ddr_copy[x + endpos];
    //         }

    //         down_width_loop:for (int x = 0; x < width; x++)
    //         {
    //             ycopy[x] = ddr_copy[x + ((height - y - 1) * frame_size)];
    //         }

    //         down_copy_loop:for (int x = 0; x < width; x++)
    //         {
    //             ddr_update[x + ((height - y) * frame_size)] = ycopy[x];
    //         }

    //         down_copy2_loop:for (int x = 0; x < width; x++)
    //         {
    //             ddr_update[x] = xcopy[x];
    //         }
    //     }
    //     break;
    
    // default:
    //     break;
    // }
}
