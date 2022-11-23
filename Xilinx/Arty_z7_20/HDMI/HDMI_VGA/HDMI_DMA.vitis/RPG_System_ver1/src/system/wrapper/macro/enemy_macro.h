/*
 * Create 2021/07/23
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
 * エネミーデータに関する定数のデータをまとめたヘッダーファイル
 */
#ifndef enemy_macro_h   /* prevent circular inclusions */
#define enemy_macro_h   /* by using protection macros */


/* 1つのリージョンマスに対しての最大敵出現数 */
#define REGION_ENEMY_MAX_SIZE       (8)
#define REGION_FORMATION_MAX_SIZE   (4)
#define REGION_DRAW_MAX_POS_NUMBER  (6)


/*
 * ver1. 2021/07/23
 * バトル時の隊列に対応したエネミーの描画座標
 */
/* X座標 */
#define FORMATION_DRAW_XPOS_1_1     (140 << RGB_BYTE_SHIFT)
#define FORMATION_DRAW_XPOS_2_1     (60  << RGB_BYTE_SHIFT)
#define FORMATION_DRAW_XPOS_2_2     (170 << RGB_BYTE_SHIFT)
#define FORMATION_DRAW_XPOS_3_1     (60  << RGB_BYTE_SHIFT)
#define FORMATION_DRAW_XPOS_3_2     (170 << RGB_BYTE_SHIFT)
#define FORMATION_DRAW_XPOS_3_3     (60  << RGB_BYTE_SHIFT)
#define FORMATION_DRAW_XPOS_3_4     (170 << RGB_BYTE_SHIFT)
#define FORMATION_DRAW_XPOS_4_1     (60  << RGB_BYTE_SHIFT)
#define FORMATION_DRAW_XPOS_4_2     (120 << RGB_BYTE_SHIFT)
#define FORMATION_DRAW_XPOS_4_3     (170 << RGB_BYTE_SHIFT)
#define FORMATION_DRAW_XPOS_4_4     (120 << RGB_BYTE_SHIFT)
#define FORMATION_DRAW_XPOS_4_5     (60  << RGB_BYTE_SHIFT)
#define FORMATION_DRAW_XPOS_4_6     (40  << RGB_BYTE_SHIFT)

/* Y座標 */
#define FORMATION_Y_STANDERD        (150)
#define FORMATION_DRAW_YPOS_1_1     (FORMATION_Y_STANDERD * MAX_V_WIDTH)
#define FORMATION_DRAW_YPOS_2_1     (60  * MAX_V_WIDTH)
#define FORMATION_DRAW_YPOS_2_2     (FORMATION_Y_STANDERD * MAX_V_WIDTH)
#define FORMATION_DRAW_YPOS_3_1     (60  * MAX_V_WIDTH)
#define FORMATION_DRAW_YPOS_3_2     (60  * MAX_V_WIDTH)
#define FORMATION_DRAW_YPOS_3_3     (FORMATION_Y_STANDERD * MAX_V_WIDTH)
#define FORMATION_DRAW_YPOS_3_4     (FORMATION_Y_STANDERD * MAX_V_WIDTH)
#define FORMATION_DRAW_YPOS_4_1     (60  * MAX_V_WIDTH)
#define FORMATION_DRAW_YPOS_4_2     (60  * MAX_V_WIDTH)
#define FORMATION_DRAW_YPOS_4_3     (100 * MAX_V_WIDTH)
#define FORMATION_DRAW_YPOS_4_4     (FORMATION_Y_STANDERD * MAX_V_WIDTH)
#define FORMATION_DRAW_YPOS_4_5     (FORMATION_Y_STANDERD * MAX_V_WIDTH)
#define FORMATION_DRAW_YPOS_4_6     (100 * MAX_V_WIDTH)


/*
 * ver1. 2021/07/23
 * エネミーのサイズを定義
 */
typedef enum
{
    ENEMY_SIZE_1,
    ENEMY_SIZE_2,
    ENEMY_SIZE_3,
    ENEMY_SIZE_4,
    ENEMY_SIZE_5,
} FormationEnemySize;



/*
 * ver1. 2021/07/23
 * 戦闘時のエネミーの描画タイプを定義
 */
typedef enum
{
    FORMATION_TYPE_1,
    FORMATION_TYPE_2,
    FORMATION_TYPE_3,
    FORMATION_TYPE_4,
    FORMATION_TYPE_END,
} FormationTypeID;


/*
 * ver1. 2021/07/23
 * エネミーデータのID定数を定義
 */
typedef enum
{
    MONSTER_ID_NON,
    MONSTER_ID_1,
    MONSTER_ID_2,
    MONSTER_ID_END,
} EnemyDataID;


#endif
