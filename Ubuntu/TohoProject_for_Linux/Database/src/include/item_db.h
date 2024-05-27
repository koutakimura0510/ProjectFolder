/*
 * Create 2021/07/06
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * -
 * アイテムと装備に関するデータベースを管理するヘッダーファイル
 */

#ifndef item_db_h   /* prevent circular inclusions */
#define item_db_h   /* by using protection macros */


/*
 * アイテムメッセージ取得
 */
#include "macro/item_msg_macro.h"


/*
 * 構造体の要素数
 */
#define ITEM_DB_SIZE	  ((sizeof (item_db))   / (sizeof (ItemDB)))
#define WEAPON_DB_SIZE	  ((sizeof (weapon_db)) / (sizeof (WeaponDB)))
#define ARMOR_DB_SIZE	  ((sizeof (armor_db))  / (sizeof (ArmorDB)))
#define AMULET_DB_SIZE	  ((sizeof (amulet_db)) / (sizeof (AmuletDB)))


/*
 * ver1. 2021/07/10
 * バトルに使用するアイテムに関するデータベース
 * 
 * id           アイテムID
 * atb_timer    atb更新時間
 * wait_time    仕様確定時からの待機時間
 * anime_id     エフェクトアニメーションのIDを指定
 * range        アイテムの使用範囲
 * use_type     アイテムの使用効果
 * power        回復系なら回復量を指定、エンチャント系ならbitを指定
 * name         アイテム名
 * msg          アイテムの説明
 */
typedef struct item_db
{
    uint32_t id;
    uint32_t atb_timer;
	uint32_t wait_time;
    uint32_t anime_id;
    uint8_t range;
    uint8_t use_type;
    uint32_t power;
    const char *name;
    const char *msg;
} ItemDB;

static const ItemDB item_db[] =
{
    {ITEM_NON,                          0, TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,               0,         0,    "しまう",                     "アイテムなんぞ使ってんじゃねぇ！",},
    {ITEM_DANGO,           TM_100MS_COUNT, TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,  ITEM_TYPE_HEEL,       200,    "甘味処の団子",               ITEM_MSG0,},
    {ITEM_SASADANGO,       TM_200MS_COUNT, TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,  ITEM_TYPE_HEEL,       500,    "甘味処の笹団子",             ITEM_MSG1,},
    {ITEM_OUGONDANGO,      TM_300MS_COUNT, TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,  ITEM_TYPE_HEEL,      1500,    "甘味処の黄金団子",           ITEM_MSG2,},
    {ITEM_GENSOUDANGO,     TM_400MS_COUNT, TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,  ITEM_TYPE_HEEL,      5000,    "甘味処の幻想団子",           ITEM_MSG3,},
    {ITEM_ARISU_COOKEI_1,  TM_200MS_COUNT, TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,  ITEM_TYPE_HEEL_RATIO,  30,    "アリスの黒炭クッキー",       ITEM_MSG4,},
    {ITEM_ARISU_COOKEI_2,  TM_300MS_COUNT, TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,  ITEM_TYPE_HEEL_RATIO,  40,    "アリスの義理クッキー",       ITEM_MSG5,},
    {ITEM_ARISU_COOKEI_3,  TM_500MS_COUNT, TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,  ITEM_TYPE_HEEL_RATIO,  60,    "アリスの本命クッキー",       ITEM_MSG6,},
    {ITEM_MARISA_KINOKO,   TM_100MS_COUNT, TM_1SEC_COUNT, A_ESNA_1,     E_SINGLE,  ITEM_TYPE_CONDITION,    0,    "魔法の森産テングダケ",       ITEM_MSG7,},
    {ITEM_YAGOKORODORINKU, TM_200MS_COUNT, TM_1SEC_COUNT, A_RISE_1,     E_SINGLE,  ITEM_TYPE_ALIVE,       10,    "八意ドリンク",               ITEM_MSG8,},
    {ITEM_HOURAIDORINK,    TM_900MS_COUNT, TM_1SEC_COUNT, A_RISE_1,     E_ALL,     ITEM_TYPE_ALIVE,        1,    "蓬莱ドリンク",               ITEM_MSG9,},
    {ITEM_HAKUREI_DOBU,    TM_100MS_COUNT, TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,  ITEM_TYPE_SP,          10,    "博麗印のどぶ水",              ITEM_MSG10,},
    {ITEM_HAKUREI_IDO,     TM_300MS_COUNT, TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,  ITEM_TYPE_SP,          20,    "博麗印の井戸水",              ITEM_MSG11,},
    {ITEM_HAKUREI_WATER,   TM_500MS_COUNT, TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,  ITEM_TYPE_SP,          40,    "博麗印の天然水",              ITEM_MSG12,},
    {ITEM_HAKUREI_GOD,     TM_700MS_COUNT, TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,  ITEM_TYPE_SP,          99,    "博麗印のお神酒",              ITEM_MSG13,},
    {ITEM_KAPPA_SIELD,     TM_200MS_COUNT, TM_1SEC_COUNT, A_DEF_1,      E_SINGLE,  ITEM_TYPE_ENCHANT,      0,    "光学迷彩・物",                ITEM_MSG14,},
    {ITEM_KAPPA_MAGIC,     TM_200MS_COUNT, TM_1SEC_COUNT, A_RES_1,      E_SINGLE,  ITEM_TYPE_ENCHANT,      0,    "光学迷彩・魔",                ITEM_MSG15,},
    {ITEM_SANAE_OMAMORI,   TM_800MS_COUNT, TM_1SEC_COUNT, A_REMIRIA_7,  E_SINGLE,  ITEM_TYPE_CONDITION,    0,    "早苗のお守り",                ITEM_MSG16,},
    {ITEM_SEIZYA_ESCAPE,   TM_10MS_COUNT,  TM_1SEC_COUNT, A_HEAL_1,     E_SINGLE,  ITEM_TYPE_ESCAPE,       0,    "お尋ね者はご用心",            ITEM_MSG17,},
    {ITEM_ONI_POWER,       TM_500MS_COUNT, TM_1SEC_COUNT, A_POWER_UP_1, E_SINGLE,  ITEM_TYPE_ENCHANT,      0,    "鬼神の怪力薬",                ITEM_MSG18,},
    {ITEM_ONI_SYURAN,      TM_500MS_COUNT, TM_1SEC_COUNT, A_BERSEK_1,   E_SINGLE,  ITEM_TYPE_CONDITION,    0,    "伊吹瓢",                      ITEM_MSG19,},
    {ITEM_NOT_FOUND,                        0,              0,          0,         0,                    0,    0,    "？？？？？？",                 ITEM_FOUND,},
};



