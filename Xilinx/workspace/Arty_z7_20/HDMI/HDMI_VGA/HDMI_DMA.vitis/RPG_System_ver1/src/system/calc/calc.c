/*
 * Create 2021/06/27
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
 * 数値処理をまとめたファイル
 */

#include "../wrapper/game_wrapper.h"


/* TODO できたらinline化にする
 *
 * ver1. 2021/08/04
 * 引数の値が等しいか判定しbool値を取得
 */
bool isCompareTo(uint32_t num1, uint32_t num2)
{
	return (num1 == num2) ? true : false;
}

/*
 * ver1. 2021/07/29
 * 引数の数値の桁数を数える関数
 */
uint32_t digit_count(uint32_t number)
{
	uint8_t count = 0;

	do
	{
		count++;
		number /= 10;
	} while (number != 0);

	return count;
}


/*
 * ver1. 2021/06/27
 * bitが立っている個所を検出し個数を取得
 */
uint32_t bit_count(uint32_t bits)
{
	bits = (bits & 0x55555555) + (bits >>  1 & 0x55555555);
	bits = (bits & 0x33333333) + (bits >>  2 & 0x33333333);
	bits = (bits & 0x0f0f0f0f) + (bits >>  4 & 0x0f0f0f0f);
	bits = (bits & 0x00ff00ff) + (bits >>  8 & 0x00ff00ff);

	return (bits & 0x0000ffff) + (bits >> 16 & 0x0000ffff);
}


/*
 * 疑似乱数生成
 *
 * 引数に応じて疑似乱数値を取得
 */
uint32_t xorshift(uint32_t seed)
{
    seed ^= (seed << 13);
    seed ^= (seed >> 17);
    seed ^= (seed << 5);

    return seed;
}


/*
 * ver1. 2021/08/12
 * バトル時の逃走の成功判定の取得
 */
bool isEscape(void)
{
	uint8_t bit = (xorshift(get_time()) & MAX_8BIT) >> 1;

	return isMaximam(bit, MAX_4BIT);
}


/*
 * ver1. 2021/07/31
 * 2の乗数 - 1の範囲のランダム値を補正した値を取得
 * 
 * (seed値 + 1) >> 1 
 * 0	1		0
 * 1	10		1
 * 10	11		1
 * 11	100		2
 * 100	101		2
 * 101	110		3
 * 110	111		3
 * 111	1000	4
 */
uint32_t get_rand(uint32_t seed)
{
	return ((xorshift(get_time()) & seed) + 1) >> 1;
}


/*
 * ver1. 2021/08/18
 * 引数で指定した値までのパーセント値を取得
 * 
 * 0 ~ 254%の値を取得可能
 * 
 * 100%を指定する場合は101を指定
 */
uint8_t get_percent(uint8_t seed)
{
	return xorshift(get_time()) % seed;
}