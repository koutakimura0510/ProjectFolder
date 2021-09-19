/*
 * マップの描画に関する関数を管理するファイル
 */

#include "../../wrapper/game_wrapper.h"
#include "draw_struct.h"


/*
 * ファイル内関数
 */
static void map_share_data(GameWrapper *const game, MapElement *map);
static void map_another_data(GameWrapper *const game, MapElement *map, uint8_t draw_type);
static void left_edge_draw(GameWrapper *const game, MapElement *map, uint32_t xsize);
static void right_edge_draw(GameWrapper *const game, MapElement *map, SDL_Rect *const rect);
static void xcenter_draw(GameWrapper *const game, MapElement *map);
static void under_edge_draw(GameWrapper *const game, MapElement *map, uint32_t yindex, uint32_t ysize);
static void top_edge_draw(GameWrapper *const game, MapElement *map, SDL_Rect *const rect);
static void ycenter_draw(GameWrapper *const game, MapElement *map, uint32_t xsize, uint32_t anime_pos);
static void display_darkening_draw(GameWrapper *const game, uint8_t vdma_pos);
static void display_gradually_draw(GameWrapper *const game, uint8_t vdma_pos);


/*
 * ver1. 2021/06/17
 * ディスプレイの基本描画関数を管理
 * 現在のシステムの状態に応じて描画方法を選択する
 * -
 * 基本描画の順番
 * 1. 遠景の描画
 * 1. 背景マップの描画
 * 2. キャラクター・NPCの描画
 * 3. オブジェクトの描画
 */
void standerd_game(GameWrapper *const game)
{
	const DisplayState *display = display_state;

	for (uint8_t i = 0; i < DISPLAY_FUNC_DB_SIZE; i++, display++)
	{
		if (game->conf.display.drawtype == display->drawtype)
		{
			display->display_func(game);
			break;
		}
	}
}



/*
 * ver1. 2021/03/6
 * VDMAの作業エリアのアドレスを更新
 *
 * 0 :フレームバッファ領域1で作業
 * 1 :フレームバッファ領域2で作業
 * 2 :フレームバッファ領域3で作業
 */
void workarea_update(GameWrapper *const game, uint32_t draw_pos)
{
	game->conf.work.adr = (DRAM_VDMA_ADDR_BASE + (FBUF_SIZE * draw_pos));
}


/*
 * ver1. 2021/06/27
 * 背景を描画
 */

/**
 * @brief  背景の描画を行う
 * @note   
 * @param  srcin: DDRメモリの書き込み開始アドレスを指定
 * @retval None
 */
void background_draw(GameWrapper *const game, uint32_t srcin)
{
    game->mapchip.srcin		 = srcin;
    game->mapchip.maxwidth	 = VIDEO_WIDTH;
    game->mapchip.maxheight	 = VIDEO_HEIGHT;
    game->mapchip.draw_xsize = VIDEO_WIDTH;
    game->mapchip.draw_ysize = VIDEO_HEIGHT;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = COLOR_ALPHA_MAX;
    game->mapchip.id         = 0;
    game->mapchip.dstin      = game->conf.work.adr;
    game->mapchip.dstout	 = game->conf.work.adr;
	game->mapchip.cut_color	 = COLOR_WHITE;
	put_mapchip(game);
    // png_mapchip(game);
}


/*
 * ver1. 2021/08/18
 * 現在の描画中の画面にカラーパレットの色を重ね合わせる
 */
void image_addition(GameWrapper *const game, uint8_t alpha)
{
    game->mapchip.srcin      = game->conf.work.adr;
    game->mapchip.dstin      = DRAM_COLOR_PALLET_ADDR_BASE;
    game->mapchip.dstout     = game->conf.work.adr;
    game->mapchip.maxwidth	 = VIDEO_WIDTH;
    game->mapchip.maxheight	 = VIDEO_HEIGHT;
    game->mapchip.draw_xsize = VIDEO_WIDTH;
    game->mapchip.draw_ysize = VIDEO_HEIGHT;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.id         = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha      = alpha;
	game->mapchip.cut_color	 = COLOR_NULL;
	put_mapchip(game);
    // png_mapchip(game);
}


/*
 * ver1. 2021/03/7
 * フレームバッファ領域を黒で塗りつぶし
 */
