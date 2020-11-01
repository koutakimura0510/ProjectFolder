/**--------------------------------------------
 * 2020/09/22 koutakimura
 * Ubuntu LTS 20.04
 *
 * 描画に関する関数をまとめたファイル
 *
 *--------------------------------------------*/
#include "../include/LIB.H"
#define DRAWPARA
#include "../include/DRAW.H"


/**----------------------------------------
 * static関数・変数
 *-----------------------------------------*/
static uint32_t get_width(char **s, uint32_t height);
static uint32_t get_height(char **s);
static uint32_t get_maxwidth(char **s, uint32_t height);
static void newline(void);


/**-------------------------------------------------
 * キャラクターの座標と向きを保存
 * -------------------------------------------------*/
typedef struct {
	uint32_t character_xpos;		//ユニットのx座標
	uint32_t character_ypos;		//ユニットのy座標
	uint8_t  character_direction;	//ユニットの現在向いている方向
} t_charapos;


/**-------------------------------------------------
 * 現在のフィールド情報を保存
 * -------------------------------------------------*/
typedef struct {
	int32_t ypos_animation_check;	//
	int32_t xpos_animation_check;
	int32_t field_maxwidth;		//現在フィールドの最大横幅指定
	int32_t field_maxheight;	//現在フィールドの最大高さ指定
	char **map_id;				//現在フィールドの先頭アドレス指定
} t_fieldinfo;


/**-------------------------------------------------
 * フィールド画面スクロールアニメーション
 * 現在のキャラクターの座標と最大フィールド幅を参照し
 * スクロールを行うか判定する
 * -------------------------------------------------*/
typedef struct {
	int32_t field_xpos;
	int32_t field_ypos;
} t_fieldpos;


/**-------------------------------------------------
 * 当たり判定のためにフィールドの文字コードを取得
 * キャラクターの座標とフィールドの座標から計算して
 * 配列のアドレスを指定する
 * -------------------------------------------------*/
typedef struct {
	uint32_t buffer_xpos;
	uint32_t buffer_ypos;
} t_bufferpos;


/**-------------------------------------------------
 * 構造体の確保
 * -------------------------------------------------*/
static t_charapos  charapos;
static t_fieldinfo fieldinfo;
static t_fieldpos  fieldpos;
static t_bufferpos bufferpos;


/**--------------------------------------------
 * デバッグ出力
 * --------------------------------------------
 * arg1: *s    " "の文字列を表示
 * arg2: d     表示データ
 *--------------------------------------------*/
void debug(char *s, int32_t d)
{
    printf("%s = ", s);
    printf("%d\r\n", d);
}


/**-------------------------------------------------
 * x軸右移動の座標計算
 * -------------------------------------------------*/
void xpos_move_on(void)
{
	t_fieldinfo *info = &fieldinfo;
	t_charapos  *cpos = &charapos;
	t_fieldpos  *fpos = &fieldpos;

	if ((FIELD_WIDTH + fpos->field_xpos) >= info->field_maxwidth) {
		cpos->character_xpos++;
	}

	if (cpos->character_xpos > (FIELD_WIDTH >> 1)) {
		fpos->field_xpos++;
	}

	cpos->character_xpos++;
}


/**--------------------------------------------
 * 文字列出力
 * --------------------------------------------
 * arg1: *s    文字列のアドレスを指定
 *--------------------------------------------*/
void asciidraw(char *s)
{
    printf("%s", s);
}


/**--------------------------------------------
 * 画面消去
 *--------------------------------------------*/
void clear_screen(void)
{
    CLEAR_SCREEN();
}


/**-------------------------------------------
 * キャラクター描画
 * -------------------------------------------
 * arg1: x		x座標を指定
 * arg2: y		y座標を指定
 * arg3: color	描画色を指定
 * arg4: *str	描画キャラクターを指定
 * -------------------------------------------*/
void reimu_draw(uint32_t x, uint32_t y, uint8_t color, char *str)
{
	xypos_draw(x, y);	//デバッグ用に座標描画
    SET_TYPE(NORMAL);
    SET_CHAR_COLOR(color);
    SET_CHAR_BOLD();
    SET_PLACE(x, y);
	strprintf(str);
//    asciidraw(str);
}


