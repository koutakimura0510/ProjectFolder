/*
 * Create 2021/07/27
 * Author kimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * IC
 * -
 * 戦闘の状況に応じてアニメーションの状態遷移を管理するファイル
 */
#include "../../../wrapper/game_wrapper.h"
#include "../wrapper/local_share.h"
#include "action_struct.h"

#ifdef MYDEBUG
#include "xil_printf.h"
#endif


/*
 * ver1. 2021/07/21
 * 仲間と敵の行動確定時の行動処理を行う状態遷移関数
 */
void battle_action_state(GameWrapper *const game)
{
    const BattleAnimation *p = battle_animation;

    for (uint8_t i = 0; i < BATTLE_ANIMATION_DB_SIZE; i++, p++)
    {
        if (game->conf.battle.state.module == p->system)
        {
            p->animation_state(game);
            break;
        }
    }
}


/*
 * ver2. 2021/07/30
 * 敵の攻撃の状態を追加
 * 敵と仲間の行動順が同時にたまった時は、仲間の方を早く動かすようにする
 * 
 * ver1. 2021/07/27
 * 勝利、敗北、逃走、通常を判断し対応した状態遷移の処理に移る
 */
static void battle_module_wrapper(GameWrapper *const game)
{
    victory_timer_set(game);
    hero_action_timer(game);
    enemy_attack_state(game);
}


/*
 * ver3. 2021/08/02
 * 行動終了と行動開始の間隔が早く感じたためキャラクターの行動時に空き時間を設けた
 * 
 * ver1. 2021/07/30
 * エネミーの攻撃処理
 * -
 * 敵からの攻撃を受けた場合、てきのわざの範囲と指定箇所は敵のアニメーションの状態遷移が終了するまで変わらないため
 * 最初の状態遷移でループ回数と座標参照用のメンバ変数の設定を行う
 * -
 * E_SINGLE 単体わざ、コマンド入力したカーソルーの位置に1回ループ処理を行う
 * E_ALL    全体わざ、仲間の人数分ループ処理を行う
 */
static void enemy_attack_state(GameWrapper *const game)
{
    static uint32_t t = 0;

    if (BATTLE_TRUN_ORDER_CAN != game->conf.battle.enemy.trun_order[0])
    {
        return;
    }

    if (BATTLE_NORMAL_STATE_DEFAULT != game->conf.battle.state.module)
    {
        return;
    }

    if (false == tmr_constant(&t, TM_3SEC_COUNT))
    {
        return;
    }

    uint8_t range = fetch_dram_db(game, MEMORY_MAGIC_ID, game->conf.battle.enemy.effect_id[0], MAGIC_SUB_MEMBER_RANGE);
    game->conf.battle.loop.counter = (E_SINGLE == range) ? 1 : game->conf.battle.hero.counter;
    game->conf.battle.loop.cursol  = (E_SINGLE == range) ? game->enemy[game->conf.battle.enemy.sort_order[0]].target_hero : 0;
    game->conf.display.uncommon_window = UNCOMMON_WINDOW_ENEMY_SKILL;

    switch (fetch_dram_db(game, MEMORY_MAGIC_ID, game->conf.battle.enemy.effect_id[0], MAGIC_SUB_MEMBER_TYPE))
    {
    case COMMAND_BATTLE_ATTACK_UNIT:
        game->conf.battle.state.module = BATTLE_ENEMY_STATE_ENEMY_MOVE;
        break;

    case COMMAND_BATTLE_MAGIC_UNIT:
        game->conf.battle.state.module = BATTLE_ENEMY_STATE_MAGIC_EFFECT;
        break;

    case COMMAND_BATTLE_MAGIC_ENEMY:
        game->conf.battle.state.module = BATTLE_ENEMY_STATE_MAGIC_EFFECT;
        break;

    default:
        break;
    }

    t = get_time();
    // bgm_update(game, SOUND_ID_BATTLE_SPEAR, SOUND_CH_EFFECT1_WORK);
}


/*
 * ver1. 2021/08/02
 * エネミーの攻撃モーションアニメーション
 * 
 * No. BATTLE_ENEMY_STATE_ENEMY_MOVE
 */
static void enemy_animation_state(GameWrapper *const game)
{
    if (false == tmr_constant(&game->conf.battle.state.timer, TM_300US_COUNT))
    {
        return;
    }

    game->conf.battle.state.timer = get_time();

    switch (game->conf.battle.motion_update[0])
    {
    case ANIME_CHANGE_MOTION_1:
        game->enemy[game->conf.battle.enemy.sort_order[0]].adjust_pos += BATTLE_ENEMY_ANIME_SPEED;
        game->conf.battle.motion_update[0] = game->enemy[game->conf.battle.enemy.sort_order[0]].adjust_pos >> 4; // 16になったら1にする
        break;

    case ANIME_CHANGE_MOTION_2:
        game->enemy[game->conf.battle.enemy.sort_order[0]].adjust_pos -= BATTLE_ENEMY_ANIME_SPEED;
        break;
    
    default:
        break;
    }

    if (game->enemy[game->conf.battle.enemy.sort_order[0]].adjust_pos == 0)
    {
        game->conf.battle.motion_update[0] = ANIME_CHANGE_MOTION_1;
        game->conf.battle.state.module = BATTLE_ENEMY_STATE_CHIP;
    }
}


