/**---------------------------------------------
 * MAPCHIP_H
 * ---------------------------------------------*/

#ifndef MAPCHIP_H_
#define MAPCHIP_H_


#define NUM(ary) 	(sizeof(ary)/sizeof(ary[0]))
#define CHIP_SIZE	((sizeof (mapid)) / (sizeof (t_mapid)))
#define CHIP_INFO	((sizeof (mapinfo)) / (sizeof (t_mapinfo)))
#define FIELDMAP_SIZE ((sizeof (fieldmap)) / (sizeof (t_fieldmap)))
#define BUILD_SIZE    ((sizeof (buildinfo)) / (sizeof (t_buildinfo)))


/**-------------------------------------------------
 * windowデータ定義
 * -------------------------------------------------*/
#define SCREEN_WIDTH	1280	//ウィンドウの幅を指定
#define SCREEN_HEIGHT	960		//ウィンドウの高さを指定
#define GRID_SIZE		32		//マップ描画データのpixel幅と高さを指定
#define MAP_SIZE_SHIFT	5		//5bitシフトすれば32になる
#define MAP_DRAW_WIDTH	(SCREEN_WIDTH >> MAP_SIZE_SHIFT)	//幅のループ回数
#define MAP_DRAW_HEIGHT	(SCREEN_HEIGHT >> MAP_SIZE_SHIFT)	//高さのループ回数
#define UNIT_WIDTH		24		//描画ユニットデータの幅を指定
#define UNIT_HEIGHT		32		//描画ユニットデータの高さを指定
#define UNIT_SHIFT		(MAP_SIZE_SHIFT-0)		//ユニットの描画位置を指定
#define FONT_SIZE		40		//描画フォントサイズを指定
#define MAPCHIP_SIZE	32		//マップチップのサイズ
#define MSG_FLAME_SIZE	10		//メッセージウィンドウの白枠のサイズ


/**-------------------------------------------------
 * Map Chip ID
 * -------------------------------------------------*/
