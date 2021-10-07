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
#ifndef event_map_direct_db_h   /* prevent circular inclusions */
#define event_map_direct_db_h   /* by using protection macros */

/*
 * Ubuntu LTS 20.04
 * Vitis 20.2
 * Kimura 2021/05/21
 *
 * -
 * ワールドマップの当たり判定を管理するヘッダーファイル
 * -
 * ワールドマップ内の固定座標イベントはマップ間移動のみである
 * 当たり判定が行われた場合にシステムの状態と描画方法を暗転モードにする
 * 
 */

#ifndef direct_worldmap_struct_h   /* prevent circular inclusions */
#define direct_worldmap_struct_h   /* by using protection macros */


/*
 * 構造体の要素数
 */
#define GEKAI_DIRECT_DB_SIZE ((sizeof (gekai_direct)) / (sizeof (GekaiDirect)))


/*
 * ワールドマップ下界の当たり判定座標を管理
 * 
 * WorldEvent構造体にアクセスするためのイベントIDを指定
 * event_id
 * 
 * 当たり判定時のイベントタイプを指定
 * event_type
 * 
 * マップ間移動の当たり判定を行うオブジェクトの描画座標
 * direct_xpos
 * direct_ypos
 */
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
 * 2. 一致すればevent_idとevent_typeを保存
 * 3. 移動アニメーションのため画面を暗転させる
 * 4. 暗転中に取得したevent_typeでデータの取得数の判定を行う。
 * 5. 判定を行ったらevent_idでデータベースの検索を行いデータを取得する
 * 6. 表示させるマップデータをフレームバッファに保存し表示する
 * 7. 特殊イベントが無ければ1 ~ 6を繰り返す
 * 
 * @param world_direcy_id データベースの当たり判定検索用のIDを保存
 * @param direct_xpos 当たり判定のx座標を指定
 * @param direct_ypos 当たり判定のy座標を指定
 * @param event_id 連番のイベント番号を指定する
 * @param event_type 発生するイベントタイプを指定する
 * @retval None
 */
typedef struct worldmap_direct
{
	uint32_t world_direct_id;
	uint32_t direct_xpos;
	uint32_t direct_ypos;
	uint32_t event_id;
	uint32_t event_type;
} WorldmapDirect;

static const WorldmapDirect worldmap_direct[] =
{
	{WORLD_DIRECT_GEKAI_ROMEN_VILLAGE, 171, 45, DIRECT_GEKAI_ROMEN_VILLAGE_ID, EVENT_TYPE_WORLD_STATE_OTHER_MAP, },
	{WORLD_DIRECT_GEKAI_ROMEN_TREE,    166, 49, DIRECT_GEKAI_ROMEN_TREE_ID, EVENT_TYPE_WORLD_STATE_OTHER_MAP, },
};


/**
 * @brief  ワールドマップの当たり判定検索時のループ回数を管理するデータベース
 * @note   
 * 
 * @param ワールドマップのIDを指定
 * @param 上記のWorldmapDirectの検索する開始行を指定
 * @param 上記のWorldmapDirectの検索する終了行を指定
 * @retval None
 */
typedef struct world_loop_count
{
	uint32_t map_name;
	uint32_t start_id;
	uint32_t loop_count;
} WorldLoopCount;

static const WorldLoopCount world_loop_count[] = {
	{GEKAI_MAP_ID,	WORLD_DIRECT_GEKAI_START, WORLD_DIRECT_GEKAI_END},
	{TIKAI_MAP_ID,	WORLD_DIRECT_GEKAI_START, WORLD_DIRECT_GEKAI_END},
	{TENKAI_MAP_ID,	WORLD_DIRECT_GEKAI_START, WORLD_DIRECT_GEKAI_END},
	{HAZAMA_MAP_ID,	WORLD_DIRECT_GEKAI_START, WORLD_DIRECT_GEKAI_END},
	{MAKAI_MAP_ID,	WORLD_DIRECT_GEKAI_START, WORLD_DIRECT_GEKAI_END},
};

#endif