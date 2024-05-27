/**-----------------------------------------------------------------------------
 * Create  2023/10/15
 * Author  kouta kimura
 * -
 * Video Tx Block function
 *-----------------------------------------------------------------------------*/
#include "../include/system_wrapper.h"


/**------------------------------------------
 * TFTLCD
 *------------------------------------------*/
#define TFT_DISPLAY_WIDTH	(240)		// 最大横幅
#define TFT_DISPLAY_HEIGHT	(320)		// 最大縦幅


/**------------------------------------------
 * インターフェース設定
 *------------------------------------------*/
#define MCU_INTERFACE		(0x00)
#define RGB_INTERFACE		(0x06)	// 0x08 = VSYNC Inteface
#define RGB_16bit_MODE		(0x55)
#define RGB_18bit_MODE		(0x66)	// DPI[6:4] / DBI[2:0]
#define RGB_SELECT			(0x40)	// RCM[1:0] "11" Ext Sync Mode / "10" DE Mode
#define INIT_SIZE			(71)

#define DRAW_INTERFACE		(RGB_INTERFACE)
#define RGB_BIT_WIDTH		(RGB_16bit_MODE)
#define SYNC_MODE_SEL		(RGB_SELECT)


/**------------------------------------------
 * ST7789V
 *------------------------------------------*/
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
#define MEMORY_ACCESS_CONTROL		(0x36)	// 表示方向の設定
#define PIXEL_FORMAT_SET			(0x3A)
#define RAM_CTRL					(0xB0)
#define RGB_INTERFACE_CONTROL		(0xB1)
#define FRAME_RATE_CONTROL_NOARMAL_MODE (0xC6)	// Default 0x0F 60fps
#define POSITIVE_GAMMA 				(0xE0)
#define NEGATIVE_GAMMA 				(0xE1)

#define TFT_CMD_BYTE (0x00)
#define TFT_DATA_BYTE (0x01)

/**----------------------------------------------------------------------------
 * TFT 初期設定
 *---------------------------------------------------------------------------*/
void video_tft_init(void)
{
	uint8_t tft_init_buff[][2] = {
		{TFT_CMD_BYTE,  SOFTWARE_RESET},
		// {TFT_CMD_BYTE,  DISPLAY_MODE_ON},
		{TFT_CMD_BYTE,  TFT_DISPLAY_OFF},
		{TFT_CMD_BYTE,  PIXEL_FORMAT_SET},
		{TFT_DATA_BYTE, RGB_BIT_WIDTH},
		{TFT_CMD_BYTE,  MEMORY_ACCESS_CONTROL},
		{TFT_DATA_BYTE, 0x14},
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
		{TFT_DATA_BYTE, 0x00},
		{TFT_CMD_BYTE,  COLUMN_ADDRESS_SET},
		{TFT_DATA_BYTE, 0x00},
		{TFT_DATA_BYTE, 0x00},
		{TFT_DATA_BYTE, TFT_DISPLAY_WIDTH >> 8},
		{TFT_DATA_BYTE, TFT_DISPLAY_WIDTH & 0xff},
		{TFT_CMD_BYTE,  PAGE_ADDRESS_SET},
		{TFT_DATA_BYTE, 0x00},
		{TFT_DATA_BYTE, 0x00},
		{TFT_DATA_BYTE, TFT_DISPLAY_HEIGHT >> 8},
		{TFT_DATA_BYTE, TFT_DISPLAY_HEIGHT & 0xff},
		//tft_init[68] = {TFT_CMD_BYTE, DISPLAY_INVER_ON};
		{TFT_CMD_BYTE,  SLEEP_MODE_OFF},
		{TFT_CMD_BYTE,  TFT_DISPLAY_ON},
		{TFT_CMD_BYTE,  MEMORY_WRITE},
	};

	usi_write_cmd(0x03, VIDEO_REG_TFT_IM);
	usi_write_cmd(0x01, VIDEO_REG_TFT_GATE);
	usi_write_cmd(0x01, VIDEO_REG_TFT_RD);
	usi_write_cmd(0x01, VIDEO_REG_TFT_WR);

	// Hardware RST
	usi_write_cmd(0x01, VIDEO_REG_TFT_RST);
	usi_write_cmd(0x00, VIDEO_REG_TFT_RST);
	wait_ms(50);
	usi_write_cmd(0x01, VIDEO_REG_TFT_RST);
	wait_ms(120);

	for (uint8_t i = 0; i < ROWS(tft_init_buff); i++) {
		if (TFT_CMD_BYTE == tft_init_buff[i][0]) {
			usi_write_cmd(0x00, VIDEO_REG_TFT_RS);
		}else{
			usi_write_cmd(0x01, VIDEO_REG_TFT_RS);
		}

		if (TFT_CMD_BYTE == tft_init_buff[i][0]) {
			usi_write_cmd(0x01, VIDEO_REG_TFT_CS);
			wait_ms(1);
			usi_write_cmd(0x00, VIDEO_REG_TFT_CS);
		}	

		usi_write_cmd(tft_init_buff[i][1], VIDEO_REG_TFT_DATA);
		usi_write_cmd(0x00, VIDEO_REG_TFT_WR);
		wait_ms(1);
		usi_write_cmd(0x01, VIDEO_REG_TFT_WR);
		wait_ms(50);
	}

	usi_write_cmd(0x01, VIDEO_REG_TFT_CS);
	usi_write_cmd(0x00, VIDEO_REG_TFT_GATE);
	usi_write_cmd(0x00, VIDEO_REG_VSG_RST);
}