void frame_buffer_clear(void)
{
	for (uint8_t i = 0; i < FBUF_NUM; i++)
	{
		while (true != hvsync_state());
		patblt(FBUF_ADDR_1 + (FBUF_ADDR_1 * (uint32_t)i), 0, 0, VIDEO_WIDTH, VIDEO_HEIGHT, COLOR_BLACK);
	}
}


/*
 * ver1. 2021/06/10
 * 現在のフレームバッファ領域のデータを他のフレームバッファ領域にコピー
 */
void frame_buffer_other_copy(GameWrapper *const game)
{
	uint32_t fbuf_other[2];

	switch (game->conf.work.adr)
	{
	case FBUF_ADDR_1:
		fbuf_other[0] = FBUF_ADDR_2;
		fbuf_other[1] = FBUF_ADDR_3;
		break;

	case FBUF_ADDR_2:
		fbuf_other[0] = FBUF_ADDR_1;
		fbuf_other[1] = FBUF_ADDR_3;
		break;

	case FBUF_ADDR_3:
		fbuf_other[0] = FBUF_ADDR_1;
		fbuf_other[1] = FBUF_ADDR_2;
		break;
	}

	for (uint8_t i = 0; i < NUM(fbuf_other); i++)
	{
		while (true != hvsync_state());
		framebuffer_copy(game->conf.work.adr, fbuf_other[i], VIDEO_WIDTH, VIDEO_HEIGHT, VIDEO_WIDTH);
	}

	framebuffer_copy(game->conf.work.adr, DRAM_BACKUP_FBUF_ADDR_BASE, VIDEO_WIDTH, VIDEO_HEIGHT, VIDEO_WIDTH);
}


/*
 * ver1. 2021/06/19
 * マップ移動時に現在のバッファのアドレスに描画データを書き込み
 */
void nextdraw_ready(GameWrapper *const game)
{
    MapElement map;

    map_share_data(game, &map);
    map_another_data(game, &map, DRAW_TYPE_MAP);
    map_center_draw(game, &map);
    player_draw(game);
    map_another_data(game, &map, DRAW_TYPE_OBJ);
    map_center_draw(game, &map);
}

/*
 * ver1. 201/8/21
 * 指定された描画の方法に応じてマップの中央、上下左右のマップ描画関数の処理を行う
 * 共有する描画に必要なマップデータの初期設定を行い、下記の順番で描画を行う
 * 
 * 背景の描画
 * キャラクターの描画
 * オブジェクトの描画
 */
static void map_draw(GameWrapper *const game)
{
    const MapState *state = map_state;
    MapElement map;

	for (uint8_t i = 0; i < MAP_STATE_FUNC_DB_SIZE; i++, state++)
	{
		if (game->conf.display.drawtype == state->drawtype)
		{
            map_share_data(game, &map);
            map_another_data(game, &map, DRAW_TYPE_MAP);
			state->map_window(game, &map);
            player_draw(game);
            map_another_data(game, &map, DRAW_TYPE_OBJ);
			state->map_window(game, &map);
			break;
		}
	}
}


/*
 * ver1. 2021/08/21
 * 背景とオブジェクトの描画で共有するデータの初期設定
 */
static void map_share_data(GameWrapper *const game, MapElement *map)
{
    map->xsize = get_mapsize('w');
    map->field  = CHIP_LEFT(game->unit.pos.fieldx) + (CHIP_LEFT(game->unit.pos.fieldy) * map->xsize);

    switch (game->conf.display.drawtype)
    {
    case DISPLAY_FIELD_RIGHT_DRAW:
        map->center = XRGB((MAPCHIP_WIDTH - game->unit.pos.anime_cnt));
        break;

    case DISPLAY_FIELD_LEFT_DRAW:
        map->center = XRGB(game->unit.pos.anime_cnt);
        break;

    case DISPLAY_FIELD_UP_DRAW:
        map->field  = CHIP_LEFT(game->unit.pos.fieldx) + (CHIP_LEFT((game->unit.pos.fieldy + MAPCHIP_HEIGHT)) * map->xsize);
        map->center = YRGB(game->unit.pos.anime_cnt);
        break;

    case DISPLAY_FIELD_DOWN_DRAW:
        map->center = YRGB((MAPCHIP_HEIGHT - game->unit.pos.anime_cnt));
        break;

    default:
        break;
    }
}


