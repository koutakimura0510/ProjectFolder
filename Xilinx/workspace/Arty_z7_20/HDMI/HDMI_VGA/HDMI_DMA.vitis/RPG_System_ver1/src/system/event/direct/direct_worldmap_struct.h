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
typedef struct gekai_direct
{
	uint32_t event_id;
	uint32_t event_type;
	uint8_t  direct_xpos;
	uint8_t  direct_ypos;
} GekaiDirect;

static const GekaiDirect gekai_direct[] =
{
	{DIRECT_GEKAI_ROMEN_TREE_ID,	EVENT_TYPE_WORLD_STATE_OTHER_MAP, 166, 49, },
	{DIRECT_GEKAI_ROMEN_VILLAGE_ID,	EVENT_TYPE_WORLD_STATE_OTHER_MAP, 171, 45, },
};


/*
 * ワールドマップの当たり判定データベースを管理するラッパー
 * 
 */
typedef struct world_wrapper
{
	const GekaiDirect *gekai;
} WorldWrapper;

static const WorldWrapper world_wrapper =
{
	gekai_direct,
};


#endif
