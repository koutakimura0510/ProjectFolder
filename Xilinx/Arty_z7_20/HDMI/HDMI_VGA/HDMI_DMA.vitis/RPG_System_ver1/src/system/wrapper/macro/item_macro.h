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

#ifndef item_macro_h   /* prevent circular inclusions */
#define item_macro_h   /* by using protection macros */

/*
 * ver1. 2021/07/10
 * アイテムID
 */
typedef enum
{
    ITEM_NON,
    /* バトルに使用するアイテム */

    /* HP単体回復系 */
    ITEM_DANGO,             // 甘味処の団子
    ITEM_SASADANGO,         // 甘味処の笹団子
    ITEM_OUGONDANGO,        // 甘味処の黄金団子
    ITEM_GENSOUDANGO,       // 甘味処の幻想団子

    /* HP全体回復系 */
    ITEM_ARISU_COOKEI_1,    // アリスの黒炭クッキー
    ITEM_ARISU_COOKEI_2,    // アリスの義理クッキー
    ITEM_ARISU_COOKEI_3,    // アリスの本命クッキー

    /* 状態異常回復 */
    ITEM_MARISA_KINOKO,     // 魔法の森産テングダケ

    /* 単体蘇生 */
    ITEM_YAGOKORODORINKU,   // 八意ドリンク

    /* 全体蘇生 */
    ITEM_HOURAIDORINK,      // 蓬莱ドリンク

    /* 霊力回復系 */
    ITEM_HAKUREI_DOBU,      // 博麗印のどぶ水
    ITEM_HAKUREI_IDO,       // 博麗印の井戸水
    ITEM_HAKUREI_WATER,     // 博麗印の天然水
    ITEM_HAKUREI_GOD,       // 博麗印のお神酒

    /* 単体プロテス */
    ITEM_KAPPA_SIELD,       // 光学迷彩・物

    /* 単体マジックバリアー */
    ITEM_KAPPA_MAGIC,       // 光学迷彩・魔

    /* 単体リフレク */
    ITEM_SANAE_OMAMORI,       // 早苗のお守り

    /* 必ず逃げれる */
    ITEM_SEIZYA_ESCAPE,     // お尋ね者はご用心

    /* 小バイキルト */
    ITEM_ONI_POWER,         // 鬼神の怪力薬
    
    /* 自身がバーサクとリジェネ */
    ITEM_ONI_SYURAN,        // 伊吹瓢

    ITEM_NOT_FOUND,
    ITEM_NAME_ID_END,
    ITEM_CURSOL_YEND = ITEM_NOT_FOUND-1,

    /* ストーリー進行のアイテム、大事な物 */
    
} ItemName;


/* エンチャント系のアイテムをまとめる */
typedef enum
{
    ENCHANT_ITEM_KAPPA_SIELD,       // 光学迷彩・物
    ENCHANT_ITEM_KAPPA_MAGIC,       // 光学迷彩・魔
    ENCHANT_ITEM_ONI_POWER,         // 鬼神の怪力薬
    ENCHANT_ITEM_END,
} ItemNameEnchant;


/* 状態異常系のアイテムをまとめる */
typedef enum
{
    CONDITION_ITEM_MARISA_KINOKO,     // 魔理沙のキノコ
    CONDITION_ITEM_SANAE_OMAMORI,     // 早苗のお守り
    CONDITION_ITEM_ONI_SYURAN,        // 伊吹瓢
    CONDITION_ITEM_END,
} ItemNameCondition;

/*
 * ver1. 2021/07/11
 * 武器のID
 */
