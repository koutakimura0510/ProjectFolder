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
#include "./DRAW.H"
#include "./MAPCHIP.H"
 
#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))
#define FIELDMAP_SIZE ((sizeof (fieldmap)) / (sizeof (t_fieldmap)))


#define SCREEN_WIDTH	1280	//ウィンドウの幅を指定
#define SCREEN_HEIGHT	960		//ウィンドウの高さを指定
#define GRID_SIZE		32		//マップ描画データのpixel幅と高さを指定
#define MAP_SIZE_SHIFT	5		//5bitシフトすれば32になる
#define MAP_DRAW_WIDTH	(SCREEN_WIDTH >> MAP_SIZE_SHIFT)	//幅のループ回数
#define MAP_DRAW_HEIGHT	(SCREEN_HEIGHT >> MAP_SIZE_SHIFT)	//高さのループ回数
#define UNIT_WIDTH		24		//描画ユニットデータの幅を指定
#define UNIT_HEIGHT		32		//描画ユニットデータの高さを指定
#define UNIT_SHIFT		(MAP_SIZE_SHIFT-0)		//ユニットの描画位置を指定
#define FONT_SIZE		40		//描画フォントサイズを指定
#define MAPCHIP_SIZE	12

//file pathは構造体に変更予定
#define FONT_PATH		"../res/font/PixelMplus12-Regular.ttf"
#define UNIT_PATH		"../res/img/unit/akisys.png"


#define RENDERER	(SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)	//レンダリング方法を指定


/**-------------------------------------------------
 * データ読み書き用配列確保
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
} t_fieldinfo;


/**-------------------------------------------------
 * フレームバッファ情報
 * -------------------------------------------------*/
typedef struct {
	uint8_t id;
	uint32_t *map;
	uint32_t fieldmap_width;
	uint32_t fieldmap_height;
} t_fieldmap;

static const t_fieldmap fieldmap[] = {
	{ 0, map40_30,		MAP_DRAW_WIDTH,		MAP_DRAW_HEIGHT   },
	{ 1, map80_60,		MAP_DRAW_WIDTH*2,	MAP_DRAW_HEIGHT*2 },
	{ 2, map120_90,		MAP_DRAW_WIDTH*3,	MAP_DRAW_HEIGHT*3 },
	{ 3, map160_120,	MAP_DRAW_WIDTH*4,	MAP_DRAW_HEIGHT*4 },
	{ 4, map320_240,	MAP_DRAW_WIDTH*5,	MAP_DRAW_HEIGHT*5 },
};

//マップ名(.バイナリファイル名)、上記のフレームバッファIDを保存してある構造体を本編では追加する。


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



/**-------------------------------------------------
 * キー操作
 * -------------------------------------------------*/
static bool key_event(const t_mapid *p, const t_mapinfo *map, t_fieldinfo *info, t_posinfo *pos, t_chipinfo *chip);


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
static void fieldmap_info_push(uint8_t id, t_fieldinfo *info);


/**-------------------------------------------------
 * ファイル操作
 * -------------------------------------------------*/
void mapf_write(void);
void mapf_read(void);



/**-------------------------------------------------
 * 現在のフィールドマップ情報を保存する関数
 * -------------------------------------------------*/
static void fieldmap_info_push(uint8_t id, t_fieldinfo *info)
{
	const t_fieldmap *p = fieldmap;

	for (uint8_t i = 0; i < FIELDMAP_SIZE; i++, p++) {
		if (p->id == id) {
			break;
		}
	}

	info->id = p->id;
	info->framebuffer_address = p->map;
	info->field_maxwidth  = p->fieldmap_width;
	info->field_maxheight = p->fieldmap_height;
}


/**-------------------------------------------------
 * t_mapinfoのアドレスを進める
 * -------------------------------------------------
 * arg1: 構造体のアドレス
 * arg2: フレームバッファに格納されているデータ
 * -------------------------------------------------*/
static const t_mapinfo *map_address_advance(const t_mapinfo *p, uint32_t d)
{
	for (uint8_t i = 0; i < CHIP_INFO; i++, p++) {
		if ((p->startid < d) && (d < p->endid)) {
			break;
		}
	}

	return p;
}



/**-------------------------------------------------
 * mapchipのpathを取得
 * -------------------------------------------------*/
static char **get_mapchip_path(const t_mapinfo *p)
{
	uint8_t select;

	select = p->select;

	return (char **)p->path[select];
}


/**-------------------------------------------------
 * マップチップデータpath更新
 * -------------------------------------------------*/
static void back_mapchip(const t_mapinfo *p, t_chipinfo *chip)
{
	int32_t id;

	chip->xchip = 0;
	chip->ychip = 0;
	id = p->startid;

	if ((id-1) < 0) {
		id = END_CHIPID;
	}

	chip->nowid = id-1;
}


/**-------------------------------------------------
 * マップチップデータpath更新
 * -------------------------------------------------*/
static void next_mapchip(const t_mapinfo *p, t_chipinfo *chip)
{
	uint32_t id;

	chip->xchip = 0;
	chip->ychip = 0;
	id = p->endid+1;

	if (id == END_CHIPID) {
		id = 0;
	}

	chip->nowid = id;
}


/**-------------------------------------------------
 * mapchip取得用変数計算
 * -------------------------------------------------*/
static void chip_advance(const t_mapinfo *p, t_chipinfo *chip, char s)
{
	chip->mapchip_flag = 1;

	if (s == 'x') {
		chip->xchip++;
		if ((p->maxwidth / p->xpixel) == chip->xchip) {
			chip->xchip = 0;
		}
		return;
	}

	if (s == 'y') {
		chip->ychip++;
		if ((p->maxheight / p->ypixel) == chip->ychip) {
			chip->ychip = 0;
		}
	}

	return;
}



