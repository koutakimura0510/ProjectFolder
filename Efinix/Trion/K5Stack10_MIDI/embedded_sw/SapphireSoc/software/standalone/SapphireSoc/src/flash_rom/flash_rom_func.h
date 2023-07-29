/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * Flash Rom グローバル関数プロトタイプ宣言
 * 
 *-----------------------------------------------------------------------------*/

#ifndef flash_rom_func_h
#define flash_rom_func_h

void flash_user_block_elase(uint16_t page_adrs);
void flash_user_page_write(uint8_t *wbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len);
void flash_write(uint8_t *wbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len);
void flash_read(uint8_t *rbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len);
void flash_id_read(void);
void flash_protection_reg_write(void);

#endif