/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * グローバル関数プロトタイプ宣言
 * 
 *-----------------------------------------------------------------------------*/

#ifndef spi_func_h
#define spi_func_h

void spi_write(uint8_t mosi, uint32_t done_adrs, uint32_t mosi_adrs, uint32_t enable_adrs, uint8_t bit);
uint8_t spi_read(uint8_t mosi, uint32_t done_adrs, uint32_t mosi_adrs, uint32_t enable_adrs, uint32_t miso_adrs, uint8_t bit);

#endif