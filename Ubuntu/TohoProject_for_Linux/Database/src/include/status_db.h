/*
 * Create 2021/07/02
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * ステータス操作関連のデータをまとめたファイル
 */
#ifndef status_db_h   /* prevent circular inclusions */
#define status_db_h   /* by using protection macros */

/* データベースの要素数 */
#define STATUS_CONFIG_DB_SIZE     ((sizeof (status_config))	/ (sizeof (StatusConfig)))
#define STATUS_CONDITION_DB_SIZE  ((sizeof (status_condition)) / (sizeof (StatusCondition)))
#define ITEM_ENCHANT_DB_SIZE  	  ((sizeof (item_enchant)) / (sizeof (ItemEnchant)))
#define ITEM_CONDITION_DB_SIZE    ((sizeof (item_condition)) / (sizeof (ItemCondition)))


/*
 * ver1. 2021/08/10
 * ステータス補正系のアイテムの効果を管理
 */
typedef struct
{
	uint8_t itemid;			//アイテムID
	uint32_t power;			//上昇値
	uint32_t enable_bit;	//ステータス操作時のbit
} ItemEnchant;

static const ItemEnchant item_enchant[] = {
	{ITEM_KAPPA_SIELD, 5, DEF_ENABLE_BIT},
	{ITEM_KAPPA_MAGIC, 5, RES_ENABLE_BIT},
	{ITEM_ONI_POWER,  10, ATK_ENABLE_BIT},
};


/*
 * ver1. 2021/08/10
 * 状態異常系のアイテムの効果を管理
 */
typedef struct
{
	uint8_t  itemid;		//アイテムID
	uint32_t type_bit;		//耐性と属性のbitを指定
	uint32_t condition_bit;	//状態異常用定数を指定
} ItemCondition;

static const ItemCondition item_condition[] = {
	{ITEM_MARISA_KINOKO,	  0,						0},
	{ITEM_SANAE_OMAMORI,	R17,	UNIT_CONDITION_RIFREK},
	{ITEM_ONI_SYURAN,		R16,    UNIT_CONDITION_BERSEK},
};


/*
 * ver1. 2021/08/10
 * ステータス補正系の属性の効果を管理するデータベース
 */
typedef struct
{
	uint32_t element;
	int32_t  power;
    uint32_t enable_bit;
} StatusConfig;

static const StatusConfig status_config[] = {
    {E_BREAK_REMIRIA,    0,     ALL_ENABLE_BIT},
    {E_ATTACK_UP_1,     10,     ATK_ENABLE_BIT},
    {E_ATTACK_UP_2,      5,     ATK_ENABLE_BIT},
    {E_DEF_UP_1,        10,     DEF_ENABLE_BIT},
    {E_DEF_UP_2,         5,     DEF_ENABLE_BIT},
    {E_MAG_UP_1,        10,     MAG_ENABLE_BIT},
    {E_MAG_UP_2,         5,     MAG_ENABLE_BIT},
    {E_RES_UP_1,        10,     RES_ENABLE_BIT},
    {E_RES_UP_2,         5,     RES_ENABLE_BIT},
    {E_SPEED_UP_1,      10,     AGI_ENABLE_BIT},
    {E_SPEED_UP_2,       5,     AGI_ENABLE_BIT},
    {E_ATTACK_DOWN_1,  -10,     ATK_ENABLE_BIT},
    {E_ATTACK_DOWN_2,   -5,     ATK_ENABLE_BIT},
    {E_DEF_DOWN_1,     -10,     DEF_ENABLE_BIT},
    {E_DEF_DOWN_2,      -5,     DEF_ENABLE_BIT},
    {E_MAG_DOWN_1,     -10,     MAG_ENABLE_BIT},
    {E_MAG_DOWN_2,      -5,     MAG_ENABLE_BIT},
    {E_RES_DOWN_1,     -10,     RES_ENABLE_BIT},
    {E_RES_DOWN_2,      -5,     RES_ENABLE_BIT},
    {E_SPEED_DOWN_1,   -10,     AGI_ENABLE_BIT},
    {E_SPEED_DOWN_2,    -5,     AGI_ENABLE_BIT},
    {E_ALL_DOWN_1,     -10,     ALL_ENABLE_BIT},
    {E_ALL_DOWN_2,      -5,     SIL_ENABLE_BIT},
};


