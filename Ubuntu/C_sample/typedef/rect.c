/*
 * Create 2021/08/17
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * Build  gcc
 * -
 * 構造体の配列にデータを保存する動作確認サンプル
 */

/* インクルードファイル */
#include <stdio.h>

#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))

/*
 * ver1. 2021/08/17
 * 四角形を描画するためのデータを頬保存する構造体
 */
typedef struct sdl_rect
{
	int x, y;
	int w, h;
} SDL_Rect;


/*
 * ver1. 2021/08/17
 * SDL_Rectのメンバに保存されているデータを出力
 */
void sdl_printf(SDL_Rect *rect, int index)
{
	for (int i = 0; i < index; i++, rect++)
	{
		printf("%d, %d, %d, %d\n", rect->x, rect->y, rect->w, rect->h);
	}
}


/*
 * ver1. 2021/08/17
 * main関数、
 */
int main(void)
{
	SDL_Rect rect[4];

	rect[0] = (SDL_Rect){0, 1, 2, 3};
	rect[1] = (SDL_Rect){1, 2, 3, 4};
	rect[2] = (SDL_Rect){2, 3, 4, 5};
	rect[3] = (SDL_Rect){3, 4, 5, 6};
	sdl_printf(rect, NUM(rect));

	SDL_Rect square = {
		.x = 1,
		.y = 1,
		.w = 1,
		.h = 1,
	};
	sdl_printf(&square, 1);

	return 0;
}