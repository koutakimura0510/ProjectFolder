/**-----------------------------------------------------------------------------
 * Create  2023/07/29
 * Author  kouta kimura
 * -
 * GPIO Block function
 *-----------------------------------------------------------------------------*/
#include "../include/system_wrapper.h"

/**-----------------------------------------------------------------------------
 * LED Auto FLASH
 *-----------------------------------------------------------------------------*/
void led_auto_flash(uint32_t time, uint32_t timer_csr_adrs)
{
	static uint32_t t = 0;
	static uint8_t flash = 0x01;
	uint32_t now_t = usi_read_cmd(timer_csr_adrs);

	if (t + time < now_t) {
		t = now_t;
		flash++;
		flash &= 0x07;
		usi_write_cmd(flash, GPIO_REG_OUT_CTRL);
	}
}

/**-----------------------------------------------------------------------------
 * LED USER FLASH
 *-----------------------------------------------------------------------------*/
void led_user_flash(uint8_t flash)
{
	usi_write_cmd(flash, GPIO_REG_OUT_CTRL);
}
