/*
 * Create 2021/10/07
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * マップ間移動時、移動先のマップ情報を管理するデータベースファイル
 * 親データベースのdirect_build_structの
 * メンバー「event_id」と「event_type」を取得する。
 * event_typeがサブマップ間の移動であれば、下記のSebmapMoveデータベースのevent_idと
 * 取得したevent_idが一致した行の開始座標を取得する
 * 
 * [マップ間移動とは詳細、例ロメンの村]
 * ワールドマップからロメンの村に移動   = ロメンの村のマップ情報読み込み
 * ロメンの村からロメンの村の家１に移動 = ロメンの村の家１のマップ情報読み込み
 * ロメンの村の家１からロメンの村に移動 = ロメンの村のマップ情報読み込み
 */
#ifndef event_map_move_db_h   /* prevent circular inclusions */
#define event_map_move_db_h   /* by using protection macros */


/*
 * 構造体の要素数
 */
#define MAP_MOVE_ALL_DB_SIZE ((sizeof (map_move_all)) / (sizeof (MapMoveAll)))


/**
 * @brief  マップ間移動時にBGMと使用するマップチップの画像データの変更を行う必要がある場合の情報を管理
 * 
 * @param next_mapname_id イベントIDを指定し一致した行のデータを取得
 * @param event_type 発生したイベントのタイプを指定する
 * @param next_file_mapdata_id 使用するマップのバックデータにアクセスするファイル番号を指定
 * @param next_file_object_id 使用するマップのオブジェクトにアクセスするファイル番号を指定
 * @param next_file_region_id 使用するマップのリージョンデータにアクセスするファイル番号を指定
 * @param next_file_npc_id 使用するマップのNPCデータにアクセスするファイル番号を指定
 * @param next_file_mapchip_id 使用するマップのマップチップデータにアクセスするファイル番号を指定
 * @param next_file_bgm_id 使用するマップのサウンドデータにアクセスするファイル番号を指定
 * @param next_map マップ番号を保存
 * @param next_map_canpass_possible_id 次回から描画を行うマップの、キャラクターが通行可能のマップチップIDの最大値を指定
 * @param next_map_object_startid 次回から描画を行うマップの、オブジェクトの開始IDを指定
 * @param next_map_object_endid 次回から描画を行うマップの、オブジェクトの終了IDを指定
 * @param unitx マップ間移動が発生した場合のキャラクターの描画開始座標を指定
 * @param unity マップ間移動が発生した場合のキャラクターの描画開始座標を指定
 * @param fieldx マップ間移動が発生した場合のキャラクターの描画開始座標を指定
 * @param fieldy マップ間移動が発生した場合のキャラクターの描画開始座標を指定
 * @note   
 * @retval None
 */
typedef struct map_move_all
{
	uint32_t next_mapname_id;
	uint32_t event_type;
	uint32_t next_file_mapdata_id;
	uint32_t next_file_object_id;
	uint32_t next_file_region_id;
	uint32_t next_file_npc_id;
	uint32_t next_file_mapchip_id;
	uint32_t next_file_bgm_id;
	uint32_t next_map;
	uint8_t next_map_canpass_id;
	uint8_t next_map_object_startid;
	uint8_t next_map_object_endid;
	uint8_t unitx;
	uint8_t unity;
	uint8_t fieldx;
	uint8_t fieldy;
} MapMoveAll;

static const MapMoveAll map_move_all[] =
{
	{TRY_ROMEN_VIRRAGE_ID, EVENT_TYPE_DANGEON_MOVE,
	FILE_ACCESS_MAPDATA_MINIGAME, FILE_ACCESS_MAPDATA_MINIGAME, FILE_ACCESS_MAPDATA_MINIGAME, FILE_ACCESS_MAPDATA_MINIGAME, FILE_ACCESS_CHIP_MINIGAME,SOUND_ID_FIELD_GEKAI,
	ROMEN_DANGEON_ID,
	0, 0, 0,
	5, 7, 0, 0},

	{TRY_ROMEN_DANGEON_ID, EVENT_TYPE_SUBMAP_MOVE,
	FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, FILE_ACCESS_CHIP_ROMEN_VIRRAGE, SOUND_ID_MURA_1,
	ROMEN_VIRRAGE_ID,
	CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE,
	OBJECT_START_MAPID_ROMEN_VIRRAGE,
	OBJECT_END_MAPID_ROMEN_VIRRAGE,
	10, 12, 16, 35,},

	{TRY_ROMEN_EXIT_ID, EVENT_TYPE_WORLD_MOVE,
	FILE_ACCESS_MAPDATA_GEKAI, FILE_ACCESS_MAPDATA_GEKAI_OBJECT, FILE_ACCESS_MAPDATA_GEKAI_REGION, FILE_ACCESS_MAPDATA_GEKAI_NPC, FILE_ACCESS_CHIP_GEKAI, SOUND_ID_FIELD_GEKAI, GEKAI_MAP_ID,
	CAN_PASS_MAPCHIP_ID_MAX_GEKAI,
	OBJECT_START_MAPID_GEKAI,
	OBJECT_END_MAPID_GEKAI,
	10, 7, 160, 39},
};



/* データベース書き込み */
void map_all_write(FILE *fp, FILE *byte)
{
	const MapMoveAll *p = map_move_all;

	for (uint32_t i = 0; i < MAP_MOVE_ALL_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->next_mapname_id);
		fprintf(fp, "0x%08x,\n", p->event_type);
		fprintf(fp, "0x%08x,\n", p->next_file_mapdata_id);
		fprintf(fp, "0x%08x,\n", p->next_file_object_id);
		fprintf(fp, "0x%08x,\n", p->next_file_region_id);
		fprintf(fp, "0x%08x,\n", p->next_file_npc_id);
		fprintf(fp, "0x%08x,\n", p->next_file_mapchip_id);
		fprintf(fp, "0x%08x,\n", p->next_file_bgm_id);
		fprintf(fp, "0x%08x,\n", p->next_map);
		fprintf(fp, "0x%08x,\n", p->next_map_canpass_id);
		fprintf(fp, "0x%08x,\n", p->next_map_object_startid);
		fprintf(fp, "0x%08x,\n", p->next_map_object_endid);
		fprintf(fp, "0x%08x,\n", p->unitx);
		fprintf(fp, "0x%08x,\n", p->unity);
		fprintf(fp, "0x%08x,\n", p->fieldx);
		fprintf(fp, "0x%08x,\n", p->fieldy);

		for (int j = 0; j < 16; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	error_print(NPC_MSG_DB_SIZE, TRY_MAP_NAME_END, "MAP ALL MOVE NUMBER");
}

#endif
