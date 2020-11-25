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
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include "./MAPCHIP.H"
#include "./TERMINAL.H"
 

//file pathは構造体に変更予定
#define FONT_PATH		"../res/font/PixelMplus12-Regular.ttf"
#define UNIT_PATH		"../res/img/unit/akisys.png"
#define RENDERER	(SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)	//レンダリング方法を指定


/**-------------------------------------------------
 * モード番号
 * -------------------------------------------------*/
typedef enum {
	MAP_MOVE,
	MSG_WINDOW,
	MODE_END,
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
 * 座標と向きを保存
 * -------------------------------------------------
 * arg1: ユニットのx座標
 * arg2: ユニットのy座標
 * arg3: フィールドのx座標、アニメーションを行う場合のみ値を操作する
 * arg4: フィールドのy座標、アニメーションを行う場合のみ値を操作する
 * arg5: ユニットの現在向いている方向を保存
 * arg6: ユニットの描画ファイルの切り取りを行うy座標を保存
 * -------------------------------------------------*/
typedef struct {
	int32_t unit_xpos;
	int32_t unit_ypos;
	int32_t field_xpos;
	int32_t field_ypos;
	uint8_t unit_direction;
	uint32_t res_ypos;
} t_posinfo;


/**-------------------------------------------------
 * 現在のフィールド情報を保存
 * -------------------------------------------------
 * arg1: 使用しているフレームバッファのIDを保存
 * arg2: 使用しているフレームバッファのアドレスを保存
 * arg3: 使用しているフレームバッファの横幅を保存
 * arg4: 使用しているフレームバッファの縦幅を保存
 * arg5: 現在のフィールドのバイナリファイルの相対パスを保存
 * -------------------------------------------------*/
typedef struct {
	uint8_t id;
	uint32_t *framebuffer_address;
	int32_t field_maxwidth;
	int32_t field_maxheight;
	char *binpath;
} t_fieldinfo;


/**-------------------------------------------------
 * マップチップ選択用情報
 * -------------------------------------------------
 * arg1: 現在選択しているマップチップのIDを保存
 * arg2: ONの時マップチップ選択画面を描画
 * arg3: マップチップ選択画面のカーソル移動用変数
 * arg4: マップチップ選択画面のカーソル移動用変数
 * -------------------------------------------------*/
typedef struct {
	uint32_t nowid;
	uint8_t mapchip_flag;
	uint32_t ychip;
	uint32_t xchip;
} t_chipinfo;


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
	t_posinfo	*pos;
	t_fieldinfo *info;
	t_chipinfo	*chip;
	t_msginfo	*minfo;
} t_infobuffer;

/**-------------------------------------------------
 * 構造体の確保
 * -------------------------------------------------*/
static t_posinfo posinfo     = {0, 0, 0, 0, 0, 0};
static t_fieldinfo fieldinfo = {0, mapsize_window_same, MAP_DRAW_WIDTH, MAP_DRAW_HEIGHT};
static t_chipinfo chipinfo   = {0, 0, 0, 0};
static t_msginfo msginfo	 = {NULLWRITE, "\0"};


/**-------------------------------------------------
 * 構造体のアドレス確保
 * -------------------------------------------------*/
static t_infobuffer infobuffer = {
	&posinfo,
	&fieldinfo,
	&chipinfo,
	&msginfo
};


/**-------------------------------------------------
 * SDL関数群
 * -------------------------------------------------*/
static bool sdl_init(void);
static bool sdl_create(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font);
static void sdl_finish(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font);
static bool load_texture(const char *path, SDL_Texture **p, SDL_Renderer *renderer, int8_t flag);
static bool load_ttf_msg(const char *msg, SDL_Texture **tx, TTF_Font **p, SDL_Renderer *renderer);
static bool player_draw(SDL_Renderer *renderer, t_posinfo *pos);
static bool map_draw(SDL_Renderer *renderer, const t_mapid *p, const t_mapinfo *map, t_posinfo *pos, t_fieldinfo *info);
static bool font_draw(SDL_Renderer *renderer, TTF_Font **font, char *s, uint32_t width, uint32_t height);
static bool mapchip_draw(SDL_Renderer *renderer, const t_mapinfo *map, t_chipinfo *chip);
static void map_direct(const t_mapinfo *map, t_posinfo *pos, t_fieldinfo *info, t_chipinfo *chip);
static bool make_msgbox(SDL_Renderer *renderer, TTF_Font **font, t_msginfo *minfo);



