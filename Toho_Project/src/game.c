/**-------------------------------------------------
 * Toho Project RPG GAME
 * -------------------------------------------------
 * Ubuntu LTS 20.04 kimura
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
#define UNIT_PATH		"res/img/unit/akisys.png"
#define BGM_PATH		"res/bgm/touhou.wav"
#define EFFECT_PATH		"res/bgm/mapmove.mp3"

#define RENDERER	(SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)


/**-------------------------------------------------
 * ファイル内グローバル変数
 * -------------------------------------------------*/
static int32_t animation_cycle = 100;
static int32_t frame = 0;
static int32_t channel = 0;


/**-------------------------------------------------
 * 関数宣言
 * -------------------------------------------------*/
static bool sdl_init(void);
static bool sdl_create(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font);
static void sdl_finish(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font);
static bool load_texture(const char *path, SDL_Texture **p, SDL_Renderer *renderer);
static bool load_ttf_msg(const char *msg, SDL_Texture **tx, TTF_Font **p, SDL_Renderer *renderer);
static bool player_draw(SDL_Renderer *renderer);
static bool map_draw(SDL_Renderer *renderer);
static bool font_draw(SDL_Renderer *renderer, TTF_Font **font);
static bool sound_effect_start(const char *sound, Mix_Chunk **effect);
static void sound_effect_stop(int32_t channel, Mix_Chunk **effect);
static bool bgm_start(const char *sound, Mix_Music **music);
static void bgm_stop(Mix_Music **music);



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
 * 使用するフォントデータとレンダリングの設定
 * -------------------------------------------------
 * window  : 画面中央に1280x720で描画する
 * renderer: GPUでグラフィック処理を行い、FPSを上げるよう設定
 * font    : 12pixelのゲーム用フォントを使用
 * -------------------------------------------------*/
static bool sdl_create(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font)
{
	*window = SDL_CreateWindow(u8"Hello SDL", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);

	if (*window == NULL) {
		fprintf(stderr, "SDL Window Create Error!: %s\n", SDL_GetError());
		return false;
	}

	*renderer = SDL_CreateRenderer(*window, -1, RENDERER); 

	if (*renderer == NULL) {
		fprintf(stderr, "SDL Renderer Create Error!: %s\n", SDL_GetError());
		return false;
	}

	*font = TTF_OpenFont(FONT_PATH, FONT_SIZE);

	if (*font == NULL) {
		fprintf(stderr, "TTF_openfont  Error!: %s\n", TTF_GetError());
		return false;
	}

	return true;
}


/**-------------------------------------------------
 * texture data load
 * -------------------------------------------------
 * arg1: const char file path
 * arg2: texture  address
 * arg3: renderer address
 * -------------------------------------------------*/
static bool load_texture(const char *path, SDL_Texture **p, SDL_Renderer *renderer)
{
	SDL_Surface *image;

	image = IMG_Load(path);

	if (image == NULL) {
		fprintf(stderr, "Map Load Error!: %s\n", IMG_GetError());
		return false;
	}
	*p = SDL_CreateTextureFromSurface(renderer, image);
	SDL_FreeSurface(image);

	return true;
}


/**-------------------------------------------------
 * render str data load
 * -------------------------------------------------
 * arg1: const char str path
 * arg2: texture address
 * arg3: ttf font address
 * arg4: renderer address
 * -------------------------------------------------*/
static bool load_ttf_msg(const char *msg, SDL_Texture **tx, TTF_Font **p, SDL_Renderer *renderer)
{
	SDL_Surface *ttf;

	ttf = TTF_RenderUTF8_Blended(*p, msg, (SDL_Color){255,255,255,255});

	if (ttf == NULL) {
		fprintf(stderr, "TTF Load Error!: %s\n", TTF_GetError());
		return false;
	}
	*tx = SDL_CreateTextureFromSurface(renderer, ttf);
	SDL_FreeSurface(ttf);

	return true;
}


/**-------------------------------------------------
 * sdlの終了
 * -------------------------------------------------*/
static void sdl_finish(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font)
{
	Mix_CloseAudio();
	TTF_CloseFont(*font);
	TTF_Quit();
	IMG_Quit();
	SDL_DestroyRenderer(*renderer);
	SDL_DestroyWindow(*window);
	SDL_Quit();
}


/**-------------------------------------------------
 * プレイヤーの描画
 * -------------------------------------------------*/
static bool player_draw(SDL_Renderer *renderer)
{
	SDL_Texture *player_tx;
	int32_t x;

	if (false == load_texture(UNIT_PATH, &player_tx, renderer)) {
		return false;
	}

	x = ((frame / animation_cycle) % 3) * IMAGE_WIDTH;
	SDL_Rect chara_rect = (SDL_Rect){x, 0, IMAGE_WIDTH, IMAGE_HEIGHT};		//x座標からwidth分、画像データ切り抜き
	SDL_Rect chara_draw = (SDL_Rect){300, 300, IMAGE_WIDTH, IMAGE_HEIGHT};	//(x300,y300)にw32 h32の大きさで描画する
	SDL_RenderCopy(renderer, player_tx, &chara_rect, &chara_draw);			//第四引数に指定した幅と高さに自動で拡大縮小してくれる
	frame += 1;
	frame &= 65535;
	SDL_DestroyTexture(player_tx);
	player_tx = NULL;

	return true;
}


