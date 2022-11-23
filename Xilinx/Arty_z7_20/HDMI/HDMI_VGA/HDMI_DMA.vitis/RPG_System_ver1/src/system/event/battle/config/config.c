/*
 * Create 2021/08/01
 * Author kimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * IC
 * -
 * 戦闘時の通常描画以外に関する描画イベントの情報の状態を管理するファイル
 */
#include "../../../wrapper/game_wrapper.h"
#include "../wrapper/local_share.h"

#ifdef MYDEBUG
#include "xil_printf.h"
#endif


/* 構造体要素数 */
#define BATTLE_CONFIG_DB_SIZE  ((sizeof (conf_state))/(sizeof (BattleConfigState)))


/*
 * ファイル内関数宣言
 */
static void battle_progress_window(GameWrapper *const game);
static void battle_result_window(GameWrapper *const game);
static void battle_death_window(GameWrapper *const game);
static void battle_escape_window(GameWrapper *const game);
static void battle_start_draw(GameWrapper *const game);
static void battle_menu_draw(GameWrapper *const game);
static void active_effect_name_window(GameWrapper *const game);
static void atb_gauge_draw(GameWrapper *const game);
static void hero_status_draw(GameWrapper *const game);
static void grapic_cmd_draw(GameWrapper *const game);
static void enemy_name_draw(GameWrapper *const game);
static void hero_atb_update(GameWrapper *const game);
static void action_atb_update(GameWrapper *const game, uint8_t hero_id);
static void item_atb_update(GameWrapper *const game, uint8_t hero_id);
static void battle_hero_trun(GameWrapper *const game);
static void battle_trun_order(GameWrapper *const game, uint8_t pos);
static void hero_chip_update(GameWrapper *const game);
static void hero_active_update(GameWrapper *const game);
static void effect_cmd_update(GameWrapper *const game, uint8_t i);
static void enemy_trun_update(GameWrapper *const game);
static bool enemy_atb_update(GameWrapper *const game, uint8_t index);
static void enemy_trun_order(GameWrapper *const game, uint8_t index);
static void enemy_target_update(GameWrapper *const game, uint8_t index);


/*
 * ver1. 2021/07/24
 * 戦闘の状況を管理する状態遷移データベース
 */
typedef struct
{
    uint8_t system;
    void (*battle_config)(GameWrapper *const game);
} BattleConfigState;

static const BattleConfigState conf_state[] = 
{
    {BATTLE_GAME_START,     battle_start_draw       },  //戦闘開始時
    {BATTLE_GAME_PROGRESS,  battle_progress_window  },  //戦闘中
    {BATTLE_GAME_RESULT,    battle_result_window    },  //勝利時
    {BATTLE_GAME_DEATH,     battle_death_window     },  //全滅時
    {BATTLE_GAME_ESCAPE,    battle_escape_window    },  //逃走時
};


/*
 * ver1. 2021/08/03
 * バトル進行画面を構成する状態遷移処理
 */
void battle_config_state(GameWrapper *const game)
{
    const BattleConfigState *p = conf_state;

    for (uint8_t i = 0; i < BATTLE_CONFIG_DB_SIZE; i++, p++)
    {
        if (p->system == game->conf.battle.state.victory)
        {
            p->battle_config(game);
            break;
        }
    }
}


/*
 * ver1. 2021/08/03
 * 戦闘突入時のアニメーション処理
 */
static void battle_start_draw(GameWrapper *const game)
{
    if (game->conf.battle.trun.sound == TRUN_SOUND_ON)
    {
        bgm_update(game, SOUND_ID_BATTLE_DEFAULT, SOUND_CH_BGM_WORK);
        game->conf.battle.trun.sound = TRUN_SOUND_OFF;
    }

    for (uint8_t i = 0; i < game->conf.battle.hero.counter; i++)
    {
        game->hero[game->conf.battle.hero.sort_order[i]].battle.draw_xpos -= UNIT_BATTLE_START_ANIME_XADD;
    }

    if (game->hero[game->conf.battle.hero.sort_order[0]].battle.draw_xpos == 0)
    {
        game->conf.battle.trun.sound    = TRUN_SOUND_ON;
        game->conf.battle.state.victory = BATTLE_GAME_PROGRESS;
    }
}


