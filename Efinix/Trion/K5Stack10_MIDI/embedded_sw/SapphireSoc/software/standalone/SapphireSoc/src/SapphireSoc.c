#include <stdint.h>
#include "bsp.h"
// #include "soc.h"


/**-----------------------------------------------------------------------------
 * Soc Periheral Adrs
 *-----------------------------------------------------------------------------*/
#define ADRS_GPIO_0_IO_CTRL		(0xf8015000)
#define ADRS_GPIO_0_IO_CTRL_OUT (ADRS_GPIO_0_IO_CTRL + 4)
#define ADRS_GPIO_0_IO_CTRL_EN 	(ADRS_GPIO_0_IO_CTRL + 8)
#define ADRS_GPIO_1_IO_CTRL 	(0xf8018000)
#define ADRS_GPIO_1_IO_CTRL_OUT (ADRS_GPIO_1_IO_CTRL + 4)
#define ADRS_GPIO_1_IO_CTRL_EN 	(ADRS_GPIO_1_IO_CTRL + 8)

/**-----------------------------------------------------------------------------
 * USI コマンド
 *-----------------------------------------------------------------------------*/
#define USI_READ_CMD		(0x80000000)
#define USI_WRITE_CMD		(0x40000000)

/**------------------------------------------------usi_write_cmd(0x7, BASE_BLOCK_ADRS_TIMER + 0xC);-----------------------------
 * Block Base Adrs
 *-----------------------------------------------------------------------------*/
#define BASE_BLOCK_ADRS_GPIO	(0x00000000)
#define BASE_BLOCK_ADRS_TIMER	(0x00040000)
#define BASE_BLOCK_ADRS_NULL	(0x0fffffff)


/**-----------------------------------------------------------------------------
 * USI Bus Read Sequence
 * adrs = block adrs
 *-----------------------------------------------------------------------------*/
uint32_t usi_read_cmd(uint32_t adrs)
{
	uint32_t lsbrd, msbrd;

	// adrs |= USI_READ_CMD;
	write_u32(adrs, ADRS_GPIO_0_IO_CTRL_OUT);
	write_u32(adrs >> 16, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_1_IO_CTRL_EN);
	write_u32(BASE_BLOCK_ADRS_NULL,0);		// Port に Read値が入力されるまで数クロックサイクル必要なため
	write_u32(BASE_BLOCK_ADRS_NULL,0);		// 空の write 動作を行い数クロック待つ
	lsbrd = read_u32(ADRS_GPIO_0_IO_CTRL);
	msbrd = read_u32(ADRS_GPIO_1_IO_CTRL) << 16;
	write_u32(0, ADRS_GPIO_1_IO_CTRL_EN);
	
	return msbrd | lsbrd;
}

/**-----------------------------------------------------------------------------
 * USI Bus Write Sequence
 * wd   = write data
 * adrs = block adrs
 *-----------------------------------------------------------------------------*/
void usi_write_cmd(uint32_t wd, uint32_t adrs)
{
	write_u32(wd, ADRS_GPIO_0_IO_CTRL_OUT);
	write_u32(wd>>16, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_0_IO_CTRL_EN);
	write_u32(0, ADRS_GPIO_0_IO_CTRL_EN);
	
	adrs |= USI_WRITE_CMD;
	write_u32(adrs, ADRS_GPIO_0_IO_CTRL_OUT);
	write_u32(adrs >> 16, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_1_IO_CTRL_EN);
	write_u32(0, ADRS_GPIO_1_IO_CTRL_EN);
}


/**-----------------------------------------------------------------------------
 * USI Bus Adrs printf
 * adrs = block adrs
 *-----------------------------------------------------------------------------*/
void usi_read_printf(uint32_t adrs)
{
	uint32_t rd = usi_read_cmd(adrs);
	bsp_printf("%x \r\n", rd);
}

/**-----------------------------------------------------------------------------
 * SPI Read
 *-----------------------------------------------------------------------------*/


/**-----------------------------------------------------------------------------
 * LED FLASH
 *-----------------------------------------------------------------------------*/
void led_flash(void)
{
	static uint32_t t = 0;
	static uint8_t flash = 0x01;
	uint32_t now_t = usi_read_cmd(BASE_BLOCK_ADRS_TIMER+0x40);

	if (t +99 < now_t) {
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
	bsp_init();
	usi_write_cmd(0x0, BASE_BLOCK_ADRS_GPIO  + 0x8);
	usi_write_cmd(0x0, BASE_BLOCK_ADRS_TIMER + 0xC);
	usi_write_cmd(499999, BASE_BLOCK_ADRS_TIMER + 0x0);
	usi_write_cmd(49999, BASE_BLOCK_ADRS_TIMER + 0x4);
	usi_write_cmd(49, BASE_BLOCK_ADRS_TIMER + 0x8);
	usi_write_cmd(0x7, BASE_BLOCK_ADRS_TIMER + 0xC);

	usi_read_printf(BASE_BLOCK_ADRS_TIMER+0x0);
	usi_read_printf(BASE_BLOCK_ADRS_TIMER+0x4);
	usi_read_printf(BASE_BLOCK_ADRS_TIMER+0x8);
	usi_read_printf(BASE_BLOCK_ADRS_TIMER+0xC);
	usi_read_printf(BASE_BLOCK_ADRS_GPIO  + 0x8);
	
	while (1)
	{
		led_flash();
		// d = usi_read_cmd(BASE_BLOCK_ADRS_GPIO);
		// bsp_printf("Teeeeeee!! \r\n");
	}
}
