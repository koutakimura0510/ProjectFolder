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

        game->npc.id[i]   = fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, map_npcid, NPC_SUB_MEMBER_PATTERN_NPCID);
        game->npc.xpos[i] = fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, map_npcid, NPC_SUB_MEMBER_PATTERN_XINIT);
        game->npc.ypos[i] = fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, map_npcid, NPC_SUB_MEMBER_PATTERN_YINIT);
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

	for (uint8_t i = 0; i < NPC_STATE_FUNC_DB_SIZE; i++, p++)
	{
		if (game->conf.display.drawtype == p->drawtype)
		{
			p->npc_window(game, &npc);
			break;
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
    npc->buffer = DRAM_MAPDATA_NPC_ADDR_START;
    npc->xsize  = get_mapsize('w');
    npc->field  = CHIP_LEFT(game->unit.pos.fieldx) + (CHIP_LEFT(game->unit.pos.fieldy) * npc->xsize);
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = COLOR_ALPHA_MAX;
    game->mapchip.srcin      = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_SRCIN);
    game->mapchip.maxwidth	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_XSIZE);
    game->mapchip.maxheight	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_YSIZE);
    game->mapchip.draw_xsize = game->mapchip.maxwidth;
    game->mapchip.draw_ysize = game->mapchip.maxheight;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;

    for (uint32_t y = 0; y < MAPCHIP_DRAW_MAX_HEIGHT; y++)
    {
        npc->index = (y * npc->xsize) + npc->field;

        for (uint32_t x = 0; x < MAPCHIP_DRAW_MAX_WIDTH; x++)
        {
            game->mapchip.id = npc->buffer[x + npc->index];

            if (game->mapchip.id == 0)
            {
                continue;
            }

            game->mapchip.dstin  = CHIP_RGB(x) + (CHIP_RGB(y) * VIDEO_WIDTH) + game->conf.work.adr;
            game->mapchip.dstout = game->mapchip.dstin;
            png_mapchip(game);
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
    npc->buffer = DRAM_MAPDATA_NPC_ADDR_START;
    npc->xsize  = get_mapsize('w');
    npc->field  = CHIP_LEFT(game->unit.pos.fieldx) + (CHIP_LEFT(game->unit.pos.fieldy) * npc->xsize);
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = COLOR_ALPHA_MAX;
    game->mapchip.srcin      = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_SRCIN);
    game->mapchip.maxwidth	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_XSIZE);
    game->mapchip.maxheight	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_YSIZE);
    game->mapchip.draw_xsize = game->mapchip.maxwidth;
    game->mapchip.draw_ysize = game->mapchip.maxheight;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;

    for (uint32_t y = 0; y < MAPCHIP_DRAW_MAX_HEIGHT; y++)
    {
        npc->index = (y * npc->xsize) + npc->field;

        for (uint32_t x = 0; x < MAPCHIP_DRAW_MAX_WIDTH; x++)
        {
            game->mapchip.id = npc->buffer[x + npc->index];

            if (game->mapchip.id == 0)
            {
                continue;
            }

            game->mapchip.dstin  = game->conf.work.adr + CHIP_RGB(x) + (CHIP_RGB(y) * VIDEO_WIDTH) - XRGB(game->unit.pos.anime_cnt);
            game->mapchip.dstout = game->mapchip.dstin;
            png_mapchip(game);
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
    npc->buffer = DRAM_MAPDATA_NPC_ADDR_START;
    npc->xsize  = get_mapsize('w');
    npc->field  = CHIP_LEFT(game->unit.pos.fieldx) + (CHIP_LEFT(game->unit.pos.fieldy) * npc->xsize) + 1;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = COLOR_ALPHA_MAX;
    game->mapchip.srcin      = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_SRCIN);
    game->mapchip.maxwidth	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_XSIZE);
    game->mapchip.maxheight	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_YSIZE);
    game->mapchip.draw_xsize = game->mapchip.maxwidth;
    game->mapchip.draw_ysize = game->mapchip.maxheight;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;

    for (uint32_t y = 0; y < MAPCHIP_DRAW_MAX_HEIGHT; y++)
    {
        npc->index = (y * npc->xsize) + npc->field;

        for (uint32_t x = 0; x < MAPCHIP_DRAW_MAX_WIDTH; x++)
        {
            game->mapchip.id = npc->buffer[x + npc->index];

            if (game->mapchip.id == 0)
            {
                continue;
            }

            game->mapchip.dstin  = game->conf.work.adr + CHIP_RGB(x) + (CHIP_RGB(y) * VIDEO_WIDTH) + XRGB(game->unit.pos.anime_cnt);
            game->mapchip.dstout = game->mapchip.dstin;
            png_mapchip(game);
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
    npc->buffer = DRAM_MAPDATA_NPC_ADDR_START;
    npc->xsize  = get_mapsize('w');
    npc->field  = CHIP_LEFT(game->unit.pos.fieldx) + (CHIP_LEFT(game->unit.pos.fieldy) * npc->xsize);
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = COLOR_ALPHA_MAX;
    game->mapchip.srcin      = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_SRCIN);
    game->mapchip.maxwidth	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_XSIZE);
    game->mapchip.maxheight	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_YSIZE);
    game->mapchip.draw_xsize = game->mapchip.maxwidth;
    game->mapchip.draw_ysize = game->mapchip.maxheight;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;

    for (uint32_t y = 0; y < MAPCHIP_DRAW_MAX_HEIGHT; y++)
    {
        npc->index = (y * npc->xsize) + npc->field + npc->xsize;

        for (uint32_t x = 0; x < MAPCHIP_DRAW_MAX_WIDTH; x++)
        {
            game->mapchip.id = npc->buffer[x + npc->index];

            if (game->mapchip.id == 0)
            {
                continue;
            }

            game->mapchip.dstin  = game->conf.work.adr + CHIP_RGB(x) + (CHIP_RGB(y) * VIDEO_WIDTH) + YRGB(game->unit.pos.anime_cnt);
            game->mapchip.dstout = game->mapchip.dstin;
            png_mapchip(game);
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
    npc->buffer = DRAM_MAPDATA_NPC_ADDR_START;
    npc->xsize  = get_mapsize('w');
    npc->field  = CHIP_LEFT(game->unit.pos.fieldx) + (CHIP_LEFT(game->unit.pos.fieldy) * npc->xsize);
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = COLOR_ALPHA_MAX;
    game->mapchip.srcin      = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_SRCIN);
    game->mapchip.maxwidth	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_XSIZE);
    game->mapchip.maxheight	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_YSIZE);
    game->mapchip.draw_xsize = game->mapchip.maxwidth;
    game->mapchip.xstart_pos = 0;

    for (uint32_t y = 0; y < MAPCHIP_DRAW_MAX_HEIGHT+1; y++)
    {
        npc->index = (y * npc->xsize) + npc->field;

        for (uint32_t x = 0; x < MAPCHIP_DRAW_MAX_WIDTH; x++)
        {
            game->mapchip.id = npc->buffer[x + npc->index];

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
            game->mapchip.dstin  = game->conf.work.adr + CHIP_RGB(x) + (CHIP_RGB(y) * VIDEO_WIDTH) - rect.y;
            game->mapchip.dstout = game->mapchip.dstin;
            png_mapchip(game);
        }
	}
}