/*
 * Create 2021/07/23
 * Author kimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * IC
 * -
 * バトル構造体のソート関数をまとめたファイル
 */
#include "../../../wrapper/game_wrapper.h"
#include "../wrapper/local_share.h"


/* ファイル内関数 */
static void enemy_db_copy(GameWrapper *const game, uint8_t index);


/*
 * ver1. 2021/07/06
 * バトルのコンフィグエフェクト配列のソート処理
 * コマンド決定時から行動開始までの時間が短い順に並び替える
 * -
 * バブルソートのアルゴリズムを使用
 */
void battle_conf_sort(GameWrapper *const game)
{
    for(uint8_t i = 0; i < game->conf.battle.hero.counter; i++)
    {
        for(uint8_t j = i + 1; j < game->conf.battle.hero.counter; j++)
        {
            if((game->conf.battle.effect.wait_time[j] + game->conf.battle.effect.com_time[j]) < (game->conf.battle.effect.wait_time[i] + game->conf.battle.effect.com_time[i]))
            {
                bool     active     = game->conf.battle.effect.active[i];
                uint8_t  heroid     = game->conf.battle.effect.hero_id[i];
                uint8_t  eff_id     = game->conf.battle.effect.id[i];
                uint8_t  drawpos    = game->conf.battle.effect.cursol_enemy[i];
                uint8_t cursol_hero = game->conf.battle.effect.cursol_hero[i];
                uint32_t wait_t     = game->conf.battle.effect.wait_time[i];
                uint32_t com_t      = game->conf.battle.effect.com_time[i];
                uint32_t anime_sel  = game->conf.battle.effect.anime_select[i];

                game->conf.battle.effect.active[i]        = game->conf.battle.effect.active[j];
                game->conf.battle.effect.hero_id[i]       = game->conf.battle.effect.hero_id[j];
                game->conf.battle.effect.id[i]            = game->conf.battle.effect.id[j];
                game->conf.battle.effect.cursol_enemy[i]  = game->conf.battle.effect.cursol_enemy[j];
                game->conf.battle.effect.cursol_hero[i]   = game->conf.battle.effect.cursol_hero[j];
                game->conf.battle.effect.wait_time[i]     = game->conf.battle.effect.wait_time[j];
                game->conf.battle.effect.com_time[i]      = game->conf.battle.effect.com_time[j];
                game->conf.battle.effect.anime_select[i]  = game->conf.battle.effect.anime_select[j];
                game->conf.battle.effect.active[i]        = active;
                game->conf.battle.effect.hero_id[i]       = heroid;
                game->conf.battle.effect.id[i]            = eff_id;
                game->conf.battle.effect.cursol_enemy[i]  = drawpos;
                game->conf.battle.effect.cursol_hero[i]   = cursol_hero;
                game->conf.battle.effect.wait_time[i]     = wait_t;
                game->conf.battle.effect.com_time[i]      = com_t;
                game->conf.battle.effect.anime_select[i] = anime_sel;
            }
        }
    }
}

/*
 * ver1. 2021/07/06
 * バトルのコンフィグ配列のシフト動作
 * -
 * 行動順が速い仲間のIDが配列のインデックスの先頭に保存される
 * 行動順の先頭の仲間の行動が全て完了したら、二番目の行動順の仲間のデータを先頭にシフトさせる
 * 同じように三番目は二番目にシフト、四番目は三番目にシフトし、四番目を空きチャンネルの設定にする
 */
void battle_atb_shift(GameWrapper *const game, uint8_t pos)
{
    for (uint8_t i = pos; i < game->conf.battle.hero.counter - 1; i++)
    {
        game->conf.battle.trun.order[i] = game->conf.battle.trun.order[i + 1];
        game->conf.battle.trun.hero[i]  = game->conf.battle.trun.hero[i + 1];
    }
    
    game->conf.battle.trun.order[game->conf.battle.hero.counter - 1] = BATTLE_TRUN_ORDER_NOT;
}


/*
 * ver2. 2021/07/29
 * 行動終了した仲間がずっと攻撃を続けてしまうバグを修正
 * シフトをした後に行動処理メンバをfalseにしなければいけなかった
 * -
 * ver1. 2021/07/27
 * コンフィグのバトル用配列のシフト動作
 */
void battle_conf_shift(GameWrapper *const game, uint8_t pos)
{
    uint8_t count = game->conf.battle.hero.counter - 1;

	for (uint8_t j = pos; j < count; j++)
	{
		game->conf.battle.effect.active[j]      = game->conf.battle.effect.active[j + 1];
		game->conf.battle.effect.hero_id[j]     = game->conf.battle.effect.hero_id[j + 1];
		game->conf.battle.effect.id[j]          = game->conf.battle.effect.id[j + 1];
		game->conf.battle.effect.cursol_enemy[j]  = game->conf.battle.effect.cursol_enemy[j + 1];
		game->conf.battle.effect.cursol_hero[j] = game->conf.battle.effect.cursol_hero[j + 1];
		game->conf.battle.effect.wait_time[j]   = game->conf.battle.effect.wait_time[j + 1];
		game->conf.battle.effect.com_time[j]    = game->conf.battle.effect.com_time[j + 1];
		game->conf.battle.effect.anime_select[j]= game->conf.battle.effect.anime_select[j + 1];
	}

    game->conf.battle.effect.wait_time[count]   = MAX_32BIT;
    game->conf.battle.effect.com_time[count]    = MAX_32BIT;
	game->conf.battle.effect.active[count]      = BATTLE_ACTION_TIMER_OFF;
}


