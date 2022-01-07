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

// #define SDL2_VERSION

// #ifdef SDL2_VERSION
	#include <SDL2/SDL.h>
	#include <SDL2/SDL_image.h>
// #else
	// #include <SDL/SDL.h>
	// #include <SDL/SDL_image.h>
// #endif


/*
 * RGB生成タイプ
 */
typedef enum
{
	XILINX,
	DEFAULT,
} RGB_TYPE;


/*
 * HD画質、1280 x 3 x 15画面のデータ容量を超える場合
 * N_POSの乗数を増やす
 */
#define BUFFER_SIZE (1920 * 1080)


/*
 * インスタンス変数
 */
SDL_Surface *image;
SDL_PixelFormat *fmt;
FILE *fp;


/*
 * ファイル名、保存ディレクトリのパス入力
 */
char dir_path[256] = "./raw/";
char filename[256];
char raw[] = ".raw";
char dat[] = ".dat";
uint8_t color[BUFFER_SIZE];


/*
 * エラー処理関数
 */
void error_fprintf(const char *s, int line)
{
	fprintf(stderr, "[Line] = %d\n", line);
	fprintf(stderr, "[func] = %s\n", s);
}


/*
 * 初期設定関数
 *
 * *path
 * 画像データのパスを入力
 */
int system_init(char *path)
{
	uint32_t count = 0;
	uint32_t file_type;

	/* 解析ファイルのエラーチェック */
	if (!path) {
		fprintf(stderr, "img load error\n");
		error_fprintf(__func__, __LINE__);
		return 1;
	}

	/* 画像データのオープンとエラーチェック */
	image = IMG_Load(path);

	if (image == NULL) {
		fprintf(stderr, "img open error\n");
		error_fprintf(__func__, __LINE__);
		return 1;
	}

	/* 拡張子までアドレスを更新 */
	do
	{
		path++;
	} while (*path != '.');

	/* パスの区切りまでアドレスを戻す */
	do
	{
		path--;
	} while (*path != '/');

	/* '/'の次のアドレスからファイル名のみ抽出 */
	path++;
	while (path[count] != '.')
	{
		filename[count] = path[count];
		count++;
	}

	fprintf(stderr, "\n");
	fprintf(stderr, "作成するファイルの拡張子を選択して下さい。\n");
	fprintf(stderr, "0 = raw, 1 = dat\n");
	scanf("%d", &file_type);

	/* ファイル名と出力先のパスを生成 */
	strcat(dir_path, filename);

	if (file_type == 0) {
		strcat(dir_path, raw);
	} else {
		strcat(dir_path, dat);
	}

	/* ファイルのオープンとエラーチェック */
	fp = fopen(dir_path, "wb");

	if (fp == NULL) {
		fprintf(stderr, "File Open error\n");
		error_fprintf(__func__, __LINE__);
		return 1;
	}

	fprintf(stderr, "ディレクトリにファイルを生成します = %s\n", dir_path);
	fprintf(stderr, "\n");

	return 0;
}


/*
 * RGBを形成
 *
 * type
 * RGBの生成パターンを選択
 */
uint32_t rgb_generate(uint32_t alpha, uint32_t red, uint32_t green, uint32_t blue, uint32_t type)
{
	uint32_t pixel;

	switch (type) {
		case XILINX:
			pixel = alpha;
			pixel = (pixel << 8) | red;
			pixel = (pixel << 8) | blue;
			pixel = (pixel << 8) | green;
			break;

		default:
			pixel = alpha;
			pixel = (pixel << 8) | red;
			pixel = (pixel << 8) | green;
			pixel = (pixel << 8) | blue;
			break;
	}

	return pixel;
}


/*
 * 画像データの読み込み
 *
 * 1. 画像データの先頭アドレス取得
 * 2. 横幅、縦幅の最大値を取得
 * 3. 画像情報をファイルに出力
 * 4. 1pixelの最大バイト数ずつデータを生成、(RGB24bit = 3bytes)
 *
 * 色データの並び順が RGBである、使用するXilinxIPが RBGのためデータ生成を並び変えながら行う
 */
