/*------------------------------------------------------------------------------
 * Create 2024/07/22
 * Author Kouta Kimura
 * 
 * Pico SPI 信号を Thru で FPGA の制御を介さず Flash の制御を行う。
 * FPGA で SPI 信号を生成する場合は、Mflash 関数を使用する。
 *-----------------------------------------------------------------------------*/
#include "trypad.h"

/**-----------------------------------------------------------------------------
 * ファイル内 グローバル変数
 *-----------------------------------------------------------------------------*/


/**-----------------------------------------------------------------------------
 * ファイル内 プロトタイプ宣言
 *-----------------------------------------------------------------------------*/

/**-----------------------------------------------------------------------------
 * USER MACRO / 
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
#define FLASH_PROTECTION_WRITE_VALUE (0x83)	// 可変可能
//
#define SPI_REG_SSP_DEVICE_SEL_IDBIT (0x01)
#define SPI_REG_SSP_DEVICE_SEL_CLEAR (0x00)
#define SPI_DIRECT_IO				 (TRION_PICO_IO3)


/**-----------------------------------------------------------------------------
 * ファイル内 関数プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
static void flash_protection_reg_write(uint8_t id);
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
 * id = Sfm ID
 * page_adrs = 消去ブロック、64page単位で指定
 *-----------------------------------------------------------------------------*/
void flash_rom_init(void)
{
	flash_protection_reg_write(0);
	flash_protection_reg_write(1);
}

/**-----------------------------------------------------------------------------
 * user Flash Write
 * 
 * id = Sfm ID 
 * 	Device0 = 0
 * 	Device1 = 1
 * 	Device2 = 2
 *  ...
 * 
 * page_adrs = 消去ブロック、64page単位で指定
 *-----------------------------------------------------------------------------*/
void flash_user_block_elase(uint8_t id, uint16_t page_adrs)
{
	uint8_t bit = SPI_REG_SSP_DEVICE_SEL_IDBIT << id;

	usi_write(SPI_REG_SSP_DEVICE_SEL, bit);
	spi_direct_control(SPI_DIRECT_IO, 1);
	flash_write_enable_cmd();
	flash_block_elase(page_adrs);
	flash_busy_wait();
	spi_direct_control(SPI_DIRECT_IO, 0);
	usi_write(SPI_REG_SSP_DEVICE_SEL, SPI_REG_SSP_DEVICE_SEL_CLEAR);
}


/**-----------------------------------------------------------------------------
 * user Flash Write
 * 
 * id = Sfm ID
 * *wbuff = 書き込みバッファアドレス
 * col_adrs = col adrs
 * page_adrs = 書き込みページアドレス、64page単位で指定
 * len = バッファサイズ
 *-----------------------------------------------------------------------------*/
void flash_user_page_write(uint8_t id, uint8_t *wbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len)
{
	uint8_t bit = SPI_REG_SSP_DEVICE_SEL_IDBIT << id;

	usi_write(SPI_REG_SSP_DEVICE_SEL, bit);
	spi_direct_control(SPI_DIRECT_IO, 1);
	flash_write_enable_cmd();
	flash_program_data_load(wbuff, col_adrs, len);
	flash_program_data_execute(page_adrs);
	flash_busy_wait();
	spi_direct_control(SPI_DIRECT_IO, 0);
	usi_write(SPI_REG_SSP_DEVICE_SEL, SPI_REG_SSP_DEVICE_SEL_CLEAR);
}


/**-----------------------------------------------------------------------------
 * Flash Write
 * 
 * id = Sfm ID
 * *wbuff = 書き込みバッファアドレス
 * col_adrs = col adrs
 * page_adrs = 書き込みページアドレス、64page単位で指定
 * len = バッファサイズ
 *-----------------------------------------------------------------------------*/
void flash_write(uint8_t id, uint8_t *wbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len)
{
	uint8_t bit = SPI_REG_SSP_DEVICE_SEL_IDBIT << id;

	usi_write(SPI_REG_SSP_DEVICE_SEL, bit);
	spi_direct_control(SPI_DIRECT_IO, 1);
	flash_write_enable_cmd();
	flash_block_elase(page_adrs);
	flash_busy_wait();
	flash_write_enable_cmd();
	flash_program_data_load(wbuff, col_adrs, len);
	flash_program_data_execute(page_adrs);
	flash_busy_wait();
	spi_direct_control(SPI_DIRECT_IO, 0);
	usi_write(SPI_REG_SSP_DEVICE_SEL, SPI_REG_SSP_DEVICE_SEL_CLEAR);
}

/**-----------------------------------------------------------------------------
 * Flash Read
 * 
 * id = Sfm ID
 * *rbuff = 読み込みバッファアドレス
 * col_adrs = col adrs
 * page_adrs = 読み込みページアドレス、64page単位で指定
 * len = バッファサイズ
 *-----------------------------------------------------------------------------*/
void flash_read(uint8_t id, uint8_t *rbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len)
{
	uint8_t bit = SPI_REG_SSP_DEVICE_SEL_IDBIT << id;

	usi_write(SPI_REG_SSP_DEVICE_SEL, bit);
	spi_direct_control(SPI_DIRECT_IO, 1);
	flash_page_read(page_adrs);
	flash_busy_wait();
	flash_read_data(rbuff, col_adrs, len);
	spi_direct_control(SPI_DIRECT_IO, 0);
	usi_write(SPI_REG_SSP_DEVICE_SEL, SPI_REG_SSP_DEVICE_SEL_CLEAR);
}


