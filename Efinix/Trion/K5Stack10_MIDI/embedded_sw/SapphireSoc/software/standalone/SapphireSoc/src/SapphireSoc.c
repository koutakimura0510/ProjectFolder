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
void led_flash(void);


/**-----------------------------------------------------------------------------
 * LED FLASH
 *-----------------------------------------------------------------------------*/
void led_flash(void)
{
	static uint32_t t = 0;
	static uint8_t flash = 0x01;
	uint32_t now_t = usi_read_cmd(TIMER_REG_COUNT1);

	if (t + 99 < now_t) {
		t = now_t;
		flash++;
		flash &= 0x07;
		usi_write_cmd(flash, BASE_BLOCK_ADRS_GPIO);
	}
}

/**-----------------------------------------------------------------------------
 * main 関数
 *-----------------------------------------------------------------------------*/
void main()
{
	// GPIO
	usi_write_cmd(0x0, GPIO_REG_ALTNATE);	// Altanate mode

	// Timer
	usi_write_cmd(0x0, 		TIMER_REG_ENABLE);	// Timer Rst
	usi_write_cmd(499999, 	TIMER_REG_DIV1);	// Timer Div1
	usi_write_cmd(49999, 	TIMER_REG_DIV2);	// Timer Div2
	usi_write_cmd(49, 		TIMER_REG_DIV3);	// Timer Div3
	usi_write_cmd(0x7, 		TIMER_REG_ENABLE);	// Timer En

	// SPI
	usi_write_cmd(0x8,		SPI_REG_DIV);	// 動作周波数
	flash_protection_reg_write();
	
	while (1)
	{
		led_flash();
		flash_id_read();
		// flash_write();
		// flash_read();
	}
}
