/*
 * DDRメモリの操作を行うハードウェア関数を管理
 */
#include "xmapchip.h"
#include "xframebuffer_copy.h"
#include "xpatbit.h"
// #include "xbackground_loop.h"
#include "xmapchip_png.h"
#include "xmapchip_color.h"
#include "../../wrapper/game_wrapper.h"

/**
 * @brief  FPGA内の容量が一杯になり、ソフトウェアで映像処理を行う必要になった時、
 * 		   もしくはソフトウェアでディスプレイ描画のアルゴリズムのデバッグを行いたいときにコメントアウトを外す
 * @note   
 */
// #define SOFTWARE_DISPLAY_ON


/* CPU処理時はキャッシュをクリアしないと映像が乱れるためインクルードする */
#ifdef SOFTWARE_DISPLAY_ON
	#include "xil_cache.h"
#endif

#ifdef SOFTWARE_DISPLAY_ON
	#define SOFTWARE_DRAM_ACCESS
	static uint32_t color_generate(uint32_t src, uint32_t dst, uint8_t alpha);
#else
	#define HARDWARE_DRAM_ACCESS
	#include "xaffine_scale.h"
	#include "xil_cache.h"
	static XAffine_scale ScaleInstance;
#endif

/*
 * マップチップ構造体のインスタンス
 */
static XMapchip ChipInstance;
static XMapchip_png			PngInstance;
static XMapchip_color		ColorInstance;
static XPatbit 				PatInctance;
static XFramebuffer_copy 	FramebufferInstance;
// static XBackground_loop 	BLoopInstance;


/*
 * FPGAのマップチップIPの初期設定
 */
bool fpga_mapchip_init(void)
{
#ifdef MYDEBUG
	if (XST_SUCCESS != XMapchip_Initialize(&ChipInstance, XPAR_MAPCHIP_0_DEVICE_ID))
	{
		return false;
	}

	if (XST_SUCCESS != XMapchip_png_Initialize(&PngInstance, XPAR_MAPCHIP_PNG_0_DEVICE_ID))
	{
		xil_printf("FPGA Mapchip Png Init Error \n");
		return false;
	}

	if (XST_SUCCESS != XMapchip_color_Initialize(&ColorInstance, XPAR_MAPCHIP_COLOR_0_DEVICE_ID))
	{
		xil_printf("FPGA Mapchip Color Init Error \n");
		return false;
	}

	if (XST_SUCCESS != XFramebuffer_copy_Initialize(&FramebufferInstance, XPAR_FRAMEBUFFER_COPY_0_DEVICE_ID))
	{
		return false;
	}

	// if (XST_SUCCESS != XBackground_loop_Initialize(&BLoopInstance, XPAR_BACKGROUND_LOOP_0_DEVICE_ID))
	// {
	// 	return false;
	// }

	if (XST_SUCCESS != XPatbit_Initialize(&PatInctance, XPAR_PATBIT_0_DEVICE_ID))
	{
		return false;
	}

	#ifdef HARDWARE_DRAM_ACCESS
		if (XST_SUCCESS != XAffine_scale_Initialize(&ScaleInstance, XPAR_AFFINE_SCALE_0_DEVICE_ID))
		{
			xil_printf("FPGA Affine Scale Init Error \n");
			return false;
		}
	#endif

	xil_printf("FPGA Mapchip Init OK\n");
#else
	XMapchip_png_Initialize(&PngInstance, XPAR_MAPCHIP_PNG_0_DEVICE_ID);
	XMapchip_color_Initialize(&ColorInstance, XPAR_MAPCHIP_COLOR_0_DEVICE_ID);
	XFramebuffer_copy_Initialize(&FramebufferInstance, XPAR_FRAMEBUFFER_COPY_0_DEVICE_ID);
	XBackground_loop_Initialize(&BLoopInstance, XPAR_BACKGROUND_LOOP_0_DEVICE_ID);
	XPatbit_Initialize(&PatInctance, XPAR_PATBIT_0_DEVICE_ID);

	#ifdef HARDWARE_DRAM_ACCESS
		XAffine_scale_Initialize(&AffineScale, XPAR_AFFINE_SCALE_0_DEVICE_ID);
	#endif
#endif

	return true;
} 


