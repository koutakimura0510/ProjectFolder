/*
 * serial.c
 *
 *  Created on: Dec 20, 2020
 *      Author: koutakimura
 */

#include "MYLIB.h"

/* --------------------------------------------------------------------------
 * SSD1306 初期設定
 ----------------------------------------------------------------------------*/
void lcd_init(void)
{
	static const uint8_t initial_table[] =
	{
		CONTRAST_SET,
		CONTRAST_VALUE,
		SER_SEGMENT_REMAP,
		CHARGE_PUMP,
		ENABLE_CHARGE_PUMP,
		SCAN_DIRECTION,
		SET_COM_PIN,
		PIN_HARD,
		SET_DISPLAY_CLOCK,
		OSCILLATOR_RATIO,
		SET_PERIOD,
		SET_DCLK,
		SET_VCOMH,
		VCOMH_LEVEL,
		DISPLAY_ON,
	};

	wait_time(LCD_POWER_ON);

	for (uint8_t i = 0; i < NUM(initial_table); i++ ) {
		lcd_write(CMD_BYTE, initial_table[i]);
		wait_time(1);
	}
}

/* --------------------------------------------------------------------------
 * SSD1306 lcd データ送信
 ----------------------------------------------------------------------------*/
void lcd_write(uint8_t cmd_data, uint8_t wr_data)
{
	static uint8_t wdat[2];

	wdat[0] = cmd_data;
	wdat[1] = wr_data;
	i2c_send(wdat, LCD_ADRRESS, NUM(wdat));
}


/* --------------------------------------------------------------------------
 *lcd 画面消去
 ----------------------------------------------------------------------------*/
void lcd_clear(void)
{
	static const uint8_t clear_table[] =
	{
			SCROLL_STOP,
			MEMORY_MODE,
			HORIZONTAL_MODE,
			COLUMN_ADDRESS,
			COLUMN_START,
			COLUMN_END,
			PAGE_ADDRESS,
			PAGE_START,
			PAGE_END,
	};

	for (uint8_t i = 0; i < NUM(clear_table); i++) {
		lcd_write(CMD_BYTE, clear_table[i]);
	}

	for (uint16_t i = 0; i < MAX_DISP; i++) {
		lcd_write(WR_BYTE, CLEAR_DISP);
	}
}


/**-------------------------------------------------
 * I2C 送信
 * -------------------------------------------------
 * arg1:	送信データが保存されているアドレスを指定
 * arg2:	スレーブのアドレスを指定
 * arg3:	送信データのデータ長を指定
 * -------------------------------------------------
 * マスタモード時に、データ転送後、Start Conditionを生成するとRestart conditionを生成
 * -------------------------------------------------
 * レジスタ処理メモ
 * SR1_ADDR: ACK後にビットがセットされる
 * -------------------------------------------------*/
bool i2c_send(uint8_t *dat, uint8_t address, uint8_t len)
{
	/*//I2C1->CR1 |= I2C_CR1_PE_Msk;
	while (I2C1->SR2 & I2C_SR2_BUSY);

	I2C1->CR1 |= I2C_CR1_START_Msk;			//start condition
	while (!(I2C1->SR1 & I2C_SR1_SB));		//スタートコンディション完了まで待機

	I2C1->DR = address;
	//while (!(I2C1->SR1 & I2C_SR1_ADDR_Msk));	//アドレス送信が完了し、ACKがセットされるまでまで待機
	while (!(I2C1->SR1 & I2C_SR1_TXE_Msk));	//DRレジスタが書き込み可能になるまで待機

	for (uint8_t i = 0; i < len; i++) {
		I2C1->DR = dat[i];
		while (!(I2C1->SR1 & I2C_SR1_TXE_Msk));	//DRレジスタが書き込み可能になるまで待機
	}

	//while (!(I2C1->SR1 & I2C_SR1_TXE_Msk));	//DRレジスタが書き込み可能になるまで待機
	I2C1->CR1 |= I2C_CR1_STOP_Msk;				//stop condition
	while (I2C1->CR1 & I2C_CR1_PE_Msk);		//クリアされるまで待機
*/
	//HAL_I2C_Master_Transmit(&hi2c1, address, dat, len, 100);
	return true;
}


/**-------------------------------------------------
 * SPI送信
 * -------------------------------------------------*/
uint8_t spi_send(uint16_t dat)
{
	while (!(SPI1->SR & SPI_SR_TXE));

	return SPI1->DR;
}


/**-------------------------------------------------
 * SPI受信
 * -------------------------------------------------*/
uint16_t spi_read(void)
{
	while (!(SPI1->SR & SPI_SR_RXNE));

	return SPI1->DR;
}
