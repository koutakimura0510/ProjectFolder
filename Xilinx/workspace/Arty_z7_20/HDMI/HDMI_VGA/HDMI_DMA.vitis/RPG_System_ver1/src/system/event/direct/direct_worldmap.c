/*
 * 当たり判定関数を管理するファイル
 */
#include "../../wrapper/game_wrapper.h"
#include "direct_worldmap_struct.h"

/*
 * ファイル内関数宣言
 */
static bool isDirect_gekai(GameWrapper *const game, const WorldWrapper *world);
static bool isDirect_tikai(GameWrapper *const game, const WorldWrapper *world);
static bool isDirect_tenkai(GameWrapper *const game, const WorldWrapper *world);
static bool isDirect_hazama(GameWrapper *const game, const WorldWrapper *world);
static bool isDirect_makai(GameWrapper *const game, const WorldWrapper *world);


/*
 * ワールドマップのデータベースから当たり判定座標を読み取り当たり判定を行う
 * キャラクターとデータベースのpixel座標が重なった場合にIDを取得する
 * ワールドマップに関連したマップ間移動の場合は、必ずデータの読み込みを行うため
 * 暗転モードのIDをsystem変数に設定する
 */
bool isDirect_worldmap(GameWrapper *const game)
{
    const WorldWrapper *world = &world_wrapper;
    bool direct;

    switch (game->conf.map.name)
    {
    case GEKAI_MAP_ID:
        direct = isDirect_gekai(game, world);
        break;

    case TIKAI_MAP_ID:
        direct = isDirect_tikai(game, world);
        break;

    case TENKAI_MAP_ID:
        direct = isDirect_tenkai(game, world);
        break;

    case HAZAMA_MAP_ID:
        direct = isDirect_hazama(game, world);
        break;

    case MAKAI_MAP_ID:
        direct = isDirect_makai(game, world);
        break;

    default :
        direct = NON_DIRECT;
        break;
    }

    if (direct == ON_DIRECT)
    {
        game->conf.display.system   = SYSTEM_MAP_DARKENING_WINDOW;
        game->conf.display.drawtype = DISPLAY_DARKENING_DRAW;
    }

    return direct;
}


/*
 * 下界の当たり判定を行う
 */
static bool isDirect_gekai(GameWrapper *const game, const WorldWrapper *world)
{
    uint32_t x = (game->unit.pos.unitx + game->unit.pos.fieldx);
    uint32_t y = (game->unit.pos.unity + game->unit.pos.fieldy);

    for (uint8_t i = 0; i < GEKAI_DIRECT_DB_SIZE; i++)
    {
        if ((x == ((uint32_t)world->gekai[i].direct_xpos << MAPCHIP_SHIFT)) && (y == ((uint32_t)world->gekai[i].direct_ypos << MAPCHIP_SHIFT)))
        {
            game->unit.pos.unitdir         = DIR_WAIT;
			game->unit.pos.anime_cnt       = 0;
            game->conf.event.id   = world->gekai[i].event_id;
            game->conf.event.type = world->gekai[i].event_type;
            return ON_DIRECT;
        }
    }

    return NON_DIRECT;
}

/*
 * 地界の当たり判定を行う
 */
static bool isDirect_tikai(GameWrapper *const game, const WorldWrapper *world)
{
    return NON_DIRECT;
}

/*
 * 天界の当たり判定を行う
 */
static bool isDirect_tenkai(GameWrapper *const game, const WorldWrapper *world)
{
    return NON_DIRECT;
}

/*
 * はざまの当たり判定を行う
 */
static bool isDirect_hazama(GameWrapper *const game, const WorldWrapper *world)
{
    return NON_DIRECT;
}

/*
 * 魔界の当たり判定を行う
 */
static bool isDirect_makai(GameWrapper *const game, const WorldWrapper *world)
{
    return NON_DIRECT;
}