/*
 * ver1. 2021/07/27
 * 仲間が倒された場合に死亡した仲間IDと一致したインデックスのデータからソート処理を行う
 * 全体攻撃の場合、死体蹴りが可能なため既に死亡している仲間の場合処理を終える
 */
void battle_dying_sort(GameWrapper *const game, uint8_t hero_id)
{
    if (game->hero[hero_id].battle.arive == BATTLE_HERO_DEATH)
    {
        return;
    }

    game->hero[hero_id].status.enchant.atk          = 0;
    game->hero[hero_id].status.enchant.def          = 0;
    game->hero[hero_id].status.enchant.mag          = 0;
    game->hero[hero_id].status.enchant.res          = 0;
    game->hero[hero_id].status.enchant.agi          = 0;
    game->hero[hero_id].battle.arive                = BATTLE_HERO_DEATH;
    game->hero[hero_id].battle.condition            = 0;
    game->hero[hero_id].battle.atb_gauge            = 0;
    game->conf.battle.hero.old_anime_order[hero_id] = BATTLE_HERO_CHIP_DEATH_1;
    game->conf.battle.hero.number--;

    for (uint32_t i = 0; i < game->conf.battle.hero.counter; i++)
    {
        if (hero_id == game->conf.battle.trun.hero[i])
        {
            cmd_db_reset(game, COMMAND_BATTLE_SYSTEM, 0);
            battle_conf_shift(game, i);
            battle_atb_shift(game, i);
            break;
        }
    }
}


/*
 * ver1. 2021/08/02
 * エネミーデータのシフト処理
 * 
 * pos インデックス開始位置
 */
void battle_enemy_shift(GameWrapper *const game, uint8_t pos)
{
    uint8_t max_count = game->conf.battle.enemy.counter - 1;
    uint8_t id        = game->enemy[pos].id;
    uint32_t draw_pos = game->enemy[pos].draw_pos;

    for (uint8_t j = pos; j < max_count; j++)
    {
        enemy_conf_shift(game, j);
        enemy_db_copy(game, j);
    }

    game->enemy[max_count].id       = id;
    game->enemy[max_count].draw_pos = draw_pos;
    game->enemy[max_count].join     = false;
    game->enemy[max_count].down_on  = true;
    game->enemy[max_count].alpha    = COLOR_ALPHA_MAX;
    game->enemy[max_count].atb_gauge = 0;
    game->conf.battle.enemy.trun_order[max_count] = BATTLE_TRUN_ORDER_NOT;
    game->conf.battle.enemy.number--;
}


/*
 * ver1. 2021/08/02
 * コンフィグのエネミーデータのシフト処理
 */
void enemy_conf_shift(GameWrapper *const game, uint8_t pos)
{
    game->conf.battle.enemy.effect_id[pos]  = game->conf.battle.enemy.effect_id[pos+1];
    game->conf.battle.enemy.sort_order[pos] = game->conf.battle.enemy.sort_order[pos+1];
    game->conf.battle.enemy.trun_order[pos] = game->conf.battle.enemy.trun_order[pos+1];
}


/*
 * ver1. 2021/08/02
 * エネミー構造体の一括コピー処理
 */
static void enemy_db_copy(GameWrapper *const game, uint8_t index)
{
//    game->enemy[index] = game->enemy[index + 1];
    game->enemy[index].id        = game->enemy[index+1].id;
    game->enemy[index].hp        = game->enemy[index+1].hp;
    game->enemy[index].damege    = game->enemy[index+1].damege;
    game->enemy[index].atb_gauge = game->enemy[index+1].atb_gauge-1;
    game->enemy[index].atb_timer = game->enemy[index+1].atb_timer;
    game->enemy[index].enchant   = game->enemy[index+1].enchant;
    game->enemy[index].condition = game->enemy[index+1].condition;
    game->enemy[index].draw_pos  = game->enemy[index+1].draw_pos;
    game->enemy[index].draw_xpos = game->enemy[index+1].draw_xpos;
    game->enemy[index].draw_ypos = game->enemy[index+1].draw_ypos;
    game->enemy[index].join      = game->enemy[index+1].join;
    game->enemy[index].down_on   = game->enemy[index+1].down_on;
    game->conf.battle.enemy.trun_order[index] = BATTLE_TRUN_ORDER_NOT;
}
