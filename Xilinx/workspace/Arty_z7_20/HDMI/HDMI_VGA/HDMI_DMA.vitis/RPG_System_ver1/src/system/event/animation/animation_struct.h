/*
 * データベース管理ヘッダーファイル
 */

#ifndef animation_struct_h   /* prevent circular inclusions */
#define animation_struct_h   /* by using protection macros */


/*
 * ジャンプ動作のデータを管理
 *
 * 現在ジャンプ中か判定
 * motion
 * 
 * ジャンプ中の移動ピクセル数をカウント
 * pixel_count
 * 
 * 現在の速度を指定
 * speed
 * 
 * ジャンプ中の動作を判定
 * state
 * 
 * 滞空時間を指定
 * time
 * 
 * 地面に落ちずにジャンプした回数を保存
 * jump_count
 */
typedef struct Jump_db
{
    bool     motion;
    int32_t  pixel_count;
    uint32_t speed;
    uint8_t  state;
    uint32_t time;
    uint32_t jump_count;
} JumpDB;


/*
 * エフェクトの描画速度と描画ONOFFを管理
 *
 * エフェクトが発動中か判定
 * trigger
 * 
 * エフェクトの描画速度を保存
 * timer
 * 
 * 現在描画中のエフェクトの番号を保存
 * mapchip_id
 * 
 * キャラクターの現在座標を保存
 * これはブロック踏みつけ時に踏みつけた場所にエフェクトを
 * 発生させるため保存しておく必要がある
 * xpos
 * ypos
 */
typedef struct realtime_effect
{
    bool     trigger;
    uint32_t timer;
    uint8_t  mapchip_id;
    uint32_t xpos;
    uint32_t ypos;
} RealtimeEffect;


/*
 * エフェクトの描画に関するデータを管理するデータベース
 *
 * エフェクトID
 * id
 * 
 * エフェクトデータが保存されているDRAMの開始アドレス
 * srcin
 * 
 * エフェクトの画像サイズ
 * maxwidth
 * maxheight
 * 
 * 透過率
 * alpha
 * 
 * 切り取り色データ
 * cut_color
 * 
 * 描画データのアニメーション数
 * animation_num
 */
typedef struct rteffect_db 
{
    uint8_t  id;
    uint32_t srcin;
    uint32_t maxwidth;
    uint32_t maxheight;
    uint8_t animation_num;
} RtEffectDB;

static const RtEffectDB rteffect_db[] =
{
    {   EFFECT_STEP_ON_ID, DRAM_EFFECT_HITBOX_ADDR_BASE, SIZE_HITBOX_WIDTH, SIZE_HITBOX_HEIGHT, EFFECT_STEP_ANIMATION_NUM     },
    {   EFFECT_PITYUN_ID,  DRAM_EFFECT_PITYUN_ADDR_BASE, SIZE_PITYUN_WIDTH, SIZE_PITYUN_HEIGHT, EFFECT_PITYUN_ANIMATION_NUM   },
    {   EFFECT_BOMB_ID,    DRAM_EFFECT_BOMB_ADDR_BASE,   SIZE_BOMB_WIDTH,   SIZE_BOMB_HEIGHT,   EFFECT_BOMB_ANIMATION_NUM     },
};

#endif
