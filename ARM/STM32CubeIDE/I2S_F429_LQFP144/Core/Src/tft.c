/*
 * tft.c
 *
 *  Created on: 2021/01/22
 *      Author: koutakimura
 */


/**
 * Include
 */
#include "../Inc/MYLIB.h"



/*---------------------------------------
 * DB0	B0	|	DB6  G0  |  DB12 R0	|
 * DB1	B1	|	DB7  G1  |  DB13 R1	|
 * DB2	B2	|	DB8  G2  |  DB14 R2	|
 * DB3	B3	|	DB9  G3  |  DB15 R3	|
 * DB4	B4	|	DB10 G4  |  DB16 R4	|
 * DB5	B5	|	DB11 G5  |  DB17 R5	|
 *---------------------------------------*/

/**----------------------------------------------
 * 	  R			|	  G			|		B		|
 * ----------------------------------------------
 * R0	PC10	| G0	PA6		|	B0	 PD6	|
 * R1	PB0		| G1	PG10	|	B1	 PG11	|
 * R2	PA11	| G2	PB10	|	B2	 PG12	|
 * R3	PA12	| G3	PB11	|	B3	 PA3	|
 * R4	PB1		| G4	PC7		|	B4	 PB8	|
 * R5	PG6		| G5	PD3		|	B5	 PB9	|
 *----------------------------------------------*/

/**----------------------------------------------------------
 * 	  WRITE		|	  CMD		|		CMD				|
 * ----------------------------------------------------------
 * ENABLE	PF10	| CSX	PC2		|	WRX_DCX	PD13	|
 * DOTCLK	PG7		| RDX	PD12	|	DCX_SCL	PF7		|
 * HSYNC	PC6		| TE	PD11	|	SDA			PF9		|
 * VSYNC	PA4		| ---------	|	----------------	|
 *----------------------------------------------------------*/

/**-------------------------------------------------------------------------
 * DCXもしくはRSpinはコマンド送信かデータ送信選択
 * CSXはチップセレクト
 * RDXはReadDataInput
 * WRXはWritePin 立ち上がりで書き込み操作など
 *-------------------------------------------------------------------------*/



/**-----------------------------------------------------------------------
 * フレームバッファの確保
 *-----------------------------------------------------------------------*/
static uint16_t tft_flame_buffer[TFT_MAX_SIZE * 2];


/**-----------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------*/
static void write_cmd(uint8_t wd);
static void write_data(uint8_t wd);
static void write_word_data(uint16_t wd);


/**-----------------------------------------------------------------------
 * TFT LCD 初期設定
 *-----------------------------------------------------------------------*/
