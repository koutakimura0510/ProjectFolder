/**---------------------------------------------
 * DRAW_H
 * ---------------------------------------------*/

#ifndef DRAW_H_
#define DRAW_H_


/**-------------------------------------------------
 * 外部関数
 * -------------------------------------------------*/
void clear_screen(void);
void map_info_struct_write(uint8_t map);
void animation_move(uint8_t id);
void saveing(void);

/**-------------------------------------------------
 * 端末操作マクロ
 * -------------------------------------------------*/
#define SET_PLACE(x, y);	printf("\033[%d;%dH", y, x);//座標の設定
#define SET_BACKCOLOR(n);	printf("\033[4%dm", (n));   //背景色の設定
#define SET_CHAR_COLOR(n);	printf("\033[3%dm", (n));   //文字色の設定
#define SET_TYPE(n);		printf("\033[%dm", (n));    //文字の種類の設定
#define SET_CHAR_BOLD();	printf("\x1b[1m");          //太文字
#define CLEAR_SCREEN();		printf("\033[2J");          //画面消去
#define CURSOL_ON();		printf("\033[?25h");        //カーソル表示
#define CURSOL_OFF();		printf("\033[?25l");		//カーソル消去
#define TERMINAL_RESET();	printf("\033[0m");			//指定リセット


/**-----------------------------------------------------------
 *
 * 描画色デバイスコード
 * ----------------------------------------------------------*/
typedef enum
{
    BLACK,
    RED,
    GREEN,
    YELLOW,
    BLUE,
    MAGENTA,
    CYAN,
    WHITE,
    DEFAULT,
    COLOR_SIZE,
} COLOR;


/**-----------------------------------------------------------
 * 文字描画方法デバイスコード
 * ----------------------------------------------------------*/
typedef enum
{
    NORMAL,		//リセット
	BOLD,		//濃く描画
    BLIGHT,		//薄く描画
    DIM,		//イタリック描画
    UNDERBAR,	//アンダーライン
    BLINK,		//点滅
	FASTBLINK,	//高速点滅
    REVERSE,	//反転
    HIDE,
    STRIKE,
} ACTION;


/**-------------------------------------------------
 * 移動番号
 * -------------------------------------------------*/
typedef enum {
	RIGHT,
	UP,
	DOWN,
	LEFT,
	C_XPOS,
	C_YPOS,
	F_XPOS,
	F_YPOS,
	NON,
} MOVE_ID;


/**-------------------------------------------------
 * フィールド番号
 * -------------------------------------------------*/
typedef enum {
    GLASS,		//広場
	KOUMAKAN,	//外観
	ROUKA,		//廊下
	TOTAL_FIERL,
} FIELD_ID;


/**-------------------------------------------------
 * 登場キャラクター名
 * -------------------------------------------------*/
typedef enum {
	REIMU,
	MARISA,
	TOTAL_CARACTER,
} CAST_ID;


/**-------------------------------------------------
 * 下記のパラメータはdraw.cのみ使用
 * -------------------------------------------------*/
#ifdef DRAWPARA

/**-------------------------------------------------
 * 構造体サイズ
 * -------------------------------------------------*/
#define CAST_SIZE  ((sizeof (cast))/(sizeof (t_cast)))
#define FIELD_SIZE ((sizeof (map)) /(sizeof (t_map)))


/**-------------------------------------------------
 * フレームバッファ要素数
 * -------------------------------------------------*/
#define FLAME_ROW  256
#define FLAME_COL	32
#define FLAME_SHIFT	 8


/**-------------------------------------------------
 * マップ描画幅
 * -------------------------------------------------*/
#define FIELD_HEIGHT 32
#define FIELD_WIDTH  32


/**-------------------------------------------------
 * フィールド描画位置指定
 * -------------------------------------------------*/
