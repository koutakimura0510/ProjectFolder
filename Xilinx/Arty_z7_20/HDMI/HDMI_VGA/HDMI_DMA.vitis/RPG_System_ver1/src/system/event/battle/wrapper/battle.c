/*
 * Create 2021/06/27
 * Author kimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * IC
 * -
 * バトルイベントに関する関数を管理するファイル
 */
#include "../../../wrapper/game_wrapper.h"
#include "../wrapper/local_share.h"

#ifdef MYDEBUG
#include "xil_printf.h"
#endif


/*
 * ファイル内関数宣言
 */
static void battle_initialize(GameWrapper *const game);
static void battle_enemy_initialize(GameWrapper *const game);
static void battle_enemy_draw(GameWrapper *const game);


/*
 * ver3. 2021/08/03
 * 戦闘開始時のアニメーション処理追加、それに応じて状態を増やした
 * 
 * ver2. 2021/07/27
 * 戦闘状況によって処理を変えるように変更
 *
 * ver1. 2021/06/27
 * バトルシステムの管理を行う
 */
bool battle_window_draw(GameWrapper *const game)
{
    background_draw(game, DRAM_BATTLE_BACK_ADDR_BASE);
    battle_player_draw(game, game->conf.battle.hero.counter);
    battle_enemy_draw(game);
    battle_config_state(game);
    battle_action_state(game);

    return (game->conf.battle.state.victory == BATTLE_GAME_FINISH) ? true : false;
}


/*
 * ver1 . 2021/06/27
 * 歩数を数えてバトルに突入するか判定を行う
 * -
 * 戦闘突入時処理
 * 1. エンカウント判定用歩数をクリア
 * 2. 次に実行するシステム変数をバトル移行モードに変更する
 * 3. 戦闘の初期設定をする
 */
bool battle_rush_state(GameWrapper *const game)
{
    if (game->conf.event.type == EVENT_TYPE_SUBMAP_MOVE)
    {
        game->unit.pos.encount = 0;
        return NON_DIRECT;
    }

    uint32_t encount = get_time() & (game->unit.pos.encount >> MAPCHIP_SHIFT);

    if (10 < xorshift(encount))
    {
#ifdef MYDEBUG
        xil_printf("Encount! work = %d\n", game->unit.pos.encount >> MAPCHIP_SHIFT);
#endif
        game->unit.pos.encount       = 0;
        game->conf.display.system    = SYSTEM_NEXT_SYSTEM_PIPE;
        game->conf.display.sub_state = SYSTEM_BATTLE_STATE;
        battle_initialize(game);
        return ON_DIRECT;
    }

    return NON_DIRECT;
}


/*
 * ver1. 2021/07/04
 * バトル突入時のバトルシステムの初期設定
 */
