/*
 * グローバル関数をまとめたファイル
 */

#ifndef FUNCTION_H_
#define FUNCTION_H_


/* mapchip.c */
bool mapchip_init(MapchipWork *chip, char *path);
void mapchip_all_fill(MapchipWork *chip, char fbuf);
void mapchip_pos_update(MapchipWork *chip, uint8_t key);
void mapchip_rect_fill(MapchipWork *chip, uint32_t fill, char fbuf);
void mapchip_rect_fill_zero(MapchipWork *chip);
void mapchip_shortcut_update(MapchipWork *chip, uint32_t num);
void mapchip_shortcut_fill(MapchipWork *chip, uint32_t num);
void fbuf_update(MapchipWork *chip);

/* file.c */
bool mapf_write(MapchipWork *chip);
bool mapf_read(MapchipWork *chip);


/* key.c */
void pos_update(void);
void xpos_move_right(MapchipWork *chip);
void xpos_move_left(void);
void ypos_move_up(void);
void ypos_move_down(MapchipWork *chip);
void map_direct(MapchipWork *chip);
uint32_t get_posinfo(uint8_t pos);


/* terminal.c */
void terminal_str(char *s, char *path);
void terminal_info(MapchipWork *chip);


/* region.c */
void region_write(MapchipWork *chip);
void request_region_id(MapchipWork *chip, uint32_t id);

#endif