/**-----------------------------------------------------------------------------
 * color bar 描画設定
 *-----------------------------------------------------------------------------*/
void video_color_bar(void)
{
	usi_write_cmd(0x000000ff, VIDEO_REG_DOT_SQUARE_COLOR1);
	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT1);
	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT1);
	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_TOP1);
	usi_write_cmd(45, VIDEO_REG_DOT_SQUARE_UNDER1);

	usi_write_cmd(0x0000ff00, VIDEO_REG_DOT_SQUARE_COLOR2);
	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT2);
	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT2);
	usi_write_cmd(46, VIDEO_REG_DOT_SQUARE_TOP2);
	usi_write_cmd(91, VIDEO_REG_DOT_SQUARE_UNDER2);

	usi_write_cmd(0x00ff0000, VIDEO_REG_DOT_SQUARE_COLOR3);
	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT3);
	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT3);
	usi_write_cmd(92, VIDEO_REG_DOT_SQUARE_TOP3);
	usi_write_cmd(137, VIDEO_REG_DOT_SQUARE_UNDER3);

	usi_write_cmd(0x0000fa9a, VIDEO_REG_DOT_SQUARE_COLOR4);
	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT4);
	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT4);
	usi_write_cmd(183, VIDEO_REG_DOT_SQUARE_TOP4);
	usi_write_cmd(228, VIDEO_REG_DOT_SQUARE_UNDER4);

	usi_write_cmd(0x00ff00ff, VIDEO_REG_DOT_SQUARE_COLOR5);
	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT5);
	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT5);
	usi_write_cmd(229, VIDEO_REG_DOT_SQUARE_TOP5);
	usi_write_cmd(272, VIDEO_REG_DOT_SQUARE_UNDER5);
}

/**-----------------------------------------------------------------------------
 * color bar 描画設定
 *-----------------------------------------------------------------------------*/