static void battle_initialize(GameWrapper *const game)
{
    uint32_t battle_pos[] = {
        UNIT_BATTLE_POS_1,
        UNIT_BATTLE_POS_2,
        UNIT_BATTLE_POS_3,
        UNIT_BATTLE_POS_4,
        UNIT_BATTLE_POS_5,
        UNIT_BATTLE_POS_6,
        UNIT_BATTLE_POS_7,
        UNIT_BATTLE_POS_8,
    };

    bgm_stop();
    battle_enemy_initialize(game);
    cmd_db_reset(game, COMMAND_BATTLE_SYSTEM, 0);
    game->conf.battle.hero.number = 0;

    for (uint8_t i = 0; i < game->conf.system.paty_member; i++)
    {
        game->hero[game->conf.battle.hero.sort_order[i]].battle.atb_gauge  = ATB_GAUGE_MAX - 15;
        game->hero[game->conf.battle.hero.sort_order[i]].battle.atb_timer  = get_time();
        game->hero[game->conf.battle.hero.sort_order[i]].battle.item_gauge = 0;
        game->hero[game->conf.battle.hero.sort_order[i]].battle.item_timer = get_time();
        game->hero[game->conf.battle.hero.sort_order[i]].battle.draw_pos   = battle_pos[i];
        game->hero[game->conf.battle.hero.sort_order[i]].battle.draw_xpos  = UNIT_BATTLE_START_ANIME_XPOS;
        game->hero[game->conf.battle.hero.sort_order[i]].battle.draw_ypos  = 0;
        game->hero[game->conf.battle.hero.sort_order[i]].status.enchant.atk = 0;
        game->hero[game->conf.battle.hero.sort_order[i]].status.enchant.def = 0;
        game->hero[game->conf.battle.hero.sort_order[i]].status.enchant.mag = 0;
        game->hero[game->conf.battle.hero.sort_order[i]].status.enchant.res = 0;
        game->hero[game->conf.battle.hero.sort_order[i]].status.enchant.agi = 0;
        game->conf.battle.trun.order[i]           = BATTLE_TRUN_ORDER_NOT;
        game->conf.battle.effect.active[i]        = BATTLE_ACTION_TIMER_OFF;
        game->conf.battle.effect.hero_id[i]       = 0;
        game->conf.battle.effect.id[i]            = 0;
        game->conf.battle.effect.cursol_enemy[i]  = 0;
        game->conf.battle.effect.cursol_hero[i]   = 0;
        game->conf.battle.effect.wait_time[i]     = MAX_32BIT;
        game->conf.battle.effect.com_time[i]      = MAX_32BIT;
        game->conf.battle.motion_update[i]        = ANIME_CHANGE_MOTION_1;

        if (game->hero[game->conf.battle.hero.sort_order[i]].battle.arive == BATTLE_HERO_ALIVE)
        {
            game->conf.battle.hero.number++;
            game->conf.battle.hero.anime_order[i] = odd_hp_mapchip(game, i);
        }
    }

    game->conf.display.uncommon_window   = UNCOMMON_WINDOW_OFF;
    game->conf.battle.trun.sound         = TRUN_SOUND_ON;
    game->conf.battle.effect.sound       = EFFECT_SOUND_ON;
    game->conf.battle.effect.loop_count  = 0;
    game->conf.battle.effect.mapchip_id  = 0;
    game->conf.battle.effect.update_time = 0;
    game->conf.battle.state.module       = BATTLE_NORMAL_STATE_DEFAULT;
    game->conf.battle.state.victory      = BATTLE_GAME_START;
    bgm_update(game, SOUND_ID_BATTLE_ENCOUNT, SOUND_CH_EFFECT2_WORK);

    #ifdef MYDEBUG
    xil_printf("Battle Init OK!\n");
    #endif
}


/*
 * ver2. 2021/07/23
 * データベースにリージョンデータを追加
 * リージョンデータを参照しエンカウント時に敵のデータを設定するように変更
 *
 * ver1. 2021/07/21
 * バトル突入時の敵データの初期設定
 */
