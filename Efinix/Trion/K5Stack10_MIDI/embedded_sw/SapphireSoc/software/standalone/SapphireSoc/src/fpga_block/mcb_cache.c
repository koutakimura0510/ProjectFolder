/**-----------------------------------------------------------------------------
 * Create  2023/07/23
 * Author  kouta kimura
 * -
 * MCB Cache Controller
 * Cache にデータを書き込むことで RAM Block へデータが転送される
 *-----------------------------------------------------------------------------*/
#include "../include/system_wrapper.h"


/**-----------------------------------------------------------------------------
 * Cache Write, Cache Size Max 256
 * 
 * wd 書き込みデータ
 * ram_adrs 書き込みアドレス
 *-----------------------------------------------------------------------------*/
void cache_write(uint16_t wd, uint32_t ram_adrs)
{
	usi_write_cmd(wd, MCB_REG_RAM_WD);
	usi_write_cmd(ram_adrs, MCB_REG_RAM_ADRS);
	usi_write_cmd(1, MCB_REG_RAM_ENABLE);
	usi_write_cmd(0, MCB_REG_RAM_ENABLE);
}


/**-----------------------------------------------------------------------------
 * Cache Flash
 * Run は自動クリアされる
 *-----------------------------------------------------------------------------*/
void cache_flush(void)
{
	usi_write_cmd(1, MCB_REG_RAM_BURST_RUN);
}

/**-----------------------------------------------------------------------------
 * return
 * true : burst transfer、転送は行われている
 * false: burst transfer、転送は行われていない
 *-----------------------------------------------------------------------------*/
bool cache_burst_bool(void)
{
	return usi_read_cmd(MCB_REG_RAM_BURST_RUN) ? false : true;
}

/**-----------------------------------------------------------------------------
 * Cache Read
 *-----------------------------------------------------------------------------*/
uint16_t cache_read(uint32_t ram_adrs)
{
	while(usi_read_cmd(MCB_REG_RAM_BURST_RUN));
	usi_write_cmd(ram_adrs | MCB_CACHE_READ, MCB_REG_RAM_ADRS);
	usi_write_cmd(1, MCB_REG_RAM_ENABLE);
	usi_write_cmd(0, MCB_REG_RAM_ENABLE);
	cache_flush();
	while(!usi_read_cmd(MCB_REG_RAM_RD_VD));

	return usi_read_cmd(MCB_REG_RAM_RD);
}