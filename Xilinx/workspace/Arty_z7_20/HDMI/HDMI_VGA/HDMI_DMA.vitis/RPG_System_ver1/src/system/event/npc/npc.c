/**
 * Create 2021/09/20
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * @brief npcの操作に関する処理を管理するファイル
 */
#include "../../wrapper/game_wrapper.h"
#include "npc_struct.h"
#include "xil_cache.h"

/* pixel移動アニメーションのONOFF */
#define NPC_MOVE_DEBUG


/* npcの操作に関するファイル内関数 */
static void npc_random_update(GameWrapper *const game, uint8_t index);
static void npc_dir_update(GameWrapper *const game);
static void npc_pixel_update(GameWrapper *const game);
static void npc_mapchip_update(GameWrapper *const game);


/**
 * @brief  DRAMに保存されているNPCのデータをラッパー構造体に保存
 * @note   構造体に保存しておくと、DRAMアクセスの時間を減らせるため作った
 * @retval None
 */
void npc_config(GameWrapper *const game)
{
    for (uint8_t i = 0; i < NPC_MAX_DRAW_NUM; i++)
    {
        uint32_t map_npcid = fetch_dram_db(game, MEMORY_NPC_MAP_ID, game->conf.map.name, NPC_SUB_MEMBER_MAP_NPC_NUM_0 + i);

        if (map_npcid == 0)
        {
            game->npc.number = i;
            break;
        }

        game->npc.map_npcid[i]    = map_npcid;
        game->npc.id[i]           = fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, map_npcid,       NPC_SUB_MEMBER_PATTERN_NPCID);
        game->npc.mapchip_id[i]   = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID,  game->npc.id[i], NPC_SUB_MEMBER_BITMAP_MAPCHIPID);
        game->npc.cut_pos[i]      = 0;
        game->npc.dir[i]          = NPC_DIR_DOWN;
        game->npc.anime_time[i]   = 0;
        game->npc.dir_time[i]     = 0;
        game->npc.active_state[i] = NPC_ACTIVE_STAND;
        game->npc.map_pos[NPC_INDEX_X][i] = 0;
        game->npc.map_pos[NPC_INDEX_Y][i] = 0;
        game->npc.pixel_adjust[NPC_INDEX_X][i] = 0;
        game->npc.pixel_adjust[NPC_INDEX_Y][i] = 0;
    }

    uint32_t size = get_mapsize('w') * get_mapsize('h');

    for (uint8_t j = 0; j < game->npc.number; j++)  /* 初期位置のインデックスを保存 */
    {
        uint32_t *buffer = DRAM_MAPDATA_NPC_ADDR_START;

        for (uint32_t i = 0; i < size; i++, buffer++)
        {
            if (*buffer == game->npc.map_npcid[j])
            {
                game->npc.dram_index[j] = i;
                break;
            }
        }
    }
}


/**
 * @brief  npcの描画を行う
 * @note   
 * @retval None
 */
void npc_draw(GameWrapper *const game)
{
    const NpcDrawing *p = npc_drawing;
    DrawElement npc;

    npc->buffer = DRAM_MAPDATA_NPC_ADDR_START;
    npc->xsize  = get_mapsize('w');
    npc->field  = CHIP_LEFT(game->unit.pos.fieldx) + (CHIP_LEFT(game->unit.pos.fieldy) * npc->xsize);
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = COLOR_ALPHA_MAX;
    game->mapchip.srcin      = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_SRCIN);
    game->mapchip.maxwidth	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_XSIZE);
    game->mapchip.maxheight	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_YSIZE);

	for (uint8_t i = 0; i < NPC_STATE_FUNC_DB_SIZE; i++, p++)
	{
		if (game->conf.display.drawtype == p->drawtype)
		{
            npc_dir_update(game);
            npc_pixel_update(game);
            npc_mapchip_update(game);
            p->npc_window(game, &npc);
			break;
		}
	}
}


/**
 * @brief  npcの向きの更新処理
 * @note   データベースから向きを変更する周期を取得し、前回の時間から一定時間経過していたら
 *         NPCの行動パターンによってNPCの現在の座標を更新する
 * @retval None
 */
