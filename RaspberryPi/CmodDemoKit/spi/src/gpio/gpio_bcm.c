//----------------------------------------------------------
// Create  2022/08/27
// Author  KoutaKimura
// -
// bcm2835ライブラリを利用した RaspberryPi GPIO の操作を行う
// 関数をまとめたヘッダファイル
// 
//----------------------------------------------------------
#define BCM_LIB_INCLUDE
#include <main.h>


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


/**----------------------------------------------------------
 * GPIO close ポート開放
 *---------------------------------------------------------*/
bool gpio_close(void)
{
	bcm2835_spi_end();
	
	if (!bcm2835_close())
	{
		printf("bcm2835 not close\n");
		return false;
	}

	printf("bcm2835 close ok\n");

	return true;
}



/**----------------------------------------------------------
 * 汎用 GPIO 操作
 * 引数 pin に設定する値は、端末で pinout コマンドを実行して確認する
 * 例えば 40pin の中から pin22 の GPIO25 を操作したい場合は、10進数で 25 を与える
 * 
 * pin: GPIO ピン番号, gpio_bcm_macro のピン番号定数を指定
 * on: Macro指定 GPIO_HIGH or GPIO_LOW
 *---------------------------------------------------------*/
void gpio_write(uint8_t pin, uint8_t on)
{
	bcm2835_gpio_write(pin, on);
}


/**----------------------------------------------------------
 * spi 1byte 送受信
 * 
 * send_data: 1byte送信データ
 * return: Slave デバイスの読み込みデータ
 *---------------------------------------------------------*/
uint8_t gpio_spi_transfer(uint8_t send_data)
{
	uint8_t read_data;

	read_data = bcm2835_spi_transfer(send_data);
	printf("MISO = 0x%x\n", read_data);

	return read_data;
}


/**----------------------------------------------------------
 * spi 連続バイト 送受信
 * wbuff: MOSI 送信バッファのアドレス
 * rbuff: MISO 受信バッファのアドレス
 * len  : バッファの深さ。送受信データは同じ配列長である必要あり 
 *----------------------------------------------------------*/
void gpio_spi_transfernb(char *wbuff, char *rbuff, uint32_t len)
{
	bcm2835_spi_transfernb(wbuff, rbuff, len);
}


/**----------------------------------------------------------
 * SPI クロック速度設定、通信中は設定を変更しないように注意する
 * 
 * spi_dev :250MHz / spi_dev = SPI CLK
 * 			2の乗数の値を指定 BCM2835_SPI_CLOCK_DIVIDER_xxx 参考
 *---------------------------------------------------------*/
void gpio_spi_clkdiv(uint16_t spi_div)
{
	bcm2835_spi_setClockDivider(spi_div);	
}