/*
 * 指定アドレスのマップチップデータをフレームバッファ領域に書き込む
 */
void put_mapchip(GameWrapper *const game)
{
	/* アドレスの設定 */
	XMapchip_Set_srcin(&ChipInstance, game->mapchip.srcin);
	XMapchip_Set_dstin(&ChipInstance, game->mapchip.dstin);
	XMapchip_Set_dstout(&ChipInstance, game->mapchip.dstout);

	/* マップチップの描画サイズの設定 */
	XMapchip_Set_mapchip_maxwidth(&ChipInstance, game->mapchip.maxwidth);
	XMapchip_Set_mapchip_maxheight(&ChipInstance, game->mapchip.maxheight);
	XMapchip_Set_mapchip_draw_xsize(&ChipInstance, game->mapchip.draw_xsize);
	XMapchip_Set_mapchip_draw_ysize(&ChipInstance, game->mapchip.draw_ysize);

	/* マップチップの開始pixelを設定 */
	XMapchip_Set_xstart_pos(&ChipInstance, game->mapchip.xstart_pos);
	XMapchip_Set_ystart_pos(&ChipInstance, game->mapchip.ystart_pos);

	/* 画面フレームの大きさ設定 */
	XMapchip_Set_frame_size(&ChipInstance, game->mapchip.frame_size);

	/* 透過データを設定 */
	XMapchip_Set_alpha(&ChipInstance, game->mapchip.alpha);

	/* マップチップIDを設定 */
	XMapchip_Set_id(&ChipInstance, game->mapchip.id);

	/* ハード動作 */
	XMapchip_Start(&ChipInstance);
	while (XMapchip_IsDone(&ChipInstance) == 0);
}


/*
 * ver1. 2021/07/10
 * png画像データのalpha値に対応した回路を追加
 * alpha値によって画像データの透過処理を行ってくれるため
 * 切り取り職を指定する必要がなくなった
 */
void png_mapchip(GameWrapper *const game)
{
	/* アドレスの設定 */
	XMapchip_png_Set_srcin(&PngInstance, game->mapchip.srcin);
	XMapchip_png_Set_dstin(&PngInstance, game->mapchip.dstin);
	XMapchip_png_Set_dstout(&PngInstance, game->mapchip.dstout);

	/* 描画サイズの設定 */
	XMapchip_png_Set_mapchip_maxwidth(&PngInstance, game->mapchip.maxwidth);
	XMapchip_png_Set_mapchip_maxheight(&PngInstance, game->mapchip.maxheight);
	XMapchip_png_Set_mapchip_draw_xsize(&PngInstance, game->mapchip.draw_xsize);
	XMapchip_png_Set_mapchip_draw_ysize(&PngInstance, game->mapchip.draw_ysize);
	XMapchip_png_Set_frame_size(&PngInstance, game->mapchip.frame_size);

	/* マップチップの開始pixelを設定 */
	XMapchip_png_Set_xstart_pos(&PngInstance, game->mapchip.xstart_pos);
	XMapchip_png_Set_ystart_pos(&PngInstance, game->mapchip.ystart_pos);

	/* 透過データを設定 */
	XMapchip_png_Set_alpha(&PngInstance, game->mapchip.alpha);

	/* マップチップIDを設定 */
	XMapchip_png_Set_id(&PngInstance, game->mapchip.id);

	/* ハード動作 */
	XMapchip_png_Start(&PngInstance);
	// XMapchip_EnableAutoRestart(&PngInstance);

	/* 書き込み終了まで待機 */
	while (XMapchip_png_IsDone(&PngInstance) == 0);
}


/*
 * ver1. 2021/07/27
 * png画像データのalpha値に対応した回路
 * 特定の色を指定した色に変換することができる
 */
