/*
 * display.c
 *
 *  Created on: Dec 19, 2020
 *      Author: koutakimura
 */
/*
  * --TFT--
  * RGB	: PA3 PA6 PA11 PA12
  * 		: PB0 PB1 PB8 PB9 PB10 PB11
  * 		: PC7 PC10
  * 		: PD3 PD6
  * 		: PG6 PG10 PG11 PG12
  *
  * ENABLE	: PF10
  * VSYNC	: PA4
  * HSYNC	: PC6
  * DOTCLK	: PG7
  *
  * CSX	: PC2
  * RDX	: PD12
  * TE		: PD11
  * WRX	: PD13
  * DCX	: PF7
  * SDA	:	/
  */

/**-------------------------------------------------
 * include
 * -------------------------------------------------*/
#include "../Inc/MYLIB.h"


/**-------------------------------------------------
 * 関数宣言
 * -------------------------------------------------*/
void display_init(void);
void write_data(uint8_t d);


/**-------------------------------------------------
 * TFT液晶初期設定
 * -------------------------------------------------*/
void display_init(void)
{
	GPIOC->ODR &= ~GPIO_ODR_OD2;
	GPIOF->ODR &= ~GPIO_ODR_OD7;
	GPIOD->ODR &= ~GPIO_ODR_OD13;
	GPIOD->ODR |= GPIO_ODR_OD12;

	GPIOA->ODR &= ~(GPIO_ODR_OD3 | GPIO_ODR_OD6);
	GPIOB->ODR &= ~(GPIO_ODR_OD8 | GPIO_ODR_OD9);
	GPIOD->ODR &= ~(GPIO_ODR_OD6);
	GPIOG->ODR &= ~(GPIO_ODR_OD10 | GPIO_ODR_OD11 | GPIO_ODR_OD12);

	GPIOD->ODR |= GPIO_ODR_OD6;
	GPIOD->ODR |= GPIO_ODR_OD13;
	wait_time(1);
	GPIOD->ODR &= ~GPIO_ODR_OD13;
	wait_time(5);

	GPIOA->ODR &= ~(GPIO_ODR_OD3 | GPIO_ODR_OD6);
	GPIOB->ODR &= ~(GPIO_ODR_OD8 | GPIO_ODR_OD9);
	GPIOD->ODR &= ~(GPIO_ODR_OD6);
	GPIOG->ODR &= ~(GPIO_ODR_OD10 | GPIO_ODR_OD11 | GPIO_ODR_OD12);

	GPIOA->ODR |= GPIO_ODR_OD3;
	GPIOB->ODR |= GPIO_ODR_OD9;

	GPIOD->ODR |= GPIO_ODR_OD13;
	wait_time(1);
	GPIOD->ODR &= ~GPIO_ODR_OD13;
}


/**-------------------------------------------------
 * 8bitデータ書き込み操作
 * -------------------------------------------------*/
void write_data(uint8_t d)
{

	GPIOA->ODR &= ~(GPIO_ODR_OD3 | GPIO_ODR_OD6);
	GPIOB->ODR &= ~(GPIO_ODR_OD8 | GPIO_ODR_OD9);
	GPIOD->ODR &= ~(GPIO_ODR_OD6);
	GPIOG->ODR &= ~(GPIO_ODR_OD10 | GPIO_ODR_OD11 | GPIO_ODR_OD12);

	GPIOD->ODR |= GPIO_ODR_OD6;
	GPIOA->ODR |= (GPIO_ODR_OD3 | GPIO_ODR_OD6);
	GPIOB->ODR |= (GPIO_ODR_OD8 | GPIO_ODR_OD9);
	GPIOG->ODR |= (GPIO_ODR_OD10 | GPIO_ODR_OD11 | GPIO_ODR_OD12);
}
