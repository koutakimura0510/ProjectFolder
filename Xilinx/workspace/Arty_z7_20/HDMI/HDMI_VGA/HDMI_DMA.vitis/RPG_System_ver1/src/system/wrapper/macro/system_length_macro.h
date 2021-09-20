/*
 * Create 2021/07/15
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
 * ファイルデータにアクセスするとぃすうをまとめたヘッダーファイル
 */

#ifndef system_length_macro_h   /* prevent circular inclusions */
#define system_length_macro_h   /* by using protection macros */

/*
 * データベースの行のメンバ数が可変であればSystemLength構造体のmember_lenメンバにこの定数を利用する
 */
#define MEMBER_LEN_VARIABLE     (0)


/* ファイル名の最大文字数 */
#define FILENAME_BUFFER_SIZE    (32)

/* メッセージファイルアプリケーションで出力された定数を記入 */
#define MSG_TOTAL_ID_END        	(8)
#define MINIGAME_TOTAL_ID_END   	(8)
#define MINIGAME_SCORE_TOTAL_ID_END (10)

/* SIN COS のテーブル数*/
#define SIN_TABLE_MAX               (361)
#define COS_TABLE_MAX               (361)

/* NPCの連番データベースの行数 */
#define NPC_PATTERN_DB_COL          (3)

/* 属性データベースの行数 */
#define UNIT_RES_SIZE               (19)

/* 可変式イベントメッセージデータベースの行数 */
#define VARIABLE_MSG_SIZE           (3)

/*
 * ver1. 2021/07/15
 * SystemLength構造体のアクセスIDを定義
 */
typedef enum
{
    MEMORY_ENEMY_PARA_ID,       //敵のパラメータファイル
    MEMORY_ENEMY_NAME_ID,       //敵の名前ファイル
    MEMORY_ITEM_ID,             //アイテムファイル
    MEMORY_WEAPON_ID,           //武器ファイル
    MEMORY_ARMOR_ID,            //防具ファイル
    MEMORY_AMULET_ID,           //アクセサリファイル
    MEMORY_COOK_ID,             //料理ファイル
    MEMORY_EVENT_MSG_ID,        //イベントのメッセージファイル
    MEMORY_MINIGAME_MSG_ID,     //ミニゲームファイル
    MEMORY_CMD_MSG_ID,          //システムコマンドファイル
    MEMORY_MINIGAME_SCORE_ID,   //ミニゲームのスコアファイル
    MEMORY_MAGIC_ID,            //スキルのデータベースファイル
    MEMORY_HERO_LEVEL_ID,       //仲間のステータスファイル
    MEMORY_HERO_SKILL_ID,       //仲間のスキル習得レベル
    MEMORY_ENEMY_REGION_ID,     //マップのリージョンID
    MEMORY_ENEMY_FORMATION_ID,  //敵の隊列データ
    MEMORY_ANIME_MAGIC_ID,      //エフェクトのアニメーションファイル
    MEMORY_STATUS_CONFIG_ID,    //ステータスの補正データファイル
    MEMORY_ELEMENT_TYPE_ID,     //わざの特性データファイル
    MEMORY_ELEMENT_WEAPON_ID,   //武器の特性データファイル
    MEMORY_ELEMENT_ARMOR_ID,    //防具の特性データファイル
    MEMORY_ELEMENT_AMULET_ID,   //アクセサリの特性データファイル
    MEMORY_CONDITION_ID,        //状態異常のデータファイル
    MEMORY_CONDITION_ANIME_ID,  //状態異常のアニメーションデータファイル
    MEMORY_DTM_ID,              //音源の演奏データファイル
    MEMORY_ITEM_ENCHANT_ID,     //アイテムのステータス操作データファイル
    MEMORY_ITEM_CONDITION_ID,   //アイテムの状態異常の効果データファイル
    MEMORY_NPC_MAP_ID,          //npcの描画番号
    MEMORY_NPC_PATTERN_ID,      //npcの行動パターンファイル
    MEMORY_NPC_EVENT_ID,        //npcのイベントデータファイル
    MEMORY_NPC_BITMAP_ID,       //npcの画像データファイル
    MEMORY_SIN_ID,              //sinのデータテーブル 0~360の計361個ある
    MEMORY_COS_ID,              //cosのデータテーブル 0~360の計361個ある
    MEMORY_TYPE_STR_ID,         //属性の文字描画を管理するファイル
    MEMORY_VARIABLE_MSG_ID,     //可変式のイベントメッセージを管理するファイル
} MemoryDataAccess;


