/*
 * Create 2021/08/15
 * Author kimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * IC
 * -
 * メニュー構成の関数を管理
 */
#include "../../wrapper/game_wrapper.h"


/* ファイル内関数 */
static void menu_select_window(GameWrapper *const game);
static void menu_talk_window(GameWrapper *const game);
static void menu_paty_window(GameWrapper *const game);
static void menu_cook_window(GameWrapper *const game);
static void paty_frame_draw(GameWrapper *const game);
static void paty_entry_draw(GameWrapper *const game);
static void paty_explain_draw(GameWrapper *const game);
static void paty_config_draw(GameWrapper *const game);
static void paty_cursol_draw(GameWrapper *const game);
static void paty_status_draw(GameWrapper *const game);
static void paty_list_draw(GameWrapper *const game, uint8_t cursol_pos);
static void cook_frame_draw(GameWrapper *const game);
static void cook_name_draw(GameWrapper *const game);
static void cook_conf_draw(GameWrapper *const game);
static void cook_cursol_draw(GameWrapper *const game);
static void cook_result_draw(GameWrapper *const game);


/*
 * ver1. 2021/08/16
 * メニュー画面の攻勢に必要なのメンバの初期設定
 */
void menu_window_init(GameWrapper *const game)
{
    game->conf.display.system = SYSTEM_MENU_WINDOW;
    cmd_db_reset(game, COMMAND_MENU_SYSTEM, 0);
    patblt(DRAM_COLOR_PALLET_ADDR_BASE, 0, 0, VIDEO_WIDTH, VIDEO_HEIGHT, COLOR_BLACK_ADD);
    bgm_update(game, SOUND_ID_CMD_BUTTON, SOUND_CH_KEY_WORK);
}


/*
 * ver1. 2021/08/15
 * メニュー画面を表示させる
 * 
 * MENU_SELECT_WINDOW 下記の選択画面を描画するモード
 * MENU_TALK_WINDOW はなす
 * MENU_PATY_WINDOW なかま
 * MENU_COOK_WINDOW たべる
 * MENU_SELECT_END  メニューを終了する
 */
void menu_window_wrapper(GameWrapper *const game)
{
    cmd_key(game);

    switch (game->conf.display.sub_state)
    {
    case MENU_SELECT_WINDOW:
        menu_select_window(game);
        break;

    case MENU_TALK_WINDOW:
        menu_talk_window(game);
        break;

    case MENU_PATY_WINDOW:
        menu_paty_window(game);
        break;

    case MENU_COOK_WINDOW:
        menu_cook_window(game);
        break;

    case MENU_SELECT_END:
        game->conf.display.system    = SYSTEM_MAP_DEFAULT_WINDOW;
        game->conf.display.drawtype  = DISPLAY_FIELD_CENTER_DRAW;
        break;

    default:
        break;
    }
}


/*
 * ver1. 2021/08/15
 * メニューウィンドウの選択画面の描画処理
 * 
 * はなす、なかま、たべるのメニュー表示と所持金の表示を行う
 */
static void menu_select_window(GameWrapper *const game)
{
    patblt(game->conf.work.adr, MENU_SELECT_XSTART_WHITE, MENU_SELECT_YSTART_WHITE, MENU_SELECT_WIDTH_WHITE, MENU_SELECT_HEIGHT_WHITE, COLOR_WHITE);
    patblt(game->conf.work.adr, MENU_SELECT_XSTART_BLACK, MENU_SELECT_YSTART_BLACK, MENU_SELECT_WIDTH_BLACK, MENU_SELECT_HEIGHT_BLACK, COLOR_BLACK);
    cursol_draw(game, MENU_SELECT_CURSOL_DEFAULT, MENU_SELECT_CURSOL_INTERVAL_YPOS, CURSOL_TYPE_DEFAULT_DRAW);
    font_dram_draw(game, MENU_SELECT_MSG_XSTART, MENU_SELECT_MSG_YSTART, MEMORY_CMD_MSG_ID, CMD_MSG_ID_MENU_SELECT, EVENT_MSG_SUB_MSG, COLOR_WHITE);

    //TODO 所持金の表示追加
}



/*
 * ver1. 2021/08/15
 * メニューウィンドウの話すコマンドを選択時の処理
 */