/**-------------------------------------------------
 * モード関数
 * -------------------------------------------------*/
static uint8_t map_move_mode(const t_const_struct *p, t_infobuffer *ptr);
static uint8_t msg_window_mode(const t_const_struct *p, t_infobuffer *ptr);


/**-------------------------------------------------
 * 座標計算
 * -------------------------------------------------*/
static void pos_update(t_posinfo *p);
static void xpos_move_right(t_fieldinfo *info, t_posinfo *p);
static void xpos_move_left(t_posinfo *p);
static void ypos_move_up(t_posinfo *p);
static void ypos_move_down(t_fieldinfo *info, t_posinfo *p);
static void direct(t_fieldinfo *info, t_posinfo *p);


/**-------------------------------------------------
 * マップチップ情報操作
 * -------------------------------------------------*/
static char **get_mapchip_path(const t_mapinfo *p);
static const t_mapinfo *map_address_advance(const t_mapinfo *p, uint32_t d);
static void back_mapchip(const t_mapinfo *p, t_chipinfo *chip);
static void next_mapchip(const t_mapinfo *p, t_chipinfo *chip);
static void chip_advance(const t_mapinfo *p, t_chipinfo *chip, char s);
static void mapchip_disp_set(t_chipinfo *chip);


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
 * ファイル操作
 * -------------------------------------------------*/
