/**---------------------------------------------
 * PARA_H
 * 
 * created on:2020/09/16
 * Author    :kouta kimura
 * ---------------------------------------------*/

#ifndef PARA_H_
#define PARA_H_

#define SET_PLACE(x, y);   printf("\033[%d;%dH", y, x);  //座標の設定
#define SET_BACKCOLOR(n);  printf("\033[4%dm", (n));    //背景色の設定
#define SET_CHAR_COLOR(n); printf("\033[3%dm", (n));    //文字色の設定
#define SET_TYPE(n);       printf("\033[%dm", (n));     //文字の種類の設定
#define SET_CHAR_BOLD();   printf("\x1b[1m");           //太文字
#define CLEAR_SCREEN();    printf("\033[2J");           //画面消去
#define CURSOL_ON();       printf("\033[?25h");         //カーソル表示
#define CURSOL_OFF();      printf("\033[?25l");         //カーソル消去

/**-----------------------------------------------------------
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
    NORMAL,
    BLIGHT,
    DIM,
    UNDERBAR,
    BLINK,
    REVERSE,
    HIDE,
    STRIKE,
} ACTION;



/**-----------------------------------------------------------
 * Toho RPG Game パラメータ構造体
 * ----------------------------------------------------------*/
/*typedef struct {
    uint32_t id;    //ID情報
    int32_t x;      //表示x座標
    int32_t y;      //表示y座標
    int32_t init;   //初期値
    int32_t 
} */




#endif
