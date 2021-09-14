/*
 * マップチップ描画高位合成
 *
 * VitisHLS 20.2
 * Ubuntu LTS 20.04
 */

#include "ap_int.h"

/*
 * マップチップの大きさ
 */
#define MAPCHIP_XSIZE (640)

typedef ap_uint<8>   u8;
typedef ap_uint<32>  u32;


u32 color_generate(u32 src, u32 dst, u8 alpha)
{
    u32 src_a  = (src >> 24) & 0xff;
	u32 src_r  = (src >> 16) & 0xff;
	u32 src_b  = (src >> 8) & 0xff;
	u32 src_g  = src & 0xff;
    u32 dst_r = (dst >> 16) & 0xff;
    u32 dst_b = (dst >> 8) & 0xff;
    u32 dst_g = dst & 0xff;

    src_r = (alpha * src_r) / 255;
    src_b = (alpha * src_b) / 255;
    src_g = (alpha * src_g) / 255;
    dst_r = ((src_a * src_r) + ((255 - src_a) * dst_r)) / 255;
    dst_b = ((src_a * src_b) + ((255 - src_a) * dst_b)) / 255;
    dst_g = ((src_a * src_g) + ((255 - src_a) * dst_g)) / 255;
    u32 color = ((dst_r << 16) & 0xff0000) | ((dst_b << 8) & 0x00ff00) | (dst_g & 0xff);

    return color;
}


/*
 * 指定サイズのマップチップをメモリに保存
 */
void mapchip_png(
    volatile u32 *srcin,    //マップチップの保存領域の開始アドレス
    volatile u32 *dstin,    //合成を行う色データのアドレス
    volatile u32 *dstout,   //書き込みを行うフレームバッファのアドレス
    u32 mapchip_maxwidth,   //指定したマップチップの横幅
    u32 mapchip_maxheight,  //指定したマップチップの縦幅
    u32 mapchip_draw_xsize, //マップチップの書き込みpixel数
    u32 mapchip_draw_ysize, //マップチップの書き込みpixel数
	u32 xstart_pos,	        //マップチップのx開始位置
    u32 ystart_pos,	        //マップチップのy開始位置
    u32 frame_size,         //書き込みを行うフレームバッファの横幅
    u8 alpha,               //合成色の透過値、255で透過を行わない
    u32 id,                 //マップチップのID
)
{
    u32 src[MAPCHIP_XSIZE];
    u32 dst[MAPCHIP_XSIZE];
    u32 chip = (id * mapchip_maxwidth * mapchip_maxheight) + xstart_pos + (ystart_pos * mapchip_maxwidth);

    height_loop:for (int y = 0; y < mapchip_draw_ysize; y++)
    {
        src_loop:for (int x = 0; x < mapchip_draw_xsize; x++)
        {
            src[x] = srcin[chip + x + y * mapchip_maxwidth];
        }

        dstin_loop:for (int x = 0; x < mapchip_draw_xsize; x++)
        {
        	dst[x] = dstin[x + y * frame_size];
        }

        dstout_loop:for (int x = 0; x < mapchip_draw_xsize; x++)
        {
        	dstout[x + y * frame_size] = color_generate(src[x], dst[x], alpha);
        }
    }
}
