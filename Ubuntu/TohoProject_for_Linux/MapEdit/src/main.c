/*
 * ワールドマップ、マップデータ作成プログラム
 *
 * Ubuntu LTS 20.04 kimura
 */


/*
 * インクルードファイル
 */
#include <SDL2/SDL.h>
#include <SDL2/SDL_events.h>
#include <SDL2/SDL_image.h>
#include <SDL2/SDL_ttf.h>
#include <stdio.h>
#include <stdlib.h>
#include "../include/MYLIB.H"



/* レンダリング方法を指定 */
#define RENDERER	(SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)


/*
 * SDL初期化関数
 */
static bool sdl_init(void);
static bool sdl_create(SDL_Window **window, SDL_Renderer **renderer);
static void sdl_finish(SDL_Window **window, SDL_Renderer **renderer, SDL_Texture **player_tx, SDL_Texture **npc_tx);


/*
 * SDLテクスチャーデータのロード
 */
static bool load_texture(SDL_Renderer *renderer, SDL_Texture **p, char *path);


/*
 * SDLキー入力操作
 */
static bool sdl_key_event(MapchipWork *chip);
static void sdl_key_ram_clear(void);


/*
 * SDL描画処理
 */
static void player_draw(SDL_Renderer *renderer, SDL_Texture **player_tx);
static void map_npc_draw(SDL_Renderer *renderer, SDL_Texture **map_tx, SDL_Texture **npc_tx, MapchipWork *chip);
static void mapchip_draw(SDL_Renderer *renderer, SDL_Texture *mapchip, MapchipWork *chip);



/*
 * sdlの初期化関数、main関数の最初に呼び出すこと
 */
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


	return true;
}

/*
 * 使用するフォントデータとレンダリングの設定
 *
 * window
 * 画面中央に指定サイズで描画する
 * 
 * renderer
 * GPUでグラフィック処理を行い、FPSを上げるよう設定
 */
