/*
 * Create 2021/08/15
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * 料理関連のデータをまとめるヘッダーファイル
 * 
 */
#ifndef cooking_db_h   /* prevent circular inclusions */
#define cooking_db_h   /* by using protection macros */

#include "macro/cook_msg_macro.h"

/* データベースの要素数 */
#define COOKING_DB_SIZE ((sizeof (cook_db))	/ (sizeof (CookDB)))


/*
 * ver1. 2021/08/15
 * 料理の情報を管理するデータベース
 */
typedef struct
{
	uint8_t  cookid;	    //料理IDを指定
	uint32_t use_type;	    //料理を使用した時の効果定数を指定
    uint32_t power;         //料理の使用時の効果
    uint32_t skill_level;   //使用回数で熟練度が上がるため、何回使用すれば熟練度が上がるか指定
    char *msg;              //料理の説明
    char *name;             //料理名
} CookDB;

static const CookDB cook_db[] = {
	{COOK_ID_0, 	COOK_TYPE_HEEL,             500,    1, COOK_MSG_0, 		"おにぎり"          },
	{COOK_ID_1, 	COOK_TYPE_RATIO,             15,    2, COOK_MSG_1, 		"サンドイッチ",     },
	{COOK_ID_2, 	COOK_TYPE_SP,                30,    3, COOK_MSG_2, 		"やさいジュース",   },
	{COOK_ID_3, 	COOK_TYPE_ALIVE,             30,    4, COOK_MSG_3, 		"カレーライス",     },
	{COOK_ID_4, 	COOK_TYPE_HEEL_SP,           25,    5, COOK_MSG_4, 		"フルーツパフェ",   },
	{COOK_ID_5, 	COOK_TYPE_HEEL_ALIVE,        50,    6, COOK_MSG_5, 		"カツカレー",       },
	{COOK_ID_6, 	COOK_TYPE_HEEL_SP,           50,    7, COOK_MSG_6, 		"ケーキ定食",       },
	{COOK_ID_NON, 	COOK_TYPE_NON,		          0,    0, COOK_MSG_NON,	"？？？？？？",       },
};


/*
 * ver1. 2021/08/15
 * 料理の情報書き出し
 */
void cooking_write(FILE *fp, FILE *byte)
{
	const CookDB *p = cook_db;

	for (uint32_t i = 0; i < COOKING_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->cookid);
		fprintf(fp, "0x%08x,\n", p->use_type);
		fprintf(fp, "0x%08x,\n", p->power);
		fprintf(fp, "0x%08x,\n", p->skill_level);

		for (uint32_t j = 0; j < COOK_SUB_MEMBER_NUMBER - 2; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}

		fprintf(byte, "0x%08x,\n", sjis_write(fp, p->msg));
        fprintf(byte, "0x%08x,\n", sjis_write(fp, p->name));
	}

    if (COOK_ID_END != COOKING_DB_SIZE)
    {
        printf("----- ERROR ------");
    }
	printf("COOKING TOTAL NUMBER = %ld\n", COOKING_DB_SIZE);
}


#endif