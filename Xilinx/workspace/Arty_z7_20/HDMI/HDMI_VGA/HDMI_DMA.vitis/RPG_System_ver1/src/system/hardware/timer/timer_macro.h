/*
 * ver1. 2021/08/25
 * FPGAのカウンターの値を取得し時間計測の計算に使用する定数をまとめたヘッダーファイル
 */

#ifndef timer_h   /* prevent circular inclusions */
#define timer_h   /* by using protection macros */


/*
 * FPGAのスイッチの入力値を取得
 */
#define GET_FPGA_SW     *((uint32_t *)XPAR_GPIO_0_BASEADDR)


/*
 * FPGAのカウンターの値を取得
 */
#define GET_FPGA_COUNT  *((uint32_t *)XPAR_GPIO_2_BASEADDR)


/*
 * CPU 666MHz
 * 
 * 666000000 * 5us = 3330
 */
#define TIMER_LOAD_VALUE (3330 / 2)


/*
 * FPGAのカウンターの速度
 * CLK 50us
 * 
 * 1 / 50us = 20000
 * 20000カウントで1秒
 */
#define FPGA_COUNT_CLK  ((uint32_t)20000)


/*
 * 秒カウンター
 */
#define TM_1SEC_COUNT 	((uint32_t)FPGA_COUNT_CLK)
#define TM_2SEC_COUNT 	((uint32_t)TM_1SEC_COUNT * 2)
#define TM_3SEC_COUNT 	((uint32_t)TM_1SEC_COUNT * 3)
#define TM_4SEC_COUNT 	((uint32_t)TM_1SEC_COUNT * 4)
#define TM_5SEC_COUNT 	((uint32_t)TM_1SEC_COUNT * 5)
#define TM_6SEC_COUNT 	((uint32_t)TM_1SEC_COUNT * 6)
#define TM_7SEC_COUNT 	((uint32_t)TM_1SEC_COUNT * 7)
#define TM_8SEC_COUNT 	((uint32_t)TM_1SEC_COUNT * 8)
#define TM_9SEC_COUNT 	((uint32_t)TM_1SEC_COUNT * 9)
#define TM_10SEC_COUNT	((uint32_t)TM_1SEC_COUNT * 10)
#define TM_20SEC_COUNT	((uint32_t)TM_1SEC_COUNT * 20)
#define TM_30SEC_COUNT	((uint32_t)TM_1SEC_COUNT * 30)


/*
 * 一日の計測時間
 *
 * MAX_TOTAL = 1日の経過時間
 * 20000 * 60 * 60 * 24 = 1728000000
 * 65536 * 65536 - 1    = 4294967295
 * 32bitの範囲に収める
 */
#define MAX_TOTAL 		((FPGA_COUNT_CLK * 60 * 60 * 24) - FPGA_COUNT_CLK)


/*
 * msカウンター
 */
#define TM_1MS_COUNT 	(TM_1SEC_COUNT / 1000)
#define TM_2MS_COUNT 	(TM_1MS_COUNT  * 2)
#define TM_3MS_COUNT 	(TM_1MS_COUNT  * 3)
#define TM_4MS_COUNT 	(TM_1MS_COUNT  * 4)
#define TM_5MS_COUNT 	(TM_1MS_COUNT  * 5)
#define TM_6MS_COUNT 	(TM_1MS_COUNT  * 6)
#define TM_7MS_COUNT 	(TM_1MS_COUNT  * 7)
#define TM_8MS_COUNT 	(TM_1MS_COUNT  * 8)
#define TM_9MS_COUNT 	(TM_1MS_COUNT  * 9)
#define TM_10MS_COUNT 	(TM_1MS_COUNT  * 10)
#define TM_15MS_COUNT 	(TM_1MS_COUNT  * 15)
#define TM_20MS_COUNT 	(TM_1MS_COUNT  * 20)
#define TM_25MS_COUNT 	(TM_1MS_COUNT  * 25)
#define TM_30MS_COUNT 	(TM_1MS_COUNT  * 30)
#define TM_35MS_COUNT 	(TM_1MS_COUNT  * 35)
#define TM_40MS_COUNT 	(TM_1MS_COUNT  * 40)
#define TM_45MS_COUNT 	(TM_1MS_COUNT  * 45)
#define TM_50MS_COUNT 	(TM_1MS_COUNT  * 50)
#define TM_55MS_COUNT 	(TM_1MS_COUNT  * 55)
#define TM_60MS_COUNT 	(TM_1MS_COUNT  * 60)
#define TM_70MS_COUNT 	(TM_1MS_COUNT  * 70)
#define TM_80MS_COUNT 	(TM_1MS_COUNT  * 80)
#define TM_90MS_COUNT 	(TM_1MS_COUNT  * 90)
#define TM_100MS_COUNT 	(TM_1MS_COUNT  * 100)
#define TM_150MS_COUNT 	(TM_1MS_COUNT  * 150)
#define TM_200MS_COUNT 	(TM_1MS_COUNT  * 200)
#define TM_300MS_COUNT 	(TM_1MS_COUNT  * 300)
#define TM_400MS_COUNT 	(TM_1MS_COUNT  * 400)
#define TM_500MS_COUNT 	(TM_1MS_COUNT  * 500)
#define TM_600MS_COUNT 	(TM_1MS_COUNT  * 600)
#define TM_700MS_COUNT 	(TM_1MS_COUNT  * 700)
#define TM_800MS_COUNT 	(TM_1MS_COUNT  * 800)
#define TM_900MS_COUNT 	(TM_1MS_COUNT  * 900)


/*
 * usカウンター
 */
#define TM_50US_COUNT 	(TM_1SEC_COUNT / 20000)
#define TM_100US_COUNT 	(TM_50US_COUNT  * 2)
#define TM_150US_COUNT 	(TM_50US_COUNT  * 3)
#define TM_200US_COUNT 	(TM_50US_COUNT  * 4)
#define TM_250US_COUNT 	(TM_50US_COUNT  * 5)
#define TM_300US_COUNT 	(TM_50US_COUNT  * 6)
#define TM_350US_COUNT 	(TM_50US_COUNT  * 7)
#define TM_400US_COUNT 	(TM_50US_COUNT  * 8)
#define TM_450US_COUNT 	(TM_50US_COUNT  * 9)
#define TM_500US_COUNT 	(TM_50US_COUNT  * 10)
#define TM_550US_COUNT 	(TM_50US_COUNT  * 11)
#define TM_600US_COUNT 	(TM_50US_COUNT  * 12)
#define TM_650US_COUNT 	(TM_50US_COUNT  * 13)
#define TM_700US_COUNT 	(TM_50US_COUNT  * 14)
#define TM_750US_COUNT 	(TM_50US_COUNT  * 15)
#define TM_800US_COUNT 	(TM_50US_COUNT  * 16)
#define TM_850US_COUNT 	(TM_50US_COUNT  * 17)
#define TM_900US_COUNT 	(TM_50US_COUNT  * 18)
#define TM_950US_COUNT 	(TM_50US_COUNT  * 19)


#endif