static bool sdl_create(SDL_Window **window, SDL_Renderer **renderer)
{
	*window = SDL_CreateWindow( u8"Aki Sister RPG Game",
								450,
								450, 
								TOTAL_SCREEN_WIDTH,
								TOTAL_SCREEN_HEIGHT,
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

	return true;
}


/*
 * 指定したファイルパスのテクスチャー情報を読み込み、使用可能にする
 */
static bool load_texture(SDL_Renderer *renderer, SDL_Texture **p, char *path)
{
	SDL_Surface *image;

	image = IMG_Load(path);

	if (image == NULL) {
		fprintf(stderr, "Texture Load Error!: %s  File Path: %s\n", IMG_GetError(), path);
		return false;
	}

	terminal_str("使用するテクスチャーのパス", path);
	*p = SDL_CreateTextureFromSurface(renderer, image);
	SDL_FreeSurface(image);

	return true;
}


/*
 * テクスチャーの破棄、使用しないテクスチャー情報をクリアする
 */
static void map_texture_destroy(SDL_Texture **p)
{
	SDL_DestroyTexture(*p);
	*p = NULL;
}


/*
 * sdlの終了
 */
static void sdl_finish(SDL_Window **window, SDL_Renderer **renderer, SDL_Texture **player_tx, SDL_Texture **npc_tx)
{
	IMG_Quit();
	SDL_DestroyRenderer(*renderer);
	SDL_DestroyWindow(*window);
	SDL_DestroyTexture(*player_tx);
	
	renderer  = NULL;
	window    = NULL;
	player_tx = NULL;
	SDL_Quit();
	printf("SDL の初期化に成功しました\r\n");
}


/*
 * 操作キャラクターの描画
 *
 * arg1:レンダリング情報
 * arg2:座標データの構造体のアドレス
 *
 * SDL_Rect	res
 * arg1:画像データの切り抜きを開始する、x_Pixel数を指定
 * arg2:画像データの切り抜きを開始する、y_Pixel数を指定
 * arg3:x地点から切り抜きを終了する、x_Pixel数を指定
 * arg4:y地点から切り抜きを終了する、y_Pixel数を指定
 *
 * SDL_Rect draw
 * arg1:描画を開始する、x_positionを指定
 * arg2:描画を開始する、y_positionを指定
 * arg3:指定したポジションに、描画を行う幅を指定
 * arg4:指定したポジションに、描画を行う高さを指定
 *
 * SDL_RenderCopy
 * arg1: レンダリング情報を指定
 * arg2: 使用するテクスチャー情報を指定
 * arg3: 使用する画像データの情報を指定し、長方形を描画する
 * arg4: この引数に指定した、幅と高さに自動で拡大縮小する
 */
static void player_draw(SDL_Renderer *renderer, SDL_Texture **player_tx)
{
	SDL_Rect res  = (SDL_Rect){
		0,
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



/**
 * @brief  マップとNPCの描画
 * @note   
 * @param  *renderer: 
 * @param  **map_tx: マップのテクスチャーデータのアドレス
 * @param  **npc_tx: npcのテクスチャー情報のアドレス
 * @param  *chip: 
 * @retval None
 */
static void map_npc_draw(SDL_Renderer *renderer, SDL_Texture **map_tx, SDL_Texture **npc_tx, MapchipWork *chip)
{
	SDL_Rect map_res;
	SDL_Rect obj_res;
	SDL_Rect npc_res = (SDL_Rect){0, 0, NPC_WIDTH, NPC_HEIGHT};
	SDL_Rect map_draw;
	uint32_t cutx[2];
	uint32_t cuty[2];
	uint32_t x 		  = get_posinfo(FIELD_XPOS);
	uint32_t y 		  = get_posinfo(FIELD_YPOS);
	uint32_t maxwidth = chip->xsize;

	for (uint32_t i = 0; i < MAP_DRAW_HEIGHT; i++)
	{
		for (uint32_t j = 0; j < MAP_DRAW_WIDTH; j++)
		{
			/* 描画範囲内のフレームバッファのデータを取得 */
			uint32_t map_data = chip->fbuf_map[((i + y) * maxwidth) + j + x];
			uint32_t obj_data = chip->fbuf_obj[((i + y) * maxwidth) + j + x];
			uint32_t npc_data = chip->fbuf_npc[((i + y) * maxwidth) + j + x];

			/* 画像データの切り取り開始座標を計算 */
			cutx[0]	 = (map_data & ((chip->chip_xsize >> MAPCHIP_SHIFT) - 1)) * MAPCHIP_SIZE;
			cuty[0]	 = (map_data / (chip->chip_xsize >> MAPCHIP_SHIFT)) * MAPCHIP_SIZE;
			cutx[1]	 = (obj_data & ((chip->chip_xsize >> MAPCHIP_SHIFT) - 1)) * MAPCHIP_SIZE;
			cuty[1]	 = (obj_data / (chip->chip_xsize >> MAPCHIP_SHIFT)) * MAPCHIP_SIZE;

			/* レンダリング情報を保存 */
			map_res  = (SDL_Rect){cutx[0], cuty[0], MAPCHIP_SIZE, MAPCHIP_SIZE};
			obj_res  = (SDL_Rect){cutx[1], cuty[1], MAPCHIP_SIZE, MAPCHIP_SIZE};
			map_draw = (SDL_Rect){j << MAP_SIZE_SHIFT, i << MAP_SIZE_SHIFT, GRID_SIZE, GRID_SIZE};

			/* 描画開始 */
			SDL_RenderCopy(renderer, *map_tx, &map_res, &map_draw);

			if (npc_data != 0)
			{
				SDL_RenderCopy(renderer, *npc_tx, &npc_res, &map_draw);
			}

			if ((chip->obj_start <= obj_data) && (obj_data <= chip->obj_end)) {
				SDL_RenderCopy(renderer, *map_tx, &obj_res, &map_draw);
			}
		}
	}
}


/*
 * マップチップ選択画面描画
 * 縦横MAPCHIP_SIZEの大きさで描画、画像データの上に薄い黒の四角形を描画し選択カーソルを再現
 */
static void mapchip_draw(SDL_Renderer *renderer, SDL_Texture *mapchip, MapchipWork *chip)
{
	uint32_t cut_ypos	= (chip->chip_ypos * MAPCHIP_SIZE) / MAPCHIP_CUT_POS;
	uint32_t maxwidth   = chip->chip_xsize;
    uint32_t maxheight;

	if (chip->cutpos <= chip->chip_ypos)
	{
		maxheight = chip->chip_ysize - (chip->cutpos * MAPCHIP_SIZE);
	}
	else
	{
		maxheight = MAPCHIP_CUT_POS;
	}

	/* マップチップ選択画面描画 */
	SDL_Rect chip_draw  = (SDL_Rect){0, cut_ypos * MAPCHIP_CUT_POS, maxwidth, maxheight};
	SDL_Rect rend       = (SDL_Rect){SCREEN_WIDTH, 0, maxwidth, maxheight};
	SDL_RenderCopy(renderer, mapchip, &chip_draw, &rend);
	SDL_SetRenderDrawBlendMode(renderer, SDL_BLENDMODE_BLEND);

	/* 選択カーソル描画 */
	SDL_Rect back_black = (SDL_Rect){(chip->chip_xpos * MAPCHIP_SIZE) + SCREEN_WIDTH, ((chip->chip_ypos % 31) * MAPCHIP_SIZE), MAPCHIP_SIZE, MAPCHIP_SIZE};
	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 100);
	SDL_RenderFillRect(renderer, &back_black);
}


/**
 * @brief  マップ作成時のキーコンフィグ
 * @note   
 * @param  key: 
 * @retval None
 */
static void map_config_key(MapchipWork *chip, int32_t key)
{
	switch (key)
	{
	case SDLK_UP: ypos_move_up(); 		break;
	case SDLK_LEFT: xpos_move_left();		break;
	case SDLK_DOWN: ypos_move_down(chip);	break;
	case SDLK_RIGHT: xpos_move_right(chip); 	break;
	case SDLK_q:mapchip_rect_fill(chip, FILL_SQUARE, 'q');	break;
	case SDLK_e: mapchip_rect_fill(chip, FILL_LOT, 'q'); break;
	case SDLK_x: mapchip_rect_fill(chip, FILL_SQUARE, 'x'); break;
	case SDLK_c: mapchip_rect_fill(chip, FILL_LOT, 'x'); break;
	case SDLK_w: mapchip_pos_update(chip, CHIP_UP); break;
	case SDLK_d: mapchip_pos_update(chip, CHIP_RIGHT); break;
	case SDLK_s: mapchip_pos_update(chip, CHIP_DOWN); break;
	case SDLK_a: mapchip_pos_update(chip, CHIP_LEFT); break;
	case SDLK_r: mapchip_shortcut_fill(chip, 0); break;
	case SDLK_t: mapchip_shortcut_fill(chip, 1); break;
	case SDLK_y: mapchip_shortcut_fill(chip, 2); break;
	case SDLK_f: mapchip_shortcut_update(chip, 0); break;
	case SDLK_g: mapchip_shortcut_update(chip, 1); break;
	case SDLK_h: mapchip_shortcut_update(chip, 2); break;
	case SDLK_b: mapchip_rect_fill_zero(chip); break;
	case SDLK_v: mapchip_all_fill(chip, 'f'); break;
	case SDLK_o: mapf_read(chip); break;
	case SDLK_p: mapf_write(chip); break;
	case SDLK_z: fbuf_update(chip); break;
	case SDLK_1: chip->dirx_loop = 1; break;
	case SDLK_2: chip->dirx_loop = 2; break;
	case SDLK_3: chip->dirx_loop = 3; break;
	case SDLK_4: chip->dirx_loop = 4; break;
	case SDLK_5: chip->diry_loop = 1; break;
	case SDLK_6: chip->diry_loop = 2; break;
	case SDLK_7: chip->diry_loop = 3; break;
	case SDLK_8: chip->diry_loop = 4; break;
	case SDLK_m: chip->isEnd++; break;
	case SDLK_l: chip->map_mode = REGION_CONFIG; break;
	default: chip->isEnd = 0; break;
	}
}


/**
 * @brief  リージョンマップ作成時のキーコンフィグ
 * @note   
 * @param  key: SDLキー入力値を指定
 */
static void region_config_key(MapchipWork *chip, int32_t key)
{
	/*
	 *
	 * 何かのキーで桁数を選択できるようにして
	 * 数字キーで数値を配列に保存する形にする
	 * 
	 * 例えば2桁設定で、数字キーの１、０を押したら0を押した瞬間に勝手に保存されるようにする
	 */
	switch (key)
	{
	case SDLK_UP: ypos_move_up(); break;
	case SDLK_LEFT: xpos_move_left(); break;
	case SDLK_DOWN: ypos_move_down(chip); break;
	case SDLK_RIGHT: xpos_move_right(chip); break;
	case SDLK_q: region_write(chip); break;
	case SDLK_a: chip->region.digit[0] = 1; break;
	case SDLK_s: chip->region.digit[0] = 2; break;
	case SDLK_d: chip->region.digit[0] = 3; break;
	case SDLK_r: chip->dirx_loop = 1; break;
	case SDLK_t: chip->dirx_loop = 2; break;
	case SDLK_y: chip->dirx_loop = 3; break;
	case SDLK_u: chip->dirx_loop = 4; break;
	case SDLK_i: chip->diry_loop = 5; break;
	case SDLK_f: chip->diry_loop = 1; break;
	case SDLK_g: chip->diry_loop = 2; break;
	case SDLK_h: chip->diry_loop = 3; break;
	case SDLK_j: chip->diry_loop = 4; break;
	case SDLK_k: chip->diry_loop = 5; break;
	case SDLK_o: mapf_read(chip); break;
	case SDLK_p: mapf_write(chip); break;
	case SDLK_0: request_region_id(chip, 0, 0); break;
	case SDLK_1: request_region_id(chip, 1, 0); break;
	case SDLK_2: request_region_id(chip, 2, 0); break;
	case SDLK_3: request_region_id(chip, 3, 0); break;
	case SDLK_4: request_region_id(chip, 4, 0); break;
	case SDLK_5: request_region_id(chip, 5, 0); break;
	case SDLK_6: request_region_id(chip, 6, 0); break;
	case SDLK_7: request_region_id(chip, 7, 0); break;
	case SDLK_8: request_region_id(chip, 8, 0); break;
	case SDLK_9: request_region_id(chip, 9, 0); break;
	case SDLK_l: chip->map_mode = NPC_CONFIG; break;
	case SDLK_m: chip->isEnd++; break;
	default: chip->isEnd = 0; break;
	}
}


/**
 * @brief  NPCマップ作成時のキーコンフィグ
 * @note   npcとリージョンマップ作成用の数値選択メンバは共有とする
 * @param  key: SDLキー入力値を指定
 */
static void npc_config_key(MapchipWork *chip, int32_t key)
{
	/*
	 *
	 * 何かのキーで桁数を選択できるようにして
	 * 数字キーで数値を配列に保存する形にする
	 * 
	 * 例えば2桁設定で、数字キーの１、０を押したら0を押した瞬間に勝手に保存されるようにする
	 */
	switch (key)
	{
	case SDLK_UP: ypos_move_up(); break;
	case SDLK_LEFT: xpos_move_left(); break;
	case SDLK_DOWN: ypos_move_down(chip); break;
	case SDLK_RIGHT: xpos_move_right(chip); break;
	case SDLK_q: npc_write(chip); break;
	case SDLK_a: chip->region.digit[1] = 1; break;
	case SDLK_s: chip->region.digit[1] = 2; break;
	case SDLK_d: chip->region.digit[1] = 3; break;
	case SDLK_r: chip->dirx_loop = 1; break;
	case SDLK_t: chip->dirx_loop = 2; break;
	case SDLK_y: chip->dirx_loop = 3; break;
	case SDLK_u: chip->dirx_loop = 4; break;
	case SDLK_i: chip->diry_loop = 5; break;
	case SDLK_f: chip->diry_loop = 1; break;
	case SDLK_g: chip->diry_loop = 2; break;
	case SDLK_h: chip->diry_loop = 3; break;
	case SDLK_j: chip->diry_loop = 4; break;
	case SDLK_k: chip->diry_loop = 5; break;
	case SDLK_o: mapf_read(chip); break;
	case SDLK_p: mapf_write(chip); break;
	case SDLK_0: request_region_id(chip, 0, 1); break;
	case SDLK_1: request_region_id(chip, 1, 1); break;
	case SDLK_2: request_region_id(chip, 2, 1); break;
	case SDLK_3: request_region_id(chip, 3, 1); break;
	case SDLK_4: request_region_id(chip, 4, 1); break;
	case SDLK_5: request_region_id(chip, 5, 1); break;
	case SDLK_6: request_region_id(chip, 6, 1); break;
	case SDLK_7: request_region_id(chip, 7, 1); break;
	case SDLK_8: request_region_id(chip, 8, 1); break;
	case SDLK_9: request_region_id(chip, 9, 1); break;
	case SDLK_l: chip->map_mode = MAP_CONFIG; break;
	case SDLK_m: chip->isEnd++; break;
	default: chip->isEnd = 0; break;
	}
}


/**
 * @brief  キー入力とキーの操作方法を端末に表示する
 * @note   
 * @retval None
 */
static bool sdl_key_event(MapchipWork *chip)
{
	SDL_Event e;

	while (SDL_PollEvent(&e)) {
		if (e.type == SDL_QUIT) {
			return false;
		}

		if (e.type != SDL_KEYDOWN) {
			return false;
		}

		switch (chip->map_mode)
		{
		case MAP_CONFIG:
			map_config_key(chip, e.key.keysym.sym);
			break;

		case REGION_CONFIG:
			region_config_key(chip, e.key.keysym.sym);
			break;

		case NPC_CONFIG:
			npc_config_key(chip, e.key.keysym.sym);
			break;

		default:
			break;
		}

		map_direct(chip);

		if (e.key.keysym.sym != SDLK_p)
		{
			terminal_info(chip);
		}

	}

	return true;
}


/**----------------------------------------------------------
 * 前回のプログラム実行のデータを削除するため、キー入力待機
 *---------------------------------------------------------*/
static void sdl_key_ram_clear(void)
{
	SDL_Event e;

	printf("<- 左キーを押してください、押すとスタートです\r\n");

	while (1) {
		SDL_PollEvent(&e);
		if (e.key.keysym.sym == SDLK_LEFT)
		{
			break;
		}
	}
}



/*
 * メイン関数
 *
 * SDLは同一スレッド内で扱わなければならない
 * SDLのレンダリング関数群は背面バッファを操作するため直接画面には描画されない
 * よって、描画を行うためにはフレームに描画情報を全て保存し、RenderPresent関数で
 * 一気に描画を行う必要がある
 */
int main(int argc, char *argv[])
{
	SDL_Window   *window;
	SDL_Renderer *renderer;
	SDL_Texture  *map_tx;
	SDL_Texture  *player_tx;
	SDL_Texture  *npc_tx;
	MapchipWork  chip;

    /* マップチップデータ操作構造体の設定 */
    if (false == mapchip_init(&chip, argv[1]))
    {
        return 1;
    }

	/* SDLの初期設定 */
	if (false == sdl_init()) {
		return 1;
	}

	if (false == sdl_create(&window, &renderer)) {
		sdl_finish(&window, &renderer, &player_tx, &npc_tx);
		return 1;
	}

	/* 使用するキャラクター画像データの読み込み */
	if (false == load_texture(renderer, &player_tx, "./res/akisys.png")) {
		return 1;
	}

	/* NPC配置用の画像データ読み込み */
	if (false == load_texture(renderer, &npc_tx, "./res/npc.png")) {
		return 1;
	}

	/* マップ作成に使用する画像データの読み込み */
	if (false == load_texture(renderer, &map_tx, chip.mapfile))
	{
		return 1;
	}

    /* 背景を黒で塗りつぶし */
	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);

    /* デバッグ用端末の初期設定 */
	sdl_key_ram_clear();
	SET_PLACE(0, 0);

	while (1)
	{
		sdl_key_event(&chip);
		SDL_RenderClear(renderer);	//チラつきを防ぐため背面バッファを毎回クリアする
		map_npc_draw(renderer, &map_tx, &npc_tx, &chip);
		mapchip_draw(renderer, map_tx, &chip);
		player_draw(renderer, &player_tx);
		SDL_RenderPresent(renderer);

		if (chip.isEnd == 5)
		{
			break;
		}
	}
	
	map_texture_destroy(&map_tx);
	sdl_finish(&window, &renderer, &player_tx, &npc_tx);
	printf("プログラムを終了します\r\n");

	return 0;
}
