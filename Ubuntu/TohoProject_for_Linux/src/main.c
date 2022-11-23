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
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include "../include/PARA.H"
#include "../include/KEY.H"
#define DRAW_DATA
#include "../include/MAPCHIP.H"
#include "../include/TIMER.H"
#include "../include/FILE.H"
#include "../include/TERMINAL.H"
 

//file pathは構造体に変更予定
#define FONT_PATH		"./res/font/PixelMplus12-Regular.ttf"
#define UNIT_PATH		"./res/img/unit/akisys.png"
#define BGM_PATH		"./res/sound/bgm/touhou.wav"
#define EFFECT_PATH		"./res/sound/effect/mapmove.wav"
#define RENDERER	(SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)	//レンダリング方法を指定


/**-------------------------------------------------
 * モード番号
 * -------------------------------------------------*/
typedef enum {
	MAP_MOVE,		//マップ移動モード
	MAP_BLINK,		//マップ移動、暗転モード
	CONFIG_WINDOW,	//メニュー画面描画モード
	MSG_WINDOW,		//メッセージウィンドウ描画モード
	MODE_END,		//モ―ドの終了
} T_MODE;


/**-------------------------------------------------
 * フレームバッファの確保
 * -------------------------------------------------*/
static uint32_t mapsize_window_same[MAP_DRAW_WIDTH * MAP_DRAW_HEIGHT] = {0};
static uint32_t mapsize_twofold[MAP_FOLD_WIDTH * MAP_FOLD_HEIGHT] = {0};
static uint32_t mapsize_threefold[(MAP_FOLD_WIDTH*2) * (MAP_FOLD_HEIGHT*2)] = {0};
static uint32_t mapsize_fourfold[(MAP_FOLD_WIDTH*3) * (MAP_FOLD_HEIGHT*3)] = {0};
static uint32_t mapsize_fivefold[(MAP_FOLD_WIDTH*4) * (MAP_FOLD_HEIGHT*4)] = {0};
static uint32_t mapsize_sixfold[(MAP_FOLD_WIDTH*5) * (MAP_FOLD_HEIGHT*5)] = {0};


/**-------------------------------------------------
 * 現在のフィールド情報を保存
 * -------------------------------------------------
 * arg1: 使用しているフレームバッファのIDを保存
 * arg2: 使用しているフレームバッファのアドレスを保存
 * arg3: 現在のマップのバックグラウンドに使用する素材IDを指定
 * arg4: 使用しているフレームバッファの横幅を保存
 * arg5: 使用しているフレームバッファの縦幅を保存
 * arg6: 現在のフィールドのバイナリファイルの相対パスを保存
 * -------------------------------------------------*/
typedef struct {
	uint8_t id;
	uint32_t resid;
	uint32_t background;
	uint32_t *framebuffer_address;
	int32_t field_maxwidth;
	int32_t field_maxheight;
	char *binpath;
} t_fieldinfo;


/**-------------------------------------------------
 * メッセージ情報を一時保存する構造体
 * -------------------------------------------------*/
typedef struct {
	uint32_t msgid;
	char *msg;
} t_msginfo;


/**-------------------------------------------------
 * 一時保存構造体を管理する構造体
 * -------------------------------------------------*/
typedef struct {
	t_fieldinfo *info;
	t_msginfo	*minfo;
} t_infobuffer;


/**-------------------------------------------------
 * 構造体の確保
 * -------------------------------------------------*/
static t_fieldinfo fieldinfo = {0, 0, 0, mapsize_window_same, MAP_DRAW_WIDTH, MAP_DRAW_HEIGHT};
static t_msginfo msginfo	 = {NULLWRITE, "\0"};


/**-------------------------------------------------
 * 構造体のアドレス確保
 * -------------------------------------------------*/
static t_infobuffer infobuffer = {
	&fieldinfo,
	&msginfo
};


/**-------------------------------------------------
 * ファイル内グローバル変数
 * -------------------------------------------------*/
static int32_t channel = 0;


/**-------------------------------------------------
 * SDL関数群
 * -------------------------------------------------*/
