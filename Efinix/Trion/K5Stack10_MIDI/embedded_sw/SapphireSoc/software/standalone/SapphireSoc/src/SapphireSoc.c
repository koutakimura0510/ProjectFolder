#include <stdint.h>
#include "bsp.h"
// #include "soc.h"


/**-----------------------------------------------------------------------------
 * Soc Periheral Adrs
 *-----------------------------------------------------------------------------*/
#define ADRS_GPIO_0_IO_CTRL		(0xf8015000)
#define ADRS_GPIO_0_IO_CTRL_OUT (ADRS_GPIO_0_IO_CTRL + 4)
#define ADRS_GPIO_0_IO_CTRL_EN 	(ADRS_GPIO_0_IO_CTRL + 8)
#define ADRS_GPIO_1_IO_CTRL 	(0xf8018000)
#define ADRS_GPIO_1_IO_CTRL_OUT (ADRS_GPIO_1_IO_CTRL + 4)
#define ADRS_GPIO_1_IO_CTRL_EN 	(ADRS_GPIO_1_IO_CTRL + 8)

/**-----------------------------------------------------------------------------
 * Block Base Adrs
 *-----------------------------------------------------------------------------*/
#define BASE_BLOCK_ADRS_GPIO	(0x00000000)
#define BASE_BLOCK_ADRS_SPI		(0x00010000)
#define BASE_BLOCK_ADRS_SYNTH	(0x00020000)
#define BASE_BLOCK_ADRS_RAM		(0x00030000)
#define BASE_BLOCK_ADRS_TIMER	(0x00040000)
#define BASE_BLOCK_ADRS_NULL	(0x0fffffff)

// GPIO Reg Map
#define GPIO_REG_ALTNATE	(BASE_BLOCK_ADRS_GPIO + 0x8)

// SPI Reg Map
#define FLASH_MEM_PAGE_LEN	(2048)
#define SPI_REG_DIV		(BASE_BLOCK_ADRS_SPI + 0x14)
#define SPI_REG_CS		(BASE_BLOCK_ADRS_SPI + 0x1C)
#define SPI_REG_MOSI	(BASE_BLOCK_ADRS_SPI + 0x18)
#define SPI_REG_ENABLE	(BASE_BLOCK_ADRS_SPI + 0x10)
#define SPI_REG_MISO	(BASE_BLOCK_ADRS_SPI + 0x84)
#define SPI_REG_INTR	(BASE_BLOCK_ADRS_SPI + 0x88)

// Timer Reg Map
#define TIMER_REG_DIV1	(BASE_BLOCK_ADRS_TIMER + 0x0)
#define TIMER_REG_DIV2	(BASE_BLOCK_ADRS_TIMER + 0x4)
#define TIMER_REG_DIV3	(BASE_BLOCK_ADRS_TIMER + 0x8)
#define TIMER_REG_ENABLE	(BASE_BLOCK_ADRS_TIMER + 0xC)
#define TIMER_REG_COUNT1	(BASE_BLOCK_ADRS_TIMER + 0x40)
#define TIMER_REG_COUNT2	(BASE_BLOCK_ADRS_TIMER + 0x44)
#define TIMER_REG_COUNT3	(BASE_BLOCK_ADRS_TIMER + 0x48)



/**-----------------------------------------------------------------------------
 * USI コマンド
 *-----------------------------------------------------------------------------*/
#define USI_READ_CMD		(0x80000000)
#define USI_WRITE_CMD		(0x40000000)


/**-----------------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
uint32_t usi_read_cmd(uint32_t adrs);
void usi_write_cmd(uint32_t wd, uint32_t adrs);
void usi_read_printf(uint32_t adrs);
//
void spi_write(uint8_t mosi);
uint8_t spi_read(uint8_t mosi);
//
void flash_protection_reg_write(void);
void flash_write_enable_cmd(void);
void flash_block_elase(void);
void flash_busy_wait(void);
void flash_program_data_load(void);
void flash_program_data_execute(void);
void flash_page_read(void);
void flash_read_data(void);
void flash_write(void);
void flash_read(void);
void flash_id_read(void);
//
void led_flash(void);


/**-----------------------------------------------------------------------------
 * USI Bus Read Sequence
 * adrs = block adrs
 *-----------------------------------------------------------------------------*/