static void battle_enemy_initialize(GameWrapper *const game)
{
    uint8_t enemy_select_count = 0;
    uint8_t enemy_id[REGION_ENEMY_MAX_SIZE];
    uint8_t formation_type[REGION_FORMATION_MAX_SIZE];
    uint8_t type_number = xorshift(get_time()) & 0x03;  //0~3の隊列タイプ参照インデックスをランダムで生成

    for (uint8_t i = 0; i < REGION_FORMATION_MAX_SIZE; i++) //リージョンマスの隊列番号取得
    {
        formation_type[i] = fetch_dram_db(game, MEMORY_ENEMY_REGION_ID, 1, REGION_SUB_MEMBER_FORMATION_1 + i);
    }

    for (uint8_t i = 0; i < REGION_ENEMY_MAX_SIZE; i++) // リージョンマスのエネミー番号取得
    {
        enemy_id[i] = fetch_dram_db(game, MEMORY_ENEMY_REGION_ID, 1, REGION_SUB_MEMBER_ENEMY_1 + i);
    }

    game->conf.battle.enemy.number  = fetch_dram_db(game, MEMORY_ENEMY_FORMATION_ID, formation_type[type_number], FORMATION_SUB_MEMBER_ENEMY_NUM);
    game->conf.battle.enemy.counter = game->conf.battle.enemy.number;

    while (game->conf.battle.enemy.number != enemy_select_count)    // 隊列に応じたエネミーの数、設定が終了するまでループ
    {
        for (uint8_t i = 0; i < REGION_ENEMY_MAX_SIZE; i++)
        {
            if (MONSTER_ID_NON == enemy_id[i])
            {
                break;
            }

            if (fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, enemy_id[i], ENEMY_SUB_MEMBER_PARA_SIZE) <= fetch_dram_db(game, MEMORY_ENEMY_FORMATION_ID, formation_type[type_number], FORMATION_SUB_MEMBER_ENEMY_SIZE))
            {
                if (xorshift(get_time()) & 0x01)
                {
                    game->enemy[enemy_select_count].id        = enemy_id[i];
                    game->enemy[enemy_select_count].hp        = fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, enemy_id[i], ENEMY_SUB_MEMBER_PARA_HP);
                    game->enemy[enemy_select_count].atb_gauge = fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, enemy_id[i], ENEMY_SUB_MEMBER_PARA_ATB_GAUGE);
                    game->enemy[enemy_select_count].atb_timer = 0;
                    game->enemy[enemy_select_count].condition = 0;
                    game->enemy[enemy_select_count].adjust_pos= 0;
                    game->enemy[enemy_select_count].draw_xpos = fetch_dram_db(game, MEMORY_ENEMY_FORMATION_ID, formation_type[type_number], FORMATION_SUB_MEMBER_DRAW_XPOS_1 + enemy_select_count);
                    game->enemy[enemy_select_count].draw_ypos = fetch_dram_db(game, MEMORY_ENEMY_FORMATION_ID, formation_type[type_number], FORMATION_SUB_MEMBER_DRAW_YPOS_1 + enemy_select_count);
                    game->enemy[enemy_select_count].draw_pos  = game->enemy[enemy_select_count].draw_xpos + game->enemy[enemy_select_count].draw_ypos;
                    game->enemy[enemy_select_count].join      = true;
                    game->enemy[enemy_select_count].down_on   = false;
                    game->enemy[enemy_select_count].alpha     = COLOR_ALPHA_MAX;
                    game->enemy[enemy_select_count].enchant.agi = 0;
                    game->enemy[enemy_select_count].enchant.res = 0;
                    game->enemy[enemy_select_count].enchant.def = 0;
                    game->conf.battle.enemy.sort_order[enemy_select_count] = 0;
                    game->conf.battle.enemy.trun_order[enemy_select_count] = BATTLE_TRUN_ORDER_NOT;
                    enemy_select_count++;
                    break;
                }
            }
        }
    }

    #ifdef MYDEBUG
    xil_printf("Enemy Init OK!\n");
    #endif
}


/*
 * ver2. 2021/07/25
 * 戦闘開始時の敵の数を保存するenemy_counterメンバで敵の描画を管理するように変更
 *
 * ver1. 2021/06/27
 * バトル中のエネミーを描画
 */
static void battle_enemy_draw(GameWrapper *const game)
{
    for (uint8_t i = 0; i < game->conf.battle.enemy.counter; i++)
    {
        if (true == game->enemy[i].join)
        {
            game->mapchip.srcin		 = fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[i].id, ENEMY_SUB_MEMBER_PARA_SRCIN);
            game->mapchip.maxwidth	 = fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[i].id, ENEMY_SUB_MEMBER_PARA_WIDTH);
            game->mapchip.maxheight	 = fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[i].id, ENEMY_SUB_MEMBER_PARA_HEIGHT);
            game->mapchip.draw_xsize = game->mapchip.maxwidth;
            game->mapchip.draw_ysize = game->mapchip.maxheight;
            game->mapchip.xstart_pos = 0;
            game->mapchip.ystart_pos = 0;
            game->mapchip.frame_size = VIDEO_WIDTH;
            game->mapchip.alpha		 = 255;
            game->mapchip.id         = 0;
            game->mapchip.dstin      = game->conf.work.adr + game->enemy[i].draw_pos + XRGB((game->enemy[i].adjust_pos));
            game->mapchip.dstout	 = game->mapchip.dstin;
            png_mapchip(game);
        }
    }
}
