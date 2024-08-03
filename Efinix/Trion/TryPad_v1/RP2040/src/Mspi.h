/*------------------------------------------------------------------------------
 * Create  2024/06/16
 * Author  Kouta Kimura
 * 
 *-----------------------------------------------------------------------------*/
#ifndef Mspi_h
#define Mspi_h

/**-----------------------------------------------------------------------------
 * USER DEBUG MACRO
 *-----------------------------------------------------------------------------*/
// #define DEBUG_MODE

/**-----------------------------------------------------------------------------
 * USER MACRO
 *-----------------------------------------------------------------------------*/
#define SPI_BAUDRATE	(10000 * 1000) // MAX 10[MHz]

/**-----------------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
void pico_spi_init(uint8_t set_sel, uint32_t baudrate);
void usi_write(uint32_t adrs, uint32_t wd);
uint32_t usi_read(uint32_t adrs);
void usi_read_wait(uint32_t adrs, uint32_t bit_mask);
void spi_direct_control(uint8_t gpio, uint8_t value);
void spi_write_direct(uint8_t *pwbuff, uint16_t len);
void spi_read_direct(uint8_t *pwbuff, uint8_t *prbuff, uint16_t len);
void spi_write_direct_notcs(uint8_t *pwbuff, uint16_t len);
void spi_read_direct_notcs(uint8_t *pwbuff, uint8_t *prbuff, uint16_t len);
void spi_cs_drive(uint8_t cs_drive);

#endif