/**---------------------------------------------
 * DRAW_H
 * 
 * created on:2020/09/16
 * Author    :kouta kimura
 * ---------------------------------------------*/

#ifndef DRAW_H_
#define DRAW_H_

void debug(char *s, int32_t d);
void asciidraw(char *s);
void clear_screen(void);
void reimu_draw(uint32_t x, uint32_t y, uint8_t color, char *str);
void xypos_draw(uint32_t x, uint32_t y);
char **searchfield_map(uint32_t id);
int32_t search_field_para(uint32_t id, uint8_t para);
void flame_draw(uint8_t color);
void flame_input(char **field, uint32_t xpos, uint32_t ypos);
void flameclear(uint8_t height, uint8_t width, uint8_t color, char s);
void flamenull(void);
void mapdraw(uint8_t map, uint32_t x, uint32_t y);


#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))
#define CARA_SIZE ((sizeof (caracter))/(sizeof (t_caracter)))
#define FIELD_SIZE ((sizeof (map))/(sizeof (t_map)))
#define FIELD_HEIGHT 64
#define FIELD_WIDTH  64


/**-------------------------------------------------
 * フィールド番号
 * -------------------------------------------------*/
typedef enum {
    GLASS,
	KOUMAKAN,
	ROUKA,
	TOTAL_FIERL,
} FIELD_ID;


/**-------------------------------------------------
 * フィールド番号
 * -------------------------------------------------*/
typedef enum {
	REIMU,
	MARISA,
	TOTAL_CARACTER,
} CARACTER_ID;


#ifdef DRAWPARA

/**--------------------------------------------------
 * フレームバッファ
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


typedef struct {
    int32_t id;
    char **field_adr;
} t_map;

static const t_map map[] = {
    {GLASS,		(char **)str , },
    {KOUMAKAN,	(char **)str2, },
    {ROUKA,		(char **)str3, },
};



/*--------------------------------------------------
 * キャラクター情報
 *-------------------------------------------------*/
typedef struct {
	int32_t id;
	char *name;
	uint8_t color;
	uint8_t x;
	uint8_t y;
} t_caracter;

static const t_caracter caracter[] = {
	{REIMU,		"霊", 	RED,	10,	10},
	{MARISA,	"魔",	YELLOW,	10,	10},
};



/*--------------------------------------------------
 * 現在位置情報
 *-------------------------------------------------*/
typedef struct {
	int32_t xpos;
	int32_t ypos;
} t_pos;


#endif

#endif