/**-----------------------------------------------------------------------------
 * Flash Rom ID Read
 * 
 * mfr_id 0xef
 * device_id_msi 0xba
 * device_id_lsb 0x21
 * 
 * W25N01GV
 * 0xef, 0xaa, 0x21
 *-----------------------------------------------------------------------------*/
uint32_t flash_id_read(uint8_t id)
{
	uint8_t wbuff[5] = {
		FLASH_ID_READ_CMD,
		FLASH_DUMMY_CMD,
		FLASH_DUMMY_CMD,
		FLASH_DUMMY_CMD,
		FLASH_DUMMY_CMD
	};
	uint8_t rbuff[5];
	uint8_t bit = SPI_REG_SSP_DEVICE_SEL_IDBIT << id;

	usi_write(SPI_REG_SSP_DEVICE_SEL, bit);
	spi_direct_control(SPI_DIRECT_IO, 1);
	spi_read_direct(wbuff, rbuff, LEN(wbuff));
	spi_direct_control(SPI_DIRECT_IO, 0);
	usi_write(SPI_REG_SSP_DEVICE_SEL, SPI_REG_SSP_DEVICE_SEL_CLEAR);

	return (rbuff[2] << 16) | (rbuff[3] << 8) | rbuff[4];
}


/**-----------------------------------------------------------------------------
 * flash protction reg write
 * id = Sfm ID
 * 
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
static void flash_protection_reg_write(uint8_t id)
{
	uint8_t wbuff[3] = {FLASH_PROTECTION_REG_WRITE, FLASH_STATUS_REG1_ADRS, FLASH_PROTECTION_WRITE_VALUE};
	uint8_t bit = SPI_REG_SSP_DEVICE_SEL_IDBIT << id;

	usi_write(SPI_REG_SSP_DEVICE_SEL, bit);
	spi_direct_control(SPI_DIRECT_IO, 1);
	spi_write_direct(wbuff, LEN(wbuff));
	spi_direct_control(SPI_DIRECT_IO, 0);
	usi_write(SPI_REG_SSP_DEVICE_SEL, SPI_REG_SSP_DEVICE_SEL_CLEAR);
}


/**-----------------------------------------------------------------------------
 * Flash Write Enable Cmd
 *-----------------------------------------------------------------------------*/
static void flash_write_enable_cmd(void)
{
	uint8_t cmd = FLASH_WRITE_ENALE_CMD;

	spi_write_direct(&cmd, 1);
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
	uint8_t wbuff[4] = {FLASH_BLOCK_ELASE, FLASH_STATUS_REG3_ADRS, page_adrs >> 8, page_adrs};

	spi_write_direct(wbuff, LEN(wbuff));
}

/**-----------------------------------------------------------------------------
 * Flash Busy Wait
 *-----------------------------------------------------------------------------*/
static void flash_busy_wait(void)
{
	uint8_t wbuff[3] = {FLASH_BUSY_WAIT_CHECK, FLASH_STATUS_REG3_ADRS, FLASH_DUMMY_CMD};
	uint8_t rbuff[3];

	do {
		spi_read_direct(wbuff, rbuff, LEN(wbuff));
	} while (!((rbuff[2] & 0x01) == 0));	// bit が 0 でなければ再度 read
}

/**-----------------------------------------------------------------------------
 * Flash Program Data Load Cmd
 * 
 * 基本的には各Page の先頭から Programを行うため、col adrs は "0" を指定する。
 *-----------------------------------------------------------------------------*/
static void flash_program_data_load(uint8_t *wbuff, uint16_t col_adrs, uint16_t len)
{
	uint8_t cmd[3] = { FLASH_PROGRAM_DATA_LOAD, col_adrs >> 8, col_adrs };

	spi_cs_drive(0);
	spi_write_direct_notcs(cmd, LEN(cmd));
	spi_write_direct_notcs(wbuff, len);
	spi_cs_drive(1);
}

/**-----------------------------------------------------------------------------
 * Flash Program Data Execute
 *-----------------------------------------------------------------------------*/
static void flash_program_data_execute(uint16_t page_adrs)
{
	uint8_t wbuff[4] = {FLASH_PROGRAM_DATA_EXECUTE, FLASH_DUMMY_CMD, page_adrs >> 8, page_adrs};

	spi_write_direct(wbuff, LEN(wbuff));
}

/**-----------------------------------------------------------------------------
 * Flash Page Read
 *-----------------------------------------------------------------------------*/
static void flash_page_read(uint16_t page_adrs)
{
	uint8_t wbuff[4] = {FLASH_PROGRAM_PAGE_READ, FLASH_DUMMY_CMD, page_adrs >> 8, page_adrs};

	spi_write_direct(wbuff, LEN(wbuff));
}

/**-----------------------------------------------------------------------------
 * Flash Page Read
 * 
 * 基本的には各Page の先頭から read を行うため、col adrs は "0" を指定する。
 *-----------------------------------------------------------------------------*/
static void flash_read_data(uint8_t *rbuff, uint16_t col_adrs, uint16_t len)
{
	uint8_t cmd[4] = {
		FLASH_READ_DATA_CMD,
		col_adrs >> 8,
		col_adrs,
		FLASH_DUMMY_CMD
	};

	spi_cs_drive(0);
	spi_write_direct_notcs(cmd, LEN(cmd));
	spi_read_direct_notcs(rbuff, rbuff, len);
	spi_cs_drive(1);
}