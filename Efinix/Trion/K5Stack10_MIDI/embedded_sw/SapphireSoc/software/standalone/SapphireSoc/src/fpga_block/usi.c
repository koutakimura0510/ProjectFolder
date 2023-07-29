/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * flash rom function
 * Device : winbond W25N01GW
 *-----------------------------------------------------------------------------*/
#include "../include/system_wrapper.h"

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
	write_u32(BASE_BLOCK_USI_ADRS_NULL,0);		// Port に Read値が入力されるまで数クロックサイクル必要なため
	write_u32(BASE_BLOCK_USI_ADRS_NULL,0);		// 空の write 動作を行い数クロック待つ
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
 * USI Bus Enable
 * 
 * bus_sel
 * 0x10:Bus Rst
 * 0x20:USI Enable
 * 0x30:UFI Enable
 *-----------------------------------------------------------------------------*/
void bus_enable_select(uint8_t bus_sel)
{
	write_u32(0x10, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_0_IO_CTRL_EN);
	write_u32(1, ADRS_GPIO_1_IO_CTRL_EN);
	write_u32(bus_sel, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(BASE_BLOCK_USI_ADRS_NULL,0);
	write_u32(0, ADRS_GPIO_0_IO_CTRL_EN);
	write_u32(0, ADRS_GPIO_1_IO_CTRL_EN);
}