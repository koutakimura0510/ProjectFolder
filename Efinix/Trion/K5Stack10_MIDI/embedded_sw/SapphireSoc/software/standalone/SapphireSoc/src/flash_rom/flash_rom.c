/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * flash rom function
 * Device : winbond W25N01GW
 *-----------------------------------------------------------------------------*/
#include "../include/system_wrapper.h"


/**-----------------------------------------------------------------------------
 * ファイル内 定数
 *-----------------------------------------------------------------------------*/
#define FLASH_DUMMY_CMD				(0x00)
#define FLASH_ID_READ_CMD			(0x9f)
#define FLASH_PROTECTION_REG_WRITE	(0x1f)
#define FLASH_STATUS_REG1_ADRS		(0xA0)
#define FLASH_STATUS_REG3_ADRS		(0xC3)
#define FLASH_WRITE_ENALE_CMD 		(0x06)
#define FLASH_BLOCK_ELASE			(0xd8)
#define FLASH_BUSY_WAIT_CHECK		(0x0f)
#define FLASH_PROGRAM_DATA_LOAD		(0x02)
#define FLASH_PROGRAM_DATA_EXECUTE	(0x10)
#define FLASH_PROGRAM_PAGE_READ		(0x13)
#define FLASH_READ_DATA_CMD			(0x03)
#define FLASH_STATUS_REG1			(0x03)
#define FLASH_READ_DATA_CMD			(0x03)
//
#define FLASH_PROTECTION_WRITE_VALUE (0x83)	//可変可能

/**-----------------------------------------------------------------------------
 * ファイル内 関数プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
static void flash_write_enable_cmd(void);
static void flash_block_elase(uint16_t page_adrs);
static void flash_busy_wait(void);
static void flash_program_data_load(uint8_t *wbuff, uint16_t col_adrs, uint16_t len);
static void flash_program_data_execute(uint16_t page_adrs);
static void flash_page_read(uint16_t page_adrs);
static void flash_read_data(uint8_t *rbuff, uint16_t col_adrs, uint16_t len);




/**-----------------------------------------------------------------------------
 * user Flash Write
 * 
 * page_adrs = 消去ブロック、64page単位で指定
 *-----------------------------------------------------------------------------*/
void flash_user_block_elase(uint16_t page_adrs)
{
	flash_write_enable_cmd();
	flash_block_elase(page_adrs);
	flash_busy_wait();
}


/**-----------------------------------------------------------------------------
 * user Flash Write
 * 
 * *wbuff = 書き込みバッファアドレス
 * col_adrs = col adrs
 * page_adrs = 書き込みページアドレス、64page単位で指定
 * len = バッファサイズ
 *-----------------------------------------------------------------------------*/
void flash_user_page_write(uint8_t *wbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len)
{
	flash_write_enable_cmd();
	flash_program_data_load(wbuff, col_adrs, len);
	flash_program_data_execute(page_adrs);
	flash_busy_wait();
}


/**-----------------------------------------------------------------------------
 * Flash Write
 * 
 * *wbuff = 書き込みバッファアドレス
 * col_adrs = col adrs
 * page_adrs = 書き込みページアドレス、64page単位で指定
 * len = バッファサイズ
 *-----------------------------------------------------------------------------*/
void flash_write(uint8_t *wbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len)
{
	flash_write_enable_cmd();
	flash_block_elase(page_adrs);
	flash_busy_wait();
	flash_write_enable_cmd();
	flash_program_data_load(wbuff, col_adrs, len);
	flash_program_data_execute(page_adrs);
	flash_busy_wait();
}

/**-----------------------------------------------------------------------------
 * Flash Read
 * 
 * *rbuff = 読み込みバッファアドレス
 * col_adrs = col adrs
 * page_adrs = 読み込みページアドレス、64page単位で指定
 * len = バッファサイズ
 *-----------------------------------------------------------------------------*/
void flash_read(uint8_t *rbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len)
{
	flash_page_read(page_adrs);
	flash_busy_wait();
	flash_read_data(rbuff, col_adrs, len);
}


/**-----------------------------------------------------------------------------
 * Flash Rom ID Read
 * 
 * mfr_id 0xef
 * device_id_msi 0xba
 * device_id_lsb 0x21
 *-----------------------------------------------------------------------------*/
void flash_id_read(void)
{
	uint8_t mfr_id, device_id_msb, device_id_lsb;

	usi_write_cmd(0, SPI_REG_CS);
	spi_read(FLASH_ID_READ_CMD);
	spi_read(FLASH_DUMMY_CMD);
	mfr_id = spi_read(FLASH_DUMMY_CMD);
	device_id_msb = spi_read(FLASH_DUMMY_CMD);
	device_id_lsb = spi_read(FLASH_DUMMY_CMD);
	usi_write_cmd(1, SPI_REG_CS);

	bsp_printf("%x,%x,%x \r\n", mfr_id, device_id_msb, device_id_lsb);
}


