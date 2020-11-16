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
#include <stdlib.h>
#include "../include/DRAW.H"
#include "../include/TIMER.H"


#define SCREEN_WIDTH	1280	//ウィンドウの幅を指定
#define SCREEN_HEIGHT	720		//ウィンドウの高さを指定
#define GRID_SIZE		32		//マップ描画データのpixel幅と高さを指定
#define MAP_SIZE_SHIFT	5		//5bitシフトすれば32になる
#define MAP_DRAW_WIDTH	(SCREEN_WIDTH >> MAP_SIZE_SHIFT)	//幅のループ回数
#define MAP_DRAW_HEIGHT	(SCREEN_HEIGHT >> MAP_SIZE_SHIFT)	//高さのループ回数
#define UNIT_WIDTH		24		//描画ユニットデータの幅を指定
#define UNIT_HEIGHT		32		//描画ユニットデータの高さを指定
#define UNIT_SHIFT		(MAP_SIZE_SHIFT-3)		//ユニットの描画位置を指定
#define FONT_SIZE		40		//描画フォントサイズを指定


//file pathは構造体に変更予定
#define FONT_PATH		"./res/font/PixelMplus12-Regular.ttf"
#define MAP_PATH		"./res/img/map/field/width32/map001.png"
#define UNIT_PATH		"./res/img/unit/akisys.png"
#define BGM_PATH		"./res/sound/bgm/touhou.wav"
#define EFFECT_PATH		"./res/sound/effect/mapmove.wav"


#define RENDERER	(SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)	//レンダリング方法を指定


/**-------------------------------------------------
 * 座標と向きを保存
 * -------------------------------------------------*/
typedef struct {
	int32_t unit_xpos;		//ユニットのx座標
	int32_t unit_ypos;		//ユニットのy座標
	int32_t field_xpos;		//フィールドのx座標、アニメーションを行うか判定
	int32_t field_ypos;		//フィールドのy座標、アニメーションを行うか判定
	uint8_t unit_direction;	//ユニットの現在向いている方向
	uint8_t info_direction;	//どの座標を更新したか判定を行う変数
	uint32_t res_ypos;		//描画ファイルの切り取りを行うy座標を指定
} t_posinfo;


/**-------------------------------------------------
 * 現在のフィールド情報を保存
 * -------------------------------------------------*/
typedef struct {
	int32_t ypos_animation_check;
	int32_t xpos_animation_check;
	int32_t field_maxwidth;		//現在フィールドの最大横幅指定
	int32_t field_maxheight;	//現在フィールドの最大高さ指定
	char **map_id;				//現在フィールドの先頭アドレス指定
} t_fieldinfo;


/**-------------------------------------------------
 * ファイル内グローバル変数
 * -------------------------------------------------*/
static int32_t channel = 0;


/**-------------------------------------------------
 * 構造体の確保
 * -------------------------------------------------*/
static t_posinfo posinfo = {0, 0, 0, 0, 0, 0};
static t_fieldinfo fieldinfo = {0, 0, MAP_DRAW_WIDTH, MAP_DRAW_HEIGHT};


/**-------------------------------------------------
 * SDL関数群
 * -------------------------------------------------*/
static bool sdl_init(void);
static bool sdl_create(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font);
static void sdl_finish(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font);
static bool load_texture(const char *path, SDL_Texture **p, SDL_Renderer *renderer);
static bool load_ttf_msg(const char *msg, SDL_Texture **tx, TTF_Font **p, SDL_Renderer *renderer);
static bool player_draw(SDL_Renderer *renderer, t_posinfo *pos);
static bool map_draw(SDL_Renderer *renderer);
static bool font_draw(SDL_Renderer *renderer, TTF_Font **font);
static bool sound_effect_start(const char *sound, Mix_Chunk **effect);
static void sound_effect_stop(int32_t channel, Mix_Chunk **effect);
static bool bgm_start(const char *sound, Mix_Music **music);
static void bgm_stop(Mix_Music **music);


/**-------------------------------------------------
 * キー操作
 * -------------------------------------------------*/
static bool key_event(t_fieldinfo *info, t_posinfo *p);


/**-------------------------------------------------
 * アニメーション管理
 * -------------------------------------------------*/
static uint32_t animation_cycle(uint32_t time);


/**-------------------------------------------------
 * マップの情報を取得
 * -------------------------------------------------*/