#define	STANDERD_S		0
#define	STANDERD_MAP0  (STANDERD_S+0)
#define	STANDERD_MAP1  (STANDERD_S+1)
#define	STANDERD_MAP2  (STANDERD_S+2)
#define	STANDERD_MAP3  (STANDERD_S+3)
#define	STANDERD_MAP4  (STANDERD_S+4)
#define	STANDERD_MAP5  (STANDERD_S+5)
#define	STANDERD_MAP6  (STANDERD_S+6)
#define	STANDERD_MAP7  (STANDERD_S+7)
#define	STANDERD_MAP8  (STANDERD_S+8)
#define	STANDERD_MAP9  (STANDERD_S+9)
#define	STANDERD_MAP10 (STANDERD_S+10)
#define	STANDERD_MAP11 (STANDERD_S+11)
#define	STANDERD_MAP12 (STANDERD_S+12)
#define	STANDERD_MAP13 (STANDERD_S+13)
#define	STANDERD_MAP14 (STANDERD_S+14)
#define	STANDERD_MAP15 (STANDERD_S+15)
#define	STANDERD_MAP16 (STANDERD_S+16)
#define	STANDERD_MAP17 (STANDERD_S+17)
#define	STANDERD_MAP18 (STANDERD_S+18)
#define	STANDERD_MAP19 (STANDERD_S+19)
#define	STANDERD_MAP20 (STANDERD_S+20)
#define	STANDERD_MAP21 (STANDERD_S+21)
#define	STANDERD_MAP22 (STANDERD_S+22)
#define	STANDERD_MAP23 (STANDERD_S+23)
#define	STANDERD_MAP24 (STANDERD_S+24)
#define	STANDERD_MAP25 (STANDERD_S+25)
#define	STANDERD_MAP26 (STANDERD_S+26)
#define	STANDERD_MAP27 (STANDERD_S+27)
#define	STANDERD_MAP28 (STANDERD_S+28)
#define	STANDERD_MAP29 (STANDERD_S+29)
#define	STANDERD_MAP30 (STANDERD_S+30)
#define	STANDERD_MAP31 (STANDERD_S+31)
#define	STANDERD_MAP32 (STANDERD_S+32)
#define	STANDERD_MAP33 (STANDERD_S+33)
#define	STANDERD_MAP34 (STANDERD_S+34)
#define	STANDERD_MAP35 (STANDERD_S+35)
#define	STANDERD_MAP36 (STANDERD_S+36)
#define	STANDERD_MAP37 (STANDERD_S+37)
#define	STANDERD_MAP38 (STANDERD_S+38)
#define	STANDERD_MAP39 (STANDERD_S+39)
#define	STANDERD_MAP40 (STANDERD_S+40)
#define	STANDERD_MAP41 (STANDERD_S+41)
#define	STANDERD_MAP42 (STANDERD_S+42)
#define	STANDERD_MAP43 (STANDERD_S+43)
#define	STANDERD_MAP44 (STANDERD_S+44)
#define	STANDERD_MAP45 (STANDERD_S+45)
#define	STANDERD_MAP46 (STANDERD_S+46)
#define	STANDERD_MAP47 (STANDERD_S+47)
#define	STANDERD_MAP48 (STANDERD_S+48)
#define	STANDERD_MAP49 (STANDERD_S+49)
#define	STANDERD_MAP50 (STANDERD_S+50)
#define	STANDERD_MAP51 (STANDERD_S+51)
#define	STANDERD_MAP52 (STANDERD_S+52)
#define	STANDERD_MAP53 (STANDERD_S+53)
#define	STANDERD_MAP54 (STANDERD_S+54)
#define	STANDERD_MAP55 (STANDERD_S+55)
#define	STANDERD_MAP56 (STANDERD_S+56)
#define	STANDERD_MAP57 (STANDERD_S+57)
#define	STANDERD_MAP58 (STANDERD_S+58)
#define	STANDERD_MAP59 (STANDERD_S+59)
#define	STANDERD_MAP60 (STANDERD_S+60)
#define	STANDERD_MAP61 (STANDERD_S+61)
#define	STANDERD_MAP62 (STANDERD_S+62)
#define	STANDERD_MAP63 (STANDERD_S+63)
#define	STANDERD_MAP64 (STANDERD_S+64)
#define	STANDERD_MAP65 (STANDERD_S+65)
#define	STANDERD_MAP66 (STANDERD_S+66)
#define	STANDERD_MAP67 (STANDERD_S+67)
#define	STANDERD_MAP68 (STANDERD_S+68)
#define	STANDERD_MAP69 (STANDERD_S+69)
#define	STANDERD_MAP70 (STANDERD_S+70)
#define	STANDERD_MAP71 (STANDERD_S+71)
#define	STANDERD_MAP72 (STANDERD_S+72)
#define	STANDERD_MAP73 (STANDERD_S+73)
#define	STANDERD_MAP74 (STANDERD_S+74)
#define	STANDERD_MAP75 (STANDERD_S+75)
#define	STANDERD_MAP76 (STANDERD_S+76)
#define	STANDERD_MAP77 (STANDERD_S+77)
#define	STANDERD_MAP78 (STANDERD_S+78)
#define	STANDERD_MAP79 (STANDERD_S+79)
#define	STANDERD_MAP80 (STANDERD_S+80)
#define	STANDERD_MAP81 (STANDERD_S+81)
#define	STANDERD_MAP82 (STANDERD_S+82)
#define	STANDERD_MAP83 (STANDERD_S+83)
#define	STANDERD_MAP84 (STANDERD_S+84)
#define	STANDERD_MAP85 (STANDERD_S+85)
#define	STANDERD_MAP86 (STANDERD_S+86)
#define	STANDERD_MAP87 (STANDERD_S+87)
#define	STANDERD_E	   (STANDERD_MAP87)
#define	MITI_S (STANDERD_E+1)
#define	MITI0 (MITI_S+0)
#define	MITI1 (MITI_S+1)
#define	MITI2 (MITI_S+2)
#define	MITI3 (MITI_S+3)
#define	MITI4 (MITI_S+4)
#define	MITI_E (MITI4)
#define	MORI_S (MITI_E+1)
#define	MORI0 (MORI_S+0)
#define	MORI1 (MORI_S+1)
#define	MORI2 (MORI_S+2)
#define	MORI3 (MORI_S+3)
#define	MORI4 (MORI_S+4)
#define	MORI_E (MORI4)
#define	SABAKU_S (MORI_E+1)
#define	SABAKU0 (SABAKU_S+0)
#define	SABAKU1 (SABAKU_S+1)
#define	SABAKU2 (SABAKU_S+2)
#define	SABAKU3 (SABAKU_S+3)
#define	SABAKU4 (SABAKU_S+4)
#define	SABAKU_E (SABAKU4)
#define	TUTI_S (SABAKU_E+1)
#define	TUTI0 (TUTI_S+0)
#define	TUTI1 (TUTI_S+1)
#define	TUTI2 (TUTI_S+2)
#define	TUTI3 (TUTI_S+3)
#define	TUTI4 (TUTI_S+4)
#define	TUTI_E (TUTI4)
#define	UMI_S (TUTI_E+1)
#define	UMI0 (UMI_S+0)
#define	UMI1 (UMI_S+1)
#define	UMI2 (UMI_S+2)
#define	UMI3 (UMI_S+3)
#define	UMI4 (UMI_S+4)
#define	UMI_E (UMI4)
#define	YAMA_GRASS_S (UMI_E+1)
#define	YAMA_GRASS0 (YAMA_GRASS_S+0)
#define	YAMA_GRASS1 (YAMA_GRASS_S+1)
#define	YAMA_GRASS2 (YAMA_GRASS_S+2)
#define	YAMA_GRASS3 (YAMA_GRASS_S+3)
#define	YAMA_GRASS4 (YAMA_GRASS_S+4)
#define	YAMA_GRASS_E (YAMA_GRASS4)
#define	YAMA_MOUNTAIN_S (YAMA_GRASS_E+1)
#define	YAMA_MOUNTAIN0 (YAMA_MOUNTAIN_S+0)
#define	YAMA_MOUNTAIN1 (YAMA_MOUNTAIN_S+1)
#define	YAMA_MOUNTAIN2 (YAMA_MOUNTAIN_S+2)
#define	YAMA_MOUNTAIN3 (YAMA_MOUNTAIN_S+3)
#define	YAMA_MOUNTAIN4 (YAMA_MOUNTAIN_S+4)
#define	YAMA_MOUNTAIN_E (YAMA_MOUNTAIN4)
#define	YAMA_STONE_S (YAMA_MOUNTAIN_E+1)
#define	YAMA_STONE0 (YAMA_STONE_S+0)
#define	YAMA_STONE1 (YAMA_STONE_S+1)
#define	YAMA_STONE2 (YAMA_STONE_S+2)
#define	YAMA_STONE3 (YAMA_STONE_S+3)
#define	YAMA_STONE4 (YAMA_STONE_S+4)
#define	YAMA_STONE_E (YAMA_STONE4)

