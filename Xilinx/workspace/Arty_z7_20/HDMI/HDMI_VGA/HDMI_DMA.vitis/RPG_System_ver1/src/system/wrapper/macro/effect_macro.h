/*
 * Create 2021/07/05
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
 * エフェクトに関する定数を管理するヘッダーファイル
 */
#ifndef effect_macro_h   /* prevent circular inclusions */
#define effect_macro_h   /* by using protection macros */


/*
 * ver1. 2021/07/05
 * エフェクトデータベースにアクセスするためのエフェクト名を定義
 */
typedef enum
{
	E_MAGIC_ACTIVE,
	E_ESCAPE_ACTIVE,
	E_SWAP_ACTIVE,
	E_TALK_ACTIVE,
	E_SLASH_1,
	E_BRAW_1,
	E_MINORIKO_1,
	E_MINORIKO_2,
	E_MINORIKO_3,
	E_MINORIKO_4,
	E_MINORIKO_5,
	E_MINORIKO_6,
	E_MINORIKO_7,
	E_MINORIKO_8,
	E_MINORIKO_9,
	E_MINORIKO_10,
	E_SIZUHA_1,
	E_SIZUHA_2,
	E_SIZUHA_3,
	E_SIZUHA_4,
	E_SIZUHA_5,
	E_SIZUHA_6,
	E_SIZUHA_7,
	E_SIZUHA_8,
	E_SIZUHA_9,
	E_SIZUHA_10,
	E_KANAKO_1,
	E_KANAKO_2,
	E_KANAKO_3,
	E_KANAKO_4,
	E_KANAKO_5,
	E_KANAKO_6,
	E_KANAKO_7,
	E_KANAKO_8,
	E_KANAKO_9,
	E_KANAKO_10,
	E_KOGASA_1,
	E_KOGASA_2,
	E_KOGASA_3,
	E_KOGASA_4,
	E_KOGASA_5,
	E_KOGASA_6,
	E_KOGASA_7,
	E_KOGASA_8,
	E_KOGASA_9,
	E_KOGASA_10,
	E_YUUKA_1,
	E_YUUKA_2,
	E_YUUKA_3,
	E_YUUKA_4,
	E_YUUKA_5,
	E_YUUKA_6,
	E_YUUKA_7,
	E_YUUKA_8,
	E_YUUKA_9,
	E_YUUKA_10,
	E_REMIRIA_1,
	E_REMIRIA_2,
	E_REMIRIA_3,
	E_REMIRIA_4,
	E_REMIRIA_5,
	E_REMIRIA_6,
	E_REMIRIA_7,
	E_REMIRIA_8,
	E_REMIRIA_9,
	E_REMIRIA_10,
	E_SATORI_1,
	E_SATORI_2,
	E_SATORI_3,
	E_SATORI_4,
	E_SATORI_5,
	E_SATORI_6,
	E_SATORI_7,
	E_SATORI_8,
	E_SATORI_9,
	E_SATORI_10,
	E_TENSI_1,
	E_TENSI_2,
	E_TENSI_3,
	E_TENSI_4,
	E_TENSI_5,
	E_TENSI_6,
	E_TENSI_7,
	E_TENSI_8,
	E_TENSI_9,
	E_TENSI_10,
	ENEMY_MAGIC_ID_1,
	ENEMY_MAGIC_ID_2,
	ENEMY_MAGIC_ID_3,
	E_END,
} EffectName;


/*
 * ver1. 2021/07/05
 * わざの属性を定義
 */