static bool sdl_init(void);
static bool sdl_create(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font);
static void sdl_finish(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font, SDL_Texture **player_tx);
static bool load_texture(const char *path, SDL_Texture **p, SDL_Renderer *renderer);
static void map_load_texture(SDL_Renderer *renderer, SDL_Texture **p, const t_mapinfo *map, t_fieldinfo *info);
static bool load_ttf_msg(const char *msg, SDL_Texture **tx, TTF_Font **p, SDL_Renderer *renderer);
static void map_texture_destroy(SDL_Texture **p);
static void player_draw(SDL_Renderer *renderer, SDL_Texture **player_tx);
static void map_draw(SDL_Renderer *renderer, SDL_Texture **map_tx, const t_mapinfo *map, t_fieldinfo *info);
static bool font_draw(SDL_Renderer *renderer, TTF_Font **font, char *s, uint32_t width, uint32_t height);
static bool make_msgbox(SDL_Renderer *renderer, TTF_Font **font, t_msginfo *minfo);
static bool sound_effect_start(const char *sound, Mix_Chunk **effect);
static void sound_effect_stop(int32_t channel, Mix_Chunk **effect);
static bool bgm_start(const char *sound, Mix_Music **music);
static void bgm_stop(Mix_Music **music);


/**-------------------------------------------------
 * モード関数
 * -------------------------------------------------*/
static uint8_t map_move_mode(t_infobuffer *ptr);
static uint8_t msg_window_mode(const t_const_struct *p, t_infobuffer *ptr);


/**-------------------------------------------------
 * アニメーション管理
 * -------------------------------------------------*/
static uint32_t animation_cycle(uint32_t time);


/**-------------------------------------------------
 * マップチップ情報操作
 * -------------------------------------------------*/
static char **get_mapchip_path(const t_mapinfo *p);
static uint8_t map_address_advance(const t_mapinfo *p, uint32_t d);


/**-------------------------------------------------
 * フレームバッファ操作
 * -------------------------------------------------*/
static void fieldmap_info_push(uint8_t mapname, t_fieldinfo *info);
static uint32_t *get_framebuffer_address(uint8_t id);
static uint8_t world_update(void);


/**-------------------------------------------------
 * メッセージ操作
 * -------------------------------------------------*/
static void set_msg_status(const t_msgbox *msg, t_msginfo *minfo, uint32_t id);



/**-------------------------------------------------
 * メッセージ情報を構造体に保存する
 * -------------------------------------------------
 * arg1: *msg
 * arg2: *minfo
 * arg3: id
 * -------------------------------------------------*/
static void set_msg_status(const t_msgbox *msg, t_msginfo *minfo, uint32_t id)
{
	for (uint8_t i = 0; i < MSGBOX_SIZE; i++, msg++) {
		if (msg->id == id) {
			break;
		}
	}

	minfo->msgid = id;
	minfo->msg   = msg->msg;
}



/**-------------------------------------------------
 * マップ作製ID更新
 * -------------------------------------------------*/
static uint8_t world_update(void)
{
	static uint8_t worldid = MAP_BUILD_START;

	worldid++;

	if (worldid > MAP_BUILD_END) {
		worldid = MAP_BUILD_START;
	}

	return worldid;
}



/**-------------------------------------------------
 * 現在のフィールドマップ情報を保存する関数
 * -------------------------------------------------
 * arg1: mapname	現在のマップ名を指定
 * arg2: *info		マップ情報を保存する構造体のアドレスを指定
 * -------------------------------------------------*/
static void fieldmap_info_push(uint8_t mapname, t_fieldinfo *info)
{
	const t_fieldmap *p = fieldmap;
	const t_buildinfo *build = buildinfo;
	uint8_t i, id;

	for (i = 0; i < BUILD_SIZE; i++, build++) {
		if (build->mapname == mapname) {
			id = build->id;
			break;
		}
	}

	for (i = 0; i < FIELDMAP_SIZE; i++, p++) {
		if (p->id == id) {
			break;
		}
	}

	info->id = p->id;
	info->resid = build->resid;
	info->background = build->background;
	info->framebuffer_address = get_framebuffer_address(id);
	info->field_maxwidth  = p->fieldmap_width;
	info->field_maxheight = p->fieldmap_height;
	info->binpath = build->binfile;
}


