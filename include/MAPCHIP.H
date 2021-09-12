#ifndef MAPCHIP_H_
#define MAPCHIP_H_


/*
 * オブジェクトの開始と終了番号
 */
#define ROMEN_OBJECT_MIN_ID (58)
#define ROMEN_OBJECT_MAX_ID (95)


/*
 * マップチップカーソル移動
 */
typedef enum
{
	CHIP_RIGHT,
	CHIP_LEFT,
	CHIP_UP,
	CHIP_DOWN
} ChipCursol;


/*
 * ショートカット登録、選択中のマップチップを選択
 */
typedef enum
{
	CHIP_SHORTCUT,
	CHIP_SELECT,
} SelectChip;


/*
 * 矩形選択の配置方法を選択
 *
 * FILL_SQUARE
 * 矩形選択で指定範囲のマップチップを配置
 * 
 * FILL_LOT
 * 矩形選択で指定範囲に同じマップチップを配置
 */
#define FILL_SQUARE		(0xffffffff)
#define FILL_LOT		(0x00000000)


/*
 * 構造体要素数計算
 */
#define BUILD_SIZE		((sizeof (buildinfo)) / (sizeof (t_buildinfo)))


/**
 * @brief  リージョンマップ作成に必要なデータを管理
 * @note   
 * @retval None
 */
typedef struct region
{
	uint32_t id;    	/* リージョンIDを保存 */
	uint32_t posid;		/* 現在いるマスのリージョンIDを保存 */
	uint32_t digit; 	/* リージョンIDの桁数を保存 */
	uint8_t key_count; 	/* リージョンIDの桁数を保存 */
} RegionConfig;

/*
 * マップ作成時の作業領域
 */
typedef struct
{
	uint32_t xsize;				/* 現在のフィールドのxの広さ */
	uint32_t ysize;				/* 現在のフィールドのyの広さ */
	char *mapfile;				/* 使用する画像データのパスを保存 */
	char *bin_map;				/* binマップデータのファイル名を保存 */
	char *bin_obj;				/* binオブジェクトデータのファイル名を保存 */
	char *bin_reg;				/* binリージョンデータのファイル名を保存 */
	char *raw_map;				/* rawマップデータのファイル名を保存 */
	char *raw_obj;				/* rawオブジェクトデータのファイル名を保存 */
	char *raw_reg;				/* rawリージョンデータのファイル名を保存 */
	uint32_t *fbuf_map;			/* マップ用フレームバッファのアドレス */
	uint32_t *fbuf_obj;			/* オブジェクト用フレームバッファのアドレス */
	uint32_t *fbuf_reg;			/* リージョンマップ用フレームバッファアドレス */
	uint32_t *fbuf_map_backup;	/* マップ用バックアップ用フレームバッファのアドレス */
	uint32_t *fbuf_obj_backup;	/* オブジェクト用バックアップ用フレームバッファのアドレス */
	uint32_t *fbuf_reg_backup;	/* リージョン用バックアップ用フレームバッファのアドレス */
	uint32_t mapchip_id;
	uint32_t dirx_loop;			/* 矩形選択のxサイズ */
	uint32_t diry_loop;			/* 矩形選択のyサイズ */
	uint32_t chip_xpos;			/* マップチップ選択中のxIndex */
	uint32_t chip_ypos;			/* マップチップ選択中のyIndex */
	uint32_t chip_xsize;		/* マップチップのxサイズ */
	uint32_t chip_ysize;		/* マップチップのyサイズ */
	uint32_t cutpos;			/* カット座標 */
	uint32_t obj_start;
	uint32_t obj_end;
	uint32_t shortcut_key[3];
	uint8_t  map_mode; 			/* 現在のマップ作成のモードを管理 */
	uint8_t  isEnd;
	RegionConfig region;
} MapchipWork;

#endif
