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
static uint32_t map40_30[MAP_DRAW_WIDTH*MAP_DRAW_HEIGHT]             = {0};
static uint32_t map80_60[(MAP_DRAW_WIDTH*2) * (MAP_DRAW_HEIGHT*2)]   = {0};
static uint32_t map120_90[(MAP_DRAW_WIDTH*3) * (MAP_DRAW_HEIGHT*3)]  = {0};
static uint32_t map160_120[(MAP_DRAW_WIDTH*4) * (MAP_DRAW_HEIGHT*4)] = {0};
static uint32_t map320_240[(MAP_DRAW_WIDTH*5) * (MAP_DRAW_HEIGHT*5)] = {0};



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
	int32_t ypos_animation_check;
	int32_t xpos_animation_check;
} t_posinfo;


/**-------------------------------------------------
 * 現在のフィールド情報を保存
 * -------------------------------------------------*/
typedef struct {
	uint8_t id;
	uint32_t *framebuffer_address;
	int32_t field_maxwidth;		//現在フィールドの最大横幅指定
	int32_t field_maxheight;	//現在フィールドの最大高さ指定
	char *binpath;
} t_fieldinfo;


/**-------------------------------------------------
 * マップチップ選択用情報
 * -------------------------------------------------*/
typedef struct {
	uint32_t nowid;
	uint8_t mapchip_flag;
	uint32_t mapchip_direct;
	uint32_t ychip;
	uint32_t xchip;
} t_chipinfo;


/**-------------------------------------------------
 * 構造体の確保
 * -------------------------------------------------*/
static t_posinfo posinfo     = {0, 0, 0, 0, 0, 0, 0, 0, 0};
static t_fieldinfo fieldinfo = {0, map40_30, MAP_DRAW_WIDTH, MAP_DRAW_HEIGHT};
static t_chipinfo chipinfo   = {0, 0, 0, 0, 0};


/**-------------------------------------------------
 * SDL関数群
 * -------------------------------------------------*/
static bool sdl_init(void);
static bool sdl_create(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font);
static void sdl_finish(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font);
static bool load_texture(const char *path, SDL_Texture **p, SDL_Renderer *renderer);
static bool load_ttf_msg(const char *msg, SDL_Texture **tx, TTF_Font **p, SDL_Renderer *renderer);
static bool player_draw(SDL_Renderer *renderer, t_posinfo *pos);
static bool map_draw(SDL_Renderer *renderer, const t_mapid *p, const t_mapinfo *map, t_posinfo *pos, t_fieldinfo *info);
static bool font_draw(SDL_Renderer *renderer, TTF_Font **font);
static bool mapchip_draw(SDL_Renderer *renderer, const t_mapinfo *map, t_chipinfo *chip);
static bool map_direct(SDL_Renderer *renderer, const t_mapinfo *map, t_posinfo *pos, t_fieldinfo *info, t_chipinfo *chip);
static bool make_msgbox(SDL_Renderer *renderer, char mag);


/**-------------------------------------------------
 * モード関数
 * -------------------------------------------------*/
static uint8_t map_move(const t_mapid *p, const t_mapinfo *map, t_fieldinfo *info, t_posinfo *pos, t_chipinfo *chip);


/**-------------------------------------------------
 * 座標計算
 * -------------------------------------------------*/
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
 * ファイル操作
 * -------------------------------------------------*/
static bool mapf_write(t_fieldinfo *info);
static bool mapf_read(t_fieldinfo *info);


/**-------------------------------------------------
 * マップ作製ID更新
 * -------------------------------------------------*/
static uint8_t world_update(void)
{
	static uint8_t worldid = WORLD_MAP;

	worldid++;

	if (worldid < TOTAL_FIERL) {
		worldid = WORLD_MAP;
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
		case MAP40:
			return &map40_30[0];

		case MAP80:
			return &map80_60[0];

		case MAP120:
			return &map120_90[0];

		case MAP160:
			return &map160_120[0];

		case MAP320:
			return &map320_240[0];

		default:
			return &map40_30[0];
	}
}


