#ifndef unit_event_macro_h   /* prevent circular inclusions */
#define unit_event_macro_h   /* by using protection macros */


/*
 * 座標判定を行わない場合指定
 */
#define POSITION_NULL   (0)


/*
 * キャラクター毎のチップの切り取り開始番号
 */
#define CUT_FILE_ACCESS_HERO_CHIP   (3)
#define MAPCHIP_MINORIKO            (0  * CUT_FILE_ACCESS_HERO_CHIP)
#define MAPCHIP_SIZUHA		        (1  * CUT_FILE_ACCESS_HERO_CHIP)
#define MAPCHIP_SATORI		        (2  * CUT_FILE_ACCESS_HERO_CHIP)
#define MAPCHIP_TENSI		        (3  * CUT_FILE_ACCESS_HERO_CHIP)
#define MAPCHIP_REMIRIA		        (16 * CUT_FILE_ACCESS_HERO_CHIP)
#define MAPCHIP_YUUKA		        (17 * CUT_FILE_ACCESS_HERO_CHIP)
#define MAPCHIP_KANAKO		        (18 * CUT_FILE_ACCESS_HERO_CHIP)
#define MAPCHIP_KOGASA		        (19 * CUT_FILE_ACCESS_HERO_CHIP)


/*
 * 上下左右のキャラクターの歩行モーション切り取り座標位置
 */
#define UNIT_CUT_DOWN           (0)
#define UNIT_CUT_LEFT           (12)
#define UNIT_CUT_RIGHT          (24)
#define UNIT_CUT_UP             (36)


/*
 * スイッチのbit位置
 */
#define SW_RIGHT        (0x10)
#define SW_LEFT         (0x08)
#define SW_UP           (0x04)
#define SW_DOWN         (0x02)
#define SW_A            (0x20)
#define SW_B            (0x01)
#define SW_AB           (SW_A | SW_B)
#define SW_DIR_BIT      (SW_RIGHT | SW_LEFT | SW_UP | SW_DOWN)
#define SW_UP_DOWN      (SW_UP | SW_DOWN)
#define SW_RIGHT_LEFT   (SW_LEFT | SW_RIGHT)
#define SW_A_RIGHT      (SW_A | SW_RIGHT)
#define SW_A_LEFT       (SW_A | SW_LEFT)
#define SW_A_UP         (SW_A | SW_UP)
#define SW_A_DOWN       (SW_A | SW_DOWN)
#define SW_B_RIGHT      (SW_B | SW_RIGHT)
#define SW_B_LEFT       (SW_B | SW_LEFT)
#define SW_B_UP         (SW_B | SW_UP)
#define SW_B_DOWN       (SW_B | SW_DOWN)


/*
 * キャラクターの現在の進行方向
 */
typedef enum
{
    DIR_WAIT  = 0x00,
    DIR_RIGHT = SW_RIGHT,
    DIR_LEFT  = SW_LEFT,
    DIR_UP    = SW_UP,
    DIR_DOWN  = SW_DOWN,
} UnitDir;


/*
 * キャラクターのアニメーションの動作状態
 */
typedef enum
{
    UNIT_WORK_TYPE_LEFT,
    UNIT_WORK_TYPE_CENTER,
    UNIT_WORK_TYPE_RIGHT,
    UNIT_WALK_TYPE_NUM,
} WorkType;


#endif