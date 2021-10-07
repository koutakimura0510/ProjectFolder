/*
 * Create 2021/10/07
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * ロメン村のイベント判定を管理するファイル
 */
#ifndef romen_db_h   /* prevent circular inclusions */
#define romen_db_h   /* by using protection macros */


/* データベースの行数 */
#define ROMEN_EVENT_POS_DB_SIZE ((sizeof (romen_event_pos))/(sizeof (RomenEventPos)))
#define ROMEN_EVENT_DB_SIZE ((sizeof (romen_event))/(sizeof (RomenEvent)))
#define ROMEN_MOVE_DB_SIZE ((sizeof (romen_move))/(sizeof (RomenMove)))


/**
 * @brief  ロメンの村の固定イベント座標を管理するデータベース
 * @note   
 * 
 * @param xpos イベントを発生させるx座標を指定
 * @param ypos イベントを発生させるy座標を指定
 * @param event_id 発生したイベントのIDを指定
 * @param isVariable 発生したイベントが可変か不変化を指定
 */
typedef struct romen_event_pos
{
	uint32_t xpos;
	uint32_t ypos;
	uint32_t event_id;
	uint32_t isVariable;
} RomenEventPos;

static const RomenEventPos romen_event_pos[] =
{
	{0,  0,		DIRECT_ROMEN_ID_EXIT,			EVENT_VARIABLE	},
	{41, 20, 	DIRECT_ROMEN_ID_HOUSE1,			EVENT_FIXED	},
	{11, 12, 	DIRECT_ROMEN_ID_HOUSE2,			EVENT_FIXED	},
	{10, 10,	DIRECT_ROMEN_ID_ITEM_SHOP,		EVENT_FIXED	},
	{10, 10,	DIRECT_ROMEN_ID_WEPON_SHOP,		EVENT_FIXED	},/* テーブルの向こう側にいる場合処理 */
	{18, 11,	DIRECT_ROMEN_ID_ITEM1,			EVENT_FIXED	},
	{18, 39,	DIRECT_ROMEN_ID_ITEM2,			EVENT_FIXED	},
	{30, 11,	DIRECT_ROMEN_ID_ITEM3,			EVENT_FIXED	},
	{17, 41,	DIRECT_ROMEN_ID_KANBAN1,		EVENT_FIXED	},
	{31, 26,	DIRECT_ROMEN_ID_KANBAN3_1,		EVENT_FIXED	},
	{32, 26,	DIRECT_ROMEN_ID_KANBAN3_2,		EVENT_FIXED	},
	{24, 15,	DIRECT_ROMEN_ID_KANBAN4,		EVENT_FIXED	},
	{29, 15,	DIRECT_ROMEN_ID_KANBAN5,		EVENT_FIXED	},
	{12, 10,	DIRECT_ROMEN_ID_LOOM1,			EVENT_FIXED	},
	{12, 10,	DIRECT_ROMEN_ID_LOOM2,			EVENT_FIXED	},
};


/**
 * @brief  ロメンの村の固定イベント座標を管理するデータベース
 * @note   
 * 
 * @param 
 * @param 
 * @param 
 * @param 
 * @param 
 * @param 
 * @param 
 * @retval None
 */
typedef struct romen_event
{
	uint32_t event_id;
	uint32_t event_type;
	uint32_t next_mapname_id;
	uint32_t next_system;
	uint8_t next_drawtype;
	uint8_t xpos;
	uint8_t ypos;
	uint8_t point;
} RomenEvent;

