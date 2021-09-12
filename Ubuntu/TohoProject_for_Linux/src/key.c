/**-------------------------------------------------
 * key操作と座標データをまとめたファイル
 * -------------------------------------------------
 * 座標計算のアニメーションについて
 *
 * --アニメーション可能--
 * ウィンドウの大きさよりもマップサイズが大きい場合、画面のアニメーションを行う
 * プレイヤーの座標がウィンドウの中央に来た場合に、フレームバッファの列と行を参照する
 * field_xpos・field_ypos変数の加算、減算を行う
 * fieldpos + プレイヤーの座標がマップサイズの表示位置に達したらアニメーションを終了する
 *
 * --アニメーション不可--
 * ウィンドウのサイズよりもマップサイズが小さい場合、プレイヤーの移動のみ行う
 * -------------------------------------------------*/


/**-------------------------------------------------
 * include file
 * -------------------------------------------------*/
#include <stdint.h>
#include "./PARA.H"
#include "./KEY.H"


/**-------------------------------------------------
 * 座標と向きを保存
 * -------------------------------------------------
 * arg1: ユニットのx座標
 * arg2: ユニットのy座標
 * arg3: フィールドのx座標、アニメーションを行う場合のみ値を操作する
 * arg4: フィールドのy座標、アニメーションを行う場合のみ値を操作する
 * arg5: ユニットの現在向いている方向を保存
 * arg6: ユニットの描画ファイルの切り取りを行うy座標を保存
 * -------------------------------------------------*/
typedef struct {
	int32_t unit_xpos;
	int32_t unit_ypos;
	int32_t field_xpos;
	int32_t field_ypos;
	uint8_t unit_direction;
	uint32_t res_ypos;
} t_posinfo;


/**-------------------------------------------------
 * 構造体の確保
 * -------------------------------------------------*/
static t_posinfo posinfo = {0, 0, 0, 0, 0, 0};



/**-------------------------------------------------
 * 関数定義
 * -------------------------------------------------*/

/**-------------------------------------------------
 * マップ切り替え時の座標データの指定
 * -------------------------------------------------*/
void pos_update(void)
{
	t_posinfo *p = &posinfo;

	p->unit_xpos  = 0;
	p->unit_ypos  = 0;
	p->field_xpos = 0;
	p->field_ypos = 0;
	p->unit_direction = DOWN;
	p->res_ypos = 0;
}



/**-------------------------------------------
 * x軸右移動の座標計算
 * -------------------------------------------
 * arg1: 現在のマップの最大横幅を指定
 * -------------------------------------------*/
void xpos_move_right(uint32_t field_maxwidth)
{
	t_posinfo *p = &posinfo;

	p->unit_direction = RIGHT;
	p->res_ypos = UNIT_HEIGHT;

	if ((MAP_DRAW_WIDTH + p->field_xpos) >= field_maxwidth) {
		p->unit_xpos++;
		return;
	}

	if (p->unit_xpos >= (MAP_DRAW_WIDTH >> 1)) {
		p->field_xpos++;
		return;
	}

	p->unit_xpos++;
}


/**-------------------------------------------------
 * x軸左移動の座標計算
 * -------------------------------------------------*/
void xpos_move_left(void)
{
	t_posinfo *p = &posinfo;

	p->unit_direction = LEFT;
	p->res_ypos = UNIT_HEIGHT+UNIT_HEIGHT+UNIT_HEIGHT;

	if (p->unit_xpos > (MAP_DRAW_WIDTH >> 1)) {
		p->unit_xpos--;
		return;
	}

	if (p->field_xpos != 0) {
		p->field_xpos--;
		return;
	}

	p->unit_xpos--;
}


/**-------------------------------------------------
 * y軸上移動の座標計算
 * -------------------------------------------------*/
void ypos_move_up(void)
{
	t_posinfo *p = &posinfo;

	p->unit_direction = UP;
	p->res_ypos = 0;

	if (p->unit_ypos > (MAP_DRAW_HEIGHT >> 1)) {
		p->unit_ypos--;
		return;
	}

	if (p->field_ypos != 0) {
		p->field_ypos--;
		return;
	}

	p->unit_ypos--;
}


/**-------------------------------------------------
 * y軸下移動の座標計算
 * -------------------------------------------------
 * arg1:現在のマップの最大高さを指定
 * -------------------------------------------------*/
void ypos_move_down(uint32_t field_maxheight)
{
	t_posinfo *p = &posinfo;

	p->unit_direction = DOWN;
	p->res_ypos = UNIT_HEIGHT+UNIT_HEIGHT;

	if ((MAP_DRAW_HEIGHT + p->field_ypos) >= field_maxheight) {
		p->unit_ypos++;
		return;
	}

	if (p->unit_ypos > (MAP_DRAW_HEIGHT >> 1)) {
		p->field_ypos++;
		return;
	}

	p->unit_ypos++;
}


/**-------------------------------------------------
 * 当たり判定
 * -------------------------------------------------
 * 現在のマップの最大高さと横幅を指定
 * -------------------------------------------------*/
void direct(uint32_t field_maxwidth, uint32_t field_maxheight)
{
	t_posinfo *p = &posinfo;
	
	switch (p->unit_direction) {
		case RIGHT:
			if (field_maxwidth <= (p->field_xpos + p->unit_xpos)) {
				p->unit_xpos--;
			}
			break;

		case LEFT:
			if (p->unit_xpos < 0) {
				p->unit_xpos++;
			}
			break;

		case DOWN:
			if (field_maxheight <= (p->field_ypos + p->unit_ypos)) {
				p->unit_ypos--;
			}
			break;

		case UP:
			if (p->unit_ypos < 0) {
				p->unit_ypos++;
			}
			break;

		default:
			break;
	}
}

/**-------------------------------------------------
 * 座標データを取得
 * -------------------------------------------------
 * arg1: pos	取得する座標のIDを指定
 * -------------------------------------------------*/
uint32_t get_posinfo(uint8_t pos)
{
	t_posinfo *p = &posinfo;
	
	switch (pos) {
		case UNIT_XPOS:
			return p->unit_xpos;

		case UNIT_YPOS:
			return p->unit_ypos;

		case FIELD_XPOS:
			return p->field_xpos;

		case FIELD_YPOS:
			return p->field_ypos;

		case RES_YPOS:
			return p->res_ypos;

		default:
			return 0;
	}
}