/*
 * ver1. 2021/08/03
 * 戦闘進行中の画面構成と更新処理
 */
static void battle_progress_window(GameWrapper *const game)
{
    battle_menu_draw(game);
    hero_atb_update(game);
    enemy_trun_update(game);
    battle_hero_trun(game);
    active_effect_name_window(game);
    hero_chip_update(game);
    hero_condition_state(game);
    battle_sub_window(game);
}


/*
 * ver2. 2021/07/28
 * レベルアップした仲間のメッセージの描画処理を追加
 * 取得した経験値とお金の描画処理を追加
 * -
 * ver1. 2021/07/27
 * 戦闘終了時のリザルトウィンドウ描画処理
 * 指定のスイッチを押すと戦闘をの状態を終了する
 */
static void battle_result_window(GameWrapper *const game)
{
    uint32_t exp  = 0;
    uint32_t gold = 0;
    uint32_t pos  = 0;

    for (uint8_t i = 0; i < game->conf.battle.enemy.counter; i++)
    {
        exp  += fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[i].id, ENEMY_SUB_MEMBER_PARA_EXP);
        gold += fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[i].id, ENEMY_SUB_MEMBER_PARA_GOLD);
    }

    patblt(game->conf.work.adr, BATTLE_RESULT_XSTART_WHITE, BATTLE_RESULT_YSTART_WHITE, BATTLE_RESULT_WIDTH_WHITE, BATTLE_RESULT_HEIGHT_WHITE, COLOR_WHITE);
    patblt(game->conf.work.adr, BATTLE_RESULT_XSTART_BLUE,  BATTLE_RESULT_YSTART_BLUE,  BATTLE_RESULT_WIDTH_BLUE,  BATTLE_RESULT_HEIGHT_BLUE,  COLOR_MID_BLUE);
    font_dram_draw(game, BATTLE_RESULT_EXP_XSTART,  BATTLE_RESULT_EXP_YSTART,  MEMORY_CMD_MSG_ID, CMD_MSG_ID_GET_EXP,  EVENT_MSG_SUB_MSG, COLOR_WHITE);
    font_dram_draw(game, BATTLE_RESULT_GOLD_XSTART, BATTLE_RESULT_GOLD_YSTART, MEMORY_CMD_MSG_ID, CMD_MSG_ID_GET_GOLD, EVENT_MSG_SUB_MSG, COLOR_WHITE);
    result_font_draw(game, BATTLE_RESULT_NUM_XSTART, BATTLE_RESULT_EXP_NUM_YSTART,  exp,  ZERO_SUP_OFF);
    result_font_draw(game, BATTLE_RESULT_NUM_XSTART, BATTLE_RESULT_GOLD_NUM_YSTART, gold, ZERO_SUP_OFF);

    for (uint8_t i = 0; i < game->conf.system.paty_member; i++)
    {
        if (true == game->hero[game->conf.battle.hero.sort_order[i]].battle.levelup)
        {
            font_dram_draw(game, BATTLE_RESULT_LV_UP_XSTART, BATTLE_RESULT_LV_UP_YSTART + (pos * SIZE_FONT_SJIS_HEIGHT), MEMORY_CMD_MSG_ID, CMD_MSG_ID_LV_UP_MINORIKO + game->conf.battle.hero.sort_order[i], EVENT_MSG_SUB_MSG, COLOR_WHITE);
            pos++;
        }
    }

    if (SW_A == cmd_key(game))
    {
        game->conf.battle.state.victory = BATTLE_GAME_FINISH;
    }
}


/*
 * ver1. 2021/08/02
 * 戦闘終了時の全滅ウィンドウ描画処理
 * 指定のスイッチを押すと戦闘の状態を終了する
 */
