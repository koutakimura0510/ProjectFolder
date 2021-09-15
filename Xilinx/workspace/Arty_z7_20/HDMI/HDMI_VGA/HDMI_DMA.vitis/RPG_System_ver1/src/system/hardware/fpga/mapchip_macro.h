#ifndef mapchip_macro_h   /* prevent circular inclusions */
#define mapchip_macro_h   /* by using protection macros */


/**
 * @brief  アフィン変換に使用する対数を定義
 */
/* 最近傍補間の値 0.5 * 固定少数 * 10 */
#define NEAREST_FIX		((5 << FIX_POS_12) / 10)

/* 最近傍補間の値 0.5 * 固定少数 * 10 */
#define NEAREST_FIX_16	((5 << FIX_POS_16) / 10)	/* 回転用 */

/* アフィン変換の回転時の1回転を判定する定数 */
#define AFFINE_RAD_1	(359)

#endif
