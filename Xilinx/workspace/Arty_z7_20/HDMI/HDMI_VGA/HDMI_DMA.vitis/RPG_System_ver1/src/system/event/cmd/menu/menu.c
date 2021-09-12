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
#include "local_share.h"


/* ファイル内関数 */
static void menu_key_state(GameWrapper *const game, SDL_Key *const key);
static void cmd_menu_system(GameWrapper *const game);
static void cmd_menu_main(GameWrapper *const game);
static void cmd_menu_sub(GameWrapper *const game);
static void paty_window_sub(GameWrapper *const game);
static void paty_swap(GameWrapper *const game);
static void paty_tools_swap(GameWrapper *const game);
static void cook_window_sub(GameWrapper *const game);
static void cook_challenge(GameWrapper *const game);
static void cook_request(GameWrapper *const game);
static void cmd_menu_back(GameWrapper *const game);
static void cook_menu_back(GameWrapper *const game);
static void paty_menu_back(GameWrapper *const game);
static void paty_yend_push(GameWrapper *const game);
static void menu_hero_chip_init(GameWrapper *const game, uint32_t default_pos);


/*
 * ver1. 2021/08/21
 * メニュー操作時のキー操作関数を管理
 */
void menu_key(GameWrapper *const game, uint8_t sw)
{
    SDL_Key key = (SDL_Key){sw, SOUND_ID_CMD_BUTTON, SOUND_CH_KEY_WORK};

    switch (sw)
    {
    case SW_A:
        cmd_menu_system(game);
        break;

    case SW_B:
        cmd_menu_back(game);
        break;

    default:
        break;
    }

    cmd_key_sound(game, &key);
    menu_key_state(game, &key);
}


/**
 * @brief   メニューウィンドウ操作時の状態遷移を管理
 * @ingroup menu window
 *
 * @note MENU_TALK_WINDOWは決定ボタンしか反応しないため処理は書かない
 *
 * @version 1.0 2021/08/29
 */
static void menu_key_state(GameWrapper *const game, SDL_Key *const key)
{
	switch (game->conf.display.sub_state)
	{
    case MENU_SELECT_WINDOW:
        cmd_key_height(game, key);
        break;

	case MENU_TALK_WINDOW:
		break;

	case MENU_PATY_WINDOW:
        paty_key(game, key);
		break;

	case MENU_COOK_WINDOW:
        cook_key(game, key);
		break;

	default:
		break;
	}
}


/*
 * ver1. 2021/08/16
 * メニュー画面の状態遷移を管理する処理
 * 
 * はなす、なかま、たべる、どれかのコマンドを確定した時にサブモードに突入する
 */
static void cmd_menu_system(GameWrapper *const game)
{
    switch (game->cmd.sub_system)
    {
    case COMMAND_MAIN:
        cmd_menu_main(game);
        game->cmd.sub_system = COMMAND_SUB;
        break;

    default:
		cmd_menu_sub(game);
        break;
    }
}


/*!
 * @brief   メニュー画面のカーソルの座標からどの画面に状態遷移をするか判定を行う処理、状態遷移時に次の状態の初期設定を行う
 * @ingroup menu window
 * 
 * @note
 * 
 * @version 2.0 2021/08/16
 */
static void cmd_menu_main(GameWrapper *const game)
{
	switch (game->cmd.cursol.y)
	{
	case COMMAND_MENU_TALK:
		game->conf.display.sub_state = MENU_TALK_WINDOW;
		break;

	case COMMAND_MENU_PATY:
        menu_hero_chip_init(game, MENU_PATY_HERO_DRAW_POS);
		game->conf.display.sub_state = MENU_PATY_WINDOW;
        game->cmd.cursol.x           = 0;
        game->cmd.cursol.xend        = game->conf.system.paty_member - 1;
        game->cmd.cursol.y           = 0;
        game->cmd.cursol.yend        = PATY_MENU_YMAX;
        break;

	case COMMAND_MENU_COOK:
        menu_hero_chip_init(game, MENU_HERO_DRAW_POS);
		game->conf.display.sub_state = MENU_COOK_WINDOW;
        game->cmd.cursol.y           = 0;
        game->cmd.cursol.yend        = COOK_MENU_YMAX;
		break;

	default:
		break;
	}
}