static bool mapf_write(t_fieldinfo *info);
static bool mapf_read(t_fieldinfo *info);



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
 * arg1: id		フレームバッファのIDを指定
 * arg2: *info	マップ情報を保存する構造体のアドレスを指定
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
static const t_mapinfo *map_address_advance(const t_mapinfo *p, uint32_t d)
{
	for (uint8_t i = 0; i < CHIP_INFO; i++, p++) {
		if ((p->startid <= d) && (d <= p->endid)) {
			break;
		}
	}

	return p;
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
 * ひとつ前のマップチップデータのIDに更新
 * ------------------------------------------------- 
 * arg1: *p 	マップチップ構造体のアドレスを指定
 * arg2: *chip	マップチップの現在の情報を保存する構造体のアドレスを指定
 * -------------------------------------------------*/
static void back_mapchip(const t_mapinfo *p, t_chipinfo *chip)
{
	uint32_t id;

	chip->xchip = 0;
	chip->ychip = 0;
	p = map_address_advance(p, chip->nowid);
	id = p->startid;	//現在のマップチップIDを取得

	if (id == MAPCHIP_START) {		//ID番号0であれば最終IDに更新
		id = MAPCHIP_END;
	}

	chip->nowid = id-1;	//ひとつ前のIDに更新
}


/**-------------------------------------------------
 * 次のマップチップデータのIDに更新
 * ------------------------------------------------- 
 * arg1: *p 	マップチップ構造体のアドレスを指定
 * arg2: *chip	マップチップの取得用構造体のアドレスを指定
 * -------------------------------------------------*/
static void next_mapchip(const t_mapinfo *p, t_chipinfo *chip)
{
	uint32_t id;

	chip->xchip = 0;
	chip->ychip = 0;
	p = map_address_advance(p, chip->nowid);
	id = p->endid+1;		//次のマップチップIDに進める

	if (id > MAPCHIP_END) {	//0~最終IDをループ
		id = MAPCHIP_START;
	}

	chip->nowid = id;		//IDを更新する
}


/**-------------------------------------------------
 * マップチップを取得するために必要な、座標指定用変数を更新
 * -------------------------------------------------
 * arg1: *p		マップチップ構造体のアドレスを指定
 * arg2: *chip	マップチップ取得用構造体のアドレスを指定
 * arg3: s		'x'xchipを更新　'y'ychipを更新
 * -------------------------------------------------*/
static void chip_advance(const t_mapinfo *p, t_chipinfo *chip, char s)
{
	p = map_address_advance(p, chip->nowid);

	if (s == 'x') {
		chip->xchip++;
		if ((p->maxwidth / p->xpixel) < chip->xchip) {
			chip->xchip = 0;
		}
		return;
	}

	if (s == 'y') {
		chip->ychip++;
		if ((p->maxheight / p->ypixel) < chip->ychip) {
			chip->ychip = 0;
		}
		return;
	}
}


/**-------------------------------------------------
 * マップチップ選択画面のON/OFF設定関数
 * -------------------------------------------------
 * arg1: *chip	マップチップ取得用構造体のアドレスを指定
 * -------------------------------------------------*/
static void mapchip_disp_set(t_chipinfo *chip)
{
	chip->mapchip_flag = ~chip->mapchip_flag & 0x01;
}


/**-------------------------------------------------
 * マップ切り替え時の座標データの指定
 * -------------------------------------------------*/
static void pos_update(t_posinfo *p)
{
	p->unit_xpos  = 0;
	p->unit_ypos  = 0;
	p->field_xpos = 0;
	p->field_ypos = 0;
	p->unit_direction = DOWN;
	p->res_ypos = 0;
}



/**-------------------------------------------
 * x軸右移動の座標計算
 * -------------------------------------------
 * ウィンドウのサイズよりもマップのサイズが小さい場合
 * プレイヤーの座標軸だけを移動させる。
 *
 * ウィンドウのサイズよりもマップのサイズが大きい場合
 * アニメーションを行うためにマップの座標軸を移動させる
 * -------------------------------------------
 * arg1: *info	現在のフィールド情報が格納されている構造体のアドレス
 * arg2: *p		プレイヤーの位置情報が格納されている構造体のアドレス
 * -------------------------------------------*/
static void xpos_move_right(t_fieldinfo *info, t_posinfo *p)
{
	p->unit_direction = RIGHT;
	p->res_ypos = UNIT_HEIGHT;

	if ((MAP_DRAW_WIDTH + p->field_xpos) >= info->field_maxwidth) {
		p->unit_xpos++;
		return;
	}

	if (p->unit_xpos >= (MAP_DRAW_WIDTH >> 1)) {
		p->field_xpos++;
		return;
	}

	p->unit_xpos++;
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
		return;
	}

	if (p->field_xpos != 0) {
		p->field_xpos--;
		return;
	}

	p->unit_xpos--;
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
		return;
	}

	if (p->field_ypos != 0) {
		p->field_ypos--;
		return;
	}

	p->unit_ypos--;
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
		return;
	}

	if (p->unit_ypos > (MAP_DRAW_HEIGHT >> 1)) {
		p->field_ypos++;
		return;
	}

	p->unit_ypos++;
}


/**-------------------------------------------------
 * 当たり判定
 * -------------------------------------------------*/
