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
#define EVENT_WORLD_DB_SIZE 		((sizeof (map_move_all)) / (sizeof (MapMoveAll)))
#define EVENT_SUBMAP_MOVE_DB_SIZE 	((sizeof (submap_move)) / (sizeof (SubmapMove)))


/**
 * @brief  マップ間移動時にBGMと使用するマップチップの画像データの変更を行う必要がある場合の情報を管理
 * 
 * @param event_id イベントIDを指定し一致した行のデータを取得
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
	uint32_t event_id;
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
	{DIRECT_GEKAI_ROMEN_TREE_ID, EVENT_TYPE_DANGEON_MOVE,
	FILE_ACCESS_MAPDATA_MINIGAME, FILE_ACCESS_MAPDATA_MINIGAME, FILE_ACCESS_MAPDATA_MINIGAME, FILE_ACCESS_MAPDATA_MINIGAME, FILE_ACCESS_CHIP_MINIGAME,SOUND_ID_FIELD_GEKAI,
	ROMEN_DANGEON_ID,
	0, 0, 0,
	5, 7, 0, 0},

	{DIRECT_GEKAI_ROMEN_VILLAGE_ID, EVENT_TYPE_SUBMAP_MOVE,
	FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, FILE_ACCESS_CHIP_ROMEN_VIRRAGE, SOUND_ID_MURA_1,
	ROMEN_VIRRAGE_ID,
	CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE,
	OBJECT_START_MAPID_ROMEN_VIRRAGE,
	OBJECT_END_MAPID_ROMEN_VIRRAGE,
	10, 12, 16, 35,},

	{DIRECT_ROMEN_ID_EXIT, EVENT_TYPE_WORLD_MOVE,
	FILE_ACCESS_MAPDATA_GEKAI, FILE_ACCESS_MAPDATA_GEKAI_OBJECT, FILE_ACCESS_MAPDATA_GEKAI_REGION, FILE_ACCESS_MAPDATA_GEKAI_NPC, FILE_ACCESS_CHIP_GEKAI, SOUND_ID_FIELD_GEKAI, GEKAI_MAP_ID,
	CAN_PASS_MAPCHIP_ID_MAX_GEKAI,
	OBJECT_START_MAPID_GEKAI,
	OBJECT_END_MAPID_GEKAI,
	10, 7, 160, 39},
};


/*
 *
 * ver1. 2021/06/02
 * 当たり判定が行われた場合、当たり判定を管理するbuild_struct.hに定義されている構造体のeventidを取得し、
 * このデータベースのevent_idと一致した行のマップデータと開始座標を取得する
 * 同一マップ間の移動は同じマップチップを使用するため、
 * マップデータのファイルと次のマップデータを表すIDだけ管理する
 * 
 * 動作例
 * ロメン村の家１の入り口と当たり判定があった場合、eventidを取得
 * 次にこの構造体のメンバevent_idを比較していき、一致した行のマップデータアクセスID、移動先のマップ名、表示座標を取得する
 * サブマップ間移動のため、家１の部屋１に移動IDを更新する。
 * 部屋１の出口と当たり判定があった場合は、ロメン村の全体マップに移動したとみなし、そのデータを取得する。
 */
typedef struct submap_move
{
	uint32_t event_id;
	uint32_t next_file_mapdata_id;
	uint32_t next_file_object_id;
	uint32_t next_map;
	uint8_t unitx;
	uint8_t unity;
	uint8_t fieldx;
	uint8_t fieldy;
} SubmapMove;

static const SubmapMove submap_move[] =
{
	{DIRECT_ROMEN_ID_HOUSE1, FILE_ACCESS_MAPDATA_ROMEN_HOUSE1,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE1_OBJECT,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE1_REGION, FILE_ACCESS_MAPDATA_ROMEN_HOUSE1_NPC, ROMEN_HOUSE1_LOOM1_ID, 	10, 1, 0, 0},
	{DIRECT_ROMEN_ID_HOUSE2, FILE_ACCESS_MAPDATA_ROMEN_HOUSE2,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE2_OBJECT,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE2_REGION, FILE_ACCESS_MAPDATA_ROMEN_HOUSE2_NPC, ROMEN_HOUSE2_LOOM1_ID, 	10, 7, 0, 0},
	{DIRECT_ROMEN_ID_LOOM1,  FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, ROMEN_VIRRAGE_ID, 		0, 0, 0, 0},
	{DIRECT_ROMEN_ID_LOOM2,	 FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, ROMEN_VIRRAGE_ID, 		1, 1, 0, 0},

};

#endif
