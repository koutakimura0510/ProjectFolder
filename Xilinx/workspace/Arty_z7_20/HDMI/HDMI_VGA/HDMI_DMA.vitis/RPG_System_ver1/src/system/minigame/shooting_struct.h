#ifndef shooting_struct_h   /* prevent circular inclusions */
#define shooting_struct_h   /* by using protection macros */


/*
 * 現在描画中の弾幕の数を管理
 */
typedef struct buletts
{
    uint32_t time;
    uint8_t bullets;
} BulletsNum;


/*
 * 弾幕のデータを管理
 *
 * 弾幕の座標を管理
 * xpos
 * ypos
 * 
 * 弾幕の進行方向
 * xdir
 * ydir
 * 
 * 弾幕の出現からの経過時間を保存
 * time
 * 
 * 弾幕の速度と速度の更新速度を管理
 * bullets_speed
 * speed_timer
 * 
 * 描画の切り取り描画位置を管理
 * animation_cnt
 * 
 * 画像データの更新速度を管理
 * animation_timer
 */
typedef struct shotpos
{
    int32_t  xpos;
    int32_t  ypos;
    int32_t  xangel;
    int32_t  yangel;
    float    xlength;
    float    ylength;
    uint8_t  xdir;
    uint8_t  ydir;
    uint32_t time;
    uint32_t bullet_speed;
    uint32_t speed_timer;
    uint32_t mapchip_id;
    uint32_t animation_cnt;
    uint32_t animation_timer;
    uint8_t  alpha;
} ShotPos;

#endif