static void direct(t_fieldinfo *info, t_posinfo *p)
{
	int32_t ux = p->unit_xpos;
	int32_t uy = p->unit_ypos;
	int32_t fx = p->field_xpos;
	int32_t fy = p->field_ypos;
	int32_t width  = info->field_maxwidth;
	int32_t height = info->field_maxheight;
	
	switch (p->unit_direction) {
	case RIGHT:
		if (width <= (fx + ux)) {
			p->unit_xpos--;
		}
		break;

	case LEFT:
		if (ux < 0) {
			p->unit_xpos++;
		}
		break;

	case DOWN:
		if (height <= (fy + uy)) {
			p->unit_ypos--;
		}
		break;

	case UP:
		if (uy < 0) {
			p->unit_ypos++;
		}
		break;

	default:
		break;
	}
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
static bool load_texture(const char *path, SDL_Texture **p, SDL_Renderer *renderer, int8_t flag)
{
	SDL_Surface *image;

	image = IMG_Load(path);

	if (image == NULL) {
		fprintf(stderr, "Texture Load Error!: %s  File Path: %s\n", IMG_GetError(), path);
		return false;
	}

	SDL_SetColorKey(image, flag, SDL_MapRGB(image->format, 255, 255, 255));
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
	TTF_CloseFont(*font);
	TTF_Quit();
	IMG_Quit();
	SDL_DestroyRenderer(*renderer);
	SDL_DestroyWindow(*window);
	SDL_Quit();
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

	if (false == load_texture(UNIT_PATH, &player_tx, renderer, SDL_FALSE)) {
		return false;
	}

	SDL_Rect res  = (SDL_Rect){
		0,
		pos->res_ypos,
		UNIT_WIDTH,
		UNIT_HEIGHT
	};

	SDL_Rect draw = (SDL_Rect){
		((pos->unit_xpos << MAP_SIZE_SHIFT)),
		((pos->unit_ypos << MAP_SIZE_SHIFT)),
		GRID_SIZE,
		GRID_SIZE
	};

	SDL_RenderCopy(renderer, player_tx, &res, &draw);
	SDL_DestroyTexture(player_tx);
	player_tx = NULL;

	return true;
}


/**-------------------------------------------------
 * マップの描画
 * 一つの要素の描画は縦横GRID_SIZEで固定
 * 16,32,の大きさを使用する場合は構造体を用意しデータを取得するよう変更
 * ウィンドウの大きさに対して必要な分だけ描画を行う
 * -------------------------------------------------
 * arg1: *renderer	レンダリング情報
 * arg2: *p			マップチップの一つの要素の座標が保存されている構造体のアドレス
 * arg3: *map		マップチップの座標以外の情報が保存されている構造体のアドレス
 * arg4: *pos		プレイヤーの位置情報が保存されている構造体のアドレス
 * arg5: *info		現在のフィールドバッファの情報が保存されている構造体のアドレス
 * -------------------------------------------------*/
static bool map_draw(SDL_Renderer *renderer, const t_mapid *p, const t_mapinfo *map, t_posinfo *pos, t_fieldinfo *info)
{
	const t_mapid *oldp = p;
	const t_mapinfo *oldmap = map;
	SDL_Texture *map_tx;
	SDL_Rect map_res;
	SDL_Rect map_draw;
	uint32_t i, j;	//forループ用変数
	uint32_t d;		//バイナリデータ保存
	uint32_t x, y;	//計算用に座標を一時保存
	uint32_t *ptr;	//フレームバッファの先頭アドレスを保存
	char **path;	//テクスチャーデータの相対パスを保存

	ptr = info->framebuffer_address;
	x = pos->field_xpos;
	y = pos->field_ypos;

	for (i = 0; i < MAP_DRAW_HEIGHT; i++) {
		for (j = 0; j < MAP_DRAW_WIDTH; j++) {
			d = ptr[((i+y) * MAP_DRAW_WIDTH)+j+x];	//マップチップに対応したバイナリデータを取得
			p = p + d;								//使用する画像データの切り抜き座標を更新
			map = map_address_advance(map, d);		//画像データの情報を更新
			path = get_mapchip_path(map);
			load_texture((char *)path, &map_tx, renderer, SDL_TRUE);
			map_res  = (SDL_Rect){p->xpos, p->ypos, map->xpixel, map->ypixel};
			map_draw = (SDL_Rect){j << MAP_SIZE_SHIFT, i << MAP_SIZE_SHIFT, GRID_SIZE, GRID_SIZE};
			SDL_RenderCopy(renderer, map_tx, &map_res, &map_draw);
			p = oldp;			//アドレスを初期位置に戻す
			map = oldmap;
		}
	}

	SDL_DestroyTexture(map_tx);
	map_tx = NULL;

	return true;
}


/**-------------------------------------------------
 * マップチップ選択画面描画
 * 縦横MAPCHIP_SIZEの大きさで描画、画像データの上に薄い黒の四角形を描画し選択カーソルを再現
 * -------------------------------------------------
 * arg1: *renderer	レンダリング情報
 * arg2: *map		マップチップの座標以外の情報が保存されている構造体のアドレス
 * arg3: *chip		マップチップの描画に必要な情報が格納されている構造体のアドレス
 * -------------------------------------------------*/
static bool mapchip_draw(SDL_Renderer *renderer, const t_mapinfo *map, t_chipinfo *chip)
{
	SDL_Texture *mapchip;
	char **path;
	uint32_t maxwidth, ypixel;

	if (chip->mapchip_flag == 0) {
		return false;
	}

	map  = map_address_advance(map, chip->nowid);
	path = get_mapchip_path(map);
	maxwidth = map->maxwidth;
	ypixel   = map->ypixel;

	if (false == load_texture((char *)path, &mapchip, renderer, SDL_FALSE)) {
		fprintf(stderr, "mapchip_draw error\n");
		return false;
	}

	SDL_Rect chip_draw = (SDL_Rect){0, chip->ychip*ypixel, maxwidth, ypixel};
	SDL_Rect rend  = (SDL_Rect){0, 0, maxwidth, MAPCHIP_SIZE};
	SDL_RenderCopy(renderer, mapchip, &chip_draw, &rend);

	SDL_SetRenderDrawBlendMode(renderer, SDL_BLENDMODE_BLEND);
	SDL_Rect back_black = (SDL_Rect){chip->xchip*MAPCHIP_SIZE, 0, MAPCHIP_SIZE, MAPCHIP_SIZE};
	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 100);
	SDL_RenderFillRect(renderer, &back_black);

	SDL_DestroyTexture(mapchip);
	mapchip = NULL;

	return true;
}