/*
 * ver1. 2021/07/10
 * 武器情報を管理するデータベース
 * 
 * id               武器ID
 * atk              攻撃力
 * effect_type      武器の効果ID
 * effect_draw_id   攻撃時の描画データID
 * equip_hero       装備可能な仲間、1byteのbitで管理
 * buy              店買値  0の時は店購入ではない
 * cell             店売値  0の時は売ることはできない
 * name             武器名
 */
typedef struct weapon_db
{
    uint8_t  id;
    uint8_t  atk;
    uint32_t effect_draw_id;
    uint8_t  equip_hero;
    uint32_t buy;
    uint32_t cell;
    const char *name;
    const char *msg;
} WeaponDB;

static const WeaponDB weapon_db[] =
{
    {WEAPON_NON,                   0,   E_BRAW_1,      EQUIP_HERO_ALL,         0,      0,       "すで",                         "信じるのは己の力のみ"},
    {WEAPON_SWORAD_TETU,          12,   E_SLASH_1,     EQUIP_HERO_SWORD,      10,      3,       "鉄の剣",                       WEAPON_MSG0},
    {WEAPON_SWORAD_BEND,          15,   E_SLASH_1,     EQUIP_HERO_SWORD,      15,      5,       "曲剣",                         WEAPON_MSG1},
    {WEAPON_SWORAD_RONG,          20,   E_SLASH_1,     EQUIP_HERO_SWORD,      20,      6,       "ロングソード",                 WEAPON_MSG2},
    {WEAPON_SWORAD_SILBER,        25,   E_SLASH_1,     EQUIP_HERO_SWORD,      30,     10,       "シルバーソード",               WEAPON_MSG3},
    {WEAPON_SWORAD_HONOO,         35,   E_SLASH_1,     EQUIP_HERO_SWORD,      60,     20,       "炎の剣",                       WEAPON_MSG4},
    {WEAPON_SWORAD_HISOUKEN,      50,   E_SLASH_1,     I_TENK,                 0,      0,       "緋想の剣",                     WEAPON_MSG5},
    {WEAPON_SWORAD_GOURYUU,       60,   E_SLASH_1,     EQUIP_HERO_SWORD,       0,     70,       "剛竜剣",                       WEAPON_MSG6},
    {WEAPON_SWORAD_MANAMUNE,      70,   E_SLASH_1,     EQUIP_HERO_SWORD,     200,     60,       "マサムネ",                     WEAPON_MSG7},
    {WEAPON_SWORAD_MURAMASA,      70,   E_SLASH_1,     EQUIP_HERO_SWORD,     200,     60,       "ムラマサ",                     WEAPON_MSG8},
    {WEAPON_SWORAD_ZANTETRU,       5,   E_SLASH_1,     I_KOGA,                 0,      0,       "神魔おどろけまる",              WEAPON_MSG9},
    {WEAPON_SWORAD_SIN_HISOUKEN,  10,   E_SLASH_1,     I_TENK,                 0,      0,       "真・緋想の剣",                 WEAPON_MSG10},
    {WEAPON_SHORT_SHORT,           6,   E_SLASH_1,     EQUIP_HERO_SHORT,       8,      2,       "ナイフ",                       WEAPON_MSG11},
    {WEAPON_SHORT_BATER,           9,   E_SLASH_1,     EQUIP_HERO_SHORT,      13,      4,       "バターナイフ",                 WEAPON_MSG12},
    {WEAPON_SHORT_POIZUN,         13,   E_SLASH_1,     EQUIP_HERO_SHORT,       0,     15,       "ポイズンダガー",               WEAPON_MSG13},
    {WEAPON_SHORT_ASSASSIN,       16,   E_SLASH_1,     EQUIP_HERO_SHORT,      30,      6,       "アサシンダガー",               WEAPON_MSG14},
    {WEAPON_SHORT_KILLER,         20,   E_SLASH_1,     EQUIP_HERO_SHORT,       0,     20,       "キラーナイフ",                 WEAPON_MSG15},
    {WEAPON_SHORT_ICE,            23,   E_SLASH_1,     EQUIP_HERO_SHORT,      30,      6,       "アイスナイフ",                 WEAPON_MSG16},
    {WEAPON_SHORT_SARAMANDER,     26,   E_SLASH_1,     EQUIP_HERO_SHORT,      60,     20,       "サラマンダー",                 WEAPON_MSG17},
    {WEAPON_SWORAD_DRAGON,        38,   E_SLASH_1,     EQUIP_HERO_SHORT,     220,     70,       "ドラゴンキラー",               WEAPON_MSG18},
    {WEAPON_SHORT_HURAGA,         50,   E_SLASH_1,     EQUIP_HERO_SHORT,       0,     60,       "フラガラッハ",                 WEAPON_MSG19},
    {WEAPON_SHORT_KURONOS,        60,   E_SLASH_1,     EQUIP_HERO_SHORT,       0,    250,       "クロノスエッジ",               WEAPON_MSG20},
    {WEAPON_SWORAD_ALTEMA,        10,   E_SLASH_1,     I_SIZU,                 0,      0,       "神刀紅葉おろし",               WEAPON_MSG21},
    {WEAPON_SPEAR_NIGHT,          14,   E_SLASH_1,     EQUIP_HERO_SPEAR,      20,      6,       "ナイトスピア",                 WEAPON_MSG22},
    {WEAPON_SPEAR_SILBER,         25,   E_SLASH_1,     EQUIP_HERO_SPEAR,      30,     10,       "シルバースピア",               WEAPON_MSG23},
    {WEAPON_SPEAR_TRIDENT,        32,   E_SLASH_1,     EQUIP_HERO_SPEAR,       0,     20,       "トライデント",                 WEAPON_MSG24},
    {WEAPON_SPEAR_RAIZIN,         36,   E_SLASH_1,     EQUIP_HERO_SPEAR,       0,     20,       "雷神槍",                       WEAPON_MSG25},
    {WEAPON_SPEAR_HONOO,          42,   E_SLASH_1,     EQUIP_HERO_SPEAR,      70,     20,       "炎の槍",                       WEAPON_MSG26},
    {WEAPON_SPEAR_DEAMON,         52,   E_SLASH_1,     EQUIP_HERO_SPEAR,       0,     40,       "デーモンスピア",               WEAPON_MSG27},
    {WEAPON_SPEAR_KING,           62,   E_SLASH_1,     EQUIP_HERO_SPEAR,       0,     50,       "海龍王の槍",                   WEAPON_MSG28},
    {WEAPON_SPEAR_TRISHULA,       74,   E_SLASH_1,     EQUIP_HERO_SPEAR,     250,     70,       "トリシューラ",                 WEAPON_MSG29},
    {WEAPON_SPEAR_LONGINUS,       95,   E_SLASH_1,     EQUIP_HERO_SPEAR,       0,    100,       "ロンギヌス",                   WEAPON_MSG30},
    {WEAPON_SPEAR_GAEBOLGA,       15,   E_SLASH_1,     EQUIP_HERO_SPEAR,       0,    220,       "ゲイボルグ",                   WEAPON_MSG31},
    {WEAPON_SPEAR_THE_GUNGNIR,    30,   E_SLASH_1,     I_REMY,                 0,      0,       "レミ嬢・ざ・ぐんぐにる",        WEAPON_MSG32},
    {WEAPON_KODUTI,               10,   E_BRAW_1,      EQUIP_HERO_HAMMER,     12,      4,       "こづち",                       WEAPON_MSG33},
    {WEAPON_KODUTI_MORI,          17,   E_BRAW_1,      EQUIP_HERO_HAMMER,      0,      8,       "森のハンマー",                 WEAPON_MSG34},
    {WEAPON_KODUTI_DAITI,         23,   E_BRAW_1,      EQUIP_HERO_HAMMER,     25,     10,       "大地のハンマー",               WEAPON_MSG35},
    {WEAPON_KODUTI_HUGOU,         30,   E_BRAW_1,      EQUIP_HERO_HAMMER,      0,     50,       "こがねもち",                   WEAPON_MSG36},
    {WEAPON_KODUTI_KOORI,         33,   E_BRAW_1,      EQUIP_HERO_HAMMER,     30,     10,       "アイスハンマー",               WEAPON_MSG37},
    {WEAPON_KODUTI_HONOO,         38,   E_BRAW_1,      EQUIP_HERO_HAMMER,     70,     20,       "ファイアーハンマー",           WEAPON_MSG38},
    {WEAPON_KODUTI_KAMIGOROSI,    44,   E_BRAW_1,      EQUIP_HERO_HAMMER,      0,      1,       "かみごろし",                   WEAPON_MSG39},
    {WEAPON_KODUTI_TORL,          54,   E_BRAW_1,      EQUIP_HERO_HAMMER,      0,     35,       "トールハンマー",               WEAPON_MSG40},
    {WEAPON_KODUTI_TOUMOKOROSI,   62,   E_BRAW_1,      I_MINO,                 0,      5,       "とうもごろし",                 WEAPON_MSG41},
    {WEAPON_KODUTI_DANZAI,        72,   E_BRAW_1,      EQUIP_HERO_HAMMER,    230,     70,       "断罪の鉄槌",                   WEAPON_MSG42},
    {WEAPON_KODUTI_GIANT,         90,   E_BRAW_1,      EQUIP_HERO_HAMMER,      0,    100,       "ギガントハンマー",             WEAPON_MSG43},
    {WEAPON_KODUTI_UTIDENO,       15,   E_BRAW_1,      I_MINO,                 0,      0,       "豊穣神のこづち",               WEAPON_MSG44},
    {WEAPON_KODUTI_ONBASIRA,      25,   E_BRAW_1,      I_KANA,                 0,      0,       "ゴッドオブオンバシラ",         WEAPON_MSG45},
    {WEAPON_UMBRELLA_SUN,          8,   E_SLASH_1,     EQUIP_HERO_UMBRELLA,   15,      5,       "日傘",                         WEAPON_MSG46},
    {WEAPON_UMBRELLA_PARASOL,     12,   E_SLASH_1,     EQUIP_HERO_UMBRELLA,   20,      6,       "パラソル",                     WEAPON_MSG47},
    {WEAPON_UMBRELLA_AIAI,        14,   E_SLASH_1,     EQUIP_HERO_UMBRELLA,    0,      8,       "あいあい傘",                   WEAPON_MSG48},
    {WEAPON_UMBRELLA_KURENAI,     20,   E_SLASH_1,     EQUIP_HERO_UMBRELLA,   40,     15,       "紅色傘",                       WEAPON_MSG49},
    {WEAPON_UMBRELLA_KOUMORI,     25,   E_SLASH_1,     EQUIP_HERO_UMBRELLA,    0,     10,       "こうもり傘",                   WEAPON_MSG50},
    {WEAPON_UMBRELLA_HISUI,       30,   E_SLASH_1,     EQUIP_HERO_UMBRELLA,    0,     50,       "ヒスイのアンブレラ",           WEAPON_MSG51},
    {WEAPON_UMBRELLA_PLATINUM,    40,   E_SLASH_1,     EQUIP_HERO_UMBRELLA,  220,    100,       "プラチナの傘",                 WEAPON_MSG52},
    {WEAPON_UMBRELLA_ROVE,        45,   E_SLASH_1,     EQUIP_HERO_UMBRELLA,    0,     30,       "ラブリーパラソル",             WEAPON_MSG53},
    {WEAPON_UMBRELLA_BLOOD,       55,   E_SLASH_1,     EQUIP_HERO_UMBRELLA,    0,    100,       "ブラッディクロス",             WEAPON_MSG54},
    {WEAPON_UMBRELLA_ORIHARUKON,  75,   E_SLASH_1,     EQUIP_HERO_UMBRELLA,    0,    150,       "オリハルコンの傘",             WEAPON_MSG55},
    {WEAPON_UMBRELLA_KOGASA,      10,   E_SLASH_1,     I_YUKA,                 0,      0,       "小傘",                         WEAPON_MSG56},
    {WEAPON_ROD,                   4,   E_SLASH_1,     EQUIP_HERO_ROD,        10,      3,       "ただの杖",                     WEAPON_MSG57},
    {WEAPON_ROD_TREE,              7,   E_SLASH_1,     EQUIP_HERO_ROD,        20,      6,       "森の杖",                       WEAPON_MSG58},
    {WEAPON_ROD_MAGIC,            10,   E_SLASH_1,     EQUIP_HERO_ROD,         0,     10,       "魔力の杖",                     WEAPON_MSG59},
    {WEAPON_ROD_KYANDY,           13,   E_SLASH_1,     EQUIP_HERO_ROD,         0,     30,       "キャンディロッド",             WEAPON_MSG60},
    {WEAPON_ROD_HONOO,            15,   E_SLASH_1,     EQUIP_HERO_ROD,        70,     20,       "炎の杖",                       WEAPON_MSG61},
    {WEAPON_ROD_BLOOD,            17,   E_SLASH_1,     EQUIP_HERO_ROD,         0,      5,       "ブラッディロッド",             WEAPON_MSG62},
    {WEAPON_ROD_MEIHU,            22,   E_SLASH_1,     EQUIP_HERO_ROD,         0,     10,       "冥府の杖",                     WEAPON_MSG63},
    {WEAPON_ROD_SEIREI,           26,   E_SLASH_1,     EQUIP_HERO_ROD,       150,     30,       "精霊の杖",                     WEAPON_MSG64},
    {WEAPON_ROD_KENZYA,           30,   E_SLASH_1,     EQUIP_HERO_ROD,       220,     70,       "賢者の杖",                     WEAPON_MSG65},
    {WEAPON_ROD_SEIZYO,           36,   E_SLASH_1,     EQUIP_HERO_ROD,         0,    100,       "聖女の杖",                     WEAPON_MSG66},
    {WEAPON_ROD_GIONGA,           41,   E_SLASH_1,     EQUIP_HERO_ROD,         0,    220,       "銀河の杖",                     WEAPON_MSG67},
    {WEAPON_ROD_LAEVATEINN,       50,   E_SLASH_1,     I_SATO,                 0,      0,       "想杖・レーヴァテイン",          WEAPON_MSG68},
    {WEAPON_NOT_FOUND,             0,           0,          0,                 0,      0,       "？？？？？？",                       WEAPON_FOUND},
};



