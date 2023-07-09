/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * flash rom function
 * Device : winbond W25N01GW
 *-----------------------------------------------------------------------------*/
#include "../include/system_wrapper.h"

/**-----------------------------------------------------------------------------
 * SPI Write
 * mosi = 1byte の送信データ
 *-----------------------------------------------------------------------------*/
void spi_write(uint8_t mosi)
{
	usi_write_cmd(0, 	SPI_REG_INTR);		// Intr Clear
	usi_write_cmd(mosi,	SPI_REG_MOSI);		// MOSI Send
	usi_write_cmd(1, 	SPI_REG_ENABLE);	// Spi Enable

	while (1) {
		if (1 == usi_read_cmd(SPI_REG_INTR)) {	// Intr Wait
			break;
		}
	}
}

/**-----------------------------------------------------------------------------
 * SPI Read
 * mosi = 1byte の送信データ
 *-----------------------------------------------------------------------------*/
uint8_t spi_read(uint8_t mosi)
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