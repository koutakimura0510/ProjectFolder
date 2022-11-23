#ifndef shooting_macro_h   /* prevent circular inclusions */
#define shooting_macro_h   /* by using protection macros */

/*
 * 弾幕の進行方向
 *
 * 上下左右
 * UP, DOWN RIGHT, LEFT
 * 
 * 回転
 * ROTATION
 * 
 * 追尾
 * TRACKING
 */
typedef enum
{
    BULLET_TYPE_UP,
    BULLET_TYPE_DOWN,
    BULLET_TYPE_RIGHT,
    BULLET_TYPE_LEFT,
    BULLET_TYPE_ROTATION,
    BULLET_TYPE_TRACKING,
    BULLET_TYPE_NUM,
} BulletDirection;


/*
 * ボムの最大個数
 */
#define BOMB_MAX_NUM     (3)


/*
 * 選択キャラクターの人数
 */
#define UNIT_FILE_ACCESS_HERO_MINIGAME_CHIP_NUMBER  (3)


/*
 * オブジェクトの描画箇所
 */
#define BOMB_DRAW_YPOS       (MAX_V_WIDTH * (VIDEO_HEIGHT - MAPCHIP_HEIGHT))
#define SCORE_DRAW_YPOS      (MAX_V_WIDTH * (VIDEO_HEIGHT - MAPCHIP_HEIGHT + 4))
#define TIME_DRAW_YPOS       (MAX_V_WIDTH * (VIDEO_HEIGHT - MAPCHIP_HEIGHT + 4))
#define TIME_DRAW_XPOS       ((VIDEO_WIDTH >> 1) + (SIZE_FONT_NUMBER_WIDTH * 2))
#define TIME_PERIOD_DRAW_POS (((TIME_DRAW_XPOS - (SIZE_FONT_NUMBER_WIDTH * 2)) << RGB_BYTE_SHIFT) + TIME_DRAW_YPOS)
#define RESULT_DRAW_YPOS	 (MAX_V_WIDTH * ((VIDEO_HEIGHT >> 1) - SIZE_FONT_RESULT_HEIGHT))


/*
 * 最大スコア表示桁数、合計値
 */
#define SCORE_DIGIT_NUMBER  (9)
#define SCORE_MAX           (999999999)


/*
 * 数字のマップチップID
 */
#define MAPCCHIP_PERIOD (12)

#endif