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
    MapElement map;

    map.buffer = DRAM_MAPDATA_NPC_ADDR_START;
    map.xsize  = get_mapsize('w');
    map.field  = CHIP_LEFT(game->unit.pos.fieldx) + (CHIP_LEFT(game->unit.pos.fieldy) * map.xsize);
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
        map.index    = (y * map.xsize) + map.field;

        for (uint32_t x = 0; x < MAPCHIP_DRAW_MAX_WIDTH; x++)
        {
            game->mapchip.id = map.buffer[x + map.index];

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


// static void npc_center_draw(GameWrapper *const game)
// {
//     if (game->unit.pos.fieldx )
//     game->unit.pos.fieldx + game->unit.pos.unitx;
//     game->mapchip.frame_size = VIDEO_WIDTH;
//     game->mapchip.alpha		 = 255;
//     game->mapchip.srcin      = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_SRCIN);
//     game->mapchip.maxwidth	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_XSIZE);
//     game->mapchip.maxheight	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_YSIZE);
//     game->mapchip.draw_xsize = game->mapchip.maxwidth;
//     game->mapchip.draw_ysize = game->mapchip.maxheight;

//     for (uint8_t i = 0; i < game->npc.number; i++)
//     {
//         game->mapchip.xstart_pos = 0;
//         game->mapchip.ystart_pos = 0;
//         game->mapchip.id     = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[i], NPC_SUB_MEMBER_BITMAP_MAPCHIPID);
//         game->mapchip.dstin  = game->conf.work.adr + XRGB(game->npc.xpos[i]) + YRGB(game->npc.ypos[i]);
//         game->mapchip.dstout = game->mapchip.dstin;
//         png_mapchip(game);
//     }
// }