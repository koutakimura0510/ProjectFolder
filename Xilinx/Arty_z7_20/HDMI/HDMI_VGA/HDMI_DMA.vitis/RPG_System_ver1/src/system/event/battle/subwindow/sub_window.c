/*
 * Create 2021/07/23
 * Author kimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * IC
 * -
 * 行動決定時のアニメーションの状態遷移を管理するファイル
 */
#include "../../../wrapper/game_wrapper.h"
#include "../wrapper/local_share.h"


/* ファイル内関数 */
static void skill_window_draw(GameWrapper *const game);
static void skill_list_draw(GameWrapper *const game);
static void item_target_select(GameWrapper *const game);
static void swap_window_draw(GameWrapper *const game);
static void talk_window_draw(GameWrapper *const game);
static void skill_target_select(GameWrapper *const game);
static void skill_target_single(GameWrapper *const game);
static void skill_target_all(GameWrapper *const game);
static void hero_cursol_draw(GameWrapper *const game, uint8_t cursol_loop, uint8_t sort_pos);
static void enemy_cursol_draw(GameWrapper *const game, uint8_t cursol_loop, uint8_t sort_pos);


/*
 * ver2. 2021/08/05
 * メッセージウィンドウの描画処理とアイテム使用時のコマンドとウィンドウ描画処理を追加した
 * 
 * ver1. 2021/07/20
 * サブウィンドウの描画とカーソルの描画位置を管理
 */
void battle_sub_window(GameWrapper *const game)
{
    switch (game->cmd.window.sub_id)
    {
    case BATTLE_WINDOW_SUB_MAGIC:
        skill_window_draw(game);
        break;

    case BATTLE_WINDOW_SUB_ITEM:
        item_target_select(game);
        break;

    case BATTLE_WINDOW_SUB_SWAP:
        swap_window_draw(game);
        break;

    case BATTLE_WINDOW_SUB_TALK:
        talk_window_draw(game);
        break;

    case BATTLE_WINDOW_SUB_CMD:
        skill_target_select(game);
        break;

    default:
        cursol_draw(game, BATTLE_CURSOL_DEFAULT_POS, BATTLE_CURSOL_INTERVAL_YPOS, CURSOL_TYPE_DEFAULT_DRAW);
        break;
    }
}


/*
 * ver3. 2021/07/28
 * ウィンドウのサイズを変更
 * ウィンドウ内に現在の残りSP値を表示するように変更
 *
 * ver2. 2021/07/23
 * 技名の横に消費SPを表示するように変更
 *
 * ver1. 2021/07/20
 * コマンド入力時のスキルウィンドウの描画
 */
static void skill_window_draw(GameWrapper *const game)
{
    patblt(game->conf.work.adr, BATTLE_SKILL_WINDOW_XSTART_WHITE, BATTLE_SKILL_WINDOW_YSTART_WHITE, BATTLE_SKILL_WINDOW_WIDTH_WHITE, BATTLE_SKILL_WINDOW_HEIGHT_WHITE, COLOR_WHITE);
    patblt(game->conf.work.adr, BATTLE_SKILL_WINDOW_XSTART_BLUE,  BATTLE_SKILL_WINDOW_YSTART_BLUE,  BATTLE_SKILL_WINDOW_WIDTH_BLUE,  BATTLE_SKILL_WINDOW_HEIGHT_BLUE,  COLOR_MID_BLUE);
    skill_list_draw(game);
    font_dram_draw(game,   BATTLE_SKILL_ODDSP_STR_XPOS, BATTLE_SKILL_ODDSP_STR_YPOS, MEMORY_CMD_MSG_ID, CMD_MSG_ID_MAGIC_POWER, EVENT_MSG_SUB_MSG, COLOR_WHITE);
    result_font_draw(game, BATTLE_SKILL_ODDSP_NUM_XPOS, BATTLE_SKILL_ODDSP_NUM_YPOS, game->hero[game->conf.battle.trun.hero[0]].status.odd_sp, ZERO_SUP_OFF);
    cursol_draw(game, BATTLE_CURSOL_SKILL_DEFAULT_POS, BATTLE_CURSOL_INTERVAL_YPOS, CURSOL_TYPE_DEFAULT_DRAW);
}


/*TODO メニュー表示時にスキル表示関数として共有するかもしれない
 *
 * ver1. 2021/08/06
 * スキルリストを描画する処理
 */
