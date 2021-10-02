/*
 * 弾幕の生成を行う関数を管理
 */

#include "../wrapper/game_wrapper.h"
#include "minigame.h"
#include <math.h>

#define BULLET_NUM  (30)
#define PI (3.141592)


/*
 * 構造体の確保
 */
static ShotPos shotpos[BULLET_NUM];
static BulletsNum bullets_num;


/*
 * ファイル内関数宣言
 */
static uint8_t bullets_timer(BulletsNum *const bullet);
static void bullet_xpos_update(ShotPos *const shot, GameWrapper *const game);
static void bullet_ypos_update(ShotPos *const shot, GameWrapper *const game);
static void bullet_dir_xpos(ShotPos *const shot);
static void bullet_dir_ypos(ShotPos *const shot);
static bool bullet_IsTrampling(ShotPos *const shot, GameWrapper *const game);
static bool bullet_IsHit(ShotPos *const shot, GameWrapper *const game);
static void bullet_config_sort(ShotPos *shot, BulletsNum *const bullet, uint8_t pos);
static uint32_t bullet_animation(ShotPos *const shot);
static void bullet_speed_update(ShotPos *const shot);


/*
 * 弾幕データのリセット処理
 *
 */
void shooting_reset(void)
{
    ShotPos *shot = shotpos;
    BulletsNum *p = &bullets_num;

    for (uint8_t i = 0; i < BULLET_NUM; i++)
    {
        shot->xpos              = 0;
        shot->ypos              = 0;
        shot->xdir              = 0;
        shot->ydir              = 0;
        shot->time              = 0;
        shot->bullet_speed      = 0;
        shot->speed_timer       = 0;
        shot->mapchip_id        = 0;
        shot->animation_cnt     = 0;
        shot->animation_timer   = 0;
        shot->alpha             = 0;
    }

    p->bullets = 0;
    p->time = get_time();
}


/*
 * 弾幕の座標計算
 * 
 * 弾幕の数ループ処理を行う
 * 踏みつけ判定がなかった場合に一定時間経過していたら弾幕の座標を更新する
 * キャラクターの座標と弾幕の座標が異なる周期で動作するため、再度踏みつけ判定を行う
 * 弾幕とキャラクターの当たり判定を行い、当たっていなければ弾幕の速度の更新を行う
 */
void bullet_pos_update(GameWrapper *const game)
{
    ShotPos *shot = shotpos;
    BulletsNum *bullet = &bullets_num;
    bool istramp;

    for (uint8_t i = 0; i < bullets_timer(bullet); i++, shot++)
    {
        istramp = BULLET_CLEAR_TRAMPLING;
        if (BULLET_NOT_CLEAR_TRAMPLING == bullet_IsTrampling(shot, game))
        {
            if (true == tmr_constant(&shot->time, shot->bullet_speed))
            {
                bullet_xpos_update(shot, game);
                bullet_ypos_update(shot, game);
                bullet_dir_xpos(shot);
                bullet_dir_ypos(shot);
                shot->time = get_time();
                if (shot->alpha != 0xff)
                {
                    shot->alpha++;
                }
            }

            if (BULLET_NOT_CLEAR_TRAMPLING == bullet_IsTrampling(shot, game))
            {
                if (BULLET_HIT_DETECTION == bullet_IsHit(shot, game))
                {
                    bgm_update(game, SOUND_ID_PITYUN, SOUND_CH_EFFECT2_WORK);
                    set_effect_trigger(EFFECT_ON, EFFECT_PITYUN_ID);
                    game->conf.display.uncommon_window = 1;
                    return;
                }
                istramp = BULLET_NOT_CLEAR_TRAMPLING;
            }
            
            bullet_speed_update(shot);
        }

        if (istramp == BULLET_CLEAR_TRAMPLING)
        {
            bullet->bullets--;
            bullet_config_sort(shot, bullet, i);
        }
    }
}


/*
 * 弾幕ブロックの描画処理
 */
void bullet_draw(GameWrapper *const game)
{
    ShotPos *shot = shotpos;
    BulletsNum *bullet = &bullets_num;

    game->mapchip.srcin      = DRAM_BLOCK_ADDR_BASE;
    game->mapchip.maxwidth   = SIZE_BLOCK_WIDTH;
    game->mapchip.maxheight  = SIZE_BLOCK_HEIGHT;
    game->mapchip.draw_xsize = SIZE_BLOCK_WIDTH;
    game->mapchip.draw_ysize = SIZE_BLOCK_HEIGHT;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.cut_color  = COLOR_WHITE;

    for (uint8_t i = 0; i < bullets_timer(bullet); i++, shot++)
    {
        game->mapchip.id     = bullet_animation(shot);
        game->mapchip.alpha  = shot->alpha;
        game->mapchip.dstin  = (shot->xpos << RGB_BYTE_SHIFT) + (shot->ypos * MAX_V_WIDTH) + game->conf.work.adr;
        game->mapchip.dstout = game->mapchip.dstin;
        put_mapchip(game);
    }
}