/*
 * データベースにアクセスするためのファイルのメンバ名を定義
 */
typedef enum
{
    ITEM_SUB_MEMBER_ID,             //アイテムID
    ITEM_SUB_MEMBER_ATB_TIMER,      //使用待機時間
    ITEM_SUB_MEMBER_WAIT_TIME,      //コマンド決定から発動までの時間
    ITEM_SUB_MEMBER_ANIME,          //アニメーションの縦幅
    ITEM_SUB_MEMBER_RANGE,          //アイテムの効果範囲
    ITEM_SUB_MEMBER_USE_TYPE,       //アイテムの効果タイプ
    ITEM_SUB_MEMBER_POWER,          //アイテムの威力
    ITEM_SUB_MEMBER_NAME,           //アイテム名
    ITEM_SUB_MEMBER_MSG,            //説明
    ITEM_MEMBER_NUMBER,
} ItemSubMember;

typedef enum
{
    ITEM_SUB_MEMBER_ENCHANT_ID,         //アイテムID
    ITEM_SUB_MEMBER_ENCHANT_POWER,      //上昇値
    ITEM_SUB_MEMBER_ENCHANT_ENABLE_BIT, //上昇させるステータス指定bit
    ITEM_SUB_MEMBER_ENCHANT_NUMBER,
} ItemEnchantNumber;

typedef enum
{
    ITEM_SUB_MEMBER_CONDITION_ID,       //アイテムID
    ITEM_SUB_MEMBER_CONDITION_TYPE_BIT, //耐性と属性値
    ITEM_SUB_MEMBER_CONDITION_CONDIBIT, //状態異常定数
    ITEM_SUB_MEMBER_CONDITION_NUMBER,
} ItemConditionNumber;

typedef enum
{
    WEAPON_SUB_MEMBER_ID,
    WEAPON_SUB_MEMBER_ATK,              //攻撃力
    WEAPON_SUB_MEMBER_EFFECT_DRAW_ID,   //武器の攻撃時の描画エフェクトのID
    WEAPON_SUB_MEMBER_EQUIP_HERO,       //装備可能の仲間
    WEAPON_SUB_MEMBER_BUY,              //買値
    WEAPON_SUB_MEMBER_CELL,             //売値
    WEAPON_SUB_MEMBER_NAME,             //武器名
    WEAPON_SUB_MEMBER_MSG,              //説明
    WEAPON_MEMBER_NUMBER
} WeaponSubMember;

typedef enum
{
    ARMOR_SUB_MEMBER_ID,
    ARMOR_SUB_MEMBER_DEF,           //防御力
    ARMOR_SUB_MEMBER_RES,           //魔防
    ARMOR_SUB_MEMBER_EQUIP_HERO,    //装備可能の仲間
    ARMOR_SUB_MEMBER_BUY,           //買値
    ARMOR_SUB_MEMBER_CELL,          //売値
    ARMOR_SUB_MEMBER_NAME,          //防具名
    ARMOR_SUB_MEMBER_MSG,           //説明
    ARMOR_MEMBER_NUMBER,
} ArmorSubMember;

typedef enum
{
    AMULET_SUB_MEMBER_ID,
    AMULET_SUB_MEMBER_EQUIP_HERO,   //装備可能の仲間
    AMULET_SUB_MEMBER_BUY,          //買値
    AMULET_SUB_MEMBER_CELL,         //売値
    AMULET_SUB_MEMBER_NAME,         //アクセサリ名
    AMULET_SUB_MEMBER_MSG,          //説明
    AMULET_MEMBER_NUMBER,
} AmuletSubMember;

