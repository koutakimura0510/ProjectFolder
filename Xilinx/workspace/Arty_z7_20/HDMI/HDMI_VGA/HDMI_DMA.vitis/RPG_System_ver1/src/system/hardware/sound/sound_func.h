#ifndef sound_func_h   /* prevent circular inclusions */
#define sound_func_h   /* by using protection macros */

bool dtmwork_init(void);
void bgm_playback(void);
void bgm_load(GameWrapper *const game, uint8_t sound_id);
void bgm_update(GameWrapper *const game, uint8_t sound_id, uint8_t ch);
void bgm_stop(void);

#endif
