/*
 * ver1. 2021/08/21
 * コマンド入力の共有処理を管理するヘッダーファイル
 */
#ifndef cmd_func_h   /* prevent circular inclusions */
#define cmd_func_h   /* by using protection macros */

void cmd_db_reset(GameWrapper *const game, uint8_t system, uint8_t ystart);
void cursol_draw(GameWrapper *const game, uint32_t pos, uint32_t interval, uint8_t type);
uint8_t cmd_key(GameWrapper *const game);


#endif