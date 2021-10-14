#ifndef rom_func_h   /* prevent circular inclusions */
#define rom_func_h   /* by using protection macros */

uint32_t get_mapsize(char wh);
bool sdread_image_init(void);
bool sd_fread(uint32_t id);
bool file_sound_load(uint32_t fileid);
uint32_t get_sound_length(uint32_t fileid);
uint32_t fetch_dram_db(GameWrapper *const game, uint8_t main_member, uint32_t sub_id, uint32_t sub_member);
uint32_t fetch_dram_msg(GameWrapper *const game, uint8_t main_member, uint32_t sub_id, uint32_t sub_member);

#endif
