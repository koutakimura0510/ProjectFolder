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

/**-------------------------------------------------
 * Map Chip ID
 * -------------------------------------------------*/
#define	STANDERD_S		0
#define	STANDERD_MAP0  (STANDERD_S+0)
#define	STANDERD_MAP1  (STANDERD_S+1)
#define	STANDERD_MAP2  (STANDERD_S+2)
#define	STANDERD_MAP3  (STANDERD_S+3)
#define	STANDERD_MAP4  (STANDERD_S+4)
#define	STANDERD_MAP5  (STANDERD_S+5)
#define	STANDERD_MAP6  (STANDERD_S+6)
#define	STANDERD_MAP7  (STANDERD_S+7)
#define	STANDERD_MAP8  (STANDERD_S+8)
#define	STANDERD_MAP9  (STANDERD_S+9)
#define	STANDERD_MAP10 (STANDERD_S+10)
#define	STANDERD_MAP11 (STANDERD_S+11)
#define	STANDERD_MAP12 (STANDERD_S+12)
#define	STANDERD_MAP13 (STANDERD_S+13)
#define	STANDERD_MAP14 (STANDERD_S+14)
#define	STANDERD_MAP15 (STANDERD_S+15)
#define	STANDERD_MAP16 (STANDERD_S+16)
#define	STANDERD_MAP17 (STANDERD_S+17)
#define	STANDERD_MAP18 (STANDERD_S+18)
#define	STANDERD_MAP19 (STANDERD_S+19)
#define	STANDERD_MAP20 (STANDERD_S+20)
#define	STANDERD_MAP21 (STANDERD_S+21)
#define	STANDERD_MAP22 (STANDERD_S+22)
#define	STANDERD_MAP23 (STANDERD_S+23)
#define	STANDERD_MAP24 (STANDERD_S+24)
#define	STANDERD_MAP25 (STANDERD_S+25)
#define	STANDERD_MAP26 (STANDERD_S+26)
#define	STANDERD_MAP27 (STANDERD_S+27)
#define	STANDERD_MAP28 (STANDERD_S+28)
#define	STANDERD_MAP29 (STANDERD_S+29)
#define	STANDERD_MAP30 (STANDERD_S+30)
#define	STANDERD_MAP31 (STANDERD_S+31)
#define	STANDERD_MAP32 (STANDERD_S+32)
#define	STANDERD_MAP33 (STANDERD_S+33)
#define	STANDERD_MAP34 (STANDERD_S+34)
#define	STANDERD_MAP35 (STANDERD_S+35)
#define	STANDERD_MAP36 (STANDERD_S+36)
#define	STANDERD_MAP37 (STANDERD_S+37)
#define	STANDERD_MAP38 (STANDERD_S+38)
#define	STANDERD_MAP39 (STANDERD_S+39)
#define	STANDERD_MAP40 (STANDERD_S+40)
#define	STANDERD_MAP41 (STANDERD_S+41)
#define	STANDERD_MAP42 (STANDERD_S+42)
#define	STANDERD_MAP43 (STANDERD_S+43)
#define	STANDERD_MAP44 (STANDERD_S+44)
#define	STANDERD_MAP45 (STANDERD_S+45)
#define	STANDERD_MAP46 (STANDERD_S+46)
#define	STANDERD_MAP47 (STANDERD_S+47)
#define	STANDERD_MAP48 (STANDERD_S+48)
#define	STANDERD_MAP49 (STANDERD_S+49)
#define	STANDERD_MAP50 (STANDERD_S+50)
#define	STANDERD_MAP51 (STANDERD_S+51)
#define	STANDERD_MAP52 (STANDERD_S+52)
#define	STANDERD_MAP53 (STANDERD_S+53)
#define	STANDERD_MAP54 (STANDERD_S+54)
#define	STANDERD_MAP55 (STANDERD_S+55)
#define	STANDERD_MAP56 (STANDERD_S+56)
#define	STANDERD_MAP57 (STANDERD_S+57)
#define	STANDERD_MAP58 (STANDERD_S+58)
#define	STANDERD_MAP59 (STANDERD_S+59)
#define	STANDERD_MAP60 (STANDERD_S+60)
#define	STANDERD_MAP61 (STANDERD_S+61)
#define	STANDERD_MAP62 (STANDERD_S+62)
#define	STANDERD_MAP63 (STANDERD_S+63)
#define	STANDERD_MAP64 (STANDERD_S+64)
#define	STANDERD_MAP65 (STANDERD_S+65)
#define	STANDERD_MAP66 (STANDERD_S+66)
#define	STANDERD_MAP67 (STANDERD_S+67)
#define	STANDERD_MAP68 (STANDERD_S+68)
#define	STANDERD_MAP69 (STANDERD_S+69)
#define	STANDERD_MAP70 (STANDERD_S+70)
#define	STANDERD_MAP71 (STANDERD_S+71)
#define	STANDERD_MAP72 (STANDERD_S+72)
#define	STANDERD_MAP73 (STANDERD_S+73)
#define	STANDERD_MAP74 (STANDERD_S+74)
#define	STANDERD_MAP75 (STANDERD_S+75)
#define	STANDERD_MAP76 (STANDERD_S+76)
#define	STANDERD_MAP77 (STANDERD_S+77)
#define	STANDERD_MAP78 (STANDERD_S+78)
#define	STANDERD_MAP79 (STANDERD_S+79)
#define	STANDERD_MAP80 (STANDERD_S+80)
#define	STANDERD_MAP81 (STANDERD_S+81)
#define	STANDERD_MAP82 (STANDERD_S+82)
#define	STANDERD_MAP83 (STANDERD_S+83)
#define	STANDERD_MAP84 (STANDERD_S+84)
#define	STANDERD_MAP85 (STANDERD_S+85)
#define	STANDERD_MAP86 (STANDERD_S+86)
#define	STANDERD_MAP87 (STANDERD_S+87)
#define	STANDERD_E	   (STANDERD_MAP87)
#define	MITI_S (STANDERD_E+1)
#define	MITI0 (MITI_S+0)
#define	MITI1 (MITI_S+1)
#define	MITI2 (MITI_S+2)
#define	MITI3 (MITI_S+3)
#define	MITI4 (MITI_S+4)
#define	MITI_E (MITI4)
#define	MORI_S (MITI_E+1)
#define	MORI0 (MORI_S+0)
#define	MORI1 (MORI_S+1)
#define	MORI2 (MORI_S+2)
#define	MORI3 (MORI_S+3)
#define	MORI4 (MORI_S+4)
#define	MORI_E (MORI4)
#define	SABAKU_S (MORI_E+1)
#define	SABAKU0 (SABAKU_S+0)
#define	SABAKU1 (SABAKU_S+1)
#define	SABAKU2 (SABAKU_S+2)
#define	SABAKU3 (SABAKU_S+3)
#define	SABAKU4 (SABAKU_S+4)
#define	SABAKU_E (SABAKU4)
#define	TUTI_S (SABAKU_E+1)
#define	TUTI0 (TUTI_S+0)
#define	TUTI1 (TUTI_S+1)
#define	TUTI2 (TUTI_S+2)
#define	TUTI3 (TUTI_S+3)
#define	TUTI4 (TUTI_S+4)
#define	TUTI_E (TUTI4)
#define	UMI_S (TUTI_E+1)
#define	UMI0 (UMI_S+0)
#define	UMI1 (UMI_S+1)
#define	UMI2 (UMI_S+2)
#define	UMI3 (UMI_S+3)
#define	UMI4 (UMI_S+4)
#define	UMI_E (UMI4)
#define	YAMA_GRASS_S (UMI_E+1)
#define	YAMA_GRASS0 (YAMA_GRASS_S+0)
#define	YAMA_GRASS1 (YAMA_GRASS_S+1)
#define	YAMA_GRASS2 (YAMA_GRASS_S+2)
#define	YAMA_GRASS3 (YAMA_GRASS_S+3)
#define	YAMA_GRASS4 (YAMA_GRASS_S+4)
#define	YAMA_GRASS_E (YAMA_GRASS4)
#define	YAMA_MOUNTAIN_S (YAMA_GRASS_E+1)
#define	YAMA_MOUNTAIN0 (YAMA_MOUNTAIN_S+0)
#define	YAMA_MOUNTAIN1 (YAMA_MOUNTAIN_S+1)
#define	YAMA_MOUNTAIN2 (YAMA_MOUNTAIN_S+2)
#define	YAMA_MOUNTAIN3 (YAMA_MOUNTAIN_S+3)
#define	YAMA_MOUNTAIN4 (YAMA_MOUNTAIN_S+4)
#define	YAMA_MOUNTAIN_E (YAMA_MOUNTAIN4)
#define	YAMA_STONE_S (YAMA_MOUNTAIN_E+1)
#define	YAMA_STONE0 (YAMA_STONE_S+0)
#define	YAMA_STONE1 (YAMA_STONE_S+1)
#define	YAMA_STONE2 (YAMA_STONE_S+2)
#define	YAMA_STONE3 (YAMA_STONE_S+3)
#define	YAMA_STONE4 (YAMA_STONE_S+4)
#define	YAMA_STONE_E (YAMA_STONE4)