static void menu_talk_window(GameWrapper *const game)
{
    game->conf.event.id = DIRECT_ROMEN_ID_KANBAN3_1;
    event_msg_draw(game);
}


/**
 * @brief   メニュー画面操作時のパーティ設定画面の構成を管理
 * @ingroup menu paty
 *
 * @note 
 *
 * @param  wrapper game
 * @return 
 * @version 1.0 2021/08/28
 */
static void menu_paty_window(GameWrapper *const game)
{
    paty_frame_draw(game);
    paty_entry_draw(game);
    paty_explain_draw(game);
    paty_config_draw(game);
    battle_player_draw(game, game->conf.system.paty_member);
    paty_cursol_draw(game);
}


/**
 * @brief   仲間ステータス画面の枠の描画処理
 * @ingroup menu paty
 *
 * @note 
 *
 * @version 1.0 2021/08/28
 */
static void paty_frame_draw(GameWrapper *const game)
{
    patblt(game->conf.work.adr, MENU_PATY_MAIN_XSTART_OUTFRAME,   MENU_PATY_MAIN_YSTART_OUTFRAME,   MENU_PATY_MAIN_WIDTH_OUTFRAME,   MENU_PATY_MAIN_HEIGHT_OUTFRAME,    COLOR_WHITE);
    patblt(game->conf.work.adr, MENU_PATY_MAIN_XSTART_INFRAME,    MENU_PATY_MAIN_YSTART_INFRAME,    MENU_PATY_MAIN_WIDTH_INFRAME,    MENU_PATY_MAIN_HEIGHT_INFRAME,     COLOR_BLACK);
    patblt(game->conf.work.adr, MENU_PATY_EQUIP_XSTART_OUTFRAME,  MENU_PATY_EQUIP_YSTART_OUTFRAME,  MENU_PATY_EQUIP_WIDTH_OUTFRAME,  MENU_PATY_EQUIP_HEIGHT_OUTFRAME,   COLOR_WHITE);
    patblt(game->conf.work.adr, MENU_PATY_EQUIP_XSTART_INFRAME,   MENU_PATY_EQUIP_YSTART_INFRAME,   MENU_PATY_EQUIP_WIDTH_INFRAME,   MENU_PATY_EQUIP_HEIGHT_INFRAME,    COLOR_MID_BLUE);
    patblt(game->conf.work.adr, MENU_PATY_REVIEW_XSTART_OUTFRAME, MENU_PATY_REVIEW_YSTART_OUTFRAME, MENU_PATY_REVIEW_WIDTH_OUTFRAME, MENU_PATY_REVIEW_HEIGHT_OUTFRAME,  COLOR_WHITE);
    patblt(game->conf.work.adr, MENU_PATY_REVIEW_XSTART_INFRAME,  MENU_PATY_REVIEW_YSTART_INFRAME,  MENU_PATY_REVIEW_WIDTH_INFRAME,  MENU_PATY_REVIEW_HEIGHT_INFRAME,   COLOR_MID_BLUE);
    patblt(game->conf.work.adr, MENU_PATY_LIST_XSTART_OUTFRAME,   MENU_PATY_LIST_YSTART_OUTFRAME,   MENU_PATY_LIST_WIDTH_OUTFRAME,   MENU_PATY_LIST_HEIGHT_OUTFRAME,    COLOR_WHITE);
    patblt(game->conf.work.adr, MENU_PATY_LIST_XSTART_INFRAME,    MENU_PATY_LIST_YSTART_INFRAME,    MENU_PATY_LIST_WIDTH_INFRAME,    MENU_PATY_LIST_HEIGHT_INFRAME,     COLOR_MID_BLUE);
}


/*
 * ver1. 2021/08/25
 * 仲間ステータス画面の登録中の装備と道具の描画処理
 */