static void skill_list_draw(GameWrapper *const game)
{
    for (uint32_t i = 0; i < game->hero[game->conf.battle.trun.hero[0]].battle.skill_number; i++)
    {
        uint32_t ypos = (i * BATTLE_CURSOL_INTERVAL) + BATTLE_SKILL_CMD_DEFAULT_YPOS;
        uint8_t skill = game->hero[game->conf.battle.trun.hero[0]].battle.skill[i];
        uint8_t sp    = fetch_dram_db(game, MEMORY_MAGIC_ID, skill, MAGIC_SUB_MEMBER_ROSS_SP);
        font_dram_draw(game,   BATTLE_SKILL_CMD_DEFAULT_XPOS, ypos, MEMORY_MAGIC_ID, skill, MAGIC_SUB_MEMBER_NAME, COLOR_WHITE);
        result_font_draw(game, BATTLE_SKILL_SP_DEFAULT_XPOS,  ypos, sp, ZERO_SUP_OFF);
    }
}


/*
 * ver2. 2021/08/05
 * アイテムウィンドウと同時にコマンド選択処理を行うように変更
 * 
 * ver1. 2021/07/20
 * コマンド入力時のアイテムウィンドウの描画
 */
static void item_target_select(GameWrapper *const game)
{
    uint32_t len;
    uint8_t hero_id = game->conf.battle.trun.hero[0];
    uint8_t range = fetch_dram_db(game, MEMORY_ITEM_ID, game->hero[hero_id].equip.item, ITEM_SUB_MEMBER_RANGE);

    game->conf.battle.loop.item_range = (E_SINGLE == range) ? 1 : game->conf.battle.hero.counter;
    game->conf.battle.loop.item_sort  = (E_SINGLE == range) ? game->cmd.cursol.y : 0;
    fetch_dram_db(game, MEMORY_ITEM_ID, game->hero[hero_id].equip.item, ITEM_SUB_MEMBER_NAME);
    len = *game->conf.db.len * SIZE_FONT_SJIS_WIDTH;
    patblt(game->conf.work.adr, BATTLE_ITEM_WINDOW_XSTART_WHITE, BATTLE_ITEM_WINDOW_YSTART_WHITE, len + ITEM_FRAME_SIZE_WHITE, BATTLE_ITEM_WINDOW_HEIGHT_WHITE, COLOR_WHITE);
    patblt(game->conf.work.adr, BATTLE_ITEM_WINDOW_XSTART_BLUE,  BATTLE_ITEM_WINDOW_YSTART_BLUE,  len + ITEM_FRAME_SIZE_BLUE,  BATTLE_ITEM_WINDOW_HEIGHT_BLUE,  COLOR_MID_BLUE);
    font_dram_draw(game, BATTLE_ITEM_CMD_DEFAULT_XPOS, BATTLE_ITEM_CMD_DEFAULT_YPOS, MEMORY_ITEM_ID, game->hero[hero_id].equip.item, ITEM_SUB_MEMBER_NAME, COLOR_WHITE);
    hero_cursol_draw(game, game->conf.battle.loop.item_range, game->conf.battle.loop.item_sort);
}


/*
 * ver1. 2021/08/11
 * 戦闘中の入れ替え選択時のウィンドウの描画
 */
static void swap_window_draw(GameWrapper *const game)
{
    patblt(game->conf.work.adr, BATTLE_SWAP_XSTART_WHITE, BATTLE_SWAP_YSTART_WHITE, BATTLE_SWAP_WIDTH_WHITE, BATTLE_SWAP_HEIGHT_WHITE, COLOR_WHITE);
    patblt(game->conf.work.adr, BATTLE_SWAP_XSTART_BLUE,  BATTLE_SWAP_YSTART_BLUE,  BATTLE_SWAP_WIDTH_BLUE,  BATTLE_SWAP_HEIGHT_BLUE,  COLOR_MID_BLUE);
    cursol_draw(game, BATTLE_SWAP_DEFAULT_POS, BATTLE_SWAP_INTERVAL_YPOS, CURSOL_TYPE_DEFAULT_DRAW);

    for (uint32_t i = 0; i < game->cmd.cursol.yend + 1; i++)
    {
        uint32_t ypos = (i * BATTLE_CURSOL_INTERVAL) + BATTLE_SWAP_MSG_YSTART;
        font_dram_draw(game, BATTLE_SWAP_MSG_XSTART, ypos, MEMORY_CMD_MSG_ID, CMD_MSG_ID_MINORIKO + game->conf.battle.hero.sort_order[i + game->conf.battle.hero.counter], EVENT_MSG_SUB_MSG, COLOR_WHITE);
    }
}


