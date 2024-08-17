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
#include <stdbool.h>

#define SDL2_VERSION

#ifdef SDL2_VERSION
	#include <SDL2/SDL.h>
	#include <SDL2/SDL_image.h>
#else
	#include <SDL/SDL.h>
	#include <SDL/SDL_image.h>
#endif


/**-----------------------------------------------------------------------------
 * HD画質、1280 x 3 x 15画面のデータ容量を超える場合
 * N_POSの乗数を増やす
 *-----------------------------------------------------------------------------*/
#define BUFFER_SIZE 	(1920 * 1080)
#define CUT_LINE_MAX	(32)

/**-----------------------------------------------------------------------------
 * RGB生成タイプ
 *-----------------------------------------------------------------------------*/
typedef enum
{
	RGB888,
	RGB565,
	DEFAULT,
} RGB_TYPE;


/**-----------------------------------------------------------------------------
 * Pixel Info 構造体
 *-----------------------------------------------------------------------------*/
typedef struct {
	uint32_t pixel_wid;			// 1画像の X軸の切り取り領域指定
	uint32_t pixel_hei;			// 1画像の Y軸の切り取り領域指定
	uint32_t rgb_type;			// RGB 形式
	uint32_t id_cnt;			// 切り抜き領域に ID を割り振る。デバッグ用途。
	uint32_t ypixel_cut;
	uint32_t xpixel_cut;
	uint32_t cut_line;
	uint8_t cut_line_buff[CUT_LINE_MAX];
} PixelInfo;

typedef struct {
	uint8_t alpha;
	uint8_t red;
	uint8_t green;
	uint8_t blue;
} PixelColor888;

typedef struct {
	uint8_t alpha;
	uint8_t msbbyte;
	uint8_t lsbbyte;
} PixelColor565;


/**-----------------------------------------------------------------------------
 * Global
 *-----------------------------------------------------------------------------*/
SDL_Surface *image;
SDL_PixelFormat *fmt;
FILE *fp;


/**-----------------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
void error_fprintf(const char *s, int line);
int file_create(char *path, char *dir_path);
bool mapchip_info_eoc(uint8_t xpos, uint8_t *id_buff);
PixelColor888 mapchip_pixel_gen(uint8_t alpha, uint8_t red, uint8_t green, uint8_t blue, uint8_t type);
uint32_t mapchip_color_upload(PixelInfo *info, uint8_t *color, uint8_t *sdl_pixe, uint32_t byte_per_pixel);
void mapchip_file_save(PixelInfo *info, uint8_t *color, uint32_t wmax, uint32_t byte_per_pixel);
void mapchip_info_save(PixelInfo *info);
void pixel_generate(void);
static void sdl_init(void);


/**-----------------------------------------------------------------------------
 * エラー処理関数
 *-----------------------------------------------------------------------------*/
void error_fprintf(const char *s, int line)
{
	fprintf(stderr, "[Line] = %d\n", line);
	fprintf(stderr, "[func] = %s\n", s);
}


/**-----------------------------------------------------------------------------
 * 初期設定関数
 *
 * *path
 * 画像データのパスを入力
 *-----------------------------------------------------------------------------*/