void tft_display_init(void)
{
	static const uint8_t reset[][2] = {
			{SOFTWARE_RESET,   TFT_CMD_BYTE,},
			{TFT_DISPLAY_OFF,  TFT_CMD_BYTE,},
			{PIXEL_FORMAT_SET, TFT_CMD_BYTE,},
			{0x55, TFT_DATA_BYTE,},	// 16bit RGB
	};

	static const uint8_t reg_init[][2] = {
			{POWER_CONTROL_1, 0}, {0x23, 1},
			{POWER_CONTROL_2, 0}, {0x10, 1},
			{VCOM_CONTROL_1,  0}, {0x3e, 1}, {0x28, 1},
			{VCOM_CONTROL_2,  0}, {0x86, 1},
			{MEMORY_ACCESS_CONTROL, 0}, {0x98, 1},
			{FRAME_CONTROL_NORMAL,  0}, {0x00, 1}, {0x18, 1},
			{DISPALY_FUNCTION_CONTROL, 0}, {0x0a, 1}, {0xa2, 1}, {0x27, 1}, {0x04, 1},
			{GAMMA_SET, 0}, {0x01, 1},
			{POSITIVE_GAMMA, 0}, {0x0f, 1}, {0x31, 1}, {0x2b, 1}, {0x0c, 1}, {0x0e, 1}, {0x08, 1}, {0x4e, 1}, {0xf1, 1}, {0x37, 1}, {0x07, 1},
			{0x10, 1}, {0x03, 1}, {0x0e, 1}, {0x09, 1}, {0x00, 1},
			{NEGATIVE_GAMMA, 0}, {0x00, 1}, {0x0e, 1}, {0x14, 1}, {0x03, 1}, {0x11, 1}, {0x07, 1}, {0x31, 1}, {0xc1, 1}, {0x48, 1}, {0x08, 1},
			{0x0f, 1}, {0x0c, 1}, {0x31, 1}, {0x36, 1}, {0x0f, 1},
	};

	static const uint8_t display_on[][2] = {
			{0x11, 0},
			{0x29, 0},
	};

	for (uint8_t i = 0; i < NUM(reset) << 1; i++) {
		if (reset[i][1] == 0) {
			write_cmd(reset[i][0]);
		} else {
			write_data(reset[i][0]);
		}
		wait_time(1);
	}

	for (uint8_t i = 0; i < NUM(reg_init) << 1; i++) {
		if (reg_init[i][1] == 0) {
			write_cmd(reg_init[i][0]);
		} else {
			write_data(reg_init[i][0]);
		}
	}

	for (uint8_t i = 0; i < NUM(display_on) << 1; i++) {
		if (display_on[i][1] == 0) {
			write_cmd(display_on[i][0]);
		} else {
			write_data(display_on[i][0]);
		}
		wait_time(1);
		write_cmd(COLUMN_ADDRESS_SET);
		write_data(0);
		write_data(0);
		write_data(0);
		write_data(TFT_DISPLAY_WIDTH);

		write_cmd(PAGE_ADDRESS_SET);
		write_data(0);
		write_data(0);
		write_data(TFT_DISPLAY_HEIGHT >> 8);
		write_data(TFT_DISPLAY_HEIGHT & 0xff);
		write_cmd(MEMORY_WRITE);
	}
}


/**---------------------------------------------------------------
 * TFT液晶　全画面表示
 * --------------------------------------------------------------
 * wd	: 設定を行うレジスタのアドレスを指定
 *---------------------------------------------------------------*/
void tft_display_flash(uint16_t color)
{
	write_word_data(color);

	for (uint32_t i = 0; i < TFT_MAX_SIZE; i++) {
		GPIOD->ODR &= ~GPIO_ODR_OD13_Msk;
		GPIOD->ODR |= GPIO_ODR_OD13_Msk;
	}
}


/**---------------------------------------------------------------
 * TFT液晶　コマンド送信
 * --------------------------------------------------------------
 * wd	: 設定を行うレジスタのアドレスを指定
 *---------------------------------------------------------------*/
static void write_cmd(uint8_t wd)
{
	GPIOC->ODR &= ~GPIO_ODR_OD2_Msk;	//CS Low
	GPIOD->ODR |= GPIO_ODR_OD12_Msk;	//RD High
	GPIOD->ODR |= GPIO_ODR_OD13_Msk;	//WR High
	GPIOF->ODR &= ~GPIO_ODR_OD7_Msk;	//DC Low

//	HAL_GPIO_WritePin(GPIOE, GPIO_PIN_4, 0);
//	HAL_SPI_Transmit(&hspi4, &wd, 1, 1000);
//	HAL_GPIO_WritePin(GPIOE, GPIO_PIN_4, 1);

	GPIOD->ODR &= ~GPIO_ODR_OD6_Msk;
	GPIOG->ODR &= ~GPIO_ODR_OD11_Msk;
	GPIOG->ODR &= ~GPIO_ODR_OD12_Msk;
	GPIOA->ODR &= ~GPIO_ODR_OD3_Msk;
	GPIOB->ODR &= ~GPIO_ODR_OD8_Msk;
	GPIOB->ODR &= ~GPIO_ODR_OD9_Msk;
	GPIOA->ODR &= ~GPIO_ODR_OD6_Msk;
	GPIOG->ODR &= ~GPIO_ODR_OD10_Msk;

	GPIOD->ODR |= (((wd & 0x01) >> 0) << GPIO_ODR_OD6_Pos);
	GPIOG->ODR |= (((wd & 0x02) >> 1) << GPIO_ODR_OD11_Pos);
	GPIOG->ODR |= (((wd & 0x04) >> 2) << GPIO_ODR_OD12_Pos);
	GPIOA->ODR |= (((wd & 0x08) >> 3) << GPIO_ODR_OD3_Pos);
	GPIOB->ODR |= (((wd & 0x10) >> 4) << GPIO_ODR_OD8_Pos);
	GPIOB->ODR |= (((wd & 0x20) >> 5) << GPIO_ODR_OD9_Pos);
	GPIOA->ODR |= (((wd & 0x40) >> 6) << GPIO_ODR_OD6_Pos);
	GPIOG->ODR |= (((wd & 0x80) >> 7) << GPIO_ODR_OD10_Pos);

	GPIOD->ODR &= ~GPIO_ODR_OD13_Msk;
	GPIOD->ODR |= GPIO_ODR_OD13_Msk;	// WRの立ち上がりで書き込み
}


