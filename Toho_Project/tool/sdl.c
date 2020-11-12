/**-------------------------------------------------
 * SDLを用いた画像読み込みファイルプログラム
 * 画像ファイル特有の、ヘッダ・圧縮・ファイルの種類などの判定を行ってくれる
 * Ubuntu LTS 20.04 kimura
 * -------------------------------------------------*/


/**-------------------------------------------------
 * インクルードファイル
 * -------------------------------------------------
 * 最新環境のSDL2をインクルードする
 * 戻り値の値が1,2では異なる場合があるため、処理を行う
 * 環境によってファイルを変更する
 * -------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>
//#include <SDL/SDL.h>
//#include <SDL/SDL_image.h>


/**-------------------------------------------------
 * main関数
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	SDL_Surface *surface;
	SDL_PixelFormat *fmt;
	SDL_Color *color;
	Uint8 index;

	surface = IMG_Load(argv[1]);

	if (surface == NULL) {
		fprintf(stderr, "img open error");
		return 1;
	}

	//サーフェイス作成
	fmt = surface->format;

	if (fmt->BitsPerPixel != 8) {
		fprintf(stderr, "8bitサーフェイスではない");
		return 1;
	}

	//サーフェイスロック
	SDL_LockSurface(surface);

	//左上角のピクセル入手
	index = *(Uint8 *)surface->pixels;
	color = fmt->palette->colors[index];

	//ロック解除
	SDL_UnlockSurface(surface);

	printf("Pixel Color-> R: %d, G: %d, B: %d, index: %d\n", color->r, color->g, color->b, index);

	fprintf(stderr, "image->format->BytesPerPixel = %d\n", surface->format->BytesPerPixel);
	fprintf(stderr, "image->w = %d\n", surface->w);
	fprintf(stderr, "image->h = %d\n", surface->h);
	SDL_Quit();

	return 0;
}
