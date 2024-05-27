/*
 * Create 2021/09/03
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * Build  gcc ver7.5.0
 * Borad  non
 * -
 * 固定少数で計算するアフィン変換サンプルプログラム
 * 回転バージョン
 */
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include "sin_cos.h"
#include "terminal.h"


/* bitmapのサイズ */
#define BITMAP_WIDTH	(30)
#define BITMAP_HEIGHT	(30)

/* 固定少数 */
#define FIX_12			(4096)
#define FIX_POS_12		(12)
#define FIX_16			(65536)
#define FIX_POS_16		(16)

/* 最近傍補間の値 0.5 * 固定少数 * 10 */
#define NEAREST_FIX		((5 << FIX_POS_12) / 10)	/* 拡大縮小 */
#define NEAREST_FIX_16	((5 << FIX_POS_16) / 10)	/* 回転用 */


/* アフィン変換用のサンプル画像データ */
static uint32_t bitmap[BITMAP_WIDTH][BITMAP_HEIGHT];

/* アフィン変換後の画像データ保存 */
static uint32_t change[BITMAP_WIDTH][BITMAP_HEIGHT];


/**
 * @brief  bufferの中身を出力する
 * @note   
 * @param  *buffer: 配列のアドレス
 * @retval None
 */
static void bitmap_print(uint32_t buffer[][BITMAP_HEIGHT])
{
	for (int y = 0; y < BITMAP_WIDTH; y++)
	{
		for (int x = 0; x < BITMAP_HEIGHT; x++)
		{
			if (buffer[y][x] == 0)
			{
				printf("  ");
			}
			else
			{
				if (buffer[y][x] < 8)
				{
					SET_CHAR_COLOR(RED);
					// printf("%2d ", buffer[y][x]);
					printf("%s ", "■");
				}
				else
				{
					SET_CHAR_COLOR(BLACK);
					// printf("%2d ", buffer[y][x]);
					printf("%s ", "■");
				}
			}
		}
		printf("\n");
	}
	printf("\n\n");
}


/**
 * @brief  bitmapのサンプル画像データの生成
 * @note   
 * @retval None
 */
static void bitmap_ganerate(void)
{
	for (uint8_t i = 0; i < BITMAP_WIDTH; i++)
	{
		for (uint8_t j = 0; j < BITMAP_HEIGHT; j++)
		{
			bitmap[i][j] = j;
		}
	}

	bitmap_print(bitmap);
}


/**
 * @brief  回転のアフィン変換
 * @note   画素間の補正は最近傍補間を使用
 * @retval None
 */
static void affine_skewe(int32_t radt, int32_t radp)
{
	int32_t m0, n0;
	int32_t deno = 1 - ((tan_table[radt] * tan_table[radp])) >> FIX_POS_16;
	radt = tan_table[radt];
	radp = tan_table[radp];

	int32_t skewe_width  = (BITMAP_WIDTH  + (BITMAP_HEIGHT * radt)) >> FIX_POS_16;
	int32_t skewe_height = (BITMAP_HEIGHT + (BITMAP_WIDTH * radp)) >> FIX_POS_16;

	for (int32_t y = 0; y < skewe_height; y++)
	{
		int32_t nn = y - (skewe_height >> 1);

		for (int32_t x = 0; x < skewe_width; x++)
		{
			int32_t nm = x - (skewe_width >> 1);
			m0 = ((nm - nn * radt) / deno)  + ((BITMAP_WIDTH / 2) << FIX_POS_16);
			n0 = ((-nm * radp + nn) / deno) + ((BITMAP_HEIGHT / 2) << FIX_POS_16);
			m0 = ((m0 + NEAREST_FIX_16) >> FIX_POS_16);
			n0 = ((n0 + NEAREST_FIX_16) >> FIX_POS_16) - 1; /* インデックスがデフォルトとでオーバーするため-1する */

			if ((m0 < 0) || (BITMAP_WIDTH <= m0))
			{
				continue;
			}

			if ((n0 < 0) || (BITMAP_HEIGHT <= n0))
			{
				continue;
			}

			change[y][x] = bitmap[n0][m0];
		}
	}

	bitmap_print(change);

	for (uint8_t i = 0; i < BITMAP_HEIGHT; i++)
	{
		for (uint8_t j = 0; j < BITMAP_WIDTH; j++)
		{
			change[i][j] = 0;
		}
	}
}

/**
 * @brief  アフィン変換処理
 * @note   
 * @param  argc: non
 * @param  *argv[]: non
 * @retval 
 * 
 * アフィン変換公式
 * 
 * (X) = (a b) (x) + (m)
 * (Y)   (c d) (y)   (n)
 */
int main(int argc, char const *argv[])
{
	SET_PLACE(0, 0);
	bitmap_ganerate();
	CLEAR_SCREEN();
	affine_skewe(30, 15);

	return 0;
}