void video_gauge(uint32_t gauge)
{
	usi_write_cmd(0x0000, VIDEO_REG_DOT_SQUARE_COLOR1);
	usi_write_cmd(0x0000, VIDEO_REG_DOT_SQUARE_COLOR2);
	usi_write_cmd(0xffff, VIDEO_REG_DOT_SQUARE_COLOR3);
	usi_write_cmd(82, VIDEO_REG_DOT_SQUARE_LEFT3);
	usi_write_cmd(190, VIDEO_REG_DOT_SQUARE_RIGHT3);
	usi_write_cmd(180, VIDEO_REG_DOT_SQUARE_TOP3);
	usi_write_cmd(220, VIDEO_REG_DOT_SQUARE_UNDER3);
	usi_write_cmd(0x0000, VIDEO_REG_DOT_SQUARE_COLOR4);
	usi_write_cmd(86, VIDEO_REG_DOT_SQUARE_LEFT4);
	usi_write_cmd(186, VIDEO_REG_DOT_SQUARE_RIGHT4);
	usi_write_cmd(180+2, VIDEO_REG_DOT_SQUARE_TOP4);
	usi_write_cmd(220-2, VIDEO_REG_DOT_SQUARE_UNDER4);
	usi_write_cmd(0x000f, VIDEO_REG_DOT_SQUARE_COLOR5);
	usi_write_cmd(86, VIDEO_REG_DOT_SQUARE_LEFT5);
	usi_write_cmd(86+gauge, VIDEO_REG_DOT_SQUARE_RIGHT5);
	usi_write_cmd(180+2, VIDEO_REG_DOT_SQUARE_TOP5);
	usi_write_cmd(220-2, VIDEO_REG_DOT_SQUARE_UNDER5);
}

/**
 * @brief  
 * @note   
 * @param  sdl: SDL_Rect adrs
 * @param  color: 描画色
 * @param  adrs_id: fpga_square_adrs の参照用 Index
 * @retval None
 */
void video_square_draw(SDL_Rect *sdl, uint16_t color, uint32_t adrs_id)
{
	static const uint32_t fpga_square_adrs[7][5] = {
		{VIDEO_REG_DOT_SQUARE_COLOR1, VIDEO_REG_DOT_SQUARE_LEFT1, VIDEO_REG_DOT_SQUARE_RIGHT1, VIDEO_REG_DOT_SQUARE_TOP1, VIDEO_REG_DOT_SQUARE_UNDER1},
		{VIDEO_REG_DOT_SQUARE_COLOR2, VIDEO_REG_DOT_SQUARE_LEFT2, VIDEO_REG_DOT_SQUARE_RIGHT2, VIDEO_REG_DOT_SQUARE_TOP2, VIDEO_REG_DOT_SQUARE_UNDER2},
		{VIDEO_REG_DOT_SQUARE_COLOR3, VIDEO_REG_DOT_SQUARE_LEFT3, VIDEO_REG_DOT_SQUARE_RIGHT3, VIDEO_REG_DOT_SQUARE_TOP3, VIDEO_REG_DOT_SQUARE_UNDER3},
		{VIDEO_REG_DOT_SQUARE_COLOR4, VIDEO_REG_DOT_SQUARE_LEFT4, VIDEO_REG_DOT_SQUARE_RIGHT4, VIDEO_REG_DOT_SQUARE_TOP4, VIDEO_REG_DOT_SQUARE_UNDER4},
		{VIDEO_REG_DOT_SQUARE_COLOR5, VIDEO_REG_DOT_SQUARE_LEFT5, VIDEO_REG_DOT_SQUARE_RIGHT5, VIDEO_REG_DOT_SQUARE_TOP5, VIDEO_REG_DOT_SQUARE_UNDER5},
		{VIDEO_REG_DOT_SQUARE_COLOR6, VIDEO_REG_DOT_SQUARE_LEFT6, VIDEO_REG_DOT_SQUARE_RIGHT6, VIDEO_REG_DOT_SQUARE_TOP6, VIDEO_REG_DOT_SQUARE_UNDER6},
		{VIDEO_REG_DOT_SQUARE_COLOR7, VIDEO_REG_DOT_SQUARE_LEFT7, VIDEO_REG_DOT_SQUARE_RIGHT7, VIDEO_REG_DOT_SQUARE_TOP7, VIDEO_REG_DOT_SQUARE_UNDER7}
	};
	
	usi_write_cmd(color, fpga_square_adrs[adrs_id][0]);
	usi_write_cmd(sdl->x, fpga_square_adrs[adrs_id][1]);
	usi_write_cmd(sdl->w, fpga_square_adrs[adrs_id][2]);
	usi_write_cmd(sdl->y, fpga_square_adrs[adrs_id][3]);
	usi_write_cmd(sdl->h, fpga_square_adrs[adrs_id][4]);
}