#define END_CHIPID	(YAMA_STONE_E + 1)

#define FIELD_WIDTH		144
#define FIELD_HEIGHT	136
#define WIDTH  150
#define HEIGHT 150
uint32_t array[WIDTH*HEIGHT];

static const uint32_t res[9][2] = {
	{140, UMI4},
	{ 90, YAMA_STONE1},
	{ 33, STANDERD_MAP9},
	{156, YAMA_MOUNTAIN1},
	{107, STANDERD_MAP0},
	{198, SABAKU4},
	{ 74, TUTI4},
	{148, STANDERD_MAP56},
	{ 82, MITI4},
};

uint32_t get_array(uint8_t r);


uint32_t get_array(uint8_t r)
{
	for (uint8_t i = 0; i < 9; i++) {
		if (r == res[i][0]) {
			return res[i][1];
		}
	}

	return UMI4;
}


/**-------------------------------------------------
 * main関数
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	SDL_Surface *image;	//ピクセルデータを扱う構造体の確保
	SDL_PixelFormat *fmt;
	FILE *fp;
	uint32_t i, j, pixel, pixel_at;
	uint8_t *p;
	uint8_t r, g, b;

	if (!argv[1]) {
		fprintf(stderr, "img load error");
		return 1;
	}

	fp = fopen("worldmap.bin", "wb");
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
	p = ((uint8_t *)image->pixels);
	SDL_UnlockSurface(image);

	for (i = 0; i < HEIGHT; i++) {
		for (j = 0; j < WIDTH; j++) {
			array[(i*HEIGHT)+j] = UMI4;
		}
	}

	for (i = 0; i < image->h; i++) {	//24bitはgbrの順で並んでいる
		for (j = 0; j < image->w; j++) {
			pixel_at = (i * (image->w) + j) * 3;

			pixel = p[pixel_at];
			b = (uint8_t)pixel;

			pixel = p[pixel_at+1];
			g = (uint8_t)pixel;

			pixel = p[pixel_at+2];
			r = (uint8_t)pixel;
			array[(i*image->h)+j] = get_array(r);

			//fprintf(stderr, "%3d, %3d = (%3d, %3d, %3d)\n", i, j, r, g, b);
		}
	}

	fprintf(stderr, "fmt->BytesPerPixel = %d\n", fmt->BytesPerPixel);
	fprintf(stderr, "image->w = %3d\n", image->w);
	fprintf(stderr, "image->h = %3d\n", image->h);
	fwrite(array, sizeof(uint32_t), sizeof(array) / sizeof(array[0]), fp);

	fclose(fp);
	SDL_Quit();

	return 0;
}
