/*
 * Create 2021/08/04
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
 * battleフォルダ内でのみ共有する関数やマクロファイルを定義するヘッダーファイル
 */

#ifndef condition_global_h   /* prevent circular inclusions */
#define condition_global_h   /* by using protection macros */

void update_condition_db(GameWrapper *const game, uint8_t hero_id);

#endif
