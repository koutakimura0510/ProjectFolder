/**-------------------------------------------------
 * ファイル操作をまとめたファイル
 * -------------------------------------------------*/

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include "../include/FILE.H" 


/**-------------------------------------------------
 * 保存したいデータをバイナリファイルに書き込む
 * -------------------------------------------------*/
bool bin_write(const char *filepath, uint32_t *framebuffer, uint32_t maxwidth, uint32_t maxheight)
{
	FILE *fp = NULL;
	uint32_t mapsize;

	fp = fopen(filepath, "wb");

	if (fp == NULL) {
		fprintf(stderr, "fiel open error = %s", filepath);
		fclose(fp);
		return false;
	}

	mapsize = maxwidth * maxheight;
	fwrite(framebuffer, sizeof(uint32_t), mapsize, fp);
	fprintf(stderr, "セーブ完了 = %s", filepath);
	fclose(fp);

	return true;
}


/**-------------------------------------------------
 * バイナリファイルのデータをフレームバッファに読み込む
 * -------------------------------------------------*/
bool bin_read(const char *filepath, uint32_t *framebuffer, uint32_t maxwidth, uint32_t maxheight)
{
	FILE *fp = NULL;
	uint32_t mapsize;

	fp = fopen(filepath, "rb");

	if (fp == NULL) {
		fprintf(stderr, "fiel read error = %s", filepath);
		fclose(fp);
		return false;
	}

	mapsize = maxwidth * maxheight;
	fread(framebuffer, sizeof(uint32_t), mapsize, fp);
	fprintf(stderr, "データ読み込み完了 = %s", filepath);
	fclose(fp);

	return true;
}