/*
 * ver1. 2021/08/19
 * マップ描画時の基本データの保存
 * バックグラウンドとオブジェクトでマップデータの保存アドレスが異なるため
 * 状態変数を取得して配列のアドレスを保存するようにした
 */
static void map_another_data(GameWrapper *const game, MapElement *map, uint8_t draw_type)
{
    map->obj_start           = (draw_type == DRAW_TYPE_MAP) ? 0 : game->conf.map.obj_startid;
    map->obj_end             = (draw_type == DRAW_TYPE_MAP) ? 0xffffffff : game->conf.map.obj_endid;
    map->buffer              = (draw_type == DRAW_TYPE_MAP) ? game->conf.map.back : game->conf.map.obj;

    if (game->conf.display.system == SYSTEM_MINIGAME_WINDOW)
    {
        game->mapchip.srcin  = DRAM_MINIGAME_FRAME_ADDR_BASE;
    }
    else
    {
        game->mapchip.srcin  = DRAM_MAPCHIP_MAPDATA_ADDR_BASE;
    }
    game->mapchip.maxwidth	 = MAPCHIP_WIDTH;
	game->mapchip.maxheight  = MAPCHIP_HEIGHT;
	game->mapchip.frame_size = VIDEO_WIDTH;
	game->mapchip.alpha		 = COLOR_ALPHA_MAX;
	game->mapchip.draw_xsize = MAPCHIP_WIDTH;
    game->mapchip.draw_ysize = MAPCHIP_HEIGHT;
    game->mapchip.cut_color  = COLOR_WHITE;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
}


/*
 * ver2. 2021/08/19
 * バックグラウンドとオブジェクトの描画を結合した、見通しが良くなった
 * 
 * ver1. 2021/06/20
 * オブジェクト領域の描画
 */
static void map_center_draw(GameWrapper *const game, MapElement *map)
{
	for (uint32_t y = 0; y < MAPCHIP_DRAW_MAX_HEIGHT; y++)
	{
        map->index    = (y * map->xsize) + map->field;
        map->draw_adr = (CHIP_RGB(y) * VIDEO_WIDTH) + game->conf.work.adr;

        for (uint32_t x = 0; x < MAPCHIP_DRAW_MAX_WIDTH; x++)
        {
            game->mapchip.id = map->buffer[x + map->index];

            if (game->mapchip.id == 0)
            {
                continue;
            }

            if ((map->obj_start <= game->mapchip.id) && (game->mapchip.id <= map->obj_end))
            {
                game->mapchip.dstin  = CHIP_RGB(x) + map->draw_adr;
                game->mapchip.dstout = game->mapchip.dstin;
                // png_mapchip(game);
                put_mapchip(game);
            }
        }
	}
}


/*
 * ver2. 2021/08/19
 * バックグラウンドとオブジェクトの描画を結合
 * 
 * ver1. 2021/06/20
 * 右移動時のオブジェクト描画
 */
static void map_right_draw(GameWrapper *const game, MapElement *map)
{
    SDL_Rect rect;

    for (uint32_t i = 0; i < MAPCHIP_DRAW_MAX_HEIGHT; i++)
    {
        rect.x = game->unit.pos.anime_cnt;
        rect.w = MAPCHIP_WIDTH - game->unit.pos.anime_cnt;
        rect.y = i;
        right_edge_draw(game, map, &rect);
        left_edge_draw(game, map, game->unit.pos.anime_cnt << 1);
        xcenter_draw(game, map);
    }
}


/*
 * ver2. 2021/08/19
 * バックグラウンドとオブジェクトの描画を結合
 * 
 * ver1. 2021/06/20
 * 左移動時のオブジェクト描画
 */
static void map_left_draw(GameWrapper *const game, MapElement *map)
{
    SDL_Rect rect;

    for (uint32_t i = 0; i < MAPCHIP_DRAW_MAX_HEIGHT; i++)
    {
        rect.x = MAPCHIP_WIDTH - game->unit.pos.anime_cnt;
        rect.w = game->unit.pos.anime_cnt;
        rect.y = i;
        right_edge_draw(game, map, &rect);
        left_edge_draw(game, map, MAPCHIP_WIDTH);
        xcenter_draw(game, map);
    }
}


