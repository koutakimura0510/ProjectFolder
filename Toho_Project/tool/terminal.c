/**-------------------------------------------------
 * 端末操作ファイル
 * -------------------------------------------------*/

#include <stdio.h>
#include <stdint.h>
#include "./TERMINAL.H"

/**-------------------------------------------------
 * デバッグ用プレイヤー座標出力
 * -------------------------------------------------*/
void terminal_info(
	int32_t xpos,
	int32_t ypos,
	int32_t fieldx,
	int32_t fieldy,
	int32_t mapwidth,
	int32_t mapheight,
	uint32_t mapid
)
{
	CLEAR_SCREEN();
	SET_TYPE(NORMAL);
	SET_PLACE(0, 0);
	printf("プレイヤーのX,Y座標	= (x:%3d y:%3d)\n", xpos, ypos);
	printf("フィールドのX,Y座標	= (x:%3d y:%3d)\n", fieldx, fieldy);
	printf("      合計のX,Y座標	= (x:%3d y:%3d)\n", fieldx+xpos, fieldy+ypos);
	printf("現在のフィールドの広さ 横:%3d 縦:%3d\n", mapwidth, mapheight);
	printf("選択中のマップチップID	= %3d\n", mapid);
	/*fprintf(stderr, "プレイヤーのX,Y座標	= (x:%3d y:%3d)\n", xpos, ypos);
	fprintf(stderr, "フィールドのX,Y座標	= (x:%3d y:%3d)\n", fieldx, fieldy);
	fprintf(stderr, "現在のフィールドの広さ 横:%3d 縦:%3d\n", mapwidth, mapheight);
	fprintf(stderr, "選択中のマップチップID	= %3d\n", mapid);*/
}


/**-------------------------------------------------
 * 文字列情報出力
 * -------------------------------------------------*/
void terminal_str(char *s, char *path)
{
	SET_TYPE(NORMAL);
	SET_PLACE(0, 6);
	printf("%s	= %s\n", s, path);
}