static void battle_death_window(GameWrapper *const game)
{
    patblt(game->conf.work.adr, BATTLE_DEATH_XSTART_WHITE, BATTLE_DEATH_YSTART_WHITE, BATTLE_DEATH_WIDTH_WHITE, BATTLE_DEATH_HEIGHT_WHITE, COLOR_WHITE);
    patblt(game->conf.work.adr, BATTLE_DEATH_XSTART_BLUE,  BATTLE_DEATH_YSTART_BLUE,  BATTLE_DEATH_WIDTH_BLUE,  BATTLE_DEATH_HEIGHT_BLUE,  COLOR_MID_BLUE);
    font_dram_draw(game, BATTLE_DEATH_MSG_XSTART, BATTLE_DEATH_MSG_YSTART, MEMORY_CMD_MSG_ID, CMD_MSG_ID_BATTLE_DEATH, EVENT_MSG_SUB_MSG, COLOR_WHITE);

    if (SW_A == cmd_key(game))
    {
        game->conf.battle.state.victory = BATTLE_GAME_FINISH;
    }
}


/*
 * ver1. 2021/08/12
 * 逃走成功時のウィンドウ描画処理
 */
static void battle_escape_window(GameWrapper *const game)
{
    patblt(game->conf.work.adr, BATTLE_ESCAPE_XSTART_WHITE, BATTLE_ESCAPE_YSTART_WHITE, BATTLE_ESCAPE_WIDTH_WHITE, BATTLE_ESCAPE_HEIGHT_WHITE, COLOR_WHITE);
    patblt(game->conf.work.adr, BATTLE_ESCAPE_XSTART_BLUE,  BATTLE_ESCAPE_YSTART_BLUE,  BATTLE_ESCAPE_WIDTH_BLUE,  BATTLE_ESCAPE_HEIGHT_BLUE,  COLOR_MID_BLUE);
    font_dram_draw(game, BATTLE_ESCAPE_MSG_XSTART, BATTLE_ESCAPE_MSG_YSTART, MEMORY_CMD_MSG_ID, CMD_MSG_ID_BATTLE_ESCAPE, EVENT_MSG_SUB_MSG, COLOR_WHITE);

    if (SW_A == cmd_key(game))
    {
        game->conf.battle.state.victory = BATTLE_GAME_FINISH;
    }
}



/*
 * ver1. 2021/08/11
 * 発動中の技のウィンドウと技名の描画
 */
static void active_effect_name_window(GameWrapper *const game)
{
    if (game->conf.display.uncommon_window == UNCOMMON_WINDOW_OFF)
    {
        return;
    }

    SDL_Rect rect;
    uint8_t effect_id;

    if (game->conf.display.uncommon_window == UNCOMMON_WINDOW_HERO_SKILL)
    {
        effect_id = game->conf.battle.effect.id[0];
    }
    else
    {
        effect_id = game->conf.battle.enemy.effect_id[0];
    }

    fetch_dram_db(game, MEMORY_MAGIC_ID, effect_id, MAGIC_SUB_MEMBER_NAME); //技名の長さを取得
    rect.x = BATTLE_EFFECT_MSG_XSTART - (*game->conf.db.len * SIZE_FONT_SJIS_HALF);
    patblt(game->conf.work.adr, BATTLE_EFFECT_XSTART_WHITE, BATTLE_EFFECT_YSTART_WHITE, BATTLE_EFFECT_WIDTH_WHITE, BATTLE_EFFECT_HEIGHT_WHITE, COLOR_WHITE);
    patblt(game->conf.work.adr, BATTLE_EFFECT_XSTART_BLUE,  BATTLE_EFFECT_YSTART_BLUE,  BATTLE_EFFECT_WIDTH_BLUE,  BATTLE_EFFECT_HEIGHT_BLUE,  COLOR_MID_BLUE);
    font_dram_draw(game, rect.x, BATTLE_EFFECT_MSG_YSTART, MEMORY_MAGIC_ID, effect_id, MAGIC_SUB_MEMBER_NAME, COLOR_WHITE);
}





/*
 * ver3. 2021/08/04
 * 処理速度と可読性向上のため描画関数を種類ごとに分けた
 * 
 * ver2. 2021/07/01
 * フォントの描画処理を追加
 *
 * ver1. 2021/06/27
 * バトル中のメニューウィンドウを描画
 * -
 * サイズを変更する場合は下記を参照
 * project://RPG_System_ver1/src/draw/event/battle/battle_macro.h
 * BATTLE_STANDERD_LINE_xxxの定数値を変更
 */