/**-------------------------------------------------
 * マップの描画
 * -------------------------------------------------*/
static bool map_draw(SDL_Renderer *renderer)
{
	SDL_Texture *map_tx;

	if (false == load_texture(MAP_PATH, &map_tx, renderer)) {
		return false;
	}

	SDL_Rect maprect = (SDL_Rect){0, 0, MAP_WIDTH, MAP_HEIGHT};
	SDL_RenderCopy(renderer, map_tx, NULL, &maprect);	//マップ描画
	SDL_DestroyTexture(map_tx);
	map_tx = NULL;

	return true;
}


/**-------------------------------------------------
 * 文字列の描画
 * -------------------------------------------------*/
static bool font_draw(SDL_Renderer *renderer, TTF_Font **font)
{
	SDL_Texture *font_tx;
	int32_t iw, ih;

	if (false == load_ttf_msg("Toho Project", &font_tx, font, renderer)) {
		return false;
	}

	SDL_QueryTexture(font_tx, NULL, NULL, &iw, &ih);	//文字の幅と高さ取得
	SDL_Rect txtRext = (SDL_Rect){0, 0, iw, ih};		//{startx, starty, endx, endy}の順に格納される
	SDL_Rect pasteRect = (SDL_Rect){200, 200, iw, ih};	//{描画x, 描画y, 描画幅, 描画高さ}
	SDL_RenderCopy(renderer, font_tx, &txtRext, &pasteRect);
	SDL_DestroyTexture(font_tx);
	font_tx = NULL;

	return true;
}


/**-------------------------------------------------
 * 効果音を再生
 * -------------------------------------------------*/
static bool sound_effect_start(const char *sound, Mix_Chunk **effect)
{
	*effect = Mix_LoadWAV(sound);

	if (Mix_OpenAudio(22050, MIX_DEFAULT_FORMAT, 2, 4096) != 0) {
		fprintf(stderr, "Audio Init Error!: %s\n", Mix_GetError());
		return false;
	}

	if (*effect == NULL) {
		fprintf(stderr, "Mix_LoadWAV Error!: %s\n", Mix_GetError());
		return false;
	}

	channel = Mix_PlayChannel(-1, *effect, 0);	//チャンネル自動割り当て,0で一回再生

	return true;
}


/**-------------------------------------------------
 * 効果音を停止
 * -------------------------------------------------*/
static void sound_effect_stop(int32_t channel, Mix_Chunk **effect)
{
	Mix_HaltChannel(channel);
	Mix_FreeChunk(*effect);
	*effect = NULL;
}


/**-------------------------------------------------
 * BGMを再生
 * -------------------------------------------------
 * arg1: file path
 * -------------------------------------------------*/
static bool bgm_start(const char *sound, Mix_Music **music)
{
	*music = Mix_LoadMUS(sound);

	if (Mix_SetMusicCMD("play -q") != 0) {
		fprintf(stderr, "Mix_SetMusicCMD");
		return false;
	}

	if (*music == NULL) {
		fprintf(stderr, "Mix_LoadMUS Error!: %s\n", Mix_GetError());
		return false;
	}

	if (Mix_PlayMusic(*music, 1) != 0) {	//一回再生,-1の場合無限に再生
		return false;
	}

	//while (Mix_PlayingMusic());	//再生中の場合1を返す

	return true;
}

/**-------------------------------------------------
 * BGMの停止
 * -------------------------------------------------*/
static void bgm_stop(Mix_Music **music)
{
	Mix_HaltMusic();		//再生停止
	Mix_FreeMusic(*music);	//リソース解放
	*music = NULL;
}


/**-------------------------------------------------
 * メイン関数
 * -------------------------------------------------
 * SDLは同一スレッド内で扱わなければならない
 * -------------------------------------------------*/
int main(void)
{

	SDL_Window *window;
	SDL_Renderer *renderer;
	TTF_Font *font;
	Mix_Music *music;
	Mix_Chunk *effect;
	int32_t quit = false;

	if (false == sdl_init()) {
		return 1;
	}

	if (false == sdl_create(&window, &renderer, &font)) {
		sdl_finish(&window, &renderer, &font);
		return 1;
	}

	//SDL_SetRenderDrawColor(renderer, 200, 200, 200, 255);	//r, g, b, a
	bgm_start(BGM_PATH, &music);
	SDL_Event e;

	while (!quit) {
		while (SDL_PollEvent(&e)) {		//イベント処理が終わるまでループ
			if (e.type == SDL_QUIT) {	//ウィンドウの閉じるボタンが押されたら抜ける
				quit = true;
				bgm_stop(&music);
				sound_effect_start(EFFECT_PATH, &effect);
				break;
			}
		}

		//キーの処理など

		SDL_RenderClear(renderer);
		map_draw(renderer);
		font_draw(renderer, &font);
		player_draw(renderer);
		SDL_RenderPresent(renderer);
	}
	sound_effect_stop(channel, &effect);
	sdl_finish(&window, &renderer, &font);

	return 0;
}
