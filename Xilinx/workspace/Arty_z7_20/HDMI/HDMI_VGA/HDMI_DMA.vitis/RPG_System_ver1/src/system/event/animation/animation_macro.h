#ifndef animation_macro_h   /* prevent circular inclusions */
#define animation_macro_h   /* by using protection macros */


/*
 * 描画の速度やアニメーションエフェクトに関するデータを管理するヘッダーファイル
 */


/*
 * リフレッシュレート
 */
#define DISPLAY_RATE	(TM_1MS_COUNT)
#define PLAYER_RATE		(TM_200MS_COUNT)
#define BLOCK_RATE      (TM_300MS_COUNT)
#define STEP_ON_RATE    (TM_100MS_COUNT)
#define DARK_RATE       (TM_1MS_COUNT)
#define FILE_ACCESS_HERO_MINIGAME_CHIP_RATE     (TM_50US_COUNT)


/*
 * エフェクト、モーションのONOFF
 */
#define EFFECT_ON       (true)
#define EFFECT_OFF      (false)
#define JUMP_ON         (false)
#define JUMP_OFF        (true)


/*
 * リアルタイムエフェクトのID
 */
typedef enum
{
    /* ミニゲーム用のID */
    EFFECT_STEP_ON_ID,
    EFFECT_BOMB_ID,
    EFFECT_PITYUN_ID,

    REALTIME_EFFECT_NUMBER,
} RTEffectID;



/*
 * エフェクトの描画箇所
 */
#define EFFECT_DRAW_XPOS    (((VIDEO_WIDTH >> 1) - (SIZE_BOMB_WIDTH >> 1)) << RGB_BYTE_SHIFT)
#define EFFECT_DRAW_YPOS    (MAX_V_WIDTH * ((VIDEO_HEIGHT >> 1) - (SIZE_BOMB_HEIGHT >> 1)))
#define EFFECT_DRAW_POS     (EFFECT_DRAW_XPOS + EFFECT_DRAW_YPOS)


/*
 * エフェクトのアニメーション数
 */
#define EFFECT_BOMB_ANIMATION_NUM   (10)
#define EFFECT_STEP_ANIMATION_NUM   (8)
#define EFFECT_PITYUN_ANIMATION_NUM (8)


/* 通常バトルエフェクトのアニメーション数 */
#define EFFECT_BATTLE_DEFAULT_ANIME_NUM (9)



/*
 * 弾幕のアニメーションの数
 * 弾幕の描画ブロックの最大個数
 */
#define BULLET_ANIMATION_NUM    (3)
#define BULLET_BLOCK_NUM        (BULLET_ANIMATION_NUM * 3)


/*
 * ジャンプの最高速度
 */
#define JUMP_MAX_SPEED  (TM_3MS_COUNT)


/*
 * ジャンプの最大高さ
 */
#define JUMP_SIZE   (130)


/*
 * 踏みつけ動作のジャンプの最大高さ
 */
#define JUMP_HIT_SIZE   (100)


/*
 * キャラクターの空中の動作状態
 */
typedef enum
{
    JUMP,
    FALL,
    WAIT,
} YposMovement;



#endif
