/**--------------------------------------------
 * Ubuntu LTS 20.04 kimura
 *
 * 描画に関する関数をまとめたファイル
 *
 *--------------------------------------------*/
#include <stddef.h>
#include "../include/LIB.H"
#define DRAWPARA
#include "../include/DRAW.H"


/**-------------------------------------------------
 * 座標と向きを保存
 * -------------------------------------------------*/
typedef struct {
	int32_t character_xpos;	//ユニットのx座標
	int32_t character_ypos;	//ユニットのy座標
	int32_t field_xpos;		//フィールドのx座標、アニメーションを行うか判定
	int32_t field_ypos;		//フィールドのy座標、アニメーションを行うか判定
	uint8_t character_direction;	//ユニットの現在向いている方向
	uint8_t info_direction;	//どの座標を更新したか判定を行う変数
} t_posinfo;


/**-------------------------------------------------
 * 現在のフィールド情報を保存
 * -------------------------------------------------*/
typedef struct {
	int32_t ypos_animation_check;
	int32_t xpos_animation_check;
	int32_t field_maxwidth;		//現在フィールドの最大横幅指定
	int32_t field_maxheight;	//現在フィールドの最大高さ指定
	char **map_id;				//現在フィールドの先頭アドレス指定
} t_fieldinfo;


/**-------------------------------------------------
 * ファイル内構造体の確保
 * -------------------------------------------------*/
static t_posinfo posinfo = {10, 10, 0, 0, 0, 0};
static t_fieldinfo fieldinfo;


/**----------------------------------------
 * static関数
 *-----------------------------------------*/
static uint32_t get_width(char **s, uint32_t height);
static uint32_t get_height(char **s);
static uint32_t get_maxwidth(char **s, uint32_t height);
static void xpos_move_right(t_fieldinfo *info, t_posinfo *p);
static void xpos_move_left(t_posinfo *p);
static void ypos_move_up(t_posinfo *p);
static void ypos_move_down(t_fieldinfo *info, t_posinfo *p);
static void direction(t_posinfo *p);
static bool detect(t_posinfo *p);
static void cast_draw(uint32_t x, uint32_t y, uint8_t color, char *str);
static void xypos_draw(t_posinfo *p);
static void asciidraw(char *s);
static void flame_draw(uint8_t color);
static void flame_input(t_fieldinfo *info, t_posinfo *p);
static void flameclear(uint8_t height, uint8_t width, char s);
static char *get_flamebuffer_address(void);
static char **search_field_map(uint32_t id);


/**-------------------------------------------------
 * x,t軸の座標を計算し当たり判定や横縦のアニメーションを行う関数
 * -------------------------------------------------*/
void animation_move(uint8_t id)
{
	t_fieldinfo *info = &fieldinfo;
	t_posinfo *p = &posinfo;

	switch (id) {
		case RIGHT:
			xpos_move_right(info, p);
			break;

		case LEFT:
			xpos_move_left(p);
			break;

		case DOWN:
			ypos_move_down(info, p);
			break;

		case UP:
			ypos_move_up(p);
			break;

		default:
			break;
	}

	if (false == detect(p)) {
		direction(p);
	}

	clear_screen();
    flameclear(FIELD_HEIGHT, FIELD_WIDTH, ' ');
    flame_input(info, p);
	flame_draw(YELLOW);
	cast_draw(p->character_xpos, p->character_ypos, RED, "巫");
	xypos_draw(p);
}


/**-------------------------------------------------
 * 描画に必要な情報を取得し構造体に保存を行う
 * -------------------------------------------------
 * arg1: map	現在のフィールドIDを指定
 * -------------------------------------------------*/
void map_info_struct_write(uint8_t map)
{
	t_fieldinfo *info = &fieldinfo;
	char **p;
	int32_t height, width, y_animation, x_animation;

	p = search_field_map(map);
    height = get_height(p);		//フィールドの縦幅を取得
	width  = get_maxwidth(p, height);
	y_animation = height - FIELD_HEIGHT;	//フィールド描画の最縦幅大幅取得
    x_animation = width  - FIELD_WIDTH;		//フィールド描画の最大横幅取得
	
    if (y_animation & 0x8000) { //フィールドの縦幅がフレームバッファ以下の場合
        y_animation = 0;       	//縦移動のアニメーションは行わない
    }

    if (x_animation & 0x8000) {	//フィールドの横幅がフレームバッファ以下の場合
        x_animation = 0;		//横移動のアニメーションは行わない
    }

	info->map_id = p;
	info->field_maxheight = height;
	info->field_maxwidth  = width;
	info->ypos_animation_check = y_animation;
	info->xpos_animation_check = x_animation;
}


