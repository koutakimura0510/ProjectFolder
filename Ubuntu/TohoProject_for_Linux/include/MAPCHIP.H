/**---------------------------------------------
 * MAPCHIP_H
 * ---------------------------------------------*/

#include "MAPCHIP_ID.H"


#ifndef MAPCHIP_H_
#define MAPCHIP_H_


/**-------------------------------------------------
 * マップチップの相対パスを確保
 * エラーが出ないため、ヌル文字とカンマ忘れに注意すること
 * -------------------------------------------------*/
static const char *mappath[] = {
	"./res/img/map/field/width32/map001.png",
	"./res/img/map/field/width32/umi.png",
	"\0",
};

static const char *foresttown[] = {
	"./res/img/map/build/tree32/BrightForest.png",
	"./res/img/map/build/tree32/TownBF.png",
	"./res/img/map/build/tree32/TownBF2.png",
	"./res/img/map/build/tree32/TownForest.png",
	"\0",
};

/*static const char *moveobj[] = {
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
*/

/**-------------------------------------------------
 * 構造体要素数計算
 * -------------------------------------------------*/
#define CHIP_SIZE	  ((sizeof (mapid)) / (sizeof (t_mapid)))
#define CHIP_INFO	  ((sizeof (mapinfo)) / (sizeof (t_mapinfo)))
#define FIELDMAP_SIZE ((sizeof (fieldmap)) / (sizeof (t_fieldmap)))
#define BUILD_SIZE    ((sizeof (buildinfo)) / (sizeof (t_buildinfo)))
#define MSGBOX_SIZE      ((sizeof (msgbox)) / (sizeof (t_msgbox)))


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
 * startとendに指定したマップを作成する
 * 作成したいマップを選択する
 * -------------------------------------------------
 * MAP_BUILD_START:上記の_STARTを指定
 * MAP_BUILD_END  :上記の_ENDを指定
 * -------------------------------------------------*/
#define	MAP_BUILD_START	(BUILD_START)
#define MAP_BUILD_END	(BUILD_END)


/**-------------------------------------------------
 * マップチップ選択範囲定義
 * マップ作成時に使用したいマップチップの範囲を選択する
 * -------------------------------------------------*/
#define MAPCHIP_START	(START_CHIPID)
#define MAPCHIP_END		(END_CHIPID)


/**-------------------------------------------------
 * 描画に使用する素材の開始IDを定義
 * -------------------------------------------------*/
#define WORLD_RES_ID	(STANDERD_S)
#define AKI_RES_ID		(BRIGHT_S)



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
 * メッセージIDを定義
 * -------------------------------------------------*/
typedef enum {
	NULLWRITE,
	DATAWRITE,
	DATAREAD,
	MAXMSG,
} MSG;


#ifdef DRAW_DATA

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
	uint8_t direct;	
} t_mapid;

