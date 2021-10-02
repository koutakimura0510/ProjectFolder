/*
 * Create 2021/06/28
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * IC      XC7Z020-1CLG400C
 * ROM     256KB
 * RAM     512KB
 * L1Cache 32KB
 * -
 * opening.cで読み込みを行うヘッダーファイル
 */
#ifndef opening_h   /* prevent circular inclusions */
#define opening_h   /* by using protection macros */

/* 関数ポインタ構造体の要素数 */
#define OPENING_FUNC_DB_SIZE	  ((sizeof (opening_state))/(sizeof (OpeningState)))

/*
 * ver1. 2021/07/02
 * タイトル画面の状態遷移ID
 */
typedef enum
{
	OPENING_BITMAP_LOAD,
	OPENING_MUSIC_LOAD,
	OPENING_DB_LOAD,
	OPENING_DEMO_WINDOW,
	OPENING_SYSTEM_DRAW,
	OPENING_BUILD_SELECT,
	OPENING_SAVE_LOAD,
	OPENING_LOAD_END,
} OpeningStateID;


/*
 * オープニングファイル内関数
 */
static void opening_demo_window(GameWrapper *const game);
static void opening_bitmap_load(GameWrapper *const game);
static void opening_music_load(GameWrapper *const game);
static void opening_db_load(GameWrapper *const game);
static void opening_title_draw(GameWrapper *const game);
static void opening_savedata_load(GameWrapper *const game);
static void build_select(GameWrapper *const game);


/*
 * ver1. 2021/07/21
 * オープニングの状態遷移管理データベース
 */

typedef struct
{
	uint8_t system;
	void (*opening_func)(GameWrapper *const game);
} OpeningState;

static const OpeningState opening_state[] =
{
	{OPENING_BITMAP_LOAD,	opening_bitmap_load		},
	{OPENING_MUSIC_LOAD,	opening_music_load		},
	{OPENING_DB_LOAD, 		opening_db_load,		},
	{OPENING_DEMO_WINDOW,	opening_demo_window		},
	{OPENING_SYSTEM_DRAW, 	opening_title_draw,		},
	{OPENING_BUILD_SELECT, 	build_select,			},
	{OPENING_SAVE_LOAD, 	opening_savedata_load,	},
};


/*
 * ver1. 2021/06/28
 * システム起動時にファイルデータを読み込むためのIDを管理する配列
 * 読み込むデータ量がおおくなったためヘッダーファイルに分類
 */
static const uint8_t bitmap_init[] = 
{
	/* 第一水準・第二水準・縦横12サイズのフォントデータ */
	FILE_ACCESS_FONT_SJIS,

	/* マップ移動時のマップチップデータ */
	FILE_ACCESS_HERO_CHIP,

	/* 戦闘に使用する仲間のマップチップデータ */
	FILE_ACCESS_HERO_BATTLE_CHIP,

	/* 戦闘に使用する行動順が来た時の枠 */
	FILE_ACCESS_HERO_BATTLE_WAKU,

	/* 戦闘に使用する数字フォントデータ */
	// FILE_ACCESS_FONT_DAMEGE,
	// FILE_ACCESS_FONT_HEAL,

	/* 基本アイコン、今のところ小中サイズ */
	FILE_ACCESS_BACK_ICON,
	FILE_ACCESS_BACK_ICON2,

	/* バックグラウンドデータ */
	// FILE_ACCESS_BACK_TITLE1,
	// FILE_ACCESS_BACK_GRASS,
	// FILE_ACCESS_BACK_FOG,
	FILE_ACCESS_NPC_WORLD,

	/* 戦闘の基本動作エフェクト */
	// FILE_ACCESS_EFFECT_BATTLE_MAGIC_1,
	// FILE_ACCESS_EFFECT_BATTLE_SLASH_1,
	// FILE_ACCESS_EFFECT_BATTLE_BROW_1,

	/* ステータス系 */
	// FILE_ACCESS_EFFECT_BATTLE_POWER_UP,
	// FILE_ACCESS_EFFECT_BATTLE_POWER_DOWN,
	// FILE_ACCESS_EFFECT_BATTLE_POWER_DOWN_2,
	// FILE_ACCESS_EFFECT_BATTLE_DEF_1,
	// FILE_ACCESS_EFFECT_BATTLE_RES_1,
	// FILE_ACCESS_EFFECT_BATTLE_HEST_1,
	// FILE_ACCESS_EFFECT_BATTLE_SLOW_1,

	// /* 回復系 */
	// FILE_ACCESS_EFFECT_BATTLE_HEAL_1,
	// FILE_ACCESS_EFFECT_BATTLE_ESNA_1,
	// FILE_ACCESS_EFFECT_BATTLE_RISE_1,

	// /* 状態異常 */
	// FILE_ACCESS_EFFECT_BATTLE_CONFIG_1,
	// FILE_ACCESS_EFFECT_BATTLE_POISON_1,
	// FILE_ACCESS_EFFECT_BATTLE_PARARAI_1,
	// FILE_ACCESS_EFFECT_BATTLE_BERSEK_1,
	// FILE_ACCESS_EFFECT_BATTLE_RIGENE_1,
	// FILE_ACCESS_EFFECT_BATTLE_DEATH_1,

	// /* ループ画像 */
	// FILE_ACCESS_EFFECT_BATTLE_POISON_2,
	// FILE_ACCESS_EFFECT_BATTLE_CONFIG_2,
	// FILE_ACCESS_EFFECT_BATTLE_PARARAI_2,
	// FILE_ACCESS_EFFECT_BATTLE_BUF_2,
	// FILE_ACCESS_EFFECT_BATTLE_BERSEK_2,
	// FILE_ACCESS_EFFECT_BATTLE_REFREK_2,
	// FILE_ACCESS_EFFECT_BATTLE_RIGENE_2,
	// // FILE_ACCESS_EFFECT_BATTLE_KANAKO_8,
	// FILE_ACCESS_EFFECT_BATTLE_REMIRIA_7,

	/* ミニゲーム系 */
	FILE_ACCESS_MAPDATA_BLOCK1,
	FILE_ACCESS_FONT_SUUZI_1,
	FILE_ACCESS_FONT_RESULT,
	FILE_ACCESS_HIT_EFFECT_1,
	FILE_ACCESS_HIT_EFFECT_2,
	FILE_ACCESS_HIT_EFFECT_3, 
	FILE_ACCESS_CHIP_MINIGAME,

	// FILE_ACCESS_ENEMY_GURL_1,
	// FILE_ACCESS_ENEMY_HIYOKO_1,
};

