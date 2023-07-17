/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * 周辺機器のアドレスマップ、コマンド定数を管理
 * 
 *-----------------------------------------------------------------------------*/
#ifndef periheral_macro_h
#define periheral_macro_h


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
#define SPI_REG_DIV		    (BASE_BLOCK_ADRS_SPI + 0x14)
#define SPI_REG_CS		    (BASE_BLOCK_ADRS_SPI + 0x1C)
#define SPI_REG_GPIO_ALT    (BASE_BLOCK_ADRS_SPI + 0x20)
#define SPI_REG_MOSI	    (BASE_BLOCK_ADRS_SPI + 0x18)
#define SPI_REG_ENABLE	    (BASE_BLOCK_ADRS_SPI + 0x10)
#define SPI_REG_MISO	    (BASE_BLOCK_ADRS_SPI + 0x84)
#define SPI_REG_INTR	    (BASE_BLOCK_ADRS_SPI + 0x88)

// Timer Reg Map
#define TIMER_REG_DIV1	    (BASE_BLOCK_ADRS_TIMER + 0x0)
#define TIMER_REG_DIV2	    (BASE_BLOCK_ADRS_TIMER + 0x4)
#define TIMER_REG_DIV3	    (BASE_BLOCK_ADRS_TIMER + 0x8)
#define TIMER_REG_ENABLE	(BASE_BLOCK_ADRS_TIMER + 0xC)
#define TIMER_REG_COUNT1	(BASE_BLOCK_ADRS_TIMER + 0x40)
#define TIMER_REG_COUNT2	(BASE_BLOCK_ADRS_TIMER + 0x44)
#define TIMER_REG_COUNT3	(BASE_BLOCK_ADRS_TIMER + 0x48)


/**-----------------------------------------------------------------------------
 * Bus Cmd
 *-----------------------------------------------------------------------------*/
#define USI_BUS_SELECT		(0x20)
#define UFI_BUS_SELECT		(0x30)
#define USI_READ_CMD		(0x80000000)
#define USI_WRITE_CMD		(0x40000000)
//
#define UFI_ENABLE_CMD		(0x80000000)
#define UFI_READ_CMD		(0x40000000 | UFI_ENABLE_CMD)
#define UFI_WRITE_CMD		(0x00000000 | UFI_ENABLE_CMD)

#endif