/**-----------------------------------------------------------------------------
 * flash protction reg write
 * 起動時は Program Reg にプロテクトがかかっており、データのRW	には解除が必要
 * S7 SRP0
 * S6 BP3
 * S5 BP2
 * S4 BP1
 * S3 BP0
 * S2 TB
 * WP-E S1
 * S0 SRP1
 *-----------------------------------------------------------------------------*/
void flash_protection_reg_write(void)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(FLASH_PROTECTION_REG_WRITE);
	spi_write(FLASH_STATUS_REG1_ADRS);
	spi_write(FLASH_PROTECTION_WRITE_VALUE);
	usi_write_cmd(1, SPI_REG_CS);
}


/**-----------------------------------------------------------------------------
 * Flash Write Enable Cmd
 *-----------------------------------------------------------------------------*/
static void flash_write_enable_cmd(void)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(FLASH_WRITE_ENALE_CMD);
	usi_write_cmd(1, SPI_REG_CS);
}

/**-----------------------------------------------------------------------------
 * Flash 128KB Block Elase
 * 1Block = 64Page x 2048 col
 * MAX = 1024 Block, 65536 Page
 * 
 * Block elase を実行する場合は、64Page ごとに行う。
 * Program する page は必ず Block elase しなければならない。
 *-----------------------------------------------------------------------------*/
static void flash_block_elase(uint16_t page_adrs)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(FLASH_BLOCK_ELASE);
	spi_write(FLASH_DUMMY_CMD);
	spi_write(page_adrs >> 8);	// Page adrs "H"
	spi_write(page_adrs);		// Page adrs "L"
	usi_write_cmd(1, SPI_REG_CS);
}

/**-----------------------------------------------------------------------------
 * Flash Busy Wait
 *-----------------------------------------------------------------------------*/
static void flash_busy_wait(void)
{
	while (1) {
		usi_write_cmd(0, SPI_REG_CS);
		spi_write(FLASH_BUSY_WAIT_CHECK);
		spi_write(FLASH_STATUS_REG3_ADRS);

		uint8_t id = spi_read(FLASH_DUMMY_CMD);
		usi_write_cmd(1, SPI_REG_CS);

		if ((id & 0x01) == 0) {
			break;
		}
	}
}

/**-----------------------------------------------------------------------------
 * Flash Program Data Load Cmd
 * 
 * 基本的には各Page の先頭から Programを行うため、col adrs は "0" を指定する。
 *-----------------------------------------------------------------------------*/
static void flash_program_data_load(uint8_t *wbuff, uint16_t col_adrs, uint16_t len)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(FLASH_PROGRAM_DATA_LOAD);	// Program Data Load Cmd
	spi_write(col_adrs >> 8);	// col adrs "H"
	spi_write(col_adrs);		// col adrs "L"

	for (uint16_t i = 0; i < len; i++) {
		spi_write(wbuff[i]);
	}

	usi_write_cmd(1, SPI_REG_CS);
}

/**-----------------------------------------------------------------------------
 * Flash Program Data Execute
 *-----------------------------------------------------------------------------*/
static void flash_program_data_execute(uint16_t page_adrs)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(FLASH_PROGRAM_DATA_EXECUTE);
	spi_write(FLASH_DUMMY_CMD);
	spi_write(page_adrs >> 8);	// Page adrs "H"
	spi_write(page_adrs);		// Page adrs "L"
	usi_write_cmd(1, SPI_REG_CS);
}

/**-----------------------------------------------------------------------------
 * Flash Page Read
 *-----------------------------------------------------------------------------*/
static void flash_page_read(uint16_t page_adrs)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(FLASH_PROGRAM_PAGE_READ);
	spi_write(FLASH_DUMMY_CMD);
	spi_write(page_adrs >> 8);	// Page adrs "H"
	spi_write(page_adrs);		// Page adrs "L"
	usi_write_cmd(1, SPI_REG_CS);
}

/**-----------------------------------------------------------------------------
 * Flash Page Read
 * 
 * 基本的には各Page の先頭から read を行うため、col adrs は "0" を指定する。
 *-----------------------------------------------------------------------------*/
static void flash_read_data(uint8_t *rbuff, uint16_t col_adrs, uint16_t len)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(FLASH_READ_DATA_CMD);
	spi_write(col_adrs >> 8);	// col adrs "H"
	spi_write(col_adrs);		// col adrs "L"
	spi_write(FLASH_DUMMY_CMD);

	for (uint16_t i = 0; i < len; i++) {
		rbuff[i] = spi_read(FLASH_DUMMY_CMD);
	}

	usi_write_cmd(1, SPI_REG_CS);
}