/**-------------------------------------------------
 * t_mapinfoのアドレスを進める
 * マップチップの開始IDと終了IDの範囲内になるまでループを行う
 * -------------------------------------------------
 * arg1: *p マップチップ構造体のアドレスを指定
 * arg2: d	IDを指定する
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

	if (id == 0) {		//ID番号0であれば最終IDに更新
		id = END_CHIPID;
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

	if (id < END_CHIPID) {	//0~最終IDをループ
		id = 0;
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

	if (width < (fx + ux)) {
		p->unit_xpos--;
		return;
	}

	if ((ux - fx) < 0) {
		p->unit_xpos++;
		return;
	}

	if (height < (fy + uy)) {
		p->unit_ypos--;
		return;
	}

	if ((uy - fy) < 0) {
		p->unit_ypos++;
		return;
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

	if (false == load_texture(UNIT_PATH, &player_tx, renderer)) {
		return false;
	}

	SDL_Rect res  = (SDL_Rect){0, pos->res_ypos, UNIT_WIDTH, UNIT_HEIGHT};
	SDL_Rect draw = (SDL_Rect){pos->unit_xpos << UNIT_SHIFT, pos->unit_ypos << UNIT_SHIFT, UNIT_WIDTH, UNIT_HEIGHT};
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
	uint32_t load = 0;
	uint32_t i, j, d, x, y;
	uint32_t *ptr;
	char **path;

	ptr = info->framebuffer_address;				//フレームバッファの先頭アドレスを取得
	x = pos->field_xpos;
	y = pos->field_ypos;

	for (i = 0; i < MAP_DRAW_HEIGHT; i++) {			//ウィンドウのサイズ分ループして描画する
		for (j = 0; j < MAP_DRAW_WIDTH; j++) {
			d = ptr[((i+y) * MAP_DRAW_WIDTH)+j+x];	//マップチップに対応したバイナリデータを取得
			p = p + d;								//使用する画像データの切り抜き座標を更新
			map = map_address_advance(map, d);		//画像データの情報を更新

			if (load != map->endid) {	//前回のデータと同じ場合テクスチャーの更新を行わない
				path = get_mapchip_path(map);
				load_texture((char *)path, &map_tx, renderer);
			}
			map_res  = (SDL_Rect){p->xpos, p->ypos, map->xpixel, map->ypixel};
			map_draw = (SDL_Rect){j << MAP_SIZE_SHIFT, i << MAP_SIZE_SHIFT, GRID_SIZE, GRID_SIZE};
			SDL_RenderCopy(renderer, map_tx, &map_res, &map_draw);
			load = map->endid;	//前回のデータを一時保存しておく
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
 * 16*16のサイズで描画、画像データの上に薄い黒の四角形を描画し選択カーソルを再現
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

	if (false == load_texture((char *)path, &mapchip, renderer)) {
		return false;
	}

	SDL_Rect chip_draw = (SDL_Rect){0, chip->ychip*ypixel, maxwidth, ypixel};
	SDL_Rect rend  = (SDL_Rect){0, 0, MAPCHIP_SIZE, MAPCHIP_SIZE};
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
 * 指定した座標にマップチップ配置
 * -------------------------------------------------
 * arg1: *renderer	レンダリング情報
 * arg2: *map		マップチップの座標以外の情報が保存されている構造体のアドレス
 * arg3: *pos		プレイヤーの位置情報が保存されている構造体のアドレス
 * arg4: *info		現在のフィールドバッファの情報が保存されている構造体のアドレス
 * arg5: *chip		マップチップの描画に必要な情報が格納されている構造体のアドレス
 * -------------------------------------------------*/