/*
 * ver1. 2021/08/08
 * 状態異常のデータを管理するデータベース
 * 
 * element          技のタイプ
 * type_bit         状態異常にしたい属性を定義
 * condition_bit    状態異常にかかった場合のbitを指定
 */
typedef struct
{
    uint32_t element;
    uint32_t type_bit;
    uint32_t condition_bit;
} StatusCondition;

static const StatusCondition status_condition[] = 
{
	{E_REGENE,			 R18,   UNIT_CONDITION_RIGENE},  //リジェネ
	{E_GUARD_REMIRIA,	 R17,   UNIT_CONDITION_RIFREK},  //カリスマガード、一度だけ90%軽減
	{E_POISON_1,		 R13,   UNIT_CONDITION_POISON},  //単体毒
	{E_POISON_2,		 R13,   UNIT_CONDITION_POISON},  //全体毒
	{E_CONFIG_1,		 R12,   UNIT_CONDITION_CONFIG},  //単体混乱
	{E_CONFIG_2,		 R12,   UNIT_CONDITION_CONFIG},  //全体混乱
	{E_BERSERK_1,		 R16,   UNIT_CONDITION_BERSEK},  //単体バーサク
	{E_BERSERK_2,		 R16,   UNIT_CONDITION_BERSEK},  //全体バーサク
	{E_STONE_1,			 R14,   UNIT_CONDITION_STONE},   //単体石化
	{E_STONE_2,			 R14,   UNIT_CONDITION_STONE},   //全体石化
	{E_PARALY_1,		 R15,   UNIT_CONDITION_PARARAI}, //単体マヒ
	{E_PARALY_2,		 R15,   UNIT_CONDITION_PARARAI}, //全体マヒ
};


/*
 * ver1. 2021/07/20
 * エフェクトデータの書き出し
 */
void status_write(FILE *fp, FILE *byte)
{
	const StatusConfig *p = status_config;

	for (uint32_t i = 0; i < STATUS_CONFIG_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->element);
		fprintf(fp, "0x%08x,\n", p->power);
		fprintf(fp, "0x%08x,\n", p->enable_bit);

		for (uint32_t j = 0; j < STATUS_SUB_MEMBER_CONFIG_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	printf("STATUS CONFIG TOTAL NUMBER = %ld\n", STATUS_CONFIG_DB_SIZE);
}


/*
 * ver1. 2021/08/08
 * 状態異常の属性データベースを書きだし
 */
void condition_write(FILE *fp, FILE *byte)
{
	const StatusCondition *p = status_condition;

	for (uint32_t i = 0; i < STATUS_CONDITION_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->element);
		fprintf(fp, "0x%08x,\n", p->type_bit);
		fprintf(fp, "0x%08x,\n", p->condition_bit);

		for (uint32_t j = 0; j < CONDITION_SUB_MEMBER_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	printf("STATUS CONDITION TOTAL NUMBER = %ld\n", STATUS_CONDITION_DB_SIZE);
}


/*
 * ver1. 2021/08/10
 * ステータス操作系アイテムの情報書き出し
 */
void item_enchant_write(FILE *fp, FILE *byte)
{
	const ItemEnchant *p = item_enchant;

	for (uint32_t i = 0; i < ITEM_ENCHANT_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->itemid);
		fprintf(fp, "0x%08x,\n", p->power);
		fprintf(fp, "0x%08x,\n", p->enable_bit);

		for (uint32_t j = 0; j < ITEM_SUB_MEMBER_ENCHANT_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	error_print(ITEM_ENCHANT_DB_SIZE, ENCHANT_ITEM_END, "Item Enchant");
	printf("ITEM ENCHANT TOTAL NUMBER = %ld\n", ITEM_ENCHANT_DB_SIZE);
}



/*
 * ver1. 2021/08/10
 * 状態異常系アイテムの情報書き出し
 */
void item_condition_write(FILE *fp, FILE *byte)
{
	const ItemCondition *p = item_condition;

	for (uint32_t i = 0; i < ITEM_CONDITION_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->itemid);
		fprintf(fp, "0x%08x,\n", p->type_bit);
		fprintf(fp, "0x%08x,\n", p->condition_bit);

		for (uint32_t j = 0; j < ITEM_SUB_MEMBER_CONDITION_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	error_print(ITEM_CONDITION_DB_SIZE, CONDITION_ITEM_END, "Item Condition");
	printf("ITEM CONDITION TOTAL NUMBER = %ld\n", ITEM_CONDITION_DB_SIZE);
}


#endif