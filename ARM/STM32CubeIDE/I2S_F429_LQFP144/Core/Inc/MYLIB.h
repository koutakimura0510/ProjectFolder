/*
 * MYLIB.h
 *
 *  Created on: Dec 27, 2020
 *      Author: koutakimura
 */

#ifndef INC_MYLIB_H_
#define INC_MYLIB_H_

/**-------------------------------------------------
 * include file
 * -------------------------------------------------*/
#include "stm32f429xx.h"
#include "stdbool.h"
#include "FUNCTION.h"
#include "SSD1306.h"
#include "TFT.h"

/**-------------------------------------------------
 * 要素数取得
 * -------------------------------------------------*/
#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))


/**-------------------------------------------------
 * システムクロック
 * -------------------------------------------------*/
#define SYSTEM_CLK (180 * 1000000)


/**-------------------------------------------------
 * Timer 割り込み間隔計算用 define定義
 * -------------------------------------------------
 * TIM2 16bit timer
 * スイッチのチャタリング除去と、5msアップカウンターとして使用
 * ------------------------------------------------
 * TIM3 16bit timer
 * 音源生成用の割り込みタイマーとして使用
 * サンプリングレートの割り込み周期で設定
 * サンプリング周波数 44.1kHz
 * ------------------------------------------------
 * TIM7 16bit timer
 * 音源データ更新用の1msタイマーとして使用
 * -------------------------------------------------*/
#define TIM2_PSC_CLK	(45000-1)
#define TIM2_ARR		(20-1)

#define TIM3_PSC_CLK (20-1)
//#define TIM3_ARR		(563) // 8000Hz
//#define TIM3_ARR		(282) // 8000Hz
//#define TIM3_ARR		(102)  // 44100hz
#define TIM3_ARR		(188)  // 48000hz

#define TIM7_PSC_CLK (45000-1)
#define TIM7_ARR		(4-1)


/*--------------------------------------------------
 - キー入力ビット
 ---------------------------------------------------*/
#define SW_BIT_SET	0xe9
#define SW_PA0		0x01
#define SW_PA3		0x08
#define SW_PA5		0x20
#define SW_PA6		0x40
#define SW_PA7		0x80


/*--------------------------------------------------
 - 5msタイマーカウント用 define定義
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
 * FONTデータ定義
 * -------------------------------------------------*/
#define FONT12_W 10
#define FONT12_H 12
#define IDFONT12  0


#endif /* INC_MYLIB_H_ */
