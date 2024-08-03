/*------------------------------------------------------------------------------
 * Create 2024/06/15
 * Author Kouta Kimura
 * 
 * SPI 通信で FPGA の制御を行うため、USIB I/F 関連の関数は SPIの関数とまとめる。
 *-----------------------------------------------------------------------------*/
#include "trypad.h"
#include "pico/stdlib.h"
#include "hardware/spi.h"

/**-----------------------------------------------------------------------------
 * グローバル変数
 *-----------------------------------------------------------------------------*/

/**-----------------------------------------------------------------------------
 * ファイル内関数
 *-----------------------------------------------------------------------------*/
static void spi_write_read(uint8_t *wbuff, uint8_t *rbuff, uint16_t len);
static void spi_write(uint8_t *wbuff, uint16_t len);
static void nop_wait(uint8_t wait);


/**-----------------------------------------------------------------------------
 * spi init
 * set_sel : 1=hard, 0=soft
 * 
 * ハード動作の時、1byte ごとに CS ドライブされる点に注意
 *-----------------------------------------------------------------------------*/
void pico_spi_init(uint8_t set_sel, uint32_t baudrate)
{
	spi_init(HARDWARE_SPI_PORT, baudrate);

	if (set_sel) {
		gpio_set_function(TRION_PICO_SPI_CS, GPIO_FUNC_SPI);
	}else{
		gpio_init(TRION_PICO_SPI_CS);
		gpio_set_dir(TRION_PICO_SPI_CS, 1);
		gpio_put(TRION_PICO_SPI_CS, 1);
	}

	gpio_set_function(TRION_PICO_SPI_SCK, GPIO_FUNC_SPI);
	gpio_set_function(TRION_PICO_SPI_MOSI, GPIO_FUNC_SPI);
	gpio_set_function(TRION_PICO_SPI_MISO, GPIO_FUNC_SPI);
	// bi_decl(bi_4pins_with_func(PICO_DEFAULT_SPI_RX_PIN, PICO_DEFAULT_SPI_TX_PIN, PICO_DEFAULT_SPI_SCK_PIN, PICO_DEFAULT_SPI_CSN_PIN, GPIO_FUNC_SPI));
}


/**-----------------------------------------------------------------------------
 * usib write
 * adrs : 書き込みアドレス
 * wd : 書き込みデータ
 *-----------------------------------------------------------------------------*/
void usi_write(uint32_t adrs, uint32_t wd)
{
	adrs |= USI_WRITE_CMD;
	uint8_t wbuff[] = {
		(adrs >> 24) & 0xff,
		(adrs >> 16) & 0xff,
		(adrs >> 8) & 0xff,
		(adrs) & 0xff,
		(wd >> 24) & 0xff,
		(wd >> 16) & 0xff,
		(wd >> 8) & 0xff,
		(wd) & 0xff,
	};

	spi_write(wbuff, ROWS(wbuff));
}

/**-----------------------------------------------------------------------------
 * usib read
 * adrs : 読み込みアドレス
 *-----------------------------------------------------------------------------*/
uint32_t usi_read(uint32_t adrs)
{
	adrs |= USI_READ_CMD;
	uint8_t wbuff[] = {
		(adrs >> 24) & 0xff,
		(adrs >> 16) & 0xff,
		(adrs >> 8) & 0xff,
		(adrs) & 0xff,
		0x00,0x00,0x00,0x00, // dummy
	};
	uint8_t rbuff[ROWS(wbuff)*2];

	spi_write_read(wbuff, rbuff, ROWS(wbuff));

	return (rbuff[4] << 24) | (rbuff[5] << 16) | (rbuff[6] << 8) | rbuff[7];
}

/**-----------------------------------------------------------------------------
 * usib read wait
 * 特定レジスタの bit が検出されるまで待機
 * 
 * adrs : 読み込みアドレス
 * bit_mask : レジスタ Bit 位置
 * 
 * TODO 更新予定：指定時間経過しても検出できない場合の例外処理
 *-----------------------------------------------------------------------------*/
