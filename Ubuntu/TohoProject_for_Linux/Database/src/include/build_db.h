/*
 * Create 2021/08/31
 * Author kimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * NPCのデータについて管理するヘッダーファイル
 */
#ifndef build_db_h_
#define build_db_h_


/* データベースの要素数 */
#define BUILD_CONFIG_DB_SIZE ((sizeof (build_config)) / (sizeof (BuildConfig)))
#define BUILD_FILE_DB_SIZE   ((sizeof (build_file)) / (sizeof (BuildFile)))


/**
 * @brief  町や建物の基本情報を管理するデータベース
 * @note   
 * 
 * @param  map_name direct_macro.hに記載してある名前の定数、nameとIDが連番になっている
 * @param  debug_start_unitx デバッグ時のキャラのx座標
 * @param  debug_start_unity デバッグ時のキャラのy座標
 * @param  debug_start_filedx デバッグ時のフィールドのx座標
 * @param  debug_start_filedy デバッグ時のフィールドのy座標
 * @param  canpass_id 通行可能なマップチップIDの最大値
 * @param  obj_start_id オブジェクト描画に利用するマップチップIDの開始ID
 * @param  obj_endid オブジェクト描画に利用するマップチップIDの終了ID
 * @param  *name 画面に描画する、町やダンジョンの名前
 * 
 * @retval None
 */
typedef struct build_config
{
    uint32_t map_name;
    uint32_t debug_start_unitx;
    uint32_t debug_start_unity;
    uint32_t debug_start_filedx;
    uint32_t debug_start_filedy;
    uint32_t debug_event_type;
    uint32_t canpass_id;
    uint32_t obj_start_id;
    uint32_t obj_end_id;
    const char *name;
} BuildConfig;

static const BuildConfig build_config[] = {
    {GEKAI_MAP_ID,           10,    7, 160, 39, EVENT_TYPE_WORLD_MOVE, CAN_PASS_MAPCHIP_ID_MAX_GEKAI,         OBJECT_START_MAPID_GEKAI,         OBJECT_END_MAPID_GEKAI,            "下界"},
    {TIKAI_MAP_ID,           10,    7, 160, 39, EVENT_TYPE_WORLD_MOVE, CAN_PASS_MAPCHIP_ID_MAX_GEKAI,         OBJECT_START_MAPID_GEKAI,         OBJECT_END_MAPID_GEKAI,            "地界"},
    {TENKAI_MAP_ID,          10,    7, 160, 39, EVENT_TYPE_WORLD_MOVE, CAN_PASS_MAPCHIP_ID_MAX_GEKAI,         OBJECT_START_MAPID_GEKAI,         OBJECT_END_MAPID_GEKAI,            "天界"},
    {HAZAMA_MAP_ID,          10,    7, 160, 39, EVENT_TYPE_WORLD_MOVE, CAN_PASS_MAPCHIP_ID_MAX_GEKAI,         OBJECT_START_MAPID_GEKAI,         OBJECT_END_MAPID_GEKAI,            "狭間"},
    {MAKAI_MAP_ID,           10,    7, 160, 39, EVENT_TYPE_WORLD_MOVE, CAN_PASS_MAPCHIP_ID_MAX_GEKAI,         OBJECT_START_MAPID_GEKAI,         OBJECT_END_MAPID_GEKAI,            "魔界"},
    {ROMEN_VIRRAGE_ID,       10,    8,  18, 21, EVENT_TYPE_SUBMAP_MOVE, CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE, OBJECT_START_MAPID_ROMEN_VIRRAGE, OBJECT_END_MAPID_ROMEN_VIRRAGE,    "ロメンの村"},
    {ROMEN_HOUSE1_LOOM1_ID,  10,    8,  18, 21, EVENT_TYPE_SUBMAP_MOVE, CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE, OBJECT_START_MAPID_ROMEN_VIRRAGE, OBJECT_END_MAPID_ROMEN_VIRRAGE,    "ロメン部屋１"},
    {ROMEN_HOUSE2_LOOM1_ID,  10,    8,  18, 21, EVENT_TYPE_SUBMAP_MOVE, CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE, OBJECT_START_MAPID_ROMEN_VIRRAGE, OBJECT_END_MAPID_ROMEN_VIRRAGE,    "ロメン部屋２"},
    {ROMEN_DANGEON_ID,       10,    8,  18, 21, EVENT_TYPE_SUBMAP_MOVE, CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE, OBJECT_START_MAPID_ROMEN_VIRRAGE, OBJECT_END_MAPID_ROMEN_VIRRAGE,    "ロメンの森林"},
    {BEGINNING_HILL_ID,      10,    8,  18, 21, EVENT_TYPE_SUBMAP_MOVE, CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE, OBJECT_START_MAPID_ROMEN_VIRRAGE, OBJECT_END_MAPID_ROMEN_VIRRAGE,    "はじまりの丘"},
};


/**
 * @brief  ファイルデータを利用する町やダンジョンのアクセスIDを管理
 * @note   
 * @retval None
 */
typedef struct build_file
{
    uint32_t map_name;
    uint32_t map_file;
    uint32_t obj_file;
    uint32_t region_file;
    uint32_t npc_file;
    uint32_t mapchip_file;
    uint32_t sound_file;
} BuildFile;