/**---------------------------------------------------------------
 * TFT液晶　データ送信
 * --------------------------------------------------------------
 * wd	: 指定したレジスタに書き込むデータを指定
 *---------------------------------------------------------------*/
static void write_data(uint8_t wd)
{
	GPIOC->ODR &= ~GPIO_ODR_OD2_Msk;	//CS Low
	GPIOD->ODR |= GPIO_ODR_OD12_Msk;	//RD High
	GPIOD->ODR |= GPIO_ODR_OD13_Msk;	//WR High
	GPIOF->ODR |= GPIO_ODR_OD7_Msk;		//DC High

//	HAL_GPIO_WritePin(GPIOE, GPIO_PIN_4, 0);
//	HAL_SPI_Transmit(&hspi4, &n, 1, 2000);
//	HAL_GPIO_WritePin(GPIOE, GPIO_PIN_4, 1);

	GPIOD->ODR &= ~GPIO_ODR_OD6_Msk;
	GPIOG->ODR &= ~GPIO_ODR_OD11_Msk;
	GPIOG->ODR &= ~GPIO_ODR_OD12_Msk;
	GPIOA->ODR &= ~GPIO_ODR_OD3_Msk;
	GPIOB->ODR &= ~GPIO_ODR_OD8_Msk;
	GPIOB->ODR &= ~GPIO_ODR_OD9_Msk;
	GPIOA->ODR &= ~GPIO_ODR_OD6_Msk;
	GPIOG->ODR &= ~GPIO_ODR_OD10_Msk;

	GPIOD->ODR |= (((wd & 0x01) >> 0) << GPIO_ODR_OD6_Pos);
	GPIOG->ODR |= (((wd & 0x02) >> 1) << GPIO_ODR_OD11_Pos);
	GPIOG->ODR |= (((wd & 0x04) >> 2) << GPIO_ODR_OD12_Pos);
	GPIOA->ODR |= (((wd & 0x08) >> 3) << GPIO_ODR_OD3_Pos);
	GPIOB->ODR |= (((wd & 0x10) >> 4) << GPIO_ODR_OD8_Pos);
	GPIOB->ODR |= (((wd & 0x20) >> 5) << GPIO_ODR_OD9_Pos);
	GPIOA->ODR |= (((wd & 0x40) >> 6) << GPIO_ODR_OD6_Pos);
	GPIOG->ODR |= (((wd & 0x80) >> 7) << GPIO_ODR_OD10_Pos);

	GPIOD->ODR &= ~GPIO_ODR_OD13_Msk;	//WRトグルで書き込み
	GPIOD->ODR |= GPIO_ODR_OD13_Msk;
}


/**---------------------------------------------------------------
 * TFT液晶　データ送信
 * --------------------------------------------------------------
 * wd	: 指定したレジスタに書き込むデータを指定
 *---------------------------------------------------------------*/