static bool map_direct(SDL_Renderer *renderer, const t_mapinfo *map, t_posinfo *pos, t_fieldinfo *info, t_chipinfo *chip)
{
	SDL_Texture *mapchip;
	uint32_t d, uxpos, uypos, xchip, ychip;
	char **path;

	if (chip->mapchip_direct == 0) {
		return false;
	}

	map = map_address_advance(map, chip->nowid);
	uxpos = pos->unit_xpos;
	uypos = pos->unit_ypos;
	xchip = chip->xchip;
	ychip = chip->ychip;
	d = ychip * (map->maxwidth / map->xpixel);
	d = d + xchip + map->startid;	//フレームバッファに保存するバイナリデータを計算
	path = get_mapchip_path(map);

	if (false == load_texture((char *)path, &mapchip, renderer)) {
		return false;
	}

	SDL_Rect chip_draw = (SDL_Rect){xchip*map->xpixel, ychip*map->ypixel, GRID_SIZE, GRID_SIZE};
	SDL_Rect draw = (SDL_Rect){uxpos << UNIT_SHIFT, uypos << UNIT_SHIFT, GRID_SIZE, GRID_SIZE};
	SDL_RenderCopy(renderer, mapchip, &chip_draw, &draw);

	SDL_DestroyTexture(mapchip);
	mapchip = NULL;
	chip->mapchip_direct = 0;
	info->framebuffer_address[uxpos + (uypos*info->field_maxwidth)] = d;

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
 * メッセージウィンドウの描画
 * 白枠を描画後、黒の四角形を描画
 * -------------------------------------------------
 * arg1: *renderer	レンダリング情報
 * arg2: msg		'w'write 文字を入力する 'r'文字を描画する
 * -------------------------------------------------*/
static bool make_msgbox(SDL_Renderer *renderer, char mag)
{
	/*if (false == get_msgcheck()) {
		return false;
	}*/

	SDL_Rect white;
	SDL_Rect black;

	white.x = (SCREEN_WIDTH >> 2) - MSG_FLAME_SIZE;
	white.y = (SCREEN_HEIGHT >> 2) + (SCREEN_HEIGHT >> 1) - MSG_FLAME_SIZE;
	white.w = (SCREEN_WIDTH >> 1) + MSG_FLAME_SIZE;
	white.h = 200 + MSG_FLAME_SIZE;

	black.x = SCREEN_WIDTH >> 2;
	black.y = (SCREEN_HEIGHT >> 2) + (SCREEN_HEIGHT >> 1);
	black.w = SCREEN_WIDTH >> 1;
	black.h = 200;

	SDL_SetRenderDrawBlendMode(renderer, SDL_BLENDMODE_BLEND);
	SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
	SDL_RenderFillRect(renderer, &white);

	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
	SDL_RenderFillRect(renderer, &black);

	//while
	//set_msgcheck();

	return true;
}



/**-------------------------------------------------
 * キーイベント処理
 * -------------------------------------------------
 * arg1: p			マップチップの当たり判定が格納されている構造体のアドレス
 * arg2: *map		マップチップの座標以外の情報が保存されている構造体のアドレス
 * arg3: *pos		プレイヤーの位置情報が保存されている構造体のアドレス
 * arg4: *info		現在のフィールドバッファの情報が保存されている構造体のアドレス
 * arg5: *chip		マップチップの描画に必要な情報が格納されている構造体のアドレス
 * -------------------------------------------------*/
static uint8_t map_move(const t_mapid *p, const t_mapinfo *map, t_fieldinfo *info, t_posinfo *pos, t_chipinfo *chip)
{
	SDL_Event e;

	while (SDL_PollEvent(&e)) {		//イベント処理が終わるまでループ
		if (e.type == SDL_QUIT) {	//ウィンドウの閉じるボタンが押されたら抜ける
			return MODE_END;
		}

		if (e.type != SDL_KEYDOWN) {
			return MAP_MOVE;
		}

		switch (e.key.keysym.sym) {
			case SDLK_w:
				ypos_move_up(pos);
				break;

			case SDLK_a:
				xpos_move_left(pos);
				break;

			case SDLK_s:
				ypos_move_down(info, pos);
				break;

			case SDLK_d:
				xpos_move_right(info, pos);
				break;

			case SDLK_p:	//マップチップを配置
				chip->mapchip_direct = 1;
				break;

			case SDLK_o:	//草原を配置
				break;

			case SDLK_k:	//マップロード
				mapf_read(info);
				break;

			case SDLK_n:
				fieldmap_info_push(world_update(), info);
				break;

			case SDLK_l:	//セーブ
				mapf_write(info);
				break;

			case SDLK_q:	//マップチップ選択画面、ON/OFF
				mapchip_disp_set(chip);
				break;

			case SDLK_e:	//マップチップカーソル右移動
				chip_advance(map, chip, 'x');
				break;

			case SDLK_r:	//マップチップカーソル縦移動
				chip_advance(map, chip, 'y');
				break;

			case SDLK_t:	//前のマップチップ画像データ読み込み
				back_mapchip(map, chip);
				break;

			case SDLK_y:	//次のマップチップ画像データ読み込み
				next_mapchip(map, chip);
				break;

			default:
				break;
		}
	}

	return MAP_MOVE;
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
		printf("ファイルopenエラー\n");
		return false;
	}

	mapsize = info->field_maxwidth * info->field_maxheight;
	fwrite(info->framebuffer_address, sizeof(uint32_t), mapsize, fp);

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
		printf("ファイルreadエラー\n");
		return false;
	}

	mapsize = info->field_maxwidth * info->field_maxheight;
	fread(info->framebuffer_address, sizeof(uint32_t), mapsize, fp);
	//fread(map40_30, sizeof(uint32_t), NUM(map40_30), fp);

	/*for (uint32_t i = 0; i < mapsize; i++) {
		printf("0x%04x \r\n", p[i]);
	}*/

	fclose(fp);

	return true;
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
	SDL_Window *window;
	SDL_Renderer *renderer;
	TTF_Font *font;
	t_posinfo *pos    = &posinfo;
	t_fieldinfo *info = &fieldinfo;
	t_chipinfo *chip  = &chipinfo;
	const t_mapid *p  = mapid;
	const t_mapinfo *map = mapinfo;
	uint8_t mode = MAP_MOVE;

	if (false == sdl_init()) {
		return 1;
	}

	if (false == sdl_create(&window, &renderer, &font)) {
		sdl_finish(&window, &renderer, &font);
		return 1;
	}

	fieldmap_info_push(world_update(), info);
	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);	//r, g, b, a ウィンドウを黒に設定

	while (mode != MODE_END) {
		switch (mode) {
			case MAP_MOVE:
				mode = map_move(p, map, info, pos, chip);
				direct(info, pos);
				break;

			case MSG_WINDOW:
				break;

			default:
				break;
		}

		SDL_RenderClear(renderer);	//チラつきを防ぐため背面バッファを毎回クリアする
		map_draw(renderer, p, map, pos, info);
		//font_draw(renderer, &font);
		mapchip_draw(renderer, map, chip);
		map_direct(renderer, map, pos, info, chip);
		player_draw(renderer, pos);
		make_msgbox(renderer, 'r');
		SDL_RenderPresent(renderer);	//フレームの情報を全て描画する
	}

	sdl_finish(&window, &renderer, &font);

	return 0;
}
