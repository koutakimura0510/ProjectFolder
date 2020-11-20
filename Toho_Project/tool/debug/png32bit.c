/**-------------------------------------------------
 * SDLを用いた画像読み込みファイルプログラム
 * 画像ファイル特有の、ヘッダ・圧縮・ファイルの種類などの判定を行ってくれる
 * Ubuntu LTS 20.04 kimura
 * -------------------------------------------------
 * 実行方法
 * ./program 画像ファイル名.拡張子
 * -------------------------------------------------
 * 扱う画像ファイルの仮定
 * RGBのカラー画像
 * 1画素のR.G.B成分は1バイトであること
 * 画像データは隙間なく並んでいること
 * R.G.Bの順番にデータが格納されていること
 * -------------------------------------------------*/

/**-------------------------------------------------
 * インクルードファイル
 * -------------------------------------------------
 * 最新環境のSDL2をインクルードする
 * 戻り値の値が1,2では異なる場合があるため、処理を行う環境によってファイルを変更する
 * もしバージョン1を使用する場合、Makefileの -ISDL2...の2の部分を消す
 * -------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>
//#include <SDL/SDL.h>
//#include <SDL/SDL_image.h>


/**-------------------------------------------------
 * main関数
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	SDL_Surface *image;	//ピクセルデータを扱う構造体の確保
	SDL_PixelFormat *fmt;
	FILE *fp;
	uint32_t i, j, temp, pixel, pixel_at;
	uint32_t *p;
	uint8_t r, g, b ,alpha;

	if (!argv[1]) {
		fprintf(stderr, "img load error");
		return 1;
	}

	fp = fopen("img.txt", "w");
	image = IMG_Load(argv[1]);

	if (fp == NULL) {
		fprintf(stderr, "file open error");
		return 1;
	}

	if (image == NULL) {
		fprintf(stderr, "img open error");
		return 1;
	}

	fmt = image->format;

	fprintf(stderr, "%dbit\n", fmt->BitsPerPixel);
	fprintf(stderr, "%dbyte\n", fmt->BytesPerPixel);
	SDL_LockSurface(image);
	p = ((uint32_t *)image->pixels);
	SDL_UnlockSurface(image);

	for (i = 0; i < image->h; i++) {
		for (j = 0; j < image->w; j++) {
			pixel_at = (i * (image->w) + j);
			pixel = p[pixel_at];
			//g = p[pixel_at + 1];
			//b = p[pixel_at + 2];
			temp = pixel & fmt->Rmask;
			temp = temp >> fmt->Rshift;
			temp = temp << fmt->Rloss;
			r = (uint8_t)temp;
			temp = pixel & fmt->Gmask;
			temp = temp >> fmt->Gshift;
			temp = temp << fmt->Gloss;
			g = (uint8_t)temp;
			temp = pixel & fmt->Bmask;
			temp = temp >> fmt->Bshift;
			temp = temp << fmt->Bloss;
			b = (uint8_t)temp;
			temp = pixel & fmt->Amask;
			temp = temp >> fmt->Ashift;
			temp = temp << fmt->Aloss;
			alpha = (uint8_t)temp;
			fprintf(stderr, "%3d, %3d = (%3d, %3d, %3d, %3d)\n", i, j, r, g, b, alpha);
			fprintf(fp,     "%3d, %3d = (%3d, %3d, %3d, %3d)\n", i, j, r, g, b, alpha);
		}
	}

	fprintf(stderr, "fmt->BytesPerPixel = %d\n", fmt->BytesPerPixel);
	fprintf(stderr, "image->w = %3d\n", image->w);
	fprintf(stderr, "image->h = %3d\n", image->h);
	fprintf(fp,		"fmt->BytesPerPixel = %d\n", fmt->BytesPerPixel);
	fprintf(fp,		"image->w = %3d\n", image->w);
	fprintf(fp,		"image->h = %3d\n", image->h);

	fclose(fp);
	SDL_Quit();

	return 0;
}
