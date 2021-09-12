/*
 * Create 2021/08/05
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 */
#ifndef animation_h   /* prevent circular inclusions */
#define animation_h   /* by using protection macros */


/* データベースの要素数 */
#define ANIAMTION_DB_SIZE  ((sizeof (animation_effect))	/ (sizeof (AnimationEffect)))
#define CONDITION_ANIAMTION_DB_SIZE  ((sizeof (animation_condition)) / (sizeof (AnimationCondition)))


/*
 * ver1. 2021/08/05
 * アニメーション画像データの動作に必要なデータを管理するデータベース
 * 
 * id		    	アニメーションID
 * srcin			アニメーション描画データが保存されているDRAMのアドレス
 * xsize	    	アニメーションのxサイズ
 * ysize	    	アニメーションのyサイズ
 * loop_count		アニメーションの繰り返し回数
 * loop_count		アニメーションの繰り返し時の開始枚数
 * animation_cnt	アニメーションの枚数
 * animation_time	アニメーションの描画速度
 * sound_id			使用する音源
 */
typedef struct
{
	uint32_t id;
	uint32_t srcin;
	uint32_t xsize;
    uint32_t ysize;
	uint32_t loop_count;
	uint32_t loop_position;
	uint32_t animation_cnt;
	uint32_t animation_time;
	uint32_t sound_id;
} AnimationEffect;

static const AnimationEffect animation_effect[] = {
	/* 通常攻撃や魔法発動 */
	{	A_MAGIC_ACTIVE,	DRAM_EFFECT_BATTLE_MAGIC_1_ADDR_BASE,		96, 	96,		1, 0, 15, TM_30MS_COUNT, SOUND_ID_BATTLE_MAGIC_1,	},
	{	A_SLASH_1,		DRAM_EFFECT_BATTLE_SLASH_1_ADDR_BASE,		120, 	120,	2, 0,  9, TM_15MS_COUNT, SOUND_ID_BATTLE_KNIFE,		},
	{	A_BRAW_1,		DRAM_EFFECT_BATTLE_BROW_1_ADDR_BASE,		120, 	120,	2, 0, 10, TM_15MS_COUNT, SOUND_ID_BATTLE_BRAW_1,	},

	/* ステータス */
	{	A_POWER_UP_1,	DRAM_EFFECT_BATTLE_POWER_UP_ADDR_BASE,		96, 	96,		1, 0, 15, TM_30MS_COUNT, SOUND_ID_BATTLE_POWER_UP,	},
	{	A_POWER_DOWN_1,	DRAM_EFFECT_BATTLE_POWER_DOWN_ADDR_BASE,	96, 	96,		1, 0, 15, TM_30MS_COUNT, SOUND_ID_BATTLE_POWER_DOWN,},
	{	A_POWER_DOWN_2,	DRAM_EFFECT_BATTLE_POWER_DOWN_2_ADDR_BASE,	96, 	96,		1, 0, 15, TM_30MS_COUNT, SOUND_ID_BATTLE_POWER_DOWN,},
	{	A_DEF_1,		DRAM_EFFECT_BATTLE_DEF_1_ADDR_BASE,			96, 	96,		1, 0, 15, TM_30MS_COUNT, SOUND_ID_BATTLE_DEF_1,		},
	{	A_RES_1,		DRAM_EFFECT_BATTLE_RES_1_ADDR_BASE,			96, 	96,		1, 0, 15, TM_30MS_COUNT, SOUND_ID_BATTLE_DEF_1,		},
	{	A_HEST_1,		DRAM_EFFECT_BATTLE_HEST_1_ADDR_BASE,		96, 	96,		1, 0, 15, TM_80MS_COUNT, SOUND_ID_BATTLE_HEST_1,	},
	{	A_SLOW_1,		DRAM_EFFECT_BATTLE_SLOW_1_ADDR_BASE,		96, 	96,		1, 0, 20, TM_80MS_COUNT, SOUND_ID_BATTLE_SLOW_1,	},

	/* 回復系 */
	{	A_HEAL_1,		DRAM_EFFECT_BATTLE_HEAL_1_ADDR_BASE,		96, 	96,		1, 0, 15, TM_30MS_COUNT, SOUND_ID_BATTLE_HEAL_1,	},
	{	A_ESNA_1,		DRAM_EFFECT_BATTLE_ESNA_1_ADDR_BASE,		96, 	96,		1, 0, 15, TM_30MS_COUNT, SOUND_ID_BATTLE_ESNA_1,	},
	{	A_RISE_1,		DRAM_EFFECT_BATTLE_RISE_1_ADDR_BASE,		96, 	96,		1, 0, 15, TM_30MS_COUNT, SOUND_ID_BATTLE_RISE_1,	},

	/* 状態異常 */
	{	A_CONFIG_1,		DRAM_EFFECT_BATTLE_CONFIG_1_ADDR_BASE,		96, 	96,		2, 0, 10, TM_15MS_COUNT, SOUND_ID_BATTLE_CONFIG_1,	},
	{	A_POISON_1,		DRAM_EFFECT_BATTLE_POISON_1_ADDR_BASE,		96, 	96,		1, 0, 15, TM_30MS_COUNT, SOUND_ID_BATTLE_POISON_1,	},
	{	A_PARARAI_1,	DRAM_EFFECT_BATTLE_PARARAI_1_ADDR_BASE,		96, 	96,		1, 0, 20, TM_30MS_COUNT, SOUND_ID_BATTLE_PARARAI_1,	},
	{	A_BERSEK_1,		DRAM_EFFECT_BATTLE_BERSEK_1_ADDR_BASE,		96, 	96,		1, 0, 15, TM_30MS_COUNT, SOUND_ID_BATTLE_POWER_UP,	},
	{	A_RIGENE_1,		DRAM_EFFECT_BATTLE_RIGENE_1_ADDR_BASE,		96, 	96,		1, 0, 15, TM_30MS_COUNT, SOUND_ID_BATTLE_ESNA_1,	},

	/* 専用技 */
	{	A_KANAKO_8,		DRAM_EFFECT_KANAKO_8_ADDR_BASE, 			640,    480,	1, 0, 20, TM_30MS_COUNT, SOUND_ID_BATTLE_KANAKO_8,	},
	{	A_REMIRIA_7,	DRAM_EFFECT_REMIRIA_7_ADDR_BASE,			96, 	96,		1, 0, 20, TM_30MS_COUNT, SOUND_ID_BATTLE_DEF_1,		},
};