/*
 * 時間経過で弾幕を生成
 *
 * xy軸の開始位置
 * 0 ~ 511のx座標、64~255のy座標の開始位置を設定
 * 
 * 進行方向
 * 奇数と偶数の値を交互に取得しLeftとRight、UPとDOWNを設定
 */
static uint8_t bullets_timer(BulletsNum *const bullet)
{
    if (bullet->bullets != (BULLET_NUM - 1))
    {
        if (true == tmr_constant(&bullet->time, TM_1_5SEC_COUNT))
        {
            ShotPos *p          = &shotpos[bullet->bullets];
            p->xpos             = xorshift(get_time()) & 0x01ff;
            p->ypos             = xorshift(get_time()) & 0x00ff;
            p->xdir             = xorshift(get_time()) & 0x0007;
            p->ydir             = xorshift(get_time()) & 0x0007;
            p->time             = get_time();
            p->speed_timer      = get_time();
            p->bullet_speed     = TM_10MS_COUNT;
            p->mapchip_id       = 0;
            p->animation_cnt    = 0;
            p->animation_timer  = 0;
            p->xangel           = 0;
            p->yangel           = 0;
            p->alpha            = 0;
            p->xlength          = (float)(xorshift(get_time()) & 0x01ff);
            p->ylength          = (float)(xorshift(get_time()) & 0x01ff);
            bullet->bullets++;
            bullet->time = get_time();
        }
    }

    return bullet->bullets;
}


/*
 * x軸の弾幕の現在座標を更新
 */
static void bullet_xpos_update(ShotPos *const shot, GameWrapper *const game)
{
    float rad;
    int32_t pos;

    switch (shot->xdir)
    {
    case BULLET_TYPE_RIGHT:
        shot->xpos++;
        break;

    case BULLET_TYPE_LEFT:
        shot->xpos--;
        break;

    case BULLET_TYPE_ROTATION:
        rad = (float)shot->xangel * 3.14f / 180.0f;
        pos = cosf(rad) * shot->xlength;
        shot->xpos  = VIDEO_WIDTH_HALF + pos;
        shot->xangel++;
        break;

    case BULLET_TYPE_TRACKING:
        if (shot->xpos < game->unit.pos.unitx)
        {
            shot->xpos++;
        }
        else
        {
            shot->xpos--;
        }
        break;

    default:
        shot->xpos--;
        break;
    }
}


/*
 * y軸の弾幕の現在座標を更新
 */
static void bullet_ypos_update(ShotPos *const shot, GameWrapper *const game)
{
    float rad;
    int32_t pos;

    switch (shot->ydir)
    {
    case BULLET_TYPE_UP:
        shot->ypos--;
        break;

    case BULLET_TYPE_DOWN:
        shot->ypos++;
        break;

    case BULLET_TYPE_ROTATION:
        rad = (float)shot->yangel * 3.14f / 180.0f;
        pos = sinf(rad) * shot->ylength;
        shot->ypos  = VIDEO_HEIGHT_HALF + pos;
        shot->yangel++;
        break;
    
    case BULLET_TYPE_TRACKING:
        if (shot->ypos < game->unit.pos.unity)
        {
            shot->ypos++;
        }
        else
        {
            shot->ypos--;
        }
        break;

    default:
        shot->ypos++;
        break;
    }
}


/*
 * 壁に衝突したらx軸の弾幕の現在座標を参照し飛ばす向きを変更する
 */
static void bullet_dir_xpos(ShotPos *const shot)
{
    if (BLOCK_MAX_XMOVE < shot->xpos)
    {
        shot->xpos = BLOCK_MAX_XMOVE;

        if ((shot->xdir != BULLET_TYPE_ROTATION) && (shot->xdir != BULLET_TYPE_TRACKING))
        {
            shot->xdir = BULLET_TYPE_LEFT;
        }

    }
    else if (shot->xpos < 0)
    {
        shot->xpos = 0;

        if ((shot->xdir != BULLET_TYPE_ROTATION) && (shot->xdir != BULLET_TYPE_TRACKING))
        {
            shot->xdir = BULLET_TYPE_RIGHT;
        }
    }
}


