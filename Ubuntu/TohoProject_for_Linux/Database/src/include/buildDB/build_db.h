/*
 * Create 2021/10/07
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * 村やダンジョンイベント判定を管理するファイル
 */
#ifndef build_db_h   /* prevent circular inclusions */
#define build_db_h   /* by using protection macros */


/* データベースの行数 */
#define BUILD_EVENT_POS_DB_SIZE ((sizeof (build_event_pos))/(sizeof (BuildEventPos)))
#define BUILD_EVENT_DB_SIZE ((sizeof (build_event))/(sizeof (BuildEvent)))
#define BUILD_SUBMAP_DB_SIZE ((sizeof (build_submap))/(sizeof (BuildSubmap)))


/**
 * @brief  村・建物・ダンジョンの固定イベント座標を管理するデータベース
 * @note   
 * 
 * @param xpos イベントを発生させるx座標を指定
 * @param ypos イベントを発生させるy座標を指定
 * @param event_id 発生したイベントのIDを指定
 * @param isVariable 発生したイベントが可変か不変化を指定
 */
typedef struct build_event_pos
{
	uint32_t event_id;
	uint32_t xpos;
	uint32_t ypos;
	uint32_t isVariable;
} BuildEventPos;

static const BuildEventPos build_event_pos[] =
{
	{DIRECT_ROMEN_ID_EXIT,			0,  0, 		EVENT_VARIABLE	},
	{DIRECT_ROMEN_ID_HOUSE1,		41, 20, 	EVENT_FIXED		},
	{DIRECT_ROMEN_ID_HOUSE2,		11, 12, 	EVENT_FIXED		},
	{DIRECT_ROMEN_ID_KANBAN1,		17, 41, 	EVENT_FIXED		},
	{DIRECT_ROMEN_ID_KANBAN3_1,		31, 26, 	EVENT_FIXED		},
	{DIRECT_ROMEN_ID_KANBAN3_2,		32, 26, 	EVENT_FIXED		},
	{DIRECT_ROMEN_ID_KANBAN4,		24, 15, 	EVENT_FIXED		},
	{DIRECT_ROMEN_ID_KANBAN5,		29, 15, 	EVENT_FIXED		},
	{DIRECT_ROMEN_ID_ITEM_SHOP,		10, 10, 	EVENT_FIXED		},
	{DIRECT_ROMEN_ID_WEPON_SHOP,	10, 10, 	EVENT_FIXED		}, /* テーブルの向こう側にいる場合処理 */
	{DIRECT_ROMEN_ID_ITEM1,			18, 11, 	EVENT_FIXED		},
	{DIRECT_ROMEN_ID_ITEM2,			18, 39, 	EVENT_FIXED		},
	{DIRECT_ROMEN_ID_ITEM3,			30, 11, 	EVENT_FIXED		},
	{DIRECT_ROMEN_ID_LOOM1,			12, 10, 	EVENT_FIXED		},
	{DIRECT_ROMEN_ID_LOOM2,			12, 10, 	EVENT_FIXED		},
};


/**
 * @brief  発生する固定イベントを管理するデータベース
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
typedef struct build_event
{
	uint32_t event_id;
	uint32_t event_type;
	uint32_t next_mapname_id;
	uint32_t next_system;
	uint8_t next_drawtype;
} BuildEvent;

static const BuildEvent build_event[] =
{
	{DIRECT_ROMEN_ID_EXIT,	 	 EVENT_TYPE_WORLD_STATE_OTHER_MAP, 	TRY_ROMEN_EXIT_ID, SYSTEM_MAP_DARKENING_WINDOW,	DISPLAY_DARKENING_DRAW,		},
	{DIRECT_ROMEN_ID_HOUSE1,	 EVENT_TYPE_SAMEMAP_MOVE,  			TRY_MAP_NAME_NULL, SYSTEM_MAP_DARKENING_SUBMAP,	DISPLAY_DARKENING_DRAW,    	},
	{DIRECT_ROMEN_ID_HOUSE2,	 EVENT_TYPE_SAMEMAP_MOVE,  			TRY_MAP_NAME_NULL, SYSTEM_MAP_DARKENING_SUBMAP,	DISPLAY_DARKENING_DRAW,    	},
	{DIRECT_ROMEN_ID_KANBAN1, 	 EVENT_TYPE_MSG_TORK,   			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	},
	{DIRECT_ROMEN_ID_KANBAN3_1,	 EVENT_TYPE_MSG_TORK,   			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	},
	{DIRECT_ROMEN_ID_KANBAN3_2,	 EVENT_TYPE_MSG_TORK,   			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	},
	{DIRECT_ROMEN_ID_KANBAN4, 	 EVENT_TYPE_MSG_TORK,   			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	},
	{DIRECT_ROMEN_ID_KANBAN5, 	 EVENT_TYPE_MSG_TORK,   			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	},
	{DIRECT_ROMEN_ID_ITEM_SHOP,  EVENT_TYPE_TOOLS_SHOP, 			TRY_MAP_NAME_NULL, SYSTEM_SHOP_WINDOW,			DISPLAY_FIELD_CENTER_DRAW,	},
	{DIRECT_ROMEN_ID_WEPON_SHOP, EVENT_TYPE_TOOLS_SHOP, 			TRY_MAP_NAME_NULL, SYSTEM_SHOP_WINDOW,			DISPLAY_FIELD_CENTER_DRAW,	},/* テーブルの向こう側にいる場合処理 */
	{DIRECT_ROMEN_ID_ITEM1,	 	 EVENT_TYPE_TREASURE_GET,  			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	},
	{DIRECT_ROMEN_ID_ITEM2,	 	 EVENT_TYPE_TREASURE_GET,  			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	},
	{DIRECT_ROMEN_ID_ITEM3,	 	 EVENT_TYPE_ITEM_GET,   			TRY_MAP_NAME_NULL, SYSTEM_MSG_WINDOW,			DISPLAY_FIELD_CENTER_DRAW, 	},
	{DIRECT_ROMEN_ID_LOOM1,	 	 EVENT_TYPE_SAMEMAP_MOVE,  			TRY_MAP_NAME_NULL, SYSTEM_MAP_DARKENING_SUBMAP,	DISPLAY_DARKENING_DRAW, 	},
	{DIRECT_ROMEN_ID_LOOM2,	 	 EVENT_TYPE_SAMEMAP_MOVE,  			TRY_MAP_NAME_NULL, SYSTEM_MAP_DARKENING_SUBMAP,	DISPLAY_DARKENING_DRAW, 	},
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
typedef struct build_submap
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
} BuildSubmap;

