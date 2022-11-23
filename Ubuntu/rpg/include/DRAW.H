/**---------------------------------------------
 * DRAW_H
 * ---------------------------------------------*/

#ifndef DRAW_H_
#define DRAW_H_


/**-------------------------------------------------
 * 外部関数
 * -------------------------------------------------*/
void clear_screen(void);


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



#endif
