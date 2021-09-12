#ifndef draw_func_h   /* prevent circular inclusions */
#define draw_func_h   /* by using protection macros */

void image_addition(GameWrapper *const game, uint8_t alpha);
void background_draw(GameWrapper *const game, uint32_t srcin);
void standerd_game(GameWrapper *const game);
void workarea_update(GameWrapper *const game, uint32_t draw_pos);
void frame_buffer_clear(void);
void frame_buffer_other_copy(GameWrapper *const game);
void nextdraw_ready(GameWrapper *const game);

#endif
