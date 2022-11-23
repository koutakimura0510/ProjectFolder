/*
 * Ubuntu LTS 20.04 
 * Author Kimura Kouta
 *
 * c言語でクラスを再現してみた
 * データベースのアクセスの方法を模索したかった
 */
#include <stdio.h>


/*
 * SystemDB サイズ
 */
#define DB_SIZE ((sizeof (systemdb))/(sizeof (SystemDB)))


/*
 * 子クラスの要素数
 */
#define POS_SIZE	(3)
#define LENGTH_SIZE	(5)


/*
 * 子クラス
 */
typedef struct 
{
	int id;
	int xpos;
	int ypos;
} Pos;

typedef struct 
{
	int id;
	int xlen;
	int ylen;
	int zlen;
} Length;

/*
 * 上記の構造体を管理するデータベース
 */
typedef struct 
{
	const int member_size[2];
	const Pos pos[POS_SIZE];
	const Length length[LENGTH_SIZE];
} SystemDB;

static const SystemDB systemdb[] =
{
	{
		{
			/* 子ClassのIDを管理 */
			POS_SIZE,
			LENGTH_SIZE,
		},

		{
			/* Pos Class */
			{0,  0,  0},
			{1, 20, 30},
			{2, 50, 60},
		},
		
		{
			/* Length Class */
			{0, 1000, 30000, 100},
			{1, 2000, 40000, 104},
			{2, 3000, 50000, 105},
			{3, 4000, 60000, 106},
			{4, 5000, 70000, 107},
		},
	},
};


/*
 * メイン関数
 */
int main(void)
{
	const SystemDB *db = systemdb;
	int id = 1;
	
	printf("データベースサイズ = %ld\n", DB_SIZE);

	switch (id)
	{
	case 0:
		for (int i = 0; i < POS_SIZE; i++)
		{
			printf("data = %d\n", db->pos[i].xpos);
		}
		break;

	case 1:
		for (int i = 0; i < LENGTH_SIZE; i++)
		{
			printf("data = %d\n", db->length[i].zlen);
		}
		break;

	default:
		break;
	}

	return 0;
}






