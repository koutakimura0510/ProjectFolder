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
static uint32_t map40_30[40*30]	 = {0};
static uint32_t map80_60[80*60]	 = {0};
static uint32_t map120_90[120*90] = {0};
static uint32_t map160_120[160*120] = {0};
static uint32_t map320_240[320*240] = {0};


/**-------------------------------------------------
 * マップチップ用変数
 * -------------------------------------------------*/
static uint8_t mapchip_flag = 0;
static uint32_t mapchip_direct = 0;
static uint32_t ychip = 0;
static uint32_t xchip = 0;


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
	int32_t field_maxwidth;		//現在フィールドの最大横幅指定
	int32_t field_maxheight;	//現在フィールドの最大高さ指定
} t_fieldinfo;


typedef struct {
	uint8_t id;
	uint32_t *map;
} t_fieldmap;

static const t_fieldmap fieldmap[] = {
	{ 0, map40_30	},
	{ 0, map80_60	},
	{ 0, map120_90	},
	{ 0, map160_120	},
	{ 0, map320_240	},
};



/**-------------------------------------------------
 * 構造体の確保
 * -------------------------------------------------*/
static t_posinfo posinfo = {0, 0, 0, 0, 0, 0, 0};
static t_fieldinfo fieldinfo = {MAP_DRAW_WIDTH, MAP_DRAW_HEIGHT};


/**-------------------------------------------------
 * SDL関数群
 * -------------------------------------------------*/
static bool sdl_init(void);
static bool sdl_create(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font);
static void sdl_finish(SDL_Window **window, SDL_Renderer **renderer, TTF_Font **font);
static bool load_texture(const char *path, SDL_Texture **p, SDL_Renderer *renderer);
static bool load_ttf_msg(const char *msg, SDL_Texture **tx, TTF_Font **p, SDL_Renderer *renderer);
static bool player_draw(SDL_Renderer *renderer, t_posinfo *pos);
static bool map_draw(SDL_Renderer *renderer, t_fieldinfo *info, const t_mapid *p, const t_mapinfo *map);
static bool font_draw(SDL_Renderer *renderer, TTF_Font **font);
static bool mapchip_draw(SDL_Renderer *renderer, const t_mapid *p, const t_mapinfo *map);
static bool map_direct(SDL_Renderer *renderer, const t_mapid *p, const t_mapinfo *map, t_fieldinfo *info, t_posinfo *pos);



/**-------------------------------------------------
 * キー操作
 * -------------------------------------------------*/
static bool key_event(t_fieldinfo *info, t_posinfo *p);


/**-------------------------------------------------
 * 座標計算
 * -------------------------------------------------*/
static void xpos_move_right(t_fieldinfo *info, t_posinfo *p);
static void xpos_move_left(t_posinfo *p);
static void ypos_move_up(t_posinfo *p);
static void ypos_move_down(t_fieldinfo *info, t_posinfo *p);
static void direct(t_fieldinfo *info, t_posinfo *p);


/**-------------------------------------------------
 * フレームバッファ操作
 * -------------------------------------------------*/
static uint32_t *get_framebuffer_address(uint8_t id);
static char **get_mapchip_path(const t_mapid *p);


/**-------------------------------------------------
 * ファイル操作
 * -------------------------------------------------*/
void mapf_write(void);
void mapf_read(void);



/**-------------------------------------------------
 * フレームバッファの先頭アドレス取得
 * -------------------------------------------------*/
static uint32_t *get_framebuffer_address(uint8_t id)
{
	const t_fieldmap *p = fieldmap;

	p = p + id;

	return &p->map[0];
}


/**-------------------------------------------------
 * mapchipのpassを取得
 * -------------------------------------------------*/