// /**-----------------------------------------------------------------------------
//  * Create  2023/10/15
//  * Author  kouta kimura
//  * -
//  * Video Tx Block function
//  *-----------------------------------------------------------------------------*/
// #include "../include/system_wrapper.h"


// /**------------------------------------------
//  * TFTLCD
//  *------------------------------------------*/
// #define TFT_DISPLAY_WIDTH	(240)		// 最大横幅
// #define TFT_DISPLAY_HEIGHT	(320)		// 最大縦幅


// /**------------------------------------------
//  * インターフェース設定
//  *------------------------------------------*/
// #define SYSTEM_INTERFACE	(0x00)
// #define RGB_INTERFACE		(0x06)	// 0x08 = VSYNC Inteface
// #define RGB_16bit_MODE		(0x55)
// #define RGB_18bit_MODE		(0x66)	// DPI[6:4] / DBI[2:0]
// #define RGB_SELECT			(0x40)	// RCM[1:0] "11" Ext Sync Mode / "10" DE Mode
// #define INIT_SIZE			(71)

// #define DRAW_INTERFACE		(RGB_INTERFACE)
// #define RGB_BIT_WIDTH		(RGB_18bit_MODE)
// #define SYNC_MODE_SEL		(RGB_SELECT)


// /**------------------------------------------
//  * レジスタ名 データシートの並び順で定義
//  *------------------------------------------*/
// #define SOFTWARE_RESET				(0x01)	// Software Reset
// #define READ_DISPLAY_IDEN			(0x04)
// #define READ_DISPLAY_STATUS			(0x09)
// #define READ_DISPLAY_POWER			(0x0a)
// #define READ_DISPLAY_MADCTL			(0x0b)
// #define READ_DISPLAY_PIXEL_FORMAT	(0x0c)
// #define READ_DISPLAY_IMAGE			(0x0d)
// #define READ_DISPLAY_SIGNAL			(0x0e)
// #define READ_DISPLAY_SELF			(0x0f)
// #define ENTER_SLEEP_MODE			(0x10)	// Sleep Mode に設定
// #define SLEEP_MODE					(0x11)	// Sleep Mode から復帰
// #define PARTIAL_MODE_ON				(0x12)
// #define DISPLAY_MODE_ON				(0x13)
// #define DISPLAY_INVER_OFF			(0x20)
// #define DISPLAY_INVER_ON			(0x21)	// 表示色反転
// #define GAMMA_SET					(0x26)
// #define TFT_DISPLAY_OFF				(0x28)
// #define TFT_DISPLAY_ON				(0x29)
// #define COLUMN_ADDRESS_SET			(0x2A)
// #define PAGE_ADDRESS_SET			(0x2B)
// #define MEMORY_WRITE				(0x2C)
// #define COLOR_SET					(0x2D)
// #define MEMORY_READ					(0x2E)
// #define PARTIAL_AREA				(0x30)
// #define SCROLLING_DEFINTION			(0x33)
// #define EFFECT_LINE_OFF				(0x34)
// #define EFFECT_LINE_ON				(0x35)
// #define MEMORY_ACCESS_CONTROL		(0x36)	// 表示方向の設定
// #define TFT_VERTICAL_SCROLL			(0x37)
// #define IDLE_MODE_OFF				(0x38)
// #define IDLE_MODE_ON				(0x39)
// #define PIXEL_FORMAT_SET			(0x3A)
// #define WRITE_MEMORY_CONTINUE		(0x3C)
// #define READ_MEMORY_CONTINUE		(0x3E)
// #define SET_TEAR_SCANLINE			(0x44)
// #define GET_SCANLINE				(0x45)
// #define WRITE_DISPLAY_BRIGHTNESS	(0x51)
// #define READ_DISPLAY_BRIGHTNESS		(0x52)
// #define WRITE_CTRL_DISPLAY			(0x53)
// #define READ_CTRL_DISPLAY			(0x54)
// #define WRITE_CONTENT_ADAPIVE		(0x55)
// #define READ_CONTENT_ADAPIVE		(0x56)
// #define READ_ID1					(0xDA)
// #define READ_ID2					(0xDB)
// #define READ_ID3					(0xDC)
// #define RGB_INTERFACE_SINGLE_CON	(0xB0) // RGB interface Signal Control
// #define FRAME_CONTROL_NORMAL		(0xB1)
// #define FRAME_CONTROL_IDLE			(0xB2)
// #define FRAME_CONTROL_PARTIAL 		(0xB3)
// #define DISPLAY_INVERSION_CONTROL 	(0xB4)
// #define BLANKING_PORCH_CONTROL 		(0xB5)
// #define DISPALY_FUNCTION_CONTROL 	(0xB6)
// #define ENTRY_MODE_SET 				(0xB7)
// #define BACKLIGHT_CONTROL_1 		(0xB8)
// #define BACKLIGHT_CONTROL_2 		(0xB9)
// #define BACKLIGHT_CONTROL_3 		(0xBA)
// #define BACKLIGHT_CONTROL_4 		(0xBB)
// #define BACKLIGHT_CONTROL_5 		(0xBC)
// #define BACKLIGHT_CONTROL_7 		(0xBE)
// #define BACKLIGHT_CONTROL_8 		(0xBF)
// #define POWER_CONTROL_1 			(0xC0)
// #define POWER_CONTROL_2 			(0xC1)
// #define VCOM_CONTROL_1 				(0xC5)
// #define VCOM_CONTROL_2 				(0xC7)
// #define NV_MEMORY_WRITE 			(0xD0)
// #define NV_MEMORY_KEY 				(0xD1)
// #define NV_MEMORY_READ 				(0xD2)
// #define READ_ID4 					(0xD3)
// #define POSITIVE_GAMMA 				(0xE0)
// #define NEGATIVE_GAMMA 				(0xE1)
// #define DIGITAL_GAMMA_CONTROL_1 	(0xE2)
// #define DIGITAL_GAMMA_CONTROL_2 	(0xE3)
// #define INTERFACE_CONTROL 			(0xF6)