static void battle_menu_draw(GameWrapper *const game)
{
    patblt(game->conf.work.adr, BATTLE_MENU_LINE_XSTART, BATTLE_MENU_LINE_YSTART, BATTLE_MENU_LINE_WIDTH, BATTLE_MENU_LINE_HEIGHT, COLOR_WHITE);
    patblt(game->conf.work.adr, BATTLE_MENU_FILL_XSTART, BATTLE_MENU_FILL_YSTART, BATTLE_MENU_FILL_WIDTH, BATTLE_MENU_FILL_HEIGHT, COLOR_MID_BLUE);
    patblt(game->conf.work.adr, BATTLE_CMD_LINE_XSTART,  BATTLE_CMD_LINE_YSTART,  BATTLE_CMD_LINE_WIDTH,  BATTLE_CMD_LINE_HEIGHT,  COLOR_WHITE);
    patblt(game->conf.work.adr, BATTLE_STAT_LINE_XSTART, BATTLE_STAT_LINE_YSTART, BATTLE_STAT_LINE_WIDTH, BATTLE_STAT_LINE_HEIGHT, COLOR_WHITE);
    atb_gauge_draw(game);
    hero_status_draw(game);
    grapic_cmd_draw(game);
    enemy_name_draw(game);
}


/*
 * ver1. 2021/08/04
 * 仲間とアイテムのATBゲージの描画
 */
static void atb_gauge_draw(GameWrapper *const game)
{
    for (uint32_t i = 0; i < game->conf.system.paty_member; i++)
    {
        uint32_t white_fill = ATB_BAR_YPOS_WHITE_FILL + (i * BATTLE_CURSOL_INTERVAL);
        uint32_t black_fill = white_fill + ATB_LINE_SIZE;
        uint32_t gauge_fill = black_fill + ATB_LINE_SIZE;
        patblt(game->conf.work.adr, ATB_BAR_XPOS_WHITE_FILL, white_fill, ATB_BAR_XLEN_WHITE_FILL, ATB_BAR_YLEN_WHITE_FILL, COLOR_WHITE);
        patblt(game->conf.work.adr, ATB_BAR_XPOS_BLACK_FILL, black_fill, ATB_BAR_XLEN_BLACK_FILL, ATB_BAR_YLEN_BLACK_FILL, COLOR_BLACK);
        patblt(game->conf.work.adr, ATB_BAR_XPOS_GAUGE_FILL, gauge_fill, game->hero[game->conf.battle.hero.sort_order[i]].battle.atb_gauge >> 1, ATB_BAR_YLEN_GAUGE_FILL, COLOR_DARK_ORANGE);
        patblt(game->conf.work.adr + ATB_ITEM_DRAW_XPOS, ATB_BAR_XPOS_WHITE_FILL, white_fill, ATB_BAR_XLEN_WHITE_FILL, ATB_BAR_YLEN_WHITE_FILL, COLOR_WHITE);
        patblt(game->conf.work.adr + ATB_ITEM_DRAW_XPOS, ATB_BAR_XPOS_BLACK_FILL, black_fill, ATB_BAR_XLEN_BLACK_FILL, ATB_BAR_YLEN_BLACK_FILL, COLOR_BLACK);
        patblt(game->conf.work.adr + ATB_ITEM_DRAW_XPOS, ATB_BAR_XPOS_GAUGE_FILL, gauge_fill, game->hero[game->conf.battle.hero.sort_order[i]].battle.item_gauge >> 1, ATB_BAR_YLEN_GAUGE_FILL, COLOR_GREEN_YELLOW);
    }
}


/*
 * ver1. 2021/08/04
 * キャラクターの名前、HP、残りHPの描画
 */
