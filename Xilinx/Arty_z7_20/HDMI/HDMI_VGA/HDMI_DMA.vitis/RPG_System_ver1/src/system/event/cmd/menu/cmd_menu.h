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
 * 
 * cmd.cで処理を行うメニュー関数を定義
 */

#ifndef cmd_menu_h   /* prevent circular inclusions */
#define cmd_menu_h   /* by using protection macros */

void menu_key(GameWrapper *const game, uint8_t sw);

#endif