static const t_mapid mapid[] = {
	{	STANDERD_MAP0,   0  },	//草原
	{	STANDERD_MAP1,   0  },
	{	STANDERD_MAP2,   0  },
	{	STANDERD_MAP3,   0  },
	{	STANDERD_MAP4,   0  },
	{	STANDERD_MAP5,   0  },
	{	STANDERD_MAP6,   0  },
	{	STANDERD_MAP7,   0  },
	{	STANDERD_MAP8,   0  },	//木
	{	STANDERD_MAP9,   0  },	//木々
	{	STANDERD_MAP10,  1  },	//大きい木
	{	STANDERD_MAP11,  0  },	//岩
	{	STANDERD_MAP12,  1  },	//砕けそうな岩
	{	STANDERD_MAP13,  1  },	//穴event
	{	STANDERD_MAP14,  1  },	//泉event
	{	STANDERD_MAP15,  0  },
	{	STANDERD_MAP16,  0  },
	{	STANDERD_MAP17,  0  },
	{	STANDERD_MAP18,  0  },
	{	STANDERD_MAP19,  0  },
	{	STANDERD_MAP20,  1  },	//うずしお
	{	STANDERD_MAP21,  1  },	//流砂
	{	STANDERD_MAP22,  1  },	//山の洞窟
	{	STANDERD_MAP23,  1  },	//岩の洞窟
	{	STANDERD_MAP24,  0  },
	{	STANDERD_MAP25,  0  },
	{	STANDERD_MAP26,  0  },
	{	STANDERD_MAP27,  0  },
	{	STANDERD_MAP28,  1  },	//看板
	{	STANDERD_MAP29,  1  },	//石碑
	{	STANDERD_MAP30,  1  },	//山の鳥居洞窟
	{	STANDERD_MAP31,  1  },	//岩の鳥居洞窟
	{	STANDERD_MAP32,  1  },	//大山1
	{	STANDERD_MAP33,  1  },	//大山2
	{	STANDERD_MAP34,  1  },	//山々1
	{	STANDERD_MAP35,  1  },	//山々2
	{	STANDERD_MAP36,  1  },	//火山1
	{	STANDERD_MAP37,  1  },	//火山2
	{	STANDERD_MAP38,  1  },	//火山の洞窟1
	{	STANDERD_MAP39,  1  },	//火山の洞窟2
	{	STANDERD_MAP40,  1  },	//大山3
	{	STANDERD_MAP41,  1  },	//大山4
	{	STANDERD_MAP42,  1  },	//山々3
	{	STANDERD_MAP43,  1  },	//山々4
	{	STANDERD_MAP44,  1  },	//火山3
	{	STANDERD_MAP45,  1  },	//火山4
	{	STANDERD_MAP46,  1  },	//火山の洞窟3
	{	STANDERD_MAP47,  1  },	//火山の洞窟4
	{	STANDERD_MAP48,  0  },
	{	STANDERD_MAP49,  1  },	//集落1
	{	STANDERD_MAP50,  1  },	//集落2
	{	STANDERD_MAP51,  1  },	//石の城1
	{	STANDERD_MAP52,  1  },	//石の城2
	{	STANDERD_MAP53,  1  },	//青い城1
	{	STANDERD_MAP54,  1  },	//青い城2
	{	STANDERD_MAP55,  1  },	//ほこらの洞窟
	{	STANDERD_MAP56,  1  },	//民家
	{	STANDERD_MAP57,  1  },	//城下町1
	{	STANDERD_MAP58,  1  },	//城下町2
	{	STANDERD_MAP59,  1  },	//石の城3
	{	STANDERD_MAP60,  1  },	//石の城4
	{	STANDERD_MAP61,  1  },	//青い城3
	{	STANDERD_MAP62,  1  },	//青い城4
	{	STANDERD_MAP63,  0  },
	{	STANDERD_MAP64,  1  },	//教会
	{	STANDERD_MAP65,  1  },	//町1
	{	STANDERD_MAP66,  1  },	//町2
	{	STANDERD_MAP67,  1  },	//黒い城1
	{	STANDERD_MAP68,  1  },	//黒い城2
	{	STANDERD_MAP69,  1  },	//塔1
	{	STANDERD_MAP70,  1  },	//タワー1
	{	STANDERD_MAP71,  0  },
	{	STANDERD_MAP72,  1  },	//テント
	{	STANDERD_MAP73,  1  },	//レンガの家
	{	STANDERD_MAP74,  1  },	//拠点
	{	STANDERD_MAP75,  1  },	//黒い城3
	{	STANDERD_MAP76,  1  },	//黒い城4
	{	STANDERD_MAP77,  1  },	//塔2
	{	STANDERD_MAP78,  1  },	//タワー2
	{	STANDERD_MAP79,  0  },
	{	STANDERD_MAP80,  1  },	//儀式のほこら
	{	STANDERD_MAP81,  1  },	//ピラミッド
	{	STANDERD_MAP82,  1  },	//祭壇
	{	STANDERD_MAP83,  0  },
	{	STANDERD_MAP84,  0  },
	{	STANDERD_MAP85,  0  },
	{	STANDERD_MAP86,  0  },
	{	STANDERD_MAP87,  0  },
	{	UMI0,    	     0  },
	{	UMI1,   	     0  },
	{	UMI2,   	     0  },
	{	UMI3,   	     0  },
	{	UMI4,  		     0  },
	{	UMI5,  		     0  },
	{	UMI6,    	     0  },
	{	UMI7,   	     0  },
	{	UMI8,   	     0  },
	{	UMI9,   	     0  },
	{	UMI10,  	     0  },
	{	UMI11,  	     0  },
	{	BRIGHT0,  1  },
	{	BRIGHT1,  1  },
	{	BRIGHT2,  1  },
	{	BRIGHT3,  1  },
	{	BRIGHT4,  1  },
	{	BRIGHT5,  1  },
	{	BRIGHT6,  0  },
	{	BRIGHT7,  0  },
	{	BRIGHT8,  1  },
	{	BRIGHT9,  1  },
	{	BRIGHT10, 1  },
	{	BRIGHT11, 1  },
	{	BRIGHT12, 1  },
	{	BRIGHT13, 1  },
	{	BRIGHT14, 1  },
	{	BRIGHT15, 1  },
	{	BRIGHT16, 1  },
	{	BRIGHT17, 1  },
	{	BRIGHT18, 1  },
	{	BRIGHT19, 1  },
	{	BRIGHT20, 1  },
	{	BRIGHT21, 1  },
	{	BRIGHT22, 0  },
	{	BRIGHT23, 0  },
	{	BRIGHT24, 1  },
	{	BRIGHT25, 1  },
	{	BRIGHT26, 1  },
	{	BRIGHT27, 1  },
	{	BRIGHT28, 1  },
	{	BRIGHT29, 1  },
	{	BRIGHT30, 1  },
	{	BRIGHT31, 1  },
	{	BRIGHT32, 0  },
	{	BRIGHT33, 0  },
	{	BRIGHT34, 0  },
	{	BRIGHT35, 0  },
	{	BRIGHT36, 0  },
	{	BRIGHT37, 0  },
	{	BRIGHT38, 0  },
	{	BRIGHT39, 0  },
	{	BRIGHT40, 1  },
	{	BRIGHT41, 1  },
	{	BRIGHT42, 1  },
	{	BRIGHT43, 1  },
	{	BRIGHT44, 1  },
	{	BRIGHT45, 1  },
	{	BRIGHT46, 1  },
	{	BRIGHT47, 1  },
	{	BRIGHT48, 0  },
	{	BRIGHT49, 0  },
	{	BRIGHT50, 0  },
	{	BRIGHT51, 0  },
	{	BRIGHT52, 0  },
	{	BRIGHT53, 0  },
	{	BRIGHT54, 1  },
	{	BRIGHT55, 1  },
	{	BRIGHT56, 1  },
	{	BRIGHT57, 1  },
	{	BRIGHT58, 1  },
	{	BRIGHT59, 1  },
	{	BRIGHT60, 1  },
	{	BRIGHT61, 1  },
	{	BRIGHT62, 1  },
	{	BRIGHT63, 1  },
	{	BRIGHT64, 0  },
	{	BRIGHT65, 0  },
	{	BRIGHT66, 0  },
	{	BRIGHT67, 0  },
	{	BRIGHT68, 0  },
	{	BRIGHT69, 0  },
	{	BRIGHT70, 1  },
	{	BRIGHT71, 1  },
	{	BRIGHT72, 1  },
	{	BRIGHT73, 1  },
	{	BRIGHT74, 1  },
	{	BRIGHT75, 1  },
	{	BRIGHT76, 1  },
	{	BRIGHT77, 1  },
	{	BRIGHT78, 1  },
	{	BRIGHT79, 1  },
	{	BRIGHT80, 1  },
	{	BRIGHT81, 1  },
	{	BRIGHT82, 1  },
	{	BRIGHT83, 1  },
	{	BRIGHT84, 1  },
	{	BRIGHT85, 1  },
	{	BRIGHT86, 1  },
	{	BRIGHT87, 1  },
	{	BRIGHT88, 1  },
	{	BRIGHT89, 1  },
	{	BRIGHT90, 1  },
	{	BRIGHT91, 1  },
	{	BRIGHT92, 1  },
	{	BRIGHT93, 1  },
	{	BRIGHT94, 1  },
	{	BRIGHT95, 1  },
	{	BRIGHT96, 1  },
	{	BRIGHT97, 1  },
	{	BRIGHT98, 1  },
	{	BRIGHT99, 1  },
	{	BRIGHT100,  1  },
	{	BRIGHT101,  1  },
	{	BRIGHT102,  1  },
	{	BRIGHT103,  1  },
	{	BRIGHT104,  1  },
	{	BRIGHT105,  1  },
	{	BRIGHT106,  1  },
	{	BRIGHT107,  1  },
	{	BRIGHT108,  1  },
	{	BRIGHT109,  1  },
	{	BRIGHT110,  1  },
	{	BRIGHT111,  1  },
	{	BRIGHT112,  1  },
	{	BRIGHT113,  1  },
	{	BRIGHT114,  1  },
	{	BRIGHT115,  1  },
	{	BRIGHT116,  1  },
	{	BRIGHT117,  1  },
	{	BRIGHT118,  1  },
	{	BRIGHT119,  1  },
	{	BRIGHT120,  1  },
	{	BRIGHT121,  1  },
	{	BRIGHT122,  1  },
	{	BRIGHT123,  1  },
	{	BRIGHT124,  1  },
	{	BRIGHT125,  1  },
	{	BRIGHT126,  1  },
	{	BRIGHT127,  1  },
	{	BRIGHT128,  1  },
	{	BRIGHT129,  1  },
	{	BRIGHT130,  1  },
	{	BRIGHT131,  1  },
	{	BRIGHT132,  1  },
	{	BRIGHT133,  1  },
	{	BRIGHT134,  1  },
	{	BRIGHT135,  1  },
	{	BRIGHT136,  1  },
	{	BRIGHT137,  1  },
	{	BRIGHT138,  1  },
	{	BRIGHT139,  1  },
	{	BRIGHT140,  1  },
	{	BRIGHT141,  1  },
	{	BRIGHT142,  1  },
	{	BRIGHT143,  1  },
	{	BRIGHT144,  1  },
	{	BRIGHT145,  1  },
	{	BRIGHT146,  1  },
	{	BRIGHT147,  1  },
	{	BRIGHT148,  1  },
	{	BRIGHT149,  1  },
	{	BRIGHT150,  1  },
	{	BRIGHT151,  1  },
	{	BRIGHT152,  1  },
	{	BRIGHT153,  1  },
	{	BRIGHT154,  1  },
	{	BRIGHT155,  1  },
	{	BRIGHT156,  1  },
	{	BRIGHT157,  1  },
	{	BRIGHT158,  1  },
	{	BRIGHT159,  1  },
	{	BRIGHT160,  1  },
	{	BRIGHT161,  1  },
	{	BRIGHT162,  1  },
	{	BRIGHT163,  1  },
	{	BRIGHT164,  1  },
	{	BRIGHT165,  1  },
	{	BRIGHT166,  1  },
	{	BRIGHT167,  1  },
	{	BRIGHT168,  1  },
	{	BRIGHT169,  1  },
	{	BRIGHT170,  1  },
	{	BRIGHT171,  1  },
	{	BRIGHT172,  1  },
	{	BRIGHT173,  1  },
	{	BRIGHT174,  1  },
	{	BRIGHT175,  1  },
	{	BRIGHT176,  1  },
	{	BRIGHT177,  1  },
	{	BRIGHT178,  1  },
	{	BRIGHT179,  1  },
	{	BRIGHT180,  1  },
	{	BRIGHT181,  1  },
	{	BRIGHT182,  1  },
	{	BRIGHT183,  1  },
	{	BRIGHT184,  1  },
	{	BRIGHT185,  1  },
	{	BRIGHT186,  1  },
	{	BRIGHT187,  1  },
	{	BRIGHT188,  1  },
	{	BRIGHT189,  1  },
	{	BRIGHT190,  1  },
	{	BRIGHT191,  1  },
	{	TOWNBF0,   0  },
	{	TOWNBF1,   0  },
	{	TOWNBF2,   0  },
	{	TOWNBF3,   0  },
	{	TOWNBF4,   0  },
	{	TOWNBF5,   0  },
	{	TOWNBF6,   0  },
	{	TOWNBF7,   0  },
	{	TOWNBF8,   0  },
	{	TOWNBF9,   0  },
	{	TOWNBF10,  0  },
	{	TOWNBF11,  0  },
	{	TOWNBF12,  0  },
	{	TOWNBF13,  0  },
	{	TOWNBF14,  0  },
	{	TOWNBF15,  0  },
	{	TOWNBF16,  0  },
	{	TOWNBF17,  0  },
	{	TOWNBF18,  0  },
	{	TOWNBF19,  0  },
	{	TOWNBF20,  0  },
	{	TOWNBF21,  0  },
	{	TOWNBF22,  0  },
	{	TOWNBF23,  0  },
	{	TOWNBF24,  0  },
	{	TOWNBF25,  0  },
	{	TOWNBF26,  0  },
	{	TOWNBF27,  0  },
	{	TOWNBF28,  0  },
	{	TOWNBF29,  0  },
	{	TOWNBF30,  0  },
	{	TOWNBF31,  0  },
	{	TOWNBF32,  0  },
	{	TOWNBF33,  0  },
	{	TOWNBF34,  0  },
	{	TOWNBF35,  0  },
	{	TOWNBF36,  0  },
	{	TOWNBF37,  0  },
	{	TOWNBF38,  0  },
	{	TOWNBF39,  0  },
	{	TOWNBF40,  0  },
	{	TOWNBF41,  0  },
	{	TOWNBF42,  0  },
	{	TOWNBF43,  0  },
	{	TOWNBF44,  0  },
	{	TOWNBF45,  0  },
	{	TOWNBF46,  0  },
	{	TOWNBF47,  0  },
	{	TOWNBF48,  0  },
	{	TOWNBF49,  0  },
	{	TOWNBF50,  0  },
	{	TOWNBF51,  0  },
	{	TOWNBF52,  0  },
	{	TOWNBF53,  0  },
	{	TOWNBF54,  0  },
	{	TOWNBF55,  0  },
	{	TOWNBF56,  0  },
	{	TOWNBF57,  0  },
	{	TOWNBF58,  0  },
	{	TOWNBF59,  0  },
	{	TOWNBF60,  1  },	//白い柵一本
	{	TOWNBF61,  1  },	//白い柵連結
	{	TOWNBF62,  1  },	//木の柵一本
	{	TOWNBF63,  1  },	//木の柵連結
	{	TOWNBF64,  0  },
	{	TOWNBF65,  0  },
	{	TOWNBF66,  0  },
	{	TOWNBF67,  0  },
	{	TOWNBF68,  0  },
	{	TOWNBF69,  0  },
	{	TOWNBF70,  0  },
	{	TOWNBF71,  0  },
	{	TOWNBF72,  0  },
	{	TOWNBF73,  0  },
	{	TOWNBF74,  0  },
	{	TOWNBF75,  0  },
	{	TOWNBF76,  1  },	//白い柵複合1
	{	TOWNBF77,  1  },	//白い柵複合2
	{	TOWNBF78,  1  },	//木の柵複合1
	{	TOWNBF79,  1  },	//木の柵複合2
	{	TOWNBF80,  0  },
	{	TOWNBF81,  0  },
	{	TOWNBF82,  0  },
	{	TOWNBF83,  0  },
	{	TOWNBF84,  0  },
	{	TOWNBF85,  0  },
	{	TOWNBF86,  0  },
	{	TOWNBF87,  0  },
	{	TOWNBF88,  0  },
	{	TOWNBF89,  0  },
	{	TOWNBF90,  0  },
	{	TOWNBF91,  0  },
	{	TOWNBF92,  1  },	//白い柵複合3
	{	TOWNBF93,  1  },	//白い柵複合4
	{	TOWNBF94,  1  },	//木の柵複合3
	{	TOWNBF95,  1  },	//木の柵複合4
	{	TOWNBF96,  1  },	//花壇1
	{	TOWNBF97,  1  },	//花壇2
	{	TOWNBF98,  0  },
	{	TOWNBF99,  0  },
	{	TOWNBF100, 0  },
	{	TOWNBF101, 0  },
	{	TOWNBF102, 0  },
	{	TOWNBF103, 0  },
	{	TOWNBF104, 0  },
	{	TOWNBF105, 0  },
	{	TOWNBF106, 0  },
	{	TOWNBF107, 0  },
	{	TOWNBF108, 0  },
	{	TOWNBF109, 0  },
	{	TOWNBF110, 0  },
	{	TOWNBF111, 0  },
	{	TOWNBF112, 1  },	//花壇3
	{	TOWNBF113, 1  },	//花壇4
	{	TOWNBF114, 0  },
	{	TOWNBF115, 0  },
	{	TOWNBF116, 0  },
	{	TOWNBF117, 0  },
	{	TOWNBF118, 0  },
	{	TOWNBF119, 0  },
	{	TOWNBF120, 0  },
	{	TOWNBF121, 0  },
	{	TOWNBF122, 0  },
	{	TOWNBF123, 0  },
	{	TOWNBF124, 0  },
	{	TOWNBF125, 0  },
	{	TOWNBF126, 0  },
	{	TOWNBF127, 0  },
	{	TOWNBF128, 1  },	//花壇5
	{	TOWNBF129, 1  },	//花壇6
	{	TOWNBF130, 0  },
	{	TOWNBF131, 0  },
	{	TOWNBF132, 0  },
	{	TOWNBF133, 0  },
	{	TOWNBF134, 0  },
	{	TOWNBF135, 0  },
	{	TOWNBF136, 0  },
	{	TOWNBF137, 0  },
	{	TOWNBF138, 0  },
	{	TOWNBF139, 0  },
	{	TOWNBF140, 0  },
	{	TOWNBF141, 0  },
	{	TOWNBF142, 0  },
	{	TOWNBF143, 0  },
	{	TOWNBF144, 0  },
	{	TOWNBF145, 0  },
	{	TOWNBF146, 0  },
	{	TOWNBF147, 0  },
	{	TOWNBF148, 0  },
	{	TOWNBF149, 0  },
	{	TOWNBF150, 0  },
	{	TOWNBF151, 0  },
	{	TOWNBF152, 1  },	//花束1
	{	TOWNBF153, 1  },	//花束2
	{	TOWNBF154, 1  },	//花束3
	{	TOWNBF155, 1  },	//花束4
	{	TOWNBF156, 0  },
	{	TOWNBF157, 0  },
	{	TOWNBF158, 0  },
	{	TOWNBF159, 0  },
	{	TOWNBF160, 0  },
	{	TOWNBF161, 0  },
	{	TOWNBF162, 0  },
	{	TOWNBF163, 0  },
	{	TOWNBF164, 0  },
	{	TOWNBF165, 0  },
	{	TOWNBF166, 0  },
	{	TOWNBF167, 0  },
	{	TOWNBF168, 1  },	//花束5
	{	TOWNBF169, 1  },	//花束6
	{	TOWNBF170, 1  },	//花束7
	{	TOWNBF171, 1  },	//花束8
	{	TOWNBF172, 0  },
	{	TOWNBF173, 0  },
	{	TOWNBF174, 0  },
	{	TOWNBF175, 0  },
	{	TOWNBF176, 0  },
	{	TOWNBF177, 0  },
	{	TOWNBF178, 0  },
	{	TOWNBF179, 0  },
	{	TOWNBF180, 0  },
	{	TOWNBF181, 0  },
	{	TOWNBF182, 0  },
	{	TOWNBF183, 0  },
	{	TOWNBF184, 1  },	//花束9
	{	TOWNBF185, 1  },	//花束10
	{	TOWNBF186, 1  },	//花束11
	{	TOWNBF187, 1  },	//花束12
	{	TOWNBF188, 0  },
	{	TOWNBF189, 0  },
	{	TOWNBF190, 0  },
	{	TOWNBF191, 0  },
	{	TOWN_ITEM0,  0  },
	{	TOWN_ITEM1,  0  },
	{	TOWN_ITEM2,  0  },
	{	TOWN_ITEM3,  0  },
	{	TOWN_ITEM4,  0  },
	{	TOWN_ITEM5,  1  },
	{	TOWN_ITEM6,  1  },
	{	TOWN_ITEM7,  1  },
	{	TOWN_ITEM8,  1  },
	{	TOWN_ITEM9,  1  },
	{	TOWN_ITEM10,  1  },
	{	TOWN_ITEM11,  1  },
	{	TOWN_ITEM12,  1  },
	{	TOWN_ITEM13,  1  },
	{	TOWN_ITEM14,  1  },
	{	TOWN_ITEM15,  1  },
	{	TOWN_ITEM16,  1  },
	{	TOWN_ITEM17,  1  },
	{	TOWN_ITEM18,  0  },
	{	TOWN_ITEM19,  0  },
	{	TOWN_ITEM20,  0  },
	{	TOWN_ITEM21,  1  },
	{	TOWN_ITEM22,  1  },
	{	TOWN_ITEM23,  1  },
	{	TOWN_ITEM24,  1  },
	{	TOWN_ITEM25,  1  },
	{	TOWN_ITEM26,  1  },
	{	TOWN_ITEM27,  1  },
	{	TOWN_ITEM28,  1  },
	{	TOWN_ITEM29,  1  },
	{	TOWN_ITEM30,  1  },
	{	TOWN_ITEM31,  1  },
	{	TOWN_ITEM32,  0  },
	{	TOWN_ITEM33,  0  },
	{	TOWN_ITEM34,  0  },
	{	TOWN_ITEM35,  0  },
	{	TOWN_ITEM36,  0  },
	{	TOWN_ITEM37,  0  },
	{	TOWN_ITEM38,  0  },
	{	TOWN_ITEM39,  0  },
	{	TOWN_ITEM40,  1  },
	{	TOWN_ITEM41,  1  },
	{	TOWN_ITEM42,  1  },
	{	TOWN_ITEM43,  1  },
	{	TOWN_ITEM44,  1  },
	{	TOWN_ITEM45,  0  },
	{	TOWN_ITEM46,  0  },
	{	TOWN_ITEM47,  0  },
	{	TOWN_ITEM48,  0  },
	{	TOWN_ITEM49,  0  },
	{	TOWN_ITEM50,  0  },
	{	TOWN_ITEM51,  0  },
	{	TOWN_ITEM52,  0  },
	{	TOWN_ITEM53,  0  },
	{	TOWN_ITEM54,  0  },
	{	TOWN_ITEM55,  0  },
	{	TOWN_ITEM56,  1  },
	{	TOWN_ITEM57,  1  },
	{	TOWN_ITEM58,  1  },
	{	TOWN_ITEM59,  1  },
	{	TOWN_ITEM60,  1  },
	{	TOWN_ITEM61,  1  },
	{	TOWN_ITEM62,  1  },
	{	TOWN_ITEM63,  1  },
	{	TOWN_ITEM64,  0  },
	{	TOWN_ITEM65,  0  },
	{	TOWN_ITEM66,  0  },
	{	TOWN_ITEM67,  0  },
	{	TOWN_ITEM68,  0  },
	{	TOWN_ITEM69,  0  },
	{	TOWN_ITEM70,  0  },
	{	TOWN_ITEM71,  0  },
	{	TOWN_ITEM72,  1  },
	{	TOWN_ITEM73,  1  },
	{	TOWN_ITEM74,  1  },
	{	TOWN_ITEM75,  0  },
	{	TOWN_ITEM76,  0  },
	{	TOWN_ITEM77,  0  },
	{	TOWN_ITEM78,  0  },
	{	TOWN_ITEM79,  0  },
	{	TOWN_ITEM80,  0  },
	{	TOWN_ITEM81,  0  },
	{	TOWN_ITEM82,  0  },
	{	TOWN_ITEM83,  0  },
	{	TOWN_ITEM84,  0  },
	{	TOWN_ITEM85,  0  },
	{	TOWN_ITEM86,  0  },
	{	TOWN_ITEM87,  0  },
	{	TOWN_ITEM88,  1  },
	{	TOWN_ITEM89,  1  },
	{	TOWN_ITEM90,  0  },
	{	TOWN_ITEM91,  0  },
	{	TOWN_ITEM92,  0  },
	{	TOWN_ITEM93,  1  },
	{	TOWN_ITEM94,  1  },
	{	TOWN_ITEM95,  1  },
	{	TOWN_ITEM96,  1  },
	{	TOWN_ITEM97,  1  },
	{	TOWN_ITEM98,  1  },
	{	TOWN_ITEM99,  1  },
	{	TOWN_ITEM100,  1  },
	{	TOWN_ITEM101,  1  },
	{	TOWN_ITEM102,  1  },
	{	TOWN_ITEM103,  1  },
	{	TOWN_ITEM104,  0  },
	{	TOWN_ITEM105,  0  },
	{	TOWN_ITEM106,  0  },
	{	TOWN_ITEM107,  0  },
	{	TOWN_ITEM108,  0  },
	{	TOWN_ITEM109,  0  },
	{	TOWN_ITEM110,  0  },
	{	TOWN_ITEM111,  1  },
	{	TOWN_ITEM112,  1  },
	{	TOWN_ITEM113,  1  },
	{	TOWN_ITEM114,  1  },
	{	TOWN_ITEM115,  1  },
	{	TOWN_ITEM116,  0  },
	{	TOWN_ITEM117,  0  },
	{	TOWN_ITEM118,  0  },
	{	TOWN_ITEM119,  1  },
	{	TOWN_ITEM120,  1  },
	{	TOWN_ITEM121,  1  },
	{	TOWN_ITEM122,  1  },
	{	TOWN_ITEM123,  1  },
	{	TOWN_ITEM124,  0  },
	{	TOWN_ITEM125,  1  },
	{	TOWN_ITEM126,  1  },
	{	TOWN_ITEM127,  1  },
	{	TOWN_ITEM128,  1  },
	{	TOWN_ITEM129,  0  },
	{	TOWN_ITEM130,  0  },
	{	TOWN_ITEM131,  0  },
	{	TOWN_ITEM132,  0  },
	{	TOWN_ITEM133,  0  },
	{	TOWN_ITEM134,  1  },
	{	TOWN_ITEM135,  1  },
	{	TOWN_ITEM136,  1  },
	{	TOWN_ITEM137,  1  },
	{	TOWN_ITEM138,  1  },
	{	TOWN_ITEM139,  1  },
	{	TOWN_ITEM140,  0  },
	{	TOWN_ITEM141,  1  },
	{	TOWN_ITEM142,  1  },
	{	TOWN_ITEM143,  1  },
	{	TOWN_ITEM144,  1  },
	{	TOWN_ITEM145,  1  },
	{	TOWN_ITEM146,  0  },
	{	TOWN_ITEM147,  0  },
	{	TOWN_ITEM148,  0  },
	{	TOWN_ITEM149,  1  },
	{	TOWN_ITEM150,  1  },
	{	TOWN_ITEM151,  1  },
	{	TOWN_ITEM152,  1  },
	{	TOWN_ITEM153,  1  },
	{	TOWN_ITEM154,  1  },
	{	TOWN_ITEM155,  0  },
	{	TOWN_ITEM156,  0  },
	{	TOWN_ITEM157,  0  },
	{	TOWN_ITEM158,  0  },
	{	TOWN_ITEM159,  1  },
	{	TOWN_ITEM160,  0  },
	{	TOWN_ITEM161,  0  },
	{	TOWN_ITEM162,  0  },
	{	TOWN_ITEM163,  0  },
	{	TOWN_ITEM164,  0  },
	{	TOWN_ITEM165,  1  },
	{	TOWN_ITEM166,  0  },
	{	TOWN_ITEM167,  0  },
	{	TOWN_ITEM168,  1  },
	{	TOWN_ITEM169,  1  },
	{	TOWN_ITEM170,  1  },
	{	TOWN_ITEM171,  1  },
	{	TOWN_ITEM172,  1  },
	{	TOWN_ITEM173,  1  },
	{	TOWN_ITEM174,  1  },
	{	TOWN_ITEM175,  1  },
	{	TOWN_ITEM176,  1  },
	{	TOWN_ITEM177,  1  },
	{	TOWN_ITEM178,  1  },
	{	TOWN_ITEM179,  1  },
	{	TOWN_ITEM180,  1  },
	{	TOWN_ITEM181,  1  },
	{	TOWN_ITEM182,  0  },
	{	TOWN_ITEM183,  0  },
	{	TOWN_ITEM184,  1  },
	{	TOWN_ITEM185,  1  },
	{	TOWN_ITEM186,  1  },
	{	TOWN_ITEM187,  1  },
	{	TOWN_ITEM188,  1  },
	{	TOWN_ITEM189,  1  },
	{	TOWN_ITEM190,  1  },
	{	TOWN_ITEM191,  1  },
	{	TOWN_ITEM192,  1  },
	{	TOWN_ITEM193,  1  },
	{	TOWN_ITEM194,  1  },
	{	TOWN_ITEM195,  1  },
	{	TOWN_ITEM196,  1  },
	{	TOWN_ITEM197,  1  },
	{	TOWN_ITEM198,  1  },
	{	TOWN_ITEM199,  1  },
	{	TOWN_ITEM200,  1  },
	{	TOWN_ITEM201,  1  },
	{	TOWN_ITEM202,  1  },
	{	TOWN_ITEM203,  1  },
	{	TOWN_ITEM204,  1  },
	{	TOWN_ITEM205,  1  },
	{	TOWN_ITEM206,  1  },
	{	TOWN_ITEM207,  1  },
	{	TOWN_ITEM208,  0  },
	{	TOWN_ITEM209,  0  },
	{	TOWN_ITEM210,  0  },
	{	TOWN_ITEM211,  0  },
	{	TOWN_ITEM212,  0  },
	{	TOWN_ITEM213,  0  },
	{	TOWN_ITEM214,  1  },
	{	TOWN_ITEM215,  1  },
	{	TOWN_ITEM216,  1  },
	{	TOWN_ITEM217,  1  },
	{	TOWN_ITEM218,  1  },
	{	TOWN_ITEM219,  1  },
	{	TOWN_ITEM220,  1  },
	{	TOWN_ITEM221,  1  },
	{	TOWN_ITEM222,  1  },
	{	TOWN_ITEM223,  1  },
	{	TOWN_ITEM224,  0  },
	{	TOWN_ITEM225,  0  },
	{	TOWN_ITEM226,  0  },
	{	TOWN_ITEM227,  0  },
	{	TOWN_ITEM228,  0  },
	{	TOWN_ITEM229,  1  },
	{	TOWN_ITEM230,  1  },
	{	TOWN_ITEM231,  1  },
	{	TOWN_ITEM232,  1  },
	{	TOWN_ITEM233,  1  },
	{	TOWN_ITEM234,  1  },
	{	TOWN_ITEM235,  1  },
	{	TOWN_ITEM236,  1  },
	{	TOWN_ITEM237,  1  },
	{	TOWN_ITEM238,  1  },
	{	TOWN_ITEM239,  1  },
	{	TOWN_ITEM240,  0  },
	{	TOWN_ITEM241,  0  },
	{	TOWN_ITEM242,  0  },
	{	TOWN_ITEM243,  0  },
	{	TOWN_ITEM244,  0  },
	{	TOWN_ITEM245,  1  },
	{	TOWN_ITEM246,  1  },
	{	TOWN_ITEM247,  1  },
	{	TOWN_ITEM248,  0  },
	{	TOWN_ITEM249,  0  },
	{	TOWN_ITEM250,  0  },
	{	TOWN_ITEM251,  0  },
	{	TOWN_ITEM252,  0  },
	{	TOWN_ITEM253,  0  },
	{	TOWN_ITEM254,  0  },
	{	TOWN_ITEM255,  0  },
	{	FOREST0,  0  },
	{	FOREST1,  0  },
	{	FOREST2,  0  },
	{	FOREST3,  0  },
	{	FOREST4,  0  },
	{	FOREST5,  0  },
	{	FOREST6,  0  },
	{	FOREST7,  0  },
	{	FOREST8,  0  },
	{	FOREST9,  0  },
	{	FOREST10,  0  },
	{	FOREST11,  0  },
	{	FOREST12,  0  },
	{	FOREST13,  0  },
	{	FOREST14,  0  },
	{	FOREST15,  0  },
	{	FOREST16,  0  },
	{	FOREST17,  0  },
	{	FOREST18,  0  },
	{	FOREST19,  0  },
	{	FOREST20,  0  },
	{	FOREST21,  0  },
	{	FOREST22,  0  },
	{	FOREST23,  0  },
	{	FOREST24,  0  },
	{	FOREST25,  0  },
	{	FOREST26,  0  },
	{	FOREST27,  0  },
	{	FOREST28,  0  },
	{	FOREST29,  0  },
	{	FOREST30,  0  },
	{	FOREST31,  0  },
	{	FOREST32,  0  },
	{	FOREST33,  0  },
	{	FOREST34,  0  },
	{	FOREST35,  0  },
	{	FOREST36,  0  },
	{	FOREST37,  0  },
	{	FOREST38,  0  },
	{	FOREST39,  0  },
	{	FOREST40,  0  },
	{	FOREST41,  0  },
	{	FOREST42,  0  },
	{	FOREST43,  0  },
	{	FOREST44,  0  },
	{	FOREST45,  0  },
	{	FOREST46,  0  },
	{	FOREST47,  0  },
	{	FOREST48,  0  },
	{	FOREST49,  0  },
	{	FOREST50,  0  },
	{	FOREST51,  0  },
	{	FOREST52,  0  },
	{	FOREST53,  0  },
	{	FOREST54,  0  },
	{	FOREST55,  0  },
	{	FOREST56,  0  },
	{	FOREST57,  0  },
	{	FOREST58,  0  },
	{	FOREST59,  0  },
	{	FOREST60,  0  },
	{	FOREST61,  0  },
	{	FOREST62,  0  },
	{	FOREST63,  0  },
	{	FOREST64,  0  },
	{	FOREST65,  0  },
	{	FOREST66,  0  },
	{	FOREST67,  0  },
	{	FOREST68,  0  },
	{	FOREST69,  0  },
	{	FOREST70,  0  },
	{	FOREST71,  0  },
	{	FOREST72,  0  },
	{	FOREST73,  0  },
	{	FOREST74,  0  },
	{	FOREST75,  0  },
	{	FOREST76,  0  },
	{	FOREST77,  0  },
	{	FOREST78,  0  },
	{	FOREST79,  0  },
	{	FOREST80,  0  },
	{	FOREST81,  0  },
	{	FOREST82,  0  },
	{	FOREST83,  0  },
	{	FOREST84,  0  },
	{	FOREST85,  0  },
	{	FOREST86,  0  },
	{	FOREST87,  0  },
	{	FOREST88,  0  },
	{	FOREST89,  0  },
	{	FOREST90,  0  },
	{	FOREST91,  0  },
	{	FOREST92,  0  },
	{	FOREST93,  0  },
	{	FOREST94,  0  },
	{	FOREST95,  0  },
	{	FOREST96,  0  },
	{	FOREST97,  0  },
	{	FOREST98,  0  },
	{	FOREST99,  0  },
	{	FOREST100,  0  },
	{	FOREST101,  0  },
	{	FOREST102,  0  },
	{	FOREST103,  0  },
	{	FOREST104,  0  },
	{	FOREST105,  0  },
	{	FOREST106,  0  },
	{	FOREST107,  0  },
	{	FOREST108,  0  },
	{	FOREST109,  0  },
	{	FOREST110,  0  },
	{	FOREST111,  0  },
	{	FOREST112,  0  },
	{	FOREST113,  0  },
	{	FOREST114,  0  },
	{	FOREST115,  0  },
	{	FOREST116,  0  },
	{	FOREST117,  0  },
	{	FOREST118,  0  },
	{	FOREST119,  0  },
	{	FOREST120,  0  },
	{	FOREST121,  0  },
	{	FOREST122,  0  },
	{	FOREST123,  0  },
	{	FOREST124,  0  },
	{	FOREST125,  0  },
	{	FOREST126,  0  },
	{	FOREST127,  0  },
	{	FOREST128,  0  },
	{	FOREST129,  0  },
	{	FOREST130,  0  },
	{	FOREST131,  0  },
	{	FOREST132,  0  },
	{	FOREST133,  0  },
	{	FOREST134,  0  },
	{	FOREST135,  0  },
	{	FOREST136,  0  },
	{	FOREST137,  0  },
	{	FOREST138,  0  },
	{	FOREST139,  0  },
	{	FOREST140,  0  },
	{	FOREST141,  0  },
	{	FOREST142,  0  },
	{	FOREST143,  0  },
	{	FOREST144,  0  },
	{	FOREST145,  0  },
	{	FOREST146,  0  },
	{	FOREST147,  0  },
	{	FOREST148,  0  },
	{	FOREST149,  0  },
	{	FOREST150,  0  },
	{	FOREST151,  0  },
	{	FOREST152,  0  },
	{	FOREST153,  0  },
	{	FOREST154,  0  },
	{	FOREST155,  0  },
	{	FOREST156,  0  },
	{	FOREST157,  0  },
	{	FOREST158,  0  },
	{	FOREST159,  0  },
	{	FOREST160,  0  },
	{	FOREST161,  0  },
	{	FOREST162,  0  },
	{	FOREST163,  0  },
	{	FOREST164,  0  },
	{	FOREST165,  0  },
	{	FOREST166,  0  },
	{	FOREST167,  0  },
	{	FOREST168,  0  },
	{	FOREST169,  0  },
	{	FOREST170,  0  },
	{	FOREST171,  0  },
	{	FOREST172,  0  },
	{	FOREST173,  0  },
	{	FOREST174,  0  },
	{	FOREST175,  0  },
	{	FOREST176,  0  },
	{	FOREST177,  0  },
	{	FOREST178,  0  },
	{	FOREST179,  0  },
	{	FOREST180,  0  },
	{	FOREST181,  0  },
	{	FOREST182,  0  },
	{	FOREST183,  0  },
	{	FOREST184,  0  },
	{	FOREST185,  0  },
	{	FOREST186,  0  },
	{	FOREST187,  0  },
	{	FOREST188,  0  },
	{	FOREST189,  0  },
	{	FOREST190,  0  },
	{	FOREST191,  0  },
	{	FOREST192,  0  },
	{	FOREST193,  0  },
	{	FOREST194,  0  },
	{	FOREST195,  0  },
	{	FOREST196,  0  },
	{	FOREST197,  0  },
	{	FOREST198,  0  },
	{	FOREST199,  0  },
	{	FOREST200,  0  },
	{	FOREST201,  0  },
	{	FOREST202,  0  },
	{	FOREST203,  0  },
	{	FOREST204,  0  },
	{	FOREST205,  0  },
	{	FOREST206,  0  },
	{	FOREST207,  0  },
	{	FOREST208,  0  },
	{	FOREST209,  0  },
	{	FOREST210,  0  },
	{	FOREST211,  0  },
	{	FOREST212,  0  },
	{	FOREST213,  0  },
	{	FOREST214,  0  },
	{	FOREST215,  0  },
	{	FOREST216,  0  },
	{	FOREST217,  0  },
	{	FOREST218,  0  },
	{	FOREST219,  0  },
	{	FOREST220,  0  },
	{	FOREST221,  0  },
	{	FOREST222,  0  },
	{	FOREST223,  0  },
	{	FOREST224,  0  },
	{	FOREST225,  0  },
	{	FOREST226,  0  },
	{	FOREST227,  0  },
	{	FOREST228,  0  },
	{	FOREST229,  0  },
	{	FOREST230,  0  },
	{	FOREST231,  0  },
	{	FOREST232,  0  },
	{	FOREST233,  0  },
	{	FOREST234,  0  },
	{	FOREST235,  0  },
	{	FOREST236,  0  },
	{	FOREST237,  0  },
	{	FOREST238,  0  },
	{	FOREST239,  0  },
	{	FOREST240,  0  },
	{	FOREST241,  0  },
	{	FOREST242,  0  },
	{	FOREST243,  0  },
	{	FOREST244,  0  },
	{	FOREST245,  0  },
	{	FOREST246,  0  },
	{	FOREST247,  0  },
	{	FOREST248,  0  },
	{	FOREST249,  0  },
	{	FOREST250,  0  },
	{	FOREST251,  0  },
	{	FOREST252,  0  },
	{	FOREST253,  0  },
	{	FOREST254,  0  },
	{	FOREST255,  0  },
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
	uint8_t  select;
	char 	 **path;
	uint32_t xpixel;
	uint32_t ypixel;
	uint32_t w_material;
	uint32_t h_material;
} t_mapinfo;