/*
 * ver1. 2021/07/11
 * 防具情報を管理すデータベース
 * -
 * id           防具ID
 * def          物防
 * res          魔防
 * equip_hero   装備可能キャラ
 * *name        装備名
 */
typedef struct armor_db
{
    uint8_t  id;
    uint8_t  def;
    uint8_t  res;
    uint8_t  equip_hero;
    uint32_t buy;
    uint32_t cell;
    const char *name;
    const char *msg;
} ArmorDB;

static const ArmorDB armor_db[] =
{
    {ARMOR_NON,                 0,   0,     EQUIP_HERO_ALL,       0,     0,     "はずす"                    ,       "見よこの鍛え上げられた筋肉"},
    {ARMOR_CLIP_TREE,           3,   3,     EQUIP_HERO_CLIP,      8,     2,     "木のヘアピン"              ,       ARMOR_MSG0},
    {ARMOR_HAT_MORI,            5,   5,     EQUIP_HERO_HAT,      14,     4,     "森の帽子"                  ,       ARMOR_MSG1},
    {ARMOR_HAT_GROUND,          7,   5,     EQUIP_HERO_HAT,      22,     7,     "大地の帽子"                  ,     ARMOR_MSG2},
    {ARMOR_RIBBON_COLOR,        5,   7,     EQUIP_HERO_RIBBON,    0,    10,     "水色リボン"                ,       ARMOR_MSG3},
    {ARMOR_HAT_FULUT,           8,   7,     EQUIP_HERO_HAT,       0,     8,     "フルーツハット"             ,      ARMOR_MSG4},
    {ARMOR_CRIP_SILBER,        10,  10,     EQUIP_HERO_CLIP,     25,     8,     "ぎんのかみかざり"            ,     ARMOR_MSG5},
    {ARMOR_HAT_ICE,            13,  10,     EQUIP_HERO_HAT,      30,    20,     "氷の帽子"                   ,      ARMOR_MSG6},
    {ARMOR_HAT_HONOO,          16,  12,     EQUIP_HERO_HAT,      50,    20,     "炎の帽子"                   ,      ARMOR_MSG7},
    {ARMOR_HAT_AKAZUKIN,       23,  23,     EQUIP_HERO_HAT,       0,    15,     "あかずきん"                  ,     ARMOR_MSG8},
    {ARMOR_CLIP_PURATINUM,     24,  22,     EQUIP_HERO_CLIP,     70,    30,     "プラチナのかみかざり"         ,        ARMOR_MSG9},
    {ARMOR_HAT_TENKO,          20,  20,     I_TENK,               0,     0,     "天子の帽子"                  ,     ARMOR_MSG10},
    {ARMOR_RIBBON_USAMIMI,     27,  27,     EQUIP_HERO_RIBBON,    0,    30,     "うさみみリボン"              ,     ARMOR_MSG11},
    {ARMOR_CRIP_KUMA,          28,  15,     EQUIP_HERO_CLIP,      0,    25,     "くまさんのヘアピン"           ,        ARMOR_MSG12},
    {ARMOR_HAT_KUROZUKIN,       0,   0,     EQUIP_HERO_HAT,       0,    25,     "くろずきん"                  ,     ARMOR_MSG13},
    {ARMOR_HAT_VEIL,           34,  30,     EQUIP_HERO_HAT,       0,    10,     "シルクのヴェール"             ,        ARMOR_MSG14},
    {ARMOR_RIBBON_CUTE,        30,  35,     EQUIP_HERO_RIBBON,  120,    30,     "キュートなリボン"             ,        ARMOR_MSG15},
    {ARMOR_HAT_CUTE,           35,  30,     EQUIP_HERO_HAT,     120,    30,     "キュートな帽子"               ,        ARMOR_MSG16},
    {ARMOR_CRIP_FLOWER,        38,  30,     EQUIP_HERO_CLIP,      0,    40,     "花のコサージュ"               ,        ARMOR_MSG17},
    {ARMOR_CROWN_KOUGYOKU,     42,  38,     EQUIP_HERO_CROWN,     0,     0,     "紅玉の冠"                     ,        ARMOR_MSG18},
    {ARMOR_RIBONN_TIRYOKU,     35,  43,     EQUIP_HERO_RIBBON,  190,    50,     "知力のリボン"                  ,       ARMOR_MSG19},
    {ARMOR_HAT_TIRYOKU,        40,  40,     EQUIP_HERO_HAT,     190,    50,     "知力の帽子"                   ,        ARMOR_MSG20},
    {ARMOR_HAT_MARISA,         35,  50,     EQUIP_HERO_HAT,       0,     0,     "魔法使いの帽子"                ,       ARMOR_MSG21},
    {ARMOR_RIBBON_REIMU,       35,  50,     EQUIP_HERO_RIBBON,    0,     0,     "巫女のリボン"                  ,       ARMOR_MSG22},
    {ARMOR_CROWN_PRINCESS,     45,  40,     EQUIP_HERO_CROWN,     0,     0,     "王女のティアラ"                ,       ARMOR_MSG23},
    {ARMOR_CROWN_GOLD,         50,  40,     EQUIP_HERO_CROWN,     0,     0,     "黄金のティアラ"                 ,      ARMOR_MSG24},
    {ARMOR_HOUZYOU,            60,  60,     I_MINO,               0,     0,     "豊穣神の帽子"                   ,      ARMOR_MSG25},
    {ARMOR_SYSTER,             60,  60,     I_SIZU,               0,     0,     "静葉のリボン"                   ,      ARMOR_MSG26},
    {ARMOR_PONDERING,          60,  60,     I_KANA,               0,     0,     "軍神のねじり鉢巻"                ,     ARMOR_MSG27},
    {ARMOR_HIMAWARIBOUSI,      60,  60,     I_YUKA,               0,     0,     "太陽の麦わら帽子"                ,     ARMOR_MSG28},
    {ARMOR_HANAKANMURI,        60,  60,     I_KOGA,               0,     0,     "七色の花冠"                      ,     ARMOR_MSG29},
    {ARMOR_KOUMA,              60,  60,     I_REMY,               0,     0,     "紅魔のティアラ"                  ,     ARMOR_MSG30},
    {ARMOR_YATAGARASU,         60,  60,     I_SATO,               0,     0,     "ヤタガラスのかみかざり"           ,        ARMOR_MSG31},
    {ARMOR_MOMO,               60,  60,     I_TENK,               0,     0,     "天桃のティアラ"                  ,     ARMOR_MSG32},
    {ARMOR_NOT_FOUND,           0,   0,          0,               0,     0,     "？？？？？？"                  ,     ARMOR_FOUND},
};