/**-------------------------------------------
 * x軸右移動の座標計算
 * -------------------------------------------
 * ウィンドウのサイズよりもマップのサイズが小さい場合
 * プレイヤーの座標軸だけを移動させる。
 *
 * ウィンドウのサイズよりもマップのサイズが大きい場合
 * アニメーションを行うためにマップの座標軸を移動させる
 *
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
	int32_t fmx = info->field_maxwidth;
	int32_t fmy = info->field_maxheight;

	if (fmx < (fx + ux)) {
		p->unit_xpos--;
		return;
	}

	if ((ux - fx) < 0) {
		p->unit_xpos++;
		return;
	}

	if (fmy < (fy + uy)) {
		p->unit_ypos--;
		return;
	}

	if ((uy - fy) < 0) {
		p->unit_ypos++;
		return;
	}
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
 * 使用マップ情報は縦横GRID_SIZEで固定
 * 16,32,の大きさを使用する場合は構造体を用意しデータを取得するよう変更
 * ウィンドウの大きさに対して必要な分だけ描画を行う
 * -------------------------------------------------
 * arg1:　レンダリング情報
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

	ptr = info->framebuffer_address;
	x = pos->field_xpos;
	y = pos->field_ypos;

	for (i = 0; i < MAP_DRAW_HEIGHT; i++) {	//ウィンドウのサイズ分ループして描画する
		for (j = 0; j < MAP_DRAW_WIDTH; j++) {
			d = ptr[((i+y) * MAP_DRAW_WIDTH)+j+x];	//マップチップに対応したバイナリデータを取得
			p = p + d;
			map = map_address_advance(map, d);

			if (load != map->endid) {
				path = get_mapchip_path(map);
				load_texture((char *)path, &map_tx, renderer);
			}
			map_res  = (SDL_Rect){p->xpos, p->ypos, map->xpixel, map->ypixel};
			map_draw = (SDL_Rect){j << MAP_SIZE_SHIFT, i << MAP_SIZE_SHIFT, GRID_SIZE, GRID_SIZE};
			SDL_RenderCopy(renderer, map_tx, &map_res, &map_draw);
			load = map->endid;
			p = oldp;
			map = oldmap;
		}
	}

	SDL_DestroyTexture(map_tx);
	map_tx = NULL;

	return true;
}


/**-------------------------------------------------
 * マップチップ選択画面描画
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
 * マップチップを置く
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
	d = d + xchip + map->startid;
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
 * キーイベント処理
 * -------------------------------------------------*/
static bool key_event(const t_mapid *p, const t_mapinfo *map, t_fieldinfo *info, t_posinfo *pos, t_chipinfo *chip)
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
				ypos_move_up(pos);
				return true;

			case SDLK_a:
				xpos_move_left(pos);
				return true;

			case SDLK_s:
				ypos_move_down(info, pos);
				return true;

			case SDLK_d:
				xpos_move_right(info, pos);
				return true;

			case SDLK_p:	//マップチップを配置
				chip->mapchip_direct = 1;
				return true;

			case SDLK_o:	//草原を配置
				return true;

			case SDLK_k:	//マップロード
				mapf_read();
				return true;

			case SDLK_l:	//セーブ
				mapf_write();
				return true;

			case SDLK_q:	//閉じる
				chip->mapchip_flag = 0;
				return true;

			case SDLK_e:	//マップチップ選択
				chip_advance(map, chip, 'x');
				return true;

			case SDLK_r:	//マップチップ次の選択
				chip_advance(map, chip, 'y');
				return true;

			case SDLK_t:	//前のマップチップ画像データ読み込み
				back_mapchip(map, chip);
				return true;

			case SDLK_y:	//次のマップチップ画像データ読み込み
				next_mapchip(map, chip);
				return true;

			default:
				return true;
		}
	}

	return true;
}



//配列データ書き込み
void mapf_write(void)
{
	FILE *fp = NULL;

	fp = fopen("map.bin", "wb");

	if (fp == NULL) {
		printf("ファイルopenエラー\n");
		return;
	}

	fwrite(map40_30, sizeof(uint32_t), NUM(map40_30), fp);

	fclose(fp);
}


//配列データ読み込み
void mapf_read(void)
{
	FILE *fp = NULL;

	fp = fopen("map.bin", "rb");

	if (fp == NULL) {
		printf("ファイルreadエラー\n");
		return;
	}
	fread(map40_30, sizeof(uint32_t), NUM(map40_30), fp);

	for (uint32_t i = 0; i < MAP_DRAW_WIDTH*MAP_DRAW_HEIGHT; i++) {
		printf("0x%04x \r\n", map40_30[i]);
	}

	fclose(fp);
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
	t_posinfo *pos    = &posinfo;
	t_fieldinfo *info = &fieldinfo;
	t_chipinfo *chip  = &chipinfo;
	const t_mapid *p  = mapid;
	const t_mapinfo *map = mapinfo;

	if (false == sdl_init()) {
		return 1;
	}

	if (false == sdl_create(&window, &renderer, &font)) {
		sdl_finish(&window, &renderer, &font);
		return 1;
	}

	fieldmap_info_push(0, info);
	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);	//r, g, b, a ウィンドウを黒に設定

	while (1) {
		if (false == key_event(p, map, info, pos, chip)) {
			break;
		}

		direct(info, pos);
		SDL_RenderClear(renderer);
		map_draw(renderer, p, map, pos, info);
		//font_draw(renderer, &font);
		mapchip_draw(renderer, map, chip);
		map_direct(renderer, map, pos, info, chip);
		player_draw(renderer, pos);
		SDL_RenderPresent(renderer);
	}

	sdl_finish(&window, &renderer, &font);

	return 0;
}