/**-------------------------------------------------
 * セーブ中アニメーション関数
 * -------------------------------------------------*/
void saveing(void)
{
    SET_TYPE(NORMAL);
    SET_CHAR_COLOR(WHITE);
    SET_CHAR_BOLD();
	SET_PLACE(2, 40);

	for (uint8_t i = 0; i <= 100; i++) {
		fprintf(stderr, "\rデータを保存しています [%3d / 100]", i);
		waittime(MS_10(3));
	}

	waittime(SECOND(1));
	fprintf(stderr, "\r\n");
	fprintf(stderr, "セーブが完了しました\r\n");
}


/**--------------------------------------------
 * 画面消去
 *--------------------------------------------*/
void clear_screen(void)
{
    CLEAR_SCREEN();
}


/**--------------------------------------------
 * フィールドの横幅を取得する
 * --------------------------------------------
 * arg1: **s    fieldの先頭アドレス
 * arg2: height 横幅を取得する行を指定
 *--------------------------------------------*/
static uint32_t get_width(char **s, uint32_t height)
{
    uint32_t count = 0;

    while (s[height][count++] != '\0');

    return count;
}


/**--------------------------------------------
 * フィールドの縦幅を取得する
 * --------------------------------------------
 * arg1: **s    fieldの先頭アドレス
 *--------------------------------------------*/
static uint32_t get_height(char **s)
{
    uint32_t count = 0;

    while (**s++ != '\0') {
        count++;
    }

    return count;
}


/**--------------------------------------------
 * フィールドの最大横幅を取得
 * --------------------------------------------
 * arg1: **s    fieldの先頭アドレス
 *--------------------------------------------*/
static uint32_t get_maxwidth(char **s, uint32_t height)
{
    uint32_t com = 0;
    uint32_t count = 0;

    for (uint8_t i = 0; i < height; i++) {
        while (s[i][count++] != '\0');
        if (com < count) {
            com = count;
        }
        count = 0;
    }
    return com;
}


/**-------------------------------------------
 * x軸右移動の座標計算
 * -------------------------------------------
 * 現在のフィールドの横幅が最大画面幅以下のとき = cpos++
 * 以上の場合、cposが画面幅の中央に移動したとき = fpos++
 * それ以外の場合 = cpos++
 * -------------------------------------------*/
static void xpos_move_right(t_fieldinfo *info, t_posinfo *p)
{
	p->character_direction = RIGHT;

	if ((FIELD_WIDTH + p->field_xpos) >= info->field_maxwidth) {
		p->character_xpos++;
		p->info_direction = C_XPOS;
		return;
	}

	if (p->character_xpos >= (FIELD_WIDTH >> 1)+FIELD_DRAW_XPOS) {
		p->field_xpos++;
		p->info_direction = F_XPOS;
		return;
	}

	p->character_xpos++;
	p->info_direction = C_XPOS;
}


/**-------------------------------------------------
 * x軸左移動の座標計算
 * -------------------------------------------------*/
static void xpos_move_left(t_posinfo *p)
{
	p->character_direction = LEFT;

	if (p->character_xpos > (FIELD_WIDTH >> 1)+FIELD_DRAW_XPOS) {
		p->character_xpos--;
		p->info_direction = C_XPOS;
		return;
	}

	if (p->field_xpos != 0) {
		p->field_xpos--;
		p->info_direction = F_XPOS;
		return;
	}

	p->character_xpos--;
	p->info_direction = C_XPOS;
}


/**-------------------------------------------------
 * y軸上移動の座標計算
 * -------------------------------------------------*/
static void ypos_move_up(t_posinfo *p)
{
	p->character_direction = UP;

	if (p->character_ypos > (FIELD_HEIGHT >> 1)+FIELD_DRAW_YPOS) {
		p->character_ypos--;
		p->info_direction = C_YPOS;
		return;
	}

	if (p->field_ypos != 0) {
		p->field_ypos--;
		p->info_direction = F_YPOS;
		return;
	}

	p->character_ypos--;
	p->info_direction = C_YPOS;
}


