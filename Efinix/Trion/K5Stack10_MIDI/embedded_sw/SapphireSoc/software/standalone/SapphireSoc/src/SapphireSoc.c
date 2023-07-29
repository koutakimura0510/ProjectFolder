/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * Soc Project
 * 
 *-----------------------------------------------------------------------------*/
#include "./include/system_wrapper.h"


/**-----------------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
static void led_auto_flash(uint32_t time);
static void led_flash(uint8_t flash);
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
 * LED Auto FLASH
 *-----------------------------------------------------------------------------*/
static void led_auto_flash(uint32_t time)
{
	static uint32_t t = 0;
	static uint8_t flash = 0x01;
	uint32_t now_t = usi_read_cmd(TIMER_REG_COUNT1);

	if (t + time < now_t) {
		t = now_t;
		flash++;
		flash &= 0x07;
		usi_write_cmd(flash, GPIO_REG_OUT_CTRL);
	}
}

/**-----------------------------------------------------------------------------
 * LED FLASH
 *-----------------------------------------------------------------------------*/
static void led_flash(uint8_t flash)
{
	usi_write_cmd(flash, GPIO_REG_OUT_CTRL);
}

/**-----------------------------------------------------------------------------
 * main 関数
 *-----------------------------------------------------------------------------*/
void main()
{
	system_initialize();

	uint16_t wd = 0;
	uint32_t adrs = 0;
	uint16_t rd;
	
	while (1) {
		// led_auto_flash();
		cache_write(wd, adrs);
		cache_flush();
		rd = cache_read(adrs);
		bsp_uDelay(500000);
		led_flash(rd);
		wd++;
		adrs++;
		// flash_id_read();
		// flash_write();
		// flash_read();
	}
}