static char **get_mapchip_path(const t_mapid *p)
{
	return (char **)p->path[p->select];
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
static bool map_draw(SDL_Renderer *renderer, t_fieldinfo *info, const t_mapid *p, const t_mapinfo *map)
{
	const t_mapid *oldp = p;
	SDL_Texture *map_tx;
	SDL_Rect map_res;
	SDL_Rect map_draw;
	uint32_t x, y, i, j, d;
	uint32_t *ptr;	//frame buffer先頭アドレス取得用ポインタ
	char **path;


	ptr = get_framebuffer_address(0);
	x = info->field_maxwidth;
	y = info->field_maxheight;

	for (i = 0; i < y; i++) {
		for (j = 0; j < x; j++) {
			d = ptr[(i * x)+j];
			p = p + d;
			path = get_mapchip_path(p);
			load_texture((char *)path, &map_tx, renderer);
			map_res  = (SDL_Rect){p->xpos, p->ypos, map->xpixel, map->ypixel};
			map_draw = (SDL_Rect){j << MAP_SIZE_SHIFT, i << MAP_SIZE_SHIFT, GRID_SIZE, GRID_SIZE};
			SDL_RenderCopy(renderer, map_tx, &map_res, &map_draw);
			p = oldp;	//アドレスのポインタを初期値に戻す
		}
	}

	SDL_DestroyTexture(map_tx);
	map_tx = NULL;

	return true;
}


/**-------------------------------------------------
 * マップチップ選択画面描画
 * -------------------------------------------------*/
static bool mapchip_draw(SDL_Renderer *renderer, const t_mapid *p, const t_mapinfo *map)
{
	SDL_Texture *mapchip;
	char **path;
	uint32_t maxwidth = map->maxwidth;
	uint32_t xpixel   = map->xpixel;
	uint32_t ypixel   = map->ypixel;

	if (mapchip_flag == 0) {
		return false;
	}

	p = p + (xchip + (ychip * (maxwidth / xpixel)));
	path = get_mapchip_path(p);

	if (false == load_texture((char *)path, &mapchip, renderer)) {
		return false;
	}

	SDL_Rect chip_draw = (SDL_Rect){0, ychip*ypixel, maxwidth, ypixel};	//マップチップを描画
	SDL_Rect rend  = (SDL_Rect){0, 0, MAPCHIP_SIZE, MAPCHIP_SIZE};		//描画座標とマップチップ大きさ指定
	SDL_RenderCopy(renderer, mapchip, &chip_draw, &rend);

	SDL_SetRenderDrawBlendMode(renderer, SDL_BLENDMODE_BLEND);
	SDL_Rect back_black = (SDL_Rect){xchip*MAPCHIP_SIZE, 0, MAPCHIP_SIZE, MAPCHIP_SIZE};
	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 100);
	SDL_RenderFillRect(renderer, &back_black);

	SDL_DestroyTexture(mapchip);
	mapchip = NULL;

	return true;
}


/**-------------------------------------------------
 * マップチップを置く
 * -------------------------------------------------*/
static bool map_direct(SDL_Renderer *renderer, const t_mapid *p, const t_mapinfo *map, t_fieldinfo *info, t_posinfo *pos)
{
	SDL_Texture *mapchip;
	uint32_t uxpos = pos->unit_xpos;
	uint32_t uypos = pos->unit_ypos;
	uint32_t d;
	char **path;
	uint32_t *ptr;

	if (mapchip_direct == 0) {
		return false;
	}

	d = (xchip + (ychip * (map->maxwidth / map->xpixel)));
	p = p + d;
	path = get_mapchip_path(p);

	if (false == load_texture((char *)path, &mapchip, renderer)) {
		return false;
	}

	SDL_Rect chip_draw = (SDL_Rect){xchip*map->xpixel, ychip*map->ypixel, GRID_SIZE, GRID_SIZE};
	SDL_Rect draw = (SDL_Rect){uxpos << UNIT_SHIFT, uypos << UNIT_SHIFT, GRID_SIZE, GRID_SIZE};
	SDL_RenderCopy(renderer, mapchip, &chip_draw, &draw);

	SDL_DestroyTexture(mapchip);
	mapchip = NULL;
	mapchip_direct = 0;
	ptr = get_framebuffer_address(0);
	ptr[uxpos + (uypos*info->field_maxheight)] = d;

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

			case SDLK_p:	//マップチップを配置
				mapchip_direct = 1;
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
				mapchip_flag = 0;
				return true;

			case SDLK_e:	//マップチップ選択
				mapchip_flag = 1;
				xchip++;
				xchip &= 7;	//マップデータによって変化	
				return true;

			case SDLK_r:	//マップチップ次の選択
				ychip++;
				if (ychip <= 11) {	//mapdata change
					ychip = 0;
				}
				return true;

			case SDLK_t:	//次のマップチップ画像データ読み込み
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
	const t_mapid *p  = mapid;
	const t_mapinfo *map = mapinfo;

	if (false == sdl_init()) {
		return 1;
	}

	if (false == sdl_create(&window, &renderer, &font)) {
		sdl_finish(&window, &renderer, &font);
		return 1;
	}

	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);	//r, g, b, a ウィンドウを黒に設定

	while (1) {
		if (false == key_event(info, pos)) {
			break;
		}

		direct(info, pos);
		SDL_RenderClear(renderer);
		map_draw(renderer, info, p, map);
		//font_draw(renderer, &font);
		mapchip_draw(renderer, p, map);
		map_direct(renderer, p, map, info, pos);
		player_draw(renderer, pos);
		SDL_RenderPresent(renderer);
	}

	sdl_finish(&window, &renderer, &font);

	return 0;
}
