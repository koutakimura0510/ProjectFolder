#ifndef mapchip_macro_h   /* prevent circular inclusions */
#define mapchip_macro_h   /* by using protection macros */


/**
 * @brief  アフィン変換に使用する対数を定義
 */
/* 最近傍補間の値 0.5 * 固定少数 * 10 */
#define NEAREST_FIX		((5 << FIX_POS_12) / 10)

/* 最近傍補間の値 0.5 * 固定少数 * 10 */
#define NEAREST_FIX_16	((5 << FIX_POS_16) / 10)	/* 回転用 */


/*
 * ミニゲームに使用するマップチップID
 */
#define MAPFILE_ACCESS_CHIP_MINIGAME_NULL    (0)
#define MAPFILE_ACCESS_CHIP_MINIGAME_GRASS   (1)
#define MAPFILE_ACCESS_CHIP_MINIGAME_BOMB1   (2)
#define MAPFILE_ACCESS_CHIP_MINIGAME_BOMB2   (3)


#endif