/*
 * ver1. 2021/08/09
 * 状態異常中のループアニメーションを管理するデータベース
 * 
 * id		    	アニメーションID
 * srcin			アニメーション描画データが保存されているDRAMのアドレス
 * xsize	    	アニメーションのxサイズ
 * ysize	    	アニメーションのyサイズ
 * animation_cnt	アニメーションの枚数
 * animation_time	アニメーションの描画速度
 * sound_id			使用する音源
 */
typedef struct
{
	uint32_t condition_bit;
	uint32_t srcin;
	uint32_t xsize;
    uint32_t ysize;
	uint32_t animation_cnt;
	uint32_t animation_time;
	uint32_t sound_id;
} AnimationCondition;

static const AnimationCondition animation_condition[] = {
	{UNIT_CONDITION_CONFIG,		DRAM_EFFECT_BATTLE_CONFIG_2_ADDR_BASE,	96, 96, 10, TM_30MS_COUNT, 0},		//こんらん
	{UNIT_CONDITION_POISON,		DRAM_EFFECT_BATTLE_POISON_2_ADDR_BASE,	96, 96, 15,	TM_30MS_COUNT, 0},		//毒
	{UNIT_CONDITION_PARARAI,	DRAM_EFFECT_BATTLE_PARARAI_2_ADDR_BASE,	96, 96, 10,	TM_30MS_COUNT, 0},		//まひ
	{UNIT_CONDITION_BERSEK,		DRAM_EFFECT_BATTLE_BERSEK_2_ADDR_BASE,	96, 96, 15,	TM_30MS_COUNT, 0},		//バーサク
	{UNIT_CONDITION_RIFREK,		DRAM_EFFECT_BATTLE_REFREK_2_ADDR_BASE,	96, 96, 15,	TM_30MS_COUNT, 0},		//リフレク
	{UNIT_CONDITION_RIGENE,		DRAM_EFFECT_BATTLE_RIGENE_2_ADDR_BASE,	96, 96, 10,	TM_30MS_COUNT, 0},		//リジェネ
};


/*
 * ver1. 2021/07/20
 * エフェクトのアニメーションデータの書き出し
 */
void anime_effect_write(FILE *fp, FILE *byte)
{
	const AnimationEffect *p = animation_effect;

	for (uint32_t i = 0; i < ANIAMTION_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->id);
		fprintf(fp, "0x%08x,\n", p->srcin);
		fprintf(fp, "0x%08x,\n", p->xsize);
		fprintf(fp, "0x%08x,\n", p->ysize);
		fprintf(fp, "0x%08x,\n", p->loop_count);
		fprintf(fp, "0x%08x,\n", p->loop_position);
		fprintf(fp, "0x%08x,\n", p->animation_cnt);
		fprintf(fp, "0x%08x,\n", p->animation_time);
		fprintf(fp, "0x%08x,\n", p->sound_id);

		for (uint32_t j = 0; j < ANIME_SUB_MEMBER_MAGIC_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	printf("ANIMATION TOTAL NUMBER = %ld\n", ANIAMTION_DB_SIZE);
}


/*
 * ver1. 2021/07/20
 * 状態異常のアニメーションループデータの書き出し
 */
void anime_condition_write(FILE *fp, FILE *byte)
{
	const AnimationCondition *p = animation_condition;

	for (uint32_t i = 0; i < CONDITION_ANIAMTION_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->condition_bit);
		fprintf(fp, "0x%08x,\n", p->srcin);
		fprintf(fp, "0x%08x,\n", p->xsize);
		fprintf(fp, "0x%08x,\n", p->ysize);
		fprintf(fp, "0x%08x,\n", p->animation_cnt);
		fprintf(fp, "0x%08x,\n", p->animation_time);
		fprintf(fp, "0x%08x,\n", p->sound_id);

		for (uint32_t j = 0; j < CONDITION_SUB_MEMBER_ANIME_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	printf("ANIMATION CONDITION TOTAL NUMBER = %ld\n", CONDITION_ANIAMTION_DB_SIZE);
}

#endif