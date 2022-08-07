#ifndef MAPCHIP_DB_H_
#define MAPCHIP_DB_H_

/*
 * フレームバッファの確保
 */
static uint32_t frame_buffer_world_1_map[GEKAI_WORLD_WIDTH * GEKAI_WORLD_HEIGHT];		/* 下界のバッファサイズ */
static uint32_t frame_buffer_build_1_map[ROMEN_VIRRAGE_WIDTH * ROMEN_VIRRAGE_HEIGHT];	/* 村のバッファサイズ 1 */


/*
 * オブジェクトマップデータの確保
 */
static uint32_t frame_buffer_world_1_object[GEKAI_WORLD_WIDTH * GEKAI_WORLD_HEIGHT];
static uint32_t frame_buffer_build_1_object[ROMEN_VIRRAGE_WIDTH * ROMEN_VIRRAGE_HEIGHT];


/*
 * リージョンマップ用フレームバッファ
 */
static uint32_t frame_buffer_world_1_region[GEKAI_WORLD_WIDTH * GEKAI_WORLD_HEIGHT];
static uint32_t frame_buffer_build_1_region[ROMEN_VIRRAGE_WIDTH * ROMEN_VIRRAGE_HEIGHT];


/*
 * NPC配置用フレームバッファ
 */
static uint32_t frame_buffer_world_1_npc[GEKAI_WORLD_WIDTH * GEKAI_WORLD_HEIGHT];
static uint32_t frame_buffer_build_1_npc[ROMEN_VIRRAGE_WIDTH * ROMEN_VIRRAGE_HEIGHT];


/*
 * 前回の状態に戻す用フレームバッファ
 */
static uint32_t frame_buffer_world_1_mapbackup[GEKAI_WORLD_WIDTH * GEKAI_WORLD_HEIGHT];
static uint32_t frame_buffer_world_1_objbackup[GEKAI_WORLD_WIDTH * GEKAI_WORLD_HEIGHT];
static uint32_t frame_buffer_world_1_regbackup[GEKAI_WORLD_WIDTH * GEKAI_WORLD_HEIGHT];
static uint32_t frame_buffer_build_1_mapbackup[ROMEN_VIRRAGE_WIDTH * ROMEN_VIRRAGE_HEIGHT];
static uint32_t frame_buffer_build_1_objbackup[ROMEN_VIRRAGE_WIDTH * ROMEN_VIRRAGE_HEIGHT];
static uint32_t frame_buffer_build_1_regbackup[ROMEN_VIRRAGE_WIDTH * ROMEN_VIRRAGE_HEIGHT];



/*
 * フィールドマップのデータ構造確保
 */
typedef struct {

	/* マップのサイズ */
	uint32_t xsize;
	uint32_t ysize;

	/* 使用するマップチップ画像データのサイズ */
	uint32_t chip_xsize;
	uint32_t chip_ysize;

	/* 
	 *選択カーソルの一番下まで移動した場合の画像データの端数 
	 *
	 * 2496 - 992 - 992 = 512 (992)で割り切れない数の残り)
	 * 512　/ 32 = 16
	 * 2496 / 32 = 78
	 * 78 - 16 = 62
	 */
	uint32_t cutpos;

	/* オブジェクトマップチップデータのかいしと終了番号 */
	uint32_t obj_start;
	uint32_t obj_end;

	/* 作成するマップデータに使用する画像データのパスを指定 */
	char *mapfile;		/* 使用するマップデータ */
	char *bin_map;		/* マップファイルのread */
	char *bin_obj;		/* オブジェクトのread */
	char *bin_reg;		/* オブジェクトのread */
	char *bin_npc;		/* NPCデータのread */

	/* rawファイル */
	char *raw_map;		/* マップのrawファイルの出力アドレス */
	char *raw_obj;		/* オブジェクトのrawファイルの出力アドレス */
	char *raw_reg;		/* リージョンマップのrawファイルの出力アドレス */
	char *raw_npc;		/* npcのrawファイルの出力アドレス */

	/* フレームバッファのアドレス */
	uint32_t *fbuf_map;
	uint32_t *fbuf_obj;
	uint32_t *fbuf_reg;
	uint32_t *fbuf_npc;
	uint32_t *fbuf_map_backup;
	uint32_t *fbuf_obj_backup;
	uint32_t *fbuf_reg_backup;
} t_buildinfo;


static const t_buildinfo buildinfo[] = {
	{	
		GEKAI_WORLD_WIDTH, 	GEKAI_WORLD_HEIGHT, 512, 1184, 31, 0, 0,
		"res/chip_gekai.png",
		"bin/map_gekai.bin",
		"bin/obj_gekai.bin",
		"bin/region_gekai.bin",
		"bin/npc_gekai.bin",
		"raw/map_gekai.raw",
		"raw/obj_gekai.raw",
		"raw/region_gekai.raw",
		"raw/npc_gekai.raw",
		frame_buffer_world_1_map,
		frame_buffer_world_1_object,
		frame_buffer_world_1_region,
		frame_buffer_world_1_npc,
		frame_buffer_world_1_mapbackup,
		frame_buffer_world_1_objbackup,
		frame_buffer_world_1_regbackup
	},

	{	
		ROMEN_VIRRAGE_WIDTH, ROMEN_VIRRAGE_HEIGHT, 512, 448 , 0, ROMEN_OBJECT_MIN_ID, ROMEN_OBJECT_MAX_ID,
		"res/chip_romen_virrage.png",
		"bin/map_romen_virrage.bin",
		"bin/obj_romen_virrage.bin",
		"bin/region_romen_virrage.bin",
		"bin/npc_romen_virrage.bin",
		"raw/map_romen_virrage.raw",
		"raw/obj_romen_virrage.raw",
		"raw/region_romen_virrage.raw",
		"raw/npc_romen_virrage.raw",
		frame_buffer_build_1_map,
		frame_buffer_build_1_object,
		frame_buffer_build_1_region,
		frame_buffer_build_1_npc,
		frame_buffer_build_1_mapbackup,
		frame_buffer_build_1_objbackup,
		frame_buffer_build_1_regbackup
	},
};


#endif