/*
 * ver1. 2021/08/16
 * メニュー画面のサブモードを管理する処理
 * 
 */
static void cmd_menu_sub(GameWrapper *const game)
{
	switch (game->conf.display.sub_state)
    {
    case MENU_TALK_WINDOW:
		//TODO トーク文字列の描画が終了したら終了するように変更する
		game->conf.display.sub_state = MENU_SELECT_END;
        break;

    case MENU_PATY_WINDOW:
        paty_window_sub(game);
        break;

    case MENU_COOK_WINDOW:
        cook_window_sub(game);
        break;

    default:
        break;
    }
}


/**
 * @brief  パーティ設定画面構成の状態遷移を管理
 * @note   COMMAND_SUB
 *         swap処理のため入れ替え元のカーソル位置を保存しておく。
 *         リスト選択時から戻った場合に同じ位置にカーソルを描画するためy座標を保存しておく。
 *         
 * 
 * @param  game: 
 * @retval None
 */
static void paty_window_sub(GameWrapper *const game)
{
    switch (game->cmd.sub_system)
    {
    case COMMAND_SUB:
        paty_yend_push(game);
        game->cmd.sub_system  = (game->cmd.cursol.y == 0) ? COMMAND_SUB_PATY_SWAP : COMMAND_SUB_PATY_LIST;
        game->cmd.cursol.oldx = game->cmd.cursol.x;
        game->cmd.cursol.oldy = game->cmd.cursol.y;
        switch (game->cmd.cursol.oldy)
        {
        case CURSOL_WEAPON_CHANGE:
            game->cmd.cursol.y = game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.weapon;
            break;

        case CURSOL_ARMOR_CHANGE:
            game->cmd.cursol.y = game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.armor;
            break;

        case CURSOL_AMULET_CHANGE:
            game->cmd.cursol.y = game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.amulet;
            break;

        case CURSOL_ITEM_CHANGE:
            game->cmd.cursol.y = game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.item;
            break;

        default:
            break;
        }
        break;

    case COMMAND_SUB_PATY_SWAP:
        paty_swap(game);
        break;

    case COMMAND_SUB_PATY_LIST:
        paty_tools_swap(game);
        break;

    default:
        break;
    }
}


/**
 * @brief  隊列の入れ替え決定時の処理をする
 * @note   処理的には配列データの入れ替え
 * @retval None
 */
static void paty_swap(GameWrapper *const game)
{
    uint32_t draw_pos = game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].battle.draw_pos;
    uint8_t sort_pos  = game->conf.battle.hero.sort_order[game->cmd.cursol.x];
    game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].battle.draw_pos = game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.oldx]].battle.draw_pos;
    game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.oldx]].battle.draw_pos = draw_pos;
    game->conf.battle.hero.sort_order[game->cmd.cursol.x] = game->conf.battle.hero.sort_order[game->cmd.cursol.oldx];
    game->conf.battle.hero.sort_order[game->cmd.cursol.oldx] = sort_pos;
    game->cmd.sub_system = COMMAND_SUB;
}


/**
 * @brief  装備とアイテムの入れ替え決定時の処理をする
 * @note   game->cmd.cursol.oldyには前回のy座標が保存されているため、どの項目を選択したか判定できる
 *         カーソルのy座標の値がが選択中の装備やアイテムIDと等しくなっているため、そのまま代入する
 * @retval None
 */
