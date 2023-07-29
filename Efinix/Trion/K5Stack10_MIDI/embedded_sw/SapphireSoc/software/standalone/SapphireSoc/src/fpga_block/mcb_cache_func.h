/**-----------------------------------------------------------------------------
 * Create  2023/07/23
 * Author  kouta kimura
 * -
 * グローバル関数プロトタイプ宣言
 * 
 *-----------------------------------------------------------------------------*/

#ifndef mcb_cache_func_h
#define mcb_cache_func_h

void cache_write(uint16_t wd, uint32_t ram_adrs);
void cache_flush(void);
uint16_t cache_read(uint32_t ram_adrs);

#endif