typedef enum
{
    WEAPON_ELEMENT_SUB_MEMBER_ID,       //ID
    WEAPON_ELEMENT_SUB_MEMBER_ATK,      //装備時の効果補正値
    WEAPON_ELEMENT_SUB_MEMBER_DEF,      //装備時の効果補正値
    WEAPON_ELEMENT_SUB_MEMBER_MAG,      //装備時の効果補正値
    WEAPON_ELEMENT_SUB_MEMBER_RES,      //装備時の効果補正値
    WEAPON_ELEMENT_SUB_MEMBER_AGI,      //装備時の効果補正値
    WEAPON_ELEMENT_SUB_MEMBER_TYPE_BIT, //攻撃時の属性を指定
    WEAPON_ELEMENT_SUB_MEMBER_LOVE,     //好感度による上昇値
    WEAPON_ELEMENT_SUB_MEMBER_NUMBER,   //メンバ数
} WeaponElementSubMember;

typedef enum
{
    ARMOR_ELEMENT_SUB_MEMBER_ID,        //ID
    ARMOR_ELEMENT_SUB_MEMBER_ATK,       //装備時の効果補正値
    ARMOR_ELEMENT_SUB_MEMBER_DEF,       //装備時の効果補正値
    ARMOR_ELEMENT_SUB_MEMBER_MAG,       //装備時の効果補正値
    ARMOR_ELEMENT_SUB_MEMBER_RES,       //装備時の効果補正値
    ARMOR_ELEMENT_SUB_MEMBER_AGI,       //装備時の効果補正値
    ARMOR_ELEMENT_SUB_MEMBER_TYPE_BIT,  //属性の耐性を指定
    ARMOR_ELEMENT_SUB_MEMBER_NUMBER,    //メンバ数
} ArmorElementSubMember;

typedef enum
{
    AMULET_ELEMENT_SUB_MEMBER_ID,        //ID
    AMULET_ELEMENT_SUB_MEMBER_ATK,       //装備時の効果補正値
    AMULET_ELEMENT_SUB_MEMBER_DEF,       //装備時の効果補正値
    AMULET_ELEMENT_SUB_MEMBER_MAG,       //装備時の効果補正値
    AMULET_ELEMENT_SUB_MEMBER_RES,       //装備時の効果補正値
    AMULET_ELEMENT_SUB_MEMBER_AGI,       //装備時の効果補正値
    AMULET_ELEMENT_SUB_MEMBER_TYPE_BIT,  //属性の耐性を指定
    AMULET_ELEMENT_SUB_MEMBER_CONDI_BIT, //装備時の状態異常
    AMULET_ELEMENT_SUB_MEMBER_SP_DOWN,   //SP消費軽減
    AMULET_ELEMENT_SUB_MEMBER_NUMBER,    //メンバ数
} AmuletElementSubMember;

typedef enum
{
    COOK_SUB_MEMBER_COOKID,             //料理ID
    COOK_SUB_MEMBER_USE_TYPE,           //料理の効果ID
    COOK_SUB_MEMBER_POWER,              //料理の効果
    COOK_SUB_MEMBER_SKILL_LEVEL,        //料理の熟練度上達回数
    COOK_SUB_MEMBER_MSG,                //料理の説明文
    COOK_SUB_MEMBER_NAME,               //料理の名前
    COOK_SUB_MEMBER_NUMBER,
} CookingSubNumber;

typedef enum
{
    EVENT_MSG_SUB_ID,
    EVENT_MSG_SUB_MSG,              //板などのイベントのメッセージ
    EVENT_MSG_MEMBER_NUMBER,
} EventMsgSubMember;

typedef enum
{
    MINIGAME_SUB_MEMBER_ID,
    MINIGAME_SUB_MEMBER_CHIP_ID,        //ミニゲームの使用マップチップ
    MINIGAME_SUB_MEMBER_MOVE_SPEED,     //移動スピード
    MINIGAME_SUB_MEMBER_JUMP_RISESPEED, //ジャンプの上昇スピード
    MINIGAME_SUB_MEMBER_JUMP_FALLSPEED, //ジャンプの下降スピード
    MINIGAME_SUB_MEMBER_JUMP_HEIGHT,    //ジャンプの高さ
    MINIGAME_SUB_MEMBER_BOMB_NUMBER,    //ボムの所持数
    MINIGAME_SUB_MEMBER_BGM_ID,         //bgm
    MINIGAME_SUB_MEMBER_SOUND_ID,       //音源構造体のアクセスID
    MINIGAME_SUB_MEMBER_MSG,            //キャラクターの説明
    MINIGAME_MSG_MEMBER_NUMBER,
} MemMinigameSubMember;