typedef enum
{
	/* 攻撃系 */
	E_DAMEGE_START,
	E_DAMAGE_ATTACK,			//物理
	E_DAMAGE_ATTACK_FIRE,		//炎物理
	E_DAMAGE_ATTACK_THUNDER,	//雷物理
	E_DAMAGE_ATTACK_ICE,		//氷物理
	E_DAMAGE_ATTACK_GROUND,		//土物理
	E_DAMAGE_ATTACK_GOD,		//神物理
	E_DAMAGE_ATTACK_SPLIT,		//霊物理
	E_DAMAGE_ATTACK_NON,		//無属性
	E_DAMAGE_MAGIC_FIRE,		//炎魔法
	E_DAMAGE_MAGIC_THUNDER,		//雷魔法
	E_DAMAGE_MAGIC_ICE,			//氷魔法
	E_DAMAGE_MAGIC_GROUND,		//土魔法
	E_DAMAGE_MAGIC_GOD,			//神魔法
	E_DAMAGE_MAGIC_SPLIT,		//霊魔法
	E_DAMAGE_MAGIC_NON,			//無属性
	E_DAMEGE_END,

	/* 回復系 */
	E_HEAL_START,
	E_HEAL,						//回復
	E_RASE,						//蘇生
	E_RECOVERY,					//状態異常回復
	E_RANDOM,					//ランダム
	E_HEAL_END,

	/* 状態異常系 */
	E_CONDITION_START,
	E_REGENE,					//リジェネ
	E_GUARD_REMIRIA,			//90%ガード
	E_POISON_1,					//単体毒
	E_POISON_2,					//全体毒
	E_CONFIG_1,					//単体混乱
	E_CONFIG_2,					//全体混乱
	E_BERSERK_1,				//単体バーサク
	E_BERSERK_2,				//全体バーサク
	E_STONE_1,					//単体石化
	E_STONE_2,					//全体石化
	E_PARALY_1,					//単体マヒ
	E_PARALY_2,					//全体マヒ
	E_CONDITION_END,

	/* バフデバフ系 */
	E_STATUS_START,
	E_BREAK_REMIRIA,			//補正値を戻す
	E_ATTACK_UP_1,				//単体攻撃上昇
	E_ATTACK_UP_2,				//全体攻撃上昇
	E_DEF_UP_1,					//単体防御上昇
	E_DEF_UP_2,					//全体防御上昇
	E_MAG_UP_1,					//単体魔攻上昇
	E_MAG_UP_2,					//全体魔攻上昇
	E_RES_UP_1,					//単体魔防上昇
	E_RES_UP_2,					//全体魔防上昇
	E_SPEED_UP_1,				//単体素早さ上昇
	E_SPEED_UP_2,				//全体素早さ上昇
	E_ATTACK_DOWN_1,			//攻撃力ダウン
	E_ATTACK_DOWN_2,			//攻撃力ダウン
	E_DEF_DOWN_1,				//単体防御力ダウン
	E_DEF_DOWN_2,				//全体防御力ダウン
	E_MAG_DOWN_1,				//単体魔攻ダウン
	E_MAG_DOWN_2,				//全体魔攻ダウン
	E_RES_DOWN_1,				//単体魔防ダウン
	E_RES_DOWN_2,				//全体魔防ダウン
	E_SPEED_DOWN_1,				//単体素早さダウン
	E_SPEED_DOWN_2,				//全体素早さダウン
	E_ALL_DOWN_1,				//単体、防御、魔防、素早さダウン
	E_ALL_DOWN_2,				//全体、防御、魔防
	E_STATUS_END,
} EffectType;


/*
 * ver1. 2021/07/05
 * わざの効果範囲を定義
 */
typedef enum
{
	E_SINGLE,
	E_ALL,
} EffectRange;


/*
 * ver1. 2021/08/05
 * エフェクトのアニメーションID
 */
typedef enum
{
	A_MAGIC_ACTIVE,
	A_SLASH_1,
	A_BRAW_1,

	/* ステータス */
	A_POWER_UP_1,
	A_POWER_DOWN_1,
	A_POWER_DOWN_2,
	A_DEF_1,
	A_RES_1,
	A_HEST_1,
	A_SLOW_1,

	/* 回復 */
	A_HEAL_1,
	A_ESNA_1,
	A_RISE_1,

	/* 状態異常 */
	A_CONFIG_1,
	A_POISON_1,
	A_PARARAI_1,
	A_BERSEK_1,
	A_RIGENE_1,

	/* 専用技 */
	A_KANAKO_8,
	A_REMIRIA_7,
	A_EFFECT_END,
} AnimationEffectID;

#endif
