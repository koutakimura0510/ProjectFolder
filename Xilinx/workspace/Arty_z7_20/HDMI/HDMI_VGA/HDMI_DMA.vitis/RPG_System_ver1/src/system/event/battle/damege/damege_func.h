/*
 * Create 2021/08/02
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
 * ダメージ描画とダメージ計算の関数をまとめたヘッダーファイル
 */

#ifndef damege_func_h   /* prevent circular inclusions */
#define damege_func_h   /* by using protection macros */


/* damege.c */
void select_unit_calc(GameWrapper *const game, uint8_t calc_id);
void select_unit_damege_draw(GameWrapper *const game, uint8_t draw_id, uint8_t memory_id);


#endif
