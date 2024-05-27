/*
 * Create 2021/08/08
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
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
#ifndef res_macro_h   /* prevent circular inclusions */
#define res_macro_h   /* by using protection macros */

/*
 * 耐性、状態bit割り当て一覧
 *
 * 耐性と属性のbitは一致させる。
 * 計算の時に&のbit演算で判定や計算がしやすくなるためである。
 *
 * 0x0000_0001 斬耐性または属性
 * 0x0000_0002 打撃耐性または属性
 * 0x0000_0004 杖耐性または属性
 * 0x0000_0008 傘耐性または属性
 * 0x0000_0010 槍耐性または属性
 * 0x0000_0020 炎耐性または属性
 * 0x0000_0040 氷耐性または属性
 * 0x0000_0080 雷耐性または属性
 * 0x0000_0100 神耐性または属性
 * 0x0000_0200 地耐性または属性
 * 0x0000_0400 霊耐性または属性
 * 0x0000_0800 無耐性または属性
 * 0x0000_1000 こんらん耐性または属性
 * 0x0000_2000 毒耐性または属性
 * 0x0000_4000 石耐性または属性
 * 0x0000_8000 マヒ耐性または属性
 * 0x0001_0000 バーサク耐性または属性
 * 0x0002_0000 こんらん状態
 * 0x0004_0000 毒状態
 * 0x0008_0000 石状態
 * 0x0010_0000 マヒ状態
 * 0x0020_0000 バーサク状態
 * 0x0040_0000 リフレク状態
 */
#define R0      (0x00000001)    // 斬耐性 または属性
#define R1      (0x00000002)    // 打撃耐性 または属性
#define R2      (0x00000004)    // 杖耐性 または属性
#define R3      (0x00000008)    // 傘耐性 または属性
#define R4      (0x00000010)    // 槍耐性 または属性
#define R5      (0x00000020)    // 炎耐性 または属性
#define R6      (0x00000040)    // 氷耐性 または属性
#define R7      (0x00000080)    // 雷耐性 または属性
#define R8      (0x00000100)    // 神耐性 または属性
#define R9      (0x00000200)    // 地耐性 または属性
#define R10     (0x00000400)    // 霊耐性 または属性
#define R11     (0x00000800)    // 無耐性 または属性
#define R12     (0x00001000)    // こんらん耐性 または属性
#define R13     (0x00002000)    // 毒耐性 または属性
#define R14     (0x00004000)    // 石耐性 または属性
#define R15     (0x00008000)    // マヒ耐性 または属性
#define R16     (0x00010000)    // バーサク耐性 または属性
#define R17     (0x00020000)    // カリスマガード属性
#define R18     (0x00040000)    // リジェネ属性
#define RNO     (0)

/* 耐性ショートカット定義 */
#define TYPE_ALL    (R0 | R1 | R2 | R3 | R4)
#define BROW_ALL    (R1 | R3)
#define SLASH_ALL   (R0 | R4)
#define ATR_ALL     (R5 | R6 | R7 | R8 | R9 | R10)
#define CONDI_ALL   (R12 | R13 | R14 | R15 | R16)


/* 敵の耐性一覧定義 */
#define ENEMY_RES_1        (R1)
#define ENEMY_RES_2        (0)


#endif