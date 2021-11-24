#include <Arduino.h>
#include <stdint.h>
#include <Wire.h>
#include "ssd1306.h"


/**
 * @brief  I2C送信関数
 * @note   
 * @param  cmd: 送信データ
 * @retval 
 */
int i2c_write(byte cmd, byte data) {
	// Wire.beginTransmission(0x3c);
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

void setup() {
	pinMode(25, OUTPUT);
	digitalWrite(25, HIGH);
	// Serial.begin(115200);
	// Serial.println("start0");
	Wire.begin();
	Wire.setClock(400000);
	// ssd1306_init();
}

void loop() {
	static uint32_t data = 0;
	static uint32_t led = 0;

	i2c_write(WR_BYTE, data);
	digitalWrite(25, led);
	delay(1000);

	if (led == 0)
	{
		led = 1;
	} else {
		led = 0;
	}
	data++;
	data &= 0x0f;
	
	// lcd_clear();
	// Serial.println("start0");
}