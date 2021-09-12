/*
 * 端末操作ファイル
 */

#include "../include/MYLIB.H"


/*
 * デバッグ用に情報を端末に出力
 */
void terminal_info(MapchipWork *chip)
{
	uint32_t xpos   = get_posinfo(UNIT_XPOS);
	uint32_t ypos   = get_posinfo(UNIT_YPOS);
	uint32_t xfield = get_posinfo(FIELD_XPOS);
	uint32_t yfield = get_posinfo(FIELD_YPOS);

	CLEAR_SCREEN();
	SET_TYPE(NORMAL);
	SET_PLACE(0, 0);
	printf("現在のフィールドの広さ 横:%3d 縦:%3d\n", chip->xsize, chip->ysize);
	printf("プレイヤーの座標　　　= (x:%3d y:%3d)\n", xpos, ypos);
	printf("フィールドの座標　　　= (x:%3d y:%3d)\n", xfield, yfield);
	printf("合計の座標　　　　　　= (x:%3d y:%3d)\n", xfield + xpos, yfield + ypos);

	if (chip->map_mode == MAP_CONFIG)
	{
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
	else
	{
		printf("リージョン番号　　　　= %3d\n", chip->region.id);
		printf("マスのリージョン番号　= %3d\n", chip->fbuf_reg[(xpos + ypos * chip->ysize) + (xfield + yfield * chip->ysize)]);
		printf("リージョンの桁数　　　= %3d\n", chip->region.digit);
		printf("矩形選択範囲　　　　　= (x:%3d y:%3d)\n", chip->dirx_loop, chip->diry_loop);
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

	printf("◎　マップ作成変更\n");
	printf("lキー\n\n");
	printf("◎　キャラクター移動\n");
	printf("矢印上下左右\n\n");
	printf("◎　保存、読み込み\n");
	printf("write:p, read:o 二回押す\n\n");

	printf("◎　一つ前に戻す\n");
	printf("z\n\n");

	printf("◎　プログラム終了\n");
	printf("m\n\n");

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
