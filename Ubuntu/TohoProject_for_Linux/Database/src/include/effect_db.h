/*
 * Create 2021/07/02
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * イベント時に発生するメッセージ描画文字列を管理するヘッダーファイル
 * sjisのフォントデータを使用するためファイルのエンコード設定をsjisに変更する
 */
#ifndef effect_db_h   /* prevent circular inclusions */
#define effect_db_h   /* by using protection macros */

#include "macro/effect_msg_macro.h"

/* データベースの要素数 */
#define EFFECT_MAGIC_DB_SIZE  ((sizeof (effect_magic))	/ (sizeof (EffectMagic)))


/*
 * ver1. 2021/07/05
 * キャラクターのわざのデータを管理するデータベース
 * -
 * id		    エフェクトID
 * wait_time	発動までの待機時間
 * anime_id		使用するアニメーションIDを保存
 * power	    威力を管理
 * power_type	技の威力のパターン
 * 0. 通常
 * 1. ダメージが少ないほどUP
 * 2. ダメージが多いほどUP
 * 3. 好感度が高いほどUP
 * 
 * element	    属性
 * type		    基本効果対象
 * range	    効果範囲
 * ross_sp	    消費sp
 */
typedef struct
{
	uint32_t id;
	uint32_t wait_time;
    uint32_t anime_id;
	uint32_t power;
	uint32_t power_type;
	uint32_t element;
	uint32_t type;
	uint32_t range;
	uint32_t ross_sp;
    const char *name;
} EffectMagic;