/*
 * ver1. 2021/07/11
 * アクセサリ情報を管理すデータベース
 * -
 * id           アクセサリID
 * equip_hero   装備可能キャラ
 * *name        装備名
 */
typedef struct amulet_db
{
    uint8_t  id;
    uint8_t  equip_hero;
    uint32_t buy;
    uint32_t cell;
    const char *name;
    const char *msg;
} AmuletDB;

static const AmuletDB amulet_db[] =
{
    {AMULET_NON,         EQUIP_HERO_ALL,     0,    0,    "はずす",              "マジックパワーなんざ必要ねぇ！"},
    {AMULET_RING_1,      EQUIP_HERO_ALL,   100,   25,    "炎のリング",          AMULET_MSG1},
    {AMULET_RING_2,      EQUIP_HERO_ALL,   100,   25,    "氷のリング",          AMULET_MSG2},
    {AMULET_RING_3,      EQUIP_HERO_ALL,   100,   25,    "雷のリング",          AMULET_MSG3},
    {AMULET_RING_4,      EQUIP_HERO_ALL,   100,   25,    "土のリング",          AMULET_MSG4},
    {AMULET_RING_5,      EQUIP_HERO_ALL,   100,   25,    "神のリング",          AMULET_MSG5},
    {AMULET_RING_6,      EQUIP_HERO_ALL,   100,   25,    "霊のリング",          AMULET_MSG6},
    {AMULET_RING_7,      EQUIP_HERO_ALL,   100,   25,    "アタックリング",        AMULET_MSG7},
    {AMULET_RING_8,      EQUIP_HERO_ALL,   100,   25,    "シールドリング",        AMULET_MSG8},
    {AMULET_RING_9,      EQUIP_HERO_ALL,   100,   25,    "マジックリング",        AMULET_MSG9},
    {AMULET_RING_10,     EQUIP_HERO_ALL,   100,   25,    "スピードリング",        AMULET_MSG10},
    {AMULET_RING_11,     EQUIP_HERO_ALL,   100,   25,    "レジストリング",        AMULET_MSG11},
    {AMULET_RING_12,     EQUIP_HERO_ALL,   100,   25,    "コンフィグリング",    AMULET_MSG12},
    {AMULET_RING_13,     EQUIP_HERO_ALL,   100,   25,    "ポイズンリング",      AMULET_MSG13},
    {AMULET_RING_14,     EQUIP_HERO_ALL,   100,   25,    "バーサクリング",      AMULET_MSG14},
    {AMULET_RING_15,     EQUIP_HERO_ALL,   100,   25,    "メヂューサリング",    AMULET_MSG15},
    {AMULET_RING_16,     EQUIP_HERO_ALL,   100,   25,    "パラライリング",      AMULET_MSG16},
    {AMULET_RING_17,     EQUIP_HERO_ALL,     0,  100,    "クリスタルリング",    AMULET_MSG17},
    {AMULET_RING_18,     EQUIP_HERO_ALL,     0,  300,    "ドラゴニックリング",  AMULET_MSG18},
    {AMULET_RING_19,     EQUIP_HERO_ALL,     0,  300,    "山童の甲羅",         AMULET_MSG19},
    {AMULET_RING_20,     EQUIP_HERO_ALL,     0,  300,    "魔人経巻の写経",     AMULET_MSG20},
    {AMULET_RING_21,     EQUIP_HERO_ALL,     0,  300,    "カラス天狗の羽",     AMULET_MSG21},
    {AMULET_RING_22,     EQUIP_HERO_ALL,     0,  300,    "七曜の護符",         AMULET_MSG22},
    {AMULET_RING_23,     EQUIP_HERO_ALL,     0,  300,    "えんまの口紅",         AMULET_MSG23},
    {AMULET_RING_24,     EQUIP_HERO_ALL,     0,  300,    "銀時計",             AMULET_MSG24},
    {AMULET_RING_25,     EQUIP_HERO_ALL,     0,  300,    "不死鳥のおぼろ火",   AMULET_MSG25},
    {AMULET_RING_26,     I_KANA,             0,  300,    "ヘンＴ",             AMULET_MSG26},
    {AMULET_RING_27,     EQUIP_HERO_ALL,     0,  300,    "宝塔",               AMULET_MSG27},
    {AMULET_RING_28,     EQUIP_HERO_ALL,     0,  300,    "はにわのお守り",      AMULET_MSG28},
    {AMULET_RING_29,     EQUIP_HERO_ALL,     0,  300,    "マターラマジック",    AMULET_MSG29},
    {AMULET_RING_30,     EQUIP_HERO_ALL,     0,  300,    "要石のお守り",        AMULET_MSG30},
    {AMULET_RING_31,     EQUIP_HERO_ALL,     0,  300,    "希望の指輪",          AMULET_MSG31},
    {AMULET_RING_32,     EQUIP_HERO_ALL,     0,  300,    "七星のネックレス",    AMULET_MSG32},
    {AMULET_NOT_FOUND,                0,     0,    0,    "？？？？？？",                AMULET_FOUND},
};


