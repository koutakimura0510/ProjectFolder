#ifndef calc_h   /* prevent circular inclusions */
#define calc_h   /* by using protection macros */

/* 各型の最大値 */
#define MAX_4BIT	(0x7f)
#define MAX_8BIT	(0xff)
#define MAX_16BIT	(0xffff)
#define MAX_32BIT	(0xffffffff)

/* 固定少数計算 */
#define fix_num(com, power) ((com / DIG_3_FIX) * power)

/* 最低値でなければnumの値を減算 */
#define min_sub(num, com)	(num != com ? num-- : num)

/* 最大値でなければnumの値を加算 */
#define max_add(num, com)	(num != com ? num++ : num)

/* a が b より小さければtrue*/
#define isMaximam(a, b)     ((a < b) ? true : false)

/*
 * ver1. 2021/08/11
 * 座標データをDRAMの4byteの規格に修正する
 * 
 * マクロ定数の中で計算を行う場合は XRGB((a - b))の様にカッコ()で式を囲む
 */
#define XRGB(x)	(int32_t)(x << RGB_BYTE_SHIFT)
#define YRGB(y)	(int32_t)(y * MAX_V_WIDTH)

/* Width、Heightの中央をもとめる、DRAMの仕様上中央値にバイト分の計算を行う */
#define W_CENTER(x)			(int32_t)((x >> 1) << RGB_BYTE_SHIFT)
#define H_CENTER(y)			(int32_t)((y >> 1) * MAX_V_WIDTH)

/* マップチップのサイズ調整のシフト動作 */
#define CHIP_RGB(pos)		(uint32_t)(pos << MAPCHIP_WIDTH_SHIFT)//MAPCHIP_HEIGHT_SHIFと同義
#define CHIP_LEFT(pos)		(uint32_t)(pos >> MAPCHIP_SHIFT)

#define CHIP_ADDR_SHIFT(pos) (int32_t)(pos << MAPCHIP_WIDTH_SHIFT) //MAPCHIP_HEIGHT_SHIFと同義、負の演算version


/* 画面のサイズや座標を求める基本計算 */
#define DISPLAY_POS(x, y, size) (x + (y * size))
#define DISPLAY_YPOS(y, size) (y * size)
#define DISPLAY_FLASH_RANGE(y, size) (y * size)



/* 固定少数 */
#define DIG_4_FIX	(1000)
#define DIG_3_FIX	(100)
#define DIG_2_FIX	(10)
#define DIG_FIX_12	(4096)
#define FIX_POS_12	(12)
#define FIX_16		(65536)
#define FIX_POS_16	(16)


/* パーセント計算用定数 */
#define DIG_10	(10)
#define DIG_20	(20)
#define DIG_30	(30)
#define DIG_40	(40)
#define DIG_50	(50)
#define DIG_60	(60)
#define DIG_70	(70)
#define DIG_80	(80)
#define DIG_90	(90)
#define DIG_100	(100)


#endif
