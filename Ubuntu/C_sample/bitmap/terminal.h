#ifndef terminal_h_
#define terminal_h_

/* 画面消去 */
#define SET_PLACE(x, y);	printf("\033[%d;%dH", y, x);//座標の設定
#define SET_BACKCOLOR(n);	printf("\033[4%dm", (n));   //背景色の設定
#define SET_CHAR_COLOR(n);	printf("\033[3%dm", (n));   //文字色の設定
#define SET_TYPE(n);		printf("\033[%dm", (n));    //文字の種類の設定
#define SET_CHAR_BOLD();	printf("\x1b[1m");          //太文字
#define CLEAR_SCREEN();		printf("\033[2J");          //画面消去
#define CURSOL_ON();		printf("\033[?25h");        //カーソル表示
#define CURSOL_OFF();		printf("\033[?25l");		//カーソル消去
#define TERMINAL_RESET();	printf("\033[0m");			//指定リセット

/**----------------------------------------------------------
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


#endif