void color_mapchip(GameWrapper *const game)
{
	XMapchip_color_Set_srcin(&ColorInstance, game->mapchip.srcin);
	XMapchip_color_Set_dstin(&ColorInstance, game->mapchip.dstin);
	XMapchip_color_Set_dstout(&ColorInstance, game->mapchip.dstout);
	XMapchip_color_Set_mapchip_maxwidth(&ColorInstance, game->mapchip.maxwidth);
	XMapchip_color_Set_mapchip_maxheight(&ColorInstance, game->mapchip.maxheight);
	XMapchip_color_Set_mapchip_draw_xsize(&ColorInstance, game->mapchip.draw_xsize);
	XMapchip_color_Set_mapchip_draw_ysize(&ColorInstance, game->mapchip.draw_ysize);
	XMapchip_color_Set_frame_size(&ColorInstance, game->mapchip.frame_size);
	XMapchip_color_Set_xstart_pos(&ColorInstance, game->mapchip.xstart_pos);
	XMapchip_color_Set_ystart_pos(&ColorInstance, game->mapchip.ystart_pos);
	XMapchip_color_Set_com(&ColorInstance, game->mapchip.com);
	XMapchip_color_Set_fill(&ColorInstance, game->mapchip.fill);
	XMapchip_color_Set_alpha(&ColorInstance, game->mapchip.alpha);
	XMapchip_color_Set_id(&ColorInstance, game->mapchip.id);
	XMapchip_color_Start(&ColorInstance);
	while (XMapchip_color_IsDone(&ColorInstance) == 0);
}


/*
 * 描画データのシフト動作
 */
// void background_loop(int ddr_copy, int ddr_update, int width, int height, int frame_size)
// {
// 	if (1 == XBackground_loop_IsReady(&BLoopInstance))
// 	{
// 		/* DDRメモリのアドレス設定 */
// 		XBackground_loop_Set_ddr_copy(&BLoopInstance, ddr_copy);
// 		XBackground_loop_Set_ddr_update(&BLoopInstance, ddr_update);

// 		/* 描画サイズを設定 */
// 		XBackground_loop_Set_width(&BLoopInstance, width);
// 		XBackground_loop_Set_height(&BLoopInstance, height);
// 		XBackground_loop_Set_frame_size(&BLoopInstance, frame_size);

// 		/* ハード動作 */
// 		XBackground_loop_Start(&BLoopInstance);
// 	}

// 	// while (XBackground_loop_IsDone(&BLoopInstance) == 0);
// }


/*
 * 指定アドレスの領域をフレームバッファ領域にコピー
 * ddr_copyの領域をddr_updateにコピーする
 */
/**
 * @brief  指定アドレスの領域を指定アドレスの領域にコピーする
 * @note   
 * @param  ddr_copy: コピー元のDRAMのアドレス
 * @param  ddr_update: コピー先のDRAMのアドレス
 * @param  width: コピーのxサイズ
 * @param  height: コピーのyサイズ
 * @param  video_width: 画面の横サイズ
 * @retval None
 */
void framebuffer_copy(int ddr_copy, int ddr_update, int width, int height, int video_width)
{
	/* DDRメモリのアドレスを設定 */
	XFramebuffer_copy_Set_copy(&FramebufferInstance, ddr_copy);
	XFramebuffer_copy_Set_update(&FramebufferInstance, ddr_update);

	/* 描画サイズを設定 */
	XFramebuffer_copy_Set_width(&FramebufferInstance, width);
	XFramebuffer_copy_Set_height(&FramebufferInstance, height);
	XFramebuffer_copy_Set_display_xsize(&FramebufferInstance, video_width);

	/* ハード動作 */
	XFramebuffer_copy_Start(&FramebufferInstance);
	while (XFramebuffer_copy_IsDone(&FramebufferInstance) == 0);
}


/*
 * 指定領域を指定の色で塗りつぶし
 */
void patblt(int dstout, int xpos, int ypos, int width, int height, int color)
{
	XPatbit_Set_dstout(&PatInctance, dstout);
	XPatbit_Set_xpos(&PatInctance, xpos);
	XPatbit_Set_ypos(&PatInctance, ypos);
	XPatbit_Set_width(&PatInctance, width);
	XPatbit_Set_height(&PatInctance, height);
	XPatbit_Set_color(&PatInctance, color);
	XPatbit_Start(&PatInctance);
	while (XPatbit_IsDone(&PatInctance) == 0);
}


