/*
 * 当たり判定関数を管理するファイル
 */
#include "../../wrapper/game_wrapper.h"
#define POS_DEBUG


/* イベント当たり判定関数宣言 */
static bool isDirect_worldmap(GameWrapper *const game);
static bool isDirect_buildmap(GameWrapper *const game);
static bool isDirect_dangeonmap(GameWrapper *const game);
static bool isEvent_fixed(GameWrapper *const game, SDL_Rect *const point);
static bool isEvent_variable(GameWrapper *const game, SDL_Rect *const point);


/**
 * @brief  イベント座標判定用関数の状態遷移関数ポインタテーブル
 * @note   イベントが固定「0」と可変「1」が存在する。
 * @retval None
 */
typedef struct
{
	bool (*const event_function[2])(GameWrapper *const game, SDL_Rect *const point);
} EventPoint;

static const EventPoint event_point = {
	{isEvent_fixed, isEvent_variable},
};


/*
 * デバッグ用に現在座標を端末に出力する
 * 使用する場合はこのファイルの先頭に #define POS_DEBUGと表記する
 */
#ifdef POS_DEBUG
#include "xil_io.h"
static void pos_debug(GameWrapper *const game);
static void pos_debug(GameWrapper *const game)
{
    xil_printf("(%3dx, %3dy), (%3dfx, %3dfy) = (%3dtx, %3d ty)\n",
                game->unit.pos.unitx >> 5, 
                game->unit.pos.unity >> 5, 
                game->unit.pos.fieldx >> 5, 
                game->unit.pos.fieldy >> 5,
                (game->unit.pos.unitx >> 5) + (game->unit.pos.fieldx >> 5),
                (game->unit.pos.unity >> 5) + (game->unit.pos.fieldy >> 5)
            );
}
#endif


/*
 * スイッチ入力が行われた時に進行方向に当たり判定が存在するか確認する
 * 障害物が存在していた場合に、進行方向を管理する変数をwait状態にし
 * 座標更新が行われないようにする
 */
bool isDirect_object(GameWrapper *const game)
{
    uint32_t x, y;

#ifdef POS_DEBUG
    if (game->unit.pos.unitdir != DIR_WAIT)
    {
        pos_debug(game);
    }
#endif

    switch (game->unit.pos.unitdir)
    {
    case DIR_RIGHT:
        x = ((game->unit.pos.unitx + game->unit.pos.fieldx) >> MAPCHIP_SHIFT) + 1;
        y = (game->unit.pos.unity + game->unit.pos.fieldy) >> MAPCHIP_SHIFT;
        break;

    case DIR_LEFT:
        x = (game->unit.pos.unitx + (game->unit.pos.fieldx - game->unit.pos.animation_pixel_x)) >> MAPCHIP_SHIFT;
        y = (game->unit.pos.unity + game->unit.pos.fieldy) >> MAPCHIP_SHIFT;
        break;

    case DIR_UP:
        x = (game->unit.pos.unitx + game->unit.pos.fieldx) >> MAPCHIP_SHIFT;
        y = (game->unit.pos.unity + (game->unit.pos.fieldy - game->unit.pos.animation_pixel_y)) >> MAPCHIP_SHIFT;
        break;

    case DIR_DOWN:
        x = (game->unit.pos.unitx + game->unit.pos.fieldx) >> MAPCHIP_SHIFT;
        y = ((game->unit.pos.unity + game->unit.pos.fieldy) >> MAPCHIP_SHIFT) + 1;
        break;

    default:
        x = (game->unit.pos.unitx + game->unit.pos.fieldx) >> MAPCHIP_SHIFT;
        y = (game->unit.pos.unity + game->unit.pos.fieldy) >> MAPCHIP_SHIFT;
    }

    if (game->conf.map.canpass_id < game->conf.map.back[x + (y * get_mapsize('w'))])
    {
		return NOT_CAN_MOVE;
	}

	return CAN_MOVE;
}


/* TODO
 * メッセージなどのイベント処理追加
 * キャラクターの進行方向のイベント情報を取得
 */
bool isDirect_event(GameWrapper *const game)
{
    switch (game->conf.event.type)
    {
    case EVENT_TYPE_WORLD_MOVE:
		return isDirect_worldmap(game);

	case EVENT_TYPE_SUBMAP_MOVE:
		return isDirect_buildmap(game);

	case EVENT_TYPE_DANGEON_MOVE:
		return isDirect_dangeonmap(game);

	default:
		return NON_DIRECT;
	}
}


/**
 * @brief  ワールドマップのマップ間移動のイベント当たり判定を行う
 * 
 * @note   
 * キャラクターの現在の座標とマップ移動イベント座標が重なった時に、
 * データを読み込むための町やダンジョンのIDを取得する。
 * マップ移動発生時の次の描画方法が暗転描画のため、ディスプレイのデータを設定しtrueを返す
 * 
 * @retval 
 */