/*
 * ver1. 2021/07/22
 *
 * 使用するわざが魔法系統の場合は、ポージングしている仲間の座標に魔法発動のエフェクトを描画する
 * -
 * 1.移動後のx座標を含んだ自身の座標を取得
 * 2.自身の画像の横サイズと、魔法陣画像データの横サイズを計算し、描画座標が中央になるように計算
 * 3.x軸と同じようにy軸の座標調整
 * 
 * No. BATTLE_ENEMY_STATE_MAGIC_EFFECT
 */
static void enemy_magic_activate(GameWrapper *const game)
{
    SDL_Rect rect;

    uint8_t anime_id = fetch_dram_db(game, MEMORY_MAGIC_ID, E_MAGIC_ACTIVE, MAGIC_SUB_MEMBER_ANIME);

    rect.w = W_CENTER(fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[game->conf.battle.enemy.sort_order[0]].id, ENEMY_SUB_MEMBER_PARA_WIDTH));
    rect.h = H_CENTER(fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[game->conf.battle.enemy.sort_order[0]].id, ENEMY_SUB_MEMBER_PARA_HEIGHT));
    rect.x = W_CENTER(fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, anime_id, ANIME_SUB_MEMBER_MAGIC_XSIZE));
    rect.y = H_CENTER(fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, anime_id, ANIME_SUB_MEMBER_MAGIC_YSIZE));
    animation_effect_draw(game, anime_id, game->enemy[game->conf.battle.enemy.sort_order[0]].draw_pos + rect.w + rect.h - rect.y - rect.x);

    if (true == tmr_constant(&game->conf.battle.effect.update_time, fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, anime_id, ANIME_SUB_MEMBER_MAGIC_ANIME_TIME)))
    {
        game->conf.battle.effect.update_time = get_time();
        animation_effect_update(game, anime_id, BATTLE_ENEMY_STATE_MAGIC_POS);
    }
}


/*
 * ver3. 2021/08/02
 * 召喚系の処理を追加するため、追加しやすいswitch-case文に変更した
 * 
 * ver2. 2021/07/29
 * わざが単体と全体の範囲があるためエフェクト描画時に描画座標を計算するように変更した
 * -
 * ver1. 2021/07/22
 * エフェクト描画の関数を管理
 * 
 * No. BATTLE_ENEMY_STATE_MAGIC_POS
 */
static void enemy_magic_draw(GameWrapper *const game)
{
    StatusRef ref;
    status_ref_update(game, &ref, MEMORY_MAGIC_ID, game->conf.battle.enemy.effect_id[0]);

    switch (ref.type)
    {
    case COMMAND_BATTLE_MAGIC_UNIT:
        enemy_hero_magic_draw(game, &ref);
        break;

    case COMMAND_BATTLE_MAGIC_ENEMY:
        enemy_paty_magic_draw(game, &ref);
        break;

    default:
        break;
    }

    if (true == tmr_constant(&game->conf.battle.effect.update_time, fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, ref.anime_id, ANIME_SUB_MEMBER_MAGIC_ANIME_TIME)))
    {
        game->conf.battle.effect.update_time = get_time();
        animation_effect_update(game, ref.anime_id, BATTLE_ENEMY_STATE_CHIP);
    }
}


/*
 * ver2. 2021/08/10
 * 敵の魔法発動後にマップチップデータのバグがでたので修正した
 * 魔法発動時にold_anime_orderに現在のマップチップデータを保存しておかなければいけなかった
 *
 * ver1. 2021/07/30
 * 敵からの受けた攻撃によって仲間の状態を変更する
 * 
 * No. BATTLE_ENEMY_STATE_CHIP
 */
