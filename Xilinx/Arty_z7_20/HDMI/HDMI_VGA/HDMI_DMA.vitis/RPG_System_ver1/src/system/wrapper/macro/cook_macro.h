/*
 * Create 2021/08/15
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
 * 料理に関する定数を管理するヘッダーファイル
 */
#ifndef cook_macro_h   /* prevent circular inclusions */
#define cook_macro_h   /* by using protection macros */


/* 料理のID */
typedef enum
{
    COOK_ID_0,
    COOK_ID_1,
    COOK_ID_2,
    COOK_ID_3,
    COOK_ID_4,
    COOK_ID_5,
    COOK_ID_6,
    COOK_ID_NON,    //習得できていない
    COOK_ID_END,
} CookID;

/* 料理使用時の効果を判定するための定数 */
typedef enum
{
    COOK_TYPE_HEEL,             //固定回復
    COOK_TYPE_RATIO,            //割合回復
    COOK_TYPE_SP,               //SP回復
    COOK_TYPE_ALIVE,            //蘇生割合蘇生
    COOK_TYPE_HEEL_SP,          //HP・SP割合回復
    COOK_TYPE_HEEL_ALIVE,       //蘇生・HP割合回復
    COOK_TYPE_HEEL_SP_ALIVE,    //HP・SP割合回復、蘇生
    COOK_TYPE_NON,              //使っても効果はない
} CookTypeID;


/* 料理の最大数と最大レベル */
#define COOK_MAX        (20)
#define COOK_MENU_YMAX  (COOK_MAX - 1)
#define COOK_LEVEL_MAX  (4)

#endif