static const RomenEvent romen_event[] =
{
	{DIRECT_ROMEN_ID_START,	 	 EVENT_TYPE_NULL, 					TRY_MAP_NAME_NULL, SYSTEM_NULL,					DISPLAY_NULL_DRAW,			0,	0,	DIRECT_POINT_NULL		},
	{DIRECT_ROMEN_ID_EXIT,	 	 EVENT_TYPE_WORLD_STATE_OTHER_MAP, 	TRY_ROMEN_EXIT_ID, SYSTEM_MAP_DARKENING_WINDOW,	DISPLAY_DARKENING_DRAW,		0,  0,	DIRECT_POINT_VARIABLE	},
	{DIRECT_ROMEN_ID_HOUSE1,	 EVENT_TYPE_SAMEMAP_MOVE,  			TRY_MAP_NAME_NULL, SYSTEM_MAP_DARKENING_SUBMAP,	DISPLAY_DARKENING_DRAW,     41, 20, DIRECT_POINT_FIXED		},
	{DIRECT_ROMEN_ID_HOUSE2,	 EVENT_TYPE_SAMEMAP_MOVE,  			TRY_MAP_NAME_NULL, SYSTEM_MAP_DARKENING_SUBMAP,	DISPLAY_DARKENING_DRAW,     11, 12, DIRECT_POINT_FIXED		},
	{DIRECT_ROMEN_ID_ITEM_SHOP,  EVENT_TYPE_TOOLS_SHOP, 			TRY_MAP_NAME_NULL, SYSTEM_SHOP_WINDOW,			DISPLAY_FIELD_CENTER_DRAW,	10, 10,	DIRECT_POINT_FIXED		},
	{DIRECT_ROMEN_ID_WEPON_SHOP, EVENT_TYPE_TOOLS_SHOP, 			TRY_MAP_NAME_NULL, SYSTEM_SHOP_WINDOW,			DISPLAY_FIELD_CENTER_DRAW,	10, 10,	DIRECT_POINT_FIXED		},/* テーブルの向こう側にいる場合処理 */
	{DIRECT_ROMEN_ID_ITEM1,	 	 EVENT_TYPE_TREASURE_GET,  			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	18, 11,	DIRECT_POINT_FIXED		},
	{DIRECT_ROMEN_ID_ITEM2,	 	 EVENT_TYPE_TREASURE_GET,  			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	18, 39,	DIRECT_POINT_FIXED		},
	{DIRECT_ROMEN_ID_ITEM3,	 	 EVENT_TYPE_ITEM_GET,   			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	30, 11,	DIRECT_POINT_FIXED		},
	{DIRECT_ROMEN_ID_KANBAN1, 	 EVENT_TYPE_MSG_TORK,   			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	17, 41,	DIRECT_POINT_FIXED		},
	{DIRECT_ROMEN_ID_KANBAN3_1,	 EVENT_TYPE_MSG_TORK,   			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	31, 26,	DIRECT_POINT_FIXED		},
	{DIRECT_ROMEN_ID_KANBAN3_2,	 EVENT_TYPE_MSG_TORK,   			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	32, 26,	DIRECT_POINT_FIXED		},
	{DIRECT_ROMEN_ID_KANBAN4, 	 EVENT_TYPE_MSG_TORK,   			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	24, 15,	DIRECT_POINT_FIXED		},
	{DIRECT_ROMEN_ID_KANBAN5, 	 EVENT_TYPE_MSG_TORK,   			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	29, 15,	DIRECT_POINT_FIXED		},
	{DIRECT_ROMEN_ID_LOOM1_START,EVENT_TYPE_NULL, 					TRY_MAP_NAME_NULL, SYSTEM_NULL,					DISPLAY_NULL_DRAW,			0,	0,	DIRECT_POINT_NULL		},
	{DIRECT_ROMEN_ID_LOOM1,	 	 EVENT_TYPE_SAMEMAP_MOVE,  			TRY_MAP_NAME_NULL, SYSTEM_MAP_DARKENING_SUBMAP,	DISPLAY_DARKENING_DRAW, 	12, 10,	DIRECT_POINT_FIXED		},
	{DIRECT_ROMEN_ID_LOOM2_START,EVENT_TYPE_NULL, 					TRY_MAP_NAME_NULL, SYSTEM_NULL,					DISPLAY_NULL_DRAW,			0,	0,	DIRECT_POINT_NULL		},
	{DIRECT_ROMEN_ID_LOOM2,	 	 EVENT_TYPE_SAMEMAP_MOVE,  			TRY_MAP_NAME_NULL, SYSTEM_MAP_DARKENING_SUBMAP,	DISPLAY_DARKENING_DRAW, 	12, 10,	DIRECT_POINT_FIXED		},
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
typedef struct romen_move
{
	uint32_t event_id;
	uint32_t next_file_mapdata_id;
	uint32_t next_file_object_id;
	uint32_t next_file_region_id;
	uint32_t next_file_npc_id;
	uint32_t next_map;
	uint8_t unitx;
	uint8_t unity;
	uint8_t fieldx;
	uint8_t fieldy;
} RomenMove;

static const RomenMove romen_move[] =
{
	{DIRECT_ROMEN_ID_HOUSE1, FILE_ACCESS_MAPDATA_ROMEN_HOUSE1,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE1_OBJECT,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE1_REGION, FILE_ACCESS_MAPDATA_ROMEN_HOUSE1_NPC, ROMEN_HOUSE1_LOOM1_ID, 	10, 1, 0, 0},
	{DIRECT_ROMEN_ID_HOUSE2, FILE_ACCESS_MAPDATA_ROMEN_HOUSE2,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE2_OBJECT,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE2_REGION, FILE_ACCESS_MAPDATA_ROMEN_HOUSE2_NPC, ROMEN_HOUSE2_LOOM1_ID, 	10, 7, 0, 0},
	{DIRECT_ROMEN_ID_LOOM1,  FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, ROMEN_VIRRAGE_ID, 		0, 0, 0, 0},
	{DIRECT_ROMEN_ID_LOOM2,	 FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, ROMEN_VIRRAGE_ID, 		1, 1, 0, 0},
};


// void npc_msg_write(FILE *fp, FILE *byte)
// {
// 	const NpcMsg *p = npc_msg;

// 	for (uint32_t i = 0; i < NPC_MSG_DB_SIZE; i++, p++)
// 	{
// 		uint32_t count = 0;
// 		fprintf(fp, "0x%08x,\n", p->msg_event_id);
// 		fprintf(byte, "0x%08x,\n", 1);

// 		for (uint32_t j = 0; j < NUM(p->msg_event); j++, count++)
// 		{
// 			if ("\0" == p->msg_event[j])
// 			{
// 				fprintf(fp, "0x%08x,\n", count);
// 				fprintf(byte, "0x%08x,\n", 1);
// 				break;
// 			}
// 		}

// 		for (uint32_t j = 0; j < count; j++)
// 		{
// 			fprintf(byte, "0x%08x,\n", sjis_write(fp, p->msg_event[j]));
// 		}
// 	}

// 	printf("VARIABLE MSG TOTAL NUMBER = %ld\n", NPC_MSG_DB_SIZE);
// }


#endif