static void npc_dir_update(GameWrapper *const game)
{
    for (uint8_t i = 0; i < game->npc.number; i++)
    {
        if (NPC_ACTIVE_ANIMATION == game->npc.active_state[i])
        {
            continue;
        }

        if (false == tmr_constant(&game->npc.dir_time[i], fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, game->npc.map_npcid[i], NPC_SUB_MEMBER_PATTERN_UPDATE_SPEED)))
        {
            continue;
        }

        switch (fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, game->npc.map_npcid[i], NPC_SUB_MEMBER_PATTERN_ACTION_PATTERN))
        {
        case NPC_PATTERN_RANDOM:
            npc_random_update(game, i);
            break;

        case NPC_PATTERN_ROULETTE:
            break;

        case NPC_PATTERN_STEP:
            break;

        case NPC_PATTERN_FAST_STEP:
            break;

        case NPC_PATTERN_STAND:
            break;
        
        default:
            break;
        }

        game->npc.dir_time[i] = get_time();
    }
}


/**
 * @brief  NPC_ACTIVE_ANIMATION時のpixel座標更新処理
 * @note   
 * @retval None
 */
static void npc_pixel_update(GameWrapper *const game)
{
    uint8_t index;

    for (uint8_t i = 0; i < game->npc.number; i++)
    {
#ifdef NPC_MOVE_DEBUG
        game->npc.active_state[i] = NPC_ACTIVE_STAND;
        continue;
#endif
        if (NPC_ACTIVE_STAND == game->npc.active_state[i])
        {
            continue;
        }

        switch (game->npc.dir[i])
        {
        case NPC_DIR_DOWN:
            index = NPC_INDEX_Y;
            game->npc.pixel_adjust[index][i] += game->unit.animation_pixel_y;
            break;

        case NPC_DIR_UP:
            index = NPC_INDEX_Y;
            game->npc.pixel_adjust[index][i] -= game->unit.animation_pixel_y;
            break;

        case NPC_DIR_RIGHT:
            index = NPC_INDEX_X;
            game->npc.pixel_adjust[index][i] += game->unit.animation_pixel_x;
            break;

        case NPC_DIR_LEFT:
            index = NPC_INDEX_X;
            game->npc.pixel_adjust[index][i] -= game->unit.animation_pixel_x;
            break;
        
        default:
            break;
        }

        if (game->npc.pixel_adjust[index][i] == 0)
        {
            game->npc.active_state[i] = NPC_ACTIVE_STAND;
        }
    }
}


/**
 * @brief  npcの歩行アニメーションマップチップ更新処理
 * @note   マップチップの並び順が0.左足、1.直立、2.右足の順番で並んでいる
 *         直立の描画は行わないため、0.左足、2.右足のマップチップを交互に入れ替える
 * 
 * @retval None
 */
static void npc_mapchip_update(GameWrapper *const game)
{
    for (uint8_t i = 0; i < game->npc.number; i++)
    {
        if (true == tmr_constant(&game->npc.anime_time[i], fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, game->npc.map_npcid[i], NPC_SUB_MEMBER_PATTERN_MAPCHIP_SPEED)))
        {
            game->npc.cut_pos[i] += 2;
            game->npc.cut_pos[i] &= 0x02;
            game->npc.mapchip_id[i] = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[i], NPC_SUB_MEMBER_BITMAP_MAPCHIPID) + game->npc.cut_pos[i] + game->npc.dir[i];
            game->npc.anime_time[i] = get_time();
        }
    }
}


/**
 * @brief  画面の上下左右のアニメーションを行わない場合のNPC描画処理
 * @note   
 * @retval None
 */