/**-------------------------------------------------
 * フレームバッファ先頭アドレス取得
 * -------------------------------------------------*/
static uint32_t *get_framebuffer_address(uint8_t id)
{
	switch (id) {
		case MAPSAME:
			return &mapsize_window_same[0];

		case MAPTWO:
			return &mapsize_twofold[0];

		case MAPTHREE:
			return &mapsize_threefold[0];

		case MAPFOUR:
			return &mapsize_fourfold[0];

		case MAPFIVE:
			return &mapsize_fivefold[0];

		case MAPSIX:
			return &mapsize_sixfold[0];


		default:
			return &mapsize_window_same[0];
	}
}


/**-------------------------------------------------
 * t_mapinfoのアドレスを進める
 * マップチップの開始IDと終了IDの範囲内になるまでループを行う
 * -------------------------------------------------
 * arg1: *p マップチップ構造体のアドレスを指定
 * arg2: d	マップチップの要素数のIDを指定する
 * -------------------------------------------------*/
static uint8_t map_address_advance(const t_mapinfo *p, uint32_t d)
{
	uint8_t i;

	for (i = 0; i < CHIP_INFO; i++, p++) {
		if ((p->startid <= d) && (d <= p->endid)) {
			break;
		}
	}

	return i;
}



/**-------------------------------------------------
 * mapchipのpathを取得
 * pathはchar型の二次元配列に格納されている
 * -------------------------------------------------
 * arg1: *p マップチップ構造体のアドレスを指定
 * -------------------------------------------------*/
static char **get_mapchip_path(const t_mapinfo *p)
{
	uint8_t select;

	select = p->select;

	return (char **)p->path[select];
}



/**-------------------------------------------------
 * sdlの初期化関数、main関数の最初に呼び出すこと
 * -------------------------------------------------*/
