/**-----------------------------------------------------------------------------
 * Create  2024/02/29
 * Author  kouta kimura
 * -
 * Ram Block function
 *-----------------------------------------------------------------------------*/
#include "../include/system_wrapper.h"


/**-----------------------------------------------------------------------------
 * memory test data set
 * 
 * BRAM へのデータ書き込み順番は下記の通り
 * 0:cmd
 * 1:cmd
 * 2:adrs
 * 3:adrs
 * 4:adrs
 * 5:adrs
 * 6:adrs
 * 7:adrs
 *-----------------------------------------------------------------------------*/
void ram_mcu_matset(uint32_t wd, uint32_t wadrs)
{
	usi_write_cmd(wadrs, RAM_REG_RAM_MAT_MEM_WA);
	usi_write_cmd(wd, RAM_REG_RAM_MAT_MEM_WD);
	usi_write_cmd(1, RAM_REG_RAM_MAT_MEM_WE);
	usi_write_cmd(0, RAM_REG_RAM_MAT_MEM_WE);
}