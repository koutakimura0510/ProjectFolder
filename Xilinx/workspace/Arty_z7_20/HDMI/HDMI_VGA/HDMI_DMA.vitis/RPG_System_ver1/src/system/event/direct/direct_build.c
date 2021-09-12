/*
 * サブマップの当たり判定関数を管理するファイル
 */
#include "../../wrapper/game_wrapper.h"
#include "direct_build_funcptr.h"


/*
 * ファイル内関数
 */
static bool isDirect_submap(GameWrapper *const game, const NextmapState *next);
static bool isDirect_point(GameWrapper *const game, const SubmapDirect *submap, uint32_t x, uint32_t y);


/*
 * 町のデータベースから当たり判定座標を読み取り当たり判定を行う
 * 停止中のキャラクターとデータベースの座標が重なった場合にIDを取得する
 */
bool isDirect_buildmap(GameWrapper *const game)
{
	const NextmapState *next = nextmap_state;

	if (game->conf.map.next != game->conf.old.nextmap)
	{
		for (uint8_t i = 0; i < NEXTMAP_DIRECT_ID_DB_SIZE; i++, next++)
		{
			if (game->conf.map.next == next->nextmap)
			{
				game->conf.old.nextmap = next->nextmap;
				game->conf.old.row_count = i;
				break;
			}
		}
	}
	else
	{
		next += game->conf.old.row_count;
	}

	return isDirect_submap(game, next);
}


/*
 * ver1. 2021/06/21
 * キャラクターの現在座標と比較を行いサブマップの当たり判定処理を行う
 * 
 * 当たり判定を行うサブマップの開始IDまでデータベースのアドレスを進める。
 * 次にサブマップの対応した開始IDから終了IDまでループを行い、当たり判定処理を行う
 */
static bool isDirect_submap(GameWrapper *const game, const NextmapState *next)
{
    const SubmapDirect *submap = submap_direct;
	uint32_t x   = (game->unit.pos.unitx + game->unit.pos.fieldx);
    uint32_t y   = (game->unit.pos.unity + game->unit.pos.fieldy);
	uint32_t cnt = next->nextmap_direct_endid - next->nextmap_direct_startid;

	if (next->nextmap_direct_startid != game->conf.old.startid)
	{
		for (uint8_t i = 0; i < SUBMAP_DIRECT_DB_SIZE; i++, submap++)
		{
			if (submap->event_id == next->nextmap_direct_startid)
			{
				game->conf.old.startid = next->nextmap_direct_startid;
				game->conf.old.start_row_count = i;
				break;
			}
		}
	}
	else
	{
		submap += game->conf.old.start_row_count;
	}

	for (uint8_t i = 0; i < cnt; i++, submap++)
    {
		if (ON_DIRECT == isDirect_point(game, submap, x, y))
		{
			game->conf.display.system   = submap->next_system;
			game->conf.display.drawtype = submap->next_drawtype;
			game->conf.event.id   		= submap->event_id;
			game->conf.event.type 		= submap->event_type;
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
static bool isDirect_point(GameWrapper *const game, const SubmapDirect *submap, uint32_t x, uint32_t y)
{
	uint8_t mapx, mapy;
	uint32_t xpos, ypos;

	switch (submap->point)
	{
	case DIRECT_POINT_FIXED:
		xpos = (uint32_t)submap->xpos << MAPCHIP_SHIFT;
		ypos = (uint32_t)submap->ypos << MAPCHIP_SHIFT;

		if ((x == xpos) && (y == ypos))
		{
			return ON_DIRECT;
		}

		if ((game->unit.pos.eventx == xpos) && (game->unit.pos.eventy == ypos))
		{
			if (submap->next_system == SYSTEM_MSG_WINDOW) {
				return ON_DIRECT;
			}
		}
		return NON_DIRECT;
	
	case DIRECT_POINT_VARIABLE:
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