static bool sdl_init(void)
{
	int32_t flags = IMG_INIT_JPG | IMG_INIT_PNG;
	int32_t initted = IMG_Init(flags);

	if ((initted & flags) != flags) {	//png jpgを使用可能にする
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
	*window = SDL_CreateWindow( u8"Aki Sister RPG Game",
								SDL_WINDOWPOS_CENTERED,
								SDL_WINDOWPOS_CENTERED, 
								SCREEN_WIDTH, SCREEN_HEIGHT,
								SDL_WINDOW_SHOWN);

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
 * arg4: color_key on/off flag
 * -------------------------------------------------*/
static bool load_texture(const char *path, SDL_Texture **p, SDL_Renderer *renderer)
{
	SDL_Surface *image;

	image = IMG_Load(path);

	if (image == NULL) {
		fprintf(stderr, "Texture Load Error!: %s  File Path: %s\n", IMG_GetError(), path);
		return false;
	}

	//SDL_SetColorKey(image, flag, SDL_MapRGB(image->format, 0, 0, 0));
	*p = SDL_CreateTextureFromSurface(renderer, image);
	SDL_FreeSurface(image);

	return true;
}


/**-------------------------------------------------
 * 複数テクスチャーを読み込む処理
 * -------------------------------------------------*/
static void map_load_texture(SDL_Renderer *renderer, SDL_Texture **p, const t_mapinfo *map, t_fieldinfo *info)
{
	char **path;	//テクスチャーデータの相対パスを保存
	
	map  = map + map_address_advance(map, info->resid);

	for (uint8_t i = 0; i < MAP_RES_SIZE; i++) {
		path = get_mapchip_path(map + i);
		if (!strcmp((char *)path, "\0")) {
			return;
		}
		load_texture((char *)path, &p[i], renderer);
		terminal_str("使用するテクスチャーのパス", (char *)path);
	}
}


/**-------------------------------------------------
 * テクスチャーの破棄
 * -------------------------------------------------*/
static void map_texture_destroy(SDL_Texture **p)
{
	for (uint8_t i = 0; i < MAP_RES_SIZE; i++) {
		SDL_DestroyTexture(p[i]);
		p[i] = NULL;
	}
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
static void sdl_finish(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font, SDL_Texture **player_tx)
{
	TTF_CloseFont(*font);
	TTF_Quit();
	IMG_Quit();
	SDL_DestroyRenderer(*renderer);
	SDL_DestroyWindow(*window);
	SDL_DestroyTexture(*player_tx);
	
	renderer  = NULL;
	window    = NULL;
	player_tx = NULL;
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
static void player_draw(SDL_Renderer *renderer, SDL_Texture **player_tx)
{
	uint32_t x;
	x = animation_cycle(MS_100(3));

	SDL_Rect res  = (SDL_Rect){
		x,
		get_posinfo(RES_YPOS),
		UNIT_WIDTH,
		UNIT_HEIGHT
	};

	SDL_Rect draw = (SDL_Rect){
		((get_posinfo(UNIT_XPOS) << MAP_SIZE_SHIFT)),
		((get_posinfo(UNIT_YPOS) << MAP_SIZE_SHIFT)),
		GRID_SIZE,
		GRID_SIZE
	};

	SDL_RenderCopy(renderer, *player_tx, &res, &draw);
}


/**-------------------------------------------------
 * マップを描画
 * -------------------------------------------------
 * 一つの要素の描画は縦横GRID_SIZEで固定
 * ウィンドウの大きさに対して必要な分だけ描画を行う
 * -------------------------------------------------
 * arg1: *renderer	レンダリング情報
 * arg2: *pos		マップ描画に使用するテクスチャー情報が保存されている配列のアドレスを指定
 * arg3: *p			マップチップの一つの要素の座標が保存されている構造体のアドレス
 * arg4: *map		マップチップの座標以外の情報が保存されている構造体のアドレス
 * arg5: *info		現在のフィールドバッファの情報が保存されている構造体のアドレス
 * -------------------------------------------------*/
static void map_draw(SDL_Renderer *renderer, SDL_Texture **map_tx, const t_mapinfo *map, t_fieldinfo *info)
{
	SDL_Rect back_res;
	SDL_Rect map_res;
	SDL_Rect map_draw;
	uint32_t i, j, n;			//forループ用変数
	uint32_t d, cnt;			//構造体のアドレスを進めるためのデータを保存
	uint32_t x, y, fieldwidth;	//プレイヤーの座標とフィールドの広さを計算用に保存
	uint32_t sel;				//描画用配列の列番号を指定するデータを保存
	uint32_t id;				//現在のマップチップIDの切り取りポイントを保存
	uint32_t xpos, ypos;		//画像データの切り取りx座標とy座標を保存
	uint32_t sheets;			//画像データのチップ数を保存
	uint32_t *ptr;				//フレームバッファの先頭アドレスを保存

	ptr = info->framebuffer_address;
	x = get_posinfo(FIELD_XPOS);
	y = get_posinfo(FIELD_YPOS);
	fieldwidth = info->field_maxwidth;
	d = info->background;
	cnt = map_address_advance(map, d);
	map = map + cnt;
	sel = map->select;
	id = d - map->startid;
	sheets = map->w_material;
	xpos = id;
	ypos = 0;
	for (n = sheets-1; n < id; n += sheets) {
		ypos += map->ypixel;
		xpos -= sheets;
	}
	xpos = xpos * map->xpixel;
	back_res = (SDL_Rect){xpos, ypos, map->xpixel, map->ypixel};

	for (i = 0; i < MAP_DRAW_HEIGHT; i++) {			//フレームバッファのデータを描画
		for (j = 0; j < MAP_DRAW_WIDTH; j++) {
			map -= cnt;
			d = ptr[((i+y) * fieldwidth)+j+x];		//マップチップに対応したバイナリデータを取得
			cnt = map_address_advance(map, d);
			map += cnt;								//画像データの情報を更新
			id = d - map->startid;					//画像データの切り取りポイント取得
			sheets = map->w_material;				//画像データの横の要素数取得
			xpos = id;
			ypos = 0;
			for (n = sheets-1; n < id; n += sheets) {
				ypos += map->ypixel;
				xpos -= sheets;
			}
			xpos *= map->xpixel;
			map_res  = (SDL_Rect){xpos, ypos, map->xpixel, map->ypixel};
			map_draw = (SDL_Rect){j << MAP_SIZE_SHIFT, i << MAP_SIZE_SHIFT, GRID_SIZE, GRID_SIZE};
			SDL_RenderCopy(renderer, map_tx[sel], &back_res, &map_draw);
			SDL_RenderCopy(renderer, map_tx[map->select], &map_res, &map_draw);
		}
	}
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
 * 文字列の描画
 * -------------------------------------------------
 * agr1: レンダリング情報
 * arg2: フォント情報
 * -------------------------------------------------*/
static bool font_draw(SDL_Renderer *renderer, TTF_Font **font, char *s, uint32_t width, uint32_t height)
{
	SDL_Texture *font_tx;
	int32_t iw, ih;	//文字の幅と高さ保存

	if (false == load_ttf_msg(s, &font_tx, font, renderer)) {
		return false;
	}

	SDL_QueryTexture(font_tx, NULL, NULL, &iw, &ih);
	SDL_Rect txtRext = (SDL_Rect){0, 0, iw, ih};
	SDL_Rect pasteRect = (SDL_Rect){width, height, iw, ih};
	SDL_RenderCopy(renderer, font_tx, &txtRext, &pasteRect);
	SDL_DestroyTexture(font_tx);
	font_tx = NULL;

	return true;
}


/**-------------------------------------------------
 * メッセージウィンドウの描画
 * 白枠を描画後、黒の四角形を描画
 * -------------------------------------------------
 * arg1: *renderer	レンダリング情報
 * arg2: **font		font情報
 * arg3: *msg		描画するメッセージ情報が保存されている構造体のアドレス
 * -------------------------------------------------*/
static bool make_msgbox(SDL_Renderer *renderer, TTF_Font **font, t_msginfo *minfo)
{
	if(minfo->msgid == NULLWRITE) {
		return false;
	}

	SDL_Rect white;
	SDL_Rect black;

	white.x = (SCREEN_WIDTH >> 2) - MSG_FLAME_SIZE;
	white.y = (SCREEN_HEIGHT >> 2) + (SCREEN_HEIGHT >> 1) - MSG_FLAME_SIZE;
	white.w = (SCREEN_WIDTH >> 1) + MSG_FLAME_SIZE + MSG_FLAME_SIZE;
	white.h = MSG_WINDOW_SIZE + MSG_FLAME_SIZE + MSG_FLAME_SIZE;

	black.x = SCREEN_WIDTH >> 2;
	black.y = (SCREEN_HEIGHT >> 2) + (SCREEN_HEIGHT >> 1);
	black.w = SCREEN_WIDTH >> 1;
	black.h = MSG_WINDOW_SIZE;

	SDL_SetRenderDrawBlendMode(renderer, SDL_BLENDMODE_BLEND);
	SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
	SDL_RenderFillRect(renderer, &white);

	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
	SDL_RenderFillRect(renderer, &black);

	font_draw(renderer, font, minfo->msg, black.x + MSG_FLAME_SIZE, black.y + MSG_FLAME_SIZE);

	return true;
}



/**-------------------------------------------------
 * マップ移動モードキーイベント処理
 * -------------------------------------------------*/
static uint8_t map_move_mode(t_infobuffer *ptr)
{
	SDL_Event e;

	while (SDL_PollEvent(&e)) {
		if (e.type == SDL_QUIT) {
			return MODE_END;
		}

		if (e.type != SDL_KEYDOWN) {
			return MAP_MOVE;
		}

		switch (e.key.keysym.sym) {
			case SDLK_UP:
				ypos_move_up();
				break;

			case SDLK_LEFT:
				xpos_move_left();
				break;

			case SDLK_DOWN:
				ypos_move_down(ptr->info->field_maxheight);
				break;

			case SDLK_RIGHT:
				xpos_move_right(ptr->info->field_maxwidth);
				break;

			case SDLK_n:	//次のマップ作製
				pos_update();
				fieldmap_info_push(world_update(), ptr->info);
				bin_read(ptr->info->binpath, ptr->info->framebuffer_address, ptr->info->field_maxwidth, ptr->info->field_maxheight);
				break;

			default:
				break;
		}

		direct(ptr->info->field_maxwidth, ptr->info->field_maxheight);
		terminal_info(	get_posinfo(UNIT_XPOS),
						get_posinfo(UNIT_YPOS),
						get_posinfo(FIELD_XPOS),
						get_posinfo(FIELD_YPOS),
						ptr->info->field_maxwidth,
						ptr->info->field_maxheight
					);
	}

	return MAP_MOVE;
}


/**-------------------------------------------------
 * メッセージ描画モードキーイベント処理
 * -------------------------------------------------*/
static uint8_t msg_window_mode(const t_const_struct *p, t_infobuffer *ptr)
{
	SDL_Event e;

	while (SDL_PollEvent(&e)) {
		if (e.type == SDL_QUIT) {
			return MODE_END;
		}

		if (e.type != SDL_KEYDOWN) {
			return MSG_WINDOW;
		}

		switch (e.key.keysym.sym) {
			case SDLK_y:
				set_msg_status(p->msg, ptr->minfo, NULLWRITE);
				return MAP_MOVE;

			case SDLK_n:
				set_msg_status(p->msg, ptr->minfo, NULLWRITE);
				return MAP_MOVE;

			default:
				return MSG_WINDOW;
		}

	}

	return MSG_WINDOW;
}


/**-------------------------------------------------
 * メイン関数
 * -------------------------------------------------
 * SDLは同一スレッド内で扱わなければならない
 * SDLのレンダリング関数群は背面バッファを操作するため直接画面には描画されない
 * よって、描画を行うためにはフレームに描画情報を全て保存し、RenderPresent関数で
 * 一気に描画を行う必要がある
 * -------------------------------------------------*/
int main(void)
{
	SDL_Window   *window;
	SDL_Renderer *renderer;
	SDL_Texture  *map_tx[MAP_RES_SIZE];
	SDL_Texture  *player_tx;
	TTF_Font	 *font;
	Mix_Music *music;
	t_infobuffer *ptr = &infobuffer;
	const t_const_struct *p = const_struct;
	uint8_t mode = MAP_MOVE;	//モード管理変数
	uint32_t oldres = 0;		//テクスチャID更新チェック変数
	SET_PLACE(0, 0);

	if (false == sdl_init()) {
		return 1;
	}

	if (false == sdl_create(&window, &renderer, &font)) {
		sdl_finish(&window, &renderer, &font, &player_tx);
		return 1;
	}

	if (false == load_texture(UNIT_PATH, &player_tx, renderer)) {
		return 1;
	}

	if (false == bgm_start(BGM_PATH, &music)) {
		return 1;
	}

	fieldmap_info_push(world_update(), ptr->info);
	oldres = ptr->info->resid;
	map_load_texture(renderer, map_tx, p->imap, ptr->info);
	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);	//r, g, b, a ウィンドウを黒に設定
	bin_read(ptr->info->binpath, ptr->info->framebuffer_address, ptr->info->field_maxwidth, ptr->info->field_maxheight);

	while (mode != MODE_END) {
		switch (mode) {
			case MAP_MOVE:
				mode = map_move_mode(ptr);
				break;

			case MAP_BLINK:
				break;

			case CONFIG_WINDOW:
				break;

			case MSG_WINDOW:
				mode = msg_window_mode(p, ptr);
				break;

			default:
				break;
		}
		
		SDL_RenderClear(renderer);	//チラつきを防ぐため背面バッファを毎回クリアする
		map_draw(renderer, map_tx, p->imap, ptr->info);
		player_draw(renderer, &player_tx);
		make_msgbox(renderer, &font, ptr->minfo);
		SDL_RenderPresent(renderer);

		if (oldres != ptr->info->resid) {	//マップに使用するテクスチャIDが変更されたらテクスチャの更新を行う
			map_texture_destroy(map_tx);
			map_load_texture(renderer, map_tx, p->imap, ptr->info);
			oldres = ptr->info->resid;
		}
	}

	map_texture_destroy(map_tx);
	sdl_finish(&window, &renderer, &font, &player_tx);

	return 0;
}
