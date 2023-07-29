/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * Soc Project
 * 
 * v1.00 new release
 * v1.01
 *-----------------------------------------------------------------------------*/
#include "./include/system_wrapper.h"
#include <math.h>

/**-----------------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
static void system_initialize(void);


/**-----------------------------------------------------------------------------
 * Inisialize
 *-----------------------------------------------------------------------------*/
static void system_initialize(void)
{
	// GPIO
	usi_write_cmd(0x0, GPIO_REG_ALTNATE);	// Altanate mode off, CPU Side Control

	// Timer
	usi_write_cmd(0x0, 		TIMER_REG_ENABLE);	// Timer Rst
	usi_write_cmd(499999, 	TIMER_REG_DIV1);	// Timer Div1
	usi_write_cmd(49999, 	TIMER_REG_DIV2);	// Timer Div2
	usi_write_cmd(49, 		TIMER_REG_DIV3);	// Timer Div3
	usi_write_cmd(0x7, 		TIMER_REG_ENABLE);	// Timer Enable

	// SPI
	usi_write_cmd(0x8,		SPI_REG_DIV);		// 動作周波数
	usi_write_cmd(1,		SPI_REG_GPIO_ALT);	// SPI 機能有効

	// flash rom
	flash_protection_reg_write();
}


/**-----------------------------------------------------------------------------
 * main 関数
 *-----------------------------------------------------------------------------*/
void main()
{
	system_initialize();

	uint32_t adrs = 0;
	uint16_t rd;
	
	double angle = 2764.601535;
	double offset = 32768.0;
	double wave = 440.0;
	double sampling_rate = 48000.0;

	for (uint32_t i = 0; i < 65535; i++) {
		double d = (angle * (double)i) / sampling_rate;
		double sin_wave = sin(d) * offset + offset;
		cache_write((uint16_t)sin_wave, i);

		if ((i & 0xff) == 255) {
			cache_flush();
			while(!(true == cache_burst_bool()));
		}
	}
	
	while (1) {
		// led_auto_flash();
		rd = cache_read(adrs);
		bsp_uDelay(100000);
		led_user_flash(rd);
		adrs++;
		// flash_id_read();
		// flash_write();
		// flash_read();
	}
}