static void paty_tools_swap(GameWrapper *const game)
{
    bool isValid;
    bool isEquip;

    if (game->cmd.cursol.y != 0)
    {
        for (uint32_t i = 0; i < game->conf.system.paty_member; i++)
        {
            switch (game->cmd.cursol.oldy)
            {
            case CURSOL_WEAPON_CHANGE:
                isValid = (game->hero[game->conf.battle.hero.sort_order[i]].equip.weapon == game->conf.item.weapon[game->cmd.cursol.y]) ? false : true;
                isEquip = (fetch_dram_db(game, MEMORY_WEAPON_ID, game->conf.item.weapon[game->cmd.cursol.y], WEAPON_SUB_MEMBER_EQUIP_HERO) & (0x00000001 << game->conf.battle.hero.sort_order[game->cmd.cursol.x])) ? true : false;
                break;

            case CURSOL_ARMOR_CHANGE:
                isValid = (game->hero[game->conf.battle.hero.sort_order[i]].equip.armor == game->conf.item.armor[game->cmd.cursol.y]) ? false : true;
                isEquip = (fetch_dram_db(game, MEMORY_ARMOR_ID, game->conf.item.armor[game->cmd.cursol.y], ARMOR_SUB_MEMBER_EQUIP_HERO) & (0x00000001 << game->conf.battle.hero.sort_order[game->cmd.cursol.x])) ? true : false;
                break;

            case CURSOL_AMULET_CHANGE:
                isValid = (game->hero[game->conf.battle.hero.sort_order[i]].equip.amulet == game->conf.item.amulet[game->cmd.cursol.y]) ? false : true;
                isEquip = (fetch_dram_db(game, MEMORY_AMULET_ID, game->conf.item.amulet[game->cmd.cursol.y], AMULET_SUB_MEMBER_EQUIP_HERO) & (0x00000001 << game->conf.battle.hero.sort_order[game->cmd.cursol.x])) ? true : false;
                break;

            case CURSOL_ITEM_CHANGE:
                isValid = (game->hero[game->conf.battle.hero.sort_order[i]].equip.item == game->conf.item.tool[game->cmd.cursol.y]) ? false : true;
                isEquip = true;
                break;

            default:
                break;
            }

            if ((isValid == false) || (isEquip == false))
            {
                return;
            }
        }
    }

    switch (game->cmd.cursol.oldy)
    {
    case CURSOL_WEAPON_CHANGE:
        game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.weapon = game->cmd.cursol.y;
        break;

    case CURSOL_ARMOR_CHANGE:
        game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.armor = game->cmd.cursol.y;
        break;

    case CURSOL_AMULET_CHANGE:
        game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.amulet = game->cmd.cursol.y;
        break;

    case CURSOL_ITEM_CHANGE:
        game->hero[game->conf.battle.hero.sort_order[game->cmd.cursol.x]].equip.item = game->cmd.cursol.y;
        break;

    default:
        break;
    }
}


/*
 * ver1. 2021/08/18
 * 料理画面の画面構成の状態遷移を管理
 * 料理選択時に成功か失敗判定を行い、結果に応じて処理を変更する
 * 
 * COMMAND_SUB
 * 料理選択画面
 * 
 * COMMAND_SUB_COOK_CHALLENGE
 * 料理を作るか確認する画面
 * 
 * default:
 * 料理のリザルト画面、失敗または成功の画面表示時に決定ボタンを押すとサブモードに移行する
 */
static void cook_window_sub(GameWrapper *const game)
{
    switch (game->cmd.sub_system)
    {
    case COMMAND_SUB:
        cook_request(game);
        break;

    case COMMAND_SUB_COOK_CHALLENGE:
        cook_challenge(game);
        break;

    default:
        game->cmd.sub_system = COMMAND_SUB;
        break;
    }
}


/*
 * ver1. 2021/08/19
 * 料理を作成できるか要求する
 * 料理を習得していて、料理可能であれば料理作成状態に移行する
 */
static void cook_request(GameWrapper *const game)
{
    if ((game->conf.cook.master[game->cmd.cursol.y] == COOK_ID_NON) || (game->conf.cook.isCook == false))
    {
        return;
    }

    game->cmd.sub_system = COMMAND_SUB_COOK_CHALLENGE;
}


/*
 * ver1. 2021/08/18
 * 料理の成功、失敗判定処理
 * 
 * 0 ~ 99%の値 < (料理の熟練度(0 ~ 4) * 10) + 60
 * MASTERならば100になるため必ず成功する
 */
static void cook_challenge(GameWrapper *const game)
{
    if (get_percent(DIG_100) < ((game->conf.cook.level[game->cmd.cursol.y] * DIG_2_FIX) + DIG_60))
    {
        game->cmd.sub_system = COMMAND_SUB_COOK_SUCCESS;
        cook_reflect(game);
    }
    else
    {
        game->cmd.sub_system = COMMAND_SUB_COOK_FAILURE;
    }
    
    cook_levelup(game);
    game->conf.cook.isCook = false;
}


