/*
 * Create 2021/07/02
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * わざ、装備の効果に関する情報をまとめたファイル
 */
#ifndef element_db_h   /* prevent circular inclusions */
#define element_db_h   /* by using protection macros */

#include "macro/res_macro.h"

/* データベースの要素数 */
#define TYPE_DB_SIZE            ((sizeof (element_db))	/ (sizeof (ElementDB)))
#define WEAPON_ELEMENT_DB_SIZE  ((sizeof (weapon_element))	/ (sizeof (WeaponElement)))
#define ARMOR_ELEMENT_DB_SIZE   ((sizeof (armor_element))	/ (sizeof (ArmorElement)))
#define AMULET_ELEMENT_DB_SIZE  ((sizeof (amulet_element))	/ (sizeof (AmuletElement)))
#define TYPE_BIT_DB_SIZE        ((sizeof (type_str))	/ (sizeof (TypeStr)))


/*
 * ver1. 2021/08/08
 * 
 * 魔法、わざの属性を管理するデータベース
 */
typedef struct
{
	uint32_t element;
    uint32_t type_bit;
} ElementDB;

static const ElementDB element_db[] = {
    {E_DAMAGE_ATTACK,           0   },
    {E_DAMAGE_ATTACK_FIRE,      R5  },
    {E_DAMAGE_ATTACK_THUNDER,   R7  },
    {E_DAMAGE_ATTACK_ICE,       R6  },
    {E_DAMAGE_ATTACK_GROUND,    R9  },
    {E_DAMAGE_ATTACK_GOD,       R8  },
    {E_DAMAGE_ATTACK_SPLIT,     R10 },
    {E_DAMAGE_ATTACK_NON,       R11 },
    {E_DAMAGE_MAGIC_FIRE,       R5  },
    {E_DAMAGE_MAGIC_THUNDER,    R7  },
    {E_DAMAGE_MAGIC_ICE,        R6  },
    {E_DAMAGE_MAGIC_GROUND,     R9  },
    {E_DAMAGE_MAGIC_GOD,        R8  },
    {E_DAMAGE_MAGIC_SPLIT,      R10 },
    {E_DAMAGE_MAGIC_NON,        R11 },
};



/*!
 * @brief 武器の効果情報を管理するデータベース
 * @details item_dbに記載されている武器のデータベースと一緒にしてもよかったが、
 *          基本情報と効果のデータベースを分けた方が考えやすかったため分けることとした
 * 
 * @ingroup weapon
 *
 * @note 
 *
 * @param  weapon_type 武器の効果ID
 * @param  atk 装備時の攻撃ステータス上昇値
 * @param  def 装備時の防御ステータス上昇値
 * @param  mag 装備時の魔攻ステータス上昇値
 * @param  res 装備時の魔防ステータス上昇値
 * @param  agi 装備時の速度ステータス上昇値
 * @param  type_bit 属性
 * @param  love 好感度で威力変動を管理 @n
 *              0. 好感度による攻撃力の上昇はなし
 *              1. 好感度による攻撃力の上昇はあり
 *              上昇がある場合で実際に計算を行う場合は、
 *              好感度60 * 1 = 60
 *              武器の攻撃力に + 60をする
 * @version 1.0 2021/08/08
 */
typedef struct weapon_element
{
    uint32_t id;
    int32_t  atk;
    int32_t  def;
    int32_t  mag;
    int32_t  res;
    int32_t  agi;
    uint32_t type_bit;
    uint32_t love;
} WeaponElement;

