/*
 * 端末操作ファイル
 */

#include "../include/MYLIB.H"

typedef struct pos_conf
{
	int32_t xpos;
	int32_t ypos;
	int32_t xfield;
	int32_t yfield;
} PosConf;


/* ヘルプ画面作成関数 */
static void map_help(MapchipWork *chip);
static void region_help(MapchipWork *chip, PosConf *pos);
static void npc_help(MapchipWork *chip, PosConf *pos);


/*
 * デバッグ用に情報を端末に出力
 */
void terminal_info(MapchipWork *chip)
{
	PosConf pos;
	pos.xpos = get_posinfo(UNIT_XPOS);
	pos.ypos = get_posinfo(UNIT_YPOS);
	pos.xfield = get_posinfo(FIELD_XPOS);
	pos.yfield = get_posinfo(FIELD_YPOS);

	CLEAR_SCREEN();
	SET_TYPE(NORMAL);
	SET_PLACE(0, 0);
	printf("現在のフィールドの広さ 横:%3d 縦:%3d\n", chip->xsize, chip->ysize);
	printf("プレイヤーの座標　　　= (x:%3d y:%3d)\n", pos.xpos, pos.ypos);
	printf("フィールドの座標　　　= (x:%3d y:%3d)\n", pos.xfield, pos.yfield);
	printf("合計の座標　　　　　　= (x:%3d y:%3d)\n", pos.xfield + pos.xpos, pos.yfield + pos.ypos);

	switch (chip->map_mode)
	{
	case MAP_CONFIG:
		map_help(chip);
		break;

	case REGION_CONFIG:
		region_help(chip, &pos);
		break;

	case NPC_CONFIG:
		npc_help(chip, &pos);
		break;

	default:
		break;
	}

	printf("◎　マップ/リージョンマップ/NPCマップ入れ替え\n");
	printf("lキー\n\n");
	printf("◎　キャラクター移動\n");
	printf("矢印上下左右\n\n");
	printf("◎　保存、読み込み\n");
	printf("write:p, read:o 二回押す\n\n");

	printf("◎　一つ前に戻す\n");
	printf("z\n\n");

	printf("◎　プログラム終了\n");
	printf("m 連打\n\n");

	if (chip->map_mode == MAP_CONFIG)
	{
		if ((chip->obj_start <= chip->mapchip_id) && (chip->mapchip_id <= chip->obj_end)) {
			printf("オブジェクトに配置します = %d, キー x\n", chip->mapchip_id);
		}else{
			printf("背景に配置します = %d, キー q\n", chip->mapchip_id);
		}
	}
}


/*
 * 文字列情報出力
 */
void terminal_str(char *s, char *path)
{
	CLEAR_SCREEN();
	SET_PLACE(0, 0);
	SET_TYPE(NORMAL);
	printf("%s	= %s\n", s, path);
}


/**
 * @brief  マップ作成時のヘルプ画面出力
 * @note   
 * @retval None
 */
static void map_help(MapchipWork *chip)
{
	printf("矩形選択範囲　　　　　= (x:%3d y:%3d)\n", chip->dirx_loop, chip->diry_loop);
	printf("\n\n");
	printf("マップチップ座標　　　= (x:%3d y:%3d)\n", chip->chip_xpos, chip->chip_ypos);
	printf("選択中のマップチップ　= %3d\n", chip->mapchip_id);
	printf("◎　マップチップカーソル　上下左右移動\n");
	printf("wasd\n\n");
	printf("◎　マップチップを背景に配置\n");
	printf("矩形範囲配置:q, 連続配置:e\n\n");
	printf("◎　マップチップをオブジェクトに配置\n");
	printf("矩形範囲配置:x \n\n");
	printf("◎　マップチップ矩形選択数変更\n");
	printf("数字キーの1~4 横幅, 5~8 縦幅\n\n");
	printf("◎　マップチップショートカット登録\n");
	printf("f, g, h\n\n");
	printf("◎　登録マップチップ配置\n");
	printf("r, t, y\n\n");
	printf("◎　選択中のマップチップで全て塗りつぶし\n");
	printf("v\n\n");
	printf("◎　選択中のマップチップでオブジェクト全て塗りつぶし\n");
	printf("c\n\n");
}


/**
 * @brief  リージョンマップ作成時のヘルプ画面出力
 * @note   
 * @retval None
 */
static void region_help(MapchipWork *chip, PosConf *pos)
{
	printf("リージョン番号　　　　 = %3d\n", chip->region.id[0]);
	printf("マスのリージョン番号　 = %3d\n", chip->fbuf_reg[(pos->xpos + (pos->ypos * chip->xsize)) + (pos->xfield + (pos->yfield * chip->xsize))]);
	printf("リージョンの桁数　　　 = %3d\n", chip->region.digit[0]);
	printf("矩形選択範囲　　　　　 = (x:%3d y:%3d)\n", chip->dirx_loop, chip->diry_loop);
	printf("\n\n");
	printf("◎　リージョンID配置\n");
	printf("q\n\n");
	printf("◎　矩形選択数変更\n");
	printf("r,t,y,u,i, 1~5 横幅\nf,g,h,j,k, 5~8 縦幅\n\n");
	printf("◎　リージョンの桁数変更\n");
	printf("a[1], s[2], d[3]\n\n");
	printf("◎　リージョンID設定\n");
	printf("0 ~ 9キー\n\n");
}


/**
 * @brief  NPCマップ作成時のヘルプ画面
 * @note   
 * @param  *chip: 
 * @retval None
 */
static void npc_help(MapchipWork *chip, PosConf *pos)
{
	printf("NPC番号　　　　　　　 = %3d\n", chip->region.id[1]);
	printf("マスのNPC番号　　　　 = %3d\n", chip->fbuf_npc[(pos->xpos + (pos->ypos * chip->xsize)) + (pos->xfield + (pos->yfield * chip->xsize))]);
	printf("IDの桁数　　　　　　  = %3d\n", chip->region.digit[1]);
	printf("矩形選択範囲　　　　  = (x:%3d y:%3d)\n", chip->dirx_loop, chip->diry_loop);
	printf("\n\n");
	printf("◎　NPCID配置\n");
	printf("q\n\n");
	printf("◎　矩形選択数変更\n");
	printf("r,t,y,u,i, 1~5 横幅\nf,g,h,j,k, 5~8 縦幅\n\n");
	printf("◎　NPCの桁数変更\n");
	printf("a[1], s[2], d[3]\n\n");
	printf("◎　NPCID設定\n");
	printf("0 ~ 9キー\n\n");
}