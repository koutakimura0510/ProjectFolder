/*
 * マップ間移動のイベント発生時の処理関数を管理するファイル
 */
#include "../../wrapper/game_wrapper.h"


/*
 * ファイル内関数
 */
static void set_world_event(GameWrapper *const game);
static void set_submap_event(GameWrapper *const game);


/**
 * @brief  次のマップ動作に必要なデータの読み込み関数を管理
 * @note   
 * ワールドマップを含んだマップ間移動とBGMなどが変化しないマップ間移動では読み込みデータが異なるため、
 * 読み込み関数を分けて考える必要があった。
 * そのため、発生したイベントのタイプを判別するメンバを作成し発生イベントによって処理を分けることとした
 * 
 * @retval None
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
 *
 * @note データ操作は考えが複雑になりやすくするため気を付けること
 */
static void set_world_event(GameWrapper *const game)
{
	game->conf.event.type 		     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_EVENT_TYPE);
	game->conf.file.mapdata  	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_NEXT_FILE_MAPDATA_ID);
	game->conf.file.object   	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_NEXT_FILE_OBJECT_ID);
	game->conf.file.region   	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_NEXT_FILE_REGION_ID);
	game->conf.file.npc     	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_NEXT_FILE_NPC_ID);
	game->conf.file.mapchip  	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_NEXT_FILE_MAPCHIP_ID);
	game->conf.file.bgm      	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_NEXT_FILE_BGM_ID);
	game->conf.map.name    		     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_NEXT_MAP);
	game->conf.map.canpass_id	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_NEXT_MAP_CANPASS_ID);
	game->conf.map.obj_startid	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_NEXT_MAP_OBJECT_STARTID);
	game->conf.map.obj_endid	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_NEXT_MAP_OBJECT_ENDID);
	game->unit.pos.unitx    	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_UNITX) << MAPCHIP_SHIFT;
	game->unit.pos.unity    	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_UNITY) << MAPCHIP_SHIFT;
	game->unit.pos.fieldx   	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_FIELDX) << MAPCHIP_SHIFT;
	game->unit.pos.fieldy   	     = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_FIELDY) << MAPCHIP_SHIFT;
	game->unit.pos.animation_pixel_x = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_ANIME_PIXELX);
	game->unit.pos.animation_pixel_y = fetch_dram_db(game, MEMORY_MAP_ALL_ID, game->conf.event.try_mapname_id, TRY_MAP_MEMBER_ANIME_PIXELY);
	game->unit.pos.unitdir  	     = DIR_WAIT;
	game->unit.pos.anime_cnt	     = 0;
	game->unit.draw.workpos          = UNIT_WORK_TYPE_CENTER;
	game->unit.draw.cutpos           = UNIT_CUT_DOWN + game->unit.draw.chara_chipid;
	game->unit.draw.mapchip_id       = UNIT_WORK_TYPE_CENTER + game->unit.draw.cutpos;
}


/*
 * 同じサブマップ間移動時のデータ設定
 * 同一マップ内のアニメーション時は画像データの更新は行わずにマップデータのみ読み込みを行う
 * 移動先のマップデータの当たり判定を行うため、マップの番号とキャラクターの座標を更新する
 */
static void set_submap_event(GameWrapper *const game)
{
	game->conf.file.mapdata    = fetch_dram_db(game, MEMORY_BUILD_SUBMAP_ID, game->conf.event.id, BUILD_SUBMAP_MEMBER_NEXT_FILE_MAPDATA_ID);
	game->conf.file.object     = fetch_dram_db(game, MEMORY_BUILD_SUBMAP_ID, game->conf.event.id, BUILD_SUBMAP_MEMBER_NEXT_FILE_OBJECT_ID);
	game->conf.file.region     = fetch_dram_db(game, MEMORY_BUILD_SUBMAP_ID, game->conf.event.id, BUILD_SUBMAP_MEMBER_NEXT_FILE_REGION_ID);
	game->conf.file.npc        = fetch_dram_db(game, MEMORY_BUILD_SUBMAP_ID, game->conf.event.id, BUILD_SUBMAP_MEMBER_NEXT_FILE_NPC_ID);
	game->conf.map.name    	   = fetch_dram_db(game, MEMORY_BUILD_SUBMAP_ID, game->conf.event.id, BUILD_SUBMAP_MEMBER_NEXT_MAP);
	game->unit.pos.unitx       = fetch_dram_db(game, MEMORY_BUILD_SUBMAP_ID, game->conf.event.id, BUILD_SUBMAP_MEMBER_UNITX) << MAPCHIP_SHIFT;
	game->unit.pos.unity       = fetch_dram_db(game, MEMORY_BUILD_SUBMAP_ID, game->conf.event.id, BUILD_SUBMAP_MEMBER_UNITY) << MAPCHIP_SHIFT;
	game->unit.pos.fieldx      = fetch_dram_db(game, MEMORY_BUILD_SUBMAP_ID, game->conf.event.id, BUILD_SUBMAP_MEMBER_FIELDX) << MAPCHIP_SHIFT;
	game->unit.pos.fieldy      = fetch_dram_db(game, MEMORY_BUILD_SUBMAP_ID, game->conf.event.id, BUILD_SUBMAP_MEMBER_FIELDX) << MAPCHIP_SHIFT;
	game->unit.pos.unitdir     = DIR_WAIT;
	game->unit.pos.anime_cnt   = 0;
	game->unit.draw.workpos    = UNIT_WORK_TYPE_CENTER;
	game->unit.draw.cutpos     = UNIT_CUT_DOWN + game->unit.draw.chara_chipid;
	game->unit.draw.mapchip_id = UNIT_WORK_TYPE_CENTER + game->unit.draw.cutpos;
}