typedef enum
{
    WEAPON_NON,
    /* 剣系 */
    WEAPON_SWORAD_TETU,         //鉄の剣
    WEAPON_SWORAD_BEND,         //曲剣
    WEAPON_SWORAD_RONG,         //ロングソード
    WEAPON_SWORAD_SILBER,       //シルバーソード
    WEAPON_SWORAD_HONOO,        //炎の剣
    WEAPON_SWORAD_HISOUKEN,     //緋想の剣
    WEAPON_SWORAD_GOURYUU,      //剛竜剣
    WEAPON_SWORAD_MANAMUNE,     //マサムネ
    WEAPON_SWORAD_MURAMASA,     //ムラマサ
    WEAPON_SWORAD_ZANTETRU,     //名工斬鉄剣
    WEAPON_SWORAD_SIN_HISOUKEN, //真・緋想剣

    /* 短剣 */
    WEAPON_SHORT_SHORT,         //ナイフ
    WEAPON_SHORT_BATER,         //バターナイフ
    WEAPON_SHORT_POIZUN,        //ポイズンダガー
    WEAPON_SHORT_ASSASSIN,      //アサシンダガー
    WEAPON_SHORT_KILLER,        //キラーナイフ
    WEAPON_SHORT_ICE,           //アイスナイフ
    WEAPON_SHORT_SARAMANDER,    //サラマンダー
    WEAPON_SWORAD_DRAGON,       //ドラゴンキラー
    WEAPON_SHORT_HURAGA,        //フラガラッハ
    WEAPON_SHORT_KURONOS,       //クロノスエッジ
    WEAPON_SWORAD_ALTEMA,       //神刀紅葉おろし

    /* 槍系 */
    WEAPON_SPEAR_NIGHT,         //ナイトスピア
    WEAPON_SPEAR_SILBER,        //シルバースピア
    WEAPON_SPEAR_TRIDENT,       //トライデント
    WEAPON_SPEAR_RAIZIN,        //雷神槍
    WEAPON_SPEAR_HONOO,         //炎の槍
    WEAPON_SPEAR_DEAMON,        //デーモンスピア
    WEAPON_SPEAR_KING,          //海龍王の槍
    WEAPON_SPEAR_TRISHULA,      //トリシューラ
    WEAPON_SPEAR_LONGINUS,      //ロンギヌス
    WEAPON_SPEAR_GAEBOLGA,      //ゲイボルグ
    WEAPON_SPEAR_THE_GUNGNIR,   //神槍スピアザグングニル

    /* ハンマー系 */
    WEAPON_KODUTI,              //こづち
    WEAPON_KODUTI_MORI,         //森のハンマー
    WEAPON_KODUTI_DAITI,        //大地のハンマー
    WEAPON_KODUTI_HUGOU,        //こがねもち
    WEAPON_KODUTI_KOORI,        //アイスハンマー
    WEAPON_KODUTI_HONOO,        //ファイアーハンマー
    WEAPON_KODUTI_KAMIGOROSI,   //かみごろし
    WEAPON_KODUTI_TORL,         //トールハンマー
    WEAPON_KODUTI_TOUMOKOROSI,  //とうもごろし
    WEAPON_KODUTI_DANZAI,       //断罪の鉄槌
    WEAPON_KODUTI_GIANT,        //ギガントハンマー
    WEAPON_KODUTI_UTIDENO,      //打ち出のこづち
    WEAPON_KODUTI_ONBASIRA,     //ゴッドオブオンバシラ

    /* 傘 */
    WEAPON_UMBRELLA_SUN,        //日傘
    WEAPON_UMBRELLA_PARASOL,    //パラソル
    WEAPON_UMBRELLA_AIAI,       //あいあい傘
    WEAPON_UMBRELLA_KURENAI,    //紅色傘
    WEAPON_UMBRELLA_KOUMORI,    //こうもり傘
    WEAPON_UMBRELLA_HISUI,      //ヒスイのアンブレラ
    WEAPON_UMBRELLA_PLATINUM,   //プラチナの傘
    WEAPON_UMBRELLA_ROVE,       //ラブリーパラソル
    WEAPON_UMBRELLA_BLOOD,      //ブラッディクロス
    WEAPON_UMBRELLA_ORIHARUKON, //オリハルコンの傘
    WEAPON_UMBRELLA_KOGASA,     //小傘

    /* 杖 */
    WEAPON_ROD,                 //ただの杖
    WEAPON_ROD_TREE,            //森の杖
    WEAPON_ROD_MAGIC,           //魔力の杖
    WEAPON_ROD_KYANDY,          //キャンディロッド
    WEAPON_ROD_HONOO,           //炎の杖
    WEAPON_ROD_BLOOD,           //ブラッディロッド
    WEAPON_ROD_MEIHU,           //冥府の杖
    WEAPON_ROD_SEIREI,          //精霊の杖
    WEAPON_ROD_KENZYA,          //賢者の杖
    WEAPON_ROD_SEIZYO,          //聖女の杖
    WEAPON_ROD_GIONGA,          //銀河の杖
    WEAPON_ROD_LAEVATEINN,      //レーヴァテイン
    WEAPON_NOT_FOUND,
    WEAPON_NAME_ID_END,
    WEAPON_CURSOL_YEND = WEAPON_NOT_FOUND-1,
} WeaponID;


/*
 * ver1. 2021/07/11
 * 防具のIDを管理
 */
