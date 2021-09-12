#ifndef draw_macro_h   /* prevent circular inclusions */
#define draw_macro_h   /* by using protection macros */


/*
 * ver1. 2021/08/18
 * マップ描画時に、バックグラウンドの描画とオブジェクトの描画を判定する定数
 */
typedef enum
{
    DRAW_TYPE_MAP,
    DRAW_TYPE_OBJ,
} DrawTypeID;

/*
 * キャラクターとフィールドのアニメーションを判定
 */
typedef enum
{
    DISPLAY_FIELD_CENTER_DRAW,  //中央描画
    DISPLAY_FIELD_RIGHT_DRAW,   //右方向アニメーション
    DISPLAY_FIELD_LEFT_DRAW,    //左方向アニメーション
    DISPLAY_FIELD_UP_DRAW,      //上方向アニメーション
    DISPLAY_FIELD_DOWN_DRAW,    //下方向アニメーション
    DISPLAY_DARKENING_DRAW,     //暗転描画
    DISPLAY_GRADUALLY_DRAW,     //黒から徐々に描画
    DISPLAY_NEXT_READY,         //暗闇中に次の描画データを準備
    DISPLAY_NULL_DRAW,          
} FieldDrawID;


/*
 * マップチップ番号
 */
typedef enum
{
	DRAW_TITLE_ID,
	DRAW_UNIT_ID,
	DRAW_MAP_ID,
	DRAW_BULLET_ID,
	DRAW_TIME_ID,
	DRAW_BOMB_ID,
	DRAW_SCORE_ID,
	DRAW_RESULT_ID,
} DrawMapchipID;



#endif
