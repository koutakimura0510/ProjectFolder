/*
 * Create 2021/07/01
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * IC      XC7Z020-1CLG400C
 * ROM     256KB
 * RAM     512KB
 * L1Cache 32KB
 * -
 * コマンド入力の操作関数を管理するファイル
 */
#include "../../wrapper/game_wrapper.h"


/*
 * ver1. 2021/08/12
 * 仲間の隊列の変更を行う
 * 
 * hero_origin      入れ替え先の隊列番号
 * hero_exchange    入れ替え元の隊列番号
 */
void hero_formation_swap(GameWrapper *game, uint8_t hero_origin, uint8_t hero_exchange)
{
    for (uint8_t i = 0; i < game->conf.system.paty_member; i++)
    {
        if (hero_origin == game->conf.battle.hero.sort_order[i])
        {
            game->conf.battle.hero.sort_order[i] = game->conf.battle.hero.sort_order[hero_exchange];
            game->conf.battle.hero.sort_order[hero_exchange] = hero_origin;
            break;
        }
    }

    // game->hero_
    // game->hero[HERO_NUMBER]   = game->hero[hero_origin];
    // game->hero[hero_origin]   = game->hero[hero_exchange];
    // game->hero[hero_exchange] = game->hero[HERO_NUMBER];
}

