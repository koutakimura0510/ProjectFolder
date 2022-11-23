#ifndef animation_func_h   /* prevent circular inclusions */
#define animation_func_h   /* by using protection macros */


uint8_t odd_hp_mapchip(GameWrapper *const game, uint8_t hero_id);;
bool isHeroActivate(uint8_t anime_order);
bool conf_anime_update(GameWrapper *const game, int32_t pos);
bool conf_anime_count(GameWrapper *const game, uint8_t count);
void animation_reset(void);
void jump_move(GameWrapper *const game);
void set_jump_motion(bool motion);
bool get_jump_motion(void);
void set_jump_status(GameWrapper *const game);
uint32_t get_jump_count(void);
void set_effect_trigger(bool b, uint8_t effect_id);
bool get_effect_trigger(uint8_t effect_id);
bool realtime_effect_draw(GameWrapper *const game, uint8_t effect_id);

#endif
