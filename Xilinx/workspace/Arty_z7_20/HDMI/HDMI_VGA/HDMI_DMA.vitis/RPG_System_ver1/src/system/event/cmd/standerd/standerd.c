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
 * バトル時のコマンド入力確定時の操作関数を管理するファイル
 */
#include "../../../wrapper/game_wrapper.h"
#include "cmd_standerd.h"

/* ファイル内関数 */
static void sound_cook_request(GameWrapper *const game, SDL_Key *const key);


/*
 * ver1. 2021/08/21
 * 全てのデフォルトコマンド関数を実行する時に使用する関数
 */
void cmd_key_all(GameWrapper *const game, uint8_t sw)
{
	SDL_Key key = (SDL_Key){sw, SOUND_ID_CMD_BUTTON, SOUND_CH_KEY_WORK};

	cmd_key_sound(game, &key);
	cmd_key_height(game, &key);
	cmd_key_width(game, &key);
	cmd_key_ab(game, &key);
}


/*
 * ver1. 2021/07/02
 * デフォルトコマンドキーの上下キー処理
 * 基本動作のみの場合に使用する
 */
void cmd_key_height(GameWrapper *const game, SDL_Key *const key)
{
	switch (key->bit & (SW_UP | SW_DOWN))
    {
    case SW_UP:
        min_sub(game->cmd.cursol.y, 0);
        break;

    case SW_DOWN:
        max_add(game->cmd.cursol.y, game->cmd.cursol.yend);
		break;

	default:
        break;
    }
}


/*
 * ver1. 2021/07/02
 * デフォルトコマンドキーの左右キー処理
 * 基本動作のみの場合に使用する
 */
void cmd_key_width(GameWrapper *const game, SDL_Key *const key)
{
	switch (key->bit & (SW_RIGHT | SW_LEFT))
    {
    case SW_RIGHT:
        max_add(game->cmd.cursol.x, game->cmd.cursol.xend);
        break;

    case SW_LEFT:
        min_sub(game->cmd.cursol.x, 0);
		break;

	default:
        break;
    }
}


/*
 * ver1. 2021/07/02
 * デフォルトコマンドキーのABボタン処理
 * 基本動作のみの場合に使用する
 */
void cmd_key_ab(GameWrapper *const game, SDL_Key *const key)
{
    if (key->bit & SW_A)
    {
		game->cmd.cursol.oldx = game->cmd.cursol.x;
		game->cmd.cursol.oldy = game->cmd.cursol.y;
		game->cmd.cursol.x = 0;
		game->cmd.cursol.y = 0;
	}

	if (key->bit & SW_B)
    {
		game->cmd.cursol.yend = BATTLE_CMD_END;
		game->cmd.sub_system  = COMMAND_MAIN;
		game->cmd.cursol.x 	  = 0;
		game->cmd.cursol.y 	  = 0;
		game->cmd.cursol.oldx = 0;
		game->cmd.cursol.oldy = 0;
		game->cmd.window.sub_id = BATTLE_WINDOW_SUB_NON;
	}
}


/**
 * @brief   コマンド入力時に音源を鳴らす場合に利用する
 * @ingroup cmd key
 *
 * @note ある特定の状態時には別の音源を鳴らすためコマンド入力の音源は鳴らさない
 *
 * @version . 2021/month/day
 */

/*
 * ver1. 2021/08/21
 * コマンド入力時に音源を鳴らす場合に利用する
 */

/**
 * @brief  コマンド入力時に音源を鳴らす処理
 * @note   モードによって音源が異なるため、モードの状態を見て鳴らす音源を変更するようにした。
 *         この関数内でコマンドの音源処理を行うように変更し、他の処理で変更しないようにした
 * 
 * @param  key: キー入力データが保存されているSDL_Key構造体のアドレスを指定
 * @retval None
 */
void cmd_key_sound(GameWrapper *const game, SDL_Key *const key)
{
	sound_cook_request(game, key);

	if (key->bit != 0)
	{
		bgm_update(game, key->sound_id, key->sound_ch);
	}
}


/**
 * @brief  コマンド入力時の料理画面における音源データのリクエスト処理
 * @note   
 * @param  key: キー入力のデータが保存されているSDL_key構造体のアドレスを指定
 * @retval None
 */
static void sound_cook_request(GameWrapper *const game, SDL_Key *const key)
{
	if ((SW_A & key->bit) != SW_A)
	{
		return;
	}

	if (game->conf.display.sub_state == MENU_COOK_WINDOW)
	{
		if (game->cmd.sub_system == COMMAND_SUB_COOK_SUCCESS)
		{
			key->sound_id = SOUND_ID_CMD_SUCCESS;
		}

		if (game->cmd.sub_system == COMMAND_SUB_COOK_FAILURE)
		{
			key->sound_id = SOUND_ID_CMD_FAIL;
		}
	}
}