// #define TFT_CMD_BYTE (0x00)
// #define TFT_DATA_BYTE (0x01)

// /**----------------------------------------------------------------------------
//  * TFT 初期設定
//  *---------------------------------------------------------------------------*/
// void video_tft_init(void)
// {
// 	uint8_t tft_init_buff[][2] = {
// 		{TFT_CMD_BYTE,  SOFTWARE_RESET},
// 		// {TFT_CMD_BYTE,  DISPLAY_MODE_ON},
// 		{TFT_CMD_BYTE,  TFT_DISPLAY_OFF},
// 		{TFT_CMD_BYTE,  PIXEL_FORMAT_SET},
// 		{TFT_DATA_BYTE, RGB_BIT_WIDTH},
// 		{TFT_CMD_BYTE,  POWER_CONTROL_1},
// 		{TFT_DATA_BYTE, 0x01},
// 		{TFT_CMD_BYTE,  POWER_CONTROL_2},
// 		{TFT_DATA_BYTE, 0x00},
// 		{TFT_CMD_BYTE,  VCOM_CONTROL_1},
// 		{TFT_DATA_BYTE, 0x3e},
// 		{TFT_DATA_BYTE, 0x28},
// 		{TFT_CMD_BYTE,  VCOM_CONTROL_2},
// 		{TFT_DATA_BYTE, 0x86},
// 		{TFT_CMD_BYTE,  MEMORY_ACCESS_CONTROL},
// 		{TFT_DATA_BYTE, 0x14},
// 		{TFT_CMD_BYTE,  FRAME_CONTROL_NORMAL},
// 		{TFT_DATA_BYTE, 0x00},
// 		{TFT_DATA_BYTE, 0x1f},
// 		{TFT_CMD_BYTE,  DISPALY_FUNCTION_CONTROL},
// 		{TFT_DATA_BYTE, 0x0a},
// 		{TFT_DATA_BYTE, 0xa2},
// 		{TFT_DATA_BYTE, 0x27},
// 		{TFT_DATA_BYTE, 0x04},
// 		{TFT_CMD_BYTE,  GAMMA_SET},
// 		{TFT_DATA_BYTE, 0x01},
// 		{TFT_CMD_BYTE,  POSITIVE_GAMMA},
// 		{TFT_DATA_BYTE, 0x0f},
// 		{TFT_DATA_BYTE, 0x31},
// 		{TFT_DATA_BYTE, 0x2b},
// 		{TFT_DATA_BYTE, 0x0c},
// 		{TFT_DATA_BYTE, 0x0e},
// 		{TFT_DATA_BYTE, 0x10},
// 		{TFT_DATA_BYTE, 0x03},
// 		{TFT_DATA_BYTE, 0x0e},
// 		{TFT_DATA_BYTE, 0x09},
// 		{TFT_DATA_BYTE, 0x00},
// 		{TFT_CMD_BYTE,  NEGATIVE_GAMMA},
// 		{TFT_DATA_BYTE, 0x00},
// 		{TFT_DATA_BYTE, 0x0e},
// 		{TFT_DATA_BYTE, 0x14},
// 		{TFT_DATA_BYTE, 0x03},
// 		{TFT_DATA_BYTE, 0x11},
// 		{TFT_DATA_BYTE, 0x0f},
// 		{TFT_DATA_BYTE, 0x0c},
// 		{TFT_DATA_BYTE, 0x31},
// 		{TFT_DATA_BYTE, 0x36},
// 		{TFT_DATA_BYTE, 0x0f},
// 		{TFT_CMD_BYTE,  INTERFACE_CONTROL},
// 		{TFT_DATA_BYTE, 0x01},
// 		{TFT_DATA_BYTE, 0x10},
// 		{TFT_DATA_BYTE, DRAW_INTERFACE},
// 		{TFT_CMD_BYTE,  RGB_INTERFACE_SINGLE_CON},
// 		{TFT_DATA_BYTE, SYNC_MODE_SEL},
// 		{TFT_CMD_BYTE,  BLANKING_PORCH_CONTROL},
// 		{TFT_DATA_BYTE, 0x04},
// 		{TFT_DATA_BYTE, 0x02},
// 		{TFT_DATA_BYTE, 0x10},
// 		{TFT_DATA_BYTE, 0x18},
// 		{TFT_CMD_BYTE,  COLUMN_ADDRESS_SET},
// 		{TFT_DATA_BYTE, 0x00},
// 		{TFT_DATA_BYTE, 0x00},
// 		{TFT_DATA_BYTE, TFT_DISPLAY_WIDTH >> 8},
// 		{TFT_DATA_BYTE, TFT_DISPLAY_WIDTH & 0xff},
// 		{TFT_CMD_BYTE,  PAGE_ADDRESS_SET},
// 		{TFT_DATA_BYTE, 0x00},
// 		{TFT_DATA_BYTE, 0x00},
// 		{TFT_DATA_BYTE, TFT_DISPLAY_HEIGHT >> 8},
// 		{TFT_DATA_BYTE, TFT_DISPLAY_HEIGHT & 0xff},
// 		//tft_init[68] = {TFT_CMD_BYTE, DISPLAY_INVER_ON};
// 		{TFT_CMD_BYTE,  SLEEP_MODE},
// 		{TFT_CMD_BYTE,  TFT_DISPLAY_ON},
// 		{TFT_CMD_BYTE,  MEMORY_WRITE},
// 	};

