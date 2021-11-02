#ifndef hero_macro_h   /* prevent circular inclusions */
#define hero_macro_h   /* by using protection macros */

/*
 * データベースアクセス用キャラクターID
 * 仲間データの参照時や配列のインデックス操作にはこの定数を使用する
 */
typedef enum
{
    HERO_MINORIKO,
    HERO_SIZUHA,
    HERO_KANAKO,
    HERO_KOGASA,
    HERO_YUUKA,
    HERO_REMIRIA,
    HERO_SATORI,
    HERO_TENSI,
    HERO_NUMBER,
} HeroBaseID;

/*
 * ver1. 2021/07/24
 * ダメージの倍率定数ID
 */
typedef enum
{
    DAMEGE_TYPE_STANDERD,
    DAMEGE_TYPE_LOW_HP,
    DAMEGE_TYPE_HIGH_HP,
    DAMEGE_TYPE_LOVE,
} BattlePowerTypeID;

/*
 * ver1. 2021/07/04
 * 各ステータスの最大値
 */
#define HP_MAX          (9999)
#define ATK_MAX         (255)
#define DEF_MAX         (255)
#define AGI_MAX         (255)
#define MAG_MAX         (255)
#define RES_MAX         (255)
#define LOVE_MAX        (100)
#define EXP_MAX         (99999999)
#define SP_BATTLE_MAX   (99)

/* 最大レベル */
#define LEVEL_MAX       (99)

/* 最大HPの桁数 */
#define HP_MAX_NUMBER   (4)

/* 仲間の習得特技数 */
#define SKILL_MAX       (10)

/* 仲間と敵のバトル最大人数 */
#define BATTLE_PATY_MAX     (4)
#define BATTLE_ENEMY_NUMBER (6)
#define BATTLE_TOTAL_NUMBER (BATTLE_PATY_NUMBER + BATTLE_ENEMY_NUMBER)

/* 仲間のステータス画面の最大移動数 */
#define PATY_MENU_YMAX      (4)

/* 装備メニューの最大描画数 */
#define MENU_LIST_NUMBER    (12)

#endif
