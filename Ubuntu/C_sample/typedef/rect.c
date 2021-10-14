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

static SDL_Rect global_rect = (SDL_Rect){1, 1, 1, 1,};

/*
 * SDL_Rectのメンバに保存されているデータを出力
 */
void sdl_printf(SDL_Rect *rect, int index)
{
	for (int i = 0; i < index; i++, rect++)
	{
		printf("%d, %d, %d, %d\n", rect->x, rect->y, rect->w, rect->h);
	}
}

void point(SDL_Rect *const a)
{
	printf("%d\n", a->x);
	printf("%d\n", a->y);
	printf("%d\n", a->w);
	printf("%d\n", a->h);
}

/*
 * main関数、
 */
int main(void)
{
	SDL_Rect rect[2];


	/* 複合リテラル初期化 その１ */
	rect[0] = (SDL_Rect){0, 1, 2, 3};
	rect[1] = (SDL_Rect){global_rect.x, global_rect.y, 3, 4};
	sdl_printf(rect, NUM(rect));


	/* 一括初期化 その１*/
	SDL_Rect round = rect[1];
	sdl_printf(&round, 1);


	/* 一括初期化 その２ */
	SDL_Rect triangle = {10, 20, 30, 40};
	sdl_printf(&triangle, 1);


	/* 複合リテラル初期化 その２ */
	SDL_Rect square = {
		.x = 3,
		.y = rect[1].y,
		.w = 1,
		.h = square.x + square.y,
	};
	sdl_printf(&square, 1);

	point((SDL_Rect){0, 1, 2, 3});


	/* 複合リテラル初期化 その３ */
	SDL_Rect rhombus = (SDL_Rect){
		global_rect.x,
		global_rect.y,
		global_rect.h,
		global_rect.w,
	};

	rhombus = (SDL_Rect){square.x, square.y, square.h, square.w};
	sdl_printf(&rhombus, 1);

	return 0;
}