/*
 * 親データベースのdirect_build_structの
 * メンバー「event_id」と「event_type」を取得する。
 * event_typeがサブマップ間の移動であれば、下記のSebmapMoveデータベースのevent_idと
 * 取得したevent_idが一致した行の開始座標を取得する
 */
#ifndef event_map_move_struct_h   /* prevent circular inclusions */
#define event_map_move_struct_h   /* by using protection macros */


/*
 * 構造体の要素数
 */
#define EVENT_WORLD_DB_SIZE 		((sizeof (world_event)) / (sizeof (WorldEvent)))
#define EVENT_SUBMAP_MOVE_DB_SIZE 	((sizeof (submap_move)) / (sizeof (SubmapMove)))



/*
 *
 * ver2. 2021/06/20
 * 
 * 追加変数
 * next_map_canpass_possible_id
 * next_map_object_startid
 * next_map_object_endid
 * 
 * 通過可能なマップチップIDを指定する変数追加
 * オブジェクト描画IDの範囲の開始と終了を指定する変数追加
 * 
 *
 * ver1. 2021/04/20
 * ワールドマップに関するマップ間移動のデータを管理
 *
 * オブジェクトのIDはdirect_macro.hを参照
 * bitmapと音源データのIDは id_macro.hを参照
 * 
 * イベントIDと一致した行のデータを取得
 * event_id
 * 
 * マップデータが保存されているアドレスにアクセスするためのIDを指定
 * map_id
 * 
 * マップデータに使用するマップチップデータを取得するためのIDを指定
 * bitmap_id
 * 
 * 音源データを管理するデータベースにアクセスするためのIDを指定
 * sound_id
 * 
 * 次のアクセスするマップ番号を保存
 * next_map
 * 
 * 次回から描画を行うマップの、キャラクターが通行可能のマップチップIDの最大値を指定
 * next_map_canpass_possible_id
 * 
 * 次回から描画を行うマップの、オブジェクトの開始と終了IDを指定
 * next_map_object_startid
 * next_map_object_endid
 *
 * マップ間移動が発生した場合のキャラクターの描画開始座標を指定
 * unitx, unity
 * fieldx fieldy
 */
typedef struct world_event
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
} WorldEvent;

static const WorldEvent world_event[] =
{
	{
		DIRECT_GEKAI_ROMEN_TREE_ID,
		EVENT_TYPE_DANGEON_MOVE,
		FILE_ACCESS_MAPDATA_MINIGAME,
		FILE_ACCESS_MAPDATA_MINIGAME,
		FILE_ACCESS_MAPDATA_MINIGAME,
		FILE_ACCESS_MAPDATA_MINIGAME,
		FILE_ACCESS_CHIP_MINIGAME,
		SOUND_ID_FIELD_GEKAI,
		ROMEN_DANGEON_ID,
		0, 0, 0, 5, 7, 0, 0
	},

	{
		DIRECT_GEKAI_ROMEN_VILLAGE_ID,
		EVENT_TYPE_SUBMAP_MOVE,
		FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE,
		FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT,
		FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION,
		FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC,
		FILE_ACCESS_CHIP_ROMEN_VIRRAGE,
		SOUND_ID_MURA_1,
		ROMEN_VIRRAGE_ID,
		CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE,
		OBJECT_START_MAPID_ROMEN_VIRRAGE,
		OBJECT_END_MAPID_ROMEN_VIRRAGE,
		10, 12, 16, 35,
	},

	{
		DIRECT_ROMEN_ID_EXIT,
		EVENT_TYPE_WORLD_MOVE,
		FILE_ACCESS_MAPDATA_GEKAI,
		FILE_ACCESS_MAPDATA_GEKAI_OBJECT,
		FILE_ACCESS_MAPDATA_GEKAI_REGION,
		FILE_ACCESS_MAPDATA_GEKAI_NPC,
		FILE_ACCESS_CHIP_GEKAI,
		SOUND_ID_FIELD_GEKAI,
		GEKAI_MAP_ID,
		CAN_PASS_MAPCHIP_ID_MAX_GEKAI,
		OBJECT_START_MAPID_GEKAI,
		OBJECT_END_MAPID_GEKAI,
		10, 7, 160, 39
	},
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
	{DIRECT_ROMEN_ID_HOUSE1, FILE_ACCESS_MAPDATA_ROMEN_HOUSE1,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE1_OBJECT,  ROMEN_HOUSE1_LOOM1_ID, 	10, 1, 0, 0},
	{DIRECT_ROMEN_ID_HOUSE2, FILE_ACCESS_MAPDATA_ROMEN_HOUSE2,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE2_OBJECT,  ROMEN_HOUSE2_LOOM1_ID, 	10, 7, 0, 0},
	{DIRECT_ROMEN_ID_LOOM1,  FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, ROMEN_VIRRAGE_ID, 		0, 0, 0, 0},
	{DIRECT_ROMEN_ID_LOOM2,	 FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, ROMEN_VIRRAGE_ID, 		1, 1, 0, 0},

};

#endif
