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
 * オープニング時のコマンド入力確定時の操作関数を管理するファイル
 */
#include "../../../wrapper/game_wrapper.h"
#include "cmd_opening.h"
#include "../standerd/cmd_standerd.h"


/* ファイル内関数 */
static void cmd_opening_system(GameWrapper *const game);


/*
 * ver1. 2021/08/21
 * オープニング中のキー入力の操作処理を管理する
 */
void opening_key(GameWrapper *const game, uint8_t sw)
{
	if (sw & SW_A)
	{
		cmd_opening_system(game);
	}
	cmd_key_all(game, sw);
}


/*
 * ver1. 2021/07/02
 * オープニング中のコマンド入力処理
 */
static void cmd_opening_system(GameWrapper *const game)
{
	game->cmd.sub_system = game->cmd.cursol.y;
}