/**---------------------------------------------
 * DRAW_H
 * 
 * created on:2020/09/16
 * Author    :kouta kimura
 * ---------------------------------------------*/

#ifndef DRAW_H_
#define DRAW_H_


/**-------------------------------------------------
 * 外部関数
 * -------------------------------------------------*/
void debug(char *s, int32_t d);
void asciidraw(char *s);
void clear_screen(void);
void reimu_draw(uint32_t x, uint32_t y, uint8_t color, char *str);
void xypos_draw(uint32_t x, uint32_t y);
char **searchfield_map(uint32_t id);
int32_t search_field_para(uint32_t id, uint8_t para);
void flame_draw(uint8_t color);
void flame_input(int32_t xpos, int32_t ypos);
void flameclear(uint8_t height, uint8_t width, uint8_t color, char s);
void flamenull(void);
void mapdraw(uint32_t x, uint32_t y);
void xpos_move(void);
void map_info_struct_write(uint8_t map);


#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))
#define CARA_SIZE ((sizeof (caracter))/(sizeof (t_caracter)))
#define FIELD_SIZE ((sizeof (map))/(sizeof (t_map)))

/**-------------------------------------------------
 * 最大画面描画幅を指定
 * -------------------------------------------------*/
#define FIELD_HEIGHT 32
#define FIELD_WIDTH  32


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
} CARACTER_ID;


#ifdef DRAWPARA

/**--------------------------------------------------
 * フレームバッファ
 * マップ情報、現在のキャラクターの位置情報の保存を行う
 * フレームバッファを参照して、端末に描画を行う
 * FIELD_HEIGHT		:高さ
 * FIELD_WIDTH + 1	:横幅 + null文字('\0')
 * --------------------------------------------------*/
static char field_flamebuffer[FIELD_HEIGHT][FIELD_WIDTH+1];


/**-------------------------------------------------
 * フィールド情報
 * -------------------------------------------------*/
static const char *str[] ={
    " __",
    "|宝|__________________________________________",
    "|                                aaaaaaaaaa   |",
    "|                                     aaaaaaa |___________________________________",
    "|                                           a                                     |",
    "|                          aaaaaaa                                                |",
    "|                                 aaa                                              |",
    "-                                aa                                                |",
    "-                                                                                  |",
    "-                  霊                         ____________________________________ |",
    "-                                   aaaaaaa   -",
    "-                                             -",
    "-                                             -",
    "-                                             -",
    "-                                  a          -",
    "-                                             -",
    "-                                             -",
    "-                                             -",
    "-                                             -",
    "-                                             -",
    "-                                             -",
    "-                ------------------------------",
    "-                -",
    "------------------",
    "\0"
};

static const char *str2[] ={
    "sx",
    "aa",
    " a",
    "霊",
    "d  a",
    "\0"
};

static const char *str3[] ={
    "----------------------",
    "----------------------",
    "ss          玉座      ",
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
 * 			id:フィールド名
 * **field_adr:フィールド情報の先頭アドレスを取得
 * -------------------------------------------------*/
typedef struct {
    uint32_t id;		//フィールド名を指定
    char **field_adr;	//フィールド情報の先頭アドレスを指定
} t_map;

static const t_map map[] = {
    {GLASS,		(char **)str , },
    {KOUMAKAN,	(char **)str2, },
    {ROUKA,		(char **)str3, },
};



/*--------------------------------------------------
 * キャラクター情報を管理する構造体
 *-------------------------------------------------*/
typedef struct {
	int32_t id;		//id name
	char *name;		//draw str
	uint8_t color;	//draw color
	uint8_t x;		//init x pos
	uint8_t y;		//init y pos
} t_caracter;

static const t_caracter caracter[] = {
	{REIMU,		"霊", 	RED,	10,	10},
	{MARISA,	"魔",	YELLOW,	10,	10},
};



/*--------------------------------------------------
 * 現在位置情報
 *-------------------------------------------------*/
typedef struct {
	int32_t xpos;	//now xpos
	int32_t ypos;	//now ypos
} t_pos;


#endif

#endif
