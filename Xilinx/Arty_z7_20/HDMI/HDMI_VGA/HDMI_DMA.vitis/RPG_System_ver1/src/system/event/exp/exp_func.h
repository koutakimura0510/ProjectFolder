/*
 * Create 2021/07/07
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * IC      XC7Z020-1CLG400C
 * ROM     256KB
 * RAM     512KB
 * L1Cache 32KB
 * -
 * フォルダ内で共有するローカル関数を管理するヘッダーファイル
 */
#ifndef exp_func_h   /* prevent circular inclusions */
#define exp_func_h   /* by using protection macros */

void hero_initialize(GameWrapper *const game);
void update_levelup(GameWrapper *const game);

#endif