static bool isDirect_worldmap(GameWrapper *const game)
{
    uint32_t x           = (game->unit.pos.unitx + game->unit.pos.fieldx);
    uint32_t y           = (game->unit.pos.unity + game->unit.pos.fieldy);
    uint8_t db_start_row = fetch_dram_db(game, MEMORY_BUILD_LOOP_ID, game->conf.map.name, BUILD_LOOPCOUNT_MEMBER_START_ID);
    uint8_t db_end_row   = fetch_dram_db(game, MEMORY_BUILD_LOOP_ID, game->conf.map.name, BUILD_LOOPCOUNT_MEMBER_LOOP_COUNT);

    for (uint32_t i = db_start_row; i < db_end_row; i++)
    {
        uint32_t direct_x = fetch_dram_db(game, MEMORY_WORLD_DIRECT_ID, i, WORLD_DIRECT_MEMBER_XPOS) << MAPCHIP_SHIFT;
        uint32_t direct_y = fetch_dram_db(game, MEMORY_WORLD_DIRECT_ID, i, WORLD_DIRECT_MEMBER_YPOS) << MAPCHIP_SHIFT;

        if ((x == direct_x) && (y == direct_y))
        {
            game->unit.pos.unitdir          = DIR_WAIT;
            game->unit.pos.anime_cnt        = 0;
            game->conf.event.try_mapname_id = fetch_dram_db(game, MEMORY_WORLD_DIRECT_ID, i, WORLD_DIRECT_MEMBER_MAPNAME_ID);
            game->conf.event.type           = fetch_dram_db(game, MEMORY_WORLD_DIRECT_ID, i, WORLD_DIRECT_MEMBER_EVENT_TYPE);
            game->conf.display.system       = SYSTEM_MAP_DARKENING_WINDOW;
            game->conf.display.drawtype     = DISPLAY_DARKENING_DRAW;
            return ON_DIRECT;
        }
    }

    return NON_DIRECT;
}


/**
 * @brief  サブマップ内のイベント発生座標を確認し当たり判定処理を管理する関数
 * @note   イベントを管理するデータベースの開始行と終了行を取得し、その範囲内でループ処理を行う
 * @retval イベント発生時true
 */
static bool isDirect_buildmap(GameWrapper *const game)
{
    SDL_Rect point = {
        .x = game->unit.pos.unitx + game->unit.pos.fieldx,
        .y = game->unit.pos.unity + game->unit.pos.fieldy,
    };

	uint8_t db_start_row = fetch_dram_db(game, MEMORY_BUILD_LOOP_ID, game->conf.map.name, BUILD_LOOPCOUNT_MEMBER_START_ID);
    uint8_t db_end_row   = fetch_dram_db(game, MEMORY_BUILD_LOOP_ID, game->conf.map.name, BUILD_LOOPCOUNT_MEMBER_LOOP_COUNT);
    const EventPoint *p  = &event_point; /* 可変・固定イベント発生確認関数ポインタの取得 */

	for (uint32_t i = db_start_row; i < db_end_row; i++)
    {
        point.h = i;

		if (ON_DIRECT == p->event_function[fetch_dram_db(game, MEMORY_BUILD_POS_ID, point.h, BUILD_POS_MEMBER_ISVARIABLE)](game, &point))
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
 * ダンジョンのデータベースから当たり判定座標を読み取り当たり判定を行う
 * 停止中のキャラクターとデータベースの座標が重なった場合にIDを取得する
 */
static bool isDirect_dangeonmap(GameWrapper *const game)
{
    return NON_DIRECT;
}


/**
 * @brief  イベント発生座標が不変のイベントの当たり判定処理を行う
 * @note   
 * @param  point: キャラクターの現在座標とループ回数が保存されている構造体のアドレス
 * @retval 
 */
static bool isEvent_fixed(GameWrapper *const game, SDL_Rect *const point)
{
    uint32_t xpos = fetch_dram_db(game, MEMORY_BUILD_POS_ID, point->h, BUILD_POS_MEMBER_XPOS) << MAPCHIP_SHIFT;
    uint32_t ypos = fetch_dram_db(game, MEMORY_BUILD_POS_ID, point->h, BUILD_POS_MEMBER_YPOS) << MAPCHIP_SHIFT;

    if ((point->x == xpos) && (point->y == ypos))
    {
        return ON_DIRECT;
    }

    if ((game->unit.pos.eventx == xpos) && (game->unit.pos.eventy == ypos))
    {
        if (SYSTEM_MSG_WINDOW == fetch_dram_db(game, MEMORY_BUILD_EVENT_ID, point->h, BUILD_EVENT_MEMBER_NEXT_SYSTEM)) {
            return ON_DIRECT;
        }
    }

    return NON_DIRECT;
}


/**
 * @brief  イベント発生座標が可変の当たり判定の処理を行う
 * @note   
 * @param  point: キャラクターの現在座標とループ回数が保存されている構造体のアドレス
 * @retval 
 */
static bool isEvent_variable(GameWrapper *const game, SDL_Rect *const point)
{
	uint8_t mapx = get_mapsize('w') - 1;
	uint8_t mapy = get_mapsize('h') - 1;
	uint8_t x = point->x >> MAPCHIP_SHIFT;
    uint8_t y = point->y >> MAPCHIP_SHIFT;

    if ((mapx <= x) || (mapy <= y) || (x == 0) || (y == 0))
    {
        return ON_DIRECT;
    }

    return NON_DIRECT;
}