void pixel_generate(void)
{
	uint32_t pixel_wid, pixel_hei, type, memory_type;
	uint8_t *p;

	/* 指定した画像データのアドレスと情報取得 */
	fmt = image->format;
	SDL_LockSurface(image);
	p = ((uint8_t *)image->pixels);
	SDL_UnlockSurface(image);

	/* 画像データの情報出力 */
	fprintf(stderr, "height   = %d\n", image->h);
	fprintf(stderr, "width    = %d\n", image->w);
	fprintf(stderr, "fmt->BytesPerPixel = %dBytes\n", fmt->BytesPerPixel);
	fprintf(stderr, "fmt->BitsPerPixel  = %dbit\n", fmt->BitsPerPixel);
	fprintf(stderr, "\n");

	/* 画像データの切り取り座標とRGB生成パターン選択 */
	fprintf(stderr, "WidthのPixel数を区切る座標をして下さい。\n");
	fprintf(stderr, "0またはwidth以上の場合、最大値を設定します。\n");
	scanf("%d", &pixel_wid);
	fprintf(stderr, "\n");
	fprintf(stderr, "HeightのPixel数を区切る座標をして下さい。\n");
	fprintf(stderr, "0またはheight以上の場合、最大値を設定します。\n");
	scanf("%d", &pixel_hei);
	fprintf(stderr, "\n");
	fprintf(stderr, "RGBの生成タイプを指定して下さい。\n");
	fprintf(stderr, "0 = RBG, 1 = RGB\n");
	scanf("%d", &type);
	fprintf(stderr, "\n");
	fprintf(stderr, "データの保存先を選択して下さい。\n");
	fprintf(stderr, "0 = Flash Memory, 1 = Block RAM\n");
	scanf("%d", &memory_type);

	if ((pixel_hei == 0) || (image->h < pixel_hei))
	{
		pixel_hei = 1;
	}

	if ((pixel_wid == 0) || (image->w < pixel_wid))
	{
		pixel_wid = 1;
	}

	/* 画像データ解析開始 */
	for (uint32_t y = 0; y < image->h / pixel_hei; y++)
	{
		uint32_t ypixel = y * pixel_hei * image->w * fmt->BytesPerPixel;
		for (uint32_t x = 0; x < image->w / pixel_wid; x++)
		{
			uint32_t wpos   = 0;
			uint32_t id_cnt = x + (y * (image->w / pixel_wid));
			uint32_t xpixel = x * pixel_wid * fmt->BytesPerPixel;

			/* 指定範囲のマップチップデータ取得 */
			for (uint32_t j = 0; j < pixel_hei; j++)
			{
				uint32_t cuty = j * image->w * fmt->BytesPerPixel;
				for (uint32_t i = 0; i < pixel_wid; i++)
				{
					uint32_t cutx = i * fmt->BytesPerPixel;
					for (uint32_t rgbx = 0; rgbx < fmt->BytesPerPixel; rgbx++)
					{
						uint32_t pos = rgbx + cutx + cuty + xpixel + ypixel;
						color[wpos] = p[pos];
						wpos++;
					}
				}
			}

			/* RGBデータの生成 */
			for (uint32_t z = 0; z < wpos; z = z + fmt->BytesPerPixel)
			{
				uint32_t pixel;

				if (fmt->BytesPerPixel == 3)
				{
					pixel = rgb_generate(0xff, color[z + 2], color[z + 1], color[z], type);
				}
				else
				{
					pixel = rgb_generate(color[z + 3], color[z], color[z + 1], color[z + 2], type);
				}
				// fprintf(stderr, "ID = %4d, マップチップの切り取り位置 = %4d, color = 0x%08x\n", id_cnt, z / fmt->BytesPerPixel, pixel);

				if (memory_type == 1) {
					fprintf(fp, "%08x\n", pixel);
				} else {
					fprintf(fp, "0x%08x,", pixel);
				}
			}
			fprintf(stderr, "ID = %3d,  マップチップのサイズ = %4d\n", id_cnt, wpos / fmt->BytesPerPixel);

			/* マップチップデータの切り取りが終了したら改行する */
			if (memory_type == 0) {
				fprintf(fp, "\n");
			}
		}
	}

	fclose(fp);
	SDL_Quit();
}

/*
 * ver1. 2021/07/10
 * sdlのpng設定
 */
static void sdl_init(void)
{
	int32_t flags = IMG_INIT_JPG | IMG_INIT_PNG;
	int32_t initted = IMG_Init(flags);

	if ((initted & flags) != flags) {	//png jpgを使用可能にする
		fprintf(stderr, "IMG Init: %s\n", IMG_GetError());
	}

	if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
		fprintf(stderr, "SDL Init ERROR!: %s\n", SDL_GetError());
	}
}



/*
 * main関数
 */
int main(int argc, char **argv)
{
	if (0 != system_init(argv[1])) {
		fclose(fp);
		SDL_Quit();
		return 1;
	}

	sdl_init();
	pixel_generate();
	fprintf(stderr, "ファイルを出力しました %s\n", dir_path);

	return 0;
}