/*
 * ver2. 2021/08/19
 * バックグラウンドとオブジェクトの描画を結合
 * 上端の描画関数を作成し、上アニメーションと下アニメーション時の処理を結合した
 * 
 * ver1. 2021/06/20
 * 上移動時のオブジェクト描画
 */
static void map_up_draw(GameWrapper *const game, MapElement *map)
{
    SDL_Rect rect;

	for (uint32_t i = 0; i < MAPCHIP_DRAW_MAX_WIDTH; i++)
    {
        rect.x = map->xsize;
        rect.w = i;
        rect.y = MAPCHIP_HEIGHT - game->unit.pos.anime_cnt;
        rect.h = game->unit.pos.anime_cnt;
        top_edge_draw(game, map, &rect);
        under_edge_draw(game, map, MAPCHIP_DRAW_MAX_HEIGHT_ANIMATION, MAPCHIP_HEIGHT);
        ycenter_draw(game, map, 0, START_UP_ANIMATION_POS);
    }
}


/*
 * ver2. 2021/08/19
 * バックグラウンドとオブジェクトの描画を結合
 * 上端の描画関数を作成し、上アニメーションと下アニメーション時の処理を結合した
 * 
 * ver1. 2021/06/20
 * 下移動時のオブジェクト描画
 */
static void map_down_draw(GameWrapper *const game, MapElement *map)
{
    SDL_Rect rect;

    for (uint32_t i = 0; i < MAPCHIP_DRAW_MAX_WIDTH; i++)
    {
        rect.x = 0;
        rect.w = i;
        rect.y = game->unit.pos.anime_cnt;
        rect.h = MAPCHIP_HEIGHT - game->unit.pos.anime_cnt;
        top_edge_draw(game, map, &rect);
        under_edge_draw(game, map, MAPCHIP_DRAW_MAX_HEIGHT, game->unit.pos.anime_cnt << 1);
        ycenter_draw(game, map, map->xsize, START_DOWN_ANIMATION_POS);
    }
}


/*
 * ver1. 2021/08/19
 * 左右アニメーション時の左端の描画処理
 * 
 * xsize    :右移動時、game->unit.pos.anime_cnt << 1を指定
 *          :左移動時、MAPCHIP_WIDTHを指定
 */
static void left_edge_draw(GameWrapper *const game, MapElement *map, uint32_t xsize)
{
    game->mapchip.id         = map->buffer[map->index + MAPCHIP_DRAW_MAX_WIDTH];
    game->mapchip.xstart_pos = 0;

    if (game->mapchip.id == 0)
    {
        return;
    }

    if ((map->obj_start <= game->mapchip.id) && (game->mapchip.id <= map->obj_end))
    {
        game->mapchip.draw_xsize = xsize - game->unit.pos.anime_cnt;
        game->mapchip.dstin      = map->draw_adr + XRGB((VIDEO_WIDTH - xsize + game->unit.pos.anime_cnt));
        game->mapchip.dstout     = game->mapchip.dstin;
        put_mapchip(game);
    }
}


/*
 * ver1. 2021/08/19
 * 左右アニメーション時の右端の描画処理
 */
static void right_edge_draw(GameWrapper *const game, MapElement *map, SDL_Rect *const rect)
{
    map->draw_adr = (rect->y * START_LEFT_ANIMATION_POS) + game->conf.work.adr;
    map->index  = (rect->y * map->xsize) + map->field;
    game->mapchip.id = map->buffer[map->index];

    if ((map->obj_start <= game->mapchip.id) && (game->mapchip.id <= map->obj_end))
    {
        game->mapchip.xstart_pos = rect->x;
        game->mapchip.draw_xsize = rect->w;
        game->mapchip.dstin      = map->draw_adr;
        game->mapchip.dstout     = map->draw_adr;
        // png_mapchip(game);
        put_mapchip(game);
    }
}


/*
 * ver1. 2021/08/19
 * 左右アニメーション時の左端の次のマップ位置からの描画処理
 */
