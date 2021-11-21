/*
 * MYLIB.h
 *
 *  Created on: Dec 6, 2020
 *      Author: koutakimura
 */


#ifndef MYLIB_H_
#define MYLIB_H_

/**-------------------------------------------------
 * include file
 * -------------------------------------------------*/
#include "stm32f429xx.h"
#include "stdbool.h"
#include "FUNCTION.h"
#include "LCD_SSD1306.h"
#include "PORT.h"

/**-------------------------------------------------
 * 要素数取得
 * -------------------------------------------------*/
#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))


/**-------------------------------------------------
 * システムクロック
 * -------------------------------------------------*/
#define SYSTEM_CLK (180 * 1000000)


/**-------------------------------------------------
 * PWMの分解能と、分解能に対応したシフト値を定義
 * -------------------------------------------------*/
#define PWM_RES  8
#define PWM_N	 256
#define PWM_SIZE (PWM_N-1)
#define ENV_RES  7


/**-------------------------------------------------
 * define
 * -------------------------------------------------
 * TIM2 16bit timer
 * スイッチのチャタリング除去と、5msアップカウンターとして使用
 *
 * TIM2: SYSTEM_CLK / (uint16_t)PSC_CLK = CLK
 * 		: 1 / CLK = timer
 * 		: timer * ARR = interupt
 *
 * * ------------------------------------------------
 * TIM3 16bit PWM timer
 * 音源生成用の割り込みタイマーとして使用
 *
 * TIM6: SYSTEM_CLK / 16 = 8000000
 * 		: 1 / 8000000  = 125ns
 * 		: 125 * 256    = 32.000us
 * 		: 周期32us = 周波数31.250kHz
 *
 * ------------------------------------------------
 * TIM7 16bit timer
 * 音源データ更新用の1msタイマーとして使用
 *
 * -------------------------------------------------*/
#define TIM2_PSC_CLK	(45000-1)
#define TIM2_ARR		(20-1)

#define TIM3_PSC_CLK (11-1)
#define TIM3_ARR		(PWM_N)

#define TIM7_PSC_CLK (45000-1)
#define TIM7_ARR		(4-1)


/*--------------------------------------------------
 - キー入力ビット
 ---------------------------------------------------*/
#define SW_BIT_SET		  0x01


/*--------------------------------------------------
 - 割り込み間隔
 - TM_INTERRUPTの値を変更すれば、タイマーカウントの値も切り替わる
 ---------------------------------------------------*/
#define TM_INTERRUPT	5


/*--------------------------------------------------
 - タイマーカウント1秒刻み
 ---------------------------------------------------*/
#define TM_200M_COUNT 	(200/TM_INTERRUPT)	//200m秒
#define TM_1SEC_COUNT 	(1000/TM_INTERRUPT)	//1秒
#define TM_2SEC_COUNT 	(TM_1SEC_COUNT*2)		//2秒
#define TM_3SEC_COUNT 	(TM_1SEC_COUNT*3)		//3秒
#define TM_10SEC_COUNT	(TM_1SEC_COUNT*10)	//10秒
#define TM_1MIN   		(TM_1SEC_COUNT*60)	//1分
#define TM_10MIN  		(TM_1MIN*10)			//10分
#define TM_60MIN  		(TM_1MIN*60)			//60分
#define MAX_TOTAL 		(TM_60MIN*24)			//1日


/*--------------------------------------------------
 - タイマーカウント1分刻み
 ---------------------------------------------------*/
#define MINUTS_1	1
#define MINUTS_3	3
#define MINUTS_10	10


/**-------------------------------------------------
 * 音源データID定義
 * -------------------------------------------------*/
#define START_BGM_ID 0
#define INADA	 		(START_BGM_ID)
#define KOUROU 		(START_BGM_ID + 1)
#define END_BGM_ID 	(KOUROU)


#endif
