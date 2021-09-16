#ifndef gamemode_h   /* prevent circular inclusions */
#define gamemode_h   /* by using protection macros */

/*
 * ゲームに使用するモードIDを管理を行う
 * 一つのモードにサブIDを使用する可能性があるため
 * モード間のIDは最低1000以上空けておく
 */

/* ウィンドウ描画のモードID */
#define SYSTEM_OPENING_WINDOW		    (0)  	// オープニング描画
#define SYSTEM_BATTLE_STATE				(4999)
#define SYSTEM_BATTLE_ENEMY				(5000)	// バトル突入表示
#define SYSTEM_BATTLE_RESULT			(5001)	// バトル終了表示
#define SYSTEM_MINIGAME_WINDOW	        (7500)	// ミニゲーム表示
#define SYSTEM_MAP_DEFAULT_WINDOW		(10000) // 通常表示
#define SYSTEM_MAP_DARKENING_WINDOW		(10030)	// 徐々に暗転
#define SYSTEM_MAP_DARKENING_SUBMAP	    (10050)	// 徐々に暗転後、次のマップデータの読み込みを行わない
#define SYSTEM_NEXT_ALLDATA_READING		(10100)	// データ読み込み
#define SYSTEM_NEXT_SUBMAP_READING		(10102)	// サブマップ読み込み
#define SYSTEM_MAP_GRADUALLY_WINDOW		(10200)	// 徐々にマップ表示
#define SYSTEM_MENU_WINDOW				(20000)	// メニュー画面表示
#define SYSTEM_MSG_WINDOW				(30000)	// メッセージ画面表示
#define SYSTEM_SHOP_WINDOW				(40000)	// お店の表示画面

/* イベントフラグ関連の定数 */
#define FLAG_NPC_MSG_DEFALUT			(100000)
#define FLAG_NPC_MSG_EVENT				(101000)
#define FLAG_NPC_MSG_CONTINUE			(102000)

/* モードID最大値 */
#define SYSTEM_NULL						(0xffffffff)

#endif
