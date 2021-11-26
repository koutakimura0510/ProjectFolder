/*
 * Create 2021/10/21
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  PlatformIO
 * Borad  ESP32 DDevkitC
 * -
 * IC      ssd1306
 */
#ifndef ssd1306_h_
#define ssd1306_h_

#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))

// ssd1306アドレス
#define LCD_ADRRESS		            (0x78)

// LCDサイズ
#define MAX_CULUMN		            (128)
#define MAX_HEIGHT		            (64)
#define DISPLAY_SIZE                (MAX_CULUMN * MAX_HEIGHT)
#define MAX_PAGE		            (8)
#define BIT_WIDTH		            (8)
#define LCD_POWER_ON 	            (1000)

#define STRAIGHT		            (0)
#define BEND			            (1)

#define MAX_DISP		            (1024)	//LCDの表示ドット数
#define CMD_BYTE 		            (0x00)	//設定コマンド
#define WR_BYTE	 		            (0x40)	//書き込みコマンド
#define CLEAR_DISP		            (0x00)

// Hardware Cinfiguration
#define SCAN_DIRECTION	            (0xC8)	//反転表示
#define SET_COM_PIN		            (0xda)	//
#define PIN_HARD		            (0x12)	//0だと間隔が広がる

// contrast_set
#define CONTRAST_SET	            (0x81)
#define CONTRAST_VALUE	            (0xff)	//最大255

// initial
#define CHARGE_PUMP			        (0x8d)
#define SER_SEGMENT_REMAP	        (0xa1)
#define ENABLE_CHARGE_PUMP	        (0x14)
#define DISPLAY_ON			        (0xaf)

// set Display Clock
#define SET_DISPLAY_CLOCK	        (0xd5)
#define OSCILLATOR_RATIO	        (0xf0)	//クロックを設定0x00~0xf0

// set Pre charge period
#define SET_PERIOD			        (0xd9)
#define SET_DCLK			        (0xff)	//Dクロックを設定0x00~0xff

// set Vcomh Deselect
#define SET_VCOMH			        (0xdb)
#define VCOMH_LEVEL			        (0x30)	//電圧発生回路の設定

// Set Memory Addressing Mode
#define MEMORY_MODE			        (0x20)
#define HORIZONTAL_MODE		        (0x00)
#define VERTICAL_MODE		        (0x01)
#define PAGE_MODE			        (0x02)
#define INVALID				        (0x03)

// Set Column
#define COLUMN_BIT			        (0x0f)
#define HI_COLUMN			        (0x10)
    
// set column address
#define COLUMN_ADDRESS		        (0x21)
#define	COLUMN_START		        (0x00)	//開始座標
#define COLUMN_END 			        (0x7f)	//終了座標

// set page address
#define PAGE_ADDRESS		        (0x22)
#define PAGE_START			        (0x00)	//開始ページ
#define PAGE_END			        (0x07)	//終了ぺージ
#define PAGE_CMD			        (0xb0)

// scrolling Horizontal
#define HORI_SCROLL_RIGHT		    (0x26)
#define HORI_SCROLL_LEFT		    (0x27)
#define HORI_DUMMY_BYTE_00		    (0x00)
#define HORI_DUMMY_BYTE_FF		    (0xff)
#define HORI_SCROLL_PAGE_START	    (0x00)
#define HORI_SCROLL_PAGE_END	    (0x01)
#define HORI_SCROLL_SPEED		    (0x05)	//0x00~0x07

// scrolling Vertical
#define VERTICAL_SCROLL			    (0xa3)
#define VERTICAL_AREA_A			    (0x0f)
#define VERTICAL_AREA_B				(0x0f)

// scrolling Vertical and Horizontal
#define DIAGONAL_SCROLL_RIGHT		(0x29)
#define DIAGONAL_SCROLL_LEFT		(0x2a)
#define DIAGONAL_DUMMY_BYTE_00		(0x00)
#define DIAGONAL_SCROLL_PAGE_START	(0x00)
#define DIAGONAL_SCROLL_PAGE_END	(0x07)
#define DIAGONAL_SCROLL_SPEED		(0x06)
#define DIAGONAL_SCROLL_OFFSET		(0x3f)	//0x00~0x3f,移動の角度調整

// scroll start stop
#define SCROLL_START		        (0x2f)
#define SCROLL_STOP			        (0x2e)


// 関数プロトタイプ宣言
int i2c_write(byte cmd, byte data);
void lcd_clear(void);
void ssd1306_init(void);


/**
 * @brief  I2C送信関数
 * @note   
 * @param  cmd: 送信データ
 * @retval 
 */
int i2c_write(byte cmd, byte data)
{
	Wire.beginTransmission(0x3c);
	// Wire.write(cmd);
	Wire.write(data);

	return Wire.endTransmission();
}


/**
 * @brief  LCDの画面クリア関数
 * @note   
 * @retval None
 */
void lcd_clear(void)
{
	static const uint8_t clear_table[] =
	{
			SCROLL_STOP,
			MEMORY_MODE,
			HORIZONTAL_MODE,
			COLUMN_ADDRESS,
			COLUMN_START,
			COLUMN_END,
			PAGE_ADDRESS,
			PAGE_START,
			PAGE_END,
	};

	for (uint8_t i = 0; i < NUM(clear_table); i++) {
		i2c_write(CMD_BYTE, clear_table[i]);
	}

	for (uint16_t i = 0; i < MAX_DISP; i++) {
		i2c_write(WR_BYTE, CLEAR_DISP);
	}
}


/**
 * @brief  SSD1306 LCD初期化関数
 * @note   
 * @retval None
 */
void ssd1306_init(void)
{
	static const uint8_t initial_table[] =
	{
		CONTRAST_SET,
		CONTRAST_VALUE,
		SER_SEGMENT_REMAP,
		CHARGE_PUMP,
		ENABLE_CHARGE_PUMP,
		SCAN_DIRECTION,
		SET_COM_PIN,
		PIN_HARD,
		SET_DISPLAY_CLOCK,
		OSCILLATOR_RATIO,
		SET_PERIOD,
		SET_DCLK,
		SET_VCOMH,
		VCOMH_LEVEL,
		DISPLAY_ON,
	};

	delay(300);

	for (uint8_t i = 0; i < NUM(initial_table); i++ ) {
		i2c_write(CMD_BYTE, initial_table[i]);
		delay(10);
	}

	lcd_clear();
}


#endif
