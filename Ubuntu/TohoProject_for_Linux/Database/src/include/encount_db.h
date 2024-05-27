/*
 * Create 2021/07/23
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * -
 * リージョンのエンカウントデータを管理するファイル
 */

#ifndef encount_db_h   /* prevent circular inclusions */
#define encount_db_h   /* by using protection macros */


/*
 * 構造体の要素数
 */
#define REGION_DB_SIZE      ((sizeof (region_db)) / (sizeof (RegionDB)))
#define FORMATION_DB_SIZE   ((sizeof (formation_db)) / (sizeof (FormationDB)))

/*
 * ver1. 2021/07/23
 * リージョンのデータベース
 * -
 * ワールドマップのデータベースに敵の出現情報をまとめるようにした
 * 敵のデータベースに出現情報のデータを持たせると、複数個所で出現する場合の管理が大変になる
 * 
 * 例　下界のリージョン1のマスに出現するモンスターのID = {0, 1, 2, 3},
 * などのようにすると、階層ごとに分けられることができる
 * ワールドマップ作製アプリケーションでマップチップにタイプした、敵出現リージョンIDも一緒に出力する
 * つまりリージョン設定をしたファイルを出力し、そのデータを参考にする
 * 参考URL https://tkool.jp/products/rpgvxace/lecture/005_001/index.html
 * 
 * -
 * エンカウント時の敵表示座標などの処理の順番
 * 1. formation_typeからランダムに隊列番号を取得
 * 2. 取得した隊列番号から下記のFormationTypeにアクセスする
 * 3. enemy_sizeメンバのデータを取得する
 * 4. RegionDBの敵IDを取得し、エネミーデータを管理しているデータベースからエネミーのサイズを取得する。
 * 5. enemy_size以下のエネミーサイズを持つ敵データを隊列の順番にセットする
 * -
 * region_id        リージョンID、敵の出現箇所
 * enemy_id[]       リージョンIDに対して出現するモンスター、最大数出現しない場合はMONSTART_ID_NONを指定する
 * formation_type[] 敵の隊列のタイプ
 */
typedef struct
{
    uint32_t region_id;
    uint32_t enemy_id[REGION_ENEMY_MAX_SIZE];
    uint32_t formation_type[REGION_FORMATION_MAX_SIZE];
} RegionDB;

static const RegionDB region_db[] = 
{
    {
        1,
        {MONSTER_ID_1, MONSTER_ID_2, MONSTER_ID_NON, MONSTER_ID_NON, MONSTER_ID_NON, MONSTER_ID_NON, MONSTER_ID_NON, MONSTER_ID_NON},
        {FORMATION_TYPE_1, FORMATION_TYPE_2, FORMATION_TYPE_2, FORMATION_TYPE_3},
    },
};


/*
 * ver1. 2021/07/23
 * 隊列における描画座標を管理する
 */
typedef struct
{
    uint32_t formation_type;    // 隊列ID
    uint32_t enemy_number;      // 隊列のタイプに対する敵の描画数
    uint32_t enemy_size;        // サイズ番号
    uint32_t draw_xpos[REGION_DRAW_MAX_POS_NUMBER];       // 描画座標
    uint32_t draw_ypos[REGION_DRAW_MAX_POS_NUMBER];       // 描画座標
} FormationDB;

static const FormationDB formation_db[] =
{
    {
        FORMATION_TYPE_1, 1, ENEMY_SIZE_5,
        {FORMATION_DRAW_XPOS_1_1, 0, 0, 0, 0, 0,},
        {FORMATION_DRAW_YPOS_1_1, 0, 0, 0, 0, 0,},
    },
    {
        FORMATION_TYPE_2, 2, ENEMY_SIZE_4,
        {FORMATION_DRAW_XPOS_2_1, FORMATION_DRAW_XPOS_2_2, 0, 0, 0, 0,},
        {FORMATION_DRAW_YPOS_2_1, FORMATION_DRAW_YPOS_2_2, 0, 0, 0, 0,},
    },
    {
        FORMATION_TYPE_3, 4, ENEMY_SIZE_3,
        {FORMATION_DRAW_XPOS_3_1, FORMATION_DRAW_XPOS_3_2, FORMATION_DRAW_XPOS_3_3, FORMATION_DRAW_XPOS_3_4, 0, 0,},
        {FORMATION_DRAW_YPOS_3_1, FORMATION_DRAW_YPOS_3_2, FORMATION_DRAW_YPOS_3_3, FORMATION_DRAW_YPOS_3_4, 0, 0,},
    },
    {
        FORMATION_TYPE_4, 6, ENEMY_SIZE_2,
        {FORMATION_DRAW_XPOS_4_1, FORMATION_DRAW_XPOS_4_2, FORMATION_DRAW_XPOS_4_3, FORMATION_DRAW_XPOS_4_4, FORMATION_DRAW_XPOS_4_5, FORMATION_DRAW_XPOS_4_6},
        {FORMATION_DRAW_YPOS_4_1, FORMATION_DRAW_YPOS_4_2, FORMATION_DRAW_YPOS_4_3, FORMATION_DRAW_YPOS_4_4, FORMATION_DRAW_YPOS_4_5, FORMATION_DRAW_YPOS_4_6},
    },
};


/*
 * ver1. 2021/07/23
 * リージョンデータベースのデータ書き出し
 */
void region_write(FILE *fp, FILE *byte)
{
	const RegionDB *p = region_db;

	for (uint32_t i = 0; i < REGION_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->region_id);
        fprintf(byte, "0x%08x,\n", 1);

		for (uint32_t j = 0; j < REGION_ENEMY_MAX_SIZE; j++)
		{
			fprintf(fp, "0x%08x,\n", p->enemy_id[j]);
            fprintf(byte, "0x%08x,\n", 1);
		}

		for (uint32_t j = 0; j < REGION_FORMATION_MAX_SIZE; j++)
		{
			fprintf(fp, "0x%08x,\n", p->formation_type[j]);
            fprintf(byte, "0x%08x,\n", 1);
		}
	}

    printf("REGION DB TOTAL NUMBER= %ld\n", REGION_DB_SIZE);
}


/*
 * ver1. 2021/07/20
 * formation database write up
 */
void formation_write(FILE *fp, FILE *byte)
{
	const FormationDB *p = formation_db;

	for (uint32_t i = 0; i < FORMATION_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->formation_type);
		fprintf(fp, "0x%08x,\n", p->enemy_number);
		fprintf(fp, "0x%08x,\n", p->enemy_size);
        fprintf(byte, "0x%08x,\n", 1);
        fprintf(byte, "0x%08x,\n", 1);
        fprintf(byte, "0x%08x,\n", 1);

		for (uint32_t j = 0; j < REGION_DRAW_MAX_POS_NUMBER; j++)
		{
			fprintf(fp, "0x%08x,\n", p->draw_xpos[j]);
            fprintf(byte, "0x%08x,\n", 1);
		}

		for (uint32_t j = 0; j < REGION_DRAW_MAX_POS_NUMBER; j++)
		{
			fprintf(fp, "0x%08x,\n", p->draw_ypos[j]);
            fprintf(byte, "0x%08x,\n", 1);
		}
	}

    printf("FORMATION TOTAL NUMBER= %ld\n", FORMATION_DB_SIZE);
}


#endif
