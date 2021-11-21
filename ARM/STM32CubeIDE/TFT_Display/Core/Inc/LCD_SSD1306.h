/*
 * LCD_SSD1306.h
 *
 *  Created on: Dec 20, 2020
 *      Author: koutakimura
 */

#ifndef INC_LCD_SSD1306_H_
#define INC_LCD_SSD1306_H_

#define LCD_ADRRESS		0x78

#define MAX_CULUMN		128
#define MAX_HEIGHT		64
#define MAX_PAGE			8
#define BIT_WIDTH			8
#define LCD_POWER_ON 	1000

#define STRAIGHT			0
#define BEND				1

#define MAX_DISP			1024	//LCDの表示ドット数
#define CMD_BYTE 			0x00	//設定コマンド
#define WR_BYTE	 		0x40	//書き込みコマンド
#define CLEAR_DISP		0x00

///Hardware Cinfiguration
#define SCAN_DIRECTION	0xC8	//反転表示
#define SET_COM_PIN		0xda	//
#define PIN_HARD			0x12	//0だと間隔が広がる

///contrast_set
#define CONTRAST_SET		0x81
#define CONTRAST_VALUE	0xff	//最大255

///initial
#define CHARGE_PUMP			0x8d
#define SER_SEGMENT_REMAP	0xa1
#define ENABLE_CHARGE_PUMP	0x14
#define DISPLAY_ON			0xaf

///set Display Clock
#define SET_DISPLAY_CLOCK	0xd5
#define OSCILLATOR_RATIO		0xf0	//クロックを設定0x00~0xf0

///set Pre charge period
#define SET_PERIOD			0xd9
#define SET_DCLK				0xff	//Dクロックを設定0x00~0xff

///set Vcomh Deselect
#define SET_VCOMH				0xdb
#define VCOMH_LEVEL			0x30	//電圧発生回路の設定

///Set Memory Addressing Mode
#define MEMORY_MODE			0x20
#define HORIZONTAL_MODE		0x00
#define VERTICAL_MODE		0x01
#define PAGE_MODE				0x02
#define INVALID				0x03

///Set Column
#define COLUMN_BIT			0x0f
#define HI_COLUMN				0x10

///set column address
#define COLUMN_ADDRESS		0x21
#define	COLUMN_START		0x00	//開始座標
#define COLUMN_END 			0x7f	//終了座標

///set page address
#define PAGE_ADDRESS			0x22
#define PAGE_START			0x00	//開始ページ
#define PAGE_END				0x07	//終了ぺージ
#define PAGE_CMD				0xb0

///scrolling Horizontal
#define HORI_SCROLL_RIGHT			0x26
#define HORI_SCROLL_LEFT				0x27
#define HORI_DUMMY_BYTE_00			0x00
#define HORI_DUMMY_BYTE_FF			0xff
#define HORI_SCROLL_PAGE_START		0x00
#define HORI_SCROLL_PAGE_END		0x01
#define HORI_SCROLL_SPEED			0x05	//0x00~0x07

///scrolling Vertical
#define VERTICAL_SCROLL				0xa3
#define VERTICAL_AREA_A				0x0f
#define VERTICAL_AREA_B				0x0f

///scrolling Vertical and Horizontal
#define DIAGONAL_SCROLL_RIGHT		0x29
#define DIAGONAL_SCROLL_LEFT		0x2a
#define DIAGONAL_DUMMY_BYTE_00		0x00
#define DIAGONAL_SCROLL_PAGE_START	0x00
#define DIAGONAL_SCROLL_PAGE_END	0x07
#define DIAGONAL_SCROLL_SPEED		0x06
#define DIAGONAL_SCROLL_OFFSET		0x3f	//0x00~0x3f,移動の角度調整

///scroll start stop
#define SCROLL_START			0x2f
#define SCROLL_STOP			0x2e

#endif /* INC_LCD_SSD1306_H_ */