static void hero_damege_chip_state(GameWrapper *const game)
{
    StatusRef ref;

    status_ref_update(game, &ref, MEMORY_MAGIC_ID, game->conf.battle.enemy.effect_id[0]);

    for (uint8_t i = 0; i < game->conf.battle.loop.counter; i++)
    {
        uint8_t hero_id = game->conf.battle.hero.sort_order[game->conf.battle.loop.cursol + i];
        game->conf.battle.hero.old_anime_order[hero_id] = game->conf.battle.hero.anime_order[hero_id];
    }

    switch (fetch_dram_db(game, MEMORY_MAGIC_ID, game->conf.battle.enemy.effect_id[0], MAGIC_SUB_MEMBER_POWER))
    {
    case SKILL_DAMEGE_POWER_NON:
        status_conf_update(game, &ref);
        game->conf.battle.state.module = BATTLE_ENEMY_STATE_RESULT;
        break;

    default:
        for (uint8_t i = 0; i < game->conf.battle.loop.counter; i++)
        {
            game->conf.battle.hero.anime_order[game->conf.battle.hero.sort_order[game->conf.battle.loop.cursol + i]] = BATTLE_HERO_CHIP_DAMAGE;
        }
        game->conf.battle.state.module = BATTLE_ENEMY_STATE_ANIME;
        break;
    }

    if (COMMAND_BATTLE_ATTACK_UNIT == ref.type)
    {
        bgm_update(game, SOUND_ID_BATTLE_DAMEGE, SOUND_CH_EFFECT1_WORK);
    }
}


/*
 * ver1. 2021/07/30
 * 仲間のダメージを受けた時の座標更新処理
 * 
 * No. BATTLE_ENEMY_STATE_ANIME
 */
static void hero_damege_animation_state(GameWrapper *const game)
{
    if (false == tmr_constant(&game->conf.battle.state.timer, TM_300US_COUNT))
    {
        return;
    }
    
    game->conf.battle.state.timer = get_time();

    for (uint8_t i = 0; i < game->conf.battle.loop.counter; i++)
    {
        uint8_t hero_id = game->conf.battle.hero.sort_order[game->conf.battle.loop.cursol + i];

        switch (game->conf.battle.motion_update[hero_id])
        {
        case ANIME_CHANGE_MOTION_1:
            game->hero[hero_id].battle.draw_xpos += BATTLE_DAMEGE_ANIME_SPEED;
            game->conf.battle.motion_update[hero_id] = game->hero[hero_id].battle.draw_xpos >> 4; // 16になったら1にする
            break;

        case ANIME_CHANGE_MOTION_2:
            game->hero[hero_id].battle.draw_xpos -= BATTLE_DAMEGE_ANIME_SPEED;
            break;
        
        default:
            break;
        }

        if (game->hero[hero_id].battle.draw_xpos == 0)
        {
            game->conf.battle.motion_update[hero_id] = ANIME_CHANGE_MOTION_1;
            game->conf.battle.state.module = BATTLE_ENEMY_STATE_CALC;
        }
    }
}


/*
 * ver1. 2021/07/31
 * 仲間のダメージ計算処理を管理
 * 
 * No. BATTLE_ENEMY_STATE_CALC
 */
static void hero_damege_calc_state(GameWrapper *const game)
{
    select_unit_calc(game, fetch_dram_db(game, MEMORY_MAGIC_ID, game->conf.battle.enemy.effect_id[0], MAGIC_SUB_MEMBER_TYPE));
    font_animetion_memba_update(game);
    game->conf.battle.state.module = BATTLE_ENEMY_STATE_DAMEGE;
}


/*
 * ver1. 2021/07/30
 * 仲間のダメージ描画アニメーション
 * 
 * No. BATTLE_ENEMY_STATE_DAMEGE
 */
static void hero_damege_draw_state(GameWrapper *const game)
{
    battle_font_animation_update(game, BATTLE_ENEMY_STATE_RESULT);
    select_unit_damege_draw(game, COMMAND_BATTLE_ATTACK_UNIT, 0);
}


/*
 * ver1. 2021/07/30
 * エネミーの攻撃終了時のエネミーメンバソートと仲間の死亡処理
 * 
 * No. BATTLE_ENEMY_STATE_RESULT
 */
static void enemy_result_sort_state(GameWrapper *const game)
{
    uint8_t enemy_count = game->conf.battle.enemy.number - 1;

    game->enemy[game->conf.battle.enemy.sort_order[0]].atb_gauge = 0;

    for (uint8_t i = 0; i < enemy_count; i++)
    {
        enemy_conf_shift(game, i);
    }

    for (uint8_t i = 0; i < game->conf.battle.loop.counter; i++)
    {
        uint8_t hero_id = game->conf.battle.hero.sort_order[game->conf.battle.loop.cursol + i];

        if (true == isHeroActivate(game->conf.battle.hero.old_anime_order[hero_id]))
        {
            game->conf.battle.hero.anime_order[hero_id] = odd_hp_mapchip(game, hero_id);
        }
        else
        {
            game->conf.battle.hero.anime_order[hero_id] = game->conf.battle.hero.old_anime_order[hero_id];
        }
    }

    if (game->conf.battle.hero.number == 0)
    {
        game->conf.battle.state.victory = BATTLE_GAME_DEATH;
    }

    game->conf.display.uncommon_window = UNCOMMON_WINDOW_OFF;
    game->conf.battle.enemy.trun_order[enemy_count] = BATTLE_TRUN_ORDER_NOT;
    game->conf.battle.state.module = BATTLE_NORMAL_STATE_DEFAULT;
}