#ifdef HARDWARE_DRAM_ACCESS
/**
 * @brief  アフィン変換の拡大縮小ハード処理
 * @note   
 * @retval None
 */
void affine_scale(GameWrapper *const game)
{
	XAffine_scale_Set_srcin(&ScaleInstance, game->mapchip.srcin);
	XAffine_scale_Set_dstin(&ScaleInstance, game->mapchip.dstin);
	XAffine_scale_Set_dstout(&ScaleInstance, game->mapchip.dstout);
	XAffine_scale_Set_mapchip_maxwidth(&ScaleInstance, game->mapchip.maxwidth);
	XAffine_scale_Set_mapchip_maxheight(&ScaleInstance, game->mapchip.maxheight);
	XAffine_scale_Set_mapchip_draw_xsize(&ScaleInstance, game->mapchip.draw_xsize);
	XAffine_scale_Set_mapchip_draw_ysize(&ScaleInstance, game->mapchip.draw_ysize);
	XAffine_scale_Set_frame_size(&ScaleInstance, game->mapchip.frame_size);
	XAffine_scale_Set_xstart_pos(&ScaleInstance, game->mapchip.xstart_pos);
	XAffine_scale_Set_ystart_pos(&ScaleInstance, game->mapchip.ystart_pos);
	XAffine_scale_Set_alpha(&ScaleInstance, game->mapchip.alpha);
	XAffine_scale_Set_id(&ScaleInstance, game->mapchip.id);
	XAffine_scale_Set_a(&ScaleInstance, game->mapchip.a);
	XAffine_scale_Set_b(&ScaleInstance, game->mapchip.b);
	XAffine_scale_Set_c(&ScaleInstance, game->mapchip.c);
	XAffine_scale_Set_d(&ScaleInstance, game->mapchip.d);
	XAffine_scale_Set_m(&ScaleInstance, game->mapchip.m);
	XAffine_scale_Set_n(&ScaleInstance, game->mapchip.n);
	XAffine_scale_Start(&ScaleInstance);
	while (XAffine_scale_IsDone(&ScaleInstance) == 0);
}
#endif


/**
 * @brief  アフィン変換のソフトウェア処理を行う場合に使用する
 */
#ifdef SOFTWARE_DRAM_ACCESS




/**
 * @brief  アフィン変換の拡大縮小処理
 * 
 * @note   行列の計算で描画座標を求めてから逆数の計算を行う必要があるため変数がたくさんになった
 *         計算の順番は下記の通りである
 *		   1. 行列Aと平行移動量mとnを決める
 *         2. 行列Aの逆行列A−1を求める
 *         3. アフィン変換後座標(X, Y)からアフィン変換前座標(x, y)を求める（必要に応じて補間を行う）
 *         4. アフィン変換前座標(x, y)の画素値に基づいてアフィン変換後座標(X, Y)に画素値を代入（画素の移動）
 *         5.全てのアフィン変換後座標(X, Y)に画素値が代入されるまでSTEP.3に戻る（STEP.3とSTEP.4を繰り返す）
 * 
 * メンバのデータ設定例、反転描画の場合
 * a 100
 * b 0
 * c 0
 * d -100
 * m 0
 * n 0
 * 
 * 指定座標ズームアップの場合
 * a,dの加算に合わせて、ズームを行いたい座標方向にmとnを加算、又は減算を行う
 * a 100 ~ 加算
 * b 0
 * c 0
 * d 100 ~ 加算
 * m 0 ~ +-
 * n 0 ~ +-
 * 
 * @retval None
 */