typedef enum
{
    MINIGAME_SUB_MEMBER_TIMEID,
    MINIGAME_SUB_MEMBER_TIME,           //ミニゲームの得点確認用時間
    MINIGAME_SUB_MEMBER_SCORE1,         //スコア1
    MINIGAME_SUB_MEMBER_SCORE2,         //スコア2
    MINIGAME_SUB_MEMBER_SCORE3,         //スコア3
    MINIGAME_SCORE_MEMBER_NUMBER,
} ScoreMinigameSubMember;

typedef enum
{
    MAGIC_SUB_MEMBER_ID,
    MAGIC_SUB_MEMBER_WAIT_TIME,    //わざ発動までの時間    
    MAGIC_SUB_MEMBER_ANIME,        //アニメーションID
    MAGIC_SUB_MEMBER_POWER,        //威力、効果の高さ
    MAGIC_SUB_MEMBER_POWER_TYPE,   //威力の変動
    MAGIC_SUB_MEMBER_ELEMENT,      //属性
    MAGIC_SUB_MEMBER_TYPE,         //効果対象、
    MAGIC_SUB_MEMBER_RANGE,        //効果の範囲
    MAGIC_SUB_MEMBER_ROSS_SP,      //消費SP
    MAGIC_SUB_MEMBER_NAME,         //わざめい
    MAGIC_SUB_MEMBER_NUMBER,            
} MagicSubMember;


typedef enum
{
    HERO_SUB_MEMBER_LEVEL_ID,           //レベル
    HERO_SUB_MEMBER_LEVEL_EXP,          //レベルに必要な経験値
    HERO_SUB_MEMBER_LEVEL_HP,           //仲間の体力
    HERO_SUB_MEMBER_LEVEL_ATK = HERO_SUB_MEMBER_LEVEL_HP + HERO_NUMBER,     //攻撃力
    HERO_SUB_MEMBER_LEVEL_DEF = HERO_SUB_MEMBER_LEVEL_ATK + HERO_NUMBER,    //防御力
    HERO_SUB_MEMBER_LEVEL_AGI = HERO_SUB_MEMBER_LEVEL_DEF + HERO_NUMBER,    //素早さ
    HERO_SUB_MEMBER_LEVEL_MAG = HERO_SUB_MEMBER_LEVEL_AGI + HERO_NUMBER,    //魔法攻撃力
    HERO_SUB_MEMBER_LEVEL_RES = HERO_SUB_MEMBER_LEVEL_MAG + HERO_NUMBER,    //魔法防御力
    HERO_SUB_MEMBER_LEVEL_NUMBER = HERO_SUB_MEMBER_LEVEL_RES + HERO_NUMBER, 
} HeroLevelSubMemnber;

typedef enum
{
    HERO_SUB_MEMBER_SKILL_ID,       //仲間のID
    HERO_SUB_MEMBER_SKILL_LEVEL,    //スキルの習得に必要なレベル
    HERO_SUB_MEMBER_SKILL_SKILL = HERO_SUB_MEMBER_SKILL_LEVEL + SKILL_MAX,  //習得スキル
    HERO_SUB_MEMBER_SKILL_NUMBER = HERO_SUB_MEMBER_SKILL_SKILL + SKILL_MAX,
} HeroSkillSubMember;