/*
 * ver2. 2021/08/12
 * 逃走、入れ替え処理追加
 *
 * ver1. 2021/07/21
 * コマンド確定時にタイマーの計測を開始し、規定時間経過後にアニメーションの状態遷移を開始する
 */
static void hero_action_timer(GameWrapper *const game)
{
    if (BATTLE_NORMAL_STATE_DEFAULT != game->conf.battle.state.module)
    {
        return;
    }

    if (BATTLE_ACTION_TIMER_OFF == game->conf.battle.effect.active[0])
    {
        return;
    }

    if (false == tmr_constant(&game->conf.battle.effect.com_time[0], game->conf.battle.effect.wait_time[0]))
    {
        return;
    }

    if (game->conf.battle.effect.anime_select[0] == COMMAND_ANIME_MAGIC)
    {
        game->conf.display.uncommon_window = UNCOMMON_WINDOW_HERO_SKILL;
    }

    switch (game->conf.battle.effect.anime_select[0])
    {
    case COMMAND_ANIME_ESCAPE:
        if (true == isEscape())
        {
            game->conf.battle.state.victory = BATTLE_GAME_ESCAPE;
        }
        game->conf.battle.state.module = BATTLE_NORMAL_STATE_FINISH;
        break;

    case COMMAND_ANIME_SWAP:
        game->conf.animation.count     = SWAP_ANIME_LOOP_SET;
        game->conf.battle.state.module = BATTLE_NORMAL_STATE_SWAP_WALK;
        break;

    default:
        game->conf.battle.state.module = BATTLE_NORMAL_STATE_ADVANCE_WALK;
        break;
    }
}


/*
 * ver1. 2021/08/12
 * 入れ替え時のアニメーション状態
 * 
 * No BATTLE_NORMAL_STATE_SWAP_WALK
 */
static void hero_swap_action(GameWrapper *const game)
{
    if (false == tmr_constant(&game->conf.battle.state.timer, SWAP_ACTION_SPEED))
    {
        return;
    }

    if (game->conf.animation.count == SWAP_ANIME_LOOP_COUNT)
    {
        uint8_t swap_hero = game->conf.battle.hero.sort_order[game->conf.battle.effect.cursol_hero[0] + game->conf.battle.hero.counter];
        game->hero[swap_hero].battle.draw_pos  = game->hero[game->conf.battle.effect.hero_id[0]].battle.draw_pos;
        game->hero[swap_hero].battle.draw_xpos = game->hero[game->conf.battle.effect.hero_id[0]].battle.draw_xpos;
        game->hero[swap_hero].battle.draw_ypos = game->hero[game->conf.battle.effect.hero_id[0]].battle.draw_ypos;
        game->conf.battle.state.module = BATTLE_NORMAL_STATE_SWAP_SORT;
        game->conf.animation.count     = SWAP_ANIME_LOOP_SET;
        return;
    }

    switch (game->conf.battle.motion_update[game->conf.battle.effect.hero_id[0]])
    {
    case ANIME_CHANGE_MOTION_1:
        game->conf.battle.hero.anime_order[game->conf.battle.effect.hero_id[0]] = BATTLE_HERO_CHIP_ACTION;
        game->conf.battle.motion_update[game->conf.battle.effect.hero_id[0]]    = ANIME_CHANGE_MOTION_2;
        break;

    case ANIME_CHANGE_MOTION_2:
        game->conf.battle.hero.anime_order[game->conf.battle.effect.hero_id[0]] = BATTLE_HERO_CHIP_STAND;
        game->conf.battle.motion_update[game->conf.battle.effect.hero_id[0]] = ANIME_CHANGE_MOTION_1;
        game->conf.animation.count++;
        break;
    
    default:
        break;
    }

    game->conf.battle.state.timer = get_time();
}


/*
 * ver1. 2021/08/12
 * 入れ替えコマンド時の隊列入れ替え処理
 * 
 * No BATTLE_NORMAL_STATE_SWAP_SORT
 */
static void hero_swap_sort(GameWrapper *const game)
{
    hero_formation_swap(game, game->conf.battle.effect.hero_id[0], game->conf.battle.effect.cursol_hero[0] + game->conf.battle.hero.counter);
    game->conf.battle.state.module = BATTLE_NORMAL_STATE_FINISH;
}


/*
 * ver1. 2021/07/22
 * 行動決定時の待機時間完了後に前方に進むアニメーションを描画する
 * 
 * No. BATTLE_NORMAL_STATE_ADVANCE_WALK
 */
