/*
 * drawファルダ内で参照する関数を宣言
 */

#ifndef unit_func_h   /* prevent circular inclusions */
#define unit_func_h   /* by using protection macros */

void battle_player_draw(GameWrapper *const game, uint8_t hero_draw_count);
void player_draw(GameWrapper *const game);
void player_frame_draw(GameWrapper *const game, uint32_t pos);
void direction_update_key(GameWrapper *const game, uint8_t sw);
void unit_pos_update(GameWrapper *const game);
void unit_action_update(GameWrapper *const game, uint8_t sw);
int32_t get_unit_index(GameWrapper *const game, uint8_t dir);


#endif
