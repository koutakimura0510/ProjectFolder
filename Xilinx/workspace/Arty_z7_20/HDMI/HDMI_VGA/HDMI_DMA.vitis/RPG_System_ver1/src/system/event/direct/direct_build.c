/*
 * サブマップの当たり判定関数を管理するファイル
 */
#include "../../wrapper/game_wrapper.h"


/*
 * ファイル内関数
 */
static bool isDirect_point(GameWrapper *const game, uint8_t i, uint32_t x, uint32_t y);


/*
 * 町のデータベースから当たり判定座標を読み取り当たり判定を行う
 * 停止中のキャラクターとデータベースの座標が重なった場合にIDを取得する
 */
bool isDirect_buildmap(GameWrapper *const game)
{
	uint32_t x           = (game->unit.pos.unitx + game->unit.pos.fieldx);
    uint32_t y           = (game->unit.pos.unity + game->unit.pos.fieldy);
	uint8_t db_start_row = fetch_dram_db(game, MEMORY_BUILD_LOOP_ID, game->conf.map.name, BUILD_LOOPCOUNT_MEMBER_START_ID);
    uint8_t db_end_row   = fetch_dram_db(game, MEMORY_BUILD_LOOP_ID, game->conf.map.name, BUILD_LOOPCOUNT_MEMBER_LOOP_COUNT);

	for (uint8_t i = db_start_row; i < db_end_row; i++)
    {
		if (ON_DIRECT == isDirect_point(game, i, x, y))
		{
			game->conf.event.id   		= fetch_dram_db(game, MEMORY_BUILD_POS_ID, i, BUILD_POS_MEMBER_EVENT_ID);
			game->conf.display.system   = fetch_dram_db(game, MEMORY_BUILD_EVENT_ID, game->conf.event.id, BUILD_EVENT_MEMBER_NEXT_SYSTEM);
			game->conf.display.drawtype = fetch_dram_db(game, MEMORY_BUILD_EVENT_ID, game->conf.event.id, BUILD_EVENT_MEMBER_NEXT_DRAWTYPE);
			game->conf.event.type 		= fetch_dram_db(game, MEMORY_BUILD_EVENT_ID, game->conf.event.id, BUILD_EVENT_MEMBER_EVENT_TYPE);
			game->conf.event.try_mapname_id = fetch_dram_db(game, MEMORY_BUILD_EVENT_ID, game->conf.event.id, BUILD_EVENT_MEMBER_NEXT_MAPNAME_ID);
			game->unit.pos.unitdir      = DIR_WAIT;
			game->unit.pos.anime_cnt    = 0;
			return ON_DIRECT;
		}
    }

	return NON_DIRECT;
}



/*
 * ver1. 2021/06/19
 * 固定座標と可変座標の当たり判定処理を行う
 * 可変座標はマップの最大サイズ、又は、最小サイズに達した場合にマップ間移動を行う
 */
static bool isDirect_point(GameWrapper *const game, uint8_t i, uint32_t x, uint32_t y)
{
	uint8_t mapx, mapy;
	uint32_t xpos, ypos;

	switch (fetch_dram_db(game, MEMORY_BUILD_POS_ID, i, BUILD_POS_MEMBER_ISVARIABLE))
	{
	case EVENT_FIXED:
		xpos = fetch_dram_db(game, MEMORY_BUILD_POS_ID, i, BUILD_POS_MEMBER_XPOS) << MAPCHIP_SHIFT;
		ypos = fetch_dram_db(game, MEMORY_BUILD_POS_ID, i, BUILD_POS_MEMBER_YPOS) << MAPCHIP_SHIFT;

		if ((x == xpos) && (y == ypos))
		{
			return ON_DIRECT;
		}

		if ((game->unit.pos.eventx == xpos) && (game->unit.pos.eventy == ypos))
		{
			if (fetch_dram_db(game, MEMORY_BUILD_EVENT_ID, i, BUILD_EVENT_MEMBER_EVENT_TYPE) == SYSTEM_MSG_WINDOW) {
				return ON_DIRECT;
			}
		}
		return NON_DIRECT;
	
	case EVENT_VARIABLE:
		mapx = get_mapsize('w') - 1;
		mapy = get_mapsize('h') - 1;
		x >>= MAPCHIP_SHIFT;
		y >>= MAPCHIP_SHIFT;

		if ((mapx <= x) || (mapy <= y) || (x == 0) || (y == 0))
		{
			return ON_DIRECT;
		}
		return NON_DIRECT;

	default:
		return NON_DIRECT;
	}
}
