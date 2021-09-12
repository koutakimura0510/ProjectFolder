/*
 * Create 2021/09/03
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * Build  gcc ver7.5.0
 * Borad  non
 * -
 * 固定少数で計算するアフィン変換サンプルプログラム
 * 
 */
#include <stdio.h>
#include <string.h>
#include <stdint.h>

/* bitmapのサイズ */
#define BITMAP_WIDTH	(20)
#define BITMAP_HEIGHT	(20)

/* 固定少数 */
#define FIX_12			(4096)
#define FIX_POS_12		(12)

/* 最近傍補間の値 0.5 * 固定少数 * 10 */
#define NEAREST_FIX		((5 << 12) / 10)


/* アフィン変換用のサンプル画像データ */
static uint32_t bitmap[BITMAP_WIDTH][BITMAP_HEIGHT];

/* アフィン変換後の画像データ保存 */
static uint32_t affine[BITMAP_WIDTH][BITMAP_HEIGHT];


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
			printf("%2d ", buffer[y][x]);
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
			bitmap[i][j] = j + i;
		}
	}

	bitmap_print(bitmap);
}


/**
 * @brief  アフィン変換
 * @note   
 * @retval None
 */
static void affine_reverse(void)
{
	int a = (50 << FIX_POS_12) / 100;
	int b = (0  << FIX_POS_12) / 100;
	int c = (0  << FIX_POS_12) / 100;
	int d = (50 << FIX_POS_12) / 100;
	int det = (a * d) - (b * c);
	int ia = ( d << FIX_POS_12) / (det >> FIX_POS_12);
	int ib = (-b << FIX_POS_12) / (det >> FIX_POS_12);
	int ic = (-c << FIX_POS_12) / (det >> FIX_POS_12);
	int id = ( a << FIX_POS_12) / (det >> FIX_POS_12);
	int m = 0;
	int n = 0;

	if (a < 0)
	{
		m--;
	}

	if (d < 0)
	{
		n--;
	}

	for (int y = 0; y < BITMAP_HEIGHT; y++)
	{
		int affine_y = y - (BITMAP_HEIGHT >> 1);
		for (int x = 0; x < BITMAP_WIDTH; x++)
		{
			int affine_x = x - (BITMAP_WIDTH >> 1);
			int rx = (affine_x * ia) + (affine_y * ib) - (m * ia) - (n * ib) + ((BITMAP_WIDTH >> 1) << FIX_POS_12);
			int ix = (rx + NEAREST_FIX) >> FIX_POS_12;

			if (ix >= BITMAP_WIDTH || ix < 0)	/* データをオーバーしていたら書き込みを行わない */
			{
				continue;
			}

			int ry = (affine_x * ic) + (affine_y * id) - (m * ic) - (n * id) + ((BITMAP_HEIGHT >> 1) << FIX_POS_12);
			int iy = (ry + NEAREST_FIX) >> FIX_POS_12;

			if (iy >= BITMAP_HEIGHT || iy < 0)	/* データをオーバーしていたら書き込みを行わない */
			{
				continue;
			}

			affine[y][x] = bitmap[iy][ix];
		}
	}

	bitmap_print(affine);
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
	bitmap_ganerate();
	affine_reverse();

	return 0;
}