static const WeaponElement weapon_element[] =
{
    {WEAPON_NON,                   0, 0, 0, 0, 0,  0    | RNO,  0,},
    {WEAPON_SWORAD_TETU,           0, 0, 0, 0, 0,  R0   | RNO,  0,},   // 鉄の剣
    {WEAPON_SWORAD_BEND,           0, 0, 0, 0, 0,  R0   | RNO,  0,},   // 曲剣
    {WEAPON_SWORAD_RONG,           0, 0, 0, 0, 0,  R0   | RNO,  0,},   // ロングソード
    {WEAPON_SWORAD_SILBER,         0, 0, 0, 0, 0,  R0   | RNO,  0,},   // シルバーソード
    {WEAPON_SWORAD_HONOO,          0, 0, 0, 0, 0,  R0   | R5,   0,},   // 炎の剣
    {WEAPON_SWORAD_HISOUKEN,       0, 0, 0, 0, 0,  R0   | RNO,  0,},   // 緋想の剣
    {WEAPON_SWORAD_GOURYUU,        0, 0, 0, 0, 0,  R0   | RNO,  0,},   // 剛竜剣
    {WEAPON_SWORAD_MANAMUNE,       0, 0, 0, 0, 0,  R0   | R10,  0,},   // マサムネ
    {WEAPON_SWORAD_MURAMASA,       0, 0, 0, 0, 0,  R0   | R10,  0,},   // ムラマサ
    {WEAPON_SWORAD_ZANTETRU,       0, 0, 0, 0, 0,  R0   | R10,  1,},   // 神魔おどろけまる
    {WEAPON_SWORAD_SIN_HISOUKEN,   0, 0, 0, 0, 0,  R0   | R11,  1,},   // 真・緋想の剣
    {WEAPON_SHORT_SHORT,           0, 0, 0, 0, 0,  R0   | RNO,  0,},   // ナイフ
    {WEAPON_SHORT_BATER,           0, 0, 0, 0, 0,  R0   | RNO,  0,},   // バターナイフ
    {WEAPON_SHORT_POIZUN,          0, 0, 0, 0, 0,  R0   | RNO,  0,},   // ポイズンダガー
    {WEAPON_SHORT_ASSASSIN,        0, 0, 0, 0, 0,  R0   | RNO,  0,},   // アサシンダガー
    {WEAPON_SHORT_KILLER,          0, 0, 0, 0, 0,  R0   | RNO,  0,},   // キラーナイフ
    {WEAPON_SHORT_ICE,             0, 0, 0, 0, 0,  R0   | R6,   0,},   // アイスナイフ
    {WEAPON_SHORT_SARAMANDER,      0, 0, 0, 0, 0,  R0   | R5,   0,},   // サラマンダー
    {WEAPON_SWORAD_DRAGON,         0, 0, 0, 0, 0,  R0   | RNO,  0,},   // ドラゴンキラー
    {WEAPON_SHORT_HURAGA,          0, 0, 0, 0, 0,  R0   | RNO,  0,},   // フラガラッハ
    {WEAPON_SHORT_KURONOS,         0, 0, 0, 0, 0,  R0   | RNO,  0,},   // クロノスエッジ
    {WEAPON_SWORAD_ALTEMA,         0, 0, 0, 0, 0,  R0   | R8,   1,},   // 神刀紅葉おろし
    {WEAPON_SPEAR_NIGHT,           0, 0, 0, 0, 0,  R4   | RNO,  0,},   // ナイトスピア
    {WEAPON_SPEAR_SILBER,          0, 0, 0, 0, 0,  R4   | RNO,  0,},   // シルバースピア
    {WEAPON_SPEAR_TRIDENT,         0, 0, 0, 0, 0,  R4   | RNO,  0,},   // トライデント
    {WEAPON_SPEAR_RAIZIN,          0, 0, 0, 0, 0,  R4   | R7,   0,},   // 雷神槍
    {WEAPON_SPEAR_HONOO,           0, 0, 0, 0, 0,  R4   | R5,   0,},   // 炎の槍
    {WEAPON_SPEAR_DEAMON,          0, 0, 0, 0, 0,  R4   | R10,  0,},   // デーモンスピア
    {WEAPON_SPEAR_KING,            0, 0, 0, 0, 0,  R4   | RNO,  0,},   // 海龍王の槍
    {WEAPON_SPEAR_TRISHULA,        0, 0, 0, 0, 0,  R4   | RNO,  0,},   // トリシューラ
    {WEAPON_SPEAR_LONGINUS,        0, 0, 0, 0, 0,  R4   | RNO,  0,},   // ロンギヌス
    {WEAPON_SPEAR_GAEBOLGA,        0, 0, 0, 0, 0,  R4   | R10,  0,},   // ゲイボルグ
    {WEAPON_SPEAR_THE_GUNGNIR,     0, 0, 0, 0, 0,  R4   | R10,  1,},   // レミ嬢・ざ・ぐんぐにる
    {WEAPON_KODUTI,               50,10,20,30, -5, R1   | RNO,  0,},   // こづち
    {WEAPON_KODUTI_MORI,           0, 0, 0, 0, 0,  R1   | RNO,  0,},   // 森のハンマー
    {WEAPON_KODUTI_DAITI,          0, 0, 0, 0, 0,  R1   | R9,   0,},   // 大地のハンマー
    {WEAPON_KODUTI_HUGOU,          0, 0, 0, 0, 0,  R1   | RNO,  0,},   // こがねもち
    {WEAPON_KODUTI_KOORI,          0, 0, 0, 0, 0,  R1   | R6,   0,},   // アイスハンマー
    {WEAPON_KODUTI_HONOO,          0, 0, 0, 0, 0,  R1   | R5,   0,},   // ファイアーハンマー
    {WEAPON_KODUTI_KAMIGOROSI,     0, 0, 0, 0, 0,  R1   | R8,   0,},   // かみごろし
    {WEAPON_KODUTI_TORL,           0, 0, 0, 0, 0,  R1   | R7,   0,},   // トールハンマー
    {WEAPON_KODUTI_TOUMOKOROSI,    0, 0, 0, 0, 0,  R1   | RNO,  0,},   // とうもごろし
    {WEAPON_KODUTI_DANZAI,         0, 0, 0, 0, 0,  R1   | RNO,  0,},   // 断罪の鉄槌
    {WEAPON_KODUTI_GIANT,          0, 0, 0, 0, 0,  R1   | RNO,  0,},   // ギガントハンマー
    {WEAPON_KODUTI_UTIDENO,        0, 0, 0, 0, 0,  R1   | R8,   1,},   // 豊穣神のこづち
    {WEAPON_KODUTI_ONBASIRA,       0, 0, 0, 0, 0,  R1   | R8,   1,},   // ゴッドオブオンバシラ
    {WEAPON_UMBRELLA_SUN,          0, 0, 0, 0, 0,  R3   | RNO,  0,},   // 日傘
    {WEAPON_UMBRELLA_PARASOL,      0, 0, 0, 0, 0,  R3   | RNO,  0,},   // パラソル
    {WEAPON_UMBRELLA_AIAI,         0, 0, 0, 0, 0,  R3   | RNO,  0,},   // あいあい傘
    {WEAPON_UMBRELLA_KURENAI,      0, 0, 0, 0, 0,  R3   | R5,   0,},   // 紅色傘
    {WEAPON_UMBRELLA_KOUMORI,      0, 0, 0, 0, 0,  R3   | RNO,  0,},   // こうもり傘
    {WEAPON_UMBRELLA_HISUI,        0, 0, 0, 0, 0,  R3   | RNO,  0,},   // ヒスイのアンブレラ
    {WEAPON_UMBRELLA_PLATINUM,     0, 0, 0, 0, 0,  R3   | RNO,  0,},   // プラチナの傘
    {WEAPON_UMBRELLA_ROVE,         0, 0, 0, 0, 0,  R3   | RNO,  0,},   // ラブリーパラソル
    {WEAPON_UMBRELLA_BLOOD,        0, 0, 0, 0, 0,  R3   | RNO,  0,},   // ブラッディクロス
    {WEAPON_UMBRELLA_ORIHARUKON,   0, 0, 0, 0, 0,  R3   | RNO,  0,},   // オリハルコンの傘
    {WEAPON_UMBRELLA_KOGASA,       0, 0, 0, 0, 0,  R3   | R10,  1,},   // 小傘
    {WEAPON_ROD,                   0, 0, 0, 0, 0,  R2   | RNO,  0,},   // ただの杖
    {WEAPON_ROD_TREE,              0, 0, 0, 0, 0,  R2   | RNO,  0,},   // 森の杖
    {WEAPON_ROD_MAGIC,             0, 0, 0, 0, 0,  R2   | RNO,  0,},   // 魔力の杖
    {WEAPON_ROD_KYANDY,            0, 0, 0, 0, 0,  R2   | RNO,  0,},   // キャンディロッド
    {WEAPON_ROD_HONOO,             0, 0, 0, 0, 0,  R2   | R5,   0,},   // 炎の杖
    {WEAPON_ROD_BLOOD,             0, 0, 0, 0, 0,  R2   | RNO,  0,},   // ブラッディロッド
    {WEAPON_ROD_MEIHU,             0, 0, 0, 0, 0,  R2   | R10,  0,},   // 冥府の杖
    {WEAPON_ROD_SEIREI,            0, 0, 0, 0, 0,  R2   | RNO,  0,},   // 精霊の杖
    {WEAPON_ROD_KENZYA,            0, 0, 0, 0, 0,  R2   | RNO,  0,},   // 賢者の杖
    {WEAPON_ROD_SEIZYO,            0, 0, 0, 0, 0,  R2   | RNO,  0,},   // 聖女の杖
    {WEAPON_ROD_GIONGA,            0, 0, 0, 0, 0,  R2   | RNO,  0,},   // 銀河の杖
    {WEAPON_ROD_LAEVATEINN,        0, 0, 0, 0, 0,  R2   | R11,  1,},   // 想杖・レーヴァテイン
};


