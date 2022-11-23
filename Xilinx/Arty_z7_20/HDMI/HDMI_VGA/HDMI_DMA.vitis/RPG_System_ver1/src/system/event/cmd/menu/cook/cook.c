/*
 * Create 2021/08/15
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
 * メニュー操作時のコマンド入力確定時の操作関数を管理するファイル
 */
#include "../local_share.h"


/*
 * ver1. 2021/08/21
 * 料理メニューのキー操作処理
 */
void cook_key(GameWrapper *const game, SDL_Key *const key)
{
    switch (key->bit & (SW_UP | SW_DOWN))
    {
    case SW_UP:
        min_sub(game->cmd.cursol.y, 0);
        game->cmd.sub_system = COMMAND_SUB;
        break;

    case SW_DOWN:
        max_add(game->cmd.cursol.y, game->cmd.cursol.yend);
        game->cmd.sub_system = COMMAND_SUB;
		break;

	default:
        break;
    }
}


/*
 * ver1. 2021/08/25
 * 料理の熟練度のレベルアップ処理
 * 指定回数料理を作る、または失敗時に熟練度を上げる
 */
void cook_levelup(GameWrapper *const game)
{
    if (game->conf.cook.level[game->cmd.cursol.y] == COOK_LEVEL_MAX)
    {
        return;
    }

    game->conf.cook.count[game->cmd.cursol.y]++;

    if ((game->cmd.sub_system == COMMAND_SUB_COOK_FAILURE) || (game->conf.cook.count[game->cmd.cursol.y] == fetch_dram_db(game, MEMORY_COOK_ID, game->conf.cook.master[game->cmd.cursol.y], COOK_SUB_MEMBER_SKILL_LEVEL)))
    {
        game->conf.cook.level[game->cmd.cursol.y]++;
        game->conf.cook.count[game->cmd.cursol.y] = 0;
    }
}


/**
 * @brief   料理の効果を反映する
 * @ingroup menu cook
 *
 * @note 
 *
 * @version 1.0 2021/08/29
 */
void cook_reflect(GameWrapper *const game)
{
    int32_t power    = fetch_dram_db(game, MEMORY_COOK_ID, game->conf.cook.master[game->cmd.cursol.y], COOK_SUB_MEMBER_POWER);
    uint8_t use_type = fetch_dram_db(game, MEMORY_COOK_ID, game->conf.cook.master[game->cmd.cursol.y], COOK_SUB_MEMBER_USE_TYPE);

    for (uint8_t i = 0; i < game->conf.system.paty_member; i++)
    {
        switch (use_type)
        {
        case COOK_TYPE_HEEL:
            hero_damege_cure(game, game->conf.battle.hero.sort_order[i], power);
            break;

        case COOK_TYPE_RATIO:
            hero_damege_cure(game, game->conf.battle.hero.sort_order[i], fix_num(game->hero[game->conf.battle.hero.sort_order[i]].status.hp, power));
            break;

        case COOK_TYPE_SP:
            hero_sp_cure(game, game->conf.battle.hero.sort_order[i], fix_num(game->hero[game->conf.battle.hero.sort_order[i]].status.sp, power));
            break;

        case COOK_TYPE_ALIVE:
            hero_alive_cure(game, game->conf.battle.hero.sort_order[i], fix_num(game->hero[game->conf.battle.hero.sort_order[i]].status.hp, power));
            break;

        case COOK_TYPE_HEEL_ALIVE:
            hero_damege_cure(game, game->conf.battle.hero.sort_order[i], fix_num(game->hero[game->conf.battle.hero.sort_order[i]].status.hp, power));
            hero_alive_cure(game, game->conf.battle.hero.sort_order[i], fix_num(game->hero[game->conf.battle.hero.sort_order[i]].status.hp, power));
            break;

        case COOK_TYPE_HEEL_SP:
            hero_damege_cure(game, game->conf.battle.hero.sort_order[i], fix_num(game->hero[game->conf.battle.hero.sort_order[i]].status.hp, power));
            hero_sp_cure(game, game->conf.battle.hero.sort_order[i], fix_num(game->hero[game->conf.battle.hero.sort_order[i]].status.sp, power));
            break;

        case COOK_TYPE_HEEL_SP_ALIVE:
            hero_damege_cure(game, game->conf.battle.hero.sort_order[i], fix_num(game->hero[game->conf.battle.hero.sort_order[i]].status.hp, power));
            hero_alive_cure(game, game->conf.battle.hero.sort_order[i], fix_num(game->hero[game->conf.battle.hero.sort_order[i]].status.hp, power));
            hero_sp_cure(game, game->conf.battle.hero.sort_order[i], fix_num(game->hero[game->conf.battle.hero.sort_order[i]].status.sp, power));
            break;

        default:
            break;
        }
    }
}