static void paty_entry_draw(GameWrapper *const game)
{
    font_dram_draw(game, MENU_PATY_EQUIP_STR_X,  MENU_PATY_EQUIP_STR_Y,  MEMORY_CMD_MSG_ID, CMD_MSG_ID_MENU_PATY_EQUIP, EVENT_MSG_SUB_MSG, COLOR_WHITE);
    font_dram_draw(game, MENU_PATY_WEAPON_STR_X, MENU_PATY_WEAPON_STR_Y, MEMORY_WEAPON_ID, game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.weapon, WEAPON_SUB_MEMBER_NAME, COLOR_WHITE);
    font_dram_draw(game, MENU_PATY_ARMOR_STR_X,  MENU_PATY_ARMOR_STR_Y,  MEMORY_ARMOR_ID,  game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.armor,  ARMOR_SUB_MEMBER_NAME,  COLOR_WHITE);
    font_dram_draw(game, MENU_PATY_AMULET_STR_X, MENU_PATY_AMULET_STR_Y, MEMORY_AMULET_ID, game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.amulet, AMULET_SUB_MEMBER_NAME, COLOR_WHITE);
    font_dram_draw(game, MENU_PATY_ITEM_STR_X,   MENU_PATY_ITEM_STR_Y,   MEMORY_ITEM_ID,   game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.item,   ITEM_SUB_MEMBER_NAME,   COLOR_WHITE);
}


/**
 * @brief  仲間ステータス画面のカーソル選択中のコマの説明文を描画
 * @note   
 */
static void paty_explain_draw(GameWrapper *const game)
{
    SDL_Cursol cursol;
    uint32_t type = 0;

    switch (game->cmd.sub_system)
    {
    case COMMAND_SUB:
        if (game->cmd.cursol.y != 0)
        {
            font_dram_draw(game, MENU_PATY_REVIEW_STR_2_XSTART, MENU_PATY_REVIEW_STR_2_YSTART, MEMORY_CMD_MSG_ID, CMD_MSG_ID_MENU_PATY_WEAPON_ATK, EVENT_MSG_SUB_MSG, COLOR_WHITE);
            font_dram_draw(game, MENU_PATY_REVIEW_STR_3_XSTART, MENU_PATY_REVIEW_STR_3_YSTART, MEMORY_CMD_MSG_ID, CMD_MSG_ID_MENU_PATY_ARMOR_DEF,  EVENT_MSG_SUB_MSG, COLOR_WHITE);
        }
        cursol.col = game->cmd.cursol.y;

        switch (cursol.col) /* 装備中のIを取得 */
        {
        case CURSOL_WEAPON_CHANGE:
            cursol.scroll = game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.weapon;
            break;

        case CURSOL_ARMOR_CHANGE:
            cursol.scroll = game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.armor;
            break;

        case CURSOL_AMULET_CHANGE:
            cursol.scroll = game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.amulet;
            break;

        case CURSOL_ITEM_CHANGE:
            cursol.scroll = game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.item;
            break;

        default:
            break;
        }
        break;

    case COMMAND_SUB_PATY_SWAP:
        cursol.col = 0;
        break;

    case COMMAND_SUB_PATY_LIST:
        cursol.scroll = game->cmd.cursol.y;
        cursol.col    = game->cmd.cursol.oldy;
        font_dram_draw(game, MENU_PATY_REVIEW_STR_2_XSTART, MENU_PATY_REVIEW_STR_2_YSTART, MEMORY_CMD_MSG_ID, CMD_MSG_ID_MENU_PATY_WEAPON_ATK, EVENT_MSG_SUB_MSG, COLOR_WHITE);
        font_dram_draw(game, MENU_PATY_REVIEW_STR_3_XSTART, MENU_PATY_REVIEW_STR_3_YSTART, MEMORY_CMD_MSG_ID, CMD_MSG_ID_MENU_PATY_ARMOR_DEF,  EVENT_MSG_SUB_MSG, COLOR_WHITE);
        break;

    default:
        break;
    }

    switch (cursol.col)
    {
    case CURSOL_WEAPON_CHANGE:
        font_dram_draw(game, MENU_PATY_REVIEW_STR_1_XSTART, MENU_PATY_REVIEW_STR_1_YSTART, MEMORY_WEAPON_ID, game->conf.item.weapon[cursol.scroll], WEAPON_SUB_MEMBER_MSG, COLOR_WHITE);
        result_font_draw(game, MENU_PATY_REVIEW_STR_4_XSTART, MENU_PATY_REVIEW_STR_4_YSTART, fetch_dram_db(game, MEMORY_WEAPON_ID, game->conf.item.weapon[cursol.scroll], WEAPON_SUB_MEMBER_ATK), ZERO_SUP_OFF);
        type = fetch_dram_db(game, MEMORY_ELEMENT_WEAPON_ID, game->conf.item.weapon[cursol.scroll], WEAPON_ELEMENT_SUB_MEMBER_TYPE_BIT);
        break;

    case CURSOL_ARMOR_CHANGE:
        font_dram_draw(game, MENU_PATY_REVIEW_STR_1_XSTART, MENU_PATY_REVIEW_STR_1_YSTART, MEMORY_ARMOR_ID, game->conf.item.armor[cursol.scroll], ARMOR_SUB_MEMBER_MSG, COLOR_WHITE);
        result_font_draw(game, MENU_PATY_REVIEW_STR_6_XSTART, MENU_PATY_REVIEW_STR_6_YSTART, fetch_dram_db(game, MEMORY_ARMOR_ID, game->conf.item.armor[cursol.scroll], ARMOR_SUB_MEMBER_DEF), ZERO_SUP_OFF);
        result_font_draw(game, MENU_PATY_REVIEW_STR_7_XSTART, MENU_PATY_REVIEW_STR_7_YSTART, fetch_dram_db(game, MEMORY_ARMOR_ID, game->conf.item.armor[cursol.scroll], ARMOR_SUB_MEMBER_RES), ZERO_SUP_OFF);
        type = fetch_dram_db(game, MEMORY_ELEMENT_ARMOR_ID, game->conf.item.armor[cursol.scroll], ARMOR_ELEMENT_SUB_MEMBER_TYPE_BIT);
        break;

    case CURSOL_AMULET_CHANGE:
        font_dram_draw(game, MENU_PATY_REVIEW_STR_1_XSTART, MENU_PATY_REVIEW_STR_1_YSTART, MEMORY_AMULET_ID, game->conf.item.amulet[cursol.scroll], AMULET_SUB_MEMBER_MSG, COLOR_WHITE);
        type = fetch_dram_db(game, MEMORY_ELEMENT_AMULET_ID, game->conf.item.amulet[cursol.scroll], AMULET_ELEMENT_SUB_MEMBER_TYPE_BIT);
        break;

    case CURSOL_ITEM_CHANGE:
        font_dram_draw(game, MENU_PATY_REVIEW_STR_1_XSTART, MENU_PATY_REVIEW_STR_1_YSTART, MEMORY_ITEM_ID, game->conf.item.tool[cursol.scroll], ITEM_SUB_MEMBER_MSG, COLOR_WHITE);
        break;

    default:
        break;
    }

    cursol.xpos = 0;

    for (uint32_t i = 0; i < UNIT_RES_SIZE; i++)
    {
        if (type & (0x00000001 << i))
        {
            font_dram_draw(game, MENU_PATY_REVIEW_STR_5_XSTART + cursol.xpos, MENU_PATY_REVIEW_STR_5_YSTART, MEMORY_TYPE_STR_ID, type & (0x00000001 << i), TYPE_STR_SUB_MEMBER_MSG, COLOR_WHITE);
            cursol.xpos += SIZE_FONT_SJIS_WIDTH;
        }
    }
}


