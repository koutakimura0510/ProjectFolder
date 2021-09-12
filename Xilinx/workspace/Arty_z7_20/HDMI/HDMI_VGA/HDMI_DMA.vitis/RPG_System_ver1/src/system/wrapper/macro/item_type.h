/*
 * Create 2021/07/10
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
 * アイテム、装備に関する定数を管理するヘッダーファイル
 */

#ifndef item_type_h   /* prevent circular inclusions */
#define item_type_h   /* by using protection macros */

/*
 * ver1. 2021/07/10
 * バトル中に使用するアイテムのタイプを宣言
 */
typedef enum
{
    ITEM_TYPE_HEEL,         //体力固定回復
    ITEM_TYPE_HEEL_RATIO,   //体力割合回復
    ITEM_TYPE_RECOVER,      //状態異常回復
    ITEM_TYPE_ALIVE,        //蘇生
    ITEM_TYPE_SP,           //SP回復
    ITEM_TYPE_SP_RATIO,     //SP回復
    ITEM_TYPE_ENCHANT,      //ステータス補正
    ITEM_TYPE_CONDITION,    //状態異常
    ITEM_TYPE_ESCAPE,       //必ず逃走
} ItemType;


/*
 * ver1. 2021/07/11
 * アイテムを使用、武器防具を使用可能な仲間のbitを定義
 * 
 * 仲間が8人のため、bit検出で判定を行うようにした
 */
#define I_MINO    (0x01)
#define I_SIZU    (0x02)
#define I_KANA    (0x04)
#define I_KOGA    (0x08)
#define I_YUKA    (0x10)
#define I_REMY    (0x20)
#define I_SATO    (0x40)
#define I_TENK    (0x80)

/* 武器装備可能者定数 */
#define EQUIP_HERO_SWORD    (I_MINO | I_TENK | I_KOGA)
#define EQUIP_HERO_SHORT    (I_MINO | I_SIZU | I_SATO | I_KANA | I_KOGA)
#define EQUIP_HERO_SPEAR    (I_REMY | I_KOGA)
#define EQUIP_HERO_HAMMER   (I_MINO | I_KANA | I_KOGA)
#define EQUIP_HERO_UMBRELLA (I_YUKA | I_REMY | I_KOGA)
#define EQUIP_HERO_ROD      (I_SIZU | I_SATO | I_YUKA)
#define EQUIP_HERO_ALL      (0xff)


/* 防具装備可能者定数 */
#define EQUIP_HERO_HAT      (EQUIP_HERO_ALL)
#define EQUIP_HERO_RIBBON   (I_MINO | I_SIZU | I_SATO | I_KOGA)
#define EQUIP_HERO_CLIP     (EQUIP_HERO_ALL)
#define EQUIP_HERO_CROWN    (I_TENK | I_REMY)


#endif
