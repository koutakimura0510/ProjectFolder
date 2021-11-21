/*
 * PORT.h
 *
 *  Created on: Dec 20, 2020
 *      Author: koutakimura
 */
/*
  * --SW--
  * PORTA PA0
  *
  * --PWM--
  * PORTA PA7
  *
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
  * --
  * PORTA PA3 PA4 PA6 PA11 PA12
  * PORTB PB0 PB1 PB8 PB9 PB10 PB11
  * PORTC PC2 PC6 PC7 PC10
  * PORTD PD3 PD6 PD11 PD12 PD13
  * PORTF PF7
  * PORTG PG6 PG7 PG10 PG11 PG12
  */
#ifndef INC_PORT_H_
#define INC_PORT_H_

#define DCX(DC) GPIOF->ODR = DC
#define RDX(RD) GPIOD->ODR = RD
#define WRX(WR) GPIOD->ODR = WR

//#define ADCCS(ADCCS) PORT7.PODR.BIT.B4 = ADCCS
//#define ADRDY() PORT7.PODR.BIT.B5


#endif /* INC_PORT_H_ */
