/**-------------------------------------------------
 * rpg game サンプル
 * lSDL2ライブラリ使用
 * -------------------------------------------------*/

/**-------------------------------------------------
 * インクルードファイル
 * -------------------------------------------------*/
#include <SDL2/SDL.h>
#include <SDL2/SDL_events.h>
#include <SDL2/SDL_image.h>
#include <SDL2/SDL_ttf.h>
#include <SDL2/SDL_mixer.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>

#define SCREEN_WIDTH	640
#define SCREEN_HEIGHT	480
#define MAP_WIDTH		4096
#define MAP_HEIGHT		4096
#define IMAGE_WIDTH		24
#define IMAGE_HEIGHT	32
#define ANIMATION		1
#define FONT_SIZE		40
#define FONT_PATH		"res/font/PixelMplus12-Regular.ttf"
#define MAP_PATH		"res/img/map/map5.png"
#define IMG_PATH		"res/img/unit/akisys.png"
#define WAV_PATH		"res/bgm/touhou.wav"

#define RENDERER	(SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)



/**-------------------------------------------------
 * 関数宣言
 * -------------------------------------------------*/
static bool sdl_init(void);



/**-------------------------------------------------
 * sdlの初期化関数
 * -------------------------------------------------*/
static bool sdl_init(void)
{
	int32_t flags = IMG_INIT_JPG | IMG_INIT_PNG;
	int32_t initted = IMG_Init(flags);

	if ((initted & flags) != flags) {	//png jpgを使用可能にする
		fprintf(stderr, "IMG Init ERROR!: JPG PNGの読み込みに失敗しました\n");
		fprintf(stderr, "IMG Init: %s\n", IMG_GetError());
		return false;
	}

	if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
		fprintf(stderr, "SDL Init ERROR!: %s\n", SDL_GetError());
		return false;
	}

	if (TTF_Init() != 0) {
		fprintf(stderr, "TTF FONT Init Error!: %s\n", TTF_GetError());
		return false;
	}

	return true;
}


/**-------------------------------------------------
 * メイン関数
 * -------------------------------------------------
 * メインルーチンではSDLの生成、初期設定を行う
 * 外部関数で値の操作を行うようにする
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	SDL_Window *window;
	SDL_Renderer *renderer;
	SDL_Surface *load_surf;
	SDL_Texture *font_tx;
	SDL_Texture *background_tx;
	SDL_Texture *chara_tx;
	SDL_Event e;
	TTF_Font *font;
	SDL_Rect maprect = (SDL_Rect){0, 0, MAP_WIDTH, MAP_HEIGHT};

	int32_t animation_cycle = 100;
	int32_t frame = 0;
	int32_t x;
	int32_t quit = false;
	int32_t iw, ih;

	//SDLの初期設定
	if (false == sdl_init()) {
		return 1;
	}

	//Windowの生成
	window = SDL_CreateWindow(u8"Hello SDL", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);

	if (window == NULL) {
		fprintf(stderr, "SDL Window Create Error!: %s\n", SDL_GetError());
		SDL_DestroyWindow(window);
		return -1;
	}

	//レンダリングの方法を指定、GPUでグラフィック処理を行い、FPSを上げるように設定
	renderer = SDL_CreateRenderer(window, -1, RENDERER); 

	if (renderer == NULL) {
		fprintf(stderr, "SDL Renderer Create Error!: %s\n", SDL_GetError());
		SDL_DestroyWindow(window);
		return -1;
	}

	//指定したフォントサイズで、フォントファイルを開く
	font = TTF_OpenFont(FONT_PATH, FONT_SIZE);

	if (font == NULL) {
		fprintf(stderr, "TTF_openfont  Error!: %s\n", TTF_GetError());
		SDL_DestroyWindow(window);
		return -1;
	}

	//マップ情報を取得、Surfaceを使いまわすために、最後に解放する
	load_surf = IMG_Load(MAP_PATH);

	if (load_surf == NULL) {
		fprintf(stderr, "Map Load Error!: %s\n", IMG_GetError());
		SDL_DestroyWindow(window);
		return -1;
	}
	background_tx = SDL_CreateTextureFromSurface(renderer, load_surf);
	SDL_FreeSurface(load_surf);

	//ユニット情報を取得
	load_surf = IMG_Load(IMG_PATH);

	if (load_surf == NULL) {
		fprintf(stderr, "IMG Load Error!: %s\n", IMG_GetError());
		SDL_DestroyWindow(window);
		return -1;
	}
	//SDL_SetColorKey(load_surf, SDL_TRUE, SDL_MapRGB(load_surf->format, 255, 255, 255));//必要ならばクロマキー処理
	chara_tx = SDL_CreateTextureFromSurface(renderer, load_surf);
	SDL_FreeSurface(load_surf);

	//指定した文字列情報を取得する
	load_surf = TTF_RenderUTF8_Blended(font, "HelloWorld", (SDL_Color){255,255,255,255});

	if (load_surf == NULL) {
		fprintf(stderr, "TTF Load Error!: %s\n", TTF_GetError());
		SDL_DestroyWindow(window);
		return -1;
	}
	font_tx = SDL_CreateTextureFromSurface(renderer, load_surf);
	SDL_FreeSurface(load_surf);

	SDL_QueryTexture(font_tx, NULL, NULL, &iw, &ih);	//文字の幅と高さ取得
	SDL_Rect txtRext = (SDL_Rect){0, 0, iw, ih};		//{startx, starty, endx, endy}の順に格納される
	SDL_Rect pasteRect = (SDL_Rect){200, 200, iw, ih};	//{描画x, 描画y, 描画幅, 描画高さ}

	SDL_QueryTexture(chara_tx, NULL, NULL, &iw, &ih);
	SDL_SetRenderDrawColor(renderer, 200, 200, 200, 255);	//r, g, b, a

	while (!quit) {
		while (SDL_PollEvent(&e)) {		//イベント処理が終わるまでループ
			if (e.type == SDL_QUIT) {	//ウィンドウの閉じるボタンが押されたら抜ける
				quit = true;
				break;
			}
		}

		//キーの処理など
		
		x = ((frame / animation_cycle) % 3) * IMAGE_WIDTH;
		SDL_Rect chara_rect = (SDL_Rect){x, 0, IMAGE_WIDTH, IMAGE_HEIGHT};		//x座標からwidth分、画像データ切り抜き
		SDL_Rect chara_draw = (SDL_Rect){300, 300, (IMAGE_WIDTH+8)*ANIMATION, IMAGE_HEIGHT*ANIMATION};	//(x300,y300)にw32 h32の大きさで描画する

		SDL_RenderClear(renderer);
		SDL_RenderCopy(renderer, background_tx, NULL, &maprect);	//マップ描画
		SDL_RenderCopy(renderer, font_tx, &txtRext, &pasteRect);
		SDL_RenderCopy(renderer, chara_tx, &chara_rect, &chara_draw);	//第四引数に指定した幅と高さに自動で拡大縮小してくれる
		SDL_RenderPresent(renderer);	//再描画

		frame += 1;
		frame &= 65535;
	}

	IMG_Quit();
	SDL_DestroyTexture(font_tx);
	SDL_DestroyTexture(background_tx);
	SDL_DestroyTexture(chara_tx);
	SDL_DestroyRenderer(renderer);
	SDL_DestroyWindow(window);
	SDL_Quit();
	TTF_CloseFont(font);
	TTF_Quit();

	return 0;
}