/**
 * @brief  仲間選択中はステータスを描画し、装備と道具選択中は一覧の描画をする
 * @note   
 * @retval None
 */
static void paty_config_draw(GameWrapper *const game)
{
    switch (game->cmd.sub_system)
    {
    case COMMAND_SUB:
        if (game->cmd.cursol.y == 0)
        {
            paty_status_draw(game);
        }
        else
        {
            paty_list_draw(game, game->cmd.cursol.y);
        }
        player_frame_draw(game, game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].battle.draw_pos);
        break;

    case COMMAND_SUB_PATY_SWAP:
        paty_status_draw(game);
        player_frame_draw(game, game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.oldx]].battle.draw_pos);
        image_addition(game, 150);
        break;

    case COMMAND_SUB_PATY_LIST:
        player_frame_draw(game, game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].battle.draw_pos);
        paty_list_draw(game, game->cmd.cursol.oldy);
        break;

    default:
        break;
    }
}


/**
 * @brief  仲間のステータスの描画
 * @note
 * @retval None
 */
static void paty_status_draw(GameWrapper *const game)
{
    font_dram_draw(game,   MENU_PATY_LIST_STR_1_XSTART, MENU_PATY_LIST_STR_1_YSTART,  MEMORY_CMD_MSG_ID, CMD_MSG_ID_MENU_PATY_STATUS, EVENT_MSG_SUB_MSG, COLOR_WHITE);
    result_font_draw(game, MENU_PATY_LIST_STR_2_XSTART, MENU_PATY_LIST_STR_1_YSTART,  game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].status.level,  ZERO_SUP_STATUS);
    result_font_draw(game, MENU_PATY_LIST_STR_2_XSTART, MENU_PATY_LIST_STR_2_YSTART,  game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].status.hp,     ZERO_SUP_STATUS);
    result_font_draw(game, MENU_PATY_LIST_STR_2_XSTART, MENU_PATY_LIST_STR_3_YSTART,  game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].status.sp,     ZERO_SUP_STATUS);
    result_font_draw(game, MENU_PATY_LIST_STR_2_XSTART, MENU_PATY_LIST_STR_4_YSTART,  game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].status.atk,    ZERO_SUP_STATUS);
    result_font_draw(game, MENU_PATY_LIST_STR_2_XSTART, MENU_PATY_LIST_STR_5_YSTART,  game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].status.def,    ZERO_SUP_STATUS);
    result_font_draw(game, MENU_PATY_LIST_STR_2_XSTART, MENU_PATY_LIST_STR_6_YSTART,  game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].status.mag,    ZERO_SUP_STATUS);
    result_font_draw(game, MENU_PATY_LIST_STR_2_XSTART, MENU_PATY_LIST_STR_7_YSTART,  game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].status.res,    ZERO_SUP_STATUS);
    result_font_draw(game, MENU_PATY_LIST_STR_2_XSTART, MENU_PATY_LIST_STR_8_YSTART,  game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].status.agi,    ZERO_SUP_STATUS);
    result_font_draw(game, MENU_PATY_LIST_STR_2_XSTART, MENU_PATY_LIST_STR_9_YSTART,  game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].status.love,   ZERO_SUP_STATUS);
    result_font_draw(game, MENU_PATY_LIST_STR_2_XSTART, MENU_PATY_LIST_STR_10_YSTART, game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].status.odd_hp, ZERO_SUP_STATUS);
    result_font_draw(game, MENU_PATY_LIST_STR_2_XSTART, MENU_PATY_LIST_STR_11_YSTART, game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].status.odd_sp, ZERO_SUP_STATUS);
    result_font_draw(game, MENU_PATY_LIST_STR_2_XSTART, MENU_PATY_LIST_STR_12_YSTART, game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].status.exp,    ZERO_SUP_STATUS);
}



