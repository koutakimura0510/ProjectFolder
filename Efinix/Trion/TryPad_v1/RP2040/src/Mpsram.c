/*------------------------------------------------------------------------------
 * Create 2024/07/09
 * Author Kouta Kimura
 * 
 *-----------------------------------------------------------------------------*/
#include "trypad.h"

/**-----------------------------------------------------------------------------
 * ファイル内 グローバル変数
 *-----------------------------------------------------------------------------*/


/**-----------------------------------------------------------------------------
 * ファイル内 プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
static void psram_data_set(uint32_t adrs, uint32_t wd);

/**-----------------------------------------------------------------------------
 * USER MACRO / 
 *-----------------------------------------------------------------------------*/


/**-----------------------------------------------------------------------------
 * PSRAM Initialize
 *-----------------------------------------------------------------------------*/
void psram_init(void)
{
	usi_write(RAM_REG_RAM_MEM_CLK_DIV, 2);
	usi_write(RAM_REG_RAM_CFG_RST, 1);
	usi_write(RAM_REG_RAM_CFG_CMD, 0x35);
	usi_write(RAM_REG_RAM_CFG_ENABLE, 1);
	usi_write(RAM_REG_RAM_CFG_RST, 0);
	usi_read_wait(RAM_REG_RAM_CFG_DONE, 0x01);
	usi_write(RAM_REG_RAM_CFG_RST, 1);
}

/**-----------------------------------------------------------------------------
 * PSRAM Device Test
 * R/W が正常に行えるかテスト
 *-----------------------------------------------------------------------------*/
bool psram_device_test(void)
{
	// test wdata set
	usi_write(RAM_REG_RAM_MAT_RST, 1);
	usi_write(RAM_REG_RAM_MAT_MEM_WD_OE, 1);	// "1" set read
	psram_data_set(0, 0x00003333);	// cmd1
	psram_data_set(1, 0x00008888);	// cmd2
	psram_data_set(2, 0x00000000);	// adrs0
	psram_data_set(3, 0x00000000);	// adrs1
	psram_data_set(4, 0x00000000);	// adrs2
	psram_data_set(5, 0x00000000);	// adrs3
	psram_data_set(6, 0x00000000);	// adrs4
	psram_data_set(7, 0x00000000);	// adrs5

	for (uint16_t i = 0; i < 247; i++) {
		psram_data_set(i+8, 0x0000aaaa+i);
	}

	usi_write(RAM_REG_RAM_MAT_ENABLE, 1);
	usi_write(RAM_REG_RAM_MAT_RST, 0);
	usi_read_wait(RAM_REG_RAM_MAT_DONE, 0x01);


	// test read data
	usi_write(RAM_REG_RAM_MAT_RST, 1);
	usi_write(RAM_REG_RAM_MAT_MEM_WD_OE, 0);	// "0" set read
	psram_data_set(0, 0x0000EEEE);	// cmd1
	psram_data_set(1, 0x0000BBBB);	// cmd2
	psram_data_set(2, 0x00000000);	// adrs0
	psram_data_set(3, 0x00000000);	// adrs1
	psram_data_set(4, 0x00000000);	// adrs2
	psram_data_set(5, 0x00000000);	// adrs3
	psram_data_set(6, 0x00000000);	// adrs4
	psram_data_set(7, 0x00000000);	// adrs5
	usi_write(RAM_REG_RAM_MAT_ENABLE, 1);
	usi_write(RAM_REG_RAM_MAT_RST, 0);
	usi_read_wait(RAM_REG_RAM_MAT_DONE, 0x01);
	usi_write(RAM_REG_RAM_MAT_RST, 1);

	uint32_t rbuff[256];

	for (uint8_t i = 0; i < 255; i++) {
		usi_write(RAM_REG_RAM_MAT_MEM_RA, i);
		rbuff[i] = usi_read(RAM_REG_RAM_MAT_MEM_RD);
		psram_data_set(i, rbuff[i]);	// コンパイル通すために記載
	}

	return true;
}

/**-----------------------------------------------------------------------------
 * PSRAM Soft Write
 *-----------------------------------------------------------------------------*/
void psram_soft_write(void)
{

}

/**-----------------------------------------------------------------------------
 * PSRAM Soft Read
 *-----------------------------------------------------------------------------*/


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
static void psram_data_set(uint32_t adrs, uint32_t wd)
{
	usi_write(RAM_REG_RAM_MAT_MEM_WA, adrs);
	usi_write(RAM_REG_RAM_MAT_MEM_WD, wd);
	usi_write(RAM_REG_RAM_MAT_MEM_WE, 1);
	usi_write(RAM_REG_RAM_MAT_MEM_WE, 0);
}