/*
 * ver1. 2021/08/05
 * 戦闘中のメッセージウィンドウの描画
 */
static void talk_window_draw(GameWrapper *const game)
{
    SDL_Rect rect;

    // fetch_dram_db(game, MEMORY_MAGIC_ID, msg_id, MAGIC_SUB_MEMBER_NAME);
    // rect.x = BATTLE_TALK_MSG_XSTART - (*game->conf.db.len * SIZE_FONT_SJIS_HALF);
    patblt(game->conf.work.adr, BATTLE_TALK_XSTART_WHITE, BATTLE_TALK_YSTART_WHITE, BATTLE_TALK_WIDTH_WHITE, BATTLE_TALK_HEIGHT_WHITE, COLOR_WHITE);
    patblt(game->conf.work.adr, BATTLE_TALK_XSTART_BLUE,  BATTLE_TALK_YSTART_BLUE,  BATTLE_TALK_WIDTH_BLUE,  BATTLE_TALK_HEIGHT_BLUE,  COLOR_MID_BLUE);
    // font_dram_draw(game, rect.x, BATTLE_TALK_MSG_YSTART, MEMORY_EVENT_MSG_ID, msg_id, EVENT_SUB_MEMBER_MSG, COLOR_WHITE);
}


/*
 * ver2. 2021/07/29
 * 選択中のわざの効果範囲を取得し、範囲が全体ならばカーソルを全ての対象に描画するように変更
 * -
 * ver1. 2021/07/20
 * バトル中にキャラクターを選択する場合のコマンドカーソル描画処理
 */
static void skill_target_select(GameWrapper *const game)
{
    switch (fetch_dram_db(game, MEMORY_MAGIC_ID, game->cmd.window.effect, MAGIC_SUB_MEMBER_RANGE))
    {
    case E_SINGLE:
        skill_target_single(game);
        break;

    case E_ALL:
        skill_target_all(game);
        break;

    default:
        break;
    }
}


/*
 * ver1. 2021/08/06
 * 行動確定時の仲間のターゲット選択処理
 */
static void skill_target_single(GameWrapper *const game)
{
    if ((game->cmd.window.system == COMMAND_BATTLE_UNIT) || (game->cmd.window.system == COMMAND_BATTLE_MAGIC_UNIT))
    {
        hero_cursol_draw(game, 1, game->cmd.cursol.y);
    }
    else
    {
        enemy_cursol_draw(game, 1, game->cmd.cursol.y);
    }
}


/*
 * ver1. 2021/08/06
 * 行動確定時の敵のターゲット選択処理
 */
static void skill_target_all(GameWrapper *const game)
{
    if ((game->cmd.window.system == COMMAND_BATTLE_UNIT) || (game->cmd.window.system == COMMAND_BATTLE_MAGIC_UNIT))
    {
        hero_cursol_draw(game, game->conf.battle.hero.counter, 0);
    }
    else
    {
        enemy_cursol_draw(game, game->conf.battle.enemy.number, 0);
    }
}


/*
 * ver1. 2021/08/06
 * 仲間の位置のカーソル描画処理
 * 
 * cursol_loop  全体描画ならばgame->conf.battle.hero.counterを引数に指定、単体描画ならば1を指定
 * sort_pos     全体描画ならば0を指定、単体描画ならばgame->cmd.cursol.yを指定
 */
static void hero_cursol_draw(GameWrapper *const game, uint8_t cursol_loop, uint8_t sort_pos)
{
    for (uint8_t i = 0; i < cursol_loop; i++)
    {
        cursol_draw(game, game->hero[game->conf.battle.hero.sort_order[sort_pos + i]].battle.draw_pos - SIZE_ICON_2_WIDTH_POS, 0, CURSOL_TYPE_DECORATION_DRAW);
    }
}


/*
 * ver1. 2021/08/06
 * 敵の位置のカーソル描画処理
 * 
 * cursol_loop  全体描画ならばgame->conf.battle.enemy.numberを引数に指定、単体描画ならば1を指定
 * sort_pos     全体描画ならば0を指定、単体描画ならばgame->cmd.cursol.yを指定
 */
static void enemy_cursol_draw(GameWrapper *const game, uint8_t cursol_loop, uint8_t sort_pos)
{
    for (uint8_t i = 0; i < cursol_loop; i++)
    {
        cursol_draw(game, game->enemy[sort_pos + i].draw_pos, 0, CURSOL_TYPE_DECORATION_DRAW);
    }
}
