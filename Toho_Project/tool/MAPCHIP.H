/**---------------------------------------------
 * MAPCHIP_H
 * ---------------------------------------------*/

#include "MAPCHIP_ID.H"


#ifndef MAPCHIP_H_
#define MAPCHIP_H_


/**-------------------------------------------------
 * マップチップの相対パスを確保
 * -------------------------------------------------*/
static const char *mappath[] = {
	"../res/img/map/field/width32/map001.png",
	"../res/img/map/field/width32/sabaku.png",
	"../res/img/map/field/width32/tuti.png",
	"../res/img/map/field/width32/umi.png",
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

static const char *foresttown[] = {
	"../res/img/map/build/tree32/BrightForest.png"
	"../res/img/map/build/tree32/TownBF.png"
	"../res/img/map/build/tree32/TownBF2.png"
	"../res/img/map/build/tree32/TownForest.png"
};


static const char *tohoitem[] = {
	"../res/img/item/toho/itemicon.png"
};


#define NUM(ary) 	  (sizeof(ary)/sizeof(ary[0]))
#define CHIP_SIZE	  ((sizeof (mapid)) / (sizeof (t_mapid)))
#define CHIP_INFO	  ((sizeof (mapinfo)) / (sizeof (t_mapinfo)))
#define FIELDMAP_SIZE ((sizeof (fieldmap)) / (sizeof (t_fieldmap)))
#define BUILD_SIZE    ((sizeof (buildinfo)) / (sizeof (t_buildinfo)))
#define MSGBOX_SIZE      ((sizeof (msgbox)) / (sizeof (t_msgbox)))


/**-------------------------------------------------
 * プレイ画面の大きさを指定
 * -------------------------------------------------
 * SCREEN_WIDTH	  :	windowの幅
 * SCREEN_HEIGHTY :	windowの高さを指定
 * -------------------------------------------------*/
#define SCREEN_WIDTH	640
#define SCREEN_HEIGHT	480	


/**-------------------------------------------------
 * プレイ画面に対して、1マスを幾つ配置可能か計算
 * -------------------------------------------------
 * MAP_DRAW_WIDTH :	幅のループ回数、マップの基本幅
 * MAP_DRAW_HEIGH :	高さのループ回数、マップの基本高さ
 * -------------------------------------------------*/
#define MAP_DRAW_WIDTH	(SCREEN_WIDTH >> MAP_SIZE_SHIFT)
#define MAP_DRAW_HEIGHT	(SCREEN_HEIGHT >> MAP_SIZE_SHIFT)


/**-------------------------------------------------
 * 縦横1マスに使用する描画pixel数を指定
 * -------------------------------------------------*/
#define GRID_SIZE		32
#define MAP_SIZE_SHIFT	5	//5bitシフトすれば32


/**-------------------------------------------------
 * メッセージウィンドウの大きさ指定
 * -------------------------------------------------
 * MSG_FLAME_SIZE :	msgwindowの白枠のサイズ
 * MSG_WINDOW_SIZE: メッセージウィンドウの大きさ
 * -------------------------------------------------*/
#define MSG_FLAME_SIZE	10
#define MSG_WINDOW_SIZE 140


/**-------------------------------------------------
 * マップチップの1マス分の大きさを指定
 * -------------------------------------------------*/
#define MAPCHIP_SIZE	32


/**-------------------------------------------------
 * プレイヤー情報
 * -------------------------------------------------
 * UNIT_WIDTH :	使用素材の1マス分の幅を指定
 * UNIT_HEIGHT:	使用素材の1マス分の高さを指定
 * -------------------------------------------------*/
#define UNIT_WIDTH		24
#define UNIT_HEIGHT		32


/**-------------------------------------------------
 * フォントサイズ
 * -------------------------------------------------*/
#define FONT_SIZE		12


/**-------------------------------------------------
 * FPS数
 * -------------------------------------------------
 * ANIMATION_FPS:	最低値1 最高値GRID_SIZEまでの値を設定
 * 					この値を上げると移動アニメーションが増える
 *
 * FPS_INTERVAL :	GRID_SIZEに対するアニメーション数の増え幅
 * 					glidsize/fps = pixelずつ増えるアニメーションを行う
 * -------------------------------------------------*/
#define ANIMATION_FPS	1
#define FPS_INTERVAL	(GRID_SIZE/ANIMATION_FPS)


/**-------------------------------------------------
 * フレームバッファのサイズ指定
 * -------------------------------------------------*/
#define MAP_FOLD_WIDTH	50
#define MAP_FOLD_HEIGHT	50


/**-------------------------------------------------
 * フィールド開始ID
 * -------------------------------------------------*/
#define START_MAP		0


/**-------------------------------------------------
 * ワールドマップ名
 * -------------------------------------------------*/
#define WORLD_MAP_START (START_MAP)
#define WORLD_MAP_FRONT (WORLD_MAP_START + 0)
#define WORLD_MAP_BACK	(WORLD_MAP_START + 1)
#define WORLD_MAP_END	(WORLD_MAP_BACK)


/**-------------------------------------------------
 * 町名
 * -------------------------------------------------*/
#define BUILD_START		(WORLD_MAP_END + 1)
#define BUILD_FOREST	(BUILD_START)
#define BUILD_FOREST2	(BUILD_START + 1)
#define BUILD_END		(BUILD_FOREST2)


/**-------------------------------------------------
 * フィールド終了ID
 * -------------------------------------------------*/
#define END_MAP			(BUILD_END)


/**-------------------------------------------------
 * マップ作成用define定義
 * startとendに指定したマップを作成する
 * -------------------------------------------------
 * MAP_BUILD_START:上記の_STARTを指定
 * MAP_BUILD_END  :上記の_ENDを指定
 * -------------------------------------------------*/
#define	MAP_BUILD_START	(START_MAP)
#define MAP_BUILD_END	(END_MAP)


/**-------------------------------------------------
 * マップチップ選択
 * -------------------------------------------------*/
#define MAPCHIP_START	(START_CHIPID)
#define MAPCHIP_END		(END_CHIPID)


/**-------------------------------------------------
 * フレームバッファID定義
 * -------------------------------------------------*/
typedef enum {
	MAPSAME,
	MAPTWO,
	MAPTHREE,
	MAPFOUR,
	MAPFIVE,
	MAPSIX,
} T_FRAMEBUFFER_ID;


/**-------------------------------------------------
 * 移動番号定義
 * -------------------------------------------------*/
typedef enum {
	RIGHT,
	UP,
	DOWN,
	LEFT,
	NON,
} MOVE_ID;


/**-------------------------------------------------
 * メッセージIDを定義
 * -------------------------------------------------*/
typedef enum {
	NULLWRITE,
	DATAWRITE,
	DATAREAD,
	MAXMSG,
} MSG;


/**-------------------------------------------------
 * マップチップの切り取り座標と当たり判定を確保
 * -------------------------------------------------
 * arg1: id		一つの要素数のID
 * arg2: xpos	開始xpixelを指定
 * arg3: ypos	開始ypixelを指定
 * arg4: direct	当たり判定の有無を指定、1.有 0.無
 * -------------------------------------------------*/
typedef struct {
	uint32_t id;
	uint32_t xpos;
	uint32_t ypos;
	uint8_t direct;	
} t_mapid;

static const t_mapid mapid[] = {
	{	STANDERD_MAP0,     0,    0,  0  },	//草原
	{	STANDERD_MAP1,    32,    0,  0  },
	{	STANDERD_MAP2,    64,    0,  0  },
	{	STANDERD_MAP3,    96,    0,  0  },
	{	STANDERD_MAP4,   128,    0,  0  },
	{	STANDERD_MAP5,   160,    0,  0  },
	{	STANDERD_MAP6,   192,    0,  0  },
	{	STANDERD_MAP7,   224,    0,  0  },
	{	STANDERD_MAP8,     0,   32,  0  },	//木
	{	STANDERD_MAP9,    32,   32,  0  },	//木々
	{	STANDERD_MAP10,   64,   32,  1  },	//大きい木
	{	STANDERD_MAP11,   96,   32,  1  },	//岩
	{	STANDERD_MAP12,  128,   32,  1  },	//砕けそうな岩
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
	{	BRIGHT0,    0,    0,  1  },
	{	BRIGHT1,   32,    0,  1  },
	{	BRIGHT2,   64,    0,  1  },
	{	BRIGHT3,   96,    0,  1  },
	{	BRIGHT4,  128,    0,  1  },
	{	BRIGHT5,  160,    0,  1  },
	{	BRIGHT6,  192,    0,  0  },
	{	BRIGHT7,  224,    0,  0  },
	{	BRIGHT8,  256,    0,  1  },
	{	BRIGHT9,  288,    0,  1  },
	{	BRIGHT10,  320,    0,  1  },
	{	BRIGHT11,  352,    0,  1  },
	{	BRIGHT12,  384,    0,  1  },
	{	BRIGHT13,  416,    0,  1  },
	{	BRIGHT14,  448,    0,  1  },
	{	BRIGHT15,  480,    0,  1  },
	{	BRIGHT16,    0,   32,  1  },
	{	BRIGHT17,   32,   32,  1  },
	{	BRIGHT18,   64,   32,  1  },
	{	BRIGHT19,   96,   32,  1  },
	{	BRIGHT20,  128,   32,  1  },
	{	BRIGHT21,  160,   32,  1  },
	{	BRIGHT22,  192,   32,  0  },
	{	BRIGHT23,  224,   32,  0  },
	{	BRIGHT24,  256,   32,  1  },
	{	BRIGHT25,  288,   32,  1  },
	{	BRIGHT26,  320,   32,  1  },
	{	BRIGHT27,  352,   32,  1  },
	{	BRIGHT28,  384,   32,  1  },
	{	BRIGHT29,  416,   32,  1  },
	{	BRIGHT30,  448,   32,  1  },
	{	BRIGHT31,  480,   32,  1  },
	{	BRIGHT32,    0,   64,  0  },
	{	BRIGHT33,   32,   64,  0  },
	{	BRIGHT34,   64,   64,  0  },
	{	BRIGHT35,   96,   64,  0  },
	{	BRIGHT36,  128,   64,  0  },
	{	BRIGHT37,  160,   64,  0  },
	{	BRIGHT38,  192,   64,  0  },
	{	BRIGHT39,  224,   64,  0  },
	{	BRIGHT40,  256,   64,  1  },
	{	BRIGHT41,  288,   64,  1  },
	{	BRIGHT42,  320,   64,  1  },
	{	BRIGHT43,  352,   64,  1  },
	{	BRIGHT44,  384,   64,  1  },
	{	BRIGHT45,  416,   64,  1  },
	{	BRIGHT46,  448,   64,  1  },
	{	BRIGHT47,  480,   64,  1  },
	{	BRIGHT48,    0,   96,  0  },
	{	BRIGHT49,   32,   96,  0  },
	{	BRIGHT50,   64,   96,  0  },
	{	BRIGHT51,   96,   96,  0  },
	{	BRIGHT52,  128,   96,  0  },
	{	BRIGHT53,  160,   96,  0  },
	{	BRIGHT54,  192,   96,  1  },
	{	BRIGHT55,  224,   96,  1  },
	{	BRIGHT56,  256,   96,  1  },
	{	BRIGHT57,  288,   96,  1  },
	{	BRIGHT58,  320,   96,  1  },
	{	BRIGHT59,  352,   96,  1  },
	{	BRIGHT60,  384,   96,  1  },
	{	BRIGHT61,  416,   96,  1  },
	{	BRIGHT62,  448,   96,  1  },
	{	BRIGHT63,  480,   96,  1  },
	{	BRIGHT64,    0,  128,  0  },
	{	BRIGHT65,   32,  128,  0  },
	{	BRIGHT66,   64,  128,  0  },
	{	BRIGHT67,   96,  128,  0  },
	{	BRIGHT68,  128,  128,  0  },
	{	BRIGHT69,  160,  128,  0  },
	{	BRIGHT70,  192,  128,  1  },
	{	BRIGHT71,  224,  128,  1  },
	{	BRIGHT72,  256,  128,  1  },
	{	BRIGHT73,  288,  128,  1  },
	{	BRIGHT74,  320,  128,  1  },
	{	BRIGHT75,  352,  128,  1  },
	{	BRIGHT76,  384,  128,  1  },
	{	BRIGHT77,  416,  128,  1  },
	{	BRIGHT78,  448,  128,  1  },
	{	BRIGHT79,  480,  128,  1  },
	{	BRIGHT80,    0,  160,  1  },
	{	BRIGHT81,   32,  160,  1  },
	{	BRIGHT82,   64,  160,  1  },
	{	BRIGHT83,   96,  160,  1  },
	{	BRIGHT84,  128,  160,  1  },
	{	BRIGHT85,  160,  160,  1  },
	{	BRIGHT86,  192,  160,  1  },
	{	BRIGHT87,  224,  160,  1  },
	{	BRIGHT88,  256,  160,  1  },
	{	BRIGHT89,  288,  160,  1  },
	{	BRIGHT90,  320,  160,  1  },
	{	BRIGHT91,  352,  160,  1  },
	{	BRIGHT92,  384,  160,  1  },
	{	BRIGHT93,  416,  160,  1  },
	{	BRIGHT94,  448,  160,  1  },
	{	BRIGHT95,  480,  160,  1  },
	{	BRIGHT96,    0,  192,  1  },
	{	BRIGHT97,   32,  192,  1  },
	{	BRIGHT98,   64,  192,  1  },
	{	BRIGHT99,   96,  192,  1  },
	{	BRIGHT100,  128,  192,  1  },
	{	BRIGHT101,  160,  192,  1  },
	{	BRIGHT102,  192,  192,  1  },
	{	BRIGHT103,  224,  192,  1  },
	{	BRIGHT104,  256,  192,  1  },
	{	BRIGHT105,  288,  192,  1  },
	{	BRIGHT106,  320,  192,  1  },
	{	BRIGHT107,  352,  192,  1  },
	{	BRIGHT108,  384,  192,  1  },
	{	BRIGHT109,  416,  192,  1  },
	{	BRIGHT110,  448,  192,  1  },
	{	BRIGHT111,  480,  192,  1  },
	{	BRIGHT112,    0,  224,  1  },
	{	BRIGHT113,   32,  224,  1  },
	{	BRIGHT114,   64,  224,  1  },
	{	BRIGHT115,   96,  224,  1  },
	{	BRIGHT116,  128,  224,  1  },
	{	BRIGHT117,  160,  224,  1  },
	{	BRIGHT118,  192,  224,  1  },
	{	BRIGHT119,  224,  224,  1  },
	{	BRIGHT120,  256,  224,  1  },
	{	BRIGHT121,  288,  224,  1  },
	{	BRIGHT122,  320,  224,  1  },
	{	BRIGHT123,  352,  224,  1  },
	{	BRIGHT124,  384,  224,  1  },
	{	BRIGHT125,  416,  224,  1  },
	{	BRIGHT126,  448,  224,  1  },
	{	BRIGHT127,  480,  224,  1  },
	{	BRIGHT128,    0,  256,  1  },
	{	BRIGHT129,   32,  256,  1  },
	{	BRIGHT130,   64,  256,  1  },
	{	BRIGHT131,   96,  256,  1  },
	{	BRIGHT132,  128,  256,  1  },
	{	BRIGHT133,  160,  256,  1  },
	{	BRIGHT134,  192,  256,  1  },
	{	BRIGHT135,  224,  256,  1  },
	{	BRIGHT136,  256,  256,  1  },
	{	BRIGHT137,  288,  256,  1  },
	{	BRIGHT138,  320,  256,  1  },
	{	BRIGHT139,  352,  256,  1  },
	{	BRIGHT140,  384,  256,  1  },
	{	BRIGHT141,  416,  256,  1  },
	{	BRIGHT142,  448,  256,  1  },
	{	BRIGHT143,  480,  256,  1  },
	{	BRIGHT144,    0,  288,  1  },
	{	BRIGHT145,   32,  288,  1  },
	{	BRIGHT146,   64,  288,  1  },
	{	BRIGHT147,   96,  288,  1  },
	{	BRIGHT148,  128,  288,  1  },
	{	BRIGHT149,  160,  288,  1  },
	{	BRIGHT150,  192,  288,  1  },
	{	BRIGHT151,  224,  288,  1  },
	{	BRIGHT152,  256,  288,  1  },
	{	BRIGHT153,  288,  288,  1  },
	{	BRIGHT154,  320,  288,  1  },
	{	BRIGHT155,  352,  288,  1  },
	{	BRIGHT156,  384,  288,  1  },
	{	BRIGHT157,  416,  288,  1  },
	{	BRIGHT158,  448,  288,  1  },
	{	BRIGHT159,  480,  288,  1  },
	{	BRIGHT160,    0,  320,  1  },
	{	BRIGHT161,   32,  320,  1  },
	{	BRIGHT162,   64,  320,  1  },
	{	BRIGHT163,   96,  320,  1  },
	{	BRIGHT164,  128,  320,  1  },
	{	BRIGHT165,  160,  320,  1  },
	{	BRIGHT166,  192,  320,  1  },
	{	BRIGHT167,  224,  320,  1  },
	{	BRIGHT168,  256,  320,  1  },
	{	BRIGHT169,  288,  320,  1  },
	{	BRIGHT170,  320,  320,  1  },
	{	BRIGHT171,  352,  320,  1  },
	{	BRIGHT172,  384,  320,  1  },
	{	BRIGHT173,  416,  320,  1  },
	{	BRIGHT174,  448,  320,  1  },
	{	BRIGHT175,  480,  320,  1  },
	{	BRIGHT176,    0,  352,  1  },
	{	BRIGHT177,   32,  352,  1  },
	{	BRIGHT178,   64,  352,  1  },
	{	BRIGHT179,   96,  352,  1  },
	{	BRIGHT180,  128,  352,  1  },
	{	BRIGHT181,  160,  352,  1  },
	{	BRIGHT182,  192,  352,  1  },
	{	BRIGHT183,  224,  352,  1  },
	{	BRIGHT184,  256,  352,  1  },
	{	BRIGHT185,  288,  352,  1  },
	{	BRIGHT186,  320,  352,  1  },
	{	BRIGHT187,  352,  352,  1  },
	{	BRIGHT188,  384,  352,  1  },
	{	BRIGHT189,  416,  352,  1  },
	{	BRIGHT190,  448,  352,  1  },
	{	BRIGHT191,  480,  352,  1  },
	{	TOWNBF0,    0,    0,  0  },
	{	TOWNBF1,   32,    0,  0  },
	{	TOWNBF2,   64,    0,  0  },
	{	TOWNBF3,   96,    0,  0  },
	{	TOWNBF4,  128,    0,  0  },
	{	TOWNBF5,  160,    0,  0  },
	{	TOWNBF6,  192,    0,  0  },
	{	TOWNBF7,  224,    0,  0  },
	{	TOWNBF8,  256,    0,  0  },
	{	TOWNBF9,  288,    0,  0  },
	{	TOWNBF10,  320,    0,  0  },
	{	TOWNBF11,  352,    0,  0  },
	{	TOWNBF12,  384,    0,  0  },
	{	TOWNBF13,  416,    0,  0  },
	{	TOWNBF14,  448,    0,  0  },
	{	TOWNBF15,  480,    0,  0  },
	{	TOWNBF16,    0,   32,  0  },
	{	TOWNBF17,   32,   32,  0  },
	{	TOWNBF18,   64,   32,  0  },
	{	TOWNBF19,   96,   32,  0  },
	{	TOWNBF20,  128,   32,  0  },
	{	TOWNBF21,  160,   32,  0  },
	{	TOWNBF22,  192,   32,  0  },
	{	TOWNBF23,  224,   32,  0  },
	{	TOWNBF24,  256,   32,  0  },
	{	TOWNBF25,  288,   32,  0  },
	{	TOWNBF26,  320,   32,  0  },
	{	TOWNBF27,  352,   32,  0  },
	{	TOWNBF28,  384,   32,  0  },
	{	TOWNBF29,  416,   32,  0  },
	{	TOWNBF30,  448,   32,  0  },
	{	TOWNBF31,  480,   32,  0  },
	{	TOWNBF32,    0,   64,  0  },
	{	TOWNBF33,   32,   64,  0  },
	{	TOWNBF34,   64,   64,  0  },
	{	TOWNBF35,   96,   64,  0  },
	{	TOWNBF36,  128,   64,  0  },
	{	TOWNBF37,  160,   64,  0  },
	{	TOWNBF38,  192,   64,  0  },
	{	TOWNBF39,  224,   64,  0  },
	{	TOWNBF40,  256,   64,  0  },
	{	TOWNBF41,  288,   64,  0  },
	{	TOWNBF42,  320,   64,  0  },
	{	TOWNBF43,  352,   64,  0  },
	{	TOWNBF44,  384,   64,  0  },
	{	TOWNBF45,  416,   64,  0  },
	{	TOWNBF46,  448,   64,  0  },
	{	TOWNBF47,  480,   64,  0  },
	{	TOWNBF48,    0,   96,  0  },
	{	TOWNBF49,   32,   96,  0  },
	{	TOWNBF50,   64,   96,  0  },
	{	TOWNBF51,   96,   96,  0  },
	{	TOWNBF52,  128,   96,  0  },
	{	TOWNBF53,  160,   96,  0  },
	{	TOWNBF54,  192,   96,  0  },
	{	TOWNBF55,  224,   96,  0  },
	{	TOWNBF56,  256,   96,  0  },
	{	TOWNBF57,  288,   96,  0  },
	{	TOWNBF58,  320,   96,  0  },
	{	TOWNBF59,  352,   96,  0  },
	{	TOWNBF60,  384,   96,  1  },	//白い柵一本
	{	TOWNBF61,  416,   96,  1  },	//白い柵連結
	{	TOWNBF62,  448,   96,  1  },	//木の柵一本
	{	TOWNBF63,  480,   96,  1  },	//木の柵連結
	{	TOWNBF64,    0,  128,  0  },
	{	TOWNBF65,   32,  128,  0  },
	{	TOWNBF66,   64,  128,  0  },
	{	TOWNBF67,   96,  128,  0  },
	{	TOWNBF68,  128,  128,  0  },
	{	TOWNBF69,  160,  128,  0  },
	{	TOWNBF70,  192,  128,  0  },
	{	TOWNBF71,  224,  128,  0  },
	{	TOWNBF72,  256,  128,  0  },
	{	TOWNBF73,  288,  128,  0  },
	{	TOWNBF74,  320,  128,  0  },
	{	TOWNBF75,  352,  128,  0  },
	{	TOWNBF76,  384,  128,  1  },	//白い柵複合1
	{	TOWNBF77,  416,  128,  1  },	//白い柵複合2
	{	TOWNBF78,  448,  128,  1  },	//木の柵複合1
	{	TOWNBF79,  480,  128,  1  },	//木の柵複合2
	{	TOWNBF80,    0,  160,  0  },
	{	TOWNBF81,   32,  160,  0  },
	{	TOWNBF82,   64,  160,  0  },
	{	TOWNBF83,   96,  160,  0  },
	{	TOWNBF84,  128,  160,  0  },
	{	TOWNBF85,  160,  160,  0  },
	{	TOWNBF86,  192,  160,  0  },
	{	TOWNBF87,  224,  160,  0  },
	{	TOWNBF88,  256,  160,  0  },
	{	TOWNBF89,  288,  160,  0  },
	{	TOWNBF90,  320,  160,  0  },
	{	TOWNBF91,  352,  160,  0  },
	{	TOWNBF92,  384,  160,  1  },	//白い柵複合3
	{	TOWNBF93,  416,  160,  1  },	//白い柵複合4
	{	TOWNBF94,  448,  160,  1  },	//木の柵複合3
	{	TOWNBF95,  480,  160,  1  },	//木の柵複合4
	{	TOWNBF96,    0,  192,  1  },	//花壇1
	{	TOWNBF97,   32,  192,  1  },	//花壇2
	{	TOWNBF98,   64,  192,  0  },
	{	TOWNBF99,   96,  192,  0  },
	{	TOWNBF100,  128,  192,  0  },
	{	TOWNBF101,  160,  192,  0  },
	{	TOWNBF102,  192,  192,  0  },
	{	TOWNBF103,  224,  192,  0  },
	{	TOWNBF104,  256,  192,  0  },
	{	TOWNBF105,  288,  192,  0  },
	{	TOWNBF106,  320,  192,  0  },
	{	TOWNBF107,  352,  192,  0  },
	{	TOWNBF108,  384,  192,  0  },
	{	TOWNBF109,  416,  192,  0  },
	{	TOWNBF110,  448,  192,  0  },
	{	TOWNBF111,  480,  192,  0  },
	{	TOWNBF112,    0,  224,  1  },	//花壇3
	{	TOWNBF113,   32,  224,  1  },	//花壇4
	{	TOWNBF114,   64,  224,  0  },
	{	TOWNBF115,   96,  224,  0  },
	{	TOWNBF116,  128,  224,  0  },
	{	TOWNBF117,  160,  224,  0  },
	{	TOWNBF118,  192,  224,  0  },
	{	TOWNBF119,  224,  224,  0  },
	{	TOWNBF120,  256,  224,  0  },
	{	TOWNBF121,  288,  224,  0  },
	{	TOWNBF122,  320,  224,  0  },
	{	TOWNBF123,  352,  224,  0  },
	{	TOWNBF124,  384,  224,  0  },
	{	TOWNBF125,  416,  224,  0  },
	{	TOWNBF126,  448,  224,  0  },
	{	TOWNBF127,  480,  224,  0  },
	{	TOWNBF128,    0,  256,  1  },	//花壇5
	{	TOWNBF129,   32,  256,  1  },	//花壇6
	{	TOWNBF130,   64,  256,  0  },
	{	TOWNBF131,   96,  256,  0  },
	{	TOWNBF132,  128,  256,  0  },
	{	TOWNBF133,  160,  256,  0  },
	{	TOWNBF134,  192,  256,  0  },
	{	TOWNBF135,  224,  256,  0  },
	{	TOWNBF136,  256,  256,  0  },
	{	TOWNBF137,  288,  256,  0  },
	{	TOWNBF138,  320,  256,  0  },
	{	TOWNBF139,  352,  256,  0  },
	{	TOWNBF140,  384,  256,  0  },
	{	TOWNBF141,  416,  256,  0  },
	{	TOWNBF142,  448,  256,  0  },
	{	TOWNBF143,  480,  256,  0  },
	{	TOWNBF144,    0,  288,  0  },
	{	TOWNBF145,   32,  288,  0  },
	{	TOWNBF146,   64,  288,  0  },
	{	TOWNBF147,   96,  288,  0  },
	{	TOWNBF148,  128,  288,  0  },
	{	TOWNBF149,  160,  288,  0  },
	{	TOWNBF150,  192,  288,  0  },
	{	TOWNBF151,  224,  288,  0  },
	{	TOWNBF152,  256,  288,  1  },	//花束1
	{	TOWNBF153,  288,  288,  1  },	//花束2
	{	TOWNBF154,  320,  288,  1  },	//花束3
	{	TOWNBF155,  352,  288,  1  },	//花束4
	{	TOWNBF156,  384,  288,  0  },
	{	TOWNBF157,  416,  288,  0  },
	{	TOWNBF158,  448,  288,  0  },
	{	TOWNBF159,  480,  288,  0  },
	{	TOWNBF160,    0,  320,  0  },
	{	TOWNBF161,   32,  320,  0  },
	{	TOWNBF162,   64,  320,  0  },
	{	TOWNBF163,   96,  320,  0  },
	{	TOWNBF164,  128,  320,  0  },
	{	TOWNBF165,  160,  320,  0  },
	{	TOWNBF166,  192,  320,  0  },
	{	TOWNBF167,  224,  320,  0  },
	{	TOWNBF168,  256,  320,  1  },	//花束5
	{	TOWNBF169,  288,  320,  1  },	//花束6
	{	TOWNBF170,  320,  320,  1  },	//花束7
	{	TOWNBF171,  352,  320,  1  },	//花束8
	{	TOWNBF172,  384,  320,  0  },
	{	TOWNBF173,  416,  320,  0  },
	{	TOWNBF174,  448,  320,  0  },
	{	TOWNBF175,  480,  320,  0  },
	{	TOWNBF176,    0,  352,  0  },
	{	TOWNBF177,   32,  352,  0  },
	{	TOWNBF178,   64,  352,  0  },
	{	TOWNBF179,   96,  352,  0  },
	{	TOWNBF180,  128,  352,  0  },
	{	TOWNBF181,  160,  352,  0  },
	{	TOWNBF182,  192,  352,  0  },
	{	TOWNBF183,  224,  352,  0  },
	{	TOWNBF184,  256,  352,  1  },	//花束9
	{	TOWNBF185,  288,  352,  1  },	//花束10
	{	TOWNBF186,  320,  352,  1  },	//花束11
	{	TOWNBF187,  352,  352,  1  },	//花束12
	{	TOWNBF188,  384,  352,  0  },
	{	TOWNBF189,  416,  352,  0  },
	{	TOWNBF190,  448,  352,  0  },
	{	TOWNBF191,  480,  352,  0  },
	{	TOWN_ITEM0,    0,    0,  0  },
	{	TOWN_ITEM1,   32,    0,  0  },
	{	TOWN_ITEM2,   64,    0,  0  },
	{	TOWN_ITEM3,   96,    0,  0  },
	{	TOWN_ITEM4,  128,    0,  0  },
	{	TOWN_ITEM5,  160,    0,  1  },
	{	TOWN_ITEM6,  192,    0,  1  },
	{	TOWN_ITEM7,  224,    0,  1  },
	{	TOWN_ITEM8,  256,    0,  1  },
	{	TOWN_ITEM9,  288,    0,  1  },
	{	TOWN_ITEM10,  320,    0,  1  },
	{	TOWN_ITEM11,  352,    0,  1  },
	{	TOWN_ITEM12,  384,    0,  1  },
	{	TOWN_ITEM13,  416,    0,  1  },
	{	TOWN_ITEM14,  448,    0,  1  },
	{	TOWN_ITEM15,  480,    0,  1  },
	{	TOWN_ITEM16,    0,   32,  1  },
	{	TOWN_ITEM17,   32,   32,  1  },
	{	TOWN_ITEM18,   64,   32,  0  },
	{	TOWN_ITEM19,   96,   32,  0  },
	{	TOWN_ITEM20,  128,   32,  0  },
	{	TOWN_ITEM21,  160,   32,  1  },
	{	TOWN_ITEM22,  192,   32,  1  },
	{	TOWN_ITEM23,  224,   32,  1  },
	{	TOWN_ITEM24,  256,   32,  1  },
	{	TOWN_ITEM25,  288,   32,  1  },
	{	TOWN_ITEM26,  320,   32,  1  },
	{	TOWN_ITEM27,  352,   32,  1  },
	{	TOWN_ITEM28,  384,   32,  1  },
	{	TOWN_ITEM29,  416,   32,  1  },
	{	TOWN_ITEM30,  448,   32,  1  },
	{	TOWN_ITEM31,  480,   32,  1  },
	{	TOWN_ITEM32,    0,   64,  0  },
	{	TOWN_ITEM33,   32,   64,  0  },
	{	TOWN_ITEM34,   64,   64,  0  },
	{	TOWN_ITEM35,   96,   64,  0  },
	{	TOWN_ITEM36,  128,   64,  0  },
	{	TOWN_ITEM37,  160,   64,  0  },
	{	TOWN_ITEM38,  192,   64,  0  },
	{	TOWN_ITEM39,  224,   64,  0  },
	{	TOWN_ITEM40,  256,   64,  1  },
	{	TOWN_ITEM41,  288,   64,  1  },
	{	TOWN_ITEM42,  320,   64,  1  },
	{	TOWN_ITEM43,  352,   64,  1  },
	{	TOWN_ITEM44,  384,   64,  1  },
	{	TOWN_ITEM45,  416,   64,  0  },
	{	TOWN_ITEM46,  448,   64,  0  },
	{	TOWN_ITEM47,  480,   64,  0  },
	{	TOWN_ITEM48,    0,   96,  0  },
	{	TOWN_ITEM49,   32,   96,  0  },
	{	TOWN_ITEM50,   64,   96,  0  },
	{	TOWN_ITEM51,   96,   96,  0  },
	{	TOWN_ITEM52,  128,   96,  0  },
	{	TOWN_ITEM53,  160,   96,  0  },
	{	TOWN_ITEM54,  192,   96,  0  },
	{	TOWN_ITEM55,  224,   96,  0  },
	{	TOWN_ITEM56,  256,   96,  1  },
	{	TOWN_ITEM57,  288,   96,  1  },
	{	TOWN_ITEM58,  320,   96,  1  },
	{	TOWN_ITEM59,  352,   96,  1  },
	{	TOWN_ITEM60,  384,   96,  1  },
	{	TOWN_ITEM61,  416,   96,  1  },
	{	TOWN_ITEM62,  448,   96,  1  },
	{	TOWN_ITEM63,  480,   96,  1  },
	{	TOWN_ITEM64,    0,  128,  0  },
	{	TOWN_ITEM65,   32,  128,  0  },
	{	TOWN_ITEM66,   64,  128,  0  },
	{	TOWN_ITEM67,   96,  128,  0  },
	{	TOWN_ITEM68,  128,  128,  0  },
	{	TOWN_ITEM69,  160,  128,  0  },
	{	TOWN_ITEM70,  192,  128,  0  },
	{	TOWN_ITEM71,  224,  128,  0  },
	{	TOWN_ITEM72,  256,  128,  1  },
	{	TOWN_ITEM73,  288,  128,  1  },
	{	TOWN_ITEM74,  320,  128,  1  },
	{	TOWN_ITEM75,  352,  128,  0  },
	{	TOWN_ITEM76,  384,  128,  0  },
	{	TOWN_ITEM77,  416,  128,  0  },
	{	TOWN_ITEM78,  448,  128,  0  },
	{	TOWN_ITEM79,  480,  128,  0  },
	{	TOWN_ITEM80,    0,  160,  0  },
	{	TOWN_ITEM81,   32,  160,  0  },
	{	TOWN_ITEM82,   64,  160,  0  },
	{	TOWN_ITEM83,   96,  160,  0  },
	{	TOWN_ITEM84,  128,  160,  0  },
	{	TOWN_ITEM85,  160,  160,  0  },
	{	TOWN_ITEM86,  192,  160,  0  },
	{	TOWN_ITEM87,  224,  160,  0  },
	{	TOWN_ITEM88,  256,  160,  1  },
	{	TOWN_ITEM89,  288,  160,  1  },
	{	TOWN_ITEM90,  320,  160,  0  },
	{	TOWN_ITEM91,  352,  160,  0  },
	{	TOWN_ITEM92,  384,  160,  0  },
	{	TOWN_ITEM93,  416,  160,  1  },
	{	TOWN_ITEM94,  448,  160,  1  },
	{	TOWN_ITEM95,  480,  160,  1  },
	{	TOWN_ITEM96,    0,  192,  1  },
	{	TOWN_ITEM97,   32,  192,  1  },
	{	TOWN_ITEM98,   64,  192,  1  },
	{	TOWN_ITEM99,   96,  192,  1  },
	{	TOWN_ITEM100,  128,  192,  1  },
	{	TOWN_ITEM101,  160,  192,  1  },
	{	TOWN_ITEM102,  192,  192,  1  },
	{	TOWN_ITEM103,  224,  192,  1  },
	{	TOWN_ITEM104,  256,  192,  0  },
	{	TOWN_ITEM105,  288,  192,  0  },
	{	TOWN_ITEM106,  320,  192,  0  },
	{	TOWN_ITEM107,  352,  192,  0  },
	{	TOWN_ITEM108,  384,  192,  0  },
	{	TOWN_ITEM109,  416,  192,  0  },
	{	TOWN_ITEM110,  448,  192,  0  },
	{	TOWN_ITEM111,  480,  192,  1  },
	{	TOWN_ITEM112,    0,  224,  1  },
	{	TOWN_ITEM113,   32,  224,  1  },
	{	TOWN_ITEM114,   64,  224,  1  },
	{	TOWN_ITEM115,   96,  224,  1  },
	{	TOWN_ITEM116,  128,  224,  0  },
	{	TOWN_ITEM117,  160,  224,  0  },
	{	TOWN_ITEM118,  192,  224,  0  },
	{	TOWN_ITEM119,  224,  224,  1  },
	{	TOWN_ITEM120,  256,  224,  1  },
	{	TOWN_ITEM121,  288,  224,  1  },
	{	TOWN_ITEM122,  320,  224,  1  },
	{	TOWN_ITEM123,  352,  224,  1  },
	{	TOWN_ITEM124,  384,  224,  0  },
	{	TOWN_ITEM125,  416,  224,  1  },
	{	TOWN_ITEM126,  448,  224,  1  },
	{	TOWN_ITEM127,  480,  224,  1  },
	{	TOWN_ITEM128,    0,  256,  1  },
	{	TOWN_ITEM129,   32,  256,  0  },
	{	TOWN_ITEM130,   64,  256,  0  },
	{	TOWN_ITEM131,   96,  256,  0  },
	{	TOWN_ITEM132,  128,  256,  0  },
	{	TOWN_ITEM133,  160,  256,  0  },
	{	TOWN_ITEM134,  192,  256,  1  },
	{	TOWN_ITEM135,  224,  256,  1  },
	{	TOWN_ITEM136,  256,  256,  1  },
	{	TOWN_ITEM137,  288,  256,  1  },
	{	TOWN_ITEM138,  320,  256,  1  },
	{	TOWN_ITEM139,  352,  256,  1  },
	{	TOWN_ITEM140,  384,  256,  0  },
	{	TOWN_ITEM141,  416,  256,  1  },
	{	TOWN_ITEM142,  448,  256,  1  },
	{	TOWN_ITEM143,  480,  256,  1  },
	{	TOWN_ITEM144,    0,  288,  1  },
	{	TOWN_ITEM145,   32,  288,  1  },
	{	TOWN_ITEM146,   64,  288,  0  },
	{	TOWN_ITEM147,   96,  288,  0  },
	{	TOWN_ITEM148,  128,  288,  0  },
	{	TOWN_ITEM149,  160,  288,  1  },
	{	TOWN_ITEM150,  192,  288,  1  },
	{	TOWN_ITEM151,  224,  288,  1  },
	{	TOWN_ITEM152,  256,  288,  1  },
	{	TOWN_ITEM153,  288,  288,  1  },
	{	TOWN_ITEM154,  320,  288,  1  },
	{	TOWN_ITEM155,  352,  288,  0  },
	{	TOWN_ITEM156,  384,  288,  0  },
	{	TOWN_ITEM157,  416,  288,  0  },
	{	TOWN_ITEM158,  448,  288,  0  },
	{	TOWN_ITEM159,  480,  288,  1  },
	{	TOWN_ITEM160,    0,  320,  0  },
	{	TOWN_ITEM161,   32,  320,  0  },
	{	TOWN_ITEM162,   64,  320,  0  },
	{	TOWN_ITEM163,   96,  320,  0  },
	{	TOWN_ITEM164,  128,  320,  0  },
	{	TOWN_ITEM165,  160,  320,  1  },
	{	TOWN_ITEM166,  192,  320,  0  },
	{	TOWN_ITEM167,  224,  320,  0  },
	{	TOWN_ITEM168,  256,  320,  1  },
	{	TOWN_ITEM169,  288,  320,  1  },
	{	TOWN_ITEM170,  320,  320,  1  },
	{	TOWN_ITEM171,  352,  320,  1  },
	{	TOWN_ITEM172,  384,  320,  1  },
	{	TOWN_ITEM173,  416,  320,  1  },
	{	TOWN_ITEM174,  448,  320,  1  },
	{	TOWN_ITEM175,  480,  320,  1  },
	{	TOWN_ITEM176,    0,  352,  1  },
	{	TOWN_ITEM177,   32,  352,  1  },
	{	TOWN_ITEM178,   64,  352,  1  },
	{	TOWN_ITEM179,   96,  352,  1  },
	{	TOWN_ITEM180,  128,  352,  1  },
	{	TOWN_ITEM181,  160,  352,  1  },
	{	TOWN_ITEM182,  192,  352,  0  },
	{	TOWN_ITEM183,  224,  352,  0  },
	{	TOWN_ITEM184,  256,  352,  1  },
	{	TOWN_ITEM185,  288,  352,  1  },
	{	TOWN_ITEM186,  320,  352,  1  },
	{	TOWN_ITEM187,  352,  352,  1  },
	{	TOWN_ITEM188,  384,  352,  1  },
	{	TOWN_ITEM189,  416,  352,  1  },
	{	TOWN_ITEM190,  448,  352,  1  },
	{	TOWN_ITEM191,  480,  352,  1  },
	{	TOWN_ITEM192,    0,  384,  1  },
	{	TOWN_ITEM193,   32,  384,  1  },
	{	TOWN_ITEM194,   64,  384,  1  },
	{	TOWN_ITEM195,   96,  384,  1  },
	{	TOWN_ITEM196,  128,  384,  1  },
	{	TOWN_ITEM197,  160,  384,  1  },
	{	TOWN_ITEM198,  192,  384,  1  },
	{	TOWN_ITEM199,  224,  384,  1  },
	{	TOWN_ITEM200,  256,  384,  1  },
	{	TOWN_ITEM201,  288,  384,  1  },
	{	TOWN_ITEM202,  320,  384,  1  },
	{	TOWN_ITEM203,  352,  384,  1  },
	{	TOWN_ITEM204,  384,  384,  1  },
	{	TOWN_ITEM205,  416,  384,  1  },
	{	TOWN_ITEM206,  448,  384,  1  },
	{	TOWN_ITEM207,  480,  384,  1  },
	{	TOWN_ITEM208,    0,  416,  0  },
	{	TOWN_ITEM209,   32,  416,  0  },
	{	TOWN_ITEM210,   64,  416,  0  },
	{	TOWN_ITEM211,   96,  416,  0  },
	{	TOWN_ITEM212,  128,  416,  0  },
	{	TOWN_ITEM213,  160,  416,  0  },
	{	TOWN_ITEM214,  192,  416,  1  },
	{	TOWN_ITEM215,  224,  416,  1  },
	{	TOWN_ITEM216,  256,  416,  1  },
	{	TOWN_ITEM217,  288,  416,  1  },
	{	TOWN_ITEM218,  320,  416,  1  },
	{	TOWN_ITEM219,  352,  416,  1  },
	{	TOWN_ITEM220,  384,  416,  1  },
	{	TOWN_ITEM221,  416,  416,  1  },
	{	TOWN_ITEM222,  448,  416,  1  },
	{	TOWN_ITEM223,  480,  416,  1  },
	{	TOWN_ITEM224,    0,  448,  0  },
	{	TOWN_ITEM225,   32,  448,  0  },
	{	TOWN_ITEM226,   64,  448,  0  },
	{	TOWN_ITEM227,   96,  448,  0  },
	{	TOWN_ITEM228,  128,  448,  0  },
	{	TOWN_ITEM229,  160,  448,  1  },
	{	TOWN_ITEM230,  192,  448,  1  },
	{	TOWN_ITEM231,  224,  448,  1  },
	{	TOWN_ITEM232,  256,  448,  1  },
	{	TOWN_ITEM233,  288,  448,  1  },
	{	TOWN_ITEM234,  320,  448,  1  },
	{	TOWN_ITEM235,  352,  448,  1  },
	{	TOWN_ITEM236,  384,  448,  1  },
	{	TOWN_ITEM237,  416,  448,  1  },
	{	TOWN_ITEM238,  448,  448,  1  },
	{	TOWN_ITEM239,  480,  448,  1  },
	{	TOWN_ITEM240,    0,  480,  0  },
	{	TOWN_ITEM241,   32,  480,  0  },
	{	TOWN_ITEM242,   64,  480,  0  },
	{	TOWN_ITEM243,   96,  480,  0  },
	{	TOWN_ITEM244,  128,  480,  0  },
	{	TOWN_ITEM245,  160,  480,  1  },
	{	TOWN_ITEM246,  192,  480,  1  },
	{	TOWN_ITEM247,  224,  480,  1  },
	{	TOWN_ITEM248,  256,  480,  0  },
	{	TOWN_ITEM249,  288,  480,  0  },
	{	TOWN_ITEM250,  320,  480,  0  },
	{	TOWN_ITEM251,  352,  480,  0  },
	{	TOWN_ITEM252,  384,  480,  0  },
	{	TOWN_ITEM253,  416,  480,  0  },
	{	TOWN_ITEM254,  448,  480,  0  },
	{	TOWN_ITEM255,  480,  480,  0  },
	{	FOREST0,    0,    0,  0  },
	{	FOREST1,   32,    0,  0  },
	{	FOREST2,   64,    0,  0  },
	{	FOREST3,   96,    0,  0  },
	{	FOREST4,  128,    0,  0  },
	{	FOREST5,  160,    0,  0  },
	{	FOREST6,  192,    0,  0  },
	{	FOREST7,  224,    0,  0  },
	{	FOREST8,  256,    0,  0  },
	{	FOREST9,  288,    0,  0  },
	{	FOREST10,  320,    0,  0  },
	{	FOREST11,  352,    0,  0  },
	{	FOREST12,  384,    0,  0  },
	{	FOREST13,  416,    0,  0  },
	{	FOREST14,  448,    0,  0  },
	{	FOREST15,  480,    0,  0  },
	{	FOREST16,    0,   32,  0  },
	{	FOREST17,   32,   32,  0  },
	{	FOREST18,   64,   32,  0  },
	{	FOREST19,   96,   32,  0  },
	{	FOREST20,  128,   32,  0  },
	{	FOREST21,  160,   32,  0  },
	{	FOREST22,  192,   32,  0  },
	{	FOREST23,  224,   32,  0  },
	{	FOREST24,  256,   32,  0  },
	{	FOREST25,  288,   32,  0  },
	{	FOREST26,  320,   32,  0  },
	{	FOREST27,  352,   32,  0  },
	{	FOREST28,  384,   32,  0  },
	{	FOREST29,  416,   32,  0  },
	{	FOREST30,  448,   32,  0  },
	{	FOREST31,  480,   32,  0  },
	{	FOREST32,    0,   64,  0  },
	{	FOREST33,   32,   64,  0  },
	{	FOREST34,   64,   64,  0  },
	{	FOREST35,   96,   64,  0  },
	{	FOREST36,  128,   64,  0  },
	{	FOREST37,  160,   64,  0  },
	{	FOREST38,  192,   64,  0  },
	{	FOREST39,  224,   64,  0  },
	{	FOREST40,  256,   64,  0  },
	{	FOREST41,  288,   64,  0  },
	{	FOREST42,  320,   64,  0  },
	{	FOREST43,  352,   64,  0  },
	{	FOREST44,  384,   64,  0  },
	{	FOREST45,  416,   64,  0  },
	{	FOREST46,  448,   64,  0  },
	{	FOREST47,  480,   64,  0  },
	{	FOREST48,    0,   96,  0  },
	{	FOREST49,   32,   96,  0  },
	{	FOREST50,   64,   96,  0  },
	{	FOREST51,   96,   96,  0  },
	{	FOREST52,  128,   96,  0  },
	{	FOREST53,  160,   96,  0  },
	{	FOREST54,  192,   96,  0  },
	{	FOREST55,  224,   96,  0  },
	{	FOREST56,  256,   96,  0  },
	{	FOREST57,  288,   96,  0  },
	{	FOREST58,  320,   96,  0  },
	{	FOREST59,  352,   96,  0  },
	{	FOREST60,  384,   96,  0  },
	{	FOREST61,  416,   96,  0  },
	{	FOREST62,  448,   96,  0  },
	{	FOREST63,  480,   96,  0  },
	{	FOREST64,    0,  128,  0  },
	{	FOREST65,   32,  128,  0  },
	{	FOREST66,   64,  128,  0  },
	{	FOREST67,   96,  128,  0  },
	{	FOREST68,  128,  128,  0  },
	{	FOREST69,  160,  128,  0  },
	{	FOREST70,  192,  128,  0  },
	{	FOREST71,  224,  128,  0  },
	{	FOREST72,  256,  128,  0  },
	{	FOREST73,  288,  128,  0  },
	{	FOREST74,  320,  128,  0  },
	{	FOREST75,  352,  128,  0  },
	{	FOREST76,  384,  128,  0  },
	{	FOREST77,  416,  128,  0  },
	{	FOREST78,  448,  128,  0  },
	{	FOREST79,  480,  128,  0  },
	{	FOREST80,    0,  160,  0  },
	{	FOREST81,   32,  160,  0  },
	{	FOREST82,   64,  160,  0  },
	{	FOREST83,   96,  160,  0  },
	{	FOREST84,  128,  160,  0  },
	{	FOREST85,  160,  160,  0  },
	{	FOREST86,  192,  160,  0  },
	{	FOREST87,  224,  160,  0  },
	{	FOREST88,  256,  160,  0  },
	{	FOREST89,  288,  160,  0  },
	{	FOREST90,  320,  160,  0  },
	{	FOREST91,  352,  160,  0  },
	{	FOREST92,  384,  160,  0  },
	{	FOREST93,  416,  160,  0  },
	{	FOREST94,  448,  160,  0  },
	{	FOREST95,  480,  160,  0  },
	{	FOREST96,    0,  192,  0  },
	{	FOREST97,   32,  192,  0  },
	{	FOREST98,   64,  192,  0  },
	{	FOREST99,   96,  192,  0  },
	{	FOREST100,  128,  192,  0  },
	{	FOREST101,  160,  192,  0  },
	{	FOREST102,  192,  192,  0  },
	{	FOREST103,  224,  192,  0  },
	{	FOREST104,  256,  192,  0  },
	{	FOREST105,  288,  192,  0  },
	{	FOREST106,  320,  192,  0  },
	{	FOREST107,  352,  192,  0  },
	{	FOREST108,  384,  192,  0  },
	{	FOREST109,  416,  192,  0  },
	{	FOREST110,  448,  192,  0  },
	{	FOREST111,  480,  192,  0  },
	{	FOREST112,    0,  224,  0  },
	{	FOREST113,   32,  224,  0  },
	{	FOREST114,   64,  224,  0  },
	{	FOREST115,   96,  224,  0  },
	{	FOREST116,  128,  224,  0  },
	{	FOREST117,  160,  224,  0  },
	{	FOREST118,  192,  224,  0  },
	{	FOREST119,  224,  224,  0  },
	{	FOREST120,  256,  224,  0  },
	{	FOREST121,  288,  224,  0  },
	{	FOREST122,  320,  224,  0  },
	{	FOREST123,  352,  224,  0  },
	{	FOREST124,  384,  224,  0  },
	{	FOREST125,  416,  224,  0  },
	{	FOREST126,  448,  224,  0  },
	{	FOREST127,  480,  224,  0  },
	{	FOREST128,    0,  256,  0  },
	{	FOREST129,   32,  256,  0  },
	{	FOREST130,   64,  256,  0  },
	{	FOREST131,   96,  256,  0  },
	{	FOREST132,  128,  256,  0  },
	{	FOREST133,  160,  256,  0  },
	{	FOREST134,  192,  256,  0  },
	{	FOREST135,  224,  256,  0  },
	{	FOREST136,  256,  256,  0  },
	{	FOREST137,  288,  256,  0  },
	{	FOREST138,  320,  256,  0  },
	{	FOREST139,  352,  256,  0  },
	{	FOREST140,  384,  256,  0  },
	{	FOREST141,  416,  256,  0  },
	{	FOREST142,  448,  256,  0  },
	{	FOREST143,  480,  256,  0  },
	{	FOREST144,    0,  288,  0  },
	{	FOREST145,   32,  288,  0  },
	{	FOREST146,   64,  288,  0  },
	{	FOREST147,   96,  288,  0  },
	{	FOREST148,  128,  288,  0  },
	{	FOREST149,  160,  288,  0  },
	{	FOREST150,  192,  288,  0  },
	{	FOREST151,  224,  288,  0  },
	{	FOREST152,  256,  288,  0  },
	{	FOREST153,  288,  288,  0  },
	{	FOREST154,  320,  288,  0  },
	{	FOREST155,  352,  288,  0  },
	{	FOREST156,  384,  288,  0  },
	{	FOREST157,  416,  288,  0  },
	{	FOREST158,  448,  288,  0  },
	{	FOREST159,  480,  288,  0  },
	{	FOREST160,    0,  320,  0  },
	{	FOREST161,   32,  320,  0  },
	{	FOREST162,   64,  320,  0  },
	{	FOREST163,   96,  320,  0  },
	{	FOREST164,  128,  320,  0  },
	{	FOREST165,  160,  320,  0  },
	{	FOREST166,  192,  320,  0  },
	{	FOREST167,  224,  320,  0  },
	{	FOREST168,  256,  320,  0  },
	{	FOREST169,  288,  320,  0  },
	{	FOREST170,  320,  320,  0  },
	{	FOREST171,  352,  320,  0  },
	{	FOREST172,  384,  320,  0  },
	{	FOREST173,  416,  320,  0  },
	{	FOREST174,  448,  320,  0  },
	{	FOREST175,  480,  320,  0  },
	{	FOREST176,    0,  352,  0  },
	{	FOREST177,   32,  352,  0  },
	{	FOREST178,   64,  352,  0  },
	{	FOREST179,   96,  352,  0  },
	{	FOREST180,  128,  352,  0  },
	{	FOREST181,  160,  352,  0  },
	{	FOREST182,  192,  352,  0  },
	{	FOREST183,  224,  352,  0  },
	{	FOREST184,  256,  352,  0  },
	{	FOREST185,  288,  352,  0  },
	{	FOREST186,  320,  352,  0  },
	{	FOREST187,  352,  352,  0  },
	{	FOREST188,  384,  352,  0  },
	{	FOREST189,  416,  352,  0  },
	{	FOREST190,  448,  352,  0  },
	{	FOREST191,  480,  352,  0  },
	{	FOREST192,    0,  384,  0  },
	{	FOREST193,   32,  384,  0  },
	{	FOREST194,   64,  384,  0  },
	{	FOREST195,   96,  384,  0  },
	{	FOREST196,  128,  384,  0  },
	{	FOREST197,  160,  384,  0  },
	{	FOREST198,  192,  384,  0  },
	{	FOREST199,  224,  384,  0  },
	{	FOREST200,  256,  384,  0  },
	{	FOREST201,  288,  384,  0  },
	{	FOREST202,  320,  384,  0  },
	{	FOREST203,  352,  384,  0  },
	{	FOREST204,  384,  384,  0  },
	{	FOREST205,  416,  384,  0  },
	{	FOREST206,  448,  384,  0  },
	{	FOREST207,  480,  384,  0  },
	{	FOREST208,    0,  416,  0  },
	{	FOREST209,   32,  416,  0  },
	{	FOREST210,   64,  416,  0  },
	{	FOREST211,   96,  416,  0  },
	{	FOREST212,  128,  416,  0  },
	{	FOREST213,  160,  416,  0  },
	{	FOREST214,  192,  416,  0  },
	{	FOREST215,  224,  416,  0  },
	{	FOREST216,  256,  416,  0  },
	{	FOREST217,  288,  416,  0  },
	{	FOREST218,  320,  416,  0  },
	{	FOREST219,  352,  416,  0  },
	{	FOREST220,  384,  416,  0  },
	{	FOREST221,  416,  416,  0  },
	{	FOREST222,  448,  416,  0  },
	{	FOREST223,  480,  416,  0  },
	{	FOREST224,    0,  448,  0  },
	{	FOREST225,   32,  448,  0  },
	{	FOREST226,   64,  448,  0  },
	{	FOREST227,   96,  448,  0  },
	{	FOREST228,  128,  448,  0  },
	{	FOREST229,  160,  448,  0  },
	{	FOREST230,  192,  448,  0  },
	{	FOREST231,  224,  448,  0  },
	{	FOREST232,  256,  448,  0  },
	{	FOREST233,  288,  448,  0  },
	{	FOREST234,  320,  448,  0  },
	{	FOREST235,  352,  448,  0  },
	{	FOREST236,  384,  448,  0  },
	{	FOREST237,  416,  448,  0  },
	{	FOREST238,  448,  448,  0  },
	{	FOREST239,  480,  448,  0  },
	{	FOREST240,    0,  480,  0  },
	{	FOREST241,   32,  480,  0  },
	{	FOREST242,   64,  480,  0  },
	{	FOREST243,   96,  480,  0  },
	{	FOREST244,  128,  480,  0  },
	{	FOREST245,  160,  480,  0  },
	{	FOREST246,  192,  480,  0  },
	{	FOREST247,  224,  480,  0  },
	{	FOREST248,  256,  480,  0  },
	{	FOREST249,  288,  480,  0  },
	{	FOREST250,  320,  480,  0  },
	{	FOREST251,  352,  480,  0  },
	{	FOREST252,  384,  480,  0  },
	{	FOREST253,  416,  480,  0  },
	{	FOREST254,  448,  480,  0  },
	{	FOREST255,  480,  480,  0  },
};


/**-------------------------------------------------
 * マップチップのデータ構造確保
 * -------------------------------------------------
 * arg1: 一つの画像データの開始ID
 * arg2: 一つの画像データの終了ID
 * arg3: 相対パスが保存されている配列の列番号を指定
 * arg4: 使用するマップチップの相対パスが保存されている配列のアドレスを指定
 * arg5: 横pixel数を指定
 * arg6: 縦pixel数を指定
 * arg7: 画像データの最大横幅を指定
 * arg8: 画像データの最大縦幅を指定
 * -------------------------------------------------*/
typedef struct {
	uint32_t startid;
	uint32_t endid;
	uint8_t select;
	char **path;
	uint32_t xpixel;
	uint32_t ypixel;
	uint32_t maxwidth;
	uint32_t maxheight;
} t_mapinfo;

static const t_mapinfo mapinfo[] = {
	{	STANDERD_S,  	 	STANDERD_E,		 0,  (char **)mappath,    32,   32,  256,  352  },
	{	SABAKU_S,	   	   	SABAKU_E,  		 1,  (char **)mappath,    32,   32,   32,  160  },
	{	TUTI_S,  		 	TUTI_E,  		 2,  (char **)mappath,    32,   32,   32,  160  },
	{	UMI_S,  		  	UMI_E,  		 3,  (char **)mappath,    32,   32,   32,  160  },
	{	BRIGHT_S,  			BRIGHT_E,		 0,  (char **)foresttown, 32,   32,  512,  384  },
	{	TOWNBF_S,  			TOWNBF_E,		 1,  (char **)foresttown, 32,   32,  512,  384  },
	{	TOWN_ITEM_S,  		TOWN_ITEM_E,  	 2,  (char **)foresttown, 32,   32,  512,  512  },
	{	FOREST_S,			FOREST_E,		 3,  (char **)foresttown, 32,   32,  512,  512  },
};


/**-------------------------------------------------
 * フレームバッファのサイズ確保
 * -------------------------------------------------
 * arg1: フレームバッファのID
 * arg2: 幅を指定
 * arg3: 高さを指定
 * -------------------------------------------------*/
typedef struct {
	uint8_t id;
	uint32_t fieldmap_width;
	uint32_t fieldmap_height;
} t_fieldmap;

static const t_fieldmap fieldmap[] = {
	{ MAPSAME,   MAP_DRAW_WIDTH,	MAP_DRAW_HEIGHT   },
	{ MAPTWO,    MAP_FOLD_WIDTH,	MAP_FOLD_HEIGHT   },
	{ MAPTHREE,  MAP_FOLD_WIDTH*2,	MAP_FOLD_HEIGHT*2 },
	{ MAPFOUR,   MAP_FOLD_WIDTH*3,	MAP_FOLD_HEIGHT*3 },
	{ MAPFIVE,   MAP_FOLD_WIDTH*4,	MAP_FOLD_HEIGHT*4 },
	{ MAPSIX,    MAP_FOLD_WIDTH*5,	MAP_FOLD_HEIGHT*5 },
};


/**-------------------------------------------------
 * フィールドマップのデータ構造確保
 * -------------------------------------------------
 * arg1: フィールドマップの名前
 * arg2: 使用するフレームバッファのID
 * arg3: マップ情報が格納されているbinファイルの相対パス
 * -------------------------------------------------*/
typedef struct {
	uint8_t mapname;
	uint8_t id;
	char *binfile;
} t_buildinfo;

static const t_buildinfo buildinfo[] = {
	{ WORLD_MAP_FRONT,  MAPSIX,  "worldmap5.bin" },
	{ WORLD_MAP_BACK,	MAPFOUR, "worldmap.bin"  },
	{ BUILD_FOREST,		MAPSAME, "Aki_Mori.bin"  },
	{ BUILD_FOREST2,	MAPTWO,  "Aki_Mori2.bin" },
};


/**-------------------------------------------------
 * メッセージウィンドウに描画する文字列の構造体確保
 * -------------------------------------------------
 * arg1:メッセージID
 * arg2:メッセージデータを格納
 * -------------------------------------------------*/
typedef struct {
	uint32_t id;
	char *msg;
} t_msgbox;

static const t_msgbox msgbox[] = {
	{ NULLWRITE, "\0",												},
	{ DATAWRITE, "データを書き込みますか はい:yキー いいえ:nキー",	},
	{ DATAREAD,  "データを読み込みますか はい:yキー いいえ:nキー",	},
};


/**-------------------------------------------------
 * const構造体を管理する構造体
 * -------------------------------------------------*/
typedef struct {
	const t_mapid		*map;
	const t_mapinfo		*imap;
	const t_fieldmap	*fmap;
	const t_buildinfo	*build;
	const t_msgbox		*msg;
} t_const_struct;

static const t_const_struct const_struct[] = {
	{mapid, mapinfo, fieldmap, buildinfo, msgbox},
};


#endif
