#ifndef KEY_H_
#define KEY_H_

/*
 * 移動番号定義
 */
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


#endif
