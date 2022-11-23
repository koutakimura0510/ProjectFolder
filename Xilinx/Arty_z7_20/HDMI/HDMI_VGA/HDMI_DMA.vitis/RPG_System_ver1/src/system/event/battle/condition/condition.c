/*
 * Create 2021/08/09
 * Author kimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * IC
 * -
 */
#include "../../../wrapper/game_wrapper.h"
#include "../wrapper/local_share.h"
#include "condition_macro.h"


/*
 * ver1. 2021/08/09
 * 状態異常用のループアニメーション更新用マップチップデータの管理を行う構造体
 */
typedef struct
{
    uint8_t mapchip_id;
    uint32_t update_time;
} MapchipCondition;

/*
 * ver1. 2021/08/11
 * 状態異常時のダメージ更新や状態異常になってから経過した時間を管理する構造体
 */
typedef struct
{
    uint32_t timer;
    uint8_t count;
} ConditionTimer;


/* ファイル内構造体の確保 */
static MapchipCondition mapchip_condition[HERO_NUMBER];
static ConditionTimer condition_timer[HERO_NUMBER];

/* ファイル内関数 */
static void condition_loop_animation(GameWrapper *const game, uint8_t hero_id);
static void condition_calc_hp(GameWrapper *const game, uint8_t hero_id);
static void regene_calc_hp(GameWrapper *const game, uint8_t hero_id);
static void poison_calc_hp(GameWrapper *const game, uint8_t hero_id);
static void move_condition(GameWrapper *const game, uint8_t hero_id);

/*
 * ver1. 2021/08/09
 * 毒状態の仲間のダメージ処理
 * 一定期間ごとに毒状態かつ生存中の仲間のHPを最大HPの1/16分減らしていく
 * 残り体力が1になったら毒ダメージは受けない
 */
void hero_condition_state(GameWrapper *const game)
{
    for (uint8_t i = 0; i < game->conf.battle.hero.counter; i++)
    {
        if (game->hero[game->conf.battle.hero.sort_order[i]].battle.arive == BATTLE_HERO_DEATH)
        {
            continue;
        }

        condition_loop_animation(game, game->conf.battle.hero.sort_order[i]);
        condition_calc_hp(game, game->conf.battle.hero.sort_order[i]);
    }
}


/*
 * ver1. 2021/08/11
 * 正常状態の構造体初期化処理
 */
void update_condition_db(GameWrapper *const game, uint8_t hero_id)
{
    ConditionTimer *cond   = &condition_timer[hero_id];
    MapchipCondition *chip = &mapchip_condition[hero_id];

    chip->mapchip_id = 0;
    cond->count = 0;
}


/*
 * ver1. 2021/08/09
 * 状態異常のループアニメーションの描画
 */
static void condition_loop_animation(GameWrapper *const game, uint8_t hero_id)
{
    MapchipCondition *p = &mapchip_condition[hero_id];
    SDL_Rect rect;

    if ((game->hero[hero_id].battle.condition == CONDITION_CURE_GOOD) && (game->hero[hero_id].equip.condition == CONDITION_CURE_GOOD))
    {
        return;
    }

    game->mapchip.srcin		 = fetch_dram_db(game, MEMORY_CONDITION_ANIME_ID, game->hero[hero_id].battle.condition, CONDITION_SUB_MEMBER_ANIME_SRCIN);
    game->mapchip.maxwidth	 = fetch_dram_db(game, MEMORY_CONDITION_ANIME_ID, game->hero[hero_id].battle.condition, CONDITION_SUB_MEMBER_ANIME_WIDTH);
    game->mapchip.maxheight	 = fetch_dram_db(game, MEMORY_CONDITION_ANIME_ID, game->hero[hero_id].battle.condition, CONDITION_SUB_MEMBER_ANIME_HEIGHT);
    game->mapchip.draw_xsize = game->mapchip.maxwidth;
    game->mapchip.draw_ysize = game->mapchip.maxheight;
    rect.w                   = game->hero[hero_id].battle.draw_pos + XRGB(game->hero[hero_id].battle.draw_xpos);
    rect.x                   = W_CENTER(game->mapchip.maxwidth) - SIZE_UNIT_BATTLE_TOTAL_HALF_POS;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = 255;
    game->mapchip.id         = p->mapchip_id;
    game->mapchip.dstin      = game->conf.work.adr + rect.w - rect.x - H_CENTER(game->mapchip.maxheight);
    game->mapchip.dstout	 = game->mapchip.dstin;
    png_mapchip(game);

    if (true == tmr_constant(&p->update_time, fetch_dram_db(game, MEMORY_CONDITION_ANIME_ID, game->hero[hero_id].battle.condition, CONDITION_SUB_MEMBER_ANIME_ANIME_TIME)))
    {
        p->mapchip_id++;
        p->update_time = get_time();

        if (p->mapchip_id == fetch_dram_db(game, MEMORY_CONDITION_ANIME_ID, game->hero[hero_id].battle.condition, CONDITION_SUB_MEMBER_ANIME_ANIME_CNT))
        {
            p->mapchip_id = 0;
        }
    }
}