/**-------------------------------------------------
 * y軸下移動の座標計算
 * -------------------------------------------------*/
static void ypos_move_down(t_fieldinfo *info, t_posinfo *p)
{
	p->character_direction = DOWN;

	if ((FIELD_HEIGHT + p->field_ypos) >= info->field_maxheight) {
		p->character_ypos++;
		p->info_direction = C_YPOS;
		return;
	}

	if (p->character_ypos > (FIELD_HEIGHT >> 1)+FIELD_DRAW_YPOS) {
		p->field_ypos++;
		p->info_direction = F_YPOS;
		return;
	}

	p->character_ypos++;
	p->info_direction = C_YPOS;
}


/**-------------------------------------------------
 * 当たり判定を行う関数
 * -------------------------------------------------
 * 座標(0, 0)から開始
 * flame_buffer[x=0][y=0] ...'|'
 * ' '空白文字ではないので、障害物があると判定される
 * -------------------------------------------------
 * true : remap draw
 * false: not draw
 * -------------------------------------------------*/
static bool detect(t_posinfo *p)
{
	uint8_t utf_bit = 0;
	int32_t x, y, s;
	int32_t dir_x = 0, dir_y = 0;

	if ((p->info_direction == F_XPOS) && (p->character_direction == RIGHT)) {
		dir_x++;
	}
	else if ((p->info_direction == F_XPOS) && (p->character_direction == LEFT)) {
		dir_x--;
	}
	else if ((p->info_direction == F_YPOS) && (p->character_direction == UP)) {
		dir_y--;
	}
	else if ((p->info_direction == F_YPOS) && (p->character_direction == DOWN)) {
		dir_y++;
	}

	x = p->character_xpos - FIELD_DRAW_XPOS + dir_x;
	y = p->character_ypos - FIELD_DRAW_YPOS + dir_y;

	for (uint8_t i = 0; i < 3; i++) {
		s = field_flamebuffer[y][x-i];
		if (s < 0) {
			utf_bit++;
		}
	}

	s = field_flamebuffer[y][x];
	if ((s != ' ') && (s > 0)) {
		s = field_flamebuffer[y][x-1];
		if (s < 0) {
			s = field_flamebuffer[y][x-2];
			if (s < 0) {
				return true;
			}
		}
	}

	if (utf_bit == 3) {
		s = field_flamebuffer[y][x+1];
		if (s != ' ') {
			return false;
		}
		return true;
	}

	for (uint8_t i = 0; i < CAST_WIDTH_SIZE; i++) {
		s = field_flamebuffer[y][x+i];	//キャラクターの描画幅分、当たり判定を行う
		if (s != ' ') {
			return false;
		}
	}

	if (x == 0) {
		return false;
	}

	return true;
}


/**-------------------------------------------------
 * 当たり判定がfalseの場合、キャラクターの向きと
 * offsetof関数で取得したバイト分アドレスを進めて
 * 座標の調整を行う
 * -------------------------------------------------*/
static void direction(t_posinfo *p)
{
	int32_t *ptr;

	uint8_t skip[] = {
		offsetof(t_posinfo, character_xpos),
		offsetof(t_posinfo, character_ypos),
		offsetof(t_posinfo, field_xpos),
		offsetof(t_posinfo, field_ypos),
	};

	ptr = (int32_t *)((uint8_t *)p + skip[p->info_direction - C_XPOS]);

	switch (p->character_direction) {
		case RIGHT:
			*ptr = *ptr - 1;
			break;

		case LEFT:
			*ptr = *ptr + 1;
			break;

		case UP:
			*ptr = *ptr + 1;
			break;

		case DOWN:
			*ptr = *ptr - 1;
			break;

		default:
			break;
	}
}


/**-------------------------------------------
 * キャラクター描画
 * -------------------------------------------
 * arg1: x		x座標を指定
 * arg2: y		y座標を指定
 * arg3: color	描画色を指定
 * arg4: *str	描画キャラクターを指定
 * -------------------------------------------*/
static void cast_draw(uint32_t x, uint32_t y, uint8_t color, char *str)
{
    SET_TYPE(NORMAL);
    SET_CHAR_COLOR(color);
    SET_CHAR_BOLD();
    SET_PLACE(x, y);
    printf("%s\r\n", str);
	//strprintf(str);
}


