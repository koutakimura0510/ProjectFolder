/**-------------------------------------------------
 * パラメータ管理ファイル
 * -------------------------------------------------*/

#ifndef DISPLAY_H_
#define DISPLAY_H_


/**
 * @brief  マップ作成時のモードID
 * @note   
 * @retval None
 */
typedef enum
{
	MAP_CONFIG,
	REGION_CONFIG,
	NPC_CONFIG,
} MapConfigData;


/*
 * ワールドマップのフレームバッファのサイズ
 */
#define GEKAI_WORLD_WIDTH  (200)
#define GEKAI_WORLD_HEIGHT (200)

/*
 * 建物内のフレームバッファサイズ
 */
#define ROMEN_VIRRAGE_WIDTH  (50)
#define ROMEN_VIRRAGE_HEIGHT (50)



/**-------------------------------------------------
 * プレイ画面の大きさを指定
 * -------------------------------------------------
 * SCREEN_WIDTH	  :	windowの幅
 * SCREEN_HEIGHTY :	windowの高さを指定
 * -------------------------------------------------*/
#define SCREEN_WIDTH	(992)
#define SCREEN_HEIGHT	(992)


/**-------------------------------------------------
 * マップチップの最大サイズ
 * -------------------------------------------------*/
#define CHIP_SCREEN_WIDTH  (512)
#define CHIP_SCREEN_HEIGHT (512)


/**-------------------------------------------------
 * 縦横1マスに使用する描画pixel数を指定
 * -------------------------------------------------*/
#define GRID_SIZE		(32)
#define MAP_SIZE_SHIFT	(5)	//5bitシフトすれば32
#define MAPCHIP_SHIFT	(5)	//5bitシフトすれば32


/**-------------------------------------------------
 * マップチップ描画を含めた画面サイズ
 * -------------------------------------------------*/
#define TOTAL_SCREEN_WIDTH  (SCREEN_WIDTH+CHIP_SCREEN_WIDTH)
#define TOTAL_SCREEN_HEIGHT (SCREEN_HEIGHT)


/**-------------------------------------------------
 * プレイ画面に対して、1マスを幾つ配置可能か計算
 * -------------------------------------------------
 * MAP_DRAW_WIDTH :	幅のループ回数、マップの基本幅
 * MAP_DRAW_HEIGH :	高さのループ回数、マップの基本高さ
 * -------------------------------------------------*/
#define MAP_DRAW_WIDTH	(SCREEN_WIDTH  / GRID_SIZE)
#define MAP_DRAW_HEIGHT	(SCREEN_HEIGHT / GRID_SIZE)



/**-------------------------------------------------
 * マップチップの1マス分の大きさを指定
 * -------------------------------------------------*/
#define MAPCHIP_SIZE	32
#define MAPCHIP_CUT_POS (992)


/**-------------------------------------------------
 * プレイヤー情報
 * -------------------------------------------------
 * UNIT_WIDTH :	使用素材の1マス分の幅を指定
 * UNIT_HEIGHT:	使用素材の1マス分の高さを指定
 * -------------------------------------------------*/
#define UNIT_WIDTH		24
#define UNIT_HEIGHT		32


/* 
 * NPCの情報
 */
#define NPC_WIDTH		32
#define NPC_HEIGHT		32


#endif