/**-------------------------------------------------
 * マップチップデータをフレームバッファに格納する関数
 * -------------------------------------------------
 * arg1: *map		マップチップの座標以外の情報が保存されている構造体のアドレス
 * arg2: *pos		プレイヤーの位置情報が保存されている構造体のアドレス
 * arg3: *info		現在のフィールドバッファの情報が保存されている構造体のアドレス
 * arg4: *chip		マップチップの描画に必要な情報が格納されている構造体のアドレス
 * -------------------------------------------------*/
static void map_direct(const t_mapinfo *map, t_posinfo *pos, t_fieldinfo *info, t_chipinfo *chip)
{
	uint32_t d;	//バイナリデータ計算用変数

	map = map_address_advance(map, chip->nowid);
	d = chip->ychip * (map->maxwidth / map->xpixel);
	d = d + chip->xchip + map->startid;
	info->framebuffer_address[(pos->unit_xpos + (pos->unit_ypos * info->field_maxwidth))] = d;
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
 * フレームバッファのデータをバイナリファイルに書き込む
 * -------------------------------------------------*/
static bool mapf_write(t_fieldinfo *info)
{
	FILE *fp = NULL;
	uint32_t mapsize;

	fp = fopen(info->binpath, "wb");

	if (fp == NULL) {
		terminal_str("file open error", info->binpath);
		fclose(fp);
		return false;
	}

	mapsize = info->field_maxwidth * info->field_maxheight;
	fwrite(info->framebuffer_address, sizeof(uint32_t), mapsize, fp);
	terminal_str("マップ作成完了", info->binpath);
	fclose(fp);

	return true;
}


/**-------------------------------------------------
 * バイナリファイルのデータをフレームバッファに読み込む
 * -------------------------------------------------*/
static bool mapf_read(t_fieldinfo *info)
{
	FILE *fp = NULL;
	uint32_t mapsize;

	fp = fopen(info->binpath, "rb");

	if (fp == NULL) {
		terminal_str("file read error", info->binpath);
		fclose(fp);
		return false;
	}

	mapsize = info->field_maxwidth * info->field_maxheight;
	fread(info->framebuffer_address, sizeof(uint32_t), mapsize, fp);
	terminal_str("マップ読み込み完了", info->binpath);
	fclose(fp);

	return true;
}


/**-------------------------------------------------
 * マップ移動モードキーイベント処理
 * -------------------------------------------------*/
static uint8_t map_move_mode(const t_const_struct *p, t_infobuffer *ptr)
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
				ypos_move_up(ptr->pos);
				break;

			case SDLK_LEFT:
				xpos_move_left(ptr->pos);
				break;

			case SDLK_DOWN:
				ypos_move_down(ptr->info, ptr->pos);
				break;

			case SDLK_RIGHT:
				xpos_move_right(ptr->info, ptr->pos);
				break;

			case SDLK_n:	//次のマップ作製
				pos_update(ptr->pos);
				fieldmap_info_push(world_update(), ptr->info);
				break;

			case SDLK_w:	//セーブ
				set_msg_status(p->msg, ptr->minfo, DATAWRITE);
				return MSG_WINDOW;

			case SDLK_r:	//マップロード
				set_msg_status(p->msg, ptr->minfo, DATAREAD);
				return MSG_WINDOW;

			case SDLK_q:	//マップチップ選択画面、ON/OFF
				mapchip_disp_set(ptr->chip);
				break;

			case SDLK_j:	//マップチップを配置
				map_direct(p->imap, ptr->pos, ptr->info, ptr->chip);
				break;

			case SDLK_h:	//マップチップカーソル右移動
				chip_advance(p->imap, ptr->chip, 'x');
				break;

			case SDLK_g:	//マップチップカーソル縦移動
				chip_advance(p->imap, ptr->chip, 'y');
				break;

			case SDLK_z:	//前のマップチップ画像データ読み込み
				back_mapchip(p->imap, ptr->chip);
				break;

			case SDLK_x:	//次のマップチップ画像データ読み込み
				next_mapchip(p->imap, ptr->chip);
				break;

			default:
				break;
		}

		direct(ptr->info, ptr->pos);
		terminal_info(	ptr->pos->unit_xpos,
						ptr->pos->unit_ypos,
						ptr->pos->field_xpos,
						ptr->pos->field_ypos,
						ptr->info->field_maxwidth,
						ptr->info->field_maxheight,
						ptr->chip->nowid
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
				mapf_write(ptr->info);
				set_msg_status(p->msg, ptr->minfo, NULLWRITE);
				return MAP_MOVE;

			case SDLK_n:
				mapf_read(ptr->info);
				set_msg_status(p->msg, ptr->minfo, NULLWRITE);
				return MAP_MOVE;

			default:
				break;
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
	TTF_Font	 *font;
	t_infobuffer *ptr = &infobuffer;
	const t_const_struct *p = const_struct;
	uint8_t mode = MAP_MOVE;

	if (false == sdl_init()) {
		return 1;
	}

	if (false == sdl_create(&window, &renderer, &font)) {
		sdl_finish(&window, &renderer, &font);
		return 1;
	}

	fieldmap_info_push(world_update(), ptr->info);
	//SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);	//r, g, b, a ウィンドウを黒に設定

	while (mode != MODE_END) {
		switch (mode) {
			case MAP_MOVE:
				mode = map_move_mode(p, ptr);
				break;

			case MSG_WINDOW:
				mode = msg_window_mode(p, ptr);
				break;

			default:
				break;
		}
		
		SDL_RenderClear(renderer);	//チラつきを防ぐため背面バッファを毎回クリアする
		map_draw(renderer, p->map, p->imap, ptr->pos, ptr->info);
		mapchip_draw(renderer, p->imap, ptr->chip);
		player_draw(renderer, ptr->pos);
		make_msgbox(renderer, &font, ptr->minfo);
		SDL_RenderPresent(renderer);	//フレームの情報を全て描画する
	}

	sdl_finish(&window, &renderer, &font);

	return 0;
}