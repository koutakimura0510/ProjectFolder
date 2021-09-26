/*
 * Create 2021/08/31
 * Author kimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * NPCのデータについて管理するヘッダーファイル
 */
#ifndef npc_db_h_
#define npc_db_h_


/* データベースの要素数 */
#define NPC_MAP_DB_SIZE   	 ((sizeof (npc_map_db))		/ (sizeof (NpcMapDB)))
#define NPC_BITMAP_DB_SIZE   ((sizeof (npc_bitmap_db))	/ (sizeof (NpcBitmapDB)))
#define NPC_EVENT_DB_SIZE    ((sizeof (npc_event_db))	/ (sizeof (NpcEventDB)))
#define NPC_PATTERN_DB_SIZE  ((sizeof (npc_pattern_db)) / (sizeof (NpcPatternDB)))


/**
 * @brief  マップに出現させる村人の番号を管理する
 * @note   村人の追加方法
 * 一つのマップに付きNPC_MAX_DRAW_NUMの数NPCを描画可能です
 * 番号0はNPCを描画しません
 * 配列の前詰めで番号を振り分けていきます
 * 1から番号を振り分けていき、1列に1 ~ 15、2列に16 ~ 30と番号を増やしていきます。
 * 振り分けた番号に対応した、描画するNPCのマップチップデータやアニメーションの種類は @p NpcPatternDBに定義します
 * 振り分けた番号はNPCのID番号と比例しているわけではないので注意が必要です
 * 
 * @param  mapid NPCを描画するマップのIDを指定
 * @param  npc_number[] NPCの番号を振り分け
 */
typedef struct npc_map_db
{
	uint32_t map_id;
	uint32_t npc_number[NPC_MAX_DRAW_NUM];
} NpcMapDB;

static const NpcMapDB npc_map_db[] = {
	{GEKAI_MAP_ID,			{0, }, },
	{TIKAI_MAP_ID,			{0, }, },
	{TENKAI_MAP_ID,			{0, }, },
	{HAZAMA_MAP_ID,			{0, }, },
	{MAKAI_MAP_ID,			{0, }, },
	{ROMEN_VIRRAGE_ID,		{ROMEN_NPC_ID_1, ROMEN_NPC_ID_2, ROMEN_NPC_ID_3, ROMEN_NPC_ID_4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},	},
	{ROMEN_HOUSE1_LOOM1_ID,	{0, }, },
	{ROMEN_HOUSE2_LOOM1_ID,	{0, }, },
	{ROMEN_DANGEON_ID,		{0, }, },
	{BEGINNING_HILL_ID,		{0, }, },
};


/*!
 * @brief NPCの行動パターンについて管理するデータべース
 * @ingroup npc group
 * 
 * @note 分かりにくそうなメンバの具体的な説明を記しておくよ
 * action_speed アニメーション時の速度を管理するよ。速度を変更して歩きを表現したり走りを表現したりするよ。
 * update_speed A地点からB地点に動き出すタイミングを管理するよ。更新タイミングを早めると早く動くと考えていいよ
 * mapchip_speed マップチップの更新時間を管理するよ。その場で凄く速く足踏みしてるような演出とかできるよ
 * action_pattern グルグル回ったりrange内をランダムで動いたりを指定するよ
 * 
 * @param map_npcid マップに登場させるNPCの番号を管理するデータベースに対応した番号を指定
 * @param npcid マップに登場させるNPCのIDを保存
 * @param xinit npcのx座標の描画初期位置
 * @param yinit npcのy座標の描画初期位置
 * @param range_left 初期位置からの左方向の最大移動量
 * @param range_right 初期位置からの右方向の最大移動量
 * @param range_up 初期位置からの上方向の最大移動量
 * @param range_down 初期位置からの下方向の最大移動量
 * @param action_speed 移動のスピードを保存
 * @param update_speed 座標更新時間の間隔を保存
 * @param mapchip_speed マップチップの更新時間を保存
 * @param action_pattern 移動アニメーションの種類を保存
 */
typedef struct npc_pattern_db
{
	uint32_t map_npcid;
	uint32_t npcid;
	uint32_t xinit;
	uint32_t yinit;
	int32_t range_left;
	int32_t range_right;
	int32_t range_up;
	int32_t range_down;
	uint32_t action_speed;
	uint32_t update_speed;
	uint32_t mapchip_speed;
	uint32_t action_pattern;
} NpcPatternDB;

static const NpcPatternDB npc_pattern_db[] = {
	{ROMEN_NPC_ID_1, NPC_GUAL_1_WORLD, 27, 28,  0, 0,  0, 0, TM_700MS_COUNT, TM_700MS_COUNT, TM_700MS_COUNT, NPC_PATTERN_STAND, 	},
	{ROMEN_NPC_ID_2, NPC_GUAL_2_WORLD, 27, 13,  0, 0,  0, 0, TM_700MS_COUNT, TM_700MS_COUNT, TM_1SEC_COUNT,  NPC_PATTERN_STAND, 	},
	{ROMEN_NPC_ID_3, NPC_GUAL_2_WORLD, 32, 36, -1, 1, -1, 1, TM_700MS_COUNT, TM_700MS_COUNT, TM_700MS_COUNT, NPC_PATTERN_RANDOM, 	},
	{ROMEN_NPC_ID_4, NPC_GUAL_1_WORLD, 39, 36, -2, 2, -2, 2, TM_100MS_COUNT, TM_100MS_COUNT, TM_100MS_COUNT, NPC_PATTERN_ROULETTE, 	},
};