static void hero_advance_walk(GameWrapper *const game)
{
    if (false == tmr_constant(&game->conf.battle.state.timer, TM_300US_COUNT))
    {
        return;
    }

    game->conf.battle.state.timer = get_time();
    game->hero[game->conf.battle.effect.hero_id[0]].battle.draw_xpos -= BATTLE_NORMAL_ANIME_SPEED;

    if (game->hero[game->conf.battle.effect.hero_id[0]].battle.draw_xpos < -SIZE_UNIT_BATTLE_WIDTH_HALF)
    {
        game->conf.battle.hero.anime_order[game->conf.battle.effect.hero_id[0]] = BATTLE_HERO_CHIP_STAND;
    }
    else
    {
        game->conf.battle.hero.anime_order[game->conf.battle.effect.hero_id[0]] = BATTLE_HERO_CHIP_RIGHT;
    }

    if (game->hero[game->conf.battle.effect.hero_id[0]].battle.draw_xpos < -SIZE_UNIT_BATTLE_WIDTH)
    {
        game->conf.battle.state.module = BATTLE_NORMAL_STATE_PAUSE;
    }
}


/*
 * ver1. 2021/07/22
 * 移動完了時にアニメーションの画像データに切り替えを行い
 * 選択したわざが物理攻撃ならば魔法陣発動エフェクトの状態には行かずにモーションエフェクト描画に移行する
 * 
 * No. BATTLE_NORMAL_STATE_PAUSE
 */
static void hero_stand_pause(GameWrapper *const game)
{
    game->conf.battle.hero.anime_order[game->conf.battle.effect.hero_id[0]] = BATTLE_HERO_CHIP_ACTION;

    switch (game->conf.battle.effect.anime_select[0])
    {
    case COMMAND_ANIME_ITEM:
        game->conf.battle.state.module = BATTLE_NORMAL_STATE_ITEM_DRAW;
        break;

    case COMMAND_ANIME_MAGIC:
        if (COMMAND_BATTLE_ATTACK_ENEMY == fetch_dram_db(game, MEMORY_MAGIC_ID, game->conf.battle.effect.id[0], MAGIC_SUB_MEMBER_TYPE))
        {
            game->conf.battle.state.module = BATTLE_NORMAL_STATE_MAGIC_POS;
        }
        else
        {
            game->conf.battle.state.module = BATTLE_NORMAL_STATE_MAGIC_EFFECT;
        }
        break;

    default:
        game->conf.battle.state.module = BATTLE_NORMAL_STATE_MAGIC_EFFECT;
        break;
    }
}


/*
 * ver1. 2021/07/22
 * 使用するわざが魔法系統の場合は、ポージングしている仲間の座標に魔法発動のエフェクトを描画する
 * -
 * 1.移動後のx座標を含んだ自身の座標を取得
 * 2.自身の画像の横サイズと、魔法陣画像データの横サイズを計算し、描画座標が中央になるように計算
 * 3.x軸と同じようにy軸の座標調整
 * 
 * No. BATTLE_NORMAL_STATE_MAGIC_EFFECT
 */
static void magic_activate_draw(GameWrapper *const game)
{
    SDL_Rect rect;

    uint8_t anime_id  = fetch_dram_db(game, MEMORY_MAGIC_ID, E_MAGIC_ACTIVE, MAGIC_SUB_MEMBER_ANIME);
    rect.w = game->hero[game->conf.battle.effect.hero_id[0]].battle.draw_pos + XRGB(game->hero[game->conf.battle.effect.hero_id[0]].battle.draw_xpos);
    rect.x = W_CENTER(fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, anime_id, ANIME_SUB_MEMBER_MAGIC_XSIZE)) - SIZE_UNIT_BATTLE_TOTAL_HALF_POS;
    rect.y = H_CENTER(fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, anime_id, ANIME_SUB_MEMBER_MAGIC_YSIZE));
    animation_effect_draw(game, anime_id, rect.w - rect.y - rect.x);

    if (true == tmr_constant(&game->conf.battle.effect.update_time, fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, anime_id, ANIME_SUB_MEMBER_MAGIC_ANIME_TIME)))
    {
        game->conf.battle.effect.update_time = get_time();
        animation_effect_update(game, anime_id, BATTLE_NORMAL_STATE_MAGIC_POS);
    }
}


/*
 * ver4. 2021/08/11
 * 発動する技名を描画するように処理を追加した
 * 
 * ver3. 2021/08/02
 * 召喚系の処理を追加するため、追加しやすいswitch-case文に変更した
 * 
 * ver2. 2021/07/29
 * わざが単体と全体の範囲があるためエフェクト描画時に描画座標を計算するように変更した
 * -
 * ver1. 2021/07/22
 * エフェクト描画の関数を管理
 * 
 * No. BATTLE_NORMAL_STATE_MAGIC_POS
 */