/*
 * ver1. 2021/08/11
 * 状態異常のHP処理関数を管理
 */
static void condition_calc_hp(GameWrapper *const game, uint8_t hero_id)
{
    switch (game->hero[hero_id].battle.condition)
    {
    case CONDITION_CURE_GOOD:
        return;
    
    case UNIT_CONDITION_RIGENE:
        regene_calc_hp(game, hero_id);
        return;

    case UNIT_CONDITION_POISON:
        poison_calc_hp(game, hero_id);
        return;
    
    case UNIT_CONDITION_RIFREK:
        // カリスマガードは特別な処理はしない
        return;

    default:
        move_condition(game, hero_id);
        return;
    }
}


/*
 * ver1. 2021/08/11
 * リジェネ状態のHP計算処理
 * 一定時間ごとに最大HPの1/16の値を回復していく、一定回数回復したらリジェネの効果が消える
 */
static void regene_calc_hp(GameWrapper *const game, uint8_t hero_id)
{
    ConditionTimer *p = &condition_timer[hero_id];

    if (false == tmr_constant(&p->timer, REGENE_TIMER))
    {
        return;
    }

    int32_t result = game->hero[hero_id].status.odd_hp + (game->hero[hero_id].status.hp >> 4);
    game->hero[hero_id].status.odd_hp = (result < game->hero[hero_id].status.hp) ? result :
    game->hero[hero_id].status.hp;
    p->timer = get_time();
    p->count++;

    if (p->count == REGENE_COUNT)
    {
        p->count = 0;
        game->hero[hero_id].battle.condition = CONDITION_CURE_GOOD;
    }
}


/*
 * ver1. 2021/08/11
 * 毒状態のHP計算処理
 * 一定時間ごとに最大HPの1/16のダメージをもらう
 */
static void poison_calc_hp(GameWrapper *const game, uint8_t hero_id)
{
    ConditionTimer *p = &condition_timer[hero_id];

    if (false == tmr_constant(&p->timer, POISON_TIMER))
    {
        return;
    }
    
    int32_t result = game->hero[hero_id].status.odd_hp - (game->hero[hero_id].status.hp >> 4);
    game->hero[hero_id].status.odd_hp = (result < 1) ? 1 : result;
    p->timer = get_time();
}


/*
 * ver1. 2021/08/11
 * 行動が制限される状態異常の処理
 * 一定時間経過したら状態が回復する
 * 
 * 状態一覧
 * バーサク     戦うコマンドのみ
 * マヒ         動けない
 * 石化         動けない
 * 混乱         動けない
 */
static void move_condition(GameWrapper *const game, uint8_t hero_id)
{
    ConditionTimer *p = &condition_timer[hero_id];

    switch (p->count)
    {
    case CONDITION_STATE_TIMER_SET:
        p->timer = get_time();
        p->count = CONDITION_STATE_TIMER_COUNT;
        break;

    case CONDITION_STATE_TIMER_COUNT:
        if (true == tmr_constant(&p->timer, CONDITION_TIMER))
        {
            game->hero[hero_id].battle.condition = CONDITION_CURE_GOOD;
        }
        break;

    default:
        p->count = CONDITION_STATE_TIMER_SET;
        break;
    }
}
