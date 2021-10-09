/*
 * Create 2021/10/07
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * ワールドマップの当たり判定を管理するデータベースファイル
 */
#ifndef event_world_direct_db_h   /* prevent circular inclusions */
#define event_world_direct_db_h   /* by using protection macros */


/*
 * 構造体の要素数
 */
#define WORLDMAP_DIRECT_DB_SIZE ((sizeof (worldmap_direct)) / (sizeof (WorldmapDirect)))
#define BUILD_LOOP_DB_SIZE ((sizeof (build_loop_count)) / (sizeof (BuildLoopCount)))


/**
 * @brief  ワールドマップの当たり判定座標とイベントの種類を管理するデータベース
 * 
 * @note   
 * プレイヤーの座標がデータベースの座標と一致した時に、event_idとevent_typeを取得する。
 * event_idは同ディレクトリ内にあるevent_map_move_db.hで管理されているMapMoveAll構造体にアクセスするためのIDである。
 * event_typeは、サブマップ間移動とワールドマップを含んだ移動では読み込むデータの種類が異なるため、読み込むデータの種類を判定するために使用する
 * 
 * 処理の順番としては、
 * 1. direct_xpos,yposで座標を検索
 * 2. 一致すればnext_mapname_idとevent_typeを保存
 * 3. 移動アニメーションのため画面を暗転させる
 * 4. 暗転中に取得したevent_typeでデータの取得数の判定を行う。
 * 5. 判定を行ったらnext_mapname_idでデータベースの検索を行いデータを取得する
 * 6. 表示させるマップデータをフレームバッファに保存し表示する
 * 7. 特殊イベントが無ければ1 ~ 6を繰り返す
 * 
 * @param world_direcy_id データベースの当たり判定検索用のIDを保存
 * @param direct_xpos 当たり判定のx座標を指定
 * @param direct_ypos 当たり判定のy座標を指定
 * @param next_mapname_id 連番のイベント番号を指定する
 * @param event_type 発生するイベントタイプを指定する
 * @retval None
 */
typedef struct worldmap_direct
{
	uint32_t world_direct_id;
	uint32_t direct_xpos;
	uint32_t direct_ypos;
	uint32_t next_mapname_id;
	uint32_t event_type;
} WorldmapDirect;

static const WorldmapDirect worldmap_direct[] =
{
	{WORLD_DIRECT_GEKAI_ROMEN_VILLAGE, 171, 45, TRY_ROMEN_VIRRAGE_ID, EVENT_TYPE_WORLD_STATE_OTHER_MAP, },
	{WORLD_DIRECT_GEKAI_ROMEN_TREE,    166, 49, TRY_ROMEN_DANGEON_ID, EVENT_TYPE_WORLD_STATE_OTHER_MAP, },
};


/**
 * @brief  ワールドマップや町ダンジョン内の当たり判定検索時のループ回数を管理するデータベース
 * @note   
 * 
 * @param マップ名のIDを指定 xxx_MAP_ID
 * @param データベースを検索する開始行を指定
 * @param データベースを検索する終了行を指定
 * @retval None
 */
typedef struct build_loop_count
{
	uint32_t map_name;
	uint32_t start_id;
	uint32_t loop_count;
} BuildLoopCount;

static const BuildLoopCount build_loop_count[] = {
	{GEKAI_MAP_ID,			WORLD_DIRECT_GEKAI_START, WORLD_DIRECT_GEKAI_END},
	{TIKAI_MAP_ID,			WORLD_DIRECT_GEKAI_START, WORLD_DIRECT_GEKAI_END},
	{TENKAI_MAP_ID,			WORLD_DIRECT_GEKAI_START, WORLD_DIRECT_GEKAI_END},
	{HAZAMA_MAP_ID,			WORLD_DIRECT_GEKAI_START, WORLD_DIRECT_GEKAI_END},
	{MAKAI_MAP_ID,			WORLD_DIRECT_GEKAI_START, WORLD_DIRECT_GEKAI_END},
	{ROMEN_VIRRAGE_ID,		DIRECT_ROMEN_ID_START,    DIRECT_ROMEN_ID_END	},
	{ROMEN_HOUSE1_LOOM1_ID,	DIRECT_ROMEN_ID_LOOM1_START, DIRECT_ROMEN_ID_LOOM1_END},
	{ROMEN_HOUSE2_LOOM1_ID,	DIRECT_ROMEN_ID_LOOM2_START, DIRECT_ROMEN_ID_LOOM2_END},
	{ROMEN_DANGEON_ID,		WORLD_DIRECT_GEKAI_START, WORLD_DIRECT_GEKAI_END},
	{BEGINNING_HILL_ID,		WORLD_DIRECT_GEKAI_START, WORLD_DIRECT_GEKAI_END},
};


/**
 * @brief  ワールドマップの当たり判定データの書き出し
 * @retval None
 */
void world_direct_write(FILE *fp, FILE *byte)
{
	const WorldmapDirect *p = worldmap_direct;

	for (uint32_t i = 0; i < WORLDMAP_DIRECT_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->world_direct_id);
		fprintf(fp, "0x%08x,\n", p->direct_xpos);
		fprintf(fp, "0x%08x,\n", p->direct_ypos);
		fprintf(fp, "0x%08x,\n", p->next_mapname_id);
		fprintf(fp, "0x%08x,\n", p->event_type);

		for (int j = 0; j < WORLD_DIRECT_MEMBER_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	error_print(WORLDMAP_DIRECT_DB_SIZE, WORLD_DIRECT_END, "MAP ALL MOVE NUMBER");
}


/**
 * @brief  マップイベントのデータベース参照回数データの書き出し
 * @retval None
 */
void build_loop_write(FILE *fp, FILE *byte)
{
	const BuildLoopCount *p = build_loop_count;

	for (uint32_t i = 0; i < BUILD_LOOP_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->map_name);
		fprintf(fp, "0x%08x,\n", p->start_id);
		fprintf(fp, "0x%08x,\n", p->loop_count);

		for (int j = 0; j < BUILD_LOOPCOUNT_MEMBER_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	error_print(BUILD_LOOP_DB_SIZE, MAP_NAME_ID_END, "BUILD LOOP COUNT NUMBER");
}

#endif