typedef enum
{
    REGION_SUB_MEMBER_ID,
    REGION_SUB_MEMBER_ENEMY_1,
    REGION_SUB_MEMBER_ENEMY_2,
    REGION_SUB_MEMBER_ENEMY_3,
    REGION_SUB_MEMBER_ENEMY_4,
    REGION_SUB_MEMBER_ENEMY_5,
    REGION_SUB_MEMBER_ENEMY_6,
    REGION_SUB_MEMBER_ENEMY_7,
    REGION_SUB_MEMBER_ENEMY_8,
    REGION_SUB_MEMBER_FORMATION_1,
    REGION_SUB_MEMBER_FORMATION_2,
    REGION_SUB_MEMBER_FORMATION_3,
    REGION_SUB_MEMBER_FORMATION_4,
    REGION_SUB_MEMBER_NUMBER,
} RegionSubMember;

typedef enum
{
    FORMATION_SUB_MEMBER_TYPE_ID,
    FORMATION_SUB_MEMBER_ENEMY_NUM,
    FORMATION_SUB_MEMBER_ENEMY_SIZE,
    FORMATION_SUB_MEMBER_DRAW_XPOS_1,
    FORMATION_SUB_MEMBER_DRAW_XPOS_2,
    FORMATION_SUB_MEMBER_DRAW_XPOS_3,
    FORMATION_SUB_MEMBER_DRAW_XPOS_4,
    FORMATION_SUB_MEMBER_DRAW_XPOS_5,
    FORMATION_SUB_MEMBER_DRAW_XPOS_6,
    FORMATION_SUB_MEMBER_DRAW_YPOS_1,
    FORMATION_SUB_MEMBER_DRAW_YPOS_2,
    FORMATION_SUB_MEMBER_DRAW_YPOS_3,
    FORMATION_SUB_MEMBER_DRAW_YPOS_4,
    FORMATION_SUB_MEMBER_DRAW_YPOS_5,
    FORMATION_SUB_MEMBER_DRAW_YPOS_6,
    FORMATION_SUB_MEMBER_NUMBER,
} FormationSubMember;

typedef enum
{
    ENEMY_SUB_MEMBER_PARA_ID,
    ENEMY_SUB_MEMBER_PARA_SIZE,         //エネミーの隊列を判定するためのサイズ
    ENEMY_SUB_MEMBER_PARA_SRCIN,        //画像データの保存アドレス
    ENEMY_SUB_MEMBER_PARA_WIDTH,        //画像データの横の長さ
    ENEMY_SUB_MEMBER_PARA_HEIGHT,       //画像データの縦の長さ
    ENEMY_SUB_MEMBER_PARA_LEVEL,        //敵のレベル
    ENEMY_SUB_MEMBER_PARA_HP,           //敵のHP
    ENEMY_SUB_MEMBER_PARA_ATK,          //攻撃力
    ENEMY_SUB_MEMBER_PARA_DEF,          //防御力
    ENEMY_SUB_MEMBER_PARA_AGI,          //素早さ
    ENEMY_SUB_MEMBER_PARA_MAG,          //魔法攻撃力
    ENEMY_SUB_MEMBER_PARA_RES,          //魔法防御力
    ENEMY_SUB_MEMBER_PARA_SKILL_NUM,    //スキルの数
    ENEMY_SUB_MEMBER_PARA_SKILL_1,      //敵のコマンド1
    ENEMY_SUB_MEMBER_PARA_SKILL_2,      //敵のコマンド2
    ENEMY_SUB_MEMBER_PARA_SKILL_3,      //敵のコマンド3
    ENEMY_SUB_MEMBER_PARA_REGISTER,     //属性耐性
    ENEMY_SUB_MEMBER_PARA_ENCHANT,      //開始時にかかっているバフ効果
    ENEMY_SUB_MEMBER_PARA_ATB_GAUGE,    //開始時のATBゲージ
    ENEMY_SUB_MEMBER_PARA_EXP,          //倒したときの経験値量
    ENEMY_SUB_MEMBER_PARA_GOLD,         //倒したときのお金
    ENEMY_SUB_MEMBER_PARA_DROP_ITEM,    //ドロップアイテム
    ENEMY_SUB_MEMBER_PARA_DROP_CHANCE,  //アイテムを落とす確率
    ENEMY_SUB_MEMBER_PARA_ESCAPE,       //逃げる確率
    // ENEMY_SUB_MEMBER_PARA_NAME,         //名前
    ENEMY_SUB_MEMBER_PARA_NUMBER,       //メンバの最大数
} EnemyParaSubMember;