static void map_info_write(uint8_t map);
static uint32_t get_width(char **s, uint32_t height);
static uint32_t get_height(char **s);
static uint32_t get_maxwidth(char **s, uint32_t height);
static char **search_field_map(uint32_t id);


/**-------------------------------------------------
 * 座標計算
 * -------------------------------------------------*/
static void xpos_move_right(t_fieldinfo *info, t_posinfo *p);
static void xpos_move_left(t_posinfo *p);
static void ypos_move_up(t_posinfo *p);
static void ypos_move_down(t_fieldinfo *info, t_posinfo *p);



/**-------------------------------------------------
 * 描画に必要な情報を取得し構造体に保存を行う
 * -------------------------------------------------
 * arg1: map	現在のフィールドIDを指定
 * -------------------------------------------------*/
static void map_info_write(uint8_t map)
{
	t_fieldinfo *info = &fieldinfo;
	char **p;
	int32_t height, width, y_animation, x_animation;

	p = search_field_map(map);
    height = get_height(p);		//フィールドの縦幅を取得
	width  = get_maxwidth(p, height);
	y_animation = height - MAP_DRAW_HEIGHT;	//フィールド描画の最縦幅大幅取得
    x_animation = width  - MAP_DRAW_WIDTH;		//フィールド描画の最大横幅取得
	
    if (y_animation & SIGNED_CHECK) { 	//フィールドが描画幅以下の場合
        y_animation = 0;       			//移動のアニメーションは行わない
    }

    if (x_animation & SIGNED_CHECK) {
        x_animation = 0;
    }

	info->map_id = p;
	info->field_maxheight = height;
	info->field_maxwidth  = width;
	info->ypos_animation_check = y_animation;
	info->xpos_animation_check = x_animation;
}


/**--------------------------------------------
 * フィールドの横幅を取得する
 * マルチバイトと混合のため、バイト数ではなく文字数を取得する
 * --------------------------------------------
 * arg1: **s    fieldの先頭アドレス
 * arg2: height 横幅を取得する行を指定
 *--------------------------------------------*/
static uint32_t get_width(char **s, uint32_t height)
{
	uint32_t byte = 0;
    uint32_t count = 0;

    while (s[height][byte] != '\0') {
		byte += mblen(&s[height][byte], MB_CUR_MAX);	//xposからの文字列バイト数をresに格納
		count++;
	}

    return count;
}


/**--------------------------------------------
 * フィールドの縦幅を取得する
 * --------------------------------------------
 * arg1: **s    fieldの先頭アドレス
 *--------------------------------------------*/
static uint32_t get_height(char **s)
{
    uint32_t count = 0;

    while (**s++ != '\0') {
        count++;
    }

    return count;
}


/**--------------------------------------------
 * フィールドの最大横幅を取得
 * マルチバイトと混合のため、バイト数ではなく文字数を取得する
 * --------------------------------------------
 * arg1: **s    fieldの先頭アドレス
 *--------------------------------------------*/
static uint32_t get_maxwidth(char **s, uint32_t height)
{
    uint32_t maxwidth = 0;
	uint32_t count, total_byte;

	for (uint8_t i = 0; i < height; i++) {
		count = 0;
		total_byte = 0;
		while (s[i][total_byte] != '\0') {
			total_byte += mblen(&s[i][total_byte], MB_CUR_MAX);
			count++;
		}
		if (maxwidth < count) {
			maxwidth = count;
		}
	}

	return maxwidth;
}


/**--------------------------------------------
 * フィールドのマップ情報を取得する
 * --------------------------------------------
 * arg1: id    フィールドのIDを指定
 *--------------------------------------------*/
static char **search_field_map(uint32_t id)
{
    const t_map *p = map;

    for (uint8_t i = 0; i < FIELD_SIZE; i++, p++) {
        if (p->id == id) {
            return p->field_adr;
        }
    }

    return (char **)nullfield;
}


/**-------------------------------------------
 * x軸右移動の座標計算
 * -------------------------------------------
 * 現在のフィールドの横幅が最大画面幅以下のとき = cpos++
 * 以上の場合、cposが画面幅の中央に移動したとき = fpos++
 * それ以外の場合 = cpos++
 * -------------------------------------------*/
