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
#include "battle/cmd_battle.h"
#include "menu/cmd_menu.h"
#include "opening/cmd_opening.h"
#include "standerd/cmd_standerd.h"


/*
 * ver1. 2021/08/21
 * コマンドの長押しキーの処理を管理する構造体
 * 
 * bit		swのbitを保存
 * state	コマンド動作時の長押し判定を管理
 * t		長押し中のカーソル更新タイマー時間を管理
 */
typedef struct
{
	uint8_t bit;
	uint8_t state;
	uint32_t t;
	uint8_t count;
} CmdKey;


/* ファイル内関数 */
static void cmd_key_push(CmdKey *const key);



/**
 * @brief  コマンドカーソル構造体の初期化
 * @note   カーソルの戻る動作時にy座標の開始位置を指定する必要があったため引数にした
 * 
 * @param  system: モードによってカーソルの移動量が異なるため移行するモードのIDを指定
 * @param  ystart: 初期化時のカーソルのy座標のポジションを指定
 * @retval None
 */
void cmd_db_reset(GameWrapper *const game, uint8_t system, uint8_t ystart)
{
	switch (system)
	{
	case COMMAND_OPENING_SYSTEM:
		game->cmd.sub_system  = COMMAND_OPENING_RESTART;
		game->cmd.cursol.yend = OPENING_CURSOL_END;
		break;

	case COMMAND_BUILD_SYSTEM:
		game->cmd.sub_system  = COMMAND_MAIN;
		game->cmd.cursol.yend = MAP_NAME_ID_END;
		break;

	case COMMAND_BATTLE_SYSTEM:
		game->cmd.sub_system    = COMMAND_MAIN;
		game->cmd.window.sub_id = BATTLE_WINDOW_SUB_NON;
		game->cmd.cursol.yend   = BATTLE_CMD_END;
		break;

	case COMMAND_MENU_SYSTEM:
		game->cmd.sub_system         = COMMAND_MAIN;
		game->cmd.cursol.yend        = COMMAND_MENU_END;
		game->conf.display.sub_state = MENU_SELECT_WINDOW;
		break;

	case COMMAND_SHOP_SYSTEM:
		break;

	case COMMAND_SELECT_SYSTEM:
		break;

	case COMMAND_MINIGAME_SYSTEM:
		// game->cmd.sub_system  = COMMAND_MINIGAME_SYSTEM;
		game->cmd.cursol.yend = game->conf.system.paty_member - 1;
		game->conf.display.sub_state = MINIGAME_START_LOAD_ID;
		break;

	default:
		break;
	}

	game->cmd.system 		= system;
	game->cmd.cursol.x 	    = 0;
	game->cmd.cursol.y 	    = ystart;
	game->cmd.cursol.xend   = 0;
    game->cmd.cursol.finish = false;
}


/*
 * ver1. 2021/07/02
 * 指定座標にカーソルの描画を行う
 * -
 * pos		カーソル描画の基準値を指定
 * interval	キー入力時のカーソルの移動幅を指定
 */

/**
 * @brief  指定座標にカーソルの描画を行う
 * @note   posには、RGB_BYTE_SHIFTとMAX_V_WIDTHの計算を行った値を指定すること
 * @param  pos: カーソル描画の基準位置を指定
 * @param  interval: カーソル移動時のy軸の移動量を指定
 * @param  type: CURSOL_TYPE_xxxと名の付くカーソルの描画タイプを指定
 * @retval None
 */
void cursol_draw(GameWrapper *const game, uint32_t pos, uint32_t interval, uint8_t type)
{
	switch (type)
	{
	case CURSOL_TYPE_DEFAULT_DRAW:
		game->mapchip.srcin		 = DRAM_ICON_ADDR_BASE;
		game->mapchip.maxwidth	 = SIZE_ICON_WIDTH;
		game->mapchip.maxheight	 = SIZE_ICON_HEIGHT;
		break;

	case CURSOL_TYPE_DECORATION_DRAW:
		game->mapchip.srcin		 = DRAM_ICON_2_ADDR_BASE;
		game->mapchip.maxwidth	 = SIZE_ICON_2_WIDTH;
		game->mapchip.maxheight	 = SIZE_ICON_2_HEIGHT;
		break;

	default:
		break;
	}

    game->mapchip.draw_xsize = game->mapchip.maxwidth;
    game->mapchip.draw_ysize = game->mapchip.maxheight;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = 255;
    game->mapchip.id         = 0;
    game->mapchip.dstin      = game->conf.work.adr + pos +  (interval * (uint32_t)game->cmd.cursol.y);
    game->mapchip.dstout	 = game->mapchip.dstin;
    png_mapchip(game);
}


/*
 * ver2. 2021/08/21
 * 各システムでキー入力のデータ操作が異なるため
 * システムごとにキー入力の状態遷移を作り、処理を分けることにした。
 * 例えば、バトル中とメニュー時のカーソル動作によるウィンドウの動作が異なるため
 * 共有の方法だと色々と考えにくかった
 * -
 * システムごとのカーソル動作関数を管理する
 * 
 * 
 * ver1. 2021/07/01
 * コマンド入力時の状態遷移を管理する
 */
uint8_t cmd_key(GameWrapper *const game)
{
	static CmdKey key = (CmdKey){0, COMMAND_KEY_STATE_PUSH, 0};

	cmd_key_push(&key);

	switch (game->cmd.system)
	{
	case COMMAND_OPENING_SYSTEM:
		opening_key(game, key.bit);
		break;

	case COMMAND_BUILD_SYSTEM:
		opening_key(game, key.bit);
		break;

	case COMMAND_BATTLE_SYSTEM:
		battle_key(game, key.bit);
		break;

	case COMMAND_MENU_SYSTEM:
		menu_key(game, key.bit);
		break;

	case COMMAND_SHOP_SYSTEM:
		// cmd_shop_system(game);
		break;

	case COMMAND_SELECT_SYSTEM:
		// cmd_select_system(game);
		break;

	case COMMAND_MINIGAME_SYSTEM:
		cmd_key_all(game, key.bit);
		break;

	default:
		break;
	}

	return key.bit;
}


/*
 * ver1. 2021/08/22
 * コマンドキーの長押し処理と単発押し処理
 * 
 * キーを押したらCOMMAND_KEY_STATE_LONG状態に移行する
 * キーを離したらCOMMAND_KEY_STATE_PUSH状態に移行する
 * キーを押す状態が一定期間過ぎたら、カーソルの移動速度を上げる
 */
static void cmd_key_push(CmdKey *const key)
{
	uint32_t com_timer;
    key->bit = get_key(true);

	switch (key->state)
	{
	case COMMAND_KEY_STATE_PUSH:
		if (key->bit != 0)
		{
			key->state = COMMAND_KEY_STATE_LONG;
			key->t = get_time();
			key->count = 0;
		}
		break;

	case COMMAND_KEY_STATE_LONG:
		if (key->count < CURSOL_SPEED_CHANGE)
		{
			com_timer = TM_150MS_COUNT;
		}
		else
		{
			com_timer = TM_100MS_COUNT;
			key->count = CURSOL_SPEED_CHANGE;
		}

		if (key->bit == 0)
		{
			key->state = COMMAND_KEY_STATE_PUSH;
		}

		if (false == tmr_constant(&key->t, com_timer))
		{
			key->bit &= SW_AB;
		}
		else
		{
			key->count++;
			key->t = get_time();
		}
		break;

	default:
		break;
	}
}