/*
 * ver1. 2021/08/08
 * 防具の効果情報を管理するデータベース
 * item_dbに記載されている武器のデータベースと一緒にしてもよかったが、
 * 基本情報と効果のデータベースを分けた方が考えやすかったため分けることとした
 * 
 * 装備時のステータスの上昇値と下降値
 * atk, def, mag, res, agi
 * 
 * 耐性
 * type_bit
 */
typedef struct
{
    uint32_t id;
    int32_t  atk;
    int32_t  def;
    int32_t  mag;
    int32_t  res;
    int32_t  agi;
    uint32_t type_bit;
} ArmorElement;

static const ArmorElement armor_element[] =
{
    {ARMOR_NON,                     0, 0, 0, 0, 0, RNO, },
    {ARMOR_CLIP_TREE,               0, 0, 0, 0, 0, RNO, },   // 木のヘアピン
    {ARMOR_HAT_MORI,                0, 0, 0, 0, 0, RNO, },   // 森の帽子
    {ARMOR_HAT_GROUND,              0, 0, 0, 0, 0, RNO, },   // 大地の帽子
    {ARMOR_RIBBON_COLOR,            0, 0, 0, 0, 0, RNO, },   // 水色リボン
    {ARMOR_HAT_FULUT,               0, 0, 0, 0, 0, RNO, },   // フルーツハット
    {ARMOR_CRIP_SILBER,             0, 0, 0, 0, 0, RNO, },   // ぎんのかみかざり
    {ARMOR_HAT_ICE,                 0, 0, 0, 0, 0, R5,  },    // 氷の帽子
    {ARMOR_HAT_HONOO,               0, 0, 0, 0, 0, R6,  },    // 炎の帽子
    {ARMOR_HAT_AKAZUKIN,            0, 0, 0, 0, 0, RNO, },   // あかずきん
    {ARMOR_CLIP_PURATINUM,          0, 0, 0, 0, 0, RNO, },   // プラチナのかみかざり
    {ARMOR_HAT_TENKO,               0, 0, 0, 0, 0, RNO, },   // 天子の帽子
    {ARMOR_RIBBON_USAMIMI,          0, 0, 0, 0, 0, R10, },   // うさみみリボン
    {ARMOR_CRIP_KUMA,               0, 0, 0, 0, 0, RNO, },   // くまさんのヘアピン
    {ARMOR_HAT_KUROZUKIN,           0, 0, 0, 0, 0, RNO, },   // くろずきん
    {ARMOR_HAT_VEIL,                0, 0, 0, 0, 0, RNO, },   // シルクのヴェール
    {ARMOR_RIBBON_CUTE,             0, 0, 0, 0, 0, RNO, },   // キュートなリボン
    {ARMOR_HAT_CUTE,                0, 0, 0, 0, 0, RNO, },   // キュートな帽子
    {ARMOR_CRIP_FLOWER,             0, 0, 0, 0, 0, RNO, },   // 花のコサージュ
    {ARMOR_CROWN_KOUGYOKU,          0, 0, 0, 0, 0, RNO, },   // 紅玉の冠
    {ARMOR_RIBONN_TIRYOKU,          0, 0, 0, 0, 0, RNO, },   // 知力のリボン
    {ARMOR_HAT_TIRYOKU,             0, 0, 0, 0, 0, RNO, },   // 知力の帽子
    {ARMOR_HAT_MARISA,              0, 0, 0, 0, 0, RNO, },   // 魔法使いの帽子
    {ARMOR_RIBBON_REIMU,            0, 0, 0, 0, 0, RNO, },   // 巫女のリボン
    {ARMOR_CROWN_PRINCESS,          0, 0, 0, 0, 0, RNO, },   // 王女のティアラ
    {ARMOR_CROWN_GOLD,              0, 0, 0, 0, 0, RNO, },   // 黄金のティアラ
    {ARMOR_HOUZYOU,                 0, 0, 0, 0, 0, RNO, },   // 豊穣神の帽子
    {ARMOR_SYSTER,                  0, 0, 0, 0, 0, RNO, },   // 静葉のリボン
    {ARMOR_PONDERING,               0, 0, 0, 0, 0, RNO, },   // 軍神のねじり鉢巻
    {ARMOR_HIMAWARIBOUSI,           0, 0, 0, 0, 0, RNO, },   // 太陽の麦わら帽子
    {ARMOR_HANAKANMURI,             0, 0, 0, 0, 0, RNO, },   // 七色の花冠
    {ARMOR_KOUMA,                   0, 0, 0, 0, 0, RNO, },   // 紅魔のティアラ
    {ARMOR_YATAGARASU,              0, 0, 0, 0, 0, RNO, },   // ヤタガラスのかみかざり
    {ARMOR_MOMO,                    0, 0, 0, 0, 0, RNO, },   // 天桃のティアラ
};


