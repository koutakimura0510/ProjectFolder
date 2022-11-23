/*
 * Create 2021/08/03
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
 * バトル中のサブウィンドウに関する処理をまとめたヘッダーファイル
 */

#ifndef sub_window_func_h   /* prevent circular inclusions */
#define sub_window_func_h   /* by using protection macros */


/* sub_window.c */
void battle_sub_window(GameWrapper *const game);

#endif
