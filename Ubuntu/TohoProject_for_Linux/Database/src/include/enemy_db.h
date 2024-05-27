/*
 * Create 2021/07/19
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * -
 * エネミーデータに関するデータを管理するヘッダーファイル
 */

#ifndef enemy_db_h   /* prevent circular inclusions */
#define enemy_db_h   /* by using protection macros */


#include "macro/res_macro.h"


/*
 * 構造体の要素数
 */
#define ENEMY_DB_SIZE	  		((sizeof (enemy_db))/(sizeof (EnemyDB)))
#define ENEMY_NAME_DB_SIZE	  	((sizeof (enemy_name))/(sizeof (EnemyName)))
#define BOSS_DB_SIZE	  		((sizeof (boss_db))/(sizeof (BossDB)))
#define ENEMY_SKILL_DB_SIZE  	((sizeof (enemy_skill))	/ (sizeof (EnemySkill)))
#define ENEMY_SKILL_NAME_DB_SIZE ((sizeof (enemy_skill_name))	/ (sizeof (EnemySkillName)))



/*
 * ver1. 2021/07/19
 * 通常のエネミーデータを管理するデータベース
 * -
 * enemysize		隊列判定用のサイズ
 * srcin			画像データのアドレス
 * width			使用する画像データの横のサイズ
 * height			使用する画像データの縦のサイズ
 * -
 * skill_number		使用するわざの数
 * skill			使用するわざを指定、雑魚敵は3つ
 * reg              耐性、炎、氷、雷、地、神、霊、無、打撃、斬、傘、杖耐性
 * condition		開始時のエンチャント状態、いきなりリフレク状態など
 * atb_gauge		開始時のATBゲージの値
 * exp          	取得経験値
 * gold				取得ゴールド
 * drop_item    	落とすアイテム
 * drop_chance  	アイテムを落とす確率
 * escape			逃走する確率
 */
typedef struct enemy_db
{
    uint32_t id;
	uint32_t enemy_size;
    uint32_t srcin;
	uint32_t width;
	uint32_t height;
	uint32_t level;
    uint32_t hp;
    uint32_t atk;
    uint32_t def;
    uint32_t agi;
    uint32_t mag;
    uint32_t res;
	uint32_t skill_number;
	uint32_t skill[3];
    uint32_t reg;
    uint32_t condition;
    uint32_t atb_gauge;
	uint32_t exp;
	uint32_t gold;
	uint32_t drop_item;
	uint32_t drop_chance;
    uint32_t escape;
    // const char *name;
} EnemyDB;

static const EnemyDB enemy_db[] = {
    {MONSTER_ID_NON,0,0,0,0,0,0,0,0,0,0,0,0,{0,0,0},0,0,0,0,0,0,0,0,},
    {MONSTER_ID_1, ENEMY_SIZE_4, DRAM_ENEMY_1_ADDR_BASE, 89, 134,5,55,16,0,8,0,8,3,{ENEMY_MAGIC_ID_1,ENEMY_MAGIC_ID_1,ENEMY_MAGIC_ID_2},ENEMY_RES_1,0,30,10,8,0,0,0,},
    {MONSTER_ID_2, ENEMY_SIZE_3, DRAM_ENEMY_2_ADDR_BASE, 102,111,3,20,20,0,8,0,8,3,{ENEMY_MAGIC_ID_3,ENEMY_MAGIC_ID_3,ENEMY_MAGIC_ID_2},ENEMY_RES_2,0,30,10,8,0,0,0,},
};


/*
 * ver1. 2021/07/25
 * モンスター名を管理
 */
typedef struct
{
	uint32_t id;
	const char *name;
} EnemyName;

static const EnemyName enemy_name[] = 
{
	{MONSTER_ID_NON,"なし"},
	{MONSTER_ID_1, "赤ずきん"},
	{MONSTER_ID_2, "ヒヨコン"},
};



/*
 * ver1. 2021/07/20
 * エネミーデータの書き出し
 */
void enemy_write(FILE *fp, FILE *byte)
{
	const EnemyDB *p = enemy_db;

	for (uint32_t i = 0; i < ENEMY_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->id);
		fprintf(fp, "0x%08x,\n", p->enemy_size);
		fprintf(fp, "0x%08x,\n", p->srcin);
		fprintf(fp, "0x%08x,\n", p->width);
		fprintf(fp, "0x%08x,\n", p->height);
		fprintf(fp, "0x%08x,\n", p->level);
		fprintf(fp, "0x%08x,\n", p->hp);
		fprintf(fp, "0x%08x,\n", p->atk);
		fprintf(fp, "0x%08x,\n", p->def);
		fprintf(fp, "0x%08x,\n", p->agi);
		fprintf(fp, "0x%08x,\n", p->mag);
		fprintf(fp, "0x%08x,\n", p->res);
		fprintf(fp, "0x%08x,\n", p->skill_number);
		fprintf(fp, "0x%08x,\n", p->skill[0]);
		fprintf(fp, "0x%08x,\n", p->skill[1]);
		fprintf(fp, "0x%08x,\n", p->skill[2]);
		fprintf(fp, "0x%08x,\n", p->reg);
		fprintf(fp, "0x%08x,\n", p->condition);
		fprintf(fp, "0x%08x,\n", p->atb_gauge);
		fprintf(fp, "0x%08x,\n", p->exp);
		fprintf(fp, "0x%08x,\n", p->gold);
		fprintf(fp, "0x%08x,\n", p->drop_item);
		fprintf(fp, "0x%08x,\n", p->drop_chance);
		fprintf(fp, "0x%08x,\n", p->escape);

		for (uint32_t j = 0; j < ENEMY_SUB_MEMBER_PARA_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	printf("ENEMY DB TOTAL NUMBER = %ld\n", ENEMY_DB_SIZE);
}


/*
 * ver1. 2021/07/26
 * エネミー名書き出し
 */
void enemy_name_write(FILE *fp, FILE *byte)
{
	const EnemyName *p = enemy_name;

	for (uint32_t i = 0; i < ENEMY_NAME_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->id);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", sjis_write(fp, p->name));
	}
	printf("ENEMY NAME TOTAL NUMBER = %ld\n", ENEMY_NAME_DB_SIZE);
}

#endif
