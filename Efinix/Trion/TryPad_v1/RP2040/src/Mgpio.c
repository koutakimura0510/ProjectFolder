/*------------------------------------------------------------------------------
 * Create 2024/06/15
 * Author Kouta Kimura
 * 
 * SPI 通信で FPGA の制御を行うため、USIB I/F 関連の関数は SPIの関数とまとめる。
 *-----------------------------------------------------------------------------*/
#include "trypad.h"
#include "pico/stdlib.h"

/**-----------------------------------------------------------------------------
 * グローバル変数
 *-----------------------------------------------------------------------------*/

/**-----------------------------------------------------------------------------
 * ファイル内関数
 *-----------------------------------------------------------------------------*/

/**-----------------------------------------------------------------------------
 * led timer blink
 * 
 * pin: GPIO Pin No
 * led_index: LED_INDEX_ENUM の定数
 * blink_time: 1us order, タイマー関数の仕様による
 *-----------------------------------------------------------------------------*/
void led_tmr_blink(uint8_t led_index, uint32_t blink_time)
{
	static uint8_t flash[3] = {0};
	static uint32_t tmr[3] = {0};
	static const uint8_t pin[3] = {
		LED_R,	LED_G,	LED_B,
	};

	if (true == timer_compare(&tmr[led_index], blink_time)) {
		gpio_put(pin[led_index], flash[led_index]);
		flash[led_index] = ~flash[led_index];
	}
}

/**-----------------------------------------------------------------------------
 * led blink
 *-----------------------------------------------------------------------------*/
void led_blink(uint8_t pin, uint8_t count)
{
	for(uint8_t i = 0; i < count; i++) {
		gpio_put(pin, i & 0x01);
		wait_ms(50);
	}
}

void led_light(uint8_t pin, uint8_t value)
{
	gpio_put(pin, value);
}