static void xpos_move_right(t_fieldinfo *info, t_posinfo *p)
{
	p->unit_direction = RIGHT;
	p->res_ypos = UNIT_HEIGHT;

	if ((MAP_DRAW_WIDTH + p->field_xpos) >= info->field_maxwidth) {
		p->unit_xpos++;
		p->info_direction = C_XPOS;
		return;
	}

	if (p->unit_xpos >= (MAP_DRAW_WIDTH >> 1)) {
		p->field_xpos++;
		p->info_direction = F_XPOS;
		return;
	}

	p->unit_xpos++;
	p->info_direction = C_XPOS;
}


/**-------------------------------------------------
 * x軸左移動の座標計算
 * -------------------------------------------------*/
static void xpos_move_left(t_posinfo *p)
{
	p->unit_direction = LEFT;
	p->res_ypos = UNIT_HEIGHT+UNIT_HEIGHT+UNIT_HEIGHT;

	if (p->unit_xpos > (MAP_DRAW_WIDTH >> 1)) {
		p->unit_xpos--;
		p->info_direction = C_XPOS;
		return;
	}

	if (p->field_xpos != 0) {
		p->field_xpos--;
		p->info_direction = F_XPOS;
		return;
	}

	p->unit_xpos--;
	p->info_direction = C_XPOS;
}


/**-------------------------------------------------
 * y軸上移動の座標計算
 * -------------------------------------------------*/
static void ypos_move_up(t_posinfo *p)
{
	p->unit_direction = UP;
	p->res_ypos = 0;

	if (p->unit_ypos > (MAP_DRAW_HEIGHT >> 1)) {
		p->unit_ypos--;
		p->info_direction = C_YPOS;
		return;
	}

	if (p->field_ypos != 0) {
		p->field_ypos--;
		p->info_direction = F_YPOS;
		return;
	}

	p->unit_ypos--;
	p->info_direction = C_YPOS;
}


/**-------------------------------------------------
 * y軸下移動の座標計算
 * -------------------------------------------------*/