static void magic_draw_state(GameWrapper *const game)
{
    StatusRef ref;
    status_ref_update(game, &ref, MEMORY_MAGIC_ID, game->conf.battle.effect.id[0]);

    switch (ref.type)
    {
    case COMMAND_BATTLE_MAGIC_UNIT:
        hero_paty_magic_draw(game, &ref);
        break;

    default:
        hero_enemy_magic_draw(game, &ref);
        break;
    }

    if (true == tmr_constant(&game->conf.battle.effect.update_time, fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, ref.anime_id, ANIME_SUB_MEMBER_MAGIC_ANIME_TIME)))
    {
        game->conf.battle.effect.update_time = get_time();
        animation_effect_update(game, ref.anime_id, BATTLE_NORMAL_STATE_DAMEGE_NUM);
    }
}


/*
 * ver1. 2021/08/05
 * アイテム使用時のエフェクト描画状態処理
 * 変数で技とアイテムのエフェクトの描画判定をしていたが
 * かえってややこしくなったため、状態関数で分けることにした
 * 
 * No. BATTLE_NORMAL_STATE_ITEM_DRAW
 */
static void item_draw_state(GameWrapper *const game)
{
    StatusRef ref;
    
    status_ref_update(game, &ref, MEMORY_ITEM_ID, game->conf.battle.effect.id[0]);
    hero_paty_magic_draw(game, &ref);

    if (true == tmr_constant(&game->conf.battle.effect.update_time, fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, ref.anime_id, ANIME_SUB_MEMBER_MAGIC_ANIME_TIME)))
    {
        game->conf.battle.effect.update_time = get_time();
        animation_effect_update(game, ref.anime_id, BATTLE_NORMAL_STATE_ITEM_USE);
    }
}


/*
 * ver2. 2021/08/06
 * 使用アイテムが回復系やダメージ系のみリザルト値の描画を行う状態に遷移する
 * 
 * ver1. 2021/08/05
 * アイテムの使用効果をキャラクターに適応する
 * 
 * No. BATTLE_NORMAL_STATE_ITEM_USE
 */
static void item_use_state(GameWrapper *const game)
{
    if (ITEM_RESULT_DRAW_OK == battle_item_use(game))
    {
        font_animetion_memba_update(game);
        game->conf.battle.state.module = BATTLE_NORMAL_STATE_DAMEGE_DRAW;
    }
    else
    {
        game->conf.battle.state.module = BATTLE_NORMAL_STATE_BACK_WALK;
    }
}


/*
 * ver5. 2021/08/08
 * 仲間の状態異常処理を追加
 *
 * ver4. 2021/08/07
 * ステータス操作系の処理を追加
 * ローカル構造体を用意し必要なデータをまとめる役割を持たせた。
 *
 * ver3. 2021/08/01
 * switch-case文に処理を変更した
 * 威力が0の場合はステータス操作系の技、それ以外はHPに関連する技のため分けやすいと思った
 *
 * ver2. 2021/07/29
 * ステータス操作系のわざはダメージ計算をしないため、パワー0の技の場合は数字の描画はせずに歩くモーションに変更する
 * -
 * ver1. 2021/07/24
 * リザルト計算の状態遷移を管理しリザルト描画のアニメーションメンバの設定を行う
 * 
 * 1.回復系の処理
 * 2.ダメージ系の処理
 * 
 * No. BATTLE_NORMAL_STATE_DAMEGE_NUM
 */
static void result_calc_state(GameWrapper *const game)
{
    StatusRef ref;
    
    status_ref_update(game, &ref, MEMORY_MAGIC_ID, game->conf.battle.effect.id[0]);

    switch (fetch_dram_db(game, MEMORY_MAGIC_ID, game->conf.battle.effect.id[0], MAGIC_SUB_MEMBER_POWER))
    {
    case SKILL_DAMEGE_POWER_NON:
        status_conf_update(game, &ref);
        game->conf.battle.state.module = BATTLE_NORMAL_STATE_BACK_WALK;
        break;

    default:
        if (E_RASE == ref.element)
        {
            select_unit_calc(game, COMMAND_BATTLE_MAGIC_RISE);
            game->conf.battle.state.module = BATTLE_NORMAL_STATE_BACK_WALK;
        }
        else
        {
            select_unit_calc(game, ref.type);
            font_animetion_memba_update(game);
            game->conf.battle.state.module = BATTLE_NORMAL_STATE_DAMEGE_DRAW;
        }
        break;
    }
}


/*
 * ver3. 2021/07/29
 * 技に応じて回復やダメージの数値の描画位置を変更するように変更
 * -
 * ver2. 2021/07/25
 * ダメージ描画にアニメーションを追加
 * アニメーションに状態遷移を追加
 *
 * ver1. 2021/06/27
 * バトル中のダメージ描画
 * 
 * No. BATTLE_NORMAL_STATE_DAMEGE_DRAW
 */