static void write_word_data(uint16_t wd)
{
	GPIOC->ODR &= ~GPIO_ODR_OD2_Msk;	//CS Low
	GPIOD->ODR |= GPIO_ODR_OD12_Msk;	//RD High
	GPIOD->ODR |= GPIO_ODR_OD13_Msk;	//WR High
	GPIOF->ODR |= GPIO_ODR_OD7_Msk;		//DC High

//	HAL_GPIO_WritePin(GPIOE, GPIO_PIN_4, 0);
//	HAL_SPI_Transmit(&hspi4, &n, 1, 2000);
//	HAL_GPIO_WritePin(GPIOE, GPIO_PIN_4, 1);

	GPIOD->ODR &= ~GPIO_ODR_OD6_Msk;
	GPIOG->ODR &= ~GPIO_ODR_OD11_Msk;
	GPIOG->ODR &= ~GPIO_ODR_OD12_Msk;
	GPIOA->ODR &= ~GPIO_ODR_OD3_Msk;
	GPIOB->ODR &= ~GPIO_ODR_OD8_Msk;
	GPIOB->ODR &= ~GPIO_ODR_OD9_Msk;

	GPIOA->ODR &= ~GPIO_ODR_OD6_Msk;
	GPIOG->ODR &= ~GPIO_ODR_OD10_Msk;
	GPIOB->ODR &= ~GPIO_ODR_OD10_Msk;
	GPIOB->ODR &= ~GPIO_ODR_OD11_Msk;
	GPIOC->ODR &= ~GPIO_ODR_OD7_Msk;
	GPIOD->ODR &= ~GPIO_ODR_OD3_Msk;

	GPIOC->ODR &= ~GPIO_ODR_OD10_Msk;
	GPIOB->ODR &= ~GPIO_ODR_OD1_Msk;
	GPIOA->ODR &= ~GPIO_ODR_OD11_Msk;
	GPIOA->ODR &= ~GPIO_ODR_OD12_Msk;
	GPIOB->ODR &= ~GPIO_ODR_OD2_Msk;
	GPIOG->ODR &= ~GPIO_ODR_OD6_Msk;

//	GPIOD->ODR |= (((wd & 0x01) >> 0) << GPIO_ODR_OD6_Pos);
	GPIOG->ODR |= (((wd & 0x0001) >> 0) << GPIO_ODR_OD11_Pos);
	GPIOG->ODR |= (((wd & 0x0002) >> 1) << GPIO_ODR_OD12_Pos);
	GPIOA->ODR |= (((wd & 0x0004) >> 2) << GPIO_ODR_OD3_Pos);
	GPIOB->ODR |= (((wd & 0x0008) >> 3) << GPIO_ODR_OD8_Pos);
	GPIOB->ODR |= (((wd & 0x0010) >> 4) << GPIO_ODR_OD9_Pos);

	GPIOA->ODR |= (((wd & 0x0020) >> 5) << GPIO_ODR_OD6_Pos);
	GPIOG->ODR |= (((wd & 0x0040) >> 6) << GPIO_ODR_OD10_Pos);
	GPIOB->ODR |= (((wd & 0x0080) >> 7) << GPIO_ODR_OD10_Pos);
	GPIOB->ODR |= (((wd & 0x0100) >> 8) << GPIO_ODR_OD11_Pos);
	GPIOC->ODR |= (((wd & 0x0200) >> 9) << GPIO_ODR_OD7_Pos);
	GPIOD->ODR |= (((wd & 0x0400) >> 10) << GPIO_ODR_OD3_Pos);

//	GPIOC->ODR |= (((wd & 0x80) >> 7) << GPIO_ODR_OD10_Pos);
	GPIOB->ODR |= (((wd & 0x0800) >> 11) << GPIO_ODR_OD1_Pos);
	GPIOA->ODR |= (((wd & 0x1080) >> 12) << GPIO_ODR_OD11_Pos);
	GPIOA->ODR |= (((wd & 0x2080) >> 13) << GPIO_ODR_OD12_Pos);
	GPIOB->ODR |= (((wd & 0x4080) >> 14) << GPIO_ODR_OD2_Pos);
	GPIOG->ODR |= (((wd & 0x8080) >> 15) << GPIO_ODR_OD6_Pos);

	GPIOD->ODR &= ~GPIO_ODR_OD13_Msk;
	GPIOD->ODR |= GPIO_ODR_OD13_Msk;
}
