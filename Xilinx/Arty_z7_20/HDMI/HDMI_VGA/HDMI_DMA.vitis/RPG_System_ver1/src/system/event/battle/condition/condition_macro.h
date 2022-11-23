/*
 * Create 2021/08/11
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * IC      XC7Z020-1CLG400C
 * ROM     256KB
 * RAM     512KB
 * L1Cache 32KB
 * -
 */

#ifndef condition_macro_h   /* prevent circular inclusions */
#define condition_macro_h   /* by using protection macros */


/* 状態異常のタイマー定数 */
#define POISON_TIMER 	(TM_5SEC_COUNT)		//毒のダメージを受ける時間
#define REGENE_TIMER 	(TM_200MS_COUNT)	//リジェネの回復時間
#define REGENE_COUNT	(50)				//リジェネの回復回数
#define CONDITION_TIMER	(TM_30SEC_COUNT)	//マヒの効果時間


/* 状態異常の状態遷移 */
typedef enum
{
	CONDITION_STATE_NULL,
	CONDITION_STATE_TIMER_SET,
	CONDITION_STATE_TIMER_COUNT,
} CondStateID;

#endif
