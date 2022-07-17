//----------------------------------------------------------
// Create  2022/7/16
// Author  koutakimura
// -
// RaspberryPi SPI通信 Master 動作
// 
//----------------------------------------------------------

/**----------------------------------------------------------
 * Include
 *---------------------------------------------------------*/
#include <stdio.h>
#include <stdbool.h>
#include <bcm2835.h>


//----------------------------------------------------------
// bcm2835 初期化
//----------------------------------------------------------
bool bcm_init(void)
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

	bcm2835_spi_setBitOrder(BCM2835_SPI_BIT_ORDER_MSBFIRST);
	bcm2835_spi_setDataMode(BCM2835_SPI_MODE0);
	bcm2835_spi_setClockDivider(BCM2835_SPI_CLOCK_DIVIDER_256);
	bcm2835_spi_chipSelect(BCM2835_SPI_CS0);
	bcm2835_spi_setChipSelectPolarity(BCM2835_SPI_CS0, LOW);

	return true;
}

/**----------------------------------------------------------
 * bcm close ポート開放
 *---------------------------------------------------------*/
bool bcm_close(void)
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
 * spi 
 *---------------------------------------------------------*/
void bcm_spi_transfer(uint8_t send_data)
{
	uint8_t read_data;

	while (1)
	{
		read_data = bcm2835_spi_transfer(send_data);
		// bcm_spi_

		if (read_data != send_data)
		{
			printf("MISO = 0x%x\n", read_data);
		}
		else
		{
			printf("MISO = 0x%x\n", read_data);
			break;
		}
		bcm2835_delay(1000);
	}
}


/**----------------------------------------------------------
 * main 関数
 *---------------------------------------------------------*/
int main(void)
{
	if (false == bcm_init())
	{
		return 1;
	}

	bcm_spi_transfer(0x33);

	if (false == bcm_close())
	{
		return 1;
	}

	printf("end\n");

	return 0;
}