#define TITLE_XPOS			2	//now fieldname draw
#define TITLE_YPOS			1
#define NOW_XPOS			2	//xpos draw
#define NOW_YPOS			2	//ypos draw
#define FIELD_DRAW_XPOS		5	//field xpos
#define FIELD_DRAW_YPOS		7	//field ypos
#define MSG_XPOS			2	//character msg
#define MSG_YPOS			41
#define STATUS_XPOS			70	//character profile
#define STATUS_YPOS			7
#define ANIMATION_MSG_XPOS	2	//info draw
#define ANIMATION_MSG_YPOS	40


/**-------------------------------------------------
 * 描画キャラクターの幅
 * -------------------------------------------------*/
#define CAST_WIDTH_SIZE		2
#define SJIS_BYTE_CHECK		3


/**--------------------------------------------------
 * フレームバッファ
 * マップ情報、現在のキャラクターの位置情報の保存を行う
 * フレームバッファを参照して、端末に描画を行う
 * FIELD_HEIGHT		:高さ
 * FIELD_WIDTH + 1	:横幅 + null文字('\0')
 * --------------------------------------------------*/
static char flamebuffer[FLAME_COL][FLAME_ROW];


/**-------------------------------------------------
 * フィールド情報
 * 二次元的な情報を予め用意しておく
 * -------------------------------------------------*/
static const char *str[] ={
		 /* 0   2   4   6   8  10  12  14  16  18  20  22  24  26  28  30  32  34  36  38  40  42 */
		 /*   1   3   5   7   9  11  13  15  17  19  21  23  25  27  29  31  33  35  37  39  41   */
/*01*/    "■■■",
/*02*/    "■出■■■■■■■■■■■■■■■■■■■■■",
/*03*/    "■                                          ■",
/*04*/    "■                                          ■■■■■■■■■■■■■■■■■■■■■",
/*05*/    "■                                                                                  ■",
/*06*/    "■                                                                                  ■",
/*07*/    "■                                                                                  ■",
/*08*/    "■         □□□□□□□□□□                                                     ■",
/*09*/    "■         □                □                                                     ■",
/*10*/    "■         □                □               ■■■■■■■■■■■■■■■■■■  ■",
/*11*/    "■         □        宝      □                                                   Ｐ■",
/*12*/    "■         □                □               ■■■■■■■■■■■■■■■■■■■■",
/*13*/    "■         □                □               ■",
/*14*/    "■         □                □               ■",
/*15*/    "■         □□□□      □□□               ■",
/*16*/    "■                                            ■",
/*17*/    "■                                            ■",
/*18*/    "■                                            ■",
/*19*/    "■                                            ■",
/*20*/    "■                                            ■",
/*21*/    "■                                            ■",
/*22*/    "■                ■■■■■■■■■■■■■■■",
/*23*/    "■                ■",
/*24*/    "■■■■■■■■■■",
/*25*/    "\0"
};

static const char *str2[] ={
    "sx",
    "aa",
    " a",
    "",
    "d  a",
    "\0"
};

static const char *str3[] ={
    "----------------------",
    "----------------------",
    "ss                ",
    " ",
    "a                       a",
    "\0"
};

static const char *nullfield[] = {
    "\0",
};


/**-------------------------------------------------
 * フィールド情報を管理する構造体
 * -------------------------------------------------
 * id		  :フィールド名
 * **field_adr:フィールド情報の先頭アドレスを取得
 * -------------------------------------------------*/
typedef struct {
    uint32_t id;		//フィールド名を指定
    char **field_adr;	//フィールドを指定
} t_map;

static const t_map map[] = {
    {GLASS,		(char **)str , },
    {KOUMAKAN,	(char **)str2, },
    {ROUKA,		(char **)str3, },
};


/*--------------------------------------------------
 * キャラクター情報、初期値
 *-------------------------------------------------*/
typedef struct {
	int32_t id;		//id name
	char *name;		//draw str
	uint8_t color;	//draw color
	uint8_t x;		//init x pos
	uint8_t y;		//init y pos
} t_cast;

static const t_cast cast[] = {
	{REIMU,		"霊", 	RED,	FIELD_DRAW_XPOS+5,	FIELD_DRAW_YPOS+3},
	{MARISA,	"魔",	YELLOW,	10,	10},
};



#endif

#endif
