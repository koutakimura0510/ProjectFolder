/*------------------------------------------------------------------------------
 * Create 2024/06/15
 * Author Kouta Kimura
 * 
 *-----------------------------------------------------------------------------*/
#include "trypad.h"


/**-----------------------------------------------------------------------------
 * ファイル内 グローバル変数
 *-----------------------------------------------------------------------------*/


/**-----------------------------------------------------------------------------
 * ファイル内 プロトタイプ宣言
 *-----------------------------------------------------------------------------*/


/**-----------------------------------------------------------------------------
 * USER MACRO / 
 *-----------------------------------------------------------------------------*/
#define TFT_DISPLAY_WIDTH			(240)		// 最大横幅
#define TFT_DISPLAY_HEIGHT			(320)		// 最大縦幅
#define TFT_DISPLAY_WIDTH_DATA		(240-1)
#define TFT_DISPLAY_HEIGHT_DATA		(320-1)
#define TFT_DISPLAY_HTOTAL_SIZE		((TFT_DISPLAY_WIDTH * TFT_DISPLAY_HEIGHT) - 1)

// Mode Setting
#define MODE_8BIT					(0x01)
#define MODE_16BIT					(0x00)
#define MODE_BITWIDTH				(MODE_16BIT)

// インターフェース設定
#define MCU_INTERFACE				(0x00)
#define RGB_INTERFACE				(0x06)	// 0x08 = VSYNC Inteface
#define RGB_16bit_MODE				(0x55)
#define RGB_18bit_MODE				(0x66)	// DPI[6:4] / DBI[2:0]
#define RGB_SELECT					(0x40)	// RCM[1:0] "11" Ext Sync Mode / "10" DE Mode
#define DRAW_INTERFACE				(RGB_INTERFACE)
#define RGB_BIT_WIDTH				(RGB_16bit_MODE)
#define SYNC_MODE_SEL				(RGB_SELECT)

// ST7789V REG Map
#define SOFTWARE_RESET				(0x01)	// Software Reset
#define SLEEP_MODE_OFF				(0x11)	// Sleep Mode から復帰
#define PARTIAL_MODE_ON				(0x12)
#define NOAMAL_MODE_ON				(0x13)
#define DISPLAY_INVER_OFF			(0x20)
#define DISPLAY_INVER_ON			(0x21)	// 表示色反転
#define GAMMA_SET					(0x26)
#define TFT_DISPLAY_OFF				(0x28)
#define TFT_DISPLAY_ON				(0x29)
#define COLUMN_ADDRESS_SET			(0x2A)
#define PAGE_ADDRESS_SET			(0x2B)
#define MEMORY_WRITE				(0x2C)
#define MEMORY_ACCESS_CONTROL		(0x36)	// MV 1, MX 0, MY 1
#define PIXEL_FORMAT_SET			(0x3A)
#define RAM_CTRL					(0xB0)
#define RGB_INTERFACE_CONTROL		(0xB1)
#define FRAME_RATE_CONTROL_NOARMAL_MODE (0xC6)	// Default 0x0F 60fps
#define POSITIVE_GAMMA 				(0xE0)
#define NEGATIVE_GAMMA 				(0xE1)

// CMD / DATA Select
#define TFT_CMD_BYTE				(0x00)
#define TFT_DATA_BYTE				(0x01)

/**-----------------------------------------------------------------------------
 * ST7789 IPS/TFT Driver initialize
 *-----------------------------------------------------------------------------*/