/* TODO
 * そのうちram構造体の内容をDRAMに保存にするように変更予定のため
 * 関数を小分けにせずに、とりあえず一つの関数内に全ての処理を書いている
 */
/** 
 * @brief  選択した候補のリストの描画処理
 * @note   
 */
static void paty_list_draw(GameWrapper *const game, uint8_t cursol_pos)
{
    SDL_Cursol cursol;
    cursol.col    = game->cmd.cursol.y - (MENU_LIST_NUMBER - 1);
    cursol.scroll = (cursol.col < 0) ? 0 : cursol.col;

    for (uint32_t i = 0; i < MENU_LIST_NUMBER; i++)
    {
        cursol.ypos  = MENU_PATY_LIST_STR_1_YSTART + (i * SIZE_FONT_SJIS_HEIGHT);
        cursol.color = (i == (game->cmd.cursol.y - cursol.scroll)) ? COLOR_YELLOW : COLOR_WHITE;
        cursol.color = (game->cmd.sub_system == COMMAND_SUB) ? COLOR_WHITE : cursol.color;

        if ((cursol.scroll + i) != 0)
        {
            for (uint8_t j = 0; j < game->conf.system.paty_member; j++)
            {
                switch (cursol_pos)
                {
                case CURSOL_WEAPON_CHANGE:
                    cursol.color = (fetch_dram_db(game, MEMORY_WEAPON_ID, game->conf.item.weapon[cursol.scroll + i], WEAPON_SUB_MEMBER_EQUIP_HERO) & (0x00000001 << game->conf.battle.hero.sort_order[game->cmd.cursol.x])) ? cursol.color : COLOR_LIGHT_GLAY;
                    cursol.color = (game->hero[game->conf.battle.hero.sort_order[j]].equip.weapon == game->conf.item.weapon[cursol.scroll + i]) ? COLOR_LIGHT_GLAY : cursol.color;
                    break;

                case CURSOL_ARMOR_CHANGE:
                    cursol.color = (fetch_dram_db(game, MEMORY_ARMOR_ID, game->conf.item.armor[cursol.scroll + i], ARMOR_SUB_MEMBER_EQUIP_HERO) & (0x00000001 << game->conf.battle.hero.sort_order[game->cmd.cursol.x])) ? cursol.color : COLOR_LIGHT_GLAY;
                    cursol.color = (game->hero[game->conf.battle.hero.sort_order[j]].equip.armor == game->conf.item.armor[cursol.scroll + i]) ? COLOR_LIGHT_GLAY : cursol.color;
                    break;

                case CURSOL_AMULET_CHANGE:
                    cursol.color = (fetch_dram_db(game, MEMORY_AMULET_ID, game->conf.item.amulet[cursol.scroll + i], AMULET_SUB_MEMBER_EQUIP_HERO) & (0x00000001 << game->conf.battle.hero.sort_order[game->cmd.cursol.x])) ? cursol.color : COLOR_LIGHT_GLAY;
                    cursol.color = (game->hero[game->conf.battle.hero.sort_order[j]].equip.amulet == game->conf.item.amulet[cursol.scroll + i]) ? COLOR_LIGHT_GLAY : cursol.color;
                    break;

                case CURSOL_ITEM_CHANGE:
                    cursol.color = (game->hero[game->conf.battle.hero.sort_order[j]].equip.item == game->conf.item.tool[cursol.scroll + i]) ? COLOR_LIGHT_GLAY : cursol.color;
                    break;

                default:
                    break;
                }

                if (cursol.color == COLOR_LIGHT_GLAY)
                {
                    break;
                }
            }
        }


        switch (cursol_pos)
        {
        case CURSOL_WEAPON_CHANGE:
            font_dram_draw(game, MENU_PATY_LIST_STR_3_XSTART, cursol.ypos, MEMORY_WEAPON_ID, game->conf.item.weapon[cursol.scroll+i], WEAPON_SUB_MEMBER_NAME, cursol.color);
            break;

        case CURSOL_ARMOR_CHANGE:
            font_dram_draw(game, MENU_PATY_LIST_STR_3_XSTART, cursol.ypos, MEMORY_ARMOR_ID, game->conf.item.armor[cursol.scroll+i], ARMOR_SUB_MEMBER_NAME, cursol.color);
            break;

        case CURSOL_AMULET_CHANGE:
            font_dram_draw(game, MENU_PATY_LIST_STR_3_XSTART, cursol.ypos, MEMORY_AMULET_ID, game->conf.item.amulet[cursol.scroll+i], AMULET_SUB_MEMBER_NAME, cursol.color);
            break;

        case CURSOL_ITEM_CHANGE:
            font_dram_draw(game, MENU_PATY_LIST_STR_3_XSTART, cursol.ypos, MEMORY_ITEM_ID, game->conf.item.tool[cursol.scroll+i], ITEM_SUB_MEMBER_NAME, cursol.color);
            break;

        default:
            break;
        }
    }
}