typedef enum
{
    ARMOR_NON,
    ARMOR_CLIP_TREE,        //木のヘアピン
    ARMOR_HAT_MORI,         //森の帽子
    ARMOR_RIBBON_COLOR,     //水色リボン
    ARMOR_HAT_FULUT,        //フルーツハット
    ARMOR_CRIP_SILBER,      //ぎんのかみかざり
    ARMOR_HAT_ICE,          //氷の帽子
    ARMOR_HAT_HONOO,        //炎の帽子
    ARMOR_HAT_GROUND,       //大地の帽子
    ARMOR_HAT_AKAZUKIN,     //あかずきん
    ARMOR_CLIP_PURATINUM,   //プラチナのかみかざり
    ARMOR_HAT_TENKO,        //天子の帽子
    ARMOR_RIBBON_USAMIMI,   //うさみみリボン
    ARMOR_CRIP_KUMA,        //くまさんのヘアピン
    ARMOR_HAT_KUROZUKIN,    //くろずきん
    ARMOR_HAT_VEIL,         //シルクのヴェール
    ARMOR_RIBBON_CUTE,      //キュートなリボン
    ARMOR_HAT_CUTE,         //キュートな帽子
    ARMOR_CRIP_FLOWER,      //花のコサージュ
    ARMOR_CROWN_KOUGYOKU,   //紅玉の冠、イベント
    ARMOR_RIBONN_TIRYOKU,   //知力のリボン
    ARMOR_HAT_TIRYOKU,      //知力の帽子
    ARMOR_HAT_MARISA,       //魔法使いの帽子
    ARMOR_RIBBON_REIMU,     //巫女のリボン
    ARMOR_CROWN_PRINCESS,   //王女のティアラ
    ARMOR_CROWN_GOLD,       //黄金のティアラ
    ARMOR_HOUZYOU,          //豊穣神の帽子、イベント、魔法使いの帽子と大事なものと合わせて豊穣神の帽子に改良
    ARMOR_SYSTER,           //静葉のリボン、イベント、巫女のリボンと大事なものを合わせて静葉のリボンに改良
    ARMOR_PONDERING,        //軍神のねじり鉢巻、闘技場の優勝賞品、汗臭い
    ARMOR_HIMAWARIBOUSI,    //太陽の麦わら帽子、小傘のおどろけイベントで幽香からもらう
    ARMOR_HANAKANMURI,      //七色の花冠、幽香の七草イベントで取得、七草で小傘が編んでくれた
    ARMOR_KOUMA,            //紅魔のティアラ、イベント、紅玉の冠と黄金のティアラを合わせて紅魔のティアラに改良
    ARMOR_YATAGARASU,       //ヤタガラスのかみかざり、さとりの動物イベントで入手
    ARMOR_MOMO,             //天桃のティアラ、イベント、天子の帽子と王女のティアラを合わせて天桃のティアラに改良
    ARMOR_NOT_FOUND,
    ARMOR_NAME_ID_END,
    ARMOR_CURSOL_YEND = ARMOR_NOT_FOUND-1,
} ArmorID;


/*
 * ver1. 2021/07/12
 * アクセサリのIDを管理
 */
typedef enum
{
    AMULET_NON,
    AMULET_RING_1,  //炎のリング
    AMULET_RING_2,  //氷のリング
    AMULET_RING_3,  //雷のリング
    AMULET_RING_4,  //土のリング
    AMULET_RING_5,  //神のリング
    AMULET_RING_6,  //霊のリング
    AMULET_RING_7,  //アタックリング
    AMULET_RING_8,  //シールドリング
    AMULET_RING_9,  //マジックリング
    AMULET_RING_10, //スピードリング
    AMULET_RING_11, //レジストリング
    AMULET_RING_12, //コンフィグリング
    AMULET_RING_13, //ポイズンリング
    AMULET_RING_14, //バーサクリング
    AMULET_RING_15, //メヂューサリング
    AMULET_RING_16, //パラライリング
    AMULET_RING_17, //クリスタルリング
    AMULET_RING_18, //ドラゴニックリング
    AMULET_RING_19, //山童の甲羅
    AMULET_RING_20, //魔人経巻の写経
    AMULET_RING_21, //鴉天狗の羽
    AMULET_RING_22, //七曜の護符
    AMULET_RING_23, //閻魔の口紅
    AMULET_RING_24, //銀時計
    AMULET_RING_25, //不死鳥の焔
    AMULET_RING_26, //ヘンＴ
    AMULET_RING_27, //宝塔
    AMULET_RING_28, //はにわのお守り
    AMULET_RING_29, //マターラマジック
    AMULET_RING_30, //要石のお守り
    AMULET_RING_31, //希望の指輪
    AMULET_RING_32, //七星のネックレス
    AMULET_NOT_FOUND,
    AMULET_NAME_ID_END,
    AMULET_CURSOL_YEND = AMULET_NOT_FOUND-1,
} AmuletID;
#endif