/*
 * ver1. 2021/08/21
 * メニュー画面の戻るスイッチを押した場合の状態遷移を管理する処理
 */
static void cmd_menu_back(GameWrapper *const game)
{
    switch (game->conf.display.sub_state)
    {
    case MENU_SELECT_WINDOW:
        game->conf.display.sub_state = MENU_SELECT_END;
        break;

    case MENU_TALK_WINDOW:
        break;

    case MENU_PATY_WINDOW:
        paty_menu_back(game);
        break;

    case MENU_COOK_WINDOW:
        cook_menu_back(game);
        break;

    default:
        break;
    }
}


/*
 * ver1. 2021/08/21
 * 料理画面操作時のBボタンで前のメニューに戻る動作処理
 */
static void cook_menu_back(GameWrapper *const game)
{
    switch (game->cmd.sub_system)
    {
    case COMMAND_SUB:
        cmd_db_reset(game, COMMAND_MENU_SYSTEM, COMMAND_MENU_COOK);
        break;

    case COMMAND_SUB_COOK_CHALLENGE:
        game->cmd.sub_system = COMMAND_SUB;
        break;

    default:
        break;
    }
}


/**
 * @brief  仲間メニュー操作時のBボタンで前のメニューに戻る動作処理
 * @note   
 * @retval None
 */
static void paty_menu_back(GameWrapper *const game)
{
    switch (game->cmd.sub_system)
    {
    case COMMAND_SUB:
        cmd_db_reset(game, COMMAND_MENU_SYSTEM, COMMAND_MENU_PATY);
        break;

    case COMMAND_SUB_PATY_SWAP:
        game->cmd.sub_system  = COMMAND_SUB;
        break;

    case COMMAND_SUB_PATY_LIST:
        game->cmd.cursol.y    = game->cmd.cursol.oldy;
        game->cmd.cursol.yend = PATY_MENU_YMAX;
        game->cmd.sub_system  = COMMAND_SUB;
        break;

    default:
        break;
    }
}


/**
 * @brief  仲間メニュー状態遷移時のy座標カーソル最大移動量を保存
 * @note   入れ替え選択時に上下キーの入力を拒否しているためyendの設定をしなくて済む
 * 
 * @retval None
 */
static void paty_yend_push(GameWrapper *const game)
{
    switch (game->cmd.cursol.y)
    {
    case CURSOL_WEAPON_CHANGE:
        game->cmd.cursol.yend = WEAPON_CURSOL_YEND;
        break;

    case CURSOL_ARMOR_CHANGE:
        game->cmd.cursol.yend = ARMOR_CURSOL_YEND;
        break;

    case CURSOL_AMULET_CHANGE:
        game->cmd.cursol.yend = AMULET_CURSOL_YEND;
        break;

    case CURSOL_ITEM_CHANGE:
        game->cmd.cursol.yend = ITEM_CURSOL_YEND;
        break;

    default:
        break;
    }
}


/*
 * ver1. 2021/08/16
 * メニューコマンドの仲間のマップチップ描画のための座標設定
 */
static void menu_hero_chip_init(GameWrapper *const game, uint32_t default_pos)
{
    for (uint32_t i = 0; i < game->conf.system.paty_member; i++)
    {
        game->hero[game->conf.battle.hero.sort_order[i]].battle.draw_pos   = default_pos + XRGB((SIZE_UNIT_BATTLE_WIDTH * i));
        game->hero[game->conf.battle.hero.sort_order[i]].battle.draw_xpos  = 0;
        game->hero[game->conf.battle.hero.sort_order[i]].battle.draw_ypos  = 0;

        if (game->hero[game->conf.battle.hero.sort_order[i]].battle.arive == BATTLE_HERO_ALIVE)
        {
            game->conf.battle.hero.anime_order[game->conf.battle.hero.sort_order[i]] = odd_hp_mapchip(game, game->conf.battle.hero.sort_order[i]);
        }
    }
}