/**
 * @brief   仲間メニュー画面のカーソルの描画処理
 * @note    カーソルのy座標と選択中の項目によってカーソルの描画基本位置を変更する
 *          
 */
static void paty_cursol_draw(GameWrapper *const game)
{
    SDL_Cursol cursol;

    cursol.col    = game->cmd.cursol.y - (MENU_LIST_NUMBER - 1);
    cursol.scroll = (cursol.col < 0) ? 0 : cursol.col;

    switch (game->cmd.sub_system)
    {
    case COMMAND_SUB:
        if (game->cmd.cursol.y == 0)
        {
            return;
        }
        cursol.ypos = MENU_PATY_EQUIP_CURSOL_POS - YRGB(SIZE_FONT_SJIS_HEIGHT);
        cursol.xpos = 0;
        break;

    case COMMAND_SUB_PATY_SWAP:
        cursol.ypos = MENU_PATY_HERO_CURSOL_POS;
        cursol.xpos = XRGB((game->cmd.cursol.x * SIZE_UNIT_WIDTH));
        break;

    case COMMAND_SUB_PATY_LIST:
        cursol.ypos = MENU_PATY_LIST_CURSOL_POS;
        cursol.xpos = 0;
        break;

    default:
        break;
    }

    cursol_draw(game, cursol.ypos + cursol.xpos - (cursol.scroll * MENU_SELECT_CURSOL_INTERVAL_YPOS), MENU_SELECT_CURSOL_INTERVAL_YPOS, CURSOL_TYPE_DEFAULT_DRAW);
}