void st7789_init(void)
{
	static const uint8_t tft_init_buff[][2] = {
		{TFT_CMD_BYTE,  SOFTWARE_RESET},
		// {TFT_CMD_BYTE,  SOFTWARE_RESET},
		{TFT_CMD_BYTE,  SLEEP_MODE_OFF},
		// {TFT_CMD_BYTE,  DISPLAY_MODE_ON},
		{TFT_CMD_BYTE,  TFT_DISPLAY_OFF},
		// {TFT_CMD_BYTE,  TFT_DISPLAY_ON},
		{TFT_CMD_BYTE,  PIXEL_FORMAT_SET},
		{TFT_DATA_BYTE, RGB_BIT_WIDTH},
		{TFT_CMD_BYTE,  MEMORY_ACCESS_CONTROL},
		{TFT_DATA_BYTE, 0xA0},
		{TFT_CMD_BYTE,  GAMMA_SET},
		{TFT_DATA_BYTE, 0x01},
		{TFT_CMD_BYTE,  POSITIVE_GAMMA},
		{TFT_DATA_BYTE, 0x0f},
		{TFT_DATA_BYTE, 0x31},
		{TFT_DATA_BYTE, 0x2b},
		{TFT_DATA_BYTE, 0x0c},
		{TFT_DATA_BYTE, 0x0e},
		{TFT_DATA_BYTE, 0x10},
		{TFT_DATA_BYTE, 0x03},
		{TFT_DATA_BYTE, 0x0e},
		{TFT_DATA_BYTE, 0x09},
		{TFT_DATA_BYTE, 0x00},
		{TFT_CMD_BYTE,  NEGATIVE_GAMMA},
		{TFT_DATA_BYTE, 0x00},
		{TFT_DATA_BYTE, 0x0e},
		{TFT_DATA_BYTE, 0x14},
		{TFT_DATA_BYTE, 0x03},
		{TFT_DATA_BYTE, 0x11},
		{TFT_DATA_BYTE, 0x0f},
		{TFT_DATA_BYTE, 0x0c},
		{TFT_DATA_BYTE, 0x31},
		{TFT_DATA_BYTE, 0x36},
		{TFT_DATA_BYTE, 0x0f},
		{TFT_CMD_BYTE,  RGB_INTERFACE_CONTROL},
		{TFT_DATA_BYTE, 0x00},	// 0x40??
		{TFT_CMD_BYTE,  COLUMN_ADDRESS_SET},
		{TFT_DATA_BYTE, 0x00},
		{TFT_DATA_BYTE, 0x00},
		{TFT_DATA_BYTE, TFT_DISPLAY_HEIGHT_DATA >> 8},		// Display の描画向きによって、Height と Width の設定を切り替える。
		{TFT_DATA_BYTE, TFT_DISPLAY_HEIGHT_DATA & 0xff},	// 今回は、240x320 を 320x240 の向きに変更するため、COL ADRS に Height を設定。
		{TFT_CMD_BYTE,  PAGE_ADDRESS_SET},
		{TFT_DATA_BYTE, 0x00},
		{TFT_DATA_BYTE, 0x00},
		{TFT_DATA_BYTE, TFT_DISPLAY_WIDTH_DATA >> 8},
		{TFT_DATA_BYTE, TFT_DISPLAY_WIDTH_DATA & 0xff},
		// {TFT_CMD_BYTE, DISPLAY_INVER_ON},
		{TFT_CMD_BYTE,  TFT_DISPLAY_ON},
		{TFT_CMD_BYTE,  MEMORY_WRITE},
	};

	usi_write(VIDEO_REG_TFT_IM, MODE_BITWIDTH);
	usi_write(VIDEO_REG_TFT_GATE, 0x01);
	usi_write(VIDEO_REG_TFT_RD, 0x01);
	usi_write(VIDEO_REG_TFT_WR, 0x01);

	// Hardware RST
	usi_write(VIDEO_REG_TFT_RST, 0x01);
	usi_write(VIDEO_REG_TFT_RST, 0x00);
	wait_ms(50);
	usi_write(VIDEO_REG_TFT_RST, 0x01);
	wait_ms(120);

	for (uint8_t i = 0; i < ROWS(tft_init_buff); i++) {
		if (TFT_CMD_BYTE == tft_init_buff[i][0]) {
			usi_write(VIDEO_REG_TFT_DCX, 0x00);	// DCX
		}else{
			usi_write(VIDEO_REG_TFT_DCX, 0x01);
		}

		if (TFT_CMD_BYTE == tft_init_buff[i][0]) {
			usi_write(VIDEO_REG_TFT_CS, 0x01);
			wait_ms(1);
			usi_write(VIDEO_REG_TFT_CS, 0x00);
		}	

		usi_write(VIDEO_REG_TFT_DATA, tft_init_buff[i][1]);
		usi_write(VIDEO_REG_TFT_WR, 0x00);
		wait_ms(1);
		usi_write(VIDEO_REG_TFT_WR, 0x01);
		wait_ms(10);
	}

	usi_write(VIDEO_REG_TFT_DCX, 0x01);
	usi_write(VIDEO_REG_TFT_CS, 0x00);
	usi_write(VIDEO_REG_TFT_GATE, 0x00);
	usi_write(VIDEO_REG_VSG_RST, 0x00);
}


/**-----------------------------------------------------------------------------
 * Disp Invert
 *-----------------------------------------------------------------------------*/
void invert_draw(bool invert)
{
	usi_write(VIDEO_REG_TFT_GATE, 0x01);
	usi_write(VIDEO_REG_TFT_DCX, 0x00);

	if (true == invert) {
		usi_write(VIDEO_REG_TFT_DATA, DISPLAY_INVER_ON);
	}else{
		usi_write(VIDEO_REG_TFT_DATA, DISPLAY_INVER_OFF);
	}
	usi_write(VIDEO_REG_TFT_WR, 0x00);
	wait_us(10);
	usi_write(VIDEO_REG_TFT_WR, 0x01);
	wait_us(10);
	usi_write(VIDEO_REG_TFT_GATE, 0x00);
	usi_write(VIDEO_REG_TFT_DCX, 0x01);
}

/**-----------------------------------------------------------------------------
 * software draw
 *-----------------------------------------------------------------------------*/
void software_draw(uint32_t color)
{
	usi_write(VIDEO_REG_TFT_GATE, 0x01);

	for (uint32_t i = 0; i < TFT_DISPLAY_HTOTAL_SIZE; i++) {
		usi_write(VIDEO_REG_TFT_DATA, color);
		usi_write(VIDEO_REG_TFT_WR, 0x00);
		usi_write(VIDEO_REG_TFT_WR, 0x01);
	}
	usi_write(VIDEO_REG_TFT_GATE, 0x00);
}


/**-----------------------------------------------------------------------------
 * rect Draw
 * 
 * SdlRect *rect : 描画位置が格納されている SdlRect 構造体のアドレス
 * color : RGB565 の色を指定
 *-----------------------------------------------------------------------------*/
void rect_draw(SdlRect *rect)
{
	usi_write(VIDEO_REG_DOT_SQUARE_TOP1, rect->top);
	usi_write(VIDEO_REG_DOT_SQUARE_UNDER1, rect->under);
	usi_write(VIDEO_REG_DOT_SQUARE_LEFT1, rect->left);
	usi_write(VIDEO_REG_DOT_SQUARE_RIGHT1, rect->right);
	usi_write(VIDEO_REG_DOT_SQUARE_COLOR1, rect->color);
}

/**-----------------------------------------------------------------------------
 * rect init
 * 
 * SdlRect *rect : 描画位置が格納されている SdlRect 構造体のアドレス
 * color : RGB565 の色を指定
 *-----------------------------------------------------------------------------*/
void rect_init(SdlRect *rect, int16_t top, int16_t under, int16_t left, int16_t right, uint16_t color)
{
	rect->top	= top;
	rect->under	= under;
	rect->left	= left;
	rect->right	= right;
	rect->color	= color;
}