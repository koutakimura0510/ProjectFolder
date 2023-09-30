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
void spi_write(uint8_t mosi, uint32_t done_adrs, uint32_t mosi_adrs, uint32_t enable_adrs, uint8_t bit)
{
	usi_write_cmd(0, 	done_adrs);		// Done(Intr) Clear
	usi_write_cmd(mosi,	mosi_adrs);		// MOSI Send
	usi_write_cmd(bit, 	enable_adrs);	// Spi Enable

	while (1) {
		if (bit == usi_read_cmd(done_adrs)) {	// Intr Wait
			break;
		}
	}
}

/**-----------------------------------------------------------------------------
 * SPI Read
 * mosi = 1byte の送信データ
 *-----------------------------------------------------------------------------*/
uint8_t spi_read(uint8_t mosi, uint32_t done_adrs, uint32_t mosi_adrs, uint32_t enable_adrs, uint32_t miso_adrs, uint8_t bit)
{
	usi_write_cmd(0, 	done_adrs);		// Done(Intr) Clear
	usi_write_cmd(mosi,	mosi_adrs);		// MOSI Send
	usi_write_cmd(bit, 	enable_adrs);	// Spi Enable

	while (1) {
		if (1 == usi_read_cmd(done_adrs)) {	// Intr Wait
			break;
		}
	}
	return usi_read_cmd(miso_adrs);
}