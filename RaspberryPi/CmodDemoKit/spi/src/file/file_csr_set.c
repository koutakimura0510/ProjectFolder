//----------------------------------------------------------
// Create  2022/08/28
// Author  KoutaKimura
// -
// FILE 操作ライブラリを利用し、設定ファイルを読み込み
// Slaveデバイスへのデータの送信及び受信を行う。
// 
//----------------------------------------------------------
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#define BCM_LIB_INCLUDE
#include "gpio_bcm_external.h"


/**----------------------------------------------------------
 * GPIO open 初期化
 * 
 * spi_dev :250MHz / spi_dev = SPI CLK
 * 			2の乗数の値を指定 BCM2835_SPI_CLOCK_DIVIDER_xxx 参考
 *---------------------------------------------------------*/
bool gpio_init(uint16_t spi_div)
{
	if (!bcm2835_init())
	{
		printf("bcm2835 not init\n");
		return false;
	}

	if (!bcm2835_spi_begin())
	{
		printf("bcm2835 not spi begin\n");
		return false;
	}

	// 汎用 Pin 設定
	bcm2835_gpio_fsel(GPIO_25_MASTER_SLAVE_SELECT, BCM2835_GPIO_FSEL_OUTP);
	bcm2835_gpio_write(GPIO_25_MASTER_SLAVE_SELECT, HIGH);

	// FPGA 側でGPIO 設定反映のため待機
	bcm2835_delayMicroseconds(1);

	// SPI 設定
	// bcm2835_gpio_set_pud(RPI_V2_GPIO_P1_24, BCM2835_GPIO_PUD_UP);	// CS プルアップ
	bcm2835_spi_setBitOrder(BCM2835_SPI_BIT_ORDER_MSBFIRST);
	bcm2835_spi_setDataMode(BCM2835_SPI_MODE0);
	bcm2835_spi_setClockDivider(spi_div);			// APBクロック 250MHz を分周

	// CS pin を関数呼び出しで Toggle させる場合は、下記の設定はコメントアウトする
	bcm2835_spi_chipSelect(BCM2835_SPI_CS0);					// CS ピンの選択
	bcm2835_spi_setChipSelectPolarity(BCM2835_SPI_CS0, LOW);	// CS ピン Active の向き設定

	return true;
}