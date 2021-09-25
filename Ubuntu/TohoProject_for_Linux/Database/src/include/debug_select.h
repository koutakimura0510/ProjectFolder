/*
 * Create 2021/08/31
 * Author kimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * NPCのデータについて管理するヘッダーファイル
 */
#ifndef debug_select_h_
#define debug_select_h_


/* データベースの要素数 */
#define DEBUG_CONFIG_DB_SIZE ((sizeof (debug_config)) / (sizeof (DebugConfig)))


/**
 * @brief  起動時のデバッグ開始先を選択するため、選択先の描画に必要な情報を管理するデータベース
 * @note   
 * 
 * @param  map_name direct_macro.hに記載してある名前の定数、nameとIDが連番になっている
 * @param  start_unitx 開始時のキャラのx座標
 * @param  start_unity 開始時のキャラのy座標
 * @param  start_filedx 開始時のフィールドのx座標
 * @param  start_filedy 開始時のフィールドのy座標
 * @param  canpass_id 通行可能なマップチップIDの最大値
 * @param  obj_start_id オブジェクト描画に利用するマップチップIDの開始ID
 * @param  obj_endid オブジェクト描画に利用するマップチップIDの終了ID
 * @param  *name 画面に描画する、町やダンジョンの名前
 * 
 * @retval None
 */
typedef struct debug_config
{
    uint32_t map_name;
    uint32_t start_unitx;
    uint32_t start_unity;
    uint32_t start_filedx;
    uint32_t start_filedy;
    uint32_t canpass_id;
    uint32_t obj_start_id;
    uint32_t obj_end_id;
    const char *name;
} DebugConfig;

static const DebugConfig debug_config[] = {
    {GEKAI_MAP_ID,           320, 224, 160, 39, CAN_PASS_MAPCHIP_ID_MAX_GEKAI,         OBJECT_START_MAPID_GEKAI,         OBJECT_END_MAPID_GEKAI,            "下界"},
    {TIKAI_MAP_ID,           320, 224, 160, 39, CAN_PASS_MAPCHIP_ID_MAX_GEKAI,         OBJECT_START_MAPID_GEKAI,         OBJECT_END_MAPID_GEKAI,            "地界"},
    {TENKAI_MAP_ID,          320, 224, 160, 39, CAN_PASS_MAPCHIP_ID_MAX_GEKAI,         OBJECT_START_MAPID_GEKAI,         OBJECT_END_MAPID_GEKAI,            "天界"},
    {HAZAMA_MAP_ID,          320, 224, 160, 39, CAN_PASS_MAPCHIP_ID_MAX_GEKAI,         OBJECT_START_MAPID_GEKAI,         OBJECT_END_MAPID_GEKAI,            "狭間"},
    {MAKAI_MAP_ID,           320, 224, 160, 39, CAN_PASS_MAPCHIP_ID_MAX_GEKAI,         OBJECT_START_MAPID_GEKAI,         OBJECT_END_MAPID_GEKAI,            "魔界"},
    {ROMEN_VIRRAGE_ID,       16,  14,  15,  16, CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE, OBJECT_START_MAPID_ROMEN_VIRRAGE, OBJECT_END_MAPID_ROMEN_VIRRAGE,    "ロメンの村"},
    {ROMEN_HOUSE1_LOOM1_ID,  16,  14,  15,  16, CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE, OBJECT_START_MAPID_ROMEN_VIRRAGE, OBJECT_END_MAPID_ROMEN_VIRRAGE,    "ロメン部屋１"},
    {ROMEN_HOUSE2_LOOM1_ID,  16,  14,  15,  16, CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE, OBJECT_START_MAPID_ROMEN_VIRRAGE, OBJECT_END_MAPID_ROMEN_VIRRAGE,    "ロメン部屋２"},
    {ROMEN_DANGEON_ID,       16,  14,  15,  16, CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE, OBJECT_START_MAPID_ROMEN_VIRRAGE, OBJECT_END_MAPID_ROMEN_VIRRAGE,    "ロメンの森林"},
    {BEGINNING_HILL_ID,      16,  14,  15,  16, CAN_PASS_MAPCHIP_ID_MAX_ROMEN_VIRRAGE, OBJECT_START_MAPID_ROMEN_VIRRAGE, OBJECT_END_MAPID_ROMEN_VIRRAGE,    "はじまりの丘"},
};


/**
 * @brief  デバッグ用処理データ書き出し
 * @note   
 * @retval None
 */
void debug_select_write(FILE *fp, FILE *byte)
{
	const DebugConfig *p = debug_config;

	for (uint32_t i = 0; i < DEBUG_CONFIG_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->map_name);
		fprintf(fp, "0x%08x,\n", p->start_unitx);
		fprintf(fp, "0x%08x,\n", p->start_unity);
		fprintf(fp, "0x%08x,\n", p->start_filedx);
		fprintf(fp, "0x%08x,\n", p->start_filedy);
		fprintf(fp, "0x%08x,\n", p->canpass_id);
		fprintf(fp, "0x%08x,\n", p->obj_start_id);
		fprintf(fp, "0x%08x,\n", p->obj_end_id);

        for (uint32_t j = 0; j < DEBUG_SUB_MEMBER_NUMBER - 1; j++)
        {
            fprintf(byte, "0x%08x,\n", 1);
        }

		fprintf(byte, "0x%08x,\n", sjis_write(fp, p->name));
	}

    error_print(DEBUG_CONFIG_DB_SIZE, MAP_NAME_ID_END, "debug");
	printf("DEBUG SELECT TOTAL NUMBER= %ld\n", DEBUG_CONFIG_DB_SIZE);
}


#endif