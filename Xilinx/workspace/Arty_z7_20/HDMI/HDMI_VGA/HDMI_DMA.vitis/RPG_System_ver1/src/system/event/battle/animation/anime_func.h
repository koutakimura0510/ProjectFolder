/*
 * Create 2021/08/02
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
 * -
 * 状態遷移中のアニメーションに関するファイルをまとめたヘッダーファイル
 */

#ifndef anime_func_h   /* prevent circular inclusions */
#define anime_func_h   /* by using protection macros */


/* anime.c */
void animation_effect_draw(GameWrapper *const game, uint8_t effect_id, uint32_t draw_pos);
void animation_effect_update(GameWrapper *const game, uint8_t effect_id, uint8_t next_state);
void font_animetion_memba_update(GameWrapper *const game);
void battle_font_animation_update(GameWrapper *const game, uint8_t next_state);
void hero_paty_magic_draw(GameWrapper *const game, StatusRef *const ref);
void hero_enemy_magic_draw(GameWrapper *const game, StatusRef *const ref);
void enemy_hero_magic_draw(GameWrapper *const game, StatusRef *const ref);
void enemy_paty_magic_draw(GameWrapper *const game, StatusRef *const ref);

#endif
