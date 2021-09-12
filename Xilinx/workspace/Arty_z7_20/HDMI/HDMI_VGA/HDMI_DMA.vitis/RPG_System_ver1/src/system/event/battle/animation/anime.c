/*
 * Create 2021/08/02
 * Author kimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * IC
 * -
 * 状態遷移のアニメーションに関する関数をまとめたファイル
 * actioc.cにすべて記入していたが、1000行を超えてしまったのでファイルを分けた
 */
#include "../../../wrapper/game_wrapper.h"
#include "../wrapper/local_share.h"


/*
 * ver4. 2021/07/31
 * エフェクト描画関数をモジュールごとに分けた
 * 
 * ver3. 2021/07/22
 * 行動確定時の処理内容を状態遷移でまとめるように変更
 * エフェクトの描画はエフェクト描画メンバのみデータの変更をするようにし、スコープの範囲を狭くした
 *
 * ver2. 2021/07/06
 * コマンド確定時に時間を計測しエフェクトの発動順にソートしているため、配列の0番地の発動条件のみ確認すればよい処理にした
 * ver1ではfor分で人数分の確認を行っていたが、処理のしやすさからver2に変更した
 * -
 * ver1. 2021/06/27
 * 行動を確定したキャラクターの行動開始時間が規定時間過ぎたらエフェクトを描画
 */
void animation_effect_draw(GameWrapper *const game, uint8_t effect_id, uint32_t draw_pos)
{
    game->mapchip.srcin      = fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, effect_id, ANIME_SUB_MEMBER_MAGIC_SRCIN);
    game->mapchip.maxwidth   = fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, effect_id, ANIME_SUB_MEMBER_MAGIC_XSIZE);
    game->mapchip.maxheight  = fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, effect_id, ANIME_SUB_MEMBER_MAGIC_YSIZE);
    game->mapchip.draw_xsize = game->mapchip.maxwidth;
    game->mapchip.draw_ysize = game->mapchip.maxheight;
    game->mapchip.alpha      = 255;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.dstin      = game->conf.work.adr + draw_pos;
    game->mapchip.dstout     = game->mapchip.dstin;
    game->mapchip.id         = game->conf.battle.effect.mapchip_id;
    png_mapchip(game);
}


/*
 * ver2. 2021/08/05
 * エフェクトのアニメーション用画像データの取り回しがしやすいように、
 * アニメーション用のデータベースを作成しデータを取得するように変更
 * 
 * ver1. 2021/07/31
 * バトル中のエフェクト描画のメンバ変数を更新、更新終了時に次の状態に遷移する
 */
void animation_effect_update(GameWrapper *const game, uint8_t effect_id, uint8_t next_state)
{
    if (EFFECT_SOUND_ON == game->conf.battle.effect.sound)
    {
        bgm_update(game, fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, effect_id, ANIME_SUB_MEMBER_MAGIC_SOUND_ID), SOUND_CH_EFFECT1_WORK);
        game->conf.battle.effect.sound = EFFECT_SOUND_OFF;
    }

    game->conf.battle.effect.mapchip_id++;

    if (game->conf.battle.effect.mapchip_id == fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, effect_id, ANIME_SUB_MEMBER_MAGIC_ANIME_CNT))
    {
        game->conf.battle.effect.mapchip_id = 0;
        game->conf.battle.effect.loop_count++;

        if (game->conf.battle.effect.loop_count == fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, effect_id, ANIME_SUB_MEMBER_MAGIC_LOOP_COUNT))
        {
            game->conf.battle.effect.mapchip_id  = 0;
            game->conf.battle.effect.sound       = EFFECT_SOUND_ON;
            game->conf.battle.effect.loop_count  = 0;
            game->conf.battle.effect.update_time = 0;
            game->conf.battle.state.module 		 = next_state;
        }
    }
}



/*
 * ver1. 2021/07/30
 *
 * フォントのアニメーションデータの更新
 */