static void npc_center_draw(GameWrapper *const game, DrawElement *const npc)
{
    game->mapchip.draw_xsize = game->mapchip.maxwidth;
    game->mapchip.draw_ysize = game->mapchip.maxheight;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;

    for (uint32_t y = 0; y < MAPCHIP_DRAW_MAX_HEIGHT; y++)  /* 一画面分npcマップファイルのID検索を行う */
    {
        npc->index = (y * npc->xsize) + npc->field;

        for (uint32_t x = 0; x < MAPCHIP_DRAW_MAX_WIDTH; x++)
        {
            uint8_t id = npc->buffer[x + npc->index];

            if (0 == id)
            {
                continue;
            }

            for (uint8_t i = 0; i < game->npc.number; i++)  /* npcidでインデックスの検索を行い、描画IDを取得する */
            {
                if (id == game->npc.map_npcid[i])
                {
                    int32_t adjust_pos = CHIP_ADDR_SHIFT(game->npc.pixel_adjust[NPC_INDEX_X][i]) + CHIP_ADDR_SHIFT(game->npc.pixel_adjust[NPC_INDEX_Y][i]);
                    game->mapchip.id = game->npc.mapchip_id[i];
                    game->mapchip.dstin  = CHIP_RGB(x) + (CHIP_RGB(y) * VIDEO_WIDTH) + game->conf.work.adr + adjust_pos;
                    game->mapchip.dstout = game->mapchip.dstin;
                    png_mapchip(game);
                    break;
                }
            }
        }
	}
}


/**
 * @brief  画面の右移動アニメーション時のNPC描画処理
 * @note   
 * @retval None
 */
static void npc_right_draw(GameWrapper *const game, DrawElement *const npc)
{
    SDL_Rect rect;
    game->mapchip.draw_ysize = game->mapchip.maxheight;
    game->mapchip.ystart_pos = 0;

    for (uint32_t y = 0; y < MAPCHIP_DRAW_MAX_HEIGHT; y++)
    {
        npc->index = (y * npc->xsize) + npc->field;

        for (uint32_t x = 0; x < MAPCHIP_DRAW_MAX_WIDTH + 1; x++)
        {
            uint8_t id = npc->buffer[x + npc->index];

            if (id == 0)
            {
                continue;
            }

            if (x == 0)
            {
                game->mapchip.xstart_pos = game->unit.pos.anime_cnt;
                game->mapchip.draw_xsize = game->mapchip.maxwidth - game->unit.pos.anime_cnt;
                rect.x = 0;
            }
            else if (x == MAPCHIP_DRAW_MAX_WIDTH)
            {
                game->mapchip.xstart_pos = 0;
                game->mapchip.draw_xsize = game->unit.pos.anime_cnt;
                rect.x = XRGB(game->unit.pos.anime_cnt);
            }
            else
            {
                game->mapchip.xstart_pos = 0;
                game->mapchip.draw_xsize = game->mapchip.maxwidth;
                rect.x = XRGB(game->unit.pos.anime_cnt);
            }

            for (uint8_t i = 0; i < game->npc.number; i++)  /* npcidでインデックスの検索を行い、描画IDを取得する */
            {
                if (id == game->npc.map_npcid[i])
                {
                    game->mapchip.id     = game->npc.mapchip_id[i];
                    game->mapchip.dstin  = game->conf.work.adr + CHIP_RGB(x) + (CHIP_RGB(y) * VIDEO_WIDTH) - rect.x + CHIP_ADDR_SHIFT(game->npc.pixel_adjust[NPC_INDEX_X][i]);
                    game->mapchip.dstout = game->mapchip.dstin;
                    png_mapchip(game);
                    break;
                }
            }
        }
	}
}


/**
 * @brief  画面の左移動アニメーション時のNPC描画処理
 * @note   
 * @retval None
 */