/*
 * ver1. 2021/08/15
 * メニューウィンドウの料理コマンドを選択時の処理
 * 
 * 枠が複数あり、大枠の中に料理名を描画する枠と説明文を描画する枠を作成する
 */
static void menu_cook_window(GameWrapper *const game)
{
    cook_frame_draw(game);
    cook_name_draw(game);
    cook_conf_draw(game);
    battle_player_draw(game, game->conf.system.paty_member);
    cook_cursol_draw(game);
    cook_result_draw(game);
}


/*
 * ver1. 2021/08/18
 * 料理メニュー画面の画面構成の描画処理
 */
static void cook_frame_draw(GameWrapper *const game)
{
    patblt(game->conf.work.adr, MENU_COOK_MAIN_XSTART_WHITE, MENU_COOK_MAIN_YSTART_WHITE, MENU_COOK_MAIN_WIDTH_WHITE, MENU_COOK_MAIN_HEIGHT_WHITE, COLOR_WHITE);
    patblt(game->conf.work.adr, MENU_COOK_MAIN_XSTART_BLACK, MENU_COOK_MAIN_YSTART_BLACK, MENU_COOK_MAIN_WIDTH_BLACK, MENU_COOK_MAIN_HEIGHT_BLACK, COLOR_BLACK);
    patblt(game->conf.work.adr, MENU_COOK_NAME_XSTART_WHITE, MENU_COOK_NAME_YSTART_WHITE, MENU_COOK_NAME_WIDTH_WHITE, MENU_COOK_NAME_HEIGHT_WHITE, COLOR_WHITE);
    patblt(game->conf.work.adr, MENU_COOK_NAME_XSTART_BLACK, MENU_COOK_NAME_YSTART_BLACK, MENU_COOK_NAME_WIDTH_BLACK, MENU_COOK_NAME_HEIGHT_BLACK, COLOR_MID_BLUE);
    patblt(game->conf.work.adr, MENU_COOK_CONF_XSTART_WHITE, MENU_COOK_CONF_YSTART_WHITE, MENU_COOK_CONF_WIDTH_WHITE, MENU_COOK_CONF_HEIGHT_WHITE, COLOR_WHITE);
    patblt(game->conf.work.adr, MENU_COOK_CONF_XSTART_BLACK, MENU_COOK_CONF_YSTART_BLACK, MENU_COOK_CONF_WIDTH_BLACK, MENU_COOK_CONF_HEIGHT_BLACK, COLOR_MID_BLUE);
}


/*
 * ver1. 2021/08/18
 * 料理名の描画処理
 * 
 * カーソルの位置が表示画面の下まで移動した時に料理名のスクロール表示をする
 */
static void cook_name_draw(GameWrapper *const game)
{
    SDL_Cursol cursol;
    cursol.col    = game->cmd.cursol.y - (MENU_COOK_MAX_NUMBER - 1);
    cursol.scroll = (cursol.col < 0) ? 0 : cursol.col;

    for (uint32_t i = 0; i < MENU_COOK_MAX_NUMBER; i++)
    {
        uint32_t ypos = MENU_COOK_NAME_MSG_YSTART + (i * SIZE_FONT_SJIS_HEIGHT);
        cursol.color = (i == (game->cmd.cursol.y - cursol.scroll)) ? COLOR_YELLOW : COLOR_WHITE;
        font_dram_draw(game, MENU_COOK_NAME_MSG_XSTART, ypos, MEMORY_COOK_ID, game->conf.cook.master[i + cursol.scroll], COOK_SUB_MEMBER_NAME, cursol.color);
    }
}


/*
 * ver1. 2021/08/18
 * 選択中の料理の、説明文、熟練度の描画処理
 */
