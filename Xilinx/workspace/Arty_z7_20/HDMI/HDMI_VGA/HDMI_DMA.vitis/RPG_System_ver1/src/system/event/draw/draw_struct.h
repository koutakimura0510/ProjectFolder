#ifndef draw_struct_h   /* prevent circular inclusions */
#define draw_struct_h   /* by using protection macros */

/*
 * 構造体の要素数
 */
#define DISPLAY_FUNC_DB_SIZE ((sizeof (display_state))/(sizeof (DisplayState)))
#define MAP_STATE_FUNC_DB_SIZE ((sizeof (map_state))/(sizeof (MapState)))



/*
 * 関数ポインタを使用するため構造体の前にファイル内関数を定義
 */
static void map_draw(GameWrapper *const game);
static void map_center_draw(GameWrapper *const game, MapElement *map);
static void map_right_draw(GameWrapper *const game, MapElement *map);
static void map_left_draw(GameWrapper *const game, MapElement *map);
static void map_up_draw(GameWrapper *const game, MapElement *map);
static void map_down_draw(GameWrapper *const game, MapElement *map);
static void frame_buffer_darkening_copy(GameWrapper *const game);
static void frame_buffer_nextdraw_ready(GameWrapper *const game);


/*
 * ver2. 2021/08/21
 * マップ移動の関数を一つにまとめ共有する処理に変更した
 * map_draw関数に突入した場合、下記のMapStateの状態遷移の処理を行う
 *
 * ver1. 2021/06/17
 * 
 * 基本描画関数を管理する構造体型関数ポインタ
 * drawtypeと一致した行の関数の処理を行う
 */
typedef struct display_state
{
	uint8_t drawtype;
	void (*display_func)(GameWrapper *const game);
} DisplayState;

static const DisplayState display_state[] =
{
	{DISPLAY_FIELD_CENTER_DRAW, map_draw,						},
	{DISPLAY_FIELD_RIGHT_DRAW, 	map_draw,						},
	{DISPLAY_FIELD_LEFT_DRAW, 	map_draw,						},
	{DISPLAY_FIELD_UP_DRAW, 	map_draw,						},
	{DISPLAY_FIELD_DOWN_DRAW, 	map_draw,						},
	{DISPLAY_DARKENING_DRAW, 	frame_buffer_darkening_copy, 	},
	{DISPLAY_GRADUALLY_DRAW, 	frame_buffer_darkening_copy, 	},
	{DISPLAY_NEXT_READY, 		frame_buffer_nextdraw_ready, 	},
};


/*
 * ver1. 2021/08/21
 * マップ移動の処理関数を管理するデータベース
 */
typedef struct
{
	uint8_t drawtype;
	void (*map_window)(GameWrapper *const game, MapElement *map);
} MapState;

static const MapState map_state[] =
{
	{DISPLAY_FIELD_CENTER_DRAW, map_center_draw },
	{DISPLAY_FIELD_RIGHT_DRAW, 	map_right_draw  },
	{DISPLAY_FIELD_LEFT_DRAW, 	map_left_draw   },
	{DISPLAY_FIELD_UP_DRAW, 	map_up_draw     },
	{DISPLAY_FIELD_DOWN_DRAW, 	map_down_draw   },
};

#endif
