/*
 * マップ間移動のイベント発生時の処理関数を管理するファイル
 */
#include "../../wrapper/game_wrapper.h"
#include "event_map_move_struct.h"


/*
 * ファイル内関数
 */
static void set_world_event(GameWrapper *const game);
static void set_submap_event(GameWrapper *const game);


/*
 * 次のマップ情報の読み込み関数イベントを管理
 */
void next_stage_update(GameWrapper *const game)
{
	switch (game->conf.event.type)
	{
	case EVENT_TYPE_WORLD_STATE_OTHER_MAP:
		set_world_event(game);
		break;

	case EVENT_TYPE_SAMEMAP_MOVE:
		set_submap_event(game);
		break;

	default:
		break;
	}
}


/*!
 * @brief   ワールドマップに関するマップ間移動処理の暗転描画が終了したときに、次のマップ動作に必要なデータを読み込む
 * @ingroup world_event
 *
 * @note データ操作は考えが複雑になりやすくするため気を付けること
 *
 * @param ラッパー構造体のアドレス
 * @version 1.0 2021/08/27
 */
static void set_world_event(GameWrapper *const game)
{
	const WorldEvent *event = world_event;

	for (uint8_t i = 0; i < EVENT_WORLD_DB_SIZE; i++, event++)
	{
		if (game->conf.event.id == event->event_id)
		{
			game->conf.event.type 		= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_EVENT_TYPE);
			game->conf.file.mapdata  	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_NEXT_FILE_MAPDATA_ID);
			game->conf.file.object   	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_NEXT_FILE_OBJECT_ID);
			game->conf.file.region   	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_NEXT_FILE_REGION_ID);
			game->conf.file.npc     	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_NEXT_FILE_NPC_ID);
			game->conf.file.mapchip  	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_NEXT_FILE_MAPCHIP_ID);
			game->conf.file.bgm      	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_NEXT_FILE_BGM_ID);
			game->conf.map.name    		= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_NEXT_MAP);
			game->conf.map.canpass_id	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_NEXT_MAP_CANPASS_ID);
			game->conf.map.obj_startid	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_NEXT_MAP_OBJECT_STARTID);
			game->conf.map.obj_endid	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_NEXT_MAP_OBJECT_ENDID);
			game->unit.pos.unitx    	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_UNITX) << MAPCHIP_SHIFT;
			game->unit.pos.unity    	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_UNITY) << MAPCHIP_SHIFT;
			game->unit.pos.fieldx   	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_FIELDX) << MAPCHIP_SHIFT;
			game->unit.pos.fieldy   	= fetch_dram_db(game, MEMORY_MAP_ALL_ID, next_mapname_id, TRY_MAP_MEMBER_FIELDY) << MAPCHIP_SHIFT;
			game->unit.pos.unitdir  	= DIR_WAIT;
			game->unit.pos.anime_cnt	= 0;
			break;
		}
	}
}


/*
 * 同じサブマップ間移動時のデータ設定
 * 同一マップ内のアニメーション時は画像データの更新は行わずにマップデータのみ読み込みを行う
 * 移動先のマップデータの当たり判定を行うため、マップの番号とキャラクターの座標を更新する
 */
static void set_submap_event(GameWrapper *const game)
{
	const SubmapMove *event = submap_move;

	for (uint8_t i = 0; i < EVENT_SUBMAP_MOVE_DB_SIZE; i++, event++)
	{
		if (event->event_id == game->conf.event.id)
		{
			game->conf.file.mapdata  = event->next_file_mapdata_id;
			game->conf.file.object   = event->next_file_object_id;
			game->conf.map.name    	 = event->next_map;
			game->unit.pos.unitx     = (uint32_t)event->unitx  << MAPCHIP_SHIFT;
			game->unit.pos.unity     = (uint32_t)event->unity  << MAPCHIP_SHIFT;
			game->unit.pos.fieldx    = (uint32_t)event->fieldx << MAPCHIP_SHIFT;
			game->unit.pos.fieldy    = (uint32_t)event->fieldy << MAPCHIP_SHIFT;
			game->unit.pos.unitdir   = DIR_WAIT;
			game->unit.pos.anime_cnt = 0;
			break;
		}
	}
}
