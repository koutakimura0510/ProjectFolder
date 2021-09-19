/*
 * アニメーションの関数を管理
 */
#include "../../wrapper/game_wrapper.h"
#include "animation_struct.h"



/*
 * 構造体の確保
 */
static JumpDB jump_db;
static RealtimeEffect realtime_effect[REALTIME_EFFECT_NUMBER];


/*
 * ファイル内関数
 */
static const RtEffectDB *search_effect_adr(uint8_t id);
static uint32_t effect_draw_adr(GameWrapper *const game, RealtimeEffect *const rt, uint8_t effect_id);


/*
 * ver2. 2021/08/03
 * ひん死の画像切替のHPを規定値を、(HP / 10)から (HP / 8)以下に変更
 * 
 * ver1. 2021/08/02
 * 現在のHPに応じてアニメーションのマップチップ画像を切り替える
 */
uint8_t odd_hp_mapchip(GameWrapper *const game, uint8_t hero_id)
{
    return (game->hero[hero_id].status.odd_hp < (game->hero[hero_id].status.hp >> 3)) ? BATTLE_HERO_CHIP_DYING : BATTLE_HERO_CHIP_STAND;
}


/*
 * ver1. 2021/08/06
 * キャラクターが行動待機中か判定を行いbool値を返す
 */
bool isHeroActivate(uint8_t anime_order)
{
    switch (anime_order)
    {
    case BATTLE_HERO_CHIP_STAND:
        return true;

    case BATTLE_HERO_CHIP_DYING:
        return true;

    default:
        return false;
    }
}



/*
 * ver1. 2021/07/29
 * 上下にはねるアニメーション座標の更新処理
 * 指定座標に達したらtrueを返す
 */
bool conf_anime_update(GameWrapper *const game, int32_t pos)
{
    game->conf.animation.vel += game->conf.animation.acc;
    game->conf.animation.y   += game->conf.animation.vel;
    
    if (pos < game->conf.animation.y)
    {
        return true;
    }

    return false;
}


/*
 * ver1. 2021/07/29
 * アニメーションカウンタの更新
 * 引数に指定したカウントの値カウントしたらtrueを返す
 */
bool conf_anime_count(GameWrapper *const game, uint8_t count)
{
    game->conf.animation.count++;

    if (game->conf.animation.count == count)
    {
        return true;
    }

    return false;
}


/*
 * アニメーション構造体の初期化
 */
void animation_reset(void)
{
    JumpDB *p = &jump_db;
    RealtimeEffect *r_effect = realtime_effect;

    p->motion           = JUMP_OFF;
    p->pixel_count      = 0;
    p->jump_count       = 0;

    for (uint8_t i = 0; i < REALTIME_EFFECT_NUMBER; i++, r_effect++)
    {
        r_effect->trigger    = EFFECT_OFF;
        r_effect->timer      = 0;
        r_effect->mapchip_id = 0;
    }
}


/*
 * キャラクターのジャンプ動作
 *
 * 1pixelずつ座標を更新し移動ごとに速度を調整する
 */
void jump_move(GameWrapper *const game)
{
    JumpDB *jump = &jump_db;

    if (JUMP_OFF == jump->motion)
    {
        return;
    }

    if (jump->pixel_count < 0)
    {
        game->unit.pos.unity += 8;
    }
    else
    {
        jump->pixel_count -= 8;
        game->unit.pos.unity -= 8;
    }
}


/*
 * ジャンプの動作状態をセット
 */
void set_jump_motion(bool motion)
{
    JumpDB *jump = &jump_db;

    jump->motion = motion;
}


/*
 * ジャンプの動作状態を取得
 */
bool get_jump_motion(void)
{
    JumpDB *jump = &jump_db;

    return jump->motion;
}


/*
 * ジャンプ動作のステータスをセット
 */
void set_jump_status(GameWrapper *const game)
{
    JumpDB *jump = &jump_db;
    
    jump->motion = JUMP_ON;
    jump->pixel_count = 115;
    jump->jump_count++;
}


/*
 * 現在のジャンプの回数を取得
 */
uint32_t get_jump_count(void)
{
    JumpDB *jump = &jump_db;

    return jump->jump_count;
}


/*
 * 指定したエフェクトの描画処理ONOFF
 */
void set_effect_trigger(bool onoff, uint8_t effect_id)
{
    RealtimeEffect *p = &realtime_effect[effect_id];

    p->trigger = onoff;
}


/*
 * 指定したエフェクトの動作状態を取得
 */
bool get_effect_trigger(uint8_t effect_id)
{
    RealtimeEffect *p = &realtime_effect[effect_id];

    return p->trigger;
}


/*
 * ver2. 2021/07/05
 * エフェクトそれぞれに時間係数を持たせるように変更
 *
 * ver1
 * リアルタイムエフェクトの描画処理
 */
bool realtime_effect_draw(GameWrapper *const game, uint8_t effect_id)
{
    RealtimeEffect *p = &realtime_effect[effect_id];

    if (p->trigger == EFFECT_OFF)
    {
        p->xpos = game->unit.pos.unitx;
        p->ypos = game->unit.pos.unity;
        return true;
    }

    const RtEffectDB *db     = search_effect_adr(effect_id);
    game->mapchip.srcin      = db->srcin;
    game->mapchip.maxwidth   = db->maxwidth;
    game->mapchip.maxheight  = db->maxheight;
    game->mapchip.draw_xsize = game->mapchip.maxwidth;
    game->mapchip.draw_ysize = game->mapchip.maxheight;
    game->mapchip.alpha      = 255;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.dstin      = effect_draw_adr(game, p, effect_id);
    game->mapchip.dstout     = game->mapchip.dstin;
    game->mapchip.id         = p->mapchip_id;
    png_mapchip(game);

    if (true == tmr_constant(&p->timer, TM_80MS_COUNT))
    {
        p->mapchip_id++;
        p->timer = get_time();

        if (p->mapchip_id == db->animation_num)
        {
            p->mapchip_id = 0;
            set_effect_trigger(EFFECT_OFF, effect_id);
            return false;
        }
    }

    return true;
}


/*
 * 指定したIDに対応したデータベースのアドレスを取得
 */
static const RtEffectDB *search_effect_adr(uint8_t id)
{
    const RtEffectDB *p = rteffect_db;

    for (uint8_t i = 0; i < REALTIME_EFFECT_NUMBER; i++, p++)
    {
        if (p->id == id)
        {
            break;
        }
    }

    return p;
}


/*
 * エフェクトの描画箇所のアドレスを計算し取得
 */
static uint32_t effect_draw_adr(GameWrapper *const game, RealtimeEffect *const rt, uint8_t effect_id)
{
    switch (effect_id)
    {
    case EFFECT_STEP_ON_ID:
        return ((rt->xpos - 60) << RGB_BYTE_SHIFT) + (rt->ypos * MAX_V_WIDTH) + game->conf.work.adr;

    case EFFECT_BOMB_ID:
        return EFFECT_DRAW_POS + game->conf.work.adr;

    case EFFECT_PITYUN_ID:
        return ((rt->xpos - 60) << RGB_BYTE_SHIFT) + ((rt->ypos - (SIZE_PITYUN_HEIGHT >> 1)) * MAX_V_WIDTH) + game->conf.work.adr;

    default:
        return 0;
    }
}