static void ypos_move_down(t_fieldinfo *info, t_posinfo *p)
{
	p->unit_direction = DOWN;
	p->res_ypos = UNIT_HEIGHT+UNIT_HEIGHT;

	if ((MAP_DRAW_HEIGHT + p->field_ypos) >= info->field_maxheight) {
		p->unit_ypos++;
		p->info_direction = C_YPOS;
		return;
	}

	if (p->unit_ypos > (MAP_DRAW_HEIGHT >> 1)) {
		p->field_ypos++;
		p->info_direction = F_YPOS;
		return;
	}

	p->unit_ypos++;
	p->info_direction = C_YPOS;
}


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

	if (Mix_OpenAudio(22050, MIX_DEFAULT_FORMAT, 2, 4096) != 0) {
		fprintf(stderr, "Audio Init Error!: %s\n", Mix_GetError());
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
		fprintf(stderr, "Res Load Error!: %s\n", IMG_GetError());
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
 * プレイヤーのアニメーションサイクル時間取得関数
 * 使用する画像データは、歩、立、歩の順で並んでいる
 * -------------------------------------------------
 * arg1	 : time	アニメーションを行う間隔時間を指定
 * return: x	歩き部分だけ使用するため、0pixel.48pixelの部分だけ切り抜き
 * -------------------------------------------------*/
static uint32_t animation_cycle(uint32_t time)
{
	static uint8_t x = 0;
	static long t = 0;

	if (true == comtimer(&t, time)) {
		x++;
		x &= 0x01;	//0と1を判定
	}

	return ((UNIT_WIDTH & (~x + 1)) << x);
}


/**-------------------------------------------------
 * 操作キャラクターの描画
 * -------------------------------------------------
 * arg1:レンダリング情報
 * arg2:座標データの構造体のアドレス
 * -------------------------------------------------
 * SDL_Rect	res		arg1:画像データの切り抜きを開始する、x_Pixel数を指定
 * 					arg2:画像データの切り抜きを開始する、y_Pixel数を指定
 * 					arg3:x地点から切り抜きを終了する、x_Pixel数を指定
 * 					arg4:y地点から切り抜きを終了する、y_Pixel数を指定
 *
 * SDL_Rect draw	arg1:描画を開始する、x_positionを指定
 * 					arg2:描画を開始する、y_positionを指定
 * 					arg3:指定したポジションに、描画を行う幅を指定
 * 					arg4:指定したポジションに、描画を行う高さを指定
 *
 * SDL_RenderCopy	arg1: レンダリング情報を指定
 * 					arg2: 使用するテクスチャー情報を指定
 * 					arg3: 使用する画像データの情報を指定し、長方形を描画する
 * 					arg4: この引数に指定した、幅と高さに自動で拡大縮小する
 * -------------------------------------------------*/
static bool player_draw(SDL_Renderer *renderer, t_posinfo *pos)
{
	SDL_Texture *player_tx;
	uint32_t x;

	if (false == load_texture(UNIT_PATH, &player_tx, renderer)) {
		return false;
	}

	x = animation_cycle(MS_100(300));
	SDL_Rect res  = (SDL_Rect){x, pos->res_ypos, UNIT_WIDTH, UNIT_HEIGHT};
	SDL_Rect draw = (SDL_Rect){pos->unit_xpos << UNIT_SHIFT, pos->unit_ypos << UNIT_SHIFT, UNIT_WIDTH, UNIT_HEIGHT};	//(x,y)にw,hの大きさで描画する
	SDL_RenderCopy(renderer, player_tx, &res, &draw);
	SDL_DestroyTexture(player_tx);
	player_tx = NULL;

	return true;
}


/**-------------------------------------------------
 * マップの描画
 * 使用マップ情報は縦横GRID_SIZEで固定
 * 16,32,の大きさを使用する場合は構造体を用意しデータを取得するよう変更
 * ウィンドウの大きさに対して必要な分だけ描画を行う
 * -------------------------------------------------
 * arg1:　レンダリング情報
 * -------------------------------------------------*/
static bool map_draw(SDL_Renderer *renderer)
{
	SDL_Texture *map_tx;

	if (false == load_texture(MAP_PATH, &map_tx, renderer)) {
		return false;
	}

	SDL_Rect map_res  = (SDL_Rect){0, 0, GRID_SIZE, GRID_SIZE};

	for (uint32_t i = 0; i < MAP_DRAW_HEIGHT; i++) {
		for (uint32_t j = 0; j < MAP_DRAW_WIDTH; j++) {
			SDL_Rect map_draw = (SDL_Rect){j << MAP_SIZE_SHIFT, i << MAP_SIZE_SHIFT, GRID_SIZE, GRID_SIZE};
			SDL_RenderCopy(renderer, map_tx, &map_res, &map_draw);
		}
	}

	SDL_DestroyTexture(map_tx);
	map_tx = NULL;

	return true;
}


/**-------------------------------------------------
 * 文字列の描画
 * -------------------------------------------------
 * agr1: レンダリング情報
 * arg2: フォント情報
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
 * キーイベント処理
 * -------------------------------------------------*/
static bool key_event(t_fieldinfo *info, t_posinfo *p)
{
	SDL_Event e;

	while (SDL_PollEvent(&e)) {		//イベント処理が終わるまでループ
		if (e.type == SDL_QUIT) {	//ウィンドウの閉じるボタンが押されたら抜ける
			return false;
		}

		if (e.type != SDL_KEYDOWN) {
			return true;
		}

		switch (e.key.keysym.sym) {
			case SDLK_w:
				ypos_move_up(p);
				return true;

			case SDLK_a:
				xpos_move_left(p);
				return true;

			case SDLK_s:
				ypos_move_down(info, p);
				return true;

			case SDLK_d:
				xpos_move_right(info, p);
				return true;

			default:
				return true;
		}
	}

	return true;
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
	t_posinfo *pos = &posinfo;
	t_fieldinfo *info = &fieldinfo;

	if (false == sdl_init()) {
		return 1;
	}

	if (false == sdl_create(&window, &renderer, &font)) {
		sdl_finish(&window, &renderer, &font);
		return 1;
	}

	if (false == bgm_start(BGM_PATH, &music)) {
		return 1;
	}

	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);	//r, g, b, a ウィンドウを黒に設定

	while (1) {
		if (false == key_event(info, pos)) {
			sound_effect_start(EFFECT_PATH, &effect);
			break;
		}

		SDL_RenderClear(renderer);
		map_draw(renderer);
		font_draw(renderer, &font);
		player_draw(renderer, pos);
		SDL_RenderPresent(renderer);
	}

	bgm_stop(&music);
	sound_effect_stop(channel, &effect);
	sdl_finish(&window, &renderer, &font);

	return 0;
}