// 	usi_write_cmd(0x03, VIDEO_REG_TFT_IM);
// 	usi_write_cmd(0x01, VIDEO_REG_TFT_GATE);
// 	usi_write_cmd(0x01, VIDEO_REG_TFT_RD);
// 	usi_write_cmd(0x01, VIDEO_REG_TFT_WR);

// 	// Hardware RST
// 	usi_write_cmd(0x01, VIDEO_REG_TFT_RST);
// 	usi_write_cmd(0x00, VIDEO_REG_TFT_RST);
// 	wait_ms(50);
// 	usi_write_cmd(0x01, VIDEO_REG_TFT_RST);
// 	wait_ms(120);

// 	for (uint8_t i = 0; i < ROWS(tft_init_buff); i++) {
// 		if (TFT_CMD_BYTE == tft_init_buff[i][0]) {
// 			usi_write_cmd(0x00, VIDEO_REG_TFT_RS);
// 		}else{
// 			usi_write_cmd(0x01, VIDEO_REG_TFT_RS);
// 		}

// 		if (TFT_CMD_BYTE == tft_init_buff[i][0]) {
// 			usi_write_cmd(0x01, VIDEO_REG_TFT_CS);
// 			wait_ms(1);
// 			usi_write_cmd(0x00, VIDEO_REG_TFT_CS);
// 		}	

