#ifndef story_struct_h   /* prevent circular inclusions */
#define story_struct_h   /* by using protection macros */


/*
 * 構造体の要素数
 */
#define SYSTEM_FUNC_DB_SIZE	  ((sizeof (system_state))/(sizeof (SystemState)))
#define DARKING_STATE_DB_SIZE ((sizeof (darking_state))/(sizeof (DarkingState)))


/*
 * 関数ポインタを使用するため構造体の前にファイル内関数を定義
 */
static void system_opening_window(GameWrapper *const game);
static void system_standerd_window(GameWrapper *const game);
static void system_nextdata_reading(GameWrapper *const game);
static void system_state_nextwindow(GameWrapper *const game);
static void system_msg_window(GameWrapper *const game);
static void system_battle_window(GameWrapper *const game);
static void system_battle_state(GameWrapper *const game);
static void system_minigame_window(GameWrapper *const game);
static void system_menu_window(GameWrapper *const game);

/*
 * システムモードを管理する構造体型関数ポインタ
 * systemメンバと一致した行の関数の処理を行う
 */
typedef struct
{
	uint32_t system;
	void (*system_func)(GameWrapper *const game);
} SystemState;

static const SystemState system_state[] =
{
	{SYSTEM_OPENING_WINDOW,			system_opening_window 		},
	{SYSTEM_MAP_DEFAULT_WINDOW, 	system_standerd_window,		},
	{SYSTEM_MAP_DARKENING_WINDOW, 	system_state_nextwindow,	},
	{SYSTEM_MAP_DARKENING_SUBMAP, 	system_state_nextwindow,	},
	{SYSTEM_NEXT_ALLDATA_READING,	system_nextdata_reading,	},
	{SYSTEM_NEXT_SUBMAP_READING,	system_nextdata_reading,	},
	{SYSTEM_MAP_GRADUALLY_WINDOW, 	system_state_nextwindow,	},
	{SYSTEM_SHOP_WINDOW,  			system_standerd_window,		},
	{SYSTEM_MSG_WINDOW,  			system_msg_window,			},
	{SYSTEM_BATTLE_STATE,  			system_battle_state,		},
	{SYSTEM_BATTLE_ENEMY,  			system_battle_window,		},
	{SYSTEM_BATTLE_RESULT, 			system_standerd_window,		},
	{SYSTEM_MINIGAME_WINDOW,		system_minigame_window		},
	{SYSTEM_MENU_WINDOW,			system_menu_window			},
};


/*
 * 暗転描画モード時の状態遷移を管理
 * 
 * now_system
 * 現在のシステムと一致した行のデータを取得
 * 
 * next_system
 * 次に処理を行うシステムの状態を指定
 * 
 * next_draw_type
 * 次の描画方法を管理
 */
typedef struct
{
	uint32_t now_system;
	uint32_t next_system;
	uint8_t  next_draw_type;
} DarkingState;

static const DarkingState darking_state[] = {
	{SYSTEM_MAP_DARKENING_SUBMAP, SYSTEM_NEXT_SUBMAP_READING,	DISPLAY_NEXT_READY			},
	{SYSTEM_MAP_DARKENING_WINDOW, SYSTEM_NEXT_ALLDATA_READING,	DISPLAY_NEXT_READY			},
	{SYSTEM_MAP_GRADUALLY_WINDOW, SYSTEM_MAP_DEFAULT_WINDOW,	DISPLAY_FIELD_CENTER_DRAW	},
};

#endif