/*
 * ver1. 2021/07/13
 * アイテムrawファイル書き出し
 */
void item_write(FILE *fp, FILE *byte)
{
	const ItemDB *item = item_db;

	for (uint8_t i = 0; i < ITEM_DB_SIZE; i++, item++)
	{
		fprintf(fp, "0x%08x,\n", item->id);
		fprintf(fp, "0x%08x,\n", item->atb_timer);
		fprintf(fp, "0x%08x,\n", item->wait_time);
		fprintf(fp, "0x%08x,\n", item->anime_id);
		fprintf(fp, "0x%08x,\n", item->range);
		fprintf(fp, "0x%08x,\n", item->use_type);
		fprintf(fp, "0x%08x,\n", item->power);
        for (uint8_t j = 0; j < ITEM_MEMBER_NUMBER - 2; j++)
        {
            fprintf(byte, "0x%08x,\n", 1);
        }
		fprintf(byte, "0x%08x,\n", sjis_write(fp, item->name));
		fprintf(byte, "0x%08x,\n", sjis_write(fp, item->msg));
	}

    if (ITEM_DB_SIZE != ITEM_NAME_ID_END)
    {
        printf("--- ERROR --- ITEM");
    }

    printf("ITEM DB TOTAL NUMBER= %ld\n", ITEM_DB_SIZE);
}