// 		usi_write_cmd(tft_init_buff[i][1], VIDEO_REG_TFT_DATA);
// 		usi_write_cmd(0x00, VIDEO_REG_TFT_WR);
// 		wait_ms(1);
// 		usi_write_cmd(0x01, VIDEO_REG_TFT_WR);
// 		wait_ms(50);
// 	}

// 	usi_write_cmd(0x01, VIDEO_REG_TFT_CS);
// 	usi_write_cmd(0x00, VIDEO_REG_TFT_GATE);
// 	usi_write_cmd(0x00, VIDEO_REG_VSG_RST);
// }


// /**-----------------------------------------------------------------------------
//  * color bar 描画設定
//  *-----------------------------------------------------------------------------*/
// void video_color_bar(void)
// {
// 	usi_write_cmd(0x000000ff, VIDEO_REG_DOT_SQUARE_COLOR1);
// 	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT1);
// 	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT1);
// 	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_TOP1);
// 	usi_write_cmd(45, VIDEO_REG_DOT_SQUARE_UNDER1);

// 	usi_write_cmd(0x0000ff00, VIDEO_REG_DOT_SQUARE_COLOR2);
// 	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT2);
// 	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT2);
// 	usi_write_cmd(46, VIDEO_REG_DOT_SQUARE_TOP2);
// 	usi_write_cmd(91, VIDEO_REG_DOT_SQUARE_UNDER2);

// 	usi_write_cmd(0x00ff0000, VIDEO_REG_DOT_SQUARE_COLOR3);
// 	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT3);
// 	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT3);
// 	usi_write_cmd(92, VIDEO_REG_DOT_SQUARE_TOP3);
// 	usi_write_cmd(137, VIDEO_REG_DOT_SQUARE_UNDER3);

// 	usi_write_cmd(0x0000fa9a, VIDEO_REG_DOT_SQUARE_COLOR4);
// 	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT4);
// 	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT4);
// 	usi_write_cmd(183, VIDEO_REG_DOT_SQUARE_TOP4);
// 	usi_write_cmd(228, VIDEO_REG_DOT_SQUARE_UNDER4);

// 	usi_write_cmd(0x00ff00ff, VIDEO_REG_DOT_SQUARE_COLOR5);
// 	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT5);
// 	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT5);
// 	usi_write_cmd(229, VIDEO_REG_DOT_SQUARE_TOP5);
// 	usi_write_cmd(272, VIDEO_REG_DOT_SQUARE_UNDER5);
// }

// /**-----------------------------------------------------------------------------
//  * color bar 描画設定
//  *-----------------------------------------------------------------------------*/
// void video_gauge(uint32_t gauge)
// {
// 	usi_write_cmd(0x0000, VIDEO_REG_DOT_SQUARE_COLOR1);
// 	usi_write_cmd(0x0000, VIDEO_REG_DOT_SQUARE_COLOR2);
// 	usi_write_cmd(0xffff, VIDEO_REG_DOT_SQUARE_COLOR3);
// 	usi_write_cmd(82, VIDEO_REG_DOT_SQUARE_LEFT3);
// 	usi_write_cmd(190, VIDEO_REG_DOT_SQUARE_RIGHT3);
// 	usi_write_cmd(180, VIDEO_REG_DOT_SQUARE_TOP3);
// 	usi_write_cmd(220, VIDEO_REG_DOT_SQUARE_UNDER3);
// 	usi_write_cmd(0x0000, VIDEO_REG_DOT_SQUARE_COLOR4);
// 	usi_write_cmd(86, VIDEO_REG_DOT_SQUARE_LEFT4);
// 	usi_write_cmd(186, VIDEO_REG_DOT_SQUARE_RIGHT4);
// 	usi_write_cmd(180+2, VIDEO_REG_DOT_SQUARE_TOP4);
// 	usi_write_cmd(220-2, VIDEO_REG_DOT_SQUARE_UNDER4);
// 	usi_write_cmd(0x000f, VIDEO_REG_DOT_SQUARE_COLOR5);
// 	usi_write_cmd(86, VIDEO_REG_DOT_SQUARE_LEFT5);
// 	usi_write_cmd(86+gauge, VIDEO_REG_DOT_SQUARE_RIGHT5);
// 	usi_write_cmd(180+2, VIDEO_REG_DOT_SQUARE_TOP5);
// 	usi_write_cmd(220-2, VIDEO_REG_DOT_SQUARE_UNDER5);
// }