static const BuildSubmap build_submap[] =
{
	{DIRECT_ROMEN_ID_HOUSE1, FILE_ACCESS_MAPDATA_ROMEN_HOUSE1,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE1_OBJECT,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE1_REGION, FILE_ACCESS_MAPDATA_ROMEN_HOUSE1_NPC, ROMEN_HOUSE1_LOOM1_ID, 	10, 1, 0, 0},
	{DIRECT_ROMEN_ID_HOUSE2, FILE_ACCESS_MAPDATA_ROMEN_HOUSE2,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE2_OBJECT,  FILE_ACCESS_MAPDATA_ROMEN_HOUSE2_REGION, FILE_ACCESS_MAPDATA_ROMEN_HOUSE2_NPC, ROMEN_HOUSE2_LOOM1_ID, 	10, 7, 0, 0},
	{DIRECT_ROMEN_ID_LOOM1,  FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, ROMEN_VIRRAGE_ID, 		0, 0, 0, 0},
	{DIRECT_ROMEN_ID_LOOM2,	 FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, ROMEN_VIRRAGE_ID, 		1, 1, 0, 0},
};


/**
 * @brief  固定イベント座標データ書き出し
 * @note   
 * @retval None
 */
void build_pos_write(FILE *fp, FILE *byte)
{
	const BuildEventPos *p = build_event_pos;

	for (uint32_t i = 0; i < BUILD_EVENT_POS_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->event_id);
		fprintf(fp, "0x%08x,\n", p->xpos);
		fprintf(fp, "0x%08x,\n", p->ypos);
		fprintf(fp, "0x%08x,\n", p->isVariable);

		for (uint32_t j = 0; j < BUILD_POS_MEMBER_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	error_print(BUILD_EVENT_POS_DB_SIZE, DIRECT_BUILD_END_EVENT, "BUILD POS TOTAL NUMBER");
}


/**
 * @brief  固定イベントデータ書き出し
 * @note   
 * @retval None
 */
void build_event_write(FILE *fp, FILE *byte)
{
	const BuildEvent *p = build_event;

	for (uint32_t i = 0; i < BUILD_EVENT_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->event_id);
		fprintf(fp, "0x%08x,\n", p->event_type);
		fprintf(fp, "0x%08x,\n", p->next_mapname_id);
		fprintf(fp, "0x%08x,\n", p->next_system);
		fprintf(fp, "0x%08x,\n", p->next_drawtype);

		for (uint32_t j = 0; j < BUILD_EVENT_MEMBER_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	error_print(BUILD_EVENT_DB_SIZE, DIRECT_BUILD_END_EVENT, "BUILD EVENT TOTAL NUMBER");
}


/**
 * @brief  建物内のサブマップ情報書き出し
 * @note   
 * @retval None
 */
void build_submap_write(FILE *fp, FILE *byte)
{
	const BuildSubmap *p = build_submap;

	for (uint32_t i = 0; i < BUILD_SUBMAP_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->event_id);
		fprintf(fp, "0x%08x,\n", p->next_file_mapdata_id);
		fprintf(fp, "0x%08x,\n", p->next_file_object_id);
		fprintf(fp, "0x%08x,\n", p->next_file_region_id);
		fprintf(fp, "0x%08x,\n", p->next_file_npc_id);
		fprintf(fp, "0x%08x,\n", p->next_map);
		fprintf(fp, "0x%08x,\n", p->unitx);
		fprintf(fp, "0x%08x,\n", p->unity);
		fprintf(fp, "0x%08x,\n", p->fieldx);
		fprintf(fp, "0x%08x,\n", p->fieldy);

		for (uint32_t j = 0; j < BUILD_SUBMAP_MEMBER_NUMBER; j++)
		{
			fprintf(byte, "0x%08x,\n", 1);
		}
	}

	error_print(BUILD_SUBMAP_DB_SIZE, 4, "BUILD SUBMAP TOTAL NUMBER");
}


#endif