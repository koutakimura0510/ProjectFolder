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
#include "../local_share.h"


/**
 * @brief   仲間メニュー操作時のキー入力処理
 * @ingroup menu paty
 *
 * @note
 *
 * @version 1.0 2021/08/28
 */

/**
 * @brief  仲間メニュー操作時のキー入力処理
 * @note   入れ替え時は上下キーの入力を拒否する
 *         リスト操作時は左右キーの入力を拒否する
 * 
 * @param  key: キー入力のデータが保存されているSDL_Key構造体のアドレスを指定
 * @retval None
 */
void paty_key(GameWrapper *const game, SDL_Key *const key)
{
    switch (game->cmd.sub_system)
    {
    case COMMAND_SUB_PATY_SWAP:
        key->bit &= SW_RIGHT_LEFT;
        break;

    case COMMAND_SUB_PATY_LIST:
        key->bit &= SW_UP_DOWN;
        break;

    default:
        break;
    }

    switch (key->bit)
    {
    case SW_UP:
        min_sub(game->cmd.cursol.y, 0);
        break;

    case SW_DOWN:
        max_add(game->cmd.cursol.y, game->cmd.cursol.yend);
		break;

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