/**--------------------------------------------
 * 2020/09/22 koutakimura
 * Ubuntu LTS 20.04
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
 * 構造体の確保
 * -------------------------------------------------*/
static t_fieldinfo fieldinfo;
static t_posinfo posinfo = {10, 10, 0, 0, 0,};


/**----------------------------------------
 * static関数・変数
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
static void mapdraw(int32_t x, int32_t y);
static void cast_draw(uint32_t x, uint32_t y, uint8_t color, char *str);
static void xypos_draw(void);
static void asciidraw(char *s);
static void flame_draw(uint8_t color);
static void flame_input(int32_t xpos, int32_t ypos);
static void flameclear(uint8_t height, uint8_t width, char s);
static char **search_field_map(uint32_t id);
static int32_t search_field_para(uint32_t id, uint8_t para);


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

		case UP:
			xpos_move_left(p);
			break;

		case DOWN:
			ypos_move_down(info, p);
			break;

		case LEFT:
			ypos_move_up(p);
			break;

		default:
			return;
	}

	if (false == detect(p)) {
		direction(p);
		return;
	}

	xypos_draw();
	mapdraw(p->field_xpos, p->field_ypos);
	cast_draw(p->character_xpos, p->character_ypos, RED, "霊");
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

	if (p->character_xpos > (FIELD_WIDTH >> 1)) {
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

	if (p->character_xpos > (FIELD_WIDTH >> 1)) {
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
	return;
}


/**-------------------------------------------------
 * y軸上移動の座標計算
 * -------------------------------------------------*/
static void ypos_move_up(t_posinfo *p)
{
	p->character_direction = UP;

	if (p->character_ypos > (FIELD_HEIGHT >> 1)) {
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
	return;
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

	if (p->character_ypos > (FIELD_HEIGHT >> 1)) {
		p->field_ypos++;
		p->info_direction = C_YPOS;
		return;
	}

	p->character_ypos++;
	p->info_direction = C_YPOS;
	return;
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

	ptr = (int32_t *)((uint8_t *)p + skip[C_XPOS - p->info_direction]);

	switch (p->character_direction) {
		case RIGHT:
			*ptr = *(ptr) - 1;
			break;

		case LEFT:
			*ptr = (*ptr) + 1;
			break;

		case UP:
			*ptr = (*ptr) + 1;
			break;

		case DOWN:
			*ptr = (*ptr) - 1;
			break;

		default:
			break;
	}
}


/**-------------------------------------------------
 * 当たり判定を行う関数
 * -------------------------------------------------
 * 座標(0, 0)から開始
 * x = 5 + 0 - 5 ...0
 * y = 7 + 0 - 7 ...0 
 * flame_buffer[x=0][y=0] ...'|'
 * ' '空白文字ではないので、障害物があると判定される
 * -------------------------------------------------*/
static bool detect(t_posinfo *p)
{
	int32_t x, y;
	char s;

	x = p->character_xpos + p->field_xpos - FIELD_DRAW_XPOS;
	y = p->character_ypos + p->field_ypos - FIELD_DRAW_YPOS;
	s = field_flamebuffer[y][x];

	if (s != ' ') {
		return false;
	}

	return true;
}


/**-------------------------------------------
 * フィールド描画関数呼び出し
 * -------------------------------------------
 * arg1: x		キャラクターの現在位置におけるx座標指定
 * arg2: y		キャラクターの現在位置におけるy座標指定
 *--------------------------------------------*/
static void mapdraw(int32_t x, int32_t y)
{
	clear_screen();
    flameclear(FIELD_HEIGHT, FIELD_WIDTH, ' ');
    flame_input(x, y);
	flame_draw(YELLOW);
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
	strprintf(str);
//    asciidraw(str);
}


/**-------------------------------------------
 * 現在のキャラクタとフィールドの座標を描画する
 * デバッグ用
 * -------------------------------------------*/
static void xypos_draw(void)
{
	t_posinfo *p = &posinfo;

    SET_TYPE(NORMAL);
    SET_CHAR_COLOR(WHITE);
    SET_CHAR_BOLD();
    SET_PLACE(2, 2);
    printf("\r%s%d\r\n", "chara_xpos = ", p->character_xpos);
    printf("%s%d\r\n",   "chara_ypos = ", p->character_ypos);
    printf("%s%d\r\n",   "field_xpos = ", p->field_xpos);
    printf("%s%d\r\n",   "field_ypos = ", p->field_ypos);
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
 * --------------------------------------------
 * arg1: xpos	キャラクターの位置に対する描画xposを指定
 * arg2: ypos	キャラクターに位置に対する描画yposを指定
 *--------------------------------------------*/
static void flame_input(int32_t xpos, int32_t ypos)
{
    int32_t len, height, y_animation, x_animation;
	t_fieldinfo *info = &fieldinfo;
	char **field;

	field  = info->map_id;	//フィールドの各情報を一時保存
	height = info->field_maxheight; 
	y_animation = info->ypos_animation_check;
	x_animation = info->xpos_animation_check;

    if (y_animation < ypos) {  //画面描画最大値チェック
        ypos = y_animation;
    }

    if (x_animation < xpos) {
        xpos = x_animation;
    }

    for (uint8_t i = 0; i < FIELD_HEIGHT && i < height-ypos; i++) {
        len = get_width(field, i+ypos);  //各行の横幅を取得
        for (uint8_t j = 0; j < FIELD_WIDTH && j < len-xpos; j++) {
            field_flamebuffer[i][j] = (char)field[i+ypos][j+xpos];
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
    for (uint8_t i = 0; i < height; i++) {
        for (uint8_t j = 0; j < width; j++) {
            field_flamebuffer[i][j] = s;
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
    SET_TYPE(NORMAL);
    SET_CHAR_COLOR(color);
    SET_CHAR_BOLD();

    for (uint8_t i = 0; i < FIELD_HEIGHT; i++) {
		SET_PLACE(FIELD_DRAW_XPOS, FIELD_DRAW_YPOS+i);
        asciidraw(&field_flamebuffer[i][0]);
    }
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


/**--------------------------------------------
 * フィールドのデータを取得する
 * --------------------------------------------
 * arg1: id    フィールドのIDを指定
 *--------------------------------------------*/
static int32_t search_field_para(uint32_t id, uint8_t para)
{
    const t_map *p = map;

    for (uint8_t i = 0; i < FIELD_SIZE; i++, p++) {
        if (p->id == id) {
            break;
        }
    }

    switch (para) {
        case 0:
            return 0;
        case 1:
            return 0;
        default:
            return 0;
    }
}
