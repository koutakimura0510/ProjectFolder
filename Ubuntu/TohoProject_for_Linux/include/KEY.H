#ifndef KEY_H_
#define KEY_H_

/**-------------------------------------------------
 * 移動番号定義
 * -------------------------------------------------*/
typedef enum {
	RIGHT,
	UP,
	DOWN,
	LEFT,
	NON,
} KEY_ID;

typedef enum {
	UNIT_XPOS,
	UNIT_YPOS,
	FIELD_XPOS,
	FIELD_YPOS,
	RES_YPOS,
} POS_ID;



void pos_update(void);
void xpos_move_right(uint32_t field_maxwidth);
void xpos_move_left(void);
void ypos_move_up(void);
void ypos_move_down(uint32_t field_maxheight);
void direct(uint32_t field_maxwidth, uint32_t field_maxheight);
uint32_t get_posinfo(uint8_t pos);

#endif
