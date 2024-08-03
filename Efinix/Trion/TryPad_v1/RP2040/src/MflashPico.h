/*------------------------------------------------------------------------------
 * Create  2024/07/14
 * Author  Kouta Kimura
 * 
 *-----------------------------------------------------------------------------*/
#ifndef MflashPico_h
#define MflashPico_h

/**-----------------------------------------------------------------------------
 * USER MACRO
 *-----------------------------------------------------------------------------*/

/**-----------------------------------------------------------------------------
 * typedef struct
 *-----------------------------------------------------------------------------*/


/**-----------------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
void flash_rom_init(void);
void flash_user_block_elase(uint8_t id, uint16_t page_adrs);
void flash_user_page_write(uint8_t id, uint8_t *wbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len);
void flash_write(uint8_t id, uint8_t *wbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len);
void flash_read(uint8_t id, uint8_t *rbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len);
uint32_t flash_id_read(uint8_t id);

#endif