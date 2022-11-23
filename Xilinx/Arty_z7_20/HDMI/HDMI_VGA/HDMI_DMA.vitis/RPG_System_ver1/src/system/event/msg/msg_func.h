/*
 * drawファルダ内で参照する関数を宣言
 */

#ifndef msg_func_h   /* prevent circular inclusions */
#define msg_func_h   /* by using protection macros */

void damege_font_draw(GameWrapper *const game, uint32_t pos, uint32_t result, uint32_t srcin);
void result_font_draw(GameWrapper *const game, uint32_t xstart, uint32_t ystart, uint32_t result, uint8_t zero_sup);
void event_msg_draw(GameWrapper *const game);
void font_dram_draw(GameWrapper *const game, uint32_t xstart, uint32_t ystart, uint8_t system_member, uint32_t file_id, uint32_t sub_member, uint32_t color);

#endif
