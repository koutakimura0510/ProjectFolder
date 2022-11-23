/*
 * Create 2021/08/21
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
 * cmd/menu.cで処理を行うメニュー関数を定義
 */

#ifndef cmd_cook_h   /* prevent circular inclusions */
#define cmd_cook_h   /* by using protection macros */

void cook_key(GameWrapper *const game, SDL_Key *const key);
void cook_levelup(GameWrapper *const game);
void cook_reflect(GameWrapper *const game);

#endif