// /**
//  * @brief  
//  * @note   
//  * @param  sdl: SDL_Rect adrs
//  * @param  color: 描画色
//  * @param  adrs_id: fpga_square_adrs の参照用 Index
//  * @retval None
//  */
// void video_square_draw(SDL_Rect *sdl, uint16_t color, uint32_t adrs_id)
// {
// 	static const uint32_t fpga_square_adrs[7][5] = {
// 		{VIDEO_REG_DOT_SQUARE_COLOR1, VIDEO_REG_DOT_SQUARE_LEFT1, VIDEO_REG_DOT_SQUARE_RIGHT1, VIDEO_REG_DOT_SQUARE_TOP1, VIDEO_REG_DOT_SQUARE_UNDER1},
// 		{VIDEO_REG_DOT_SQUARE_COLOR2, VIDEO_REG_DOT_SQUARE_LEFT2, VIDEO_REG_DOT_SQUARE_RIGHT2, VIDEO_REG_DOT_SQUARE_TOP2, VIDEO_REG_DOT_SQUARE_UNDER2},
// 		{VIDEO_REG_DOT_SQUARE_COLOR3, VIDEO_REG_DOT_SQUARE_LEFT3, VIDEO_REG_DOT_SQUARE_RIGHT3, VIDEO_REG_DOT_SQUARE_TOP3, VIDEO_REG_DOT_SQUARE_UNDER3},
// 		{VIDEO_REG_DOT_SQUARE_COLOR4, VIDEO_REG_DOT_SQUARE_LEFT4, VIDEO_REG_DOT_SQUARE_RIGHT4, VIDEO_REG_DOT_SQUARE_TOP4, VIDEO_REG_DOT_SQUARE_UNDER4},
// 		{VIDEO_REG_DOT_SQUARE_COLOR5, VIDEO_REG_DOT_SQUARE_LEFT5, VIDEO_REG_DOT_SQUARE_RIGHT5, VIDEO_REG_DOT_SQUARE_TOP5, VIDEO_REG_DOT_SQUARE_UNDER5},
// 		{VIDEO_REG_DOT_SQUARE_COLOR6, VIDEO_REG_DOT_SQUARE_LEFT6, VIDEO_REG_DOT_SQUARE_RIGHT6, VIDEO_REG_DOT_SQUARE_TOP6, VIDEO_REG_DOT_SQUARE_UNDER6},
// 		{VIDEO_REG_DOT_SQUARE_COLOR7, VIDEO_REG_DOT_SQUARE_LEFT7, VIDEO_REG_DOT_SQUARE_RIGHT7, VIDEO_REG_DOT_SQUARE_TOP7, VIDEO_REG_DOT_SQUARE_UNDER7}
// 	};
	
// 	usi_write_cmd(color, fpga_square_adrs[adrs_id][0]);
// 	usi_write_cmd(sdl->x, fpga_square_adrs[adrs_id][1]);
// 	usi_write_cmd(sdl->w, fpga_square_adrs[adrs_id][2]);
// 	usi_write_cmd(sdl->y, fpga_square_adrs[adrs_id][3]);
// 	usi_write_cmd(sdl->h, fpga_square_adrs[adrs_id][4]);
// }
