/**-----------------------------------------------------------------------------
 * Create  2023/07/15
 * Author  kouta kimura
 * -
 * グローバル関数プロトタイプ宣言
 * 
 *-----------------------------------------------------------------------------*/

#ifndef ram_func_h
#define ram_func_h

void spi_write(uint8_t mosi);
uint8_t spi_read(uint8_t mosi);

#endif