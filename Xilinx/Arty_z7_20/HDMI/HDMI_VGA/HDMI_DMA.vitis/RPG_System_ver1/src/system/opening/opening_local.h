/*
 * キャラクターのステータスデータベース構造体管理ヘッダーファイル
 */

#ifndef opening_local_h   /* prevent circular inclusions */
#define opening_local_h   /* by using protection macros */


#include "opening_macro.h"


void story_opening_mode(GameWrapper *const game);
void opening_hardware_init(GameWrapper *const game);
void load_display_draw(GameWrapper *const game);
#endif
