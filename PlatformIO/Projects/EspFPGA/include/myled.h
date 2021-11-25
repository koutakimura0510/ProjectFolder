/*
 * Create 2021/10/25
 * Author koutakimura
 * Editor VSCode ver1.62.1
 * Build  PlatformIO
 * Borad  ESP32 DDevkitC
 * 
 * GPIOやLEDの簡単な操作をまとめるライブラリ
 */
#ifndef myled_h_
#define myled_h_


/**
 * @brief  指定時間の間隔でLED点滅
 * @note   
 * @param  time: 1msオーダーの点滅時間指定
 * @param  pin:	 操作port
 * @retval None
 */
void led_blink(unsigned int time, unsigned int pin)
{
	static unsigned char led = 0;
	static unsigned long ms_time = 0;
	unsigned long current_time = millis();

	if ((time + ms_time) <= current_time)
	{
		led++;
		led &= 0x01;
		digitalWrite(pin, led);
		ms_time = current_time;
	}
}

#endif