void usi_read_wait(uint32_t adrs, uint32_t bit_mask)
{
	adrs |= USI_READ_CMD;
	uint8_t wbuff[] = {
		(adrs >> 24) & 0xff,
		(adrs >> 16) & 0xff,
		(adrs >> 8) & 0xff,
		(adrs) & 0xff,
		0x00,0x00,0x00,0x00, // dummy
	};
	uint8_t rbuff[ROWS(wbuff)*2];
	uint32_t rd;

	do {
		spi_write_read(wbuff, rbuff, ROWS(wbuff));
		rd = (rbuff[4] << 24) | (rbuff[5] << 16) | (rbuff[6] << 8) | rbuff[7];
		rd &= bit_mask;
	} while (!(bit_mask == rd));

	return;
}

/**-----------------------------------------------------------------------------
 * SPI Direct Control の制御用 GPIO の出力を設定する
 * L = Un Direct, H = Direct
 * 
 * gpio GPIO ID
 * value 1=H, 0=L
 *-----------------------------------------------------------------------------*/
void spi_direct_control(uint8_t gpio, uint8_t value)
{
	gpio_put(gpio, value);
	nop_wait(4);
}

/**-----------------------------------------------------------------------------
 * FPGA に接続されている Slave デバイスに対して、ダイレクト・ライト・アクセスを行う。
 * 
 * *pwbuff バッファポインタ
 * len pwbuff のバッファサイズ
 *-----------------------------------------------------------------------------*/
void spi_write_direct(uint8_t *pwbuff, uint16_t len)
{
	spi_write(pwbuff, len);
}

/**-----------------------------------------------------------------------------
 * spi_write_direct の CS を制御しない動作の関数
 * 
 * *pwbuff バッファポインタ
 * len pwbuff のバッファサイズ
 *-----------------------------------------------------------------------------*/
void spi_write_direct_notcs(uint8_t *pwbuff, uint16_t len)
{
	spi_write_blocking(HARDWARE_SPI_PORT, pwbuff, len);
	nop_wait(4);
}

/**-----------------------------------------------------------------------------
 * FPGA に接続されている Slave デバイスに対して、ダイレクト・リード・アクセスを行う。
 * 
 * *pwbuff バッファポインタ
 * *prbuff バッファポインタ
 * len pwbuff のバッファサイズ
 *-----------------------------------------------------------------------------*/
void spi_read_direct(uint8_t *pwbuff, uint8_t *prbuff, uint16_t len)
{
	spi_write_read(pwbuff, prbuff, len);
}

/**-----------------------------------------------------------------------------
 * spi_read_direct の CS を制御しない動作の関数
 * 
 * *pwbuff バッファポインタ
 * len pwbuff のバッファサイズ
 *-----------------------------------------------------------------------------*/
void spi_read_direct_notcs(uint8_t *pwbuff, uint8_t *prbuff, uint16_t len)
{
	spi_write_read_blocking(HARDWARE_SPI_PORT, pwbuff, prbuff, len);
	nop_wait(4);
}

/**-----------------------------------------------------------------------------
 * 
 * cs_drive 1=H, 0=L
 *-----------------------------------------------------------------------------*/
void spi_cs_drive(uint8_t cs_drive)
{
	gpio_put(TRION_PICO_SPI_CS, cs_drive);
}

/**-----------------------------------------------------------------------------
 * spi r/w
 * FPGA tCSH : min 400ns, typ 800ns
 *-----------------------------------------------------------------------------*/
static void spi_write_read(uint8_t *wbuff, uint8_t *rbuff, uint16_t len)
{
	gpio_put(TRION_PICO_SPI_CS, 0);
	spi_write_read_blocking(HARDWARE_SPI_PORT, wbuff, rbuff, len);
	nop_wait(4);
	gpio_put(TRION_PICO_SPI_CS, 1);
	nop_wait(4);
}

/**-----------------------------------------------------------------------------
 * spi write
 *-----------------------------------------------------------------------------*/
static void spi_write(uint8_t *wbuff, uint16_t len)
{
	gpio_put(TRION_PICO_SPI_CS, 0);
	spi_write_blocking(HARDWARE_SPI_PORT, wbuff, len);
	nop_wait(4);
	gpio_put(TRION_PICO_SPI_CS, 1);
	nop_wait(4);
}

/**-----------------------------------------------------------------------------
 * spi nop wait
 *-----------------------------------------------------------------------------*/
static void nop_wait(uint8_t wait)
{
	for (uint8_t i = 0; i < wait; i++) {
		__asm volatile ("nop");
	}
}