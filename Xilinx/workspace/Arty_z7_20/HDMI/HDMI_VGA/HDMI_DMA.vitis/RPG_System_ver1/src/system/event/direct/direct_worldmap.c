/*
 * 当たり判定関数を管理するファイル
 */
#include "../../wrapper/game_wrapper.h"


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
bool isDirect_worldmap(GameWrapper *const game)
{
    uint32_t x           = (game->unit.pos.unitx + game->unit.pos.fieldx);
    uint32_t y           = (game->unit.pos.unity + game->unit.pos.fieldy);
    uint8_t db_start_row = fetch_dram_db(game, MEMORY_BUILD_LOOP_ID, game->conf.map.name, BUILD_LOOPCOUNT_MEMBER_START_ID);
    uint8_t db_end_row   = fetch_dram_db(game, MEMORY_BUILD_LOOP_ID, game->conf.map.name, BUILD_LOOPCOUNT_MEMBER_LOOP_COUNT);

    for (uint8_t i = db_start_row; i < db_end_row; i++)
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