static void npc_left_draw(GameWrapper *const game, DrawElement *const npc)
{
    SDL_Rect rect;
    game->mapchip.draw_ysize = game->mapchip.maxheight;
    game->mapchip.ystart_pos = 0;

    for (uint32_t y = 0; y < MAPCHIP_DRAW_MAX_HEIGHT; y++)
    {
        npc->index = (y * npc->xsize) + npc->field;

        for (uint32_t x = 0; x < MAPCHIP_DRAW_MAX_WIDTH+1; x++)
        {
            uint8_t id = npc->buffer[x + npc->index];

            if (id == 0)
            {
                continue;
            }

            if (x == 0)
            {
                game->mapchip.xstart_pos = game->mapchip.maxwidth - game->unit.pos.anime_cnt;
                game->mapchip.draw_xsize = game->unit.pos.anime_cnt;
                rect.x = 0;
            }
            else if (x == MAPCHIP_DRAW_MAX_WIDTH)
            {
                game->mapchip.xstart_pos = 0;
                game->mapchip.draw_xsize = game->mapchip.maxwidth - game->unit.pos.anime_cnt;
                rect.x = XRGB(game->unit.pos.anime_cnt) - CHIP_RGB(1);
            }
            else
            {
                game->mapchip.xstart_pos = 0;
                game->mapchip.draw_xsize = game->mapchip.maxwidth;
                rect.x = XRGB(game->unit.pos.anime_cnt) - CHIP_RGB(1);
            }

            for (uint8_t i = 0; i < game->npc.number; i++)  /* npcidでインデックスの検索を行い、描画IDを取得する */
            {
                if (id == game->npc.map_npcid[i])
                {
                    game->mapchip.id     = game->npc.mapchip_id[i];
                    game->mapchip.dstin  = game->conf.work.adr + CHIP_RGB(x) + (CHIP_RGB(y) * VIDEO_WIDTH) + rect.x + CHIP_ADDR_SHIFT(game->npc.pixel_adjust[NPC_INDEX_X][i]);
                    game->mapchip.dstout = game->mapchip.dstin;
                    png_mapchip(game);
                    break;
                }
            }
        }
	}
}


/**
 * @brief  画面の上移動アニメーション時のNPC描画処理
 * @note   
 * @retval None
 */
static void npc_up_draw(GameWrapper *const game, DrawElement *const npc)
{
    SDL_Rect rect;
    game->mapchip.draw_xsize = game->mapchip.maxwidth;
    game->mapchip.xstart_pos = 0;

    for (uint32_t y = 0; y < MAPCHIP_DRAW_MAX_HEIGHT+1; y++)
    {
        npc->index = (y * npc->xsize) + npc->field;

        for (uint32_t x = 0; x < MAPCHIP_DRAW_MAX_WIDTH; x++)
        {
            uint8_t id = npc->buffer[x + npc->index];

            if (id == 0)
            {
                continue;
            }

            if (y == 0)
            {
                game->mapchip.ystart_pos = game->mapchip.maxheight - game->unit.pos.anime_cnt;
                game->mapchip.draw_ysize = game->unit.pos.anime_cnt;
                rect.y = 0;
            }
            else
            {
                game->mapchip.ystart_pos = 0;
                game->mapchip.draw_ysize = game->mapchip.maxheight;
                rect.y = YRGB(game->unit.pos.anime_cnt) - (CHIP_RGB(1) * VIDEO_WIDTH);
            }

            for (uint8_t i = 0; i < game->npc.number; i++)  /* npcidでインデックスの検索を行い、描画IDを取得する */
            {
                if (id == game->npc.map_npcid[i])
                {
                    game->mapchip.id     = game->npc.mapchip_id[i];
                    game->mapchip.dstin  = game->conf.work.adr + CHIP_RGB(x) + (CHIP_RGB(y) * VIDEO_WIDTH) + rect.y + CHIP_ADDR_SHIFT(game->npc.pixel_adjust[NPC_INDEX_Y][i]);
                    game->mapchip.dstout = game->mapchip.dstin;
                    png_mapchip(game);
                    break;
                }
            }
        }
	}
}


/**
 * @brief  画面の下移動アニメーション時のNPC描画処理
 * @note   
 * @retval None
 */