/*
 * ver1. 2021/08/08
 * アクセサリの効果情報を管理するデータベース
 * item_dbに記載されている武器のデータベースと一緒にしてもよかったが、
 * 基本情報と効果のデータベースを分けた方が考えやすかったため分けることとした
 * 
 * 装備時のステータスの上昇値と下降値
 * atk, def, mag, res, agi
 * 
 * 装備時の耐性
 * type_bit
 * 
 * 装備時の状態異常
 * condition_bit
 * 
 * 0の場合SP消費効果なし、1の場合、技の消費SPが半分になる
 * sp_down
 * 
 */
typedef struct
{
    uint32_t id;
    int32_t  atk;
    int32_t  def;
    int32_t  mag;
    int32_t  res;
    int32_t  agi;
    uint32_t type_bit;
    uint32_t condition_bit;
    uint32_t sp_down;
} AmuletElement;

static const AmuletElement amulet_element[] =
{
    {AMULET_NON,          0,  0,  0,  0,  0,  0,                              0,  0,          },
    {AMULET_RING_1,       0,  0,  0,  0,  0,  R5,                             0,  0,          },  // 炎のリング
    {AMULET_RING_2,       0,  0,  0,  0,  0,  R6,                             0,  0,          },  // 氷のリング
    {AMULET_RING_3,       0,  0,  0,  0,  0,  R7,                             0,  0,          },  // 雷のリング
    {AMULET_RING_4,       0,  0,  0,  0,  0,  R9,                             0,  0,          },  // 土のリング
    {AMULET_RING_5,       0,  0,  0,  0,  0,  R8,                             0,  0,          },  // 神のリング
    {AMULET_RING_6,       0,  0,  0,  0,  0,  R10,                            0,  0,          },  // 霊のリング
    {AMULET_RING_7,       5,  0,  0,  0,  0,  0,                              0,  0,          },  // アタックリング
    {AMULET_RING_8,       0,  5,  0,  0,  0,  0,                              0,  0,          },  // シールドリング
    {AMULET_RING_9,       0,  0,  5,  0,  0,  0,                              0,  0,          },  // マジックリング
    {AMULET_RING_10,      0,  0,  0,  0,  5,  0,                              0,  0,          },  // スピードリング
    {AMULET_RING_11,      0,  0,  0,  5,  0,  0,                              0,  0,          },  // レジストリング
    {AMULET_RING_12,      0,  0,  0,  0,  0,  R12,                            0,  0,          },  // コンフィグリング
    {AMULET_RING_13,      0,  0,  0,  0,  0,  R13,                            0,  0,          },  // ポイズンリング
    {AMULET_RING_14,      0,  0,  0,  0,  0,  R16,                            0,  0,          },  // バーサクリング
    {AMULET_RING_15,      0,  0,  0,  0,  0,  R14,                            0,  0,          },  // メヂューサリング
    {AMULET_RING_16,      0,  0,  0,  0,  0,  R15,                            0,  0,          },  // パラライリング
    {AMULET_RING_17,      3,  3,  3,  3,  3,  0,                              0,  0,          },  // クリスタルリング
    {AMULET_RING_18,     20,  0,  0,  0,  0,  0,                              0,  0,          },  // ドラゴニックリング
    {AMULET_RING_19,      0, 20,  0,  0,  0,  0,                              0,  0,          },  // 山童の甲羅
    {AMULET_RING_20,      0,  0, 20,  0,  0,  0,                              0,  0,          },  // 魔人経巻の写経
    {AMULET_RING_21,      0,  0,  0,  0, 20,  0,                              0,  0,          },  // 鴉天狗の羽
    {AMULET_RING_22,      0,  0,  0, 20,  0,  0,                              0,  0,          },  // 七曜の護符
    {AMULET_RING_23,      0,  0,  0,  0,  0,  0,                              0,  1,          },  // 閻魔の口紅
    {AMULET_RING_24,      0, 10,  0, 10,  0,  0,                              0,  0,          },  // 銀時計
    {AMULET_RING_25,      5,  0,  5,  0, 10,  0,                              0,  0,          },  // 不死鳥の朧火
    {AMULET_RING_26,      5,  5,  5,  5,  1,  0,                              0,  0,          },  // ヘンＴ
    {AMULET_RING_27,     10,  0, 10,  0,  0,  0,                              0,  0,          },  // 宝塔
    {AMULET_RING_28,      0, 10,  0,  0, 10,  0,                              0,  0,          },  // はにわのお守り
    {AMULET_RING_29,      0,  0,  0,  0,  0,  R18,        UNIT_CONDITION_RIGENE,  0,          },  // マターラマジック
    {AMULET_RING_30,      0,  0,  0,  0,  0,  TYPE_ALL,                       0,  0,          },  // 要石のお守り
    {AMULET_RING_31,      0,  0,  0,  0,  0,  CONDI_ALL,                      0,  0,          },  // 希望の指輪
    {AMULET_RING_32,      0,  0,  0,  0,  0,  ATR_ALL,                        0,  0,          },  // 七星のネックレス
};