void font_animetion_memba_update(GameWrapper *const game)
{
    game->conf.animation.vel = RESULT_ANIMATION_VEL;
    game->conf.animation.acc = 1;
    game->conf.animation.y   = 0;
    game->conf.animation.state = ANIMATION_STATE_SIN_CURVE;
    game->conf.animation.count = 0;
}


/*
 * ver1. 2021/07/30
 * ダメージ、回復描画の座標更新処理
 */
void battle_font_animation_update(GameWrapper *const game, uint8_t next_state)
{
    if (false == tmr_constant(&game->conf.battle.state.timer, TM_700US_COUNT))
    {
        return;
    }

    switch (game->conf.animation.state)
    {
    case ANIMATION_STATE_SIN_CURVE:
        if (true == conf_anime_update(game, RESULT_ANIMATION_STOP))
        {
            game->conf.animation.state = ANIMATION_STATE_KEEP_POS;
        }
        break;

    case ANIMATION_STATE_KEEP_POS:
        if (true == conf_anime_count(game, RESULT_ANIME_KEEP_COUNT))
        {
            game->conf.battle.state.module = next_state;
        }
        break;

    default:
        break;
    }

    game->conf.battle.state.timer = get_time();
}


/*
 * ver1. 2021/08/02
 * 仲間の技発動時の仲間の位置のエフェクト描画処理
 * 仲間の座標の中心に描画するように計算を行う
 */
void hero_paty_magic_draw(GameWrapper *const game, StatusRef *const ref)
{
    for (uint8_t i = 0; i < ref->index_loop; i++)
    {
        uint32_t draw_pos = W_CENTER(fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, ref->anime_id, ANIME_SUB_MEMBER_MAGIC_XSIZE));
        draw_pos = game->hero[game->conf.battle.hero.sort_order[ref->sort_pos + i]].battle.draw_pos + SIZE_UNIT_BATTLE_WIDTH_HALF_POS - SIZE_UNIT_BATTLE_HEIGHT_HALF_POS - draw_pos;
        draw_pos += (game->hero[game->conf.battle.hero.sort_order[ref->sort_pos + i]].battle.draw_xpos << RGB_BYTE_SHIFT);
        animation_effect_draw(game, ref->anime_id, draw_pos);
    }
}


/*
 * ver1. 2021/08/02
 * 仲間の技発動時の敵の位置のエフェクト描画処理
 */
void hero_enemy_magic_draw(GameWrapper *const game, StatusRef *const ref)
{
    for (uint8_t i = 0; i < ref->index_loop; i++)
    {
        animation_effect_draw(game, ref->anime_id, game->enemy[ref->sort_pos + i].draw_pos);
    }
}


/*
 * ver1. 2021/08/09
 * 敵の技発動時の、仲間の位置のエフェクト描画処理
 */
void enemy_hero_magic_draw(GameWrapper *const game, StatusRef *const ref)
{
    SDL_Rect rect;

    for (uint8_t i = 0; i < game->conf.battle.loop.counter; i++)
    {
        rect.w = W_CENTER(fetch_dram_db(game, MEMORY_ANIME_MAGIC_ID, ref->anime_id, ANIME_SUB_MEMBER_MAGIC_XSIZE));
        rect.x = game->hero[game->conf.battle.hero.sort_order[game->conf.battle.loop.cursol + i]].battle.draw_pos;
        rect.w = rect.x + SIZE_UNIT_BATTLE_WIDTH_HALF_POS - SIZE_UNIT_BATTLE_HEIGHT_HALF_POS - rect.w;
        animation_effect_draw(game, ref->anime_id, rect.w);
    }
}


/*
 * ver1. 2021/08/09
 * 敵の技発動時の、敵の位置のエフェクト描画処理
 */
void enemy_paty_magic_draw(GameWrapper *const game, StatusRef *const ref)
{
    for (uint8_t i = 0; i < game->conf.battle.loop.counter; i++)
    {
        animation_effect_draw(game, ref->anime_id, game->enemy[game->conf.battle.loop.cursol + i].draw_pos);
    }
}
