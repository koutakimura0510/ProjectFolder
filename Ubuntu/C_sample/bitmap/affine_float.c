/*
 * Create 2021/09/03
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * Build  gcc ver7.5.0
 * Borad  non
 * -
 * 浮動小数で計算するアフィン変換サンプルプログラム
 */
#include <stdio.h>
#include <string.h>
#include <stdint.h>

/* bitmapのサイズ */
#define BITMAP_WIDTH	(20)
#define BITMAP_HEIGHT	(20)

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
 * @brief  アフィン変換のリバース処理
 * @note   STEP1. 行列Aと平行移動量mとnを求める
 *         STEP2. 行列Aの逆行列A-1を求める
 *         STEP3. アフィン変換後座標(X, Y)からアフィン変換前座標(x,y)を求める
 *         STEP4. アフィン変換前座標(x, y)の画素値に基づいてアフィン変換後座標(X, Y)に画素値を代入（画素の移動）
 *         STEP5. 全てのアフィン変換後座標(X, Y)に画素値が代入されるまでSTEP.3に戻る（STEP.3とSTEP.4を繰り返す）
 * @retval None
 */
static void affine_reverse(void)
{
	int oX, oY;		/* アフィン返還後の座標 */
	int noX, noY;
	int ix, iy;		/* 元画像の座標 */
	double rx, ry;  /* 元画像の座標実数 */
	double a = 1.0;
	double b = 0.5;
	double c = 0.5;
	double d = 1.0;
	int m    = 0;
	int n    = 0;
	double det;
	double ia;
	double ib;
	double ic;
	double id;

	/* 逆行列の計算 */
	det = (a * d) - (b * c);
	if (det == 0)
	{
		printf("det 0 !!\n");
		return;
	}

	ia =  d / det;
	ib = -b / det;
	ic = -c / det;
	id =  a / det;

	for (oY = 0; oY < BITMAP_HEIGHT; oY++)
	{
		noY = oY - (BITMAP_HEIGHT / 2);

		for (oX = 0; oX < BITMAP_WIDTH; oX++)
		{
			noX = oX - (BITMAP_WIDTH / 2);
			rx = (double)noX * ia + (double)noY * ib - (double)m * ia - (double)n * ib + (double)BITMAP_WIDTH / 2.0;
			ix = (int)(rx + 0.5)-1;

			if (ix >= BITMAP_WIDTH || ix < 0)
			{
				continue;
			}

			ry = (double)noX * ic + (double)noY * id - (double)m * ic - (double)n * id + (double)BITMAP_HEIGHT / 2.0;
			iy = (int)(ry + 0.5)-1;

			if (iy >= BITMAP_HEIGHT || iy < 0)
			{
				continue;
			}

			for (int k = 0; k < 1; k++)
			{
				// affine[oY][1 * (oX + oY * BITMAP_WIDTH) + k] = bitmap[oY][1 * (ix + iy * BITMAP_WIDTH) + k];
				affine[oY][oX] = bitmap[iy][ix];
			}
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