/**-------------------------------------------
 * 現在のキャラクタとフィールドの座標を描画する
 * デバッグ用
 * -------------------------------------------*/
static void xypos_draw(t_posinfo *p)
{
    SET_TYPE(NORMAL);
    SET_CHAR_COLOR(WHITE);
    SET_CHAR_BOLD();
    SET_PLACE(2, 2);
    printf("\r%s%d\r\n", "chara_xpos = ", p->character_xpos);
    printf("%s%d\r\n",   "chara_ypos = ", p->character_ypos);
    printf("%s%d\r\n",   "field_xpos = ", p->field_xpos);
    printf("%s%d\r\n",   "field_ypos = ", p->field_ypos);
}


/**-------------------------------------------------
 * イベントのメッセージを描画する関数
 * -------------------------------------------------*/
static void event_msg_draw(void)
{

}


/**--------------------------------------------
 * 文字列出力
 * --------------------------------------------
 * arg1: *s    文字列のアドレスを指定
 *--------------------------------------------*/
static void asciidraw(char *s)
{
    printf("%s", s);
}


/**--------------------------------------------
 * フレームバッファにフィールドの情報を格納
 *--------------------------------------------*/
static void flame_input(t_fieldinfo *info, t_posinfo *p)
{
    int32_t xpos, ypos, len, height, y_animation, x_animation;
	char **field;	//filed pointer
	char *ptr;		//flame buffer pointer

	ptr = get_flamebuffer_address();
	field  = info->map_id;
	height = info->field_maxheight; 
	y_animation = info->ypos_animation_check;
	x_animation = info->xpos_animation_check;
	xpos = p->field_xpos;
	ypos = p->field_ypos;

    if (y_animation < ypos) {	//画面描画最大値チェック
        ypos = y_animation;
    }

    if (x_animation < xpos) {
        xpos = x_animation;
    }

    for (uint8_t i = 0; i < FIELD_HEIGHT && i < height-ypos; i++) {
        len = get_width(field, i+ypos);  //各行の横幅を取得
        for (uint8_t j = 0; j < FIELD_WIDTH && j < len-xpos; j++) {
            //field_flamebuffer[i][j] = (char)field[i+ypos][j+xpos];
			ptr[(i << FLAME_SHIFT) + j] = (char)field[i+ypos][j+xpos];
        }
    }
}


/**--------------------------------------------
 * フレームバッファに指定した文字を書き込む
 * 通常は画面クリア描画に使用する
 * --------------------------------------------
 * arg1: height     縦幅を指定
 * arg2: width      横幅を指定
 * arg3: s          文字を指定
 *--------------------------------------------*/
static void flameclear(uint8_t height, uint8_t width, char s)
{
	char *ptr;

	ptr = get_flamebuffer_address();

    for (uint8_t i = 0; i < height; i++) {
        for (uint8_t j = 0; j < width; j++) {
			ptr[(i << FLAME_SHIFT) + j] = s;
        }
    }
}


/**--------------------------------------------
 * フレームバッファ描画
 * ヌル文字の格納場所に注意すること
 * -------------------------------------------
 * arg1: color	描画色を指定
 *--------------------------------------------*/
static void flame_draw(uint8_t color)
{
	char *ptr;

	ptr = get_flamebuffer_address();
    SET_TYPE(NORMAL);
    SET_CHAR_COLOR(color);
    SET_CHAR_BOLD();

    for (uint8_t i = 0; i < FIELD_HEIGHT; i++) {
		SET_PLACE(FIELD_DRAW_XPOS, FIELD_DRAW_YPOS+i);
        //asciidraw(&field_flamebuffer[i][0]);
		asciidraw(&ptr[i << FLAME_SHIFT]);
    }
}


/**-------------------------------------------------
 * フレームバッファ先頭アドレス取得
 * -------------------------------------------------*/
static char *get_flamebuffer_address(void)
{
	return &field_flamebuffer[0][0];
}


/**--------------------------------------------
 * フィールドのマップ情報を取得する
 * --------------------------------------------
 * arg1: id    フィールドのIDを指定
 *--------------------------------------------*/
static char **search_field_map(uint32_t id)
{
    const t_map *p = map;

    for (uint8_t i = 0; i < FIELD_SIZE; i++, p++) {
        if (p->id == id) {
            return p->field_adr;
        }
    }

    return (char **)nullfield;
}