uint32_t usi_read_cmd(uint32_t adrs)
{
	uint32_t lsbrd, msbrd;

	// adrs |= USI_READ_CMD;
	write_u32(adrs, ADRS_GPIO_0_IO_CTRL_OUT);
	write_u32(adrs >> 16, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_1_IO_CTRL_EN);
	write_u32(BASE_BLOCK_ADRS_NULL,0);		// Port に Read値が入力されるまで数クロックサイクル必要なため
	write_u32(BASE_BLOCK_ADRS_NULL,0);		// 空の write 動作を行い数クロック待つ
	lsbrd = read_u32(ADRS_GPIO_0_IO_CTRL);
	msbrd = read_u32(ADRS_GPIO_1_IO_CTRL) << 16;
	write_u32(0, ADRS_GPIO_1_IO_CTRL_EN);
	
	return msbrd | lsbrd;
}

/**-----------------------------------------------------------------------------
 * USI Bus Write Sequence
 * wd   = write data
 * adrs = block adrs
 *-----------------------------------------------------------------------------*/
void usi_write_cmd(uint32_t wd, uint32_t adrs)
{
	write_u32(wd, ADRS_GPIO_0_IO_CTRL_OUT);
	write_u32(wd>>16, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_0_IO_CTRL_EN);
	write_u32(0, ADRS_GPIO_0_IO_CTRL_EN);
	
	adrs |= USI_WRITE_CMD;
	write_u32(adrs, ADRS_GPIO_0_IO_CTRL_OUT);
	write_u32(adrs >> 16, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_1_IO_CTRL_EN);
	write_u32(0, ADRS_GPIO_1_IO_CTRL_EN);
}


/**-----------------------------------------------------------------------------
 * USI Bus Adrs printf
 * adrs = block adrs
 *-----------------------------------------------------------------------------*/
void usi_read_printf(uint32_t adrs)
{
	uint32_t rd = usi_read_cmd(adrs);
	bsp_printf("%x \r\n", rd);
}

/**-----------------------------------------------------------------------------
 * SPI Write
 * mosi = 1byte の送信データ
 *-----------------------------------------------------------------------------*/
void spi_write(uint8_t mosi)
{
	usi_write_cmd(0, 	SPI_REG_INTR);		// Intr Clear
	usi_write_cmd(mosi,	SPI_REG_MOSI);		// MOSI Send
	usi_write_cmd(1, 	SPI_REG_ENABLE);	// Spi Enable

	while (1) {
		if (1 == usi_read_cmd(SPI_REG_INTR)) {	// Intr Wait
			break;
		}
	}
}

/**-----------------------------------------------------------------------------
 * SPI Read
 * mosi = 1byte の送信データ
 *-----------------------------------------------------------------------------*/
uint8_t spi_read(uint8_t mosi)
{
	usi_write_cmd(0, 	SPI_REG_INTR);		// Intr Clear
	usi_write_cmd(mosi,	SPI_REG_MOSI);		// MOSI Send
	usi_write_cmd(1, 	SPI_REG_ENABLE);	// Spi Enable

	while (1) {
		if (1 == usi_read_cmd(SPI_REG_INTR)) {	// Intr Wait
			break;
		}
	}
	return usi_read_cmd(SPI_REG_MISO);
}

/**-----------------------------------------------------------------------------
 * flash protction reg write
 * 起動時は Program Reg にプロテクトがかかっており、データの書き込みには解除が必要
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
	spi_write(0x1f);	// Status Reg Access Adrs
	spi_write(0xA0);	// Protection Reg Adrs
	spi_write(0x83);	// SR Value
	usi_write_cmd(1, SPI_REG_CS);
}


/**-----------------------------------------------------------------------------
 * Flash Write Enable Cmd
 *-----------------------------------------------------------------------------*/
void flash_write_enable_cmd(void)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(0x06);
	usi_write_cmd(1, SPI_REG_CS);
}

/**-----------------------------------------------------------------------------
 * Flash 128KB Block Elase
 *-----------------------------------------------------------------------------*/
void flash_block_elase(void)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(0xd8);
	spi_write(0x00);	// dummy
	spi_write(0x00);	// Page adrs "H"
	spi_write(0x00);	// Page adrs "L"
	usi_write_cmd(1, SPI_REG_CS);
}

/**-----------------------------------------------------------------------------
 * Flash Busy Wait
 *-----------------------------------------------------------------------------*/
void flash_busy_wait(void)
{
	while (1) {
		usi_write_cmd(0, SPI_REG_CS);
		spi_write(0x0f);
		spi_write(0xC3);	// Status reg read
		uint8_t id = spi_read(0x00);
		usi_write_cmd(1, SPI_REG_CS);

		if ((id & 0x01) == 0) {
			break;
		}
	}
}

/**-----------------------------------------------------------------------------
 * Flash Program Data Load Cmd
 *-----------------------------------------------------------------------------*/