static void npc_down_draw(GameWrapper *const game, DrawElement *const npc)
{
    SDL_Rect rect;
    game->mapchip.draw_xsize = game->mapchip.maxwidth;
    game->mapchip.xstart_pos = 0;

    for (uint32_t y = 0; y < MAPCHIP_DRAW_MAX_HEIGHT+1; y++)
    {
        npc->index = (y * npc->xsize) + npc->field;

        for (uint32_t x = 0; x < MAPCHIP_DRAW_MAX_WIDTH; x++)
        {
            uint8_t id = npc->buffer[x + npc->index];

            if (game->mapchip.id == 0)
            {
                continue;
            }

            if (y == 0)
            {
                game->mapchip.ystart_pos = game->unit.pos.anime_cnt;
                game->mapchip.draw_ysize = game->mapchip.maxheight - game->unit.pos.anime_cnt;
                rect.y = 0;
            }
            else if (y == MAPCHIP_DRAW_MAX_HEIGHT)
            {
                game->mapchip.ystart_pos = 0;
                game->mapchip.draw_ysize = game->unit.pos.anime_cnt;
                rect.y = (CHIP_RGB(1) * VIDEO_WIDTH) - YRGB((game->mapchip.maxheight - game->unit.pos.anime_cnt));
            }
            else
            {
                game->mapchip.ystart_pos = 0;
                game->mapchip.draw_ysize = game->mapchip.maxheight;
                rect.y = YRGB(game->unit.pos.anime_cnt);
            }

            for (uint8_t i = 0; i < game->npc.number; i++)  /* npcidでインデックスの検索を行い、描画IDを取得する */
            {
                if (id == game->npc.map_npcid[i])
                {
                    game->mapchip.id     = game->npc.mapchip_id[i];
                    game->mapchip.dstin  = game->conf.work.adr + CHIP_RGB(x) + (CHIP_RGB(y) * VIDEO_WIDTH) - rect.y + CHIP_ADDR_SHIFT(game->npc.pixel_adjust[NPC_INDEX_Y][i]);
                    game->mapchip.dstout = game->mapchip.dstin;
                    png_mapchip(game);
                    break;
                }
            }
        }
	}
}


/**
 * @brief  ランダム方向に行動するNPCの座標更新処理
 * @note   
 * npc.map_pos[][]の二次元配列参照計算方法
 * right,left時はx座標を更新しなければならない
 * up,down時はy座標を更新しなければならない
 * 
 * x = Index[0], right,left = 0,1
 * y = Index[1], up,down = 2,3
 * 1bitシフトすると0,もしくは1が残るためindexを参照できる
 * 
 * @retval None
 */
static void npc_random_update(GameWrapper *const game, uint8_t index)
{
    uint8_t rand_number = get_random(0x03); /* 上下左右の要素の合計が3のため 0 ~ 3の値を取得 */
    int8_t  range       = fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, game->npc.map_npcid[index], NPC_SUB_MEMBER_PATTERN_RANGE_LEFT + rand_number);
    uint8_t range_bit   = range >> 1;
    int32_t sign        = 0;

    if (range < game->npc.map_pos[range_bit][index]) /* 左、上移動の判定 */
    {
        sign = -1;
    }

    if (game->npc.map_pos[range_bit][index] < range) /* 右、下移動の判定 */
    {
        sign = 1;
    }

    if (sign != 0)
    {
        uint32_t *buffer = DRAM_MAPDATA_NPC_ADDR_START;

        /* npcの状態・向き・座標データ更新 */
        game->npc.dir[index]      = NPC_DIR_EDGE * rand_number;
        game->npc.active_state[i] = NPC_ACTIVE_ANIMATION;
        game->npc.map_pos[range_bit][index] += sign;

        /* 座標調整用データの更新。アニメーション処理関数内でpixel数の操作を行う */
        game->pixel_adjust[range_bit][index] = MAPCHIP_WIDTH * (~sign + 1);

        /* npcマップの移動前の座標を初期化 */
        buffer[game->npc.dram_index[index]] = 0;
        Xil_DCacheFlushRange((uint32_t)(buffer + game->npc.dram_index[index]), 4);

        /* 移動後の座標に番号を保存 */
        game->npc.dram_index[index] += (range_bit == 0) ? sign : get_mapsize('w') * sign;
        buffer[game->npc.dram_index[index]] = game->npc.map_npcid[index];
        Xil_DCacheFlushRange((uint32_t)(buffer + game->npc.dram_index[index]), 4);
    }
}