static void action_result_state(GameWrapper *const game)
{
    battle_font_animation_update(game, BATTLE_NORMAL_STATE_BACK_WALK);

    switch (game->conf.battle.effect.anime_select[0])
    {
    case COMMAND_ANIME_ITEM:
        select_unit_damege_draw(game, COMMAND_BATTLE_MAGIC_UNIT, MEMORY_ITEM_ID);
        break;

    case COMMAND_ANIME_MAGIC:
        select_unit_damege_draw(game, fetch_dram_db(game, MEMORY_MAGIC_ID, game->conf.battle.effect.id[0], MAGIC_SUB_MEMBER_TYPE), MEMORY_MAGIC_ID);
        break;

    default:
        break;
    }
}


/*
 * ver1. 2021/07/22
 * コマンド動作完了後に前方に進むアニメーションを行っていた場合に、キャラクター描画の定位置に戻るアニメーション処理を行う
 * 
 * No. BATTLE_NORMAL_STATE_BACK_WALK
 */
static void back_walk_state(GameWrapper *const game)
{
    if (false == tmr_constant(&game->conf.battle.state.timer, TM_300US_COUNT))
    {
        return;
    }

    game->conf.battle.state.timer = get_time();
    game->hero[game->conf.battle.effect.hero_id[0]].battle.draw_xpos += BATTLE_NORMAL_ANIME_SPEED;

    if (game->hero[game->conf.battle.effect.hero_id[0]].battle.draw_xpos < -SIZE_UNIT_BATTLE_WIDTH_HALF)
    {
        game->conf.battle.hero.anime_order[game->conf.battle.effect.hero_id[0]] = BATTLE_HERO_CHIP_RIGHT;
    }
    else
    {
        game->conf.battle.hero.anime_order[game->conf.battle.effect.hero_id[0]] = BATTLE_HERO_CHIP_STAND;
    }

    if (game->hero[game->conf.battle.effect.hero_id[0]].battle.draw_xpos == 0)
    {
        game->conf.battle.state.module = BATTLE_NORMAL_STATE_DOWN_JUGE;
    }
}


/*
 * ver3. 2021/07/29
 * 敵を倒したときに敵の並び順を前詰めでシフトするため、コマンド確定時のターゲットカーソルのデータを減算するように変更した
 * -
 * ver2. 2021/07/26
 * 全体攻撃で一斉に敵のHPが0になる場合があるため
 * HPが0以下になった敵のデータを構造体の末尾に挿入し構造体のソートを行う処理に変更し
 * ソートを行った場合は、再度同じインデックスの判定を行う
 *
 * ver1. 2021/07/24
 * ダメージに応じてHPが0以下になったか判定を行い、データの形成を行う
 * 倒した敵IDを配列の末尾に挿入し、末尾以外のデータを前詰めでシフトする
 * 
 * No. BATTLE_NORMAL_STATE_DOWN_JUGE
 */
static void enemy_down_check(GameWrapper *const game)
{
    uint8_t i = 0;
    bool sound_defeat = ENEMY_DEFEAT_SOUND_OFF;

    do
    {
        if ((game->enemy[i].hp <= 0) && (true == game->enemy[i].join))
        {
            
            for (uint8_t j = 0; j < game->conf.battle.hero.counter; j++)
            {
                if ((0 != game->conf.battle.effect.cursol_enemy[j]) && (i <= game->conf.battle.effect.cursol_enemy[j]))
                {
                    game->conf.battle.effect.cursol_enemy[j]--;
                }
            }

            sound_defeat = ENEMY_DEFEAT_SOUND_ON;
            battle_enemy_shift(game, i);
        }
        else
        {
            i++;
        }
    } while (i != game->conf.battle.enemy.counter);

    if (sound_defeat == ENEMY_DEFEAT_SOUND_ON)
    {
        bgm_update(game, SOUND_ID_BATTLE_DEFEAT1, SOUND_CH_EFFECT1_WORK);
    }

    game->conf.battle.state.module = BATTLE_NORMAL_STATE_DOWN_DRAW;
}


/*
 * ver2. 2021/07/26
 * alpha値を敵単体に持たせるように変更、alpha値が0になったら状態を変更する
 *
 * ver1. 2021/07/24
 * HPが0になった場合のアニメーション処理を行う
 * 
 * No. BATTLE_NORMAL_STATE_DOWN_DRAW
 */
static void enemy_down_draw(GameWrapper *const game)
{
    game->conf.battle.state.module = BATTLE_NORMAL_STATE_FINISH;

    for (uint8_t i = 0; i < game->conf.battle.enemy.counter; i++)
    {
        if (false == game->enemy[i].down_on)
        {
            continue;
        }

        game->enemy[i].alpha -= COLOR_ALPHA_INC;
        
        if (game->enemy[i].alpha == COLOR_ALPHA_MIN)
        {
            game->enemy[i].down_on = false;
        }
        game->mapchip.srcin		 = fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[i].id, ENEMY_SUB_MEMBER_PARA_SRCIN);
        game->mapchip.maxwidth	 = fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[i].id, ENEMY_SUB_MEMBER_PARA_WIDTH);
        game->mapchip.maxheight	 = fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[i].id, ENEMY_SUB_MEMBER_PARA_HEIGHT);
        game->mapchip.draw_xsize = game->mapchip.maxwidth;
        game->mapchip.draw_ysize = game->mapchip.maxheight;
        game->mapchip.xstart_pos = 0;
        game->mapchip.ystart_pos = 0;
        game->mapchip.frame_size = VIDEO_WIDTH;
        game->mapchip.alpha		 = game->enemy[i].alpha;
        game->mapchip.id         = 0;
        game->mapchip.dstin      = game->conf.work.adr + game->enemy[i].draw_pos;
        game->mapchip.dstout	 = game->mapchip.dstin;
        png_mapchip(game);
        game->conf.battle.state.module = BATTLE_NORMAL_STATE_DOWN_DRAW;
    }
}