void flash_program_data_load(void)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(0x02);	// Program Data Load Cmd
	spi_write(0);		// col adrs "H"
	spi_write(0);		// col adrs "L"

	for (uint16_t i = 0; i < FLASH_MEM_PAGE_LEN; i++) {	// 取り敢えず確認用
		spi_write(i & 0xff);
	}
	usi_write_cmd(1, SPI_REG_CS);
}

/**-----------------------------------------------------------------------------
 * Flash Program Data Execute
 *-----------------------------------------------------------------------------*/
void flash_program_data_execute(void)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(0x10);	// Program Execute Cmd
	spi_write(0x00);	// dummy
	spi_write(0x00);	// Page adrs "H"
	spi_write(0x02);	// Page adrs "L"
	usi_write_cmd(1, SPI_REG_CS);
}

/**-----------------------------------------------------------------------------
 * Flash Page Read
 *-----------------------------------------------------------------------------*/
void flash_page_read(void)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(0x13);	// Page read Cmd
	spi_write(0x00);	// dummy
	spi_write(0x00);	// Page adrs "H"
	spi_write(0x02);	// Page adrs "L"
	usi_write_cmd(1, SPI_REG_CS);
}

/**-----------------------------------------------------------------------------
 * Flash Page Read
 *-----------------------------------------------------------------------------*/
void flash_read_data(void)
{
	usi_write_cmd(0, SPI_REG_CS);
	spi_write(0x03);	// read data
	spi_write(0x00);	// col adrs "H"
	spi_write(0x00);	// col adrs "L"
	spi_write(0x00);	// dummy

	for (uint16_t i = 0; i < FLASH_MEM_PAGE_LEN; i++) {
		uint8_t rd = spi_read(0x00);
		bsp_printf("%x \r\n", rd);
	}

	usi_write_cmd(1, SPI_REG_CS);
}

/**-----------------------------------------------------------------------------
 * Flash Write
 *-----------------------------------------------------------------------------*/
void flash_write(void)
{
	flash_write_enable_cmd();
	flash_block_elase();
	flash_busy_wait();
	flash_write_enable_cmd();
	flash_program_data_load();
	flash_program_data_execute();
	flash_busy_wait();
}

/**-----------------------------------------------------------------------------
 * Flash Read
 *-----------------------------------------------------------------------------*/
void flash_read(void)
{
	flash_page_read();
	flash_busy_wait();
	flash_read_data();
}


/**-----------------------------------------------------------------------------
 * Flash Rom ID Read
 *-----------------------------------------------------------------------------*/
void flash_id_read(void)
{
	uint8_t mfr_id, device_id_msb, device_id_lsb;

	usi_write_cmd(0, SPI_REG_CS);
	spi_read(0x9f);
	spi_read(0x00);
	mfr_id = spi_read(0x00);
	device_id_msb = spi_read(0x00);
	device_id_lsb = spi_read(0x00);
	usi_write_cmd(1, SPI_REG_CS);

	bsp_printf("%x,%x,%x \r\n", mfr_id, device_id_msb, device_id_lsb);
}


/**-----------------------------------------------------------------------------
 * LED FLASH
 *-----------------------------------------------------------------------------*/
void led_flash(void)
{
	static uint32_t t = 0;
	static uint8_t flash = 0x01;
	uint32_t now_t = usi_read_cmd(TIMER_REG_COUNT1);

	if (t + 99 < now_t) {
		t = now_t;
		flash++;
		flash &= 0x07;
		usi_write_cmd(flash, BASE_BLOCK_ADRS_GPIO);
	}
}

/**-----------------------------------------------------------------------------
 * main 関数
 *-----------------------------------------------------------------------------*/
void main()
{
	// GPIO
	usi_write_cmd(0x0, GPIO_REG_ALTNATE);	// Altanate mode

	// Timer
	usi_write_cmd(0x0, 		TIMER_REG_ENABLE);	// Timer Rst
	usi_write_cmd(499999, 	TIMER_REG_DIV1);	// Timer Div1
	usi_write_cmd(49999, 	TIMER_REG_DIV2);	// Timer Div2
	usi_write_cmd(49, 		TIMER_REG_DIV3);	// Timer Div3
	usi_write_cmd(0x7, 		TIMER_REG_ENABLE);	// Timer En

	// SPI
	usi_write_cmd(0x8,		SPI_REG_DIV);	// 動作周波数
	flash_protection_reg_write();
	
	while (1)
	{
		led_flash();
		flash_id_read();
		flash_write();
		flash_read();
	}
}
