/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * グローバル関数プロトタイプ宣言
 * 
 *-----------------------------------------------------------------------------*/

#ifndef usi_func_h
#define usi_func_h

void usi_write_cmd(uint32_t wd, uint32_t adrs);
uint32_t usi_read_cmd(uint32_t adrs);
void usi_read_wait(uint32_t adrs, uint32_t flag);
void usi_read_printf(uint32_t adrs);
void bus_enable_select(uint8_t bus_sel);

#endif