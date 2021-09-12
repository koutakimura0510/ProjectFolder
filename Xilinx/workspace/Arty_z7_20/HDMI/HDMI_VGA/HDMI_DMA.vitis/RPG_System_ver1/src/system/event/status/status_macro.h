/*
 * Create 2021/08/06
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
 * ステータス関連のマクロをまとめたヘッダーファイル
 */
#ifndef status_macro_h   /* prevent circular inclusions */
#define status_macro_h   /* by using protection macros */


/* ステータス補正を行うメンバ数 */
#define STATUS_FIT_NUM     (5)

/*
 * ver1. 2021/08/07
 * 各ステータスの最大上昇値と下降値
 */
#define MAX_STATUS_ENCHANT     (50)
#define MIN_STATUS_ENCHANT     (-50)

/*
 * ver1. 2021/08/07
 * 操作ステータス選択bit定数
 */
#define ATK_ENABLE_BIT  (0x00000001)
#define DEF_ENABLE_BIT  (0x00000002)
#define MAG_ENABLE_BIT  (0x00000004)
#define RES_ENABLE_BIT  (0x00000008)
#define AGI_ENABLE_BIT  (0x00000010)


/* 敵の下降 */
#define ALL_ENABLE_BIT  (ATK_ENABLE_BIT | DEF_ENABLE_BIT | RES_ENABLE_BIT | AGI_ENABLE_BIT | MAG_ENABLE_BIT)
#define SIL_ENABLE_BIT  (RES_ENABLE_BIT | DEF_ENABLE_BIT)

#endif