/* メンバを追加、メンバ変数の値を変更、アドレスの変更をした場合必ずファイルを出力し更新すること 空白は0x8140*/
static const EffectMagic effect_magic[] = {
    {E_MAGIC_ACTIVE,  0, A_MAGIC_ACTIVE, 0, 0, 0, 0, 0, 0, "なし",},		//魔法発動陣
    {E_ESCAPE_ACTIVE, 0, A_MAGIC_ACTIVE, 0, 0, 0, 0, 0, 0, "なし",},		//逃走
    {E_SWAP_ACTIVE,   0, A_MAGIC_ACTIVE, 0, 0, 0, 0, 0, 0, "なし",},		//入れ替え
    {E_ESCAPE_ACTIVE, 0, A_MAGIC_ACTIVE, 0, 0, 0, 0, 0, 0, "なし",},		//逃走
	{E_SLASH_1,     TM_2SEC_COUNT, A_SLASH_1, 		   100, 0, E_DAMAGE_ATTACK,        COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 0,      "たたかう",},
	{E_BRAW_1,      TM_2SEC_COUNT, A_BRAW_1, 		   100, 0, E_DAMAGE_ATTACK,        COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 0,      "たたかう",},
	{E_MINORIKO_1,  TM_2SEC_COUNT, A_POWER_UP_1, 	     0, 0, E_ATTACK_UP_1,          COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE, 1,      "ちからため",},
	{E_MINORIKO_2,  TM_2SEC_COUNT, A_BRAW_1, 		   105, 0, E_DAMAGE_ATTACK,        COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 2,      "芋沙雨",},
	{E_MINORIKO_3,  TM_2SEC_COUNT, A_HEAL_1, 		    20, 0, E_HEAL,                 COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE, 2,      "芋ぐい",},
	{E_MINORIKO_4,  TM_2SEC_COUNT, A_BRAW_1, 		   115, 0, E_DAMAGE_ATTACK,        COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 3,      "芋パンチ",},
	{E_MINORIKO_5,  TM_2SEC_COUNT, A_BRAW_1, 		    90, 0, E_DAMAGE_ATTACK,        COMMAND_BATTLE_ATTACK_ENEMY, E_ALL,    4,      "五月雨芋",},
	{E_MINORIKO_6,  TM_2SEC_COUNT, A_HEAL_1, 		    15, 0, E_HEAL,                 COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    10,     "芋カーニバル",},
	{E_MINORIKO_7,  TM_2SEC_COUNT, A_BRAW_1, 		   125, 0, E_DAMAGE_ATTACK,        COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 6,      "芋キャノン",},
	{E_MINORIKO_8,  TM_2SEC_COUNT, A_BRAW_1, 		   110, 0, E_DAMAGE_ATTACK,        COMMAND_BATTLE_ATTACK_ENEMY, E_ALL,    10,     "大豊作",},
	{E_MINORIKO_9,  TM_2SEC_COUNT, A_SLASH_1, 		   125, 0, E_DAMAGE_ATTACK_GOD,    COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 11,     "芋神剣",},
	{E_MINORIKO_10, TM_2SEC_COUNT, A_BRAW_1, 		   135, 0, E_DAMAGE_ATTACK_GOD,    COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 20,     "ゴッド芋クラッシュ",},
	{E_SIZUHA_1,    TM_2SEC_COUNT, A_HEAL_1, 		    55, 0, E_HEAL,                 COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE,  3,     "秋ヒール",},
	{E_SIZUHA_2,    TM_2SEC_COUNT, A_ESNA_1, 		     0, 0, E_RECOVERY,             COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE,  1,     "秋リカバー",},
	{E_SIZUHA_3,    TM_2SEC_COUNT, A_RISE_1, 		    10, 0, E_RASE,                 COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE,  5,     "秋ライズ",},
	{E_SIZUHA_4,    TM_2SEC_COUNT, A_HEAL_1, 		    90, 0, E_HEAL,                 COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE,  5,     "秋キュア",},
	{E_SIZUHA_5,    TM_2SEC_COUNT, A_RIGENE_1, 		     0, 0, E_REGENE,		       COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE,  5,     "秋リジェネ",},
	{E_SIZUHA_6,    TM_2SEC_COUNT, A_HEAL_1, 		    80, 0, E_HEAL,                 COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,     10,    "秋オーバーヒール",},
	{E_SIZUHA_7,    TM_2SEC_COUNT, A_SLASH_1, 		    70, 0, E_DAMAGE_MAGIC_GOD,     COMMAND_BATTLE_MAGIC_ENEMY,  E_ALL,     5,     "もみじ嵐",},
	{E_SIZUHA_8,    TM_2SEC_COUNT, A_HEST_1,    	     0, 0, E_SPEED_UP_2,           COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE,  9,     "秋ヘイスト",},
	{E_SIZUHA_9,    TM_2SEC_COUNT, A_SLASH_1, 		   125, 0, E_DAMAGE_MAGIC_GOD,     COMMAND_BATTLE_MAGIC_ENEMY,  E_SINGLE, 13,     "秋乱舞",},
	{E_SIZUHA_10,   TM_2SEC_COUNT, A_HEAL_1, 		   125, 0, E_HEAL,                 COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    20,     "慈愛の心",},
	{E_KANAKO_1,    TM_3SEC_COUNT, A_BRAW_1,		    90, 0, E_DAMAGE_ATTACK_SPLIT,  COMMAND_BATTLE_ATTACK_ENEMY, E_ALL,    5,      "一柱・以一当千",},
	{E_KANAKO_2,    TM_2SEC_COUNT, A_BRAW_1,		   115, 0, E_DAMAGE_ATTACK_GOD,    COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 4,      "二柱・遮二無二",},
	{E_KANAKO_3,    TM_2SEC_COUNT, A_BRAW_1, 		    90, 0, E_DAMAGE_ATTACK_GOD,    COMMAND_BATTLE_ATTACK_ENEMY, E_ALL,    6,      "三柱・三千世界",},
	{E_KANAKO_4,    TM_2SEC_COUNT, A_SLOW_1, 		     0, 0, E_SPEED_DOWN_1,         COMMAND_BATTLE_MAGIC_ENEMY,  E_SINGLE, 9,      "四柱・桃三李四",},
	{E_KANAKO_5,    TM_2SEC_COUNT, A_BRAW_1, 		   120, 0, E_DAMAGE_ATTACK,        COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 7,      "五柱・五濁悪世",},
	{E_KANAKO_6,    TM_2SEC_COUNT, A_BRAW_1, 		     0, 0, E_RECOVERY,             COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE, 3,      "六柱・六根清浄",},
	{E_KANAKO_7,    TM_2SEC_COUNT, A_BERSEK_1,		     0, 0, E_BERSERK_1,	           COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE, 9,      "七柱・七転八起",},
	{E_KANAKO_8,    TM_2SEC_COUNT, A_KANAKO_8, 		   115, 0, E_DAMAGE_ATTACK_GOD,    COMMAND_BATTLE_ATTACK_ENEMY, E_ALL,    15,     "八柱・八大地獄",},
	{E_KANAKO_9,    TM_2SEC_COUNT, A_RISE_1, 		     1, 0, E_RASE,                 COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE, 15,     "九柱・九品往生",},
	{E_KANAKO_10,   TM_2SEC_COUNT, A_BRAW_1, 		   135, 0, E_DAMAGE_ATTACK_GOD,    COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 17,     "御柱・怪力乱神",},
	{E_KOGASA_1,    TM_2SEC_COUNT, A_POWER_DOWN_2,	     0, 0, E_DEF_DOWN_1,		   COMMAND_BATTLE_MAGIC_ENEMY,  E_SINGLE, 2,      "おどろけー！",},
	{E_KOGASA_2,    TM_2SEC_COUNT, A_DEF_1, 		     0, 0, E_DEF_UP_2,             COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    4,      "たちあがれー！",},
	{E_KOGASA_3,    TM_2SEC_COUNT, A_HEAL_1, 		    65, 0, E_HEAL,                 COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE, 6,      "がんばれー！",},
	{E_KOGASA_4,    TM_2SEC_COUNT, A_RES_1,			     0, 0, E_RES_UP_2,             COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    4,      "きらめけー！",},
	{E_KOGASA_5,    TM_2SEC_COUNT, A_POWER_DOWN_2,	     0, 0, E_RES_DOWN_1,           COMMAND_BATTLE_MAGIC_ENEMY,  E_SINGLE, 4,      "ひざまずけー！",},
	{E_KOGASA_6,    TM_2SEC_COUNT, A_POWER_DOWN_2,	     0, 0, E_ALL_DOWN_2,	       COMMAND_BATTLE_MAGIC_ENEMY,  E_ALL,    10,     "とどろけー！",},
	{E_KOGASA_7,    TM_2SEC_COUNT, A_POWER_DOWN_2,	     0, 0, E_ALL_DOWN_1,	       COMMAND_BATTLE_MAGIC_ENEMY,  E_SINGLE, 10,     "さざめけー！",},
	{E_KOGASA_8,    TM_2SEC_COUNT, A_HEST_1,		     0, 0, E_SPEED_UP_2,	       COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    10,     "けちらせー！",},
	{E_KOGASA_9,    TM_2SEC_COUNT, A_SLASH_1, 		   145, 0, E_DAMAGE_MAGIC_NON,     COMMAND_BATTLE_MAGIC_ENEMY,  E_SINGLE,  7,     "プチフラワースパーク",},
	{E_KOGASA_10,   TM_2SEC_COUNT, A_SLASH_1, 		   250, 0, E_DAMAGE_MAGIC_NON,     COMMAND_BATTLE_MAGIC_ENEMY,  E_ALL,    20,     "ダブルマスタースパーク",},
	{E_YUUKA_1,     TM_2SEC_COUNT, A_BRAW_1, 		   100, 1, E_DAMAGE_ATTACK_SPLIT,  COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 3,      "キンセンカ",},
	{E_YUUKA_2,     TM_2SEC_COUNT, A_SLASH_1, 		    70, 1, E_DAMAGE_MAGIC_SPLIT,   COMMAND_BATTLE_MAGIC_ENEMY,  E_ALL,    5,      "ホワイトレースフラワー",},
	{E_YUUKA_3,     TM_2SEC_COUNT, A_BRAW_1, 		    90, 3, E_DAMAGE_ATTACK_SPLIT,  COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 4,      "ランキュラス",},
	{E_YUUKA_4,     TM_2SEC_COUNT, A_HEAL_1, 		    50, 3, E_HEAL,                 COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE, 4,      "ドラセナ・フラグランス",},
	{E_YUUKA_5,     TM_2SEC_COUNT, A_BRAW_1, 		   105, 2, E_DAMAGE_ATTACK_SPLIT,  COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 7,      "カモミール",},
	{E_YUUKA_6,     TM_2SEC_COUNT, A_SLASH_1, 		   100, 0, E_DAMAGE_MAGIC_SPLIT,   COMMAND_BATTLE_MAGIC_ENEMY,  E_ALL,    9,      "桜吹雪",},
	{E_YUUKA_7,     TM_2SEC_COUNT, A_BRAW_1, 		   100, 3, E_DAMAGE_ATTACK_SPLIT,  COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 8,      "四つ葉のクローバー",},
	{E_YUUKA_8,     TM_2SEC_COUNT, A_HEAL_1, 		    50, 3, E_HEAL,                 COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    12,     "ユリオプスデージー",},
	{E_YUUKA_9,     TM_2SEC_COUNT, A_SLASH_1, 		   110, 3, E_DAMAGE_MAGIC_SPLIT,   COMMAND_BATTLE_MAGIC_ENEMY,  E_ALL,    16,     "フラワースパーク",},
	{E_YUUKA_10,    TM_2SEC_COUNT, A_SLASH_1, 		   250, 0, E_DAMAGE_MAGIC_NON,     COMMAND_BATTLE_MAGIC_ENEMY,  E_ALL,    20,     "ダブルマスタースパーク",},
	{E_REMIRIA_1,   TM_2SEC_COUNT, A_DEF_1,			     0, 0, E_DEF_UP_2,             COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    4,      "魔族の衣",},
	{E_REMIRIA_2,   TM_2SEC_COUNT, A_RES_1,			     0, 0, E_RES_UP_2,             COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    4,      "ドレスコード",},
	{E_REMIRIA_3,   TM_2SEC_COUNT, A_HEAL_1, 		    80, 0, E_HEAL,                 COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE, 5,      "午後のティータイム",},
	{E_REMIRIA_4,   TM_2SEC_COUNT, A_RISE_1, 		    10, 0, E_RASE,                 COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE, 6,      "悪魔のキッス",},
	{E_REMIRIA_5,   TM_2SEC_COUNT, A_HEAL_1, 		    55, 0, E_HEAL,                 COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    8,      "七曜の宴",},
	{E_REMIRIA_6,   TM_2SEC_COUNT, A_ESNA_1, 		     0, 0, E_RECOVERY,             COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE, 3,      "気功法",},
	{E_REMIRIA_7,   TM_2SEC_COUNT, A_REMIRIA_7, 	     0, 0, E_GUARD_REMIRIA,        COMMAND_BATTLE_MAGIC_UNIT,   E_SINGLE, 6,      "カリスマガード",},
	{E_REMIRIA_8,   TM_2SEC_COUNT, A_POWER_UP_1,	     0, 0, E_BREAK_REMIRIA,        COMMAND_BATTLE_MAGIC_ENEMY,  E_SINGLE, 5,      "カリスマブレイク",},
	{E_REMIRIA_9,   TM_2SEC_COUNT, A_POWER_UP_1,	     0, 0, E_ATTACK_UP_2,          COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    8,      "うー☆",},
	{E_REMIRIA_10,  TM_2SEC_COUNT, A_SLASH_1, 		   135, 0, E_DAMAGE_ATTACK_SPLIT,  COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 7,      "グングニルツイスター",},
	{E_SATORI_1,    TM_800US_COUNT,A_SLASH_1, 		   115, 0, E_DAMAGE_MAGIC_NON,     COMMAND_BATTLE_MAGIC_ENEMY,  E_SINGLE, 9,      "想起・イダテン",},
	{E_SATORI_2,    TM_2SEC_COUNT, A_HEAL_1, 		    90, 0, E_HEAL,                 COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    17,     "想起・少彦名命",},
	{E_SATORI_3,    TM_2SEC_COUNT, A_SLASH_1, 		   135, 0, E_DAMAGE_MAGIC_NON,     COMMAND_BATTLE_MAGIC_ENEMY,  E_SINGLE, 12,     "想起・天之御影命",},
	{E_SATORI_4,    TM_2SEC_COUNT, A_SLASH_1, 		   135, 0, E_DAMAGE_MAGIC_FIRE,    COMMAND_BATTLE_MAGIC_ENEMY,  E_ALL,    15,     "想起・炎雷神",},
	{E_SATORI_5,    TM_2SEC_COUNT, A_RISE_1, 		   100, 0, E_RASE,                 COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    20,     "想起・伊邪那",},
	{E_SATORI_6,    TM_2SEC_COUNT, A_SLASH_1, 		   145, 0, E_DAMAGE_MAGIC_NON,     COMMAND_BATTLE_MAGIC_ENEMY,  E_ALL,    15,     "想起・牛頭天王",},
	{E_SATORI_7,    TM_2SEC_COUNT, A_RIGENE_1, 		     0, 0, E_REGENE,               COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,    20,     "想起・天照大神",},
	{E_SATORI_8,    TM_2SEC_COUNT, A_SLASH_1, 		   155, 0, E_DAMAGE_MAGIC_NON,     COMMAND_BATTLE_MAGIC_ENEMY,  E_ALL,    22,     "想起・八咫烏",},
	{E_SATORI_9,    TM_2SEC_COUNT, A_SLASH_1, 		     0, 0, E_RANDOM,               COMMAND_BATTLE_MAGIC_ENEMY,  E_SINGLE, 3,      "想起・黒歴史",},
	{E_SATORI_10,   TM_2SEC_COUNT, A_SLASH_1, 		   200, 0, E_DAMAGE_ATTACK,        COMMAND_BATTLE_MAGIC_ENEMY,  E_SINGLE, 15,     "想起・オリュンポス十二神",},
	{E_TENSI_1,     TM_2SEC_COUNT, A_SLASH_1, 		   115, 0, E_DAMAGE_ATTACK_FIRE,   COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 4,      "炎剣",},
	{E_TENSI_2,     TM_2SEC_COUNT, A_SLASH_1, 		   115, 0, E_DAMAGE_ATTACK_ICE,    COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 4,      "氷剣",},
	{E_TENSI_3,     TM_2SEC_COUNT, A_SLASH_1, 		   115, 0, E_DAMAGE_ATTACK_THUNDER,COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 4,      "雷剣",},
	{E_TENSI_4,     TM_2SEC_COUNT, A_SLASH_1, 		   115, 0, E_DAMAGE_ATTACK_SPLIT,  COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 4,      "地剣",},
	{E_TENSI_5,     TM_2SEC_COUNT, A_SLASH_1, 		   115, 0, E_DAMAGE_ATTACK_GROUND, COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 4,      "霊剣",},
	{E_TENSI_6,     TM_2SEC_COUNT, A_SLASH_1, 		   115, 0, E_DAMAGE_ATTACK_GOD,    COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 4,      "神剣",},
	{E_TENSI_7,     TM_2SEC_COUNT, A_SLASH_1, 		   110, 0, E_DAMAGE_ATTACK_NON,    COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 10,     "天剣",},
	{E_TENSI_8,     TM_2SEC_COUNT, A_SLASH_1, 		   125, 0, E_DAMAGE_ATTACK_NON,    COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 8,      "緋想剣",},
	{E_TENSI_9,     TM_2SEC_COUNT, A_SLASH_1, 		   125, 0, E_DAMAGE_ATTACK_NON,    COMMAND_BATTLE_ATTACK_ENEMY, E_SINGLE, 17,     "天変地異",},
	{E_TENSI_10,    TM_2SEC_COUNT, A_SLASH_1, 		   180, 0, E_DAMAGE_ATTACK_NON,    COMMAND_BATTLE_MAGIC_ENEMY,  E_ALL,    27,     "メテオ",},

	/* 敵のエフェクトデータ */
    {ENEMY_MAGIC_ID_1, 			0, A_BRAW_1, 		   100, 0, E_DAMAGE_ATTACK, 	   COMMAND_BATTLE_ATTACK_UNIT,  E_SINGLE,  0,	  "こうげき"},
    {ENEMY_MAGIC_ID_2, 			0, A_BRAW_1, 		   100, 0, E_DAMAGE_ATTACK, 	   COMMAND_BATTLE_ATTACK_UNIT,  E_ALL,     0, 	  "全体攻撃"},
    {ENEMY_MAGIC_ID_3, 			0, A_POISON_1, 		     0, 0, E_POISON_2,		 	   COMMAND_BATTLE_MAGIC_UNIT,   E_ALL,     0, 	  "ポイズンブレス"},
};


/*
 * ver1. 2021/07/20
 * エフェクトデータの書き出し
 */
void magic_write(FILE *fp, FILE *byte)
{
	const EffectMagic *p = effect_magic;

	for (uint32_t i = 0; i < EFFECT_MAGIC_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->id);
		fprintf(fp, "0x%08x,\n", p->wait_time);
		fprintf(fp, "0x%08x,\n", p->anime_id);
		fprintf(fp, "0x%08x,\n", p->power);
		fprintf(fp, "0x%08x,\n", p->power_type);
		fprintf(fp, "0x%08x,\n", p->element);
		fprintf(fp, "0x%08x,\n", p->type);
		fprintf(fp, "0x%08x,\n", p->range);
		fprintf(fp, "0x%08x,\n", p->ross_sp);

		for (uint32_t j = 0; j < MAGIC_SUB_MEMBER_NUMBER-1; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
		fprintf(byte, "0x%08x,\n", sjis_write(fp, p->name));
	}

    if (EFFECT_MAGIC_DB_SIZE != E_END)
    {
        printf("--- ERROR --- EFFECT_MAGIC_DB_SIZE");
    }

	printf("MAGIC TOTAL NUMBER = %ld\n", EFFECT_MAGIC_DB_SIZE);
}



#endif