int file_create(char *path, char *dir_path)
{
	char filename[256] ={'\0'};	// 初期化しないバグ発生
	char bin[] = ".bin"; // 拡張子
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
	strcat(dir_path, bin);

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


/**-----------------------------------------------------------------------------
 * 指定した画像データのくり抜き領域をチェック
 *-----------------------------------------------------------------------------*/
bool mapchip_info_eoc(uint8_t xpos, uint8_t *id_buff)
{
	for (uint8_t i = 0; i < CUT_LINE_MAX; i++) {
		if (xpos == id_buff[i]) {
			return true;
		}
	}

	return false;
}

/**-----------------------------------------------------------------------------
 * RGB888 の色データを RGB565 に間引くか、RGB888 のまま出力する
 * colocr_bit
 *-----------------------------------------------------------------------------*/
PixelColor888 mapchip_pixel_gen(uint8_t alpha, uint8_t red, uint8_t green, uint8_t blue, uint8_t rgb_type)
{
	PixelColor888 pixel;

	switch (rgb_type) {
		case RGB888:
			pixel.alpha = alpha;
			pixel.red = red;
			pixel.green = green;
			pixel.blue = blue;
			break;

		case RGB565:
			pixel.alpha = alpha;
			pixel.red = (red & 0xf8);
			pixel.green = (green & 0xfc);
			pixel.blue = (blue & 0xf8);
			break;

		default:
			break;
	}

	return pixel;
}


/**-----------------------------------------------------------------------------
 * MapChip RGB データのファイル出力
 *-----------------------------------------------------------------------------*/
void mapchip_file_save(PixelInfo *info, uint8_t *color, uint32_t wmax, uint32_t byte_per_pixel)
{
	PixelColor888 pixel;
	PixelColor565 Rgb565;

	for (uint32_t x = 0; x < wmax; x = x + byte_per_pixel) {
		if (byte_per_pixel == 3) {
			pixel = mapchip_pixel_gen(0xff, color[x + 2], color[x + 1], color[x], info->rgb_type);
		}else{
			pixel = mapchip_pixel_gen(color[x + 3], color[x], color[x + 1], color[x + 2], info->rgb_type);
		}

		if (info->rgb_type == RGB888) {
			fwrite(&pixel, sizeof(PixelColor888), 1, fp);
		}else{
			Rgb565.alpha   = pixel.alpha;
			Rgb565.msbbyte = pixel.red | ((pixel.green >> 5) & 0x07);
			Rgb565.lsbbyte = (pixel.green << 3) | (pixel.blue >> 3);
			fwrite(&Rgb565, sizeof(PixelColor565), 1, fp);
		}
	}
	
	fprintf(stderr, "ID = %3d,  マップチップのサイズ = %4d\n", info->id_cnt, wmax / byte_per_pixel);
}

/**-----------------------------------------------------------------------------
 * MapChip 色データ抽出
 *-----------------------------------------------------------------------------*/
uint32_t mapchip_color_upload(PixelInfo *info, uint8_t *color, uint8_t *sdl_pixel, uint32_t byte_per_pixel)
{
	uint32_t wpos = 0;

	for (uint32_t y = 0; y < info->pixel_hei; y++)	{ // 指定範囲のマップチップデータ取得
		uint32_t cuty = y * image->w * byte_per_pixel;

		for (uint32_t x = 0; x < info->pixel_wid; x++) {
			uint32_t cutx = x * byte_per_pixel;

			for (uint32_t rgbx = 0; rgbx < byte_per_pixel; rgbx++) {	// 1pixel の RGB 要素抜き出し
				uint32_t pos = rgbx + cutx + cuty + info->xpixel_cut + info->ypixel_cut;
				color[wpos] = sdl_pixel[pos];
				wpos++;
			}
		}
	}

	return wpos;
}

/**-----------------------------------------------------------------------------
 * MapChip Info Save
 * パラメータ設定を追加する場合は、この関数内に処理追加
 *-----------------------------------------------------------------------------*/
void mapchip_info_save(PixelInfo *info)
{
	/* 画像データの情報出力 */
	fprintf(stderr, "画像ファイルのデータプロジェクトで使用する RAW 又は dat ファイルを生成します。\n");
	fprintf(stderr, "なお、不正値を入力した場合のエラーは処理は行っていません。\n");
	fprintf(stderr, "正しいファイルが生成されませんので注意してください。\n");
	fprintf(stderr, "\n");
	fprintf(stderr, "----------------------------------------------\n");
	fprintf(stderr, "読み込んだ画像ファイルの Info を出力します。\n");
	fprintf(stderr, "height   = %d\n", image->h);
	fprintf(stderr, "width    = %d\n", image->w);
	fprintf(stderr, "fmt->BytesPerPixel = %dBytes\n", fmt->BytesPerPixel);
	fprintf(stderr, "fmt->BitsPerPixel  = %dbit\n", fmt->BitsPerPixel);
	fprintf(stderr, "\n");

	/* 画像データの切り取り座標とRGB生成パターン選択 */
	fprintf(stderr, "WidthのPixel数を区切る座標をして下さい。\n");
	fprintf(stderr, "0またはwidth以上の場合、最大値を設定します。\n");
	scanf("%d", &info->pixel_wid);
	fprintf(stderr, "PixelWidth = %d\n", info->pixel_wid);
	fprintf(stderr, "\n");
	fprintf(stderr, "----------------------------------------------\n");
	fprintf(stderr, "HeightのPixel数を区切る座標をして下さい。\n");
	fprintf(stderr, "0またはheight以上の場合、最大値を設定します。\n");
	scanf("%d", &info->pixel_hei);
	fprintf(stderr, "PixelHeight = %d\n", info->pixel_hei);
	fprintf(stderr, "\n");
	fprintf(stderr, "----------------------------------------------\n");
	fprintf(stderr, "RGBの生成タイプを指定して下さい。\n");
	fprintf(stderr, "0 = RGB888, 1 = RGB565\n");
	scanf("%d", &info->rgb_type);
	fprintf(stderr, "PixelType = %d\n", info->rgb_type);
	fprintf(stderr, "\n");
	fprintf(stderr, "----------------------------------------------\n");
	fprintf(stderr, "使用する画像ラインの選択をします。\n");
	fprintf(stderr, "0 の場合すべてのラインを読み取ります。\n");
	fprintf(stderr, "左足、立姿、左足の歩行画像 = ID 1,2,3 としたとき、立姿を飛ばしたい場合は 13 と入力してください。 \n");
	fprintf(stderr, "以降の 4,5,6 ラインも使用する場合は、13456 と入力します。\n");
	fprintf(stderr, "0 = AllLine, 123456 -> 135 CutLine\n");
	scanf("%d", &info->cut_line);

	if (info->cut_line != 0) {
		uint32_t dec = 1;

		for (uint8_t i = 0;  i < image->w / info->pixel_wid; i++) {
			dec *= 10;
		}

		for (uint8_t i = image->w / info->pixel_wid; i > 0 ; i--) {
			info->cut_line_buff[i] = info->cut_line / dec;
			info->cut_line %= dec;
		}
	} else {
		for (uint8_t i = 0; i < CUT_LINE_MAX; i++) {
			info->cut_line_buff[i] = i;
		}
	}

	for (uint8_t i = 0; i < image->w / info->pixel_wid ; i++) {
		printf("cut_line 0x%x\n",info->cut_line_buff[i]);
	}
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
	PixelInfo info;
	static uint8_t color[BUFFER_SIZE];
	uint8_t *sdl_pixel;
	uint32_t wpos;	// Color Buffer WP

	fmt = image->format;
	SDL_LockSurface(image);
	sdl_pixel = ((uint8_t *)image->pixels);
	SDL_UnlockSurface(image);
	mapchip_info_save(&info);

	for (uint32_t y = 0; y < image->h / info.pixel_hei; y++)
	{
		info.ypixel_cut = y * info.pixel_hei * image->w * fmt->BytesPerPixel; // 画像の切り取り Y座標計算

		for (uint32_t x = 0; x < image->w / info.pixel_wid; x++)
		{
			if (false == mapchip_info_eoc(x, info.cut_line_buff)) {
				continue;
			}

			info.xpixel_cut = x * info.pixel_wid * fmt->BytesPerPixel;	// 画像の切り取り x座標計算
			info.id_cnt = x + (y * (image->w / info.pixel_wid));		// 切り取り座標のID算出
			wpos = mapchip_color_upload(&info, color, sdl_pixel, fmt->BitsPerPixel);
			mapchip_file_save(&info, color, wpos, fmt->BitsPerPixel);
		}
	}

	fclose(fp);
	SDL_Quit();
}

/**-----------------------------------------------------------------------------
 * sdl png 有効設定
 *-----------------------------------------------------------------------------*/
static void sdl_init(void)
{
	int32_t flags = IMG_INIT_JPG | IMG_INIT_PNG;
	int32_t initted = IMG_Init(flags);

	if ((initted & flags) != flags) {		// png jpgを使用可能にする
		fprintf(stderr, "IMG Init: %s\n", IMG_GetError());
	}

	if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
		fprintf(stderr, "SDL Init ERROR!: %s\n", SDL_GetError());
	}
	
	fprintf(stderr, "SDL の初期設定が完了しました\n");
}


/*
 * main関数
 */
int main(int argc, char **argv)
{
	char dir_path[256] = "./raw/";	// file 保存ディレクトリ

	if (0 != file_create(argv[1], dir_path)) {
		fprintf(stderr, "引数にファイルを選択してください。\n");
		// fclose(fp);
		SDL_Quit();
		return 1;
	}

	sdl_init();
	pixel_generate();
	fprintf(stderr, "ファイルを出力しました %s\n", dir_path);

	return 0;
}
