/*
 *
 * ワールドマップの雛形作成
 * 
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>
#include "include/COLOR.H"


/*
 * RGB生成タイプ
 */
typedef enum
{
	XILINX,
	DEFAULT,
} RGB_TYPE;


/*
 * インスタンス変数
 */
SDL_Surface *image;
SDL_PixelFormat *fmt;
FILE *fp;


/*
 * ファイル名、保存ディレクトリのパス入力
 */
char dir_path[256] = "./bin/";
char filename[256];
char raw[] = ".bin";


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

	/* ファイル名と出力先のパスを生成 */
	strcat(dir_path, filename);
	strcat(dir_path, raw);

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
 * マップチップID取得
 */
uint32_t get_mapchip_id(uint32_t color)
{
	const GekaiDB *gekai = gekaidb;

	for (uint32_t i = 0; i < GEKAI_SIZE; i++, gekai++)
	{
		if (color == gekai->name)
		{
			return gekai->mapchipid;
		}
	}

	return YAMA;
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
			pixel = alpha & 0x00;
			pixel = (pixel << 8) | red;
			pixel = (pixel << 8) | blue;
			pixel = (pixel << 8) | green;
			break;

		default:
			pixel = alpha & 0x00;
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
    uint32_t count;
    uint32_t color[3];
    uint32_t pixel;
    uint32_t *heap;
	uint8_t *p;

	/* 指定した画像データのアドレスと情報取得 */
	SDL_LockSurface(image);
	SDL_UnlockSurface(image);
	fmt  = image->format;
	p    = ((uint8_t *)image->pixels);
    heap = (uint32_t *)malloc(sizeof(uint32_t) * image->w * image->h);

    if (heap == NULL)
    {
        printf("heap error \n");
        exit(1);
    }


	/* 画像データの情報出力 */
	fprintf(stderr, "height   = %d\n", image->h);
	fprintf(stderr, "width    = %d\n", image->w);
	fprintf(stderr, "fmt->BytesPerPixel = %dBytes\n", fmt->BytesPerPixel);
	fprintf(stderr, "fmt->BitsPerPixel  = %dbit\n", fmt->BitsPerPixel);
	fprintf(stderr, "\n");


    for (uint32_t y = 0; y < image->h; y++)
    {
        for (uint32_t x = 0; x < image->w; x++)
        {
            for (uint32_t n = 0; n < fmt->BytesPerPixel; n++)
            {
                color[n] = (uint8_t)*p;
                p++;
            }

            if (fmt->BytesPerPixel == 3)
            {
                pixel = rgb_generate(0, color[2], color[1], color[0], 1);
            }
            else
            {
                pixel = rgb_generate(color[3], color[2], color[1], color[0], 1);
            }
            count = x + (y * image->w);
            heap[x + (y * image->w)] = get_mapchip_id(pixel);
			// fprintf(fp, "%3d, ", get_mapchip_id(pixel));
        }
		// fprintf(fp, "\n");
    }

	uint32_t mapsize = image->w * image->h;
	fwrite(heap, sizeof(uint32_t), mapsize, fp);
    fprintf(stderr, "ループ回数 = %d\n", count);
	fclose(fp);
	SDL_Quit();
    free(heap);
}


/*
 * main関数
 *
 */
int main(int argc, char **argv)
{
	if (0 != system_init(argv[1])) {
		fclose(fp);
		SDL_Quit();
		return 1;
	}

	pixel_generate();
	printf("binファイル作成完了 = %s\n", dir_path);

	return 0;
}
