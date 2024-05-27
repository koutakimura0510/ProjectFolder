/*
 * キャラクターのステータスデータベース構造体管理ヘッダーファイル
 */

#ifndef minigame_db_h   /* prevent circular inclusions */
#define minigame_db_h   /* by using protection macros */


/*
 * キャラクター構造体の要素数
 */
#define MINIGAME_PARA_DB_SIZE   ((sizeof (minigame_db))/(sizeof (MinigameDB)))
#define SCORE_DB_SIZE           ((sizeof(score_db)) / (sizeof(ScoreDB)))


/*
 * キャラクターのステータス
 *
 * アクセスID
 * id
 * 
 * マップチップの切り取り開始番号
 * chara_chipid
 * 
 * 横移動の速度
 * move_speed
 * 
 * ジャンプの上昇の速度
 * jump_rise_speed
 * 
 * ジャンプの落下速度
 * jump_fall_speed
 * 
 * ジャンプの高さ
 * jump_height
 * 
 * ボムの所持数
 * bomb_number
 */
typedef struct minigame_db
{
	uint32_t id;
	uint32_t chara_chipid;
	uint32_t move_speed;
	uint32_t jump_rise_speed;
	uint32_t jump_fall_speed;
	int32_t  jump_height;
	uint32_t  bomb_number;
    uint32_t bgm_id;
    uint32_t sound_id;
    const char *msg;
} MinigameDB;

static const MinigameDB minigame_db[] = {
	{HERO_MINORIKO,	MAPCHIP_MINORIKO,	TM_1MS_COUNT,	TM_300US_COUNT,	TM_500US_COUNT,	90, 	1, SOUND_ID_MINORIKO, 	FILE_ACCESS_BGM_MINORIKO,	"日々の農作業によって天狗並みのスピードを手に入れた！"},
	{HERO_SIZUHA,	MAPCHIP_SIZUHA,		TM_5MS_COUNT,	TM_800US_COUNT,	TM_900US_COUNT,	150,	1, SOUND_ID_SIZUHA,		FILE_ACCESS_BGM_SIZUHA,		"背の高い木々に色を塗っているせいかジャンプ力が高い"},
	{HERO_KANAKO,	MAPCHIP_KANAKO,		TM_4MS_COUNT,	TM_500US_COUNT,	TM_700US_COUNT,	95,		2, SOUND_ID_KANAKO, 	FILE_ACCESS_BGM_KANAKO,		"カッパからボムをたくさんもらっている"},
	{HERO_KOGASA,	MAPCHIP_KOGASA,		TM_7MS_COUNT,	TM_1MS_COUNT,	TM_1MS_COUNT,	78,		1, SOUND_ID_KOGASA, 	FILE_ACCESS_BGM_KOGASA,		"力はない、平凡的な能力をしている"},
	{HERO_YUUKA,	MAPCHIP_YUUKA,		TM_7MS_COUNT,	TM_1MS_COUNT,	TM_1MS_COUNT,	78,		1, SOUND_ID_YUUKA, 		FILE_ACCESS_BGM_YUUKA,		"操作性は悪いが得点が入りやすくなっている"},
	{HERO_REMIRIA,	MAPCHIP_REMIRIA,	TM_3MS_COUNT,	TM_500US_COUNT,	TM_650US_COUNT,	78,		1, SOUND_ID_REMIRIA, 	FILE_ACCESS_BGM_REMIRIA,	"小柄で羽根つきなので一度に二回ジャンプができる"},
	{HERO_SATORI,	MAPCHIP_SATORI,		TM_6MS_COUNT,	TM_1MS_COUNT,	TM_1MS_COUNT,	90,		1, SOUND_ID_SATORI, 	FILE_ACCESS_BGM_SATORI,		"何が起こるかわからない"},
	{HERO_TENSI,	MAPCHIP_TENSI,		TM_4MS_COUNT,	TM_600US_COUNT,	TM_750US_COUNT,	95,		1, SOUND_ID_TENSI,	 	FILE_ACCESS_BGM_TENSI,		"一回程度ならブロックの衝撃にも耐えられる"},
};


/*
 * 弾幕の速度に対応した得点を管理
 *
 * 得点に対応した弾幕の速度を指定
 * timer_count
 * 
 * 踏みつけ時の得点の管理
 * 速度が早いものほど得点を高くし、最終配列には一番高い値を指定
 * point[0~2]
 */
typedef struct score_db
{
    uint32_t id;
    uint32_t time;
    uint32_t score1;
    uint32_t score2;
    uint32_t score3;
} ScoreDB;

static const ScoreDB score_db[] = {
    {0, TM_10MS_COUNT,       100,   200,   300},
    {1, TM_9MS_COUNT,        100,   200,   300},
    {2, TM_8MS_COUNT,        200,   300,   400},
    {3, TM_7MS_COUNT,        400,   500,   600},
    {4, TM_6MS_COUNT,        700,   800,   900},
    {5, TM_5MS_COUNT,       1000,  1300,  1500},
    {6, TM_4MS_COUNT,       1000,  1500,  2000},
    {7, TM_3MS_COUNT,       3000,  4000,  5000},
    {8, TM_2MS_COUNT,       5000,  7000,  8000},
    {9, TM_1MS_COUNT,      10000, 15000, 20000},
};


/*
 * ver1. 2021/07/15
 * イベントメッセージrawファイル書き出し
 */
void minigame_write(FILE *fp, FILE *byte)
{
	const MinigameDB *p = minigame_db;

	for (uint32_t i = 0; i < MINIGAME_PARA_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->id);
		fprintf(fp, "0x%08x,\n", p->chara_chipid);
		fprintf(fp, "0x%08x,\n", p->move_speed);
		fprintf(fp, "0x%08x,\n", p->jump_rise_speed);
		fprintf(fp, "0x%08x,\n", p->jump_fall_speed);
		fprintf(fp, "0x%08x,\n", p->jump_height);
		fprintf(fp, "0x%08x,\n", p->bomb_number);
		fprintf(fp, "0x%08x,\n", p->bgm_id);
		fprintf(fp, "0x%08x,\n", p->sound_id);

		for (int j = 0; j < MINIGAME_MSG_MEMBER_NUMBER - 1; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
		fprintf(byte, "0x%08x,\n", sjis_write(fp, p->msg));
	}

	printf("MINIGAME DB TOTAL NUMBER= %ld\n", MINIGAME_PARA_DB_SIZE);
}


/*
 * ver1. 2021/07/20
 * ミニゲームのスコア表書き出し
 */
void score_write(FILE *fp, FILE *byte)
{
	const ScoreDB *p = score_db;

	for (uint32_t i = 0; i < SCORE_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->id);
		fprintf(fp, "0x%08x,\n", p->time);
		fprintf(fp, "0x%08x,\n", p->score1);
		fprintf(fp, "0x%08x,\n", p->score2);
		fprintf(fp, "0x%08x,\n", p->score3);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
	}

	printf("MINIGAME SCORE TOTAL NUMBER= %ld\n", SCORE_DB_SIZE);
}



#endif
	