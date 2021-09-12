#ifndef detection_macro_h   /* prevent circular inclusions */
#define detection_macro_h   /* by using protection macros */


/*
 * ブロックの当たり判定
 */
#define BLOCK_DETECTION_RIGHT   (SIZE_BLOCK_WIDTH - 8)
#define BLOCK_DETECTION_LEFT    (8)
#define BLOCK_DETECTION_UP      (5)
#define BLOCK_DETECTION_DOWN    (28)


/*
 * 踏みつけの当たり判定
 */
#define STEP_DETECTION_RIGHT    (32 - 5)
#define STEP_DETECTION_LEFT     (32 - 27)
#define STEP_DETECTION_UP       (18)
#define STEP_DETECTION_DOWN     (31)


/*
 * 当たり判定
 */
#define BULLET_HIT_DETECTION            (true)
#define BULLET_NOT_HIT_DETECTION        (false)
#define BULLET_CLEAR_TRAMPLING          (true)
#define BULLET_NOT_CLEAR_TRAMPLING      (false)

#endif
