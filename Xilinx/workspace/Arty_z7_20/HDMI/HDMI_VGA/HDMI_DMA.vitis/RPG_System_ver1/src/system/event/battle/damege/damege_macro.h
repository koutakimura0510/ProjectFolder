#ifndef damege_macro_h   /* prevent circular inclusions */
#define damege_macro_h   /* by using protection macros */

/* カリスマガード状態のダメージ軽減量 */
#define GUARD_REMIRIA   (6)



/* ダメージ・回復の描画の開始位置計算定数 */
#define ADJUST_RESULT_FONT_DRAW_POS     (6) //フォントの描画位置調整

#define BATTLE_DAMEGE_UNIT_DRAW_XPOS    (SIZE_UNIT_BATTLE_WIDTH >> 1)
#define BATTLE_DAMEGE_UNIT_DRAW_YPOS    ((SIZE_UNIT_BATTLE_HEIGHT - ADJUST_RESULT_FONT_DRAW_POS) * MAX_V_WIDTH)
#define BATTLE_DAMEGE_UNIT_DRAW_NUM     (SIZE_FONT_DAMEGE_WIDTH >> 1)   //戦闘リザルトフォントサイズの半分
#define BATTLE_DAMEGE_ENEMY_DRAW_NUM    (SIZE_FONT_DAMEGE_WIDTH >> 1)


/*
 * ver1. 2021/07/25
 * リザルト表示のアニメーション描画
 */
typedef enum
{
    ANIMATION_STATE_SIN_CURVE,
    ANIMATION_STATE_KEEP_POS,
} BattleAnimationStateID;


/* リザルトの表示時間 */
#define RESULT_ANIME_KEEP_COUNT (20)

/* リザルトの更新速度 */
#define RESULT_ANIME_TIMER      (TM_700US_COUNT)

/* リザルトアニメーションの大きさ */
#define RESULT_ANIMATION_VEL    (-10)

/* リザルトアニメーションの着地点 */
#define RESULT_ANIMATION_STOP    (-8)

#endif
