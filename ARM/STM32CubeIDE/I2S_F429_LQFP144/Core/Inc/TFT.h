/*
 * TFT.h
 *
 *  Created on: Jan 23, 2021
 *      Author: koutakimura
 */

#ifndef INC_TFT_H_
#define INC_TFT_H_

/**------------------------------------------
 * 使用するTFT液晶の詳細
 *------------------------------------------*/
#define TFT_DISPLAY_WIDTH	240		// 最大横幅
#define TFT_DISPLAY_HEIGHT	320		// 最大縦幅
#define TFT_MAX_SIZE (TFT_DISPLAY_WIDTH * TFT_DISPLAY_HEIGHT)
#define TFT_CMD_BYTE		0
#define TFT_DATA_BYTE	1

/**------------------------------------------
 * レジスタ設定 データシートの並び順で定義
 *------------------------------------------*/
#define SOFTWARE_RESET				0x01
#define READ_DISPLAY_IDEN			0x04
#define READ_DISPLAY_STATUS			0x09
#define READ_DISPLAY_POWER			0x0A
#define READ_DISPLAY_MADCTL 		0x0B
#define READ_DISPLAY_PIXEL_FORMAT	0x0C
#define READ_DISPLAY_IMAGE			0x0D
#define READ_DISPLAY_SIGNAL			0x0E
#define READ_DISPLAY_SELF			0x0F
#define ENTER_SLEEP_MODE				0x10
#define SLEEP_MODE					0x11
#define PARTIAL_MODE_ON				0x12
#define DISPLAY_MODE_ON				0x13
#define DISPLAY_INVER_OFF			0x20
#define DISPLAY_INVER_ON				0X21
#define GAMMA_SET						0x26
#define TFT_DISPLAY_OFF				0x28
#define TFT_DISPLAY_ON				0x29
#define COLUMN_ADDRESS_SET			0x2A
#define PAGE_ADDRESS_SET				0x2B
#define MEMORY_WRITE					0x2C
#define COLOR_SET						0x2D
#define MEMORY_READ					0x2E
#define PARTIAL_AREA					0x30
#define SCROLLING_DEFINTION			0x33
#define EFFECT_LINE_OFF				0x34
#define EFFECT_LINE_ON				0x35
#define MEMORY_ACCESS_CONTROL		0x36
#define TFT_VERTICAL_SCROLL			0x37
#define IDLE_MODE_OFF				0x38
#define IDLE_MODE_ON					0x39
#define PIXEL_FORMAT_SET				0x3A
#define WRITE_MEMORY_CONTINUE		0x3C
#define READ_MEMORY_CONTINUE		0x3E
#define SET_TEAR_SCANLINE			0x44
#define GET_SCANLINE					0x45
#define WRITE_DISPLAY_BRIGHTNESS	0x51
#define READ_DISPLAY_BRIGHTNESS		0x52
#define WRITE_CTRL_DISPLAY			0x53
#define READ_CTRL_DISPLAY			0x54
#define WRITE_CONTENT_ADAPIVE		0x55
#define READ_CONTENT_ADAPIVE		0x56
#define READ_ID1						0xDA
#define READ_ID2						0xDB
#define READ_ID3						0xDC
#define RGB_INTERFACE				0xB0
#define FRAME_CONTROL_NORMAL		0xB1
#define FRAME_CONTROL_IDLE			0xB2
#define FRAME_CONTROL_PARTIAL		0xB3
#define DISPLAY_INVERSION_CONTROL	0xB4
#define BLANKING_PORCH_CONTROL		0xB5
#define DISPALY_FUNCTION_CONTROL	0xB6
#define ENTRY_MODE_SET				0xB7
#define BACKLIGHT_CONTROL_1			0xB8
#define BACKLIGHT_CONTROL_2			0xB9
#define BACKLIGHT_CONTROL_3			0xBA
#define BACKLIGHT_CONTROL_4			0xBB
#define BACKLIGHT_CONTROL_5			0XBC
#define BACKLIGHT_CONTROL_7			0xBE
#define BACKLIGHT_CONTROL_8			0xBF
#define POWER_CONTROL_1				0xC0
#define POWER_CONTROL_2				0xC1
#define VCOM_CONTROL_1				0xC5
#define VCOM_CONTROL_2				0xC7
#define NV_MEMORY_WRITE				0xD0
#define NV_MEMORY_KEY				0xD1
#define NV_MEMORY_READ				0xD2
#define READ_ID4						0xD3
#define POSITIVE_GAMMA				0xE0
#define NEGATIVE_GAMMA				0xE1
#define DIGITAL_GAMMA_CONTROL_1		0xE2
#define DIGITAL_GAMMA_CONTROL_2		0xE3
#define INTERFACE_CONTROL			0xF6


#endif /* INC_TFT_H_ */
