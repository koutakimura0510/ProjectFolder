/*
 * 当たり判定関数を管理するファイル
 */
#include "../../wrapper/game_wrapper.h"
#define POS_DEBUG

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
