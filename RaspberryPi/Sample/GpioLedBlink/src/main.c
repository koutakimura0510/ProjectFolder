//----------------------------------------------------------
// Create  2022/7/17
// Author  koutakimura
// -
// RaspberryPi GPIO 操作 LED Blink
// 
//----------------------------------------------------------

/**----------------------------------------------------------
 * Include
 *---------------------------------------------------------*/
#include <stdio.h>
#include <stdbool.h>

/**----------------------------------------------------------
 * 古いライブラリの場合は int, char など使用し、
 * 自作関数や、uint型に対応しているものは stdint を使用
 *---------------------------------------------------------*/
#include <stdint.h>	
#include <bcm2835.h>


//----------------------------------------------------------
// Pre Process
//----------------------------------------------------------
#define GPIO_LED_0_SEl (22)


//----------------------------------------------------------
// bcm2835 初期化
//----------------------------------------------------------
bool bcm_init(void)
{
	if (!bcm2835_init())
	{
		printf("bcm2835 not init\n");
		return false;
	}

	bcm2835_gpio_fsel(GPIO_LED_0_SEl, BCM2835_GPIO_FSEL_OUTP);
	printf("bcm2835 init ok\n");

	return true;
}

/**----------------------------------------------------------
 * bcm close GPIO 制御終了
 *---------------------------------------------------------*/
bool bcm_close(void)
{
	bcm2835_gpio_write(GPIO_LED_0_SEl, LOW);
	
	if (!bcm2835_close())
	{
		printf("bcm2835 not close\n");
		return false;
	}

	printf("bcm2835 close ok\n");

	return true;
}


//----------------------------------------------------------
// bcm led blink
//----------------------------------------------------------
void bcm_led_blink(uint8_t blink_count, unsigned int blink_on_time, unsigned int blink_off_time)
{
	for (uint8_t i = 0; i < blink_count; i++)
	{
		bcm2835_gpio_write(GPIO_LED_0_SEl, HIGH);
		bcm2835_delay(blink_on_time);
		bcm2835_gpio_write(GPIO_LED_0_SEl, LOW);
		bcm2835_delay(blink_off_time);
	}
}


/**----------------------------------------------------------
 * main 関数
 *---------------------------------------------------------*/
int main(int argc, char *argv[])
{
	if (false == bcm_init())
	{
		return 1;
	}

	bcm_led_blink(8, 100, 400);

	if (false == bcm_close())
	{
		return 1;
	}

	return 0;
}