/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * グローバル関数プロトタイプ宣言
 * 
 *-----------------------------------------------------------------------------*/

#ifndef usi_func_h
#define usi_func_h

uint32_t usi_read_cmd(uint32_t adrs);
void usi_write_cmd(uint32_t wd, uint32_t adrs);
void usi_read_printf(uint32_t adrs);

#endif