static void cook_conf_draw(GameWrapper *const game)
{
    SDL_Cursol cursol;

    /* 熟練度の描画 */
    cursol.col = game->conf.cook.level[game->cmd.cursol.y] + CMD_MSG_ID_MENU_MASTER_LV1;
    cursol.color = (cursol.col == CMD_MSG_ID_MENU_MASTER_LV5) ? COLOR_YELLOW : COLOR_WHITE;
    font_dram_draw(game, MENU_COOK_MASTER_NUM_XSTART, MENU_COOK_MASTER_NUM_YSTART, MEMORY_CMD_MSG_ID, cursol.col, EVENT_MSG_SUB_MSG, cursol.color);

    /* 説明 */
    font_dram_draw(game, MENU_COOK_MASTER_MSG_XSTART, MENU_COOK_MASTER_MSG_YSTART, MEMORY_CMD_MSG_ID, CMD_MSG_ID_MENU_MASTER, EVENT_MSG_SUB_MSG, COLOR_WHITE);

    /* 【熟練度】の文字列描画 */
    font_dram_draw(game, MENU_COOK_CONF_MSG_XSTART,   MENU_COOK_CONF_MSG_YSTART,   MEMORY_COOK_ID, game->conf.cook.master[game->cmd.cursol.y], COOK_SUB_MEMBER_MSG, COLOR_WHITE);
}


/*
 * ver1. 2021/08/21
 * 料理画面のカーソルの描画処理
 * メニューのカーソルが画面外に移動しないように、スクロールメンバを利用して座標を調整する
 */
static void cook_cursol_draw(GameWrapper *const game)
{
    SDL_Cursol cursol;

    cursol.col    = game->cmd.cursol.y - (MENU_COOK_MAX_NUMBER - 1);
    cursol.scroll = (cursol.col < 0) ? 0 : cursol.col;
    cursol_draw(game, MENU_COOK_CURSOL_DEFAULT - (cursol.scroll * MENU_SELECT_CURSOL_INTERVAL_YPOS), MENU_SELECT_CURSOL_INTERVAL_YPOS, CURSOL_TYPE_DEFAULT_DRAW);
}


/**
 * @brief  cook challenge or result window draw
 * @note   COMMAND_SUB_COOK_CHALLENGE request cook window draw
 *         COMMAND_SUB_COOK_SUCCESS success window draw
 *         COMMAND_SUB_COOK_FAILURE fail window draw
 * @retval None
 */
static void cook_result_draw(GameWrapper *const game)
{
    SDL_Rect rect;
    uint8_t result;

    switch (game->cmd.sub_system)
    {
    case COMMAND_SUB:
        break;

    case COMMAND_SUB_COOK_CHALLENGE:
        image_addition(game, 150);
        rect.y = MENU_COOK_NAME_MSG_YSTART + (game->cmd.cursol.y * SIZE_FONT_SJIS_HEIGHT);
        rect.w = SIZE_FONT_SJIS_WIDTH * 3;
        rect.h = SIZE_FONT_SJIS_HEIGHT;
        patblt(game->conf.work.adr, MENU_COOK_NAME_XSTART_BLACK,   rect.y-2, rect.w+4, rect.h+4, COLOR_WHITE);
        patblt(game->conf.work.adr, MENU_COOK_NAME_XSTART_BLACK+1, rect.y-1, rect.w+2, rect.h+2, COLOR_MID_BLUE);
        font_dram_draw(game, MENU_COOK_NAME_XSTART_BLACK+2, rect.y, MEMORY_CMD_MSG_ID, CMD_MSG_ID_MENU_EART, EVENT_MSG_SUB_MSG, COLOR_WHITE);
        break;

    default:
        image_addition(game, 70);
        result = (game->cmd.sub_system == COMMAND_SUB_COOK_SUCCESS) ? 0 : 1;
        patblt(game->conf.work.adr, MENU_COOK_SUCCESS_X_OUTSIDE, MENU_COOK_SUCCESS_Y_OUTSIDE, MENU_COOK_SUCCESS_WIDTH_OUTSIDE, MENU_COOK_SUCCESS_HEIGHT_OUTSIDE, COLOR_WHITE);
        patblt(game->conf.work.adr, MENU_COOK_SUCCESS_X_INSIDE,  MENU_COOK_SUCCESS_Y_INSIDE,  MENU_COOK_SUCCESS_WIDTH_INSIDE,  MENU_COOK_SUCCESS_HEIGHT_INSIDE,  COLOR_MID_BLUE);
        font_dram_draw(game, MENU_COOK_SUCCESS_MSG_X, MENU_COOK_SUCCESS_MSG_Y, MEMORY_CMD_MSG_ID, CMD_MSG_ID_MENU_COOK_SUCCESS + result, EVENT_MSG_SUB_MSG, COLOR_WHITE);
        break;
    }
}