static const BuildFile build_file[] = {
    {GEKAI_MAP_ID,              FILE_ACCESS_MAPDATA_GEKAI,         FILE_ACCESS_MAPDATA_GEKAI_OBJECT,         FILE_ACCESS_MAPDATA_GEKAI_REGION,         FILE_ACCESS_MAPDATA_GEKAI_NPC,         FILE_ACCESS_CHIP_GEKAI,         SOUND_ID_FIELD_GEKAI},
    {TIKAI_MAP_ID,              FILE_ACCESS_MAPDATA_GEKAI,         FILE_ACCESS_MAPDATA_GEKAI_OBJECT,         FILE_ACCESS_MAPDATA_GEKAI_REGION,         FILE_ACCESS_MAPDATA_GEKAI_NPC,         FILE_ACCESS_CHIP_GEKAI,         SOUND_ID_FIELD_GEKAI},
    {TENKAI_MAP_ID,             FILE_ACCESS_MAPDATA_GEKAI,         FILE_ACCESS_MAPDATA_GEKAI_OBJECT,         FILE_ACCESS_MAPDATA_GEKAI_REGION,         FILE_ACCESS_MAPDATA_GEKAI_NPC,         FILE_ACCESS_CHIP_GEKAI,         SOUND_ID_FIELD_GEKAI},
    {HAZAMA_MAP_ID,             FILE_ACCESS_MAPDATA_GEKAI,         FILE_ACCESS_MAPDATA_GEKAI_OBJECT,         FILE_ACCESS_MAPDATA_GEKAI_REGION,         FILE_ACCESS_MAPDATA_GEKAI_NPC,         FILE_ACCESS_CHIP_GEKAI,         SOUND_ID_FIELD_GEKAI},
    {MAKAI_MAP_ID,              FILE_ACCESS_MAPDATA_GEKAI,         FILE_ACCESS_MAPDATA_GEKAI_OBJECT,         FILE_ACCESS_MAPDATA_GEKAI_REGION,         FILE_ACCESS_MAPDATA_GEKAI_NPC,         FILE_ACCESS_CHIP_GEKAI,         SOUND_ID_FIELD_GEKAI},
    {ROMEN_VIRRAGE_ID,          FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, FILE_ACCESS_CHIP_ROMEN_VIRRAGE, SOUND_ID_MURA_1     },
    {ROMEN_HOUSE1_LOOM1_ID,     FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, FILE_ACCESS_CHIP_ROMEN_VIRRAGE, SOUND_ID_MURA_1     },
    {ROMEN_HOUSE2_LOOM1_ID,     FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, FILE_ACCESS_CHIP_ROMEN_VIRRAGE, SOUND_ID_MURA_1     },
    {ROMEN_DANGEON_ID,          FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, FILE_ACCESS_CHIP_ROMEN_VIRRAGE, SOUND_ID_MURA_1     },
    {BEGINNING_HILL_ID,         FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION, FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC, FILE_ACCESS_CHIP_ROMEN_VIRRAGE, SOUND_ID_MURA_1     },
};


/**
 * @brief  ビルドの基本情報を書き出し
 * @note   
 * @retval None
 */
void build_config_write(FILE *fp, FILE *byte)
{
	const BuildConfig *p = build_config;

	for (uint32_t i = 0; i < BUILD_CONFIG_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->map_name);
		fprintf(fp, "0x%08x,\n", p->debug_start_unitx);
		fprintf(fp, "0x%08x,\n", p->debug_start_unity);
		fprintf(fp, "0x%08x,\n", p->debug_start_filedx);
		fprintf(fp, "0x%08x,\n", p->debug_start_filedy);
		fprintf(fp, "0x%08x,\n", p->debug_event_type);
		fprintf(fp, "0x%08x,\n", p->canpass_id);
		fprintf(fp, "0x%08x,\n", p->obj_start_id);
		fprintf(fp, "0x%08x,\n", p->obj_end_id);

        for (uint32_t j = 0; j < BUILD_SUB_MEMBER_CONFIG_NUMBER - 1; j++)
        {
            fprintf(byte, "0x%08x,\n", 1);
        }

		fprintf(byte, "0x%08x,\n", sjis_write(fp, p->name));
	}

    error_print(BUILD_CONFIG_DB_SIZE, MAP_NAME_ID_END, "DEBUG CONFIG TOTAL NUMBER");
}


/**
 * @brief  ファイルを利用するビルド情報を書き出し
 * @note   
 * @retval None
 */
void build_file_write(FILE *fp, FILE *byte)
{
	const BuildFile *p = build_file;

	for (uint32_t i = 0; i < BUILD_CONFIG_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->map_name);
		fprintf(fp, "0x%08x,\n", p->map_file);
		fprintf(fp, "0x%08x,\n", p->obj_file);
		fprintf(fp, "0x%08x,\n", p->region_file);
		fprintf(fp, "0x%08x,\n", p->npc_file);
		fprintf(fp, "0x%08x,\n", p->mapchip_file);
		fprintf(fp, "0x%08x,\n", p->sound_file);

        for (uint32_t j = 0; j < BUILD_SUB_MEMBER_FILE_NUMBER; j++)
        {
            fprintf(byte, "0x%08x,\n", 1);
        }
	}

    error_print(BUILD_FILE_DB_SIZE, MAP_NAME_ID_END, "DEBUG FILE TOTAL NUMBER");
}


#endif