static void hero_status_draw(GameWrapper *const game)
{
    for (uint32_t i = 0; i < game->conf.system.paty_member; i++)
    {
        uint32_t pos     = BATTLE_HERO_NAME_DEFAULT_YPOS + (i * BATTLE_CURSOL_INTERVAL);
        uint8_t  hero_id = game->conf.battle.hero.sort_order[i];
        uint32_t color   = ((BATTLE_TRUN_ORDER_CAN == game->conf.battle.trun.order[0]) && (hero_id == game->conf.battle.trun.hero[0])) ? COLOR_YELLOW : COLOR_WHITE;
        font_dram_draw(game,   BATTLE_HERO_NAME_DEFAULT_XPOS,   pos, MEMORY_CMD_MSG_ID, CMD_MSG_ID_MINORIKO + hero_id, EVENT_MSG_SUB_MSG, color);
        font_dram_draw(game,   BATTLE_HERO_HP_SLASH_XPOS,       pos, MEMORY_CMD_MSG_ID, CMD_MSG_ID_SLASH, EVENT_MSG_SUB_MSG, COLOR_WHITE);
        result_font_draw(game, BATTLE_HERO_ODD_HP_DEFAULT_XPOS, pos, game->hero[hero_id].status.odd_hp,   ZERO_SUP_ON);
        result_font_draw(game, BATTLE_HERO_HP_DEFAULT_XPOS,     pos, game->hero[hero_id].status.hp,       ZERO_SUP_ON);
    }
}


/*
 * ver1. 2021/08/04
 * バトル中のコマンド入力の基本項目を描画
 * 
 * たたかう 0
 * わざ     1
 * アイテム 2
 * いれかえ 3
 * はなす   4
 * にげる   5
 */
static void grapic_cmd_draw(GameWrapper *const game)
{
    for (uint32_t i = 0; i < BATTLE_CMD_MAX; i++)
    {
        font_dram_draw(game, BATTLE_CMD_DEFAULT_XPOS, BATTLE_CMD_DEFAULT_YPOS + (i * BATTLE_CURSOL_INTERVAL), MEMORY_CMD_MSG_ID, CMD_MSG_ID_FIGHT + i, EVENT_MSG_SUB_MSG, COLOR_WHITE);
    }
}


/*
 * ver1. 2021/08/04
 * バトル中のエネミーの名前を描画
 */
static void enemy_name_draw(GameWrapper *const game)
{
    for (uint32_t i = 0; i < game->conf.battle.enemy.number; i++)
    {
        font_dram_draw(game, BATTLE_ENEMY_NAME_DRAW_XPOS, BATTLE_ENEMY_NAME_DRAW_YPOS + (i * BATTLE_CURSOL_INTERVAL), MEMORY_ENEMY_NAME_ID, game->enemy[i].id, EVENT_MSG_SUB_MSG, COLOR_WHITE);
    }
}


/*
 * ver5. 2021/08/04
 * 仲間と敵のATBゲージの更新処理を分けた
 * ATB更新関数を行動用とアイテム用を作成し、それらを呼び出す形にした
 * 
 * ver4. 2021/07/30
 * 敵のatbゲージ更新処理追加
 *
 * ver3. 2021/07/27
 * 戦闘終了時にATBゲージの更新は行わないが、ATBゲージの描画は行うため
 * ATBゲージの更新と描画関数の処理を分けるように変更した
 *
 * ver2. 2021/07/08
 * 隊列順でATBゲージを更新するように変更
 *
 * ver1. 2021/07/04
 * ATBバーの描画と値の管理を行う
 * -
 * 戦闘に参加中の仲間のATB値を一定時間ごとに増やしていく
 * ATB値が最大値の場合は描画処理のみを行う
 * ATBが最大値になった時に、行動順の決定を行う処理関数を実行する
 * -
 * ATBゲージの枠のみ連番で描画し、実際のゲージの増減描画は隊列順で更新を行う
 */
static void hero_atb_update(GameWrapper *const game)
{
    for (uint8_t i = 0; i < game->conf.battle.hero.counter; i++)
    {
        uint8_t hero_id = game->conf.battle.hero.sort_order[i];

        if (game->hero[hero_id].battle.arive == BATTLE_HERO_ALIVE)
        {
            action_atb_update(game, hero_id);
            item_atb_update(game, hero_id);
        }
    }
}


