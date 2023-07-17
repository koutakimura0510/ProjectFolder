/**-----------------------------------------------------------------------------
 * Create  2023/07/15
 * Author  kouta kimura
 * -
 * Ex ram function
 * Device : ISSI
 *-----------------------------------------------------------------------------*/
#include "../include/system_wrapper.h"

/**-----------------------------------------------------------------------------
 * RAM Write
 *-----------------------------------------------------------------------------*/
void ram_write(uint16_t wd, uint32_t adrs)
{

	// data
	write_u32(wd, ADRS_GPIO_0_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_0_IO_CTRL_EN);
	write_u32(0, ADRS_GPIO_0_IO_CTRL_EN);

	// adrs
	write_u32(UFI_WRITE_CMD + adrs, 	   ADRS_GPIO_0_IO_CTRL_OUT);
	write_u32((UFI_WRITE_CMD + adrs) >>16, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_1_IO_CTRL_EN);

	// 
	write_u32(BASE_BLOCK_ADRS_NULL,0);
	write_u32(BASE_BLOCK_ADRS_NULL,0);
	write_u32(BASE_BLOCK_ADRS_NULL,0);
	write_u32(BASE_BLOCK_ADRS_NULL,0);
	write_u32(0, ADRS_GPIO_1_IO_CTRL_EN);
}

/**-----------------------------------------------------------------------------
 * SPI Read
 * mosi = 1byte の送信データ
 *-----------------------------------------------------------------------------*/
uint8_t ram_read(uint8_t mosi)
{
	usi_write_cmd(0, 	SPI_REG_INTR);		// Intr Clear
	usi_write_cmd(mosi,	SPI_REG_MOSI);		// MOSI Send
	usi_write_cmd(1, 	SPI_REG_ENABLE);	// Spi Enable

	while (1) {
		if (1 == usi_read_cmd(SPI_REG_INTR)) {	// Intr Wait
			break;
		}
	}
	return usi_read_cmd(SPI_REG_MISO);
}