static const uint8_t sound_init[] =
{
	FILE_ACCESS_BGM_TITLE,
	// FILE_ACCESS_BGM_BATTLE_FANFARE,
	// FILE_ACCESS_BGM_ENDING,
	// FILE_ACCESS_BGM_BATTLE_DEFAULT,
	// FILE_ACCESS_BGM_BATTLE_ENCOUNT,
	// FILE_ACCESS_BGM_BATTLE_TRUN,
	// FILE_ACCESS_BGM_BATTLE_DAMAGE,
	// FILE_ACCESS_BGM_BATTLE_KNIFE,
	// FILE_ACCESS_BGM_BATTLE_SPEAR,
	// FILE_ACCESS_BGM_BATTLE_PUNCH,
	// FILE_ACCESS_BGM_BATTLE_MISS,
	// FILE_ACCESS_BGM_BATTLE_DEFEAT1,
	// FILE_ACCESS_BGM_BATTLE_DEFEAT2,
	// FILE_ACCESS_BGM_BATTLE_RUN,
	// FILE_ACCESS_BGM_BATTLE_BRAW_1,
	FILE_ACCESS_BGM_CMD_ENTER,
	FILE_ACCESS_BGM_CMD_DOOR1,
	FILE_ACCESS_BGM_CMD_DOOR2,
	FILE_ACCESS_BGM_CMD_CHEST,
	FILE_ACCESS_BGM_CMD_SWITCH,
	FILE_ACCESS_BGM_CMD_GOLD,
	FILE_ACCESS_BGM_CMD_SELECT1,
	FILE_ACCESS_BGM_CMD_SELECT2,
	FILE_ACCESS_BGM_CMD_COLLAPSE,
	FILE_ACCESS_BGM_CMD_KAIDAN,
	FILE_ACCESS_BGM_CMD_TAKARA,
	FILE_ACCESS_BGM_CMD_SUCCESS,
	FILE_ACCESS_BGM_CMD_FAIL,
	FILE_ACCESS_BGM_CMD_CANSEL,

	// /* 専用基本音 */
	// FILE_ACCESS_BGM_EFFECT_MAGIC_1,

	// /* ステータス系 */
	// FILE_ACCESS_BGM_EFFECT_POWER_UP,
	// FILE_ACCESS_BGM_EFFECT_POWER_DOWN,
	// FILE_ACCESS_BGM_EFFECT_DEF_1,
	// FILE_ACCESS_BGM_EFFECT_HEST_1,
	// FILE_ACCESS_BGM_EFFECT_SLOW_1,

	// /* 回復系 */
	// FILE_ACCESS_BGM_EFFECT_HEAL_1,
	// FILE_ACCESS_BGM_EFFECT_ESNA_1,
	// FILE_ACCESS_BGM_EFFECT_RISE_1,

	// /* 状態異常 */
	// FILE_ACCESS_BGM_EFFECT_CONFIG_1,
	// FILE_ACCESS_BGM_EFFECT_POISON_1,
	// FILE_ACCESS_BGM_EFFECT_PARARAI_1,
	// FILE_ACCESS_BGM_EFFECT_KANAKO_8,

	/* ミニゲーム */
	// FILE_ACCESS_BGM_COIN,
	// FILE_ACCESS_BGM_JUMP,
	// FILE_ACCESS_BGM_BOM,
	// FILE_ACCESS_BGM_PITYN,
};

#endif