/**
 * @brief  属性の文字列を管理
 * @note   
 * @retval None
 */
typedef struct
{
    uint32_t type_bit;
    char *msg;
} TypeStr;

static const TypeStr type_str[] = {
    {R0,    "斬"},
    {R1,    "打"},
    {R2,    "杖"},
    {R3,    "傘"},
    {R4,    "槍"},
    {R5,    "炎"},
    {R6,    "氷"},
    {R7,    "雷"},
    {R8,    "神"},
    {R9,    "地"},
    {R10,   "霊"},
    {R11,   "無"},
    {R12,   "混"},
    {R13,   "毒"},
    {R14,   "石"},
    {R15,   "硬"},
    {R16,   "狂"},
    {R17,   "耐"},
    {R18,   "癒"},
};


/*
 * ver1. 2021/08/08
 * 攻撃エフェクトの属性書き出し
 */
void atk_element_write(FILE *fp, FILE *byte)
{
	const ElementDB *p = element_db;

	for (uint32_t i = 0; i < TYPE_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->element);
		fprintf(fp, "0x%08x,\n", p->type_bit);

		for (uint32_t j = 0; j < ELEMENT_SUB_MEMBER_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	printf("ELEMENT DB TOTAL NUMBER = %ld\n", TYPE_DB_SIZE);
}


/*
 * ver1. 2021/08/08
 * 武器の属性の書き出し
 */
void weapon_element_write(FILE *fp, FILE *byte)
{
	const WeaponElement *p = weapon_element;

	for (uint32_t i = 0; i < WEAPON_ELEMENT_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->id);
		fprintf(fp, "0x%08x,\n", p->atk);
		fprintf(fp, "0x%08x,\n", p->def);
		fprintf(fp, "0x%08x,\n", p->mag);
		fprintf(fp, "0x%08x,\n", p->res);
		fprintf(fp, "0x%08x,\n", p->agi);
		fprintf(fp, "0x%08x,\n", p->type_bit);
		fprintf(fp, "0x%08x,\n", p->love);

		for (uint32_t j = 0; j < WEAPON_ELEMENT_SUB_MEMBER_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	printf("ELEMENT WEAPON TOTAL NUMBER = %ld\n", WEAPON_ELEMENT_DB_SIZE);
}

/*
 * ver1. 2021/08/08
 * 防具の属性の書き出し
 */
void armor_element_write(FILE *fp, FILE *byte)
{
	const ArmorElement *p = armor_element;

	for (uint32_t i = 0; i < ARMOR_ELEMENT_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->id);
		fprintf(fp, "0x%08x,\n", p->atk);
		fprintf(fp, "0x%08x,\n", p->def);
		fprintf(fp, "0x%08x,\n", p->mag);
		fprintf(fp, "0x%08x,\n", p->res);
		fprintf(fp, "0x%08x,\n", p->type_bit);
		fprintf(fp, "0x%08x,\n", p->agi);

		for (uint32_t j = 0; j < ARMOR_ELEMENT_SUB_MEMBER_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	printf("ELEMENT ARMOR TOTAL NUMBER = %ld\n", ARMOR_ELEMENT_DB_SIZE);
}

/*
 * ver1. 2021/08/08
 * アクセサリの属性の書き出し
 */
void amulet_element_write(FILE *fp, FILE *byte)
{
	const AmuletElement *p = amulet_element;

	for (uint32_t i = 0; i < AMULET_ELEMENT_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->id);
		fprintf(fp, "0x%08x,\n", p->atk);
		fprintf(fp, "0x%08x,\n", p->def);
		fprintf(fp, "0x%08x,\n", p->mag);
		fprintf(fp, "0x%08x,\n", p->res);
		fprintf(fp, "0x%08x,\n", p->agi);
		fprintf(fp, "0x%08x,\n", p->type_bit);
		fprintf(fp, "0x%08x,\n", p->condition_bit);
		fprintf(fp, "0x%08x,\n", p->sp_down);

		for (uint32_t j = 0; j < AMULET_ELEMENT_SUB_MEMBER_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	printf("ELEMENT AMULET TOTAL NUMBER = %ld\n", AMULET_ELEMENT_DB_SIZE);
}


/**
 * @brief  属性に使用する文字列の書き出し
 * @note   
 * @retval None
 */
static void type_bit_write(FILE *fp, FILE *byte)
{
    const TypeStr *p = type_str;

	for (uint32_t i = 0; i < TYPE_BIT_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->type_bit);
		fprintf(byte, "0x%08x,\n", 1);
        fprintf(byte, "0x%08x,\n", sjis_write(fp, p->msg));
	}

	printf("TYPE BIT TOTAL NUMBER = %ld\n", TYPE_BIT_DB_SIZE);
}


#endif