typedef enum
{
    ANIME_SUB_MEMBER_MAGIC_ID,            //技のID
    ANIME_SUB_MEMBER_MAGIC_SRCIN,         //技のエフェクト保存用アドレス
    ANIME_SUB_MEMBER_MAGIC_XSIZE,         //わざエフェクトのwidth
    ANIME_SUB_MEMBER_MAGIC_YSIZE,         //わざエフェクトのheight
    ANIME_SUB_MEMBER_MAGIC_LOOP_COUNT,    //わざのアニメーションの枚数
    ANIME_SUB_MEMBER_MAGIC_LOOP_POSITION, //わざのアニメーションループ時の開始枚数
    ANIME_SUB_MEMBER_MAGIC_ANIME_CNT,     //わざのアニメーションの更新時間
    ANIME_SUB_MEMBER_MAGIC_ANIME_TIME,    //わざ発動までの時間
    ANIME_SUB_MEMBER_MAGIC_SOUND_ID,      //わざの効果音のアドレス
    ANIME_SUB_MEMBER_MAGIC_NUMBER,        //最大数
} AnimationEffectNumber;

typedef enum
{
    CONDITION_SUB_MEMBER_ANIME_CONDIBIT,    // 状態異常のID
    CONDITION_SUB_MEMBER_ANIME_SRCIN,       // ループアニメーションの画像データアドレス
    CONDITION_SUB_MEMBER_ANIME_WIDTH,       // 画像データの横幅
    CONDITION_SUB_MEMBER_ANIME_HEIGHT,      // 画像データの縦幅
    CONDITION_SUB_MEMBER_ANIME_ANIME_CNT,   // アニメーション数
    CONDITION_SUB_MEMBER_ANIME_ANIME_TIME,  // アニメーション更新タイム
    CONDITION_SUB_MEMBER_ANIME_SOUND_ID,    // 音源データ
    CONDITION_SUB_MEMBER_ANIME_NUMBER,
} AnimationConditionNumber;

typedef enum
{
    STATUS_SUB_MEMBER_CONFIG_ELEMENT,       //ステータス操作ID
    STATUS_SUB_MEMBER_CONFIG_POWER,         //ステータスの上昇値と下降値
    STATUS_SUB_MEMBER_CONFIG_ENABLE_BIT,    //どのステータスを操作するか選択
    STATUS_SUB_MEMBER_CONFIG_NUMBER,        //データべ―スのメンバ数
} StatusConfigNumber;

typedef enum
{
    ELEMENT_SUB_MEMBER_ELEMENT,             //魔法攻撃時の効果の定数名を指定
    ELEMENT_SUB_MEMBER_TYPE_BIT,            //攻撃の属性
    ELEMENT_SUB_MEMBER_NUMBER,              //データべ―スのメンバ数
} ElementTypeNumber;

typedef enum
{
    CONDITION_SUB_MEMBER_ELEMENT,           // 状態異常の技の属性
    CONDITION_SUB_MEMBER_TYPE_BIT,          // 状態異常の耐性と属性を定義
    CONDITION_SUB_MEMBER_CONDITION_BIT,     // 状態異常のID
    CONDITION_SUB_MEMBER_NUMBER,
} ConditionTypeNumber;

typedef enum
{
    DTM_SUB_MEMBER_ID,
    DTM_SUB_MEMBER_FILE_ID,                 //
    DTM_SUB_MEMBER_BGM_ADDR,                // DRAMの音源データが保存されているアドレス
    DTM_SUB_MEMBER_SOUND_LOOP,              // loopの有無
    DTM_SUB_MEMBER_VOLUME,                  // 基本音量
    DTM_SUB_MEMBER_NUMBER,
} SoundDtmNumber;

