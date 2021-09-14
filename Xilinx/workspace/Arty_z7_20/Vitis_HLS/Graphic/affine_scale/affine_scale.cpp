/**
 * Create 2021/09/05
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis_Hls20.2
 * Borad  ArtyZ7-20
 * -
 * @brief アフィン変換の拡大縮小、スライド移動の処理を行うソースファイル
 */

#include "ap_int.h"

/*
 * プロジェクトに使用する画面サイズ
 */
#define MAPCHIP_XSIZE (640)

/**
 * @brief  アフィン変換固定少数計算定数
 * @note   
 * @retval None
 */
#define FIX_POS_12   (12)
#define NEAREST_FIX  (2048) // (5 << 12) / 10


/* 型の定義 */
typedef ap_uint<8>   u8;
typedef ap_uint<32>  u32;
typedef ap_int<32>   i32;

/**
 * @brief  スケール変換の座標データを計算し色データを取得
 * @note   
 * @param  src: 基本色データ
 * @param  dst: 合成用の色データ
 * @param  alpha: 透過データ 0で消える
 * @retval 
 */
u32 color_generate(u32 src, u32 dst, u8 alpha)
{
    u32 src_a  = (src >> 24) & 0xff;
	u32 src_r  = (src >> 16) & 0xff;
	u32 src_b  = (src >> 8) & 0xff;
	u32 src_g  = src & 0xff;
    u32 dst_r = (dst >> 16) & 0xff;
    u32 dst_b = (dst >> 8) & 0xff;
    u32 dst_g = dst & 0xff;

    dst_r = ((src_a * src_r) + ((255 - src_a) * dst_r)) / 255;
    dst_b = ((src_a * src_b) + ((255 - src_a) * dst_b)) / 255;
    dst_g = ((src_a * src_g) + ((255 - src_a) * dst_g)) / 255;
    dst_r = (alpha * dst_r) / 255;
    dst_b = (alpha * dst_b) / 255;
    dst_g = (alpha * dst_g) / 255;
    u32 color = ((dst_r << 16) & 0xff0000) | ((dst_b << 8) & 0x00ff00) | (dst_g & 0xff);

    return color;
}


/**
 * @brief  アフィン変換による画像データの拡大縮小処理
 * @note   引数(a , d)又は(b, c)は両方とも0にしてはいけない
 *         a, dは100が基準値、b, cは0が基準値
 * @retval None
 */
void affine_scale(
    volatile u32 *srcin,    /* マップチップの保存領域の開始アドレス */
    volatile u32 *dstin,    /* 合成を行う色データのアドレス */
    volatile u32 *dstout,   /* 書き込みを行うフレームバッファのアドレス */
    u32 mapchip_maxwidth,   /* 指定したマップチップの横幅 */
    u32 mapchip_maxheight,  /* 指定したマップチップの縦幅 */
    u32 mapchip_draw_xsize, /* マップチップの書き込みpixel数 */
    u32 mapchip_draw_ysize, /* マップチップの書き込みpixel数 */
	u32 xstart_pos,	        /* マップチップのx開始位置 */
    u32 ystart_pos,	        /* マップチップのy開始位置 */
    i32 frame_size,         /* 書き込みを行うフレームバッファの横幅 */
    u8 alpha,               /* 合成色の透過値、255で透過を行わない */
    u32 id,                 /* マップチップのID */
    i32 a,                  /* 線形変換a */
    i32 b,                  /* 線形変換b */
    i32 c,                  /* 線形変換c */
    i32 d,                  /* 線形変換d */
    i32 m,                  /* 横移動量 */
    i32 n                   /* 縦移動量 */
)
{
    u32 src[MAPCHIP_XSIZE];
    u32 dst[MAPCHIP_XSIZE];
    u32 chip = (id * mapchip_maxwidth * mapchip_maxheight) + xstart_pos + (ystart_pos * mapchip_maxwidth);
    a = (a << FIX_POS_12) / 100;
    b = (b << FIX_POS_12) / 100;
    c = (c << FIX_POS_12) / 100;
    d = (d << FIX_POS_12) / 100;
    i32 det = ((a * d) - (b * c)) >> FIX_POS_12;
    i32 ixa = ( d << FIX_POS_12) / det;
    i32 ixb = (-b << FIX_POS_12) / det;
    i32 ixc = (-c << FIX_POS_12) / det;
    i32 ixd = ( a << FIX_POS_12) / det;

	if (a < 0)
	{
		m--;
	}

	if (d < 0)
	{
		n--;
	}

    i32 result_width  = (mapchip_width >> 1);
    i32 result_height = (mapchip_height >> 1);
    i32 result_width_fix  = ((result_width  << FIX_POS_12) + NEAREST_FIX) - ((m * ixa) - (n * ixb));
    i32 result_height_fix = ((result_height << FIX_POS_12) + NEAREST_FIX) - ((m * ixc) - (n * ixd));

    height_loop:for (i32 y = 0; y < mapchip_draw_ysize; y++)
    {
        i32 result_yb = ((y - result_height) * ixb) + result_width_fix;
        i32 result_yd = ((y - result_height) * ixd) + result_height_fix;

        src_loop:for (i32 x = 0; x < mapchip_draw_xsize; x++)
        {
            i32 rx  = (((x - result_width) * ixa) + result_yb) >> FIX_POS_12;
            i32 ry  = (((x - result_width) * ixc) + result_yd) >> FIX_POS_12;

            if ((rx < 0) || (mapchip_width <= rx) || (ry < 0) || (mapchip_height <= ry))
            {
                src[x] = 0x00000000;
            }
            else
            {
                src[x] = srcin[chip + rx + ry * mapchip_width];
            }
        }

        dstin_loop:for (i32 x = 0; x < mapchip_draw_xsize; x++)
        {
            dst[x] = dstin[x + y * frame_size];
        }

        dstout_loop:for (i32 x = 0; x < mapchip_draw_xsize; x++)
        {
        	dstout[x + y * frame_size] = color_generate(src[x], dst[x], alpha);
        }
    }
}