/*
 * ver1. 2021/07/13
 * 武器rawファイル書き出し
 */
void weapon_write(FILE *fp, FILE *byte)
{
	const WeaponDB *item = weapon_db;

	for (uint8_t i = 0; i < WEAPON_DB_SIZE; i++, item++)
	{
		fprintf(fp, "0x%08x,\n", item->id);
		fprintf(fp, "0x%08x,\n", item->atk);
		fprintf(fp, "0x%08x,\n", item->effect_draw_id);
		fprintf(fp, "0x%08x,\n", item->equip_hero);
		fprintf(fp, "0x%08x,\n", item->buy);
		fprintf(fp, "0x%08x,\n", item->cell);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", sjis_write(fp, item->name));
		fprintf(byte, "0x%08x,\n", sjis_write(fp, item->msg));
	}

    error_print(WEAPON_DB_SIZE, WEAPON_NAME_ID_END, "WEAPON DB TOTAL NUMBER");
}



/*
 * ver1. 2021/07/13
 * 防具rawファイル書き出し
 */
void armor_write(FILE *fp, FILE *byte)
{
	const ArmorDB *item = armor_db;

	for (uint8_t i = 0; i < ARMOR_DB_SIZE; i++, item++)
	{
		fprintf(fp, "0x%08x,\n", item->id);
		fprintf(fp, "0x%08x,\n", item->def);
		fprintf(fp, "0x%08x,\n", item->res);
		fprintf(fp, "0x%08x,\n", item->equip_hero);
		fprintf(fp, "0x%08x,\n", item->buy);
		fprintf(fp, "0x%08x,\n", item->cell);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", sjis_write(fp, item->name));
		fprintf(byte, "0x%08x,\n", sjis_write(fp, item->msg));
	}

    error_print(ARMOR_DB_SIZE, ARMOR_NAME_ID_END, "ARMOR DB TOTAL NUMBER");
}



/*
 * ver1. 2021/07/13
 * アクセサリrawファイル書き出し
 */
void amulet_write(FILE *fp, FILE *byte)
{
	const AmuletDB *item = amulet_db;

	for (uint8_t i = 0; i < AMULET_DB_SIZE; i++, item++)
	{
		fprintf(fp, "0x%08x,\n", item->id);
		fprintf(fp, "0x%08x,\n", item->equip_hero);
		fprintf(fp, "0x%08x,\n", item->buy);
		fprintf(fp, "0x%08x,\n", item->cell);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", sjis_write(fp, item->name));
		fprintf(byte, "0x%08x,\n", sjis_write(fp, item->msg));
	}

    error_print(AMULET_DB_SIZE, AMULET_NAME_ID_END, "AMULET DB TOTAL NUMBER");
}


#endif