/*
 * ver1. 2021/07/22
 * 全てのキャラクター行動処理が完了したら、次の仲間のアニメーション処理待機状態に移行する
 * 
 * No. BATTLE_NORMAL_STATE_FINISH
 */
static void action_finish_state(GameWrapper *const game)
{
    uint8_t hero_id = game->conf.battle.effect.hero_id[0];

    game->conf.display.uncommon_window = UNCOMMON_WINDOW_OFF;
    game->conf.battle.state.module = BATTLE_NORMAL_STATE_DEFAULT;
    game->conf.battle.hero.anime_order[hero_id] = odd_hp_mapchip(game, hero_id);
    game->hero[hero_id].battle.item_gauge = (game->conf.battle.effect.anime_select[0] == COMMAND_ANIME_ITEM) ? 0 : game->hero[hero_id].battle.item_gauge;
    game->hero[hero_id].battle.atb_gauge = 0;
    battle_conf_shift(game, 0);
}


/*
 * ver1. 2021/07/27
 * 状態遷移タイマーのセット
 */
static void victory_timer_set(GameWrapper *const game)
{
    if (BATTLE_NORMAL_STATE_DEFAULT != game->conf.battle.state.module)
    {
        return;
    }

    if (game->conf.battle.enemy.number != 0)
    {
        return;
    }

	game->conf.battle.state.timer  = get_time();
	game->conf.battle.state.module = BATTLE_VICTORY_STATE_SOUND_START;
    bgm_stop();
    bgm_update(game, SOUND_ID_BATTLE_FANFARE, SOUND_CH_BGM_WORK);
}


/*
 * ver1. 2021/07/27
 * 勝利ファンファーレの開始
 */
static void victory_fanfare_start(GameWrapper *const game)
{
	if (true == tmr_constant(&game->conf.battle.state.timer, VICTPRY_FANDARE_WAIT_TIME))
	{
        game->conf.battle.state.module  = BATTLE_VICTORY_STATE_RESULT;
	}
}


/*
 * ver1. 2021/07/27
 * 勝利時の取得経験値、ドロップアイテム、レベルアップの取得
 */
static void victory_result_store(GameWrapper *const game)
{
    uint32_t exp = 0;

    for (uint8_t i = 0; i < game->conf.battle.enemy.counter; i++)
    {
        exp += fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[i].id, ENEMY_SUB_MEMBER_PARA_EXP);
    }

    for (uint8_t i = 0; i < game->conf.system.paty_member; i++)
    {
        if (BATTLE_HERO_ALIVE == game->hero[i].battle.arive)
        {
            game->hero[i].status.exp += exp;
        }
    }

    update_levelup(game);
    game->conf.cook.isCook          = true;
    game->conf.battle.state.module  = BATTLE_VICTORY_STATE_ANIME_START;
    game->conf.battle.state.victory = BATTLE_GAME_RESULT;
}


/*
 * ver1. 2021/07/27
 * 勝利アニメーションの画像データの切り替え開始
 */
static void victory_animation(GameWrapper *const game)
{
	for (uint8_t i = 0; i < game->conf.battle.hero.counter; i++)
	{
        if (BATTLE_HERO_CHIP_DEATH_1 == game->conf.battle.hero.anime_order[i])
        {
            continue;
        }

		if (false == tmr_constant(&game->conf.battle.hero.animation_time[game->conf.battle.hero.sort_order[i]], VICTORY_ANIME_SPEED + (i * TM_30MS_COUNT)))
		{
            continue;
        }
        
        switch (game->conf.battle.hero.anime_order[game->conf.battle.hero.sort_order[i]])
        {
        case BATTLE_HERO_CHIP_ACTION:
            game->conf.battle.hero.anime_order[game->conf.battle.hero.sort_order[i]] = BATTLE_HERO_CHIP_STAND;
            break;
        
        default:
            game->conf.battle.hero.anime_order[game->conf.battle.hero.sort_order[i]] = BATTLE_HERO_CHIP_ACTION;
            break;
        }

        game->conf.battle.hero.animation_time[game->conf.battle.hero.sort_order[i]] = get_time();
	}
}
