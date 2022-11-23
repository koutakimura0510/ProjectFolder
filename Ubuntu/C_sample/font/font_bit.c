/*
 * Create 2021/07/01
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * sjisのfontデータをbitに変換
 */
#include <stdio.h>
#include <stdint.h>
#include "KanjiFont12.h"

/*
 * ver1. 2021/07/01
 * bitフォントサイズ 12 x 12 x 7901文字
 */
#define FONT_SIZEX	(12)
#define FONT_SIZEY	(12)
#define FONT_WIDTH	(144)
#define FONT_HEIGHT	(7901)
#define BUFFER_SIZE	(FONT_WIDTH * FONT_HEIGHT)


/*
 * ver1. 2021/07/01
 * 漢字フォントヘッダーファイルのインデックス参照用定数
 */
#define KANJI_WIDTH		 (24)
#define KANJI_WIDTH_HALF (KANJI_WIDTH >> 1)
#define KANJI_HEIGHT	 (7901)



/* フォントデータ保存用バッファ */
uint32_t font_buff[BUFFER_SIZE];


/*
 * フレームバッファのデータをファイルに書き込む
 */
static void file_write(void)
{
	const char *file = "font_sjis.raw";
	FILE *fp = fopen(file, "wb");

	if (fp == NULL)
	{
		printf("file open error %s\n", file);
		fclose(fp);
		return;
	}
	printf("フォントデータを作成します %s\n", file);

	for (uint32_t y = 0; y < FONT_HEIGHT; y++)
	{
		for (uint32_t x = 0; x < FONT_WIDTH; x++)
		{
			fprintf(fp, "0x%08x,", font_buff[x + (y * FONT_WIDTH)]);
		}
		fprintf(fp, "\n");
	}

	printf("rawファイル作成完了 %s\n", file);
	fclose(fp);
}


/*
 * ver1. 2021/07/01
 * 1byte単位でヘッダーファイルに保存されているフォントデータを1bit単位に分解してグローバル配列に保存
 * 縦方向にデータが並んでいるため、縦方向にデータを保存する
 */
static void font_bit_generate(void)
{
	for (uint32_t y = 0; y < KANJI_HEIGHT; y++)
	{
		uint32_t count = 0;
		uint32_t index = 0;
		for (uint32_t x = 0; x < KANJI_WIDTH; x++)
		{
			uint32_t bit = KanjiFont12[y][x];

			if (x < KANJI_WIDTH_HALF)
			{
				count = 8;
			}
			else
			{
				count = 4;
				index = (FONT_SIZEX * 8) - KANJI_WIDTH_HALF;
			}

			for (uint32_t i = 0; i < count; i++)
			{
				uint32_t color = (~(bit & 0x01) + 1) & 0xffffffff;	//alpha値を含む色データ出力
				font_buff[(i * KANJI_WIDTH_HALF) + (x + index) + (y * FONT_WIDTH)] = color;
				bit >>= 1;
			}
		}
		printf("y = %d\n", y);
	}
}


/*
 * ver1. 2021/07/01
 * メイン関数
 */
int main(int argc, char **argv)
{
	font_bit_generate();
	file_write();

	return 0;
}