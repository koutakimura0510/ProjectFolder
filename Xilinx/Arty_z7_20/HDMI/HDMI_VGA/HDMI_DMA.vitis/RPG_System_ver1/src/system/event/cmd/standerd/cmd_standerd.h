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
 * cmdフォルダ内で共有するコマンドの基本処理を行う関数を定義
 */

#ifndef cmd_standerd_h   /* prevent circular inclusions */
#define cmd_standerd_h   /* by using protection macros */

void cmd_key_all(GameWrapper *const game, uint8_t sw);
void cmd_key_height(GameWrapper *const game, SDL_Key *const key);
void cmd_key_width(GameWrapper *const game, SDL_Key *const key);
void cmd_key_ab(GameWrapper *const game, SDL_Key *const key);
void cmd_key_sound(GameWrapper *const game, SDL_Key *const key);

#endif