/*
 * ver1. 2021/08/04
 * 仲間の行動用ATBゲージの更新処理
 * 
 * ATBゲージ更新計算
 * 基準値   = 基本値(256) - 仲間の素早さ
 * 補正値   = 更新基準値 - (エンチャントの素早さ補正値 + 装備の素早さ補正値) * エンチャントの素早さ倍率
 * 更新速度 = 基準値 * 補正値
 */
static void action_atb_update(GameWrapper *const game, uint8_t hero_id)
{
    if (game->hero[hero_id].battle.condition == UNIT_CONDITION_PARARAI)
    {
        return;
    }

    if (game->hero[hero_id].battle.atb_gauge == ATB_GAUGE_MAX)
    {
        return;
    }

    uint32_t atb_time = ATB_GAUGE_DEFAULT_NUM - game->hero[hero_id].status.agi;
    atb_time *= (BATTLE_HERO_ATB_TIMER - ((game->hero[hero_id].status.enchant.agi + game->hero[hero_id].equip.enchant.agi) * BATTLE_ATB_ENCHANT));

    if (true == tmr_constant(&game->hero[hero_id].battle.atb_timer, atb_time))
    {
        game->hero[hero_id].battle.atb_timer = get_time();
        game->hero[hero_id].battle.atb_gauge++;
        battle_trun_order(game, hero_id);
    }
}


/*
 * ver1. 2021/08/04
 * 仲間のアイテムのATBゲージ更新処理
 */
static void item_atb_update(GameWrapper *const game, uint8_t hero_id)
{
    if (game->hero[hero_id].battle.item_gauge == ATB_GAUGE_MAX)
    {
        return;
    }
    
    if (true == tmr_constant(&game->hero[hero_id].battle.item_timer, fetch_dram_db(game, MEMORY_ITEM_ID, game->hero[hero_id].equip.item, ITEM_SUB_MEMBER_ATB_TIMER)))
    {
        game->hero[hero_id].battle.item_timer = get_time();
        game->hero[hero_id].battle.item_gauge++;
    }
}

/*
 * ver1. 2021/07/04
 * バトル中の行動順の決定処理
 * -
 * 行動順保存配列のインデックスを順番にチェックしていき、空いているチャンネルに下記のデータを保存
 * ATBゲージが貯まったキャラクターのIDをtrun_heroに保存
 * trun_orderに行動可能を表すbool値を保存
 */
static void battle_trun_order(GameWrapper *const game, uint8_t pos)
{
    if (ATB_GAUGE_MAX == game->hero[pos].battle.atb_gauge)
    {
        for (uint8_t i = 0; i < game->conf.battle.hero.counter; i++)
        {
            if (BATTLE_TRUN_ORDER_NOT == game->conf.battle.trun.order[i])
            {
                game->conf.battle.trun.hero[i]  = pos;
                game->conf.battle.trun.order[i] = BATTLE_TRUN_ORDER_CAN;
                break;
            }
        }
    }
}


/*
 * ver2. 2021/08/03
 * 条件に当てはまらなければ途中でreturnし、ネストが深くなりすぎないようにした
 * 
 * ver1. 2021/07/04
 * ATBゲージが溜まったキャラクターのコマンド動作を行う
 * コマンドの決定処理が行われたら行動順をシフト移動し次のキャラクターの行動に移行し、
 * 使用する、わざ、アイテムの実行時間に応じて行動実行順をソートする
 */
static void battle_hero_trun(GameWrapper *const game)
{
    if (BATTLE_TRUN_ORDER_NOT == game->conf.battle.trun.order[0])
    {
        return;
    }

    if (TRUN_SOUND_ON == game->conf.battle.trun.sound)
    {
        bgm_update(game, SOUND_ID_BATTLE_TRUN, SOUND_CH_EFFECT2_WORK);
        game->conf.battle.trun.sound = TRUN_SOUND_OFF;
    }

    cmd_key(game);
    player_frame_draw(game, game->hero[game->conf.battle.trun.hero[0]].battle.draw_pos);
    hero_active_update(game);
}


/*
 * ver1. 2021/07/27
 * 魔法詠唱時の仲間の画像データ切替処理
 */
