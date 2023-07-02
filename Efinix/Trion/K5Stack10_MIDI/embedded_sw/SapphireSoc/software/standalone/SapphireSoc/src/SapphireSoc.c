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

/**-----------------------------------------------------------------------------
 * Block Base Adrs
 *-----------------------------------------------------------------------------*/
#define BASE_BLOCK_ADRS_GPIO	(0x00000000)


/**-----------------------------------------------------------------------------
 * USI Bus Read Sequence
 * adrs = block adrs
 *-----------------------------------------------------------------------------*/
uint32_t usi_read_cmd(uint32_t adrs)
{
	uint32_t rd;

	adrs |= USI_READ_CMD;
	write_u32(adrs, ADRS_GPIO_0_IO_CTRL_OUT);
	write_u32(adrs >> 16, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_1_IO_CTRL_EN);
	rd = (read_u32(ADRS_GPIO_1_IO_CTRL) << 16) | read_u32(ADRS_GPIO_0_IO_CTRL);
	write_u32(0, ADRS_GPIO_1_IO_CTRL_EN);
	
	return rd;
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
 * main 関数
 *-----------------------------------------------------------------------------*/
void main()
{
	uint32_t d = 255;
	// bsp_init();
	usi_write_cmd(0, BASE_BLOCK_ADRS_GPIO + 0x8);
	
	while (1)
	{
		usi_write_cmd(d, BASE_BLOCK_ADRS_GPIO);
		bsp_uDelay(1000000);
		d = usi_read_cmd(BASE_BLOCK_ADRS_GPIO);
		usi_write_cmd(0, BASE_BLOCK_ADRS_GPIO);
		bsp_uDelay(1000000);
	
	//     usi_write_cmd(0xffffffff, 0x40000000);
		bsp_printf("Teeeeeee!! \r\n");
	}
}