#define END_CHIPID	(YAMA_STONE_E + 1)


/**-------------------------------------------------
 * フレームバッファID定義
 * -------------------------------------------------*/
typedef enum {
	MAP40,
	MAP80,
	MAP120,
	MAP160,
	MAP320,
} T_FRAMEBUFFER_ID;


/**-------------------------------------------------
 * 移動番号定義
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
 * フィールド名定義
 * -------------------------------------------------*/
typedef enum {
    WORLD_MAP,	//世界地図
	HIROMA,		//外観
	TOTAL_FIERL,
} FIELD_NAME;



/**-------------------------------------------------
 * マップチップの相対パスを確保
 * -------------------------------------------------*/
static const char *mappath[] = {
	"../res/img/map/field/width32/map001.png",
	"../res/img/map/field/width32/miti.png",
	"../res/img/map/field/width32/mori.png",
	"../res/img/map/field/width32/sabaku.png",
	"../res/img/map/field/width32/tuti.png",
	"../res/img/map/field/width32/umi.png",
	"../res/img/map/field/width32/yama1.png",
	"../res/img/map/field/width32/yama2.png",
	"../res/img/map/field/width32/yama3.png",
};

static const char *moveobj[] = {
	"../res/img/item/obj/move_obj1.png"
	"../res/img/item/obj/move_obj2.png"
	"../res/img/item/obj/move_obj3.png"
	"../res/img/item/obj/move_obj4.png"
	"../res/img/item/obj/move_obj5.png"
	"../res/img/item/obj/move_obj6.png"
	"../res/img/item/obj/move_obj7.png"
	"../res/img/item/obj/switch.png"
	"../res/img/item/obj/tobira1.png"
	"../res/img/item/obj/tobira2.png"
	"../res/img/item/obj/tobira3.png"
};

