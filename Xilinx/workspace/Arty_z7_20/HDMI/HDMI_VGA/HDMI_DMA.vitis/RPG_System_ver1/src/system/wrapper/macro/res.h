/*
 * Create 2021/08/08
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
 * 耐性、状態異常に関するデータをまとめたヘッダー
 */

#ifndef res_h   /* prevent circular inclusions */
#define res_h   /* by using protection macros */


/* 属性一覧 */
#define UNIT_RES_GOOD   (0x00000000)   // 正常
#define UNIT_RES_0      (0x00000001)    // 斬耐性
#define UNIT_RES_1      (0x00000002)    // 打撃耐性
#define UNIT_RES_2      (0x00000004)    // 杖耐性
#define UNIT_RES_3      (0x00000008)    // 傘耐性
#define UNIT_RES_4      (0x00000010)    // 槍耐性
#define UNIT_RES_5      (0x00000020)    // 炎耐性
#define UNIT_RES_6      (0x00000040)    // 氷耐性
#define UNIT_RES_7      (0x00000080)    // 雷耐性
#define UNIT_RES_8      (0x00000100)    // 神耐性
#define UNIT_RES_9      (0x00000200)    // 地耐性
#define UNIT_RES_10     (0x00000400)    // 霊耐性
#define UNIT_RES_11     (0x00000800)    // 無耐性
#define UNIT_RES_12     (0x00001000)    // こんらん耐性
#define UNIT_RES_13     (0x00002000)    // 毒耐性
#define UNIT_RES_14     (0x00004000)    // 石耐性
#define UNIT_RES_15     (0x00008000)    // マヒ耐性
#define UNIT_RES_16     (0x00010000)    // バーサク耐性
#define UNIT_RES_17     (0x00020000)    // ガード耐性
#define UNIT_RES_18     (0x00040000)    // リジェネ耐性


/* 状態異常一覧 */
typedef enum
{
    CONDITION_CURE_GOOD,     // 正常
    UNIT_CONDITION_CONFIG,   // こんらん状態
    UNIT_CONDITION_POISON,   // 毒状態
    UNIT_CONDITION_STONE,    // 石状態
    UNIT_CONDITION_PARARAI,  // マヒ状態
    UNIT_CONDITION_BERSEK,   // バーサク状態
    UNIT_CONDITION_RIFREK,   // カリスマガード状態
    UNIT_CONDITION_RIGENE,   // リジェネ状態
    UNIT_CONDITION_END,      // 
} ConditionBit;

#endif
