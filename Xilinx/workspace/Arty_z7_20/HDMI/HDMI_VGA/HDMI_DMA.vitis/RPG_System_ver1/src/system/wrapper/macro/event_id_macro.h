/*
 * イベントIDを管理
 */

#ifndef event_id_macro_h   /* prevent circular inclusions */
#define event_id_macro_h   /* by using protection macros */

/**
 * @brief  イベントの発生条件を判定する定数を定義
 * @note   
 * 
 * 不変イベント
 * ストーリーの進行上まったく変化しないイベントのことやフラグが無いことを指す。
 * 例、村の壺の中のアイテムを一度取ったら無くなり続けるなど
 * 
 * 可変イベント
 * 一度調べたらフラグを取得出来たり、ある特定のフラグが立っていたら
 * イベントが分岐するなどのイベントを指す。
 * 
 * また、出口の判定などにも利用する
 */
#define EVENT_VARIABLE	(1)  /* 可変のイベント */
#define EVENT_FIXED		(3)  /* 不変のイベント */
#define EVENT_NULL		(2)


/*
 * マップ描画に使用する通行可能なマップチップIDの最大値を定義
 * ワールドマップのようにオブジェクトの描画が無い場合は0を指定
 */
#define CAN_PASS_MAPCHIP_ID_MAX_GEKAI	(152)
#define OBJECT_START_MAPID_GEKAI		(0)
#define OBJECT_END_MAPID_GEKAI			(0)


#define CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE	(57)
#define OBJECT_START_MAPID_ROMEN_VIRRAGE		(58)
#define OBJECT_END_MAPID_ROMEN_VIRRAGE			(95)


/**
 * @brief  固定イベントのIDを管理する
 * @note   
 * @retval
 */
typedef enum
{
	EVENT_TYPE_WORLD_MOVE,				// ワールドマップの移動中イベント
	EVENT_TYPE_WORLD_STATE_OTHER_MAP,	// WMAPから他のマップ、又は、ワールドマップに移行する時のイベント
	EVENT_TYPE_SUBMAP_MOVE,				// サブマップの移動中イベント
	EVENT_TYPE_DANGEON_MOVE,			// ダンジョンの移動中イベント
	EVENT_TYPE_MAP_EXIT,				// 出口に出るイベント
	EVENT_TYPE_SAMEMAP_MOVE,			// 同一マップ間移動イベント
	EVENT_TYPE_MSG_TORK,				// NPCと会話
	EVENT_TYPE_TOOLS_SHOP,				// お店
	EVENT_TYPE_ITEM_GET,				// 壺などの画像データが切り替わらないアイテムの取得
	EVENT_TYPE_TREASURE_GET,			// 宝箱の中身を取得、口が空いている画像データに切り替え
	EVENT_TYPE_SPECIAL_TREASURE_GET,	// 鍵を持っていないと空けられない特別な宝箱の中身を取得、口が空いている画像データに切り替え
	EVENT_TYPE_OPEN_DOOR,				// 扉を空けるアニメーションイベント
	EVENT_TYPE_SPECIAL_OPEN_DOOR,		// 鍵付きの扉を空けるイベント
	EVENT_TYPE_NULL,
} FixedEventID;


/*
 * ver1. 2021/08/11
 * 特定の条件下で表示させるウィンドウの番号を定義
 * 
 * game->conf.display.uncommon_windowメンバを使用する
 */
typedef enum
{
	UNCOMMON_WINDOW_OFF,			// ウィンドウOFF
	UNCOMMON_WINDOW_HERO_SKILL,		// バトル中の仲間のわざ発動ウィンドウ
	UNCOMMON_WINDOW_ENEMY_SKILL,	// バトル中の敵のわざ発動ウィンドウ
} UncommonWindowID;


#endif