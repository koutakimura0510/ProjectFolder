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
 * メニュー画面を構成する処理を管理するヘッダーファイル
 */
#ifndef menu_func_h   /* prevent circular inclusions */
#define menu_func_h   /* by using protection macros */

void menu_window_init(GameWrapper *const game);
void menu_window_wrapper(GameWrapper *const game);

#endif