void affine_scale(GameWrapper *const game)
{
	int32_t a   = (game->mapchip.a << FIX_POS_12) / DIG_100;	/* アフィン変換の行列計算を固定少数倍しておく */
	int32_t b   = (game->mapchip.b << FIX_POS_12) / DIG_100;	/* アフィン変換の行列計算を固定少数倍しておく */
	int32_t c   = (game->mapchip.c << FIX_POS_12) / DIG_100;	/* アフィン変換の行列計算を固定少数倍しておく */
	int32_t d   = (game->mapchip.d << FIX_POS_12) / DIG_100;	/* アフィン変換の行列計算を固定少数倍しておく */
	int32_t det = (a * d) - (b * c); /* 逆行列計算保持メンバ */

	if (det == 0)
	{
		return;
	}

	det >>= FIX_POS_12;
	int32_t ia = (d  << FIX_POS_12) / det;	/* 逆行列計算保持メンバ */
	int32_t ib = (-b << FIX_POS_12) / det;	/* 逆行列計算保持メンバ */
	int32_t ic = (-c << FIX_POS_12) / det;	/* 逆行列計算保持メンバ */
	int32_t id = ( a << FIX_POS_12) / det;	/* 逆行列計算保持メンバ */

	if (a < 0)
	{
		game->mapchip.m--;
	}

	if (d < 0)
	{
		game->mapchip.n--;
	}

	/* ループ外で計算可能な処理は予め計算結果を保存しておくようにした */
	uint32_t chip      = (game->mapchip.maxwidth * game->mapchip.maxheight * (uint32_t)game->mapchip.id);
	int32_t max_height = game->mapchip.maxheight >> 1;
	int32_t max_width  = game->mapchip.maxwidth  >> 1;
	int32_t result_a   = game->mapchip.m * ia;
	int32_t result_ab  = result_a - (game->mapchip.n * ib);
	int32_t result_c   = game->mapchip.m * ic;
	int32_t result_cd  = result_c - (game->mapchip.n * id);
	int32_t xcount     = (game->mapchip.a - DIG_100) + game->mapchip.maxwidth;	/* x軸のループ最大値、拡大縮小に応じてループの処理回数も変更される */
	int32_t ycount     = (game->mapchip.d - DIG_100) + game->mapchip.maxheight;	/* y軸のループ最大値、拡大縮小に応じてループの処理回数も変更される*/
	uint32_t *dstout   = (uint32_t *)game->mapchip.dstout;
	uint32_t *dstin    = (uint32_t *)game->mapchip.dstin;
	uint32_t *srcin    = (uint32_t *)game->mapchip.srcin;

	for (int32_t y = 0; y < ycount; y++)
	{
		int32_t affine_y  = y - max_height;	/* 原点0基準の値に変換 */
		int32_t result_yb = (affine_y * ib) - result_ab + (max_width << FIX_POS_12);
		int32_t result_yd = (affine_y * id) - result_cd + (max_width << FIX_POS_12);
		int32_t ypos = DISPLAY_YPOS(y, VIDEO_WIDTH);

		for (int32_t x = 0; x < xcount; x++)
		{
			int32_t affine_x = x - max_width;				/* 原点0基準の値に変換 */
			int32_t rx = (affine_x * ia) + result_yb;		/* 元画像の横座標を計算し座標返還を行い原点基準の値に変換 */
			int32_t ix = (rx + NEAREST_FIX) >> FIX_POS_12;	/* 補完 */

			if ((ix < 0) || (game->mapchip.maxwidth <= ix)) /* x軸のインデックスをオーバーしていたら書き込みを行わない */
			{
				continue;
			}

			int32_t ry = (affine_x * ic) + result_yd;
			int32_t iy = (ry + NEAREST_FIX) >> FIX_POS_12;

			if ((iy < 0) || (game->mapchip.maxheight <= iy)) /* y軸のインデックスをオーバーしていたら書き込みを行わない */
			{
				continue;
			}

			dstout[x + ypos] = color_generate(srcin[chip + DISPLAY_POS(ix, iy, game->mapchip.maxwidth)], dstin[x + ypos], game->mapchip.alpha);
			// dstout[x + (y * VIDEO_WIDTH)] = ddr_read[ix + (iy * game->mapchip.maxwidth)];
		}
	}

	Xil_DCacheFlushRange(game->mapchip.dstout, DISPLAY_FLASH_RANGE(ycount, MAX_V_WIDTH));
}

#endif

/**
 * @brief  透過処理を含んだ色データの合成値を計算し取得
 * @note   
 * @param  src: 基本色データ
 * @param  dst: 合成用の色データ
 * @param  alpha: 透過データ 0で消える
 * @retval 
 */
