/*
 * Create 2021/08/12
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
 * 隊列の変更処理関数を管理するヘッダーファイル
 */

#ifndef formation_func_h   /* prevent circular inclusions */
#define formation_func_h   /* by using protection macros */

void hero_formation_swap(GameWrapper *game, uint8_t hero_origin, uint8_t hero_exchange);

#endif