static void hero_chip_update(GameWrapper *const game)
{
    for (uint8_t i = 0; i < game->conf.battle.hero.counter; i++)
    {
        uint8_t hero_id = game->conf.battle.hero.sort_order[i];

        if ((game->conf.battle.hero.anime_order[hero_id] == BATTLE_HERO_CHIP_MAGIC_1) || (game->conf.battle.hero.anime_order[hero_id] == BATTLE_HERO_CHIP_MAGIC_2))
        {
            if (false == tmr_constant(&game->conf.battle.hero.animation_time[hero_id], BATTLE_MAGIC_CHIP_TIMER))
            {
                continue;
            }

            switch (game->conf.battle.hero.anime_order[hero_id])
            {
            case BATTLE_HERO_CHIP_MAGIC_1:
                game->conf.battle.hero.anime_order[hero_id] = BATTLE_HERO_CHIP_MAGIC_2;
                break;

            case BATTLE_HERO_CHIP_MAGIC_2:
                game->conf.battle.hero.anime_order[hero_id] = BATTLE_HERO_CHIP_MAGIC_1;
                break;

            default:
                break;
            }

            game->conf.battle.hero.animation_time[hero_id] = get_time();
        }
    }
}


/*
 * ver2. 2021/08/09
 * バーサク状態の時の処理を追加
 * コマンドが押された扱いにし最速で攻撃コマンドのデータをセットする
 *
 * ver1. 2021/08/03
 * 仲間のコマンド決定時の行動パターン確定処理
 */
static void hero_active_update(GameWrapper *const game)
{
    if (game->hero[game->conf.battle.trun.hero[0]].battle.condition == UNIT_CONDITION_BERSEK)
    {
        game->cmd.cursol.finish = true;
    }

    if (false == game->cmd.cursol.finish)
    {
        return;
    }

    for (uint8_t i = 0; i < game->conf.battle.hero.counter; i++)
    {
        if (game->conf.battle.effect.active[i] == BATTLE_ACTION_TIMER_ON)
        {
            continue;
        }

        effect_cmd_update(game, i);
        break;
    }

    battle_conf_sort(game);
    battle_atb_shift(game, 0);
    game->conf.battle.trun.sound = TRUN_SOUND_ON;
}


/*
 * ver1. 2021/08/09
 * コマンド確定時のエフェクトデータのセット
 */
static void effect_cmd_update(GameWrapper *const game, uint8_t i)
{
    uint8_t hero_id = game->conf.battle.trun.hero[0];
    uint8_t bersek = (game->hero[hero_id].battle.condition == UNIT_CONDITION_BERSEK) ? 0x00 : 0xff;

    game->conf.battle.effect.id[i]           = (bersek & 0xff) ? game->cmd.window.effect : fetch_dram_db(game, MEMORY_WEAPON_ID, game->hero[hero_id].equip.weapon, WEAPON_SUB_MEMBER_EFFECT_DRAW_ID);
    game->conf.battle.effect.anime_select[i] = game->cmd.window.anime   & bersek;
    game->conf.battle.effect.cursol_enemy[i] = game->cmd.cursol.y_enter & bersek;
    game->conf.battle.effect.cursol_hero[i]  = game->cmd.cursol.y_enter & bersek;
    game->conf.battle.effect.com_time[i]     = get_time();
    game->conf.battle.effect.active[i]       = BATTLE_ACTION_TIMER_ON;
    game->conf.battle.effect.hero_id[i]      = hero_id;

    switch (game->conf.battle.effect.anime_select[i])
    {    
    case COMMAND_ANIME_MAGIC:
        game->conf.battle.effect.wait_time[i] = fetch_dram_db(game, MEMORY_MAGIC_ID, game->cmd.window.effect, MAGIC_SUB_MEMBER_WAIT_TIME);
        break;

    case COMMAND_ANIME_ITEM:
        game->conf.battle.effect.wait_time[i] = fetch_dram_db(game, MEMORY_ITEM_ID, game->cmd.window.effect, ITEM_SUB_MEMBER_WAIT_TIME);
        break;

    default:
        game->conf.battle.effect.wait_time[i] = fetch_dram_db(game, MEMORY_MAGIC_ID, game->cmd.window.effect, MAGIC_SUB_MEMBER_WAIT_TIME);
        break;
    }
}



