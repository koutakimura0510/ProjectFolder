/*
 * battleフォルダの外部ファイルで使用する関数を記入
 */

#ifndef battle_func_h   /* prevent circular inclusions */
#define battle_func_h   /* by using protection macros */

#include "battle_macro.h"
#include "../condition/condition_global.h"


bool battle_rush_state(GameWrapper *const game);
bool battle_window_draw(GameWrapper *const game);

#endif