/*
 * 壁に衝突したらy軸の弾幕の現在座標を参照し飛ばす向きを変更する
 */
static void bullet_dir_ypos(ShotPos *const shot)
{
    if (BLOCK_MAX_YMOVE < shot->ypos)
    {
        shot->ypos = BLOCK_MAX_YMOVE;
        if ((shot->ydir != BULLET_TYPE_ROTATION) && (shot->ydir != BULLET_TYPE_TRACKING))
        {
            shot->ydir = BULLET_TYPE_UP;
        }
    }
    else if (shot->ypos < 0)
    {
        shot->ypos = 0;
        if ((shot->ydir != BULLET_TYPE_ROTATION) && (shot->ydir != BULLET_TYPE_TRACKING))
        {
            shot->ydir = BULLET_TYPE_DOWN;
        }
    }
}


/*
 * 弾幕上部の左右の端の座標とキャラクターの下部と比較を行い、踏みつけ動作の当たり判定を行う
 * 踏みつけ判定が行われた場合、スコアの計算とジャンプ動作の再設定を行う
 */
static bool bullet_IsTrampling(ShotPos *const shot, GameWrapper *const game)
{
    if ((shot->ypos < game->unit.pos.unity + STEP_DETECTION_DOWN) && ((game->unit.pos.unity + STEP_DETECTION_UP) < shot->ypos) && (game->unit.pos.unitx + STEP_DETECTION_LEFT < shot->xpos + MAPCHIP_WIDTH) && (shot->xpos < game->unit.pos.unitx + STEP_DETECTION_RIGHT))
    {
        bgm_update(game, SOUND_ID_COIN, SOUND_CH_EFFECT1_WORK);
        set_score(game, shot->mapchip_id / BULLET_ANIMATION_NUM, shot->bullet_speed);
        set_jump_status(game);
        set_effect_trigger(EFFECT_ON, EFFECT_STEP_ON_ID);
        shot->ypos = game->unit.pos.unity + MAPCHIP_HEIGHT;
        shot->mapchip_id += BULLET_ANIMATION_NUM;

        if (BULLET_BLOCK_NUM <= shot->mapchip_id)
        {
            return BULLET_CLEAR_TRAMPLING;
        }
    }

    return BULLET_NOT_CLEAR_TRAMPLING;
}


/*
 * 弾幕を規定回数踏みつけたら、弾幕のデータの並び順をシフトする
 */
static void bullet_config_sort(ShotPos *shot, BulletsNum *const bullet, uint8_t pos)
{
    if (pos < bullet->bullets)
    {
        for (uint8_t i = 0; i < bullet->bullets; i++)
        {
            *shot = *(shot + 1);
            shot++;
        }
    }
}


/*
 * キャラクターと弾幕の当たり判定を行う
 * 歩行中はキャラクターの上部のみを当たり判定とする
 * ジャンプ中は下部以外を当たり判定とする
 */
static bool bullet_IsHit(ShotPos *const shot, GameWrapper *const game)
{
    if (shot->alpha != 0xff)
    {
        return BULLET_NOT_HIT_DETECTION;
    }

    if (((game->unit.pos.unity + BLOCK_DETECTION_UP) < (shot->ypos + SIZE_BLOCK_HEIGHT)) && (shot->ypos < (game->unit.pos.unity + BLOCK_DETECTION_DOWN)))
    {
        if (((game->unit.pos.unitx + BLOCK_DETECTION_LEFT) < (shot->xpos + SIZE_BLOCK_WIDTH)) && (shot->xpos < (game->unit.pos.unitx + BLOCK_DETECTION_RIGHT)))
        {
            return BULLET_HIT_DETECTION;
        }
    }

    return BULLET_NOT_HIT_DETECTION;
}


/*
 * 一致時間経過したら弾幕の画像データ切り替えをしアニメーションを行う
 */
static uint32_t bullet_animation(ShotPos *const shot)
{
	if (true == tmr_constant(&shot->animation_timer, BLOCK_RATE))
	{
		shot->animation_cnt++;

        if (BULLET_ANIMATION_NUM <= shot->animation_cnt)
        {
            shot->animation_cnt = 0;
        }
		shot->animation_timer = get_time();
	}

    return shot->mapchip_id + shot->animation_cnt;
}


/*
 * 一定時間経過したら弾幕の速度を上げる
 */
static void bullet_speed_update(ShotPos *const shot)
{
    if (true == tmr_constant(&shot->speed_timer, TM_400MS_COUNT))
    {
        if (TM_1MS_COUNT < shot->bullet_speed)
        {
            shot->bullet_speed--;
        }
        shot->speed_timer = get_time();
    }
}