/**-------------------------------------------
 * 現在のキャラクタの座標を描画する
 * -------------------------------------------
 * arg1: x		x座標を指定
 * arg2: y		y座標を指定
 * -------------------------------------------*/
void xypos_draw(uint32_t x, uint32_t y)
{
    SET_TYPE(NORMAL);
    SET_CHAR_COLOR(WHITE);
    SET_CHAR_BOLD();
    SET_PLACE(2, 2);
    printf("\r%s%d\r\n", "xpos = ", x);
    printf("%s%d\r\n", "ypos = ", y);
}


/**-------------------------------------------------
 * 座標計算
 * -------------------------------------------------*/


/**--------------------------------------------
 * フィールドのマップ情報を取得する
 * --------------------------------------------
 * arg1: id    フィールドのIDを指定
 *--------------------------------------------*/
char **search_field_map(uint32_t id)
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
int32_t search_field_para(uint32_t id, uint8_t para)
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



/**--------------------------------------------
 * フレームバッファ描画
 * ヌル文字の格納場所に注意すること
 *--------------------------------------------*/
void flame_draw(uint8_t color)
{
    SET_TYPE(NORMAL);
    SET_CHAR_COLOR(color);
    SET_CHAR_BOLD();

    for (uint8_t i = 0; i < FIELD_HEIGHT; i++) {
		SET_PLACE(5, 5+i);
        asciidraw(&field_flamebuffer[i][0]);
        //newline();
    }
}


/**--------------------------------------------
 * フレームバッファにフィールドの情報を格納
 * --------------------------------------------
 * arg1: **field    フィールドの先頭アドレスを指定
 * arg2: xpos       キャラクターの位置に対する描画xposを指定
 * arg3: ypos       キャラクターに位置に対する描画yposを指定
 *--------------------------------------------*/
void flame_input(int32_t xpos, int32_t ypos)
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
    flame_draw(YELLOW);
}


/**--------------------------------------------
 * フレームバッファに指定した文字を書き込む
 * 通常は画面クリア描画に使用する
 * --------------------------------------------
 * arg1: height     縦幅を指定
 * arg2: width      横幅を指定
 * arg3: color      書き込む色を指定
 * arg4: s          文字を指定
 *--------------------------------------------*/
void flameclear(uint8_t height, uint8_t width, uint8_t color, char s)
{
    for (uint8_t i = 0; i < height; i++) {
        for (uint8_t j = 0; j < width; j++) {
            field_flamebuffer[i][j] = s;
        }
    }
}


/**--------------------------------------------
 * フレームバッファの各行の末尾にヌル文字を書き込む
 *--------------------------------------------*/
void flamenull(void)
{
    for (uint8_t i = 0; i < FIELD_HEIGHT; i++) {
        field_flamebuffer[i][FIELD_WIDTH] = '\0';
    }
}


/**-------------------------------------------
 * フィールド描画関数呼び出し
 * -------------------------------------------
 * arg1: map	描画マップ指定
 * arg2: x		キャラクターの現在位置におけるx座標指定
 * arg3: y		キャラクターの現在位置におけるy座標指定
 *--------------------------------------------*/
void mapdraw(uint32_t x, uint32_t y)
{
	clear_screen();
    flameclear(FIELD_HEIGHT, FIELD_WIDTH, 0, ' ');
    //    flamenull();
    flame_input(x, y);
}


/**-------------------------------------------------
 * 描画に必要な情報を取得し構造体に保存を行う
 *
 * -------------------------------------------------
 * arg1: map	現在のフィールドIDを指定
 * -------------------------------------------------*/
void map_info_struct_write(uint8_t map)
{
	t_fieldinfo *info = &fieldinfo;
	char **p;
	int32_t height, width, y_animation, x_animation;

	p = search_field_map(map);
    height = get_height(p);	//フィールドの縦幅を取得
	width  = get_maxwidth(p, height);
	y_animation = height - FIELD_HEIGHT;	//フィールド描画の最縦幅大幅取得
    x_animation = width - FIELD_WIDTH; 		//フィールド描画の最大横幅取得
	
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


/*----------------------------------------------
 * static関数処理
 *---------------------------------------------*/

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


/**--------------------------------------------
 * 改行を行う
 *--------------------------------------------*/
static void newline(void)
{
    printf("\r\n");
}
