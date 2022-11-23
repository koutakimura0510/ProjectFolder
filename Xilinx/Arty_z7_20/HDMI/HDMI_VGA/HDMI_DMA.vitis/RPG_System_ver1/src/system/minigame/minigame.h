/**
 * @brief  ミニゲームフォルダ内で共有する関数と定数を管理するヘッダーファイル
 * @note   
 * @param  game: 
 * @retval 
 */
#ifndef minigame_h   /* prevent circular inclusions */
#define minigame_h   /* by using protection macros */

#include "shooting_macro.h"
#include "shooting_struct.h"


/** フォルダ内共有関数 */
void bullet_pos_update(GameWrapper *const game);
void bullet_draw(GameWrapper *const game);
void shooting_reset(void);
void set_score(GameWrapper *const game, uint32_t step_on_count, uint32_t bullet_speed);


#endif
