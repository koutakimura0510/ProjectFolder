/*
 * Create 2021/09/03
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * Build  gcc ver7.5.0
 * Borad  non
 * -
 * 固定少数で計算するアフィン変換サンプルプログラム
 * 構造体使用version
 */
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include "terminal.h"

/* bitmapのサイズ */
#define BITMAP_WIDTH	(40)
#define BITMAP_HEIGHT	(40)

/* 固定少数 */
#define FIX_12			(4096)
#define FIX_POS_12		(12)

/* 最近傍補間の値 0.5 * 固定少数 * 10 */
#define NEAREST_FIX		((5 << 12) / 10)


/* アフィン変換用のサンプル画像データ */
static uint32_t bitmap[BITMAP_WIDTH][BITMAP_HEIGHT];

/* アフィン変換後の画像データ保存 */
static uint32_t change[BITMAP_WIDTH][BITMAP_HEIGHT];


/**
 * @brief  アフィン変換の計算に使用するメンバを管理
 * @note   
 * @retval None
 * 
 */
typedef struct
{
	int a;		/* 行列1列目の基底ベクトル1 a */
	int b;		/* 行列2列目の基底ベクトル2 b */
	int c;		/* 行列1列目の基底ベクトル1 c */
	int d;		/* 行列2列目の基底ベクトル2 d */
	int m;		/* 平行移動量m */
	int n;		/* 平行移動量n */
	int det;	/* 逆行列計算保持メンバ */
	int ia;		/* 逆行列計算保持メンバ */
	int ib;		/* 逆行列計算保持メンバ */
	int ic;		/* 逆行列計算保持メンバ */
	int id;		/* 逆行列計算保持メンバ */
} AffineConfig;

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
				printf("%2d ", buffer[y][x]);
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
	printf("形成した元画像データを表示します\n\n");

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
 * @brief  アフィン変換
 * @note   
 * @retval None
 */
static void affine_reverse(AffineConfig *const affine)
{
	affine->a = (affine->a << FIX_POS_12) / 100;
	affine->b = (affine->b << FIX_POS_12) / 100;
	affine->c = (affine->c << FIX_POS_12) / 100;
	affine->d = (affine->d << FIX_POS_12) / 100;
	affine->det = (affine->a * affine->d) - (affine->b * affine->c);

	if (affine->det == 0)
	{
		return;
	}

	affine->ia = ( affine->d << FIX_POS_12) / (affine->det >> FIX_POS_12);
	affine->ib = (-affine->b << FIX_POS_12) / (affine->det >> FIX_POS_12);
	affine->ic = (-affine->c << FIX_POS_12) / (affine->det >> FIX_POS_12);
	affine->id = ( affine->a << FIX_POS_12) / (affine->det >> FIX_POS_12);


	if (affine->a < 0)
	{
		affine->m--;
	}

	if (affine->d < 0)
	{
		affine->n--;
	}

    int32_t result_ab = (affine->m * affine->ia) - (affine->n * affine->ib);
    int32_t result_cd = (affine->m * affine->ic) - (affine->n * affine->id);
    int32_t result_width  = (BITMAP_WIDTH  >> 1);
    int32_t result_height = (BITMAP_HEIGHT >> 1);
    int32_t result_width_fix  = ((result_width  << FIX_POS_12) + NEAREST_FIX) - result_ab;
    int32_t result_height_fix = ((result_height << FIX_POS_12) + NEAREST_FIX) - result_cd;

	for (int32_t y = 0; y < BITMAP_HEIGHT; y++)
	{
	    int32_t result_yb = ((y - result_height) * affine->ib) + result_width_fix;
        int32_t result_yd = ((y - result_height) * affine->id) + result_height_fix;
		
		for (int32_t x = 0; x < BITMAP_WIDTH; x++)
		{
			int32_t rx  = (((x - result_width) * affine->ia) + result_yb) >> FIX_POS_12;
			int32_t ry  = (((x - result_width) * affine->ic) + result_yd) >> FIX_POS_12;

			if ((rx < 0) || (BITMAP_WIDTH <= rx))	/* x軸のインデックスをオーバーしていたら書き込みを行わない */
			{
				continue;
			}

			if ((ry < 0) || (BITMAP_HEIGHT <= ry))	/* y軸のインデックスをオーバーしていたら書き込みを行わない */
			{
				continue;
			}

			change[y][x] = bitmap[ry][rx];
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
	CLEAR_SCREEN();
	bitmap_ganerate();

	int sw = 0;
	int x = 100;
	int y = 100;

	for (uint8_t i = 0; i < 1000; i++)
	{
		usleep(50000);

		switch (sw)
		{
		case 0:
			x -= 10;
			y -= 10;
			if (x == 0)
			{
				sw = 1;
			}
			break;

		case 1:
			x += 10;
			y += 10;
			if (x == 100)
			{
				sw = 0;
			}
			break;

		default:
			break;
		}

		CLEAR_SCREEN();
		SET_PLACE(0, 0);
		affine_reverse(&(AffineConfig){x, 0, 0, y, 0, 0});
	}

	return 0;
}
