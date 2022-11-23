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
 * コマンド入力時の座標指定やIDの定数を管理するヘッダーファイル
 */

#ifndef cmd_macro_h   /* prevent circular inclusions */
#define cmd_macro_h   /* by using protection macros */


/*
 * ver1. 2021/07/23
 * カーソルの種類を定義
 */
#define CURSOL_TYPE_DEFAULT_DRAW    (0) //通常の白くて小さいカーソル
#define CURSOL_TYPE_DECORATION_DRAW (1) //ちょっとゴージャスなカーソル


/* 長押しの速度変更カウントの値 */
#define CURSOL_SPEED_CHANGE         (5)


/*
 * ver1. 2021/07/01
 * コマンドカーソルモードのIDを管理
 * 
 * コマンドのカーソルの操作方法が実行中の処理によって異なるため、
 * モード変数を定義し種類を選別する
 */
typedef enum
{
    COMMAND_OPENING_SYSTEM,
    COMMAND_BUILD_SYSTEM,
    COMMAND_BATTLE_SYSTEM,
    COMMAND_MENU_SYSTEM,
    COMMAND_SHOP_SYSTEM,
    COMMAND_SELECT_SYSTEM,
    COMMAND_MINIGAME_SYSTEM,
} CommandMain;


/**
 * @brief  オープニングの選択項目数
 * @note   
 * @retval None
 */
typedef enum
{
    OPENING_BEFORE_START,
    OPENING_CONTINUE,
    OPENING_MINIGAME,
    OPENING_CURSOL_END = OPENING_MINIGAME,
} OpeningCursolNum;

/*
 * ver1. 2021/07/03
 * 各コマンド入力状態の親モードをMAINとし、それ以外をSUBとする
 */
typedef enum
{
    COMMAND_MAIN,
    COMMAND_SUB,
    COMMAND_SUB_PATY_SWAP,
    COMMAND_SUB_PATY_LIST,
    COMMAND_SUB_COOK_CHALLENGE,
    COMMAND_SUB_COOK_SUCCESS,
    COMMAND_SUB_COOK_FAILURE,
} CommandSub;


/*
 * ver1. 2021/07/01
 * オープニング時のコマンドカーソルのモードIDの管理
 */
typedef enum
{
    COMMAND_OPENING_RESTART,
    COMMAND_OPENING_CONTINU,
    COMMAND_OPENING_MINIGAME,
    COMMAND_OPENING_END,
} CommnadOpening;


/*
 * ver1. 2021/07/01
 * バトル時のコマンドカーソルのモードIDの管理
 */
typedef enum
{
    COMMAND_BATTLE_MAGIC,
    COMMAND_BATTLE_UNIT,
    COMMAND_BATTLE_ENEMY,
    COMMAND_BATTLE_ATTACK_UNIT,
    COMMAND_BATTLE_ATTACK_ENEMY,
    COMMAND_BATTLE_MAGIC_UNIT,
    COMMAND_BATTLE_MAGIC_ENEMY,
    COMMAND_BATTLE_SWAP,
    COMMAND_BATTLE_TALK,
    COMMAND_BATTLE_ESCAPE,
    COMMAND_BATTLE_DONE,
    COMMAND_BATTLE_MAGIC_RISE,
    COMMAND_BATTLE_END,
} CommnadBattleState;

/*
 * ver1. 2021/06/27
 * バトル時のカーソル移動の最大値、最低値、座標を定義
 * -
 * バトル時メニューウィンドウ
 * たたかう 0
 * わざ     1
 * アイテム 2
 * いれかえ 3
 * はなす   4
 * にげる   5
 */
typedef enum
{
    BATTLE_ATTACK_SELECT,
    BATTLE_MAGIC_SELECT,
    BATTLE_ITEM_SELECT,
    BATTLE_SWAP_SELECT,
    BATTLE_TALK_SELECT,
    BATTLE_ESCAPE_SELECT,
    BATTLE_CMD_END = BATTLE_ESCAPE_SELECT,
    BATTLE_CMD_MAX,
} CmdBattleMenu;



/*
 * ver1. 2021/08/05
 * コマンド入力時のアイテムとわざの判定を行う定数
 */
typedef enum
{
    COMMAND_ANIME_MAGIC,
    COMMAND_ANIME_ITEM,
    COMMAND_ANIME_ESCAPE,
    COMMAND_ANIME_SWAP,
    COMMAND_ANIME_TALK,
} CmdAnimtion;

/*
 * ver1. 2021/07/01
 * メニュ操作時のコマンドカーソルのモードIDの管理
 */
typedef enum
{
    COMMAND_MENU_TALK,
    COMMAND_MENU_PATY,
    COMMAND_MENU_COOK,
    COMMAND_MENU_END = COMMAND_MENU_COOK,
} CommnadMening;


/**
 * @brief  仲間メニュー時の選択項目のIDを定義
 * @note   
 * @retval None
 */
typedef enum
{
    CURSOL_PATY_SWAP,
    CURSOL_WEAPON_CHANGE,
    CURSOL_ARMOR_CHANGE,
    CURSOL_AMULET_CHANGE,
    CURSOL_ITEM_CHANGE,
} CommandPatyMenuID;

/*
 * ver1. 2021/08/21
 * コマンドキーの長押し処理の状態管理
 */
typedef enum
{
    COMMAND_KEY_STATE_PUSH,
    COMMAND_KEY_STATE_LONG,
} CmdKeyState;

#endif