/*
 * ver1. 2021/08/04
 * エネミーの行動開始決定処理
 */
static void enemy_trun_update(GameWrapper *const game)
{
    for (uint8_t i = 0; i < game->conf.battle.enemy.number; i++)
    {
        if (true == enemy_atb_update(game, i))
        {
            enemy_trun_order(game, i);
            enemy_target_update(game, i);

#ifdef MYDEBUG
            xil_printf("[Enemy Attack ID %d], [Target %d]\n", game->enemy[i].id, game->enemy[i].target_hero);
#endif
        }
    }
}


/*
 * ver2. 2021/08/05
 * 行動中のエネミーのATBゲージを更新しないように変更
 *
 * ver1. 2021/08/03
 * エネミーのATBゲージの更新処理
 */
static bool enemy_atb_update(GameWrapper *const game, uint8_t index)
{
    if (true == isCompareTo(ATB_GAUGE_MAX, game->enemy[index].atb_gauge))
    {
        return false;
    }

    uint32_t atb_time = ATB_GAUGE_DEFAULT_NUM - fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[index].id, ENEMY_SUB_MEMBER_PARA_AGI);
    atb_time *= (BATTLE_ENEMY_ATB_TIMER - (game->enemy[index].enchant.agi * BATTLE_ATB_ENCHANT));

    if (false == tmr_constant(&game->enemy[index].atb_timer, atb_time))
    {
        return false;
    }

    game->enemy[index].atb_timer = get_time();
    game->enemy[index].atb_gauge++;

    return isCompareTo(ATB_GAUGE_MAX, game->enemy[index].atb_gauge);
}

/*
 * ver1. 2021/08/03
 * ATBゲージがたまったエネミーの行動パターンの設定を行う
 * データベースからスキルの数を取得し、それをランダム値に変換してスキルの決定を行う
 * -
 * 使用する技の取得パターン
 * 一般の敵のスキル数は3つである
 * 10進数の3をランダム値に分解すると、0, 1, 1, 2のうちどれかの値を取得できる
 * ENEMY_SUB_MEMBER_PARA_SKILL_1の基準値とランダム値を足すと、0, 1, 2のスキル配列参照用のインデックスが計算できる
 * -
 * スキルの発動のしやすさを並べる、左から順に発動しやすい
 * スキル1、スキル2、スキル3
 */
static void enemy_trun_order(GameWrapper *const game, uint8_t index)
{
    uint8_t skill_rand = get_rand(fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[index].id, ENEMY_SUB_MEMBER_PARA_SKILL_NUM));

    for (uint8_t i = 0; i < game->conf.battle.enemy.counter; i++)
    {
        if (BATTLE_TRUN_ORDER_NOT == game->conf.battle.enemy.trun_order[i])
        {
            game->conf.battle.enemy.trun_order[i] = BATTLE_TRUN_ORDER_CAN;
            game->conf.battle.enemy.sort_order[i] = index;
            game->conf.battle.enemy.effect_id[i]  = fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[index].id, ENEMY_SUB_MEMBER_PARA_SKILL_1 + skill_rand);
            break;
        }
    }
}


/*
 * ver1. 2021/08/03
 * エネミーの攻撃対象の決定処理
 * 隊列の先頭から順番に生存中の仲間を対象に選ぶため、前衛に並び替えるほど攻撃を受けやすい
 */
static void enemy_target_update(GameWrapper *const game, uint8_t index)
{
    uint8_t target = get_time() % game->conf.battle.hero.counter;

    if (game->hero[game->conf.battle.hero.sort_order[target]].battle.arive == BATTLE_HERO_ALIVE)
    {
        game->enemy[index].target_hero = target;
        return;
    }

    for (uint8_t i = 0; i < game->conf.battle.hero.counter; i++)
    {
        if (game->hero[game->conf.battle.hero.sort_order[i]].battle.arive == BATTLE_HERO_ALIVE)
        {
            game->enemy[index].target_hero = i;
            break;
        }
    }
}
