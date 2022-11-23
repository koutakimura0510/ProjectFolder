/*
 * 描画データの操作を行う関数を管理
 */

#include "game_wrapper.h"


/*
 * ストーリーゲームを管理する構造体を確保
 */
GameWrapper game_wrapper;


/*
 * ver2. 2021/07/21
 * ファイルの構造を修正したため、game関数をmain関数に変更
 *
 * ver1. 2021/07/02
 * ゲームのシステム進行を行う
 */

int main(void)
{
	GameWrapper *game = &game_wrapper;

	opening_hardware_init(game);

	while (1)
	{
		story_toho_rpg(game);
	}

	return 0;
}