static const char *tohoitem[] = {
	"../res/img/item/toho/itemicon.png"
};


/**-------------------------------------------------
 * マップチップの切り取り座標と当たり判定を確保
 * -------------------------------------------------*/
typedef struct {
	uint32_t id;	//一つの要素数のID
	uint32_t xpos;	//開始xpixel数を指定
	uint32_t ypos;	//開始ypixel数を指定
	uint8_t direct;	//当たり判定の有無を指定、1.有 0.無
} t_mapid;

static const t_mapid mapid[] = {
	{	STANDERD_MAP0,     0,    0,  0  },
	{	STANDERD_MAP1,    32,    0,  0  },
	{	STANDERD_MAP2,    64,    0,  0  },
	{	STANDERD_MAP3,    96,    0,  0  },
	{	STANDERD_MAP4,   128,    0,  0  },
	{	STANDERD_MAP5,   160,    0,  0  },
	{	STANDERD_MAP6,   192,    0,  0  },
	{	STANDERD_MAP7,   224,    0,  0  },
	{	STANDERD_MAP8,     0,   32,  0  },
	{	STANDERD_MAP9,    32,   32,  0  },
	{	STANDERD_MAP10,   64,   32,  1  },
	{	STANDERD_MAP11,   96,   32,  1  },
	{	STANDERD_MAP12,  128,   32,  1  },
	{	STANDERD_MAP13,  160,   32,  1  },	//穴event
	{	STANDERD_MAP14,  192,   32,  1  },	//泉event
	{	STANDERD_MAP15,  224,   32,  0  },
	{	STANDERD_MAP16,    0,   64,  0  },
	{	STANDERD_MAP17,   32,   64,  0  },
	{	STANDERD_MAP18,   64,   64,  0  },
	{	STANDERD_MAP19,   96,   64,  0  },
	{	STANDERD_MAP20,  128,   64,  1  },	//うずしお
	{	STANDERD_MAP21,  160,   64,  1  },	//流砂
	{	STANDERD_MAP22,  192,   64,  1  },	//山の洞窟
	{	STANDERD_MAP23,  224,   64,  1  },	//岩の洞窟
	{	STANDERD_MAP24,    0,   96,  0  },
	{	STANDERD_MAP25,   32,   96,  0  },
	{	STANDERD_MAP26,   64,   96,  0  },
	{	STANDERD_MAP27,   96,   96,  0  },
	{	STANDERD_MAP28,  128,   96,  1  },	//看板
	{	STANDERD_MAP29,  160,   96,  1  },	//石碑
	{	STANDERD_MAP30,  192,   96,  1  },	//山の鳥居洞窟
	{	STANDERD_MAP31,  224,   96,  1  },	//岩の鳥居洞窟
	{	STANDERD_MAP32,    0,  128,  1  },	//大山1
	{	STANDERD_MAP33,   32,  128,  1  },	//大山2
	{	STANDERD_MAP34,   64,  128,  1  },	//山々1
	{	STANDERD_MAP35,   96,  128,  1  },	//山々2
	{	STANDERD_MAP36,  128,  128,  1  },	//火山1
	{	STANDERD_MAP37,  160,  128,  1  },	//火山2
	{	STANDERD_MAP38,  192,  128,  1  },	//火山の洞窟1
	{	STANDERD_MAP39,  224,  128,  1  },	//火山の洞窟2
	{	STANDERD_MAP40,    0,  160,  1  },	//大山3
	{	STANDERD_MAP41,   32,  160,  1  },	//大山4
	{	STANDERD_MAP42,   64,  160,  1  },	//山々3
	{	STANDERD_MAP43,   96,  160,  1  },	//山々4
	{	STANDERD_MAP44,  128,  160,  1  },	//火山3
	{	STANDERD_MAP45,  160,  160,  1  },	//火山4
	{	STANDERD_MAP46,  192,  160,  1  },	//火山の洞窟3
	{	STANDERD_MAP47,  224,  160,  1  },	//火山の洞窟4
	{	STANDERD_MAP48,    0,  192,  0  },
	{	STANDERD_MAP49,   32,  192,  1  },	//集落1
	{	STANDERD_MAP50,   64,  192,  1  },	//集落2
	{	STANDERD_MAP51,   96,  192,  1  },	//石の城1
	{	STANDERD_MAP52,  128,  192,  1  },	//石の城2
	{	STANDERD_MAP53,  160,  192,  1  },	//青い城1
	{	STANDERD_MAP54,  192,  192,  1  },	//青い城2
	{	STANDERD_MAP55,  224,  192,  1  },	//ほこらの洞窟
	{	STANDERD_MAP56,    0,  224,  1  },	//民家
	{	STANDERD_MAP57,   32,  224,  1  },	//城下町1
	{	STANDERD_MAP58,   64,  224,  1  },	//城下町2
	{	STANDERD_MAP59,   96,  224,  1  },	//石の城3
	{	STANDERD_MAP60,  128,  224,  1  },	//石の城4
	{	STANDERD_MAP61,  160,  224,  1  },	//青い城3
	{	STANDERD_MAP62,  192,  224,  1  },	//青い城4
	{	STANDERD_MAP63,  224,  224,  0  },
	{	STANDERD_MAP64,    0,  256,  1  },	//教会
	{	STANDERD_MAP65,   32,  256,  1  },	//町1
	{	STANDERD_MAP66,   64,  256,  1  },	//町2
	{	STANDERD_MAP67,   96,  256,  1  },	//黒い城1
	{	STANDERD_MAP68,  128,  256,  1  },	//黒い城2
	{	STANDERD_MAP69,  160,  256,  1  },	//塔1
	{	STANDERD_MAP70,  192,  256,  1  },	//タワー1
	{	STANDERD_MAP71,  224,  256,  0  },
	{	STANDERD_MAP72,    0,  288,  1  },	//テント
	{	STANDERD_MAP73,   32,  288,  1  },	//レンガの家
	{	STANDERD_MAP74,   64,  288,  1  },	//拠点
	{	STANDERD_MAP75,   96,  288,  1  },	//黒い城3
	{	STANDERD_MAP76,  128,  288,  1  },	//黒い城4
	{	STANDERD_MAP77,  160,  288,  1  },	//塔2
	{	STANDERD_MAP78,  192,  288,  1  },	//タワー2
	{	STANDERD_MAP79,  224,  288,  0  },
	{	STANDERD_MAP80,    0,  320,  1  },	//儀式のほこら
	{	STANDERD_MAP81,   32,  320,  1  },	//ピラミッド
	{	STANDERD_MAP82,   64,  320,  1  },	//祭壇
	{	STANDERD_MAP83,   96,  320,  0  },
	{	STANDERD_MAP84,  128,  320,  0  },
	{	STANDERD_MAP85,  160,  320,  0  },
	{	STANDERD_MAP86,  192,  320,  0  },
	{	STANDERD_MAP87,  224,  320,  0  },
	{	MITI0,			   0,    0,  0  },
	{	MITI1,    		   0,   32,  0  },
	{	MITI2,    		   0,   64,  0  },
	{	MITI3,    		   0,   96,  0  },
	{	MITI4,    		   0,  128,  0  },
	{	MORI0,    		   0,    0,  0  },
	{	MORI1,    		   0,   32,  0  },
	{	MORI2,    		   0,   64,  0  },
	{	MORI3,    		   0,   96,  0  },
	{	MORI4,    		   0,  128,  0  },
	{	SABAKU0,    	   0,    0,  0  },
	{	SABAKU1,    	   0,   32,  0  },
	{	SABAKU2,    	   0,   64,  0  },
	{	SABAKU3,    	   0,   96,  0  },
	{	SABAKU4,    	   0,  128,  0  },
	{	TUTI0,    		   0,    0,  0  },
	{	TUTI1,    		   0,   32,  0  },
	{	TUTI2,    		   0,   64,  0  },
	{	TUTI3,    		   0,   96,  0  },
	{	TUTI4,    		   0,  128,  0  },
	{	UMI0,    		   0,    0,  1  },	//穴みずたまり
	{	UMI1,    		   0,   32,  1  },	//川縦
	{	UMI2,    		   0,   64,  1  },	//川横
	{	UMI3,    		   0,   96,  1  },	//海道
	{	UMI4,    		   0,  128,  1  },	//海
	{	YAMA_GRASS0,       0,    0,  0  },
	{	YAMA_GRASS1,       0,   32,  0  },
	{	YAMA_GRASS2,       0,   64,  0  },
	{	YAMA_GRASS3,       0,   96,  0  },
	{	YAMA_GRASS4,       0,  128,  0  },
	{	YAMA_MOUNTAIN0,    0,    0,  0  },
	{	YAMA_MOUNTAIN1,    0,   32,  0  },
	{	YAMA_MOUNTAIN2,    0,   64,  0  },
	{	YAMA_MOUNTAIN3,    0,   96,  0  },
	{	YAMA_MOUNTAIN4,    0,  128,  1  },	//山々
	{	YAMA_STONE0,       0,    0,  1  },	//岩
	{	YAMA_STONE1,       0,   32,  1  },	//岩
	{	YAMA_STONE2,       0,   64,  1  },	//岩
	{	YAMA_STONE3,       0,   96,  1  },	//岩
	{	YAMA_STONE4,       0,  128,  1  },	//岩々

};