static void xcenter_draw(GameWrapper *const game, MapElement *map)
{
    game->mapchip.draw_xsize = MAPCHIP_WIDTH;

    for (uint32_t j = 0; j < MAPCHIP_DRAW_MAX_WIDTH_ANIMATION; j++)
    {
        game->mapchip.id = map->buffer[map->index + j + 1];

        if (game->mapchip.id == 0)
        {
            continue;
        }
        
        if ((map->obj_start <= game->mapchip.id) && (game->mapchip.id <= map->obj_end))
        {
            game->mapchip.dstin  = map->draw_adr + map->center + CHIP_RGB(j);
            game->mapchip.dstout = game->mapchip.dstin;
            // png_mapchip(game);
            put_mapchip(game);
        }
    }
}


/*
 * ver1. 2021/08/19
 * 上下マップ移動時の上端の描画を行う処理
 */
static void top_edge_draw(GameWrapper *const game, MapElement *map, SDL_Rect *const rect)
{
    map->draw_adr    = CHIP_RGB(rect->w) + game->conf.work.adr;
    map->index       = rect->w + map->field;
    game->mapchip.id = map->buffer[map->index - rect->x];

    if (game->mapchip.id == 0)
    {
        return;
    }

    if ((map->obj_start <= game->mapchip.id) && (game->mapchip.id <= map->obj_end))
    {
        game->mapchip.ystart_pos = rect->y;
        game->mapchip.draw_ysize = rect->h;
        game->mapchip.dstin      = map->draw_adr;
        game->mapchip.dstout     = game->mapchip.dstin;
        // png_mapchip(game);
        put_mapchip(game);
    }
}


/*
 * ver1. 2021/08/19
 * 上下マップ移動時の下端の描画を行う処理
 * 
 * yindex   :下アニメーション時はMAPCHIP_DRAW_MAX_HEIGHTを指定
 *          :上アニメーション時はMAPCHIP_DRAW_MAX_HEIGHT_ANIMATIONを指定
 * 
 * ysize    :下アニメーション時はgame->unit.pos.anime_cntを2倍した値を指定
 *          :上アニメーション時はMAPCHIP_HEIGHTを指定
 */
static void under_edge_draw(GameWrapper *const game, MapElement *map, uint32_t yindex, uint32_t ysize)
{
    game->mapchip.id         = map->buffer[map->index + (map->xsize * yindex)];
    game->mapchip.ystart_pos = 0;

    if (game->mapchip.id == 0)
    {
        return;
    }

    if ((map->obj_start <= game->mapchip.id) && (game->mapchip.id <= map->obj_end))
    {
        game->mapchip.draw_ysize = ysize - game->unit.pos.anime_cnt;
        game->mapchip.dstin      = map->draw_adr + YRGB((VIDEO_HEIGHT - ysize + game->unit.pos.anime_cnt));
        game->mapchip.dstout     = game->mapchip.dstin;
        // png_mapchip(game);
        put_mapchip(game);
    }
}


/*
 * ver1. 2021/08/19
 * 上下マップ移動時の上端分の次のマップ位置から描画を行う処理
 * 
 * xsize    :上アニメーション時は0を指定
 *          :下アニメーション時はマップの横幅を指定
 * 
 * anime_pos:上アニメーション時はSTART_UP_ANIMATION_POSを指定
 *          :下アニメーション時はSTART_DOWN_ANIMATION_POSを指定
 */
static void ycenter_draw(GameWrapper *const game, MapElement *map, uint32_t xsize, uint32_t anime_pos)
{
    game->mapchip.draw_ysize = MAPCHIP_WIDTH;

    for (uint32_t j = 0; j < MAPCHIP_DRAW_MAX_HEIGHT_ANIMATION; j++)
    {
        game->mapchip.id = map->buffer[map->index + xsize + (j * map->xsize)];

        if (game->mapchip.id == 0)
        {
            continue;
        }

        if ((map->obj_start <= game->mapchip.id) && (game->mapchip.id <= map->obj_end))
        {
            game->mapchip.dstin  = map->draw_adr + map->center + (j * anime_pos);
            game->mapchip.dstout = game->mapchip.dstin;
            // png_mapchip(game);
            put_mapchip(game);
        }
    }
}


/*
 * ver1. 2021/06/10
 *
 * バックアップ領域のデータを暗転表示させながらフレームバッファ領域にコピー
 * 指定モードでマップ間移動のアニメーションを行う
 * アニメーション完了後、現在のフレームバッファのチャンネルデータを他のフレームバッファ領域にコピーする
 * (VDMAチャンネル切り替え時に映像が乱れないようにするため)
 * -
 * 暗転速度計算
 * 1フレームごとにalpha値を変更させたデータで描画を行う
 * COLOR_ALPHA_NUMがalpha値の変化量である
 * 
 * 例
 * MAX 255 / 変化量 15 = 17
 * 変化量15の場合、最低で描画完了に17フレームかかる
 */
