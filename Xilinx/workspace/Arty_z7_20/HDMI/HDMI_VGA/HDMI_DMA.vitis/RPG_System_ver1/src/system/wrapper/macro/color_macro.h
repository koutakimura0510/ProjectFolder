/*
 * 色データに関する定数をまとめたヘッダーファイル
 */

#ifndef color_macro_h   /* prevent circular inclusions */
#define color_macro_h   /* by using protection macros */


/*
 * 8bit色データの最大値
 */
#define COLOR_MAX_MASK	(255)


/*
 * RBGループ用定数
 */
#define COLOR_NUMBER_RBG	(3)
#define COLOR_NUMBER_ARBG	(4)


/*
 * alpha値を操作する定数
 */
#define COLOR_ALPHA_MAX	(255)
#define COLOR_ALPHA_MIN	(0)
#define COLOR_ALPHA_INC	(15)
#define COLOR_ALPHA_DEC	(5)


/*
 * 色データを管理
 * XilinxのHDMIのIPの使用上
 * A R B G の並び順で定義すること
 */
#define COLOR_BLACK         (0x00000000)	//黒
#define COLOR_LIGHT_GLAY    (0x00686868)	//暗い灰色
#define COLOR_BLACK_ADD     (0x8f020304)	//加算用黒
#define COLOR_WHITE         (0x00ffffff)	//白
#define COLOR_YELLOW		(0x00ff00ff)	//黄色
#define COLOR_GOLD			(0x00ff00d7)	//黄金色
#define COLOR_GREEN_YELLOW	(0x00ad2fff)	//黄緑
#define COLOR_GREEN_SPRING	(0x00007fff)	//エメラルド
#define COLOR_SNOW		    (0x00fffafa)	//肌色の薄い感じ
#define COLOR_DARK_BLUE     (0x00008b00)	//濃い青
#define COLOR_MID_BLUE	    (0x00197019)	//深い青
#define COLOR_DARK_RED	    (0x00330000)	//濃い赤
#define COLOR_DARK_ORANGE	(0x00ff008c)	//濃いオレンジ
#define COLOR_INDIGO        (0x004b8200)    //濃い紫

#define COLOR_NULL         (0x00feffff)
#endif