static uint32_t color_generate(uint32_t src, uint32_t dst, uint8_t alpha)
{
    uint32_t src_a = (src >> 24) & 0xff;
	uint32_t src_r = (src >> 16) & 0xff;
	uint32_t src_b = (src >> 8) & 0xff;
	uint32_t src_g = src & 0xff;
    uint32_t dst_r = (dst >> 16) & 0xff;
    uint32_t dst_b = (dst >> 8) & 0xff;
    uint32_t dst_g = dst & 0xff;

    dst_r = ((src_a * src_r) + ((COLOR_ALPHA_MAX - src_a) * dst_r)) / COLOR_ALPHA_MAX;
    dst_b = ((src_a * src_b) + ((COLOR_ALPHA_MAX - src_a) * dst_b)) / COLOR_ALPHA_MAX;
    dst_g = ((src_a * src_g) + ((COLOR_ALPHA_MAX - src_a) * dst_g)) / COLOR_ALPHA_MAX;
    dst_r = (alpha * dst_r) / COLOR_ALPHA_MAX;
    dst_b = (alpha * dst_b) / COLOR_ALPHA_MAX;
    dst_g = (alpha * dst_g) / COLOR_ALPHA_MAX;
    uint32_t color = ((dst_r << 16) & 0xff0000) | ((dst_b << 8) & 0x00ff00) | (dst_g & 0xff);

    return color;
}


/**
 * @brief  アフィン変換によるディスプレイの回転動作
 * @note   
 * @retval None
 */
void affine_roulette(GameWrapper *const game)
{
	int32_t m0, n0;
	uint32_t chip      = (game->mapchip.maxwidth * game->mapchip.maxheight * (uint32_t)game->mapchip.id);
	int32_t max_width  = game->mapchip.maxwidth  >> 1;	/* ループ内で計算を行うと無駄になるためループ外で予め計算しておく */
	int32_t max_height = game->mapchip.maxheight >> 1;	/* ループ内で計算を行うと無駄になるためループ外で予め計算しておく */
	int32_t width      = max_width  << FIX_POS_16;		/* ループ内で計算を行うと無駄になるためループ外で予め計算しておく */
	int32_t height     = max_height << FIX_POS_16;		/* ループ内で計算を行うと無駄になるためループ外で予め計算しておく */
	int32_t sin_curve  = fetch_dram_db(game, MEMORY_SIN_ID, 0, game->mapchip.rad);
	int32_t cos_curve  = fetch_dram_db(game, MEMORY_COS_ID, 65536, game->mapchip.rad);
	uint32_t *dstout   = (uint32_t *)game->mapchip.dstout;
	uint32_t *dstin    = (uint32_t *)game->mapchip.dstin;
	uint32_t *srcin    = (uint32_t *)game->mapchip.srcin;

	for (int32_t y = 0; y < game->mapchip.maxheight; y++)
	{
		int32_t ysin = ((y - max_height) * sin_curve) + width;
		int32_t ycos = ((y - max_height) * cos_curve) + height;
		int32_t ypos = DISPLAY_YPOS(y, VIDEO_WIDTH);

		for (int32_t x = 0; x < game->mapchip.maxwidth; x++)
		{
			m0 =  ((x - max_width) * cos_curve) + ysin;
			n0 = -((x - max_width) * sin_curve) + ycos;
			m0 = ((m0 + NEAREST_FIX_16) >> FIX_POS_16);
			n0 = ((n0 + NEAREST_FIX_16) >> FIX_POS_16) - 1; /* インデックスがデフォルトでオーバーするため-1する */

			if ((m0 < 0) || (game->mapchip.maxwidth <= m0))
			{
				continue;
			}

			if ((n0 < 0) || (game->mapchip.maxheight <= n0))
			{
				continue;
			}

			dstout[x + ypos] = color_generate(srcin[chip + DISPLAY_POS(m0, n0, game->mapchip.maxwidth)], dstin[x + ypos], game->mapchip.alpha);
		}
	}

	Xil_DCacheFlushRange(game->mapchip.dstout, DISPLAY_FLASH_RANGE(game->mapchip.maxheight, MAX_V_WIDTH));
}