static void frame_buffer_darkening_copy(GameWrapper *const game)
{
    uint8_t vdma_pos = (game->conf.work.adr - DRAM_VDMA_ADDR_BASE) / FBUF_SIZE; 
	patblt(DRAM_COLOR_PALLET_ADDR_BASE, 0, 0, VIDEO_WIDTH, VIDEO_HEIGHT, COLOR_BLACK);

	switch (game->conf.display.drawtype)
	{
	case DISPLAY_DARKENING_DRAW:
        display_darkening_draw(game, vdma_pos);
		break;

	case DISPLAY_GRADUALLY_DRAW:
        display_gradually_draw(game, vdma_pos);
		break;

	default:
		break;
	}

	frame_buffer_other_copy(game);
}

/*
 * ver1. 2021/06/10
 * 描画切替動作のため次に描画を行うデータをバックアップ領域にコピー
 * 現在のフレームバッファ領域のアドレスを一時保存しておき、バックアップ用のアドレスに切り替える
 * バックアップ領域に次回描画予定のデータを書き込む
 * 一時保存していたフレームバッファのアドレスに切り替える
 */
static void frame_buffer_nextdraw_ready(GameWrapper *const game)
{
	uint32_t backup = game->conf.work.adr;

	game->conf.work.adr = DRAM_BACKUP_FBUF_ADDR_BASE;
	nextdraw_ready(game);
	game->conf.work.adr = backup;
}



/*
 * ver1. 2021/06/19
 * 画面の暗転描画処理を管理
 * 現在のアドレスに描画データを保存後、そのデータを他のバッファ領域にコピー
 * VDMAのチャンネルを現在のアドレスに切り替えて、カラーパレットと合成した色を徐々に描画する
 */
static void display_darkening_draw(GameWrapper *const game, uint8_t vdma_pos)
{
    nextdraw_ready(game);
    frame_buffer_other_copy(game);
    game->mapchip.srcin 	 = game->conf.work.adr;
    game->mapchip.dstin 	 = DRAM_COLOR_PALLET_ADDR_BASE;
    game->mapchip.dstout     = game->conf.work.adr;
    game->mapchip.maxwidth	 = VIDEO_WIDTH;
    game->mapchip.maxheight	 = VIDEO_HEIGHT;
    game->mapchip.draw_xsize = VIDEO_WIDTH;
    game->mapchip.draw_ysize = VIDEO_HEIGHT;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.id         = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.cut_color  = COLOR_WHITE;
    vdma_channel(vdma_pos);

    for (int32_t i = 255; i >= 0; i -= COLOR_ALPHA_DEC)
    {
        while (true != hvsync_state());
        game->mapchip.alpha = i;
        put_mapchip(game);
        // png_mapchip(game);
    }
}


/*
 * ver1. 2021/06/19
 * 暗転状態から徐々にデータを描画処理
 * バックアップ領域に描画データを保存後、カラーパレットと合成した色を徐々に描画する
 */
static void display_gradually_draw(GameWrapper *const game, uint8_t vdma_pos)
{
    frame_buffer_nextdraw_ready(game);
    game->mapchip.srcin      = DRAM_BACKUP_FBUF_ADDR_BASE;
    game->mapchip.dstin      = DRAM_COLOR_PALLET_ADDR_BASE;
    game->mapchip.maxwidth	 = VIDEO_WIDTH;
    game->mapchip.maxheight	 = VIDEO_HEIGHT;
    game->mapchip.draw_xsize = VIDEO_WIDTH;
    game->mapchip.draw_ysize = VIDEO_HEIGHT;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.id         = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.cut_color  = COLOR_WHITE;
    game->mapchip.dstout     = game->conf.work.adr;
    vdma_channel(vdma_pos);
    for (uint32_t i = 0; i < 256; i += COLOR_ALPHA_INC)
    {
        while (true != hvsync_state());
        game->mapchip.alpha = i;
        put_mapchip(game);
        // png_mapchip(game);
    }
}
