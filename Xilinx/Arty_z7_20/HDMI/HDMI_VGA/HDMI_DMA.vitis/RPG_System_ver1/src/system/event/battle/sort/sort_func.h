/*
 * バトルで使用するソート処理に関する関数を共有するヘッダーファイル
 */

#ifndef sort_func_h   /* prevent circular inclusions */
#define sort_func_h   /* by using protection macros */


/* sort.c */
void battle_conf_sort(GameWrapper *const game);
void battle_atb_shift(GameWrapper *const game, uint8_t pos);
void battle_conf_shift(GameWrapper *const game, uint8_t pos);
void battle_dying_sort(GameWrapper *const game, uint8_t hero_id);
void battle_enemy_shift(GameWrapper *const game, uint8_t pos);
void enemy_conf_shift(GameWrapper *const game, uint8_t pos);

#endif