/**
 * @brief  npcのイベントデータを管理するデータベース
 * @note   
 * @param map_npcid マップに登場させるNPCの番号を管理するデータベースに対応した番号を指定
 * @param event_id どのようなイベントの管理を行うかを判定するIDを指定
 * @param event_flag 特定のイベント発生時にメッセージを変化させるため、必要なフラグを指定する
 * @param get_event_id NPCに話しかけた時に発生するイベントのフラグを保存、利用しない場合は0を指定
 * @retval None
 */
typedef struct npc_event_db
{
	uint32_t map_npcid;
	uint32_t event_id;
	uint32_t event_flag;
	uint32_t get_event_flag;
} NpcEventDB;

static const NpcEventDB npc_event_db[] = {
	{ ROMEN_NPC_ID_1, FLAG_NPC_MSG_EVENT,    ROMEN_BOSS_DYE, 0, },
	{ ROMEN_NPC_ID_2, FLAG_NPC_MSG_EVENT,    ROMEN_BOSS_DYE, 0, },
	{ ROMEN_NPC_ID_3, FLAG_NPC_MSG_CONTINUE, ROMEN_BOSS_DYE, 0, },
	{ ROMEN_NPC_ID_4, FLAG_NPC_MSG_CONTINUE, ROMEN_BOSS_DYE, 0, },
};


/*!
 * @brief NPCに利用するの画像データについて管理するデータベース
 * @note 
 * @param srcin DRAMのアドレス
 * @param xsize width
 * @param yszie height
 * @param mapchip_id
 */
typedef struct npc_bitmap_db
{
	uint32_t id;
	uint32_t srcin;
	uint32_t xsize;
    uint32_t ysize;
	uint32_t mapchip_id;
} NpcBitmapDB;

static const NpcBitmapDB npc_bitmap_db[] = {
	{NPC_GUAL_1_WORLD, DRAM_NPC_WORLD_ADDR_BASE, 32, 32, 0},
	{NPC_GUAL_2_WORLD, DRAM_NPC_WORLD_ADDR_BASE, 32, 32, 3},
};


/**
 * @brief  NPCのマップ連番の書き出し
 */
void npc_map_write(FILE *fp, FILE *byte)
{
	const NpcMapDB *p = npc_map_db;

	for (uint32_t i = 0; i < NPC_MAP_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->map_id);

		for (uint32_t j = 0; j < NPC_MAX_DRAW_NUM; j++)
		{
			fprintf(fp, "0x%08x,\n", p->npc_number[j]);
		}

		for (uint32_t j = 0; j < 1 + NPC_MAX_DRAW_NUM; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	error_print(NPC_MAP_DB_SIZE, MAP_NAME_ID_END, "NPC_MAP_DB_SIZE");
	printf("NPC MAP TOTAL NUMBER = %ld\n", NPC_MAP_DB_SIZE);
}


/*
 * npcの行動パターンの書き出し
 */
void npc_pattern_write(FILE *fp, FILE *byte)
{
	const NpcPatternDB *p = npc_pattern_db;

	for (uint32_t i = 0; i < NPC_PATTERN_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->map_npcid);
		fprintf(fp, "0x%08x,\n", p->npcid);
		fprintf(fp, "0x%08x,\n", p->xinit);
		fprintf(fp, "0x%08x,\n", p->yinit);
		fprintf(fp, "0x%08x,\n", p->range_left);
		fprintf(fp, "0x%08x,\n", p->range_right);
		fprintf(fp, "0x%08x,\n", p->range_up);
		fprintf(fp, "0x%08x,\n", p->action_speed);
		fprintf(fp, "0x%08x,\n", p->update_speed);
		fprintf(fp, "0x%08x,\n", p->mapchip_speed);
		fprintf(fp, "0x%08x,\n", p->action_speed);
		fprintf(fp, "0x%08x,\n", p->action_pattern);

		for (uint32_t j = 0; j < NPC_SUB_MEMBER_PATTERN_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	printf("NPC PATTERN TOTAL NUMBER = %ld\n", NPC_PATTERN_DB_SIZE);
}


/*
 * npcの行動パターンの書き出し
 */
void npc_event_write(FILE *fp, FILE *byte)
{
	const NpcEventDB *p = npc_event_db;

	for (uint32_t i = 0; i < NPC_EVENT_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->map_npcid);
		fprintf(fp, "0x%08x,\n", p->event_id);
		fprintf(fp, "0x%08x,\n", p->event_flag);
		fprintf(fp, "0x%08x,\n", p->get_event_flag);

		for (uint32_t j = 0; j < NPC_SUB_MEMBER_EVENT_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	printf("NPC EVENT TOTAL NUMBER = %ld\n", NPC_EVENT_DB_SIZE);
}


/*
 * npcの画像データのデータを書き出し
 */
void npc_bitmap_write(FILE *fp, FILE *byte)
{
	const NpcBitmapDB *p = npc_bitmap_db;

	for (uint32_t i = 0; i < NPC_BITMAP_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->id);
		fprintf(fp, "0x%08x,\n", p->srcin);
		fprintf(fp, "0x%08x,\n", p->xsize);
		fprintf(fp, "0x%08x,\n", p->ysize);
		fprintf(fp, "0x%08x,\n", p->mapchip_id);

		for (uint32_t j = 0; j < NPC_SUB_MEMBER_BITMAP_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	if (NPC_BITMAP_DB_SIZE != NPC_ID_END)
    {
        printf("--- ERROR --- NPC_ID_END or NPC_BITMAP_DB_SIZE");
    }

	printf("NPC BITMAP TOTAL NUMBER = %ld\n", NPC_BITMAP_DB_SIZE);
}




#endif