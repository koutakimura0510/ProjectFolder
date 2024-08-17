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