static const t_mapinfo mapinfo[] = {
	{STANDERD_S,  	STANDERD_E,		 0,  (char **)mappath,    32,   32,  8,  11},
	{UMI_S,  		UMI_E,  		 1,  (char **)mappath,    32,   32,  6,   2},
	{BRIGHT_S,  	BRIGHT_E,		 0,  (char **)foresttown, 32,   32, 16,  12},
	{TOWNBF_S,  	TOWNBF_E,		 1,  (char **)foresttown, 32,   32, 16,  12},
	{TOWN_ITEM_S,  	TOWN_ITEM_E,  	 2,  (char **)foresttown, 32,   32, 16,  16},
	{FOREST_S,		FOREST_E,		 3,  (char **)foresttown, 32,   32, 16,  16},
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
	uint32_t resid;
	uint32_t background;
	char *binfile;
} t_buildinfo;

static const t_buildinfo buildinfo[] = {
	{ WORLD_MAP_FRONT,  MAPSIX,  WORLD_RES_ID, STANDERD_MAP0, "./bin/Gensoukyou/worldmap5.bin" },
	{ WORLD_MAP_BACK,	MAPFOUR, WORLD_RES_ID, STANDERD_MAP0, "./bin/Gensoukyou/worldmap.bin"  },
	{ BUILD_FOREST,		MAPSAME, AKI_RES_ID,   TOWNBF0,		  "./bin/Gensoukyou/Aki_Mori.bin"  },
	{ BUILD_FOREST2,	MAPSAME, AKI_RES_ID,   TOWNBF0,		  "./bin/Gensoukyou/Aki_Mori2.bin" },
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
	{ DATAWRITE, "マップデータ 書き込み:yキー 読み込み:nキー",	},
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
#endif