/**-------------------------------------------------
 * マップチップのデータ構造確保
 * -------------------------------------------------*/
typedef struct {
	uint32_t startid;	//一つの画像データの開始ID
	uint32_t endid;		//一つの画像データの終了ID
	uint8_t select;		//相対パスが保存されている配列の列番号を指定
	char **path;		//相対パスのアドレス
	uint32_t xpixel;	//横pixel数を指定
	uint32_t ypixel;	//縦pixel数を指定
	uint32_t maxwidth;	//画像データの最大横幅を指定
	uint32_t maxheight;	//画像データの最大縦幅を指定
} t_mapinfo;

static const t_mapinfo mapinfo[] = {
	{	STANDERD_S,  	 	STANDERD_E,		 0,  (char **)mappath,   32,   32,  256,  352  },
	{	MITI_S,  		 	MITI_E,  		 1,  (char **)mappath,   32,   32,   32,  160  },
	{	MORI_S,  		 	MORI_E,  		 2,  (char **)mappath,   32,   32,   32,  160  },
	{	SABAKU_S,	   	   	SABAKU_E,  		 3,  (char **)mappath,   32,   32,   32,  160  },
	{	TUTI_S,  		 	TUTI_E,  		 4,  (char **)mappath,   32,   32,   32,  160  },
	{	UMI_S,  		  	UMI_E,  		 5,  (char **)mappath,   32,   32,   32,  160  },
	{	YAMA_GRASS_S,  		YAMA_GRASS_E,  	 6,  (char **)mappath,   32,   32,   32,  160  },
	{	YAMA_MOUNTAIN_S,  	YAMA_MOUNTAIN_E, 7,  (char **)mappath,   32,   32,   32,  160  },
	{	YAMA_STONE_S,  		YAMA_STONE_E,  	 8,  (char **)mappath,   32,   32,   32,  160  },
};


/**-------------------------------------------------
 * フレームバッファのデータ構造確保
 * -------------------------------------------------*/
typedef struct {
	uint8_t id;
	uint32_t fieldmap_width;
	uint32_t fieldmap_height;
} t_fieldmap;

static const t_fieldmap fieldmap[] = {
	{ MAP40,    MAP_DRAW_WIDTH,		MAP_DRAW_HEIGHT   },
	{ MAP80,    MAP_DRAW_WIDTH*2,	MAP_DRAW_HEIGHT*2 },
	{ MAP120,   MAP_DRAW_WIDTH*3,	MAP_DRAW_HEIGHT*3 },
	{ MAP160,   MAP_DRAW_WIDTH*4,	MAP_DRAW_HEIGHT*4 },
	{ MAP320,   MAP_DRAW_WIDTH*5,	MAP_DRAW_HEIGHT*5 },
};


/**-------------------------------------------------
 * 
 * -------------------------------------------------*/
typedef struct {
	uint8_t mapname;
	uint8_t id;
	char *binfile;
} t_buildinfo;

static const t_buildinfo buildinfo[] = {
	{ WORLD_MAP,  MAP320, "worldmap.bin" },
	{ HIROMA,  	  MAP40,  "hiroma.bin"   },
};


#endif
