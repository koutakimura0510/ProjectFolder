/*
 * Create 2021/08/09
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
 * 状態異常の動作処理関数をまとめたヘッダーファイル
 */
#ifndef condition_func_h   /* prevent circular inclusions */
#define condition_func_h   /* by using protection macros */

void hero_condition_state(GameWrapper *const game);

#endif