typedef enum
{
    NPC_SUB_MEMBER_MAP_ID,                  /* マップのID */
    NPC_SUB_MEMBER_MAP_NPC_NUM_0,           /* NPCの連番*/
    NPC_SUB_MEMBER_MAP_NPC_NUM_1,           /* NPCの連番*/
    NPC_SUB_MEMBER_MAP_NPC_NUM_2,           /* NPCの連番*/
    NPC_SUB_MEMBER_MAP_NPC_NUM_3,           /* NPCの連番*/
    NPC_SUB_MEMBER_MAP_NPC_NUM_4,           /* NPCの連番*/
    NPC_SUB_MEMBER_MAP_NPC_NUM_5,           /* NPCの連番*/
    NPC_SUB_MEMBER_MAP_NPC_NUM_6,           /* NPCの連番*/
    NPC_SUB_MEMBER_MAP_NPC_NUM_7,           /* NPCの連番*/
    NPC_SUB_MEMBER_MAP_NPC_NUM_8,           /* NPCの連番*/
    NPC_SUB_MEMBER_MAP_NPC_NUM_9,           /* NPCの連番*/
    NPC_SUB_MEMBER_MAP_NPC_NUM_10,          /* NPCの連番*/
    NPC_SUB_MEMBER_MAP_NUMBER,
} NpcMapNUmber;

typedef enum
{
    NPC_SUB_MEMBER_PATTERN_MAP_NPCID,       /* NPCの連番 */
    NPC_SUB_MEMBER_PATTERN_NPCID,           /* NPCのID */
    NPC_SUB_MEMBER_PATTERN_XINIT,           /* NPCの描画初期x */
    NPC_SUB_MEMBER_PATTERN_YINIT,           /* NPCの描画初期y */
    NPC_SUB_MEMBER_PATTERN_RANGE_LEFT,      /* 初期位置からの左方向に移動できる量 */
    NPC_SUB_MEMBER_PATTERN_RANGE_RIGHT,     /* 初期位置からの右方向に移動できる量 */
    NPC_SUB_MEMBER_PATTERN_RANGE_UP,        /* 初期位置からの上方向に移動できる量 */
    NPC_SUB_MEMBER_PATTERN_RANGE_DOWN,      /* 初期位置からの下方向に移動できる量 */
    NPC_SUB_MEMBER_PATTERN_ACTION_SPEED,    /* アニメーション時の速度 */
    NPC_SUB_MEMBER_PATTERN_UPDATE_SPEED,    /* A地点からB地点に動き出す更新時間 */
    NPC_SUB_MEMBER_PATTERN_MAPCHIP_SPEED,   /* マップチップの更新時間 */
    NPC_SUB_MEMBER_PATTERN_ACTION_PATTERN,  /* アニメーションの種類 */
    NPC_SUB_MEMBER_PATTERN_NUMBER,
} NpcPatternNumber;

typedef enum
{
    NPC_SUB_MEMBER_EVENT_MAP_NPCID,
    NPC_SUB_MEMBER_EVENT_ID,
    NPC_SUB_MEMBER_EVENT_FLAG,
    NPC_SUB_MEMBER_EVENT_GET_FLAG,
    NPC_SUB_MEMBER_EVENT_NUMBER,
} NpcEventNumber;

typedef enum
{
    NPC_SUB_MEMBER_BITMAP_ID,               // NPCのID
    NPC_SUB_MEMBER_BITMAP_SRCIN,            // NPCの画像データアドレス
    NPC_SUB_MEMBER_BITMAP_XSIZE,            // 1マスの横幅
    NPC_SUB_MEMBER_BITMAP_YSIZE,            // 1マスの縦幅
    NPC_SUB_MEMBER_BITMAP_MAPCHIPID,        // マップチップの開始ID
    NPC_SUB_MEMBER_BITMAP_NUMBER,
} NpcBitmapNumber;

typedef enum
{
    SIN_SUB_MEMBER_DATA,                    /* sinデータテーブル */
    SIN_SUB_MEMBER_NUMBER,
} SinTable;

typedef enum
{
    COS_SUB_MEMBER_DATA,                    /* cosデータテーブル */
    COS_SUB_MEMBER_NUMBER,
} CosTable;

typedef enum
{
    TYPE_STR_SUB_MEMBER_BIT,
    TYPE_STR_SUB_MEMBER_MSG,                /* 属性を表す一文字の文字 */
    TYPE_STR_SUB_MEMBER_NUMBER,
} TypeBitStr;
#endif
