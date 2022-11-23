/*
 * プレイヤーの座標更新を行う関数を管理
 */

#include "../../wrapper/game_wrapper.h"


/*
 * ファイル内関数宣言
 */
static void eventpos_update_key(GameWrapper *const game, uint8_t sw);
static void unit_right(GameWrapper *const game);
static void unit_left(GameWrapper *const game);
static void unit_up(GameWrapper *const game);
static void unit_down(GameWrapper *const game);
static void unit_mapchippos_update(GameWrapper *const game);
static void adjust_unit_action(GameWrapper *const game);
static uint8_t get_dynig_chip(GameWrapper *const game, uint8_t hero_id);



/*
 * ver4. 2021/08/16
 * メニュー画面にもバトルチップを描画するため関数をbattle.cから移した
 *
 * ver3. 2021/08/02
 * 死亡中のマップチップは2枚使用するため、仲間の現在の状況を判定し画像貼り付けの枚数を調整するようにした
 * 
 * ver2. 2021/07/08
 * config.battleにメンバを追加し、隊列のインデックスを参照して描画するように変更
 *
 * ver1. 2021/06/27
 * バトル中のキャラクターを描画
 */
void battle_player_draw(GameWrapper *const game, uint8_t hero_draw_count)
{
    game->mapchip.srcin		 = DRAM_UNIT_BATTLE_ADDR_BASE;
    game->mapchip.maxwidth	 = SIZE_UNIT_BATTLE_WIDTH;
    game->mapchip.maxheight	 = SIZE_UNIT_BATTLE_HEIGHT;
    game->mapchip.draw_xsize = SIZE_UNIT_BATTLE_WIDTH;
    game->mapchip.draw_ysize = SIZE_UNIT_BATTLE_HEIGHT;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = 255;

    for (uint8_t i = 0; i < hero_draw_count; i++)
    {
        uint8_t hero_id = game->conf.battle.hero.sort_order[i];

        for (uint32_t j = 0; j < get_dynig_chip(game, hero_id); j++)
        {
            game->mapchip.id     = (BATTLE_HERO_CHIP_NUMBER * hero_id) + game->conf.battle.hero.anime_order[hero_id] + j;
            game->mapchip.dstin  = game->conf.work.adr + game->hero[hero_id].battle.draw_pos + XRGB((game->hero[hero_id].battle.draw_xpos + (j << MAPCHIP_SHIFT)));
            game->mapchip.dstout = game->mapchip.dstin;
            png_mapchip(game);
        }
    }
}


/**
 * @brief  選択中、又は行動中の仲間のフレームの描画
 * @note   指定した座標が中央に来るように描画する
 * 
 * @param  pos: 描画基本座標を指定
 * @retval None
 */
void player_frame_draw(GameWrapper *const game, uint32_t pos)
{
    game->mapchip.srcin		 = DRAM_UNIT_WAKU_ADDR_BASE;
    game->mapchip.maxwidth	 = SIZE_BATTLE_HERO_FRAME_WIDTH;
    game->mapchip.maxheight	 = SIZE_BATTLE_HERO_FRAME_HEIGHT;
    game->mapchip.draw_xsize = SIZE_BATTLE_HERO_FRAME_WIDTH;
    game->mapchip.draw_ysize = SIZE_BATTLE_HERO_FRAME_HEIGHT;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = 255;
    game->mapchip.id         = 0;
    game->mapchip.dstin      = game->conf.work.adr + pos - BATTLE_FRAME_HERO_ADJUST_POS;
    game->mapchip.dstout	 = game->mapchip.dstin;
    png_mapchip(game);
}


/*
 * 現在座標に操作キャラクターの描画を行う
 */
void player_draw(GameWrapper *const game)
{
	game->mapchip.srcin		 = DRAM_UNIT_ADDR_BASE;
	game->mapchip.maxwidth	 = SIZE_UNIT_WIDTH;
	game->mapchip.maxheight	 = SIZE_UNIT_HEIGHT;
	game->mapchip.draw_xsize = SIZE_UNIT_WIDTH;
    game->mapchip.draw_ysize = SIZE_UNIT_HEIGHT;
	game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
	game->mapchip.frame_size = VIDEO_WIDTH;
	game->mapchip.alpha		 = 255;
	game->mapchip.id         = game->unit.draw.mapchip_id;
	game->mapchip.dstin      = (game->unit.pos.unitx << RGB_BYTE_SHIFT) + (game->unit.pos.unity * MAX_V_WIDTH) + game->conf.work.adr;
	game->mapchip.dstout	 = game->mapchip.dstin;
	png_mapchip(game);
}


/*
 * キャラクターのアクション動作
 */
void unit_action_update(GameWrapper *const game, uint8_t sw)
{
    if (SW_A & sw)
    {
        if (JUMP_OFF == get_jump_motion())
        {
            bgm_update(game, SOUND_ID_JUMP, SOUND_CH_EFFECT2_WORK);
            set_jump_status(game);
        }
    }

    jump_move(game);
    adjust_unit_action(game);
}


/*
 * ver1.
 * スイッチ入力を読み取り方向を記憶する
 * 方向に応じてキャラクターのアニメーション用の切り抜き座標を更新する
 * ストーリーモード(マップ移動モード)中は1マスずつの移動を行うため、キャラクターの方向を移動完了まで保持しておき、移動完了まで入力を受け付けない
 * 3つのボタンを同時に押した場合、入力を受け付けない
 */
void direction_update_key(GameWrapper *const game, uint8_t sw)
{
    unit_mapchippos_update(game);
    
    if ((game->unit.pos.anime_cnt & ANIMATION_MAX_PIXEL_MASK) && (game->conf.display.system == SYSTEM_MAP_DEFAULT_WINDOW))
    {
        return;
    }

    switch (sw & SW_DIR_BIT)
    {
    case SW_RIGHT:
        game->unit.pos.unitdir = DIR_RIGHT;
        game->unit.pos.old_key = SW_RIGHT;
        break;

    case SW_LEFT:
        game->unit.pos.unitdir = DIR_LEFT;
        game->unit.pos.old_key = SW_LEFT;
        break;

    case SW_UP:
        game->unit.pos.unitdir = DIR_UP;
        game->unit.pos.old_key = SW_UP;
        break;

    case SW_DOWN:
        game->unit.pos.unitdir = DIR_DOWN;
        game->unit.pos.old_key = SW_DOWN;
        break;

    default:
        if (bit_count(sw & (sw ^ game->unit.pos.old_key)) < 2)
        {
            game->unit.pos.unitdir = (sw ^ game->unit.pos.old_key) & sw;
        }
        else
        {
            game->unit.pos.unitdir = DIR_WAIT;
        }
        break;
    }

    eventpos_update_key(game, sw & SW_A);
}


/*
 * キャラクターの現在座標の更新方法を管理する
 * 画面中央にキャラクターの座標が達したときに、マップの広さが画面サイズよりも大きければ
 * キャラクター座標の更新を停止しマップ座標の更新を始める
 * 移動アニメーション用のpixel数をカウントし、1マス分移動を行ったらカウントをクリアする
 * 
 * ミニゲームモード時はキャラクターそれぞれで移動スピードを管理するため
 * ミニゲーム時のみタイム関数を使用する
 */
void unit_pos_update(GameWrapper *const game)
{
    if (game->unit.pos.anime_cnt == 0)
    {
        int32_t pos = get_unit_index(game, game->unit.pos.unitdir);

        for (uint8_t i = 0; i < game->npc.number; i++)
        {
            if (game->npc.dram_index[i] == pos)
            {
                return;
            }
        }
    }

    switch (game->unit.pos.unitdir)
    {
    case DIR_RIGHT:
        unit_right(game);
        break;

    case DIR_LEFT:
        unit_left(game);
        break;

    case DIR_UP:
        unit_up(game);
        break;

    case DIR_DOWN:
        unit_down(game);
        break;

    default:
        game->unit.pos.anime_cnt = 0;
        break;
    }

    if (game->unit.pos.unitdir & SW_DIR_BIT)
	{
        game->unit.pos.encount++;
        game->unit.pos.anime_cnt += game->unit.pos.animation_pixel_x;
        if (game->unit.pos.anime_cnt == ANIMATION_MAX_PIXEL_NUM)
        {
            game->unit.pos.anime_cnt = 0;
            game->conf.display.drawtype = DISPLAY_FIELD_CENTER_DRAW;
        }
        // game->unit.pos.anime_cnt &= ANIMATION_MAX_PIXEL_MASK;
    }
}


/**
 * @brief  プレイヤーの現在座標から配列にアクセスするためのインデックスを取得する
 * @note   
 * @param  dir: インデックス調整用のプレイヤーの向きを指定する
 * DIR_RIGHT 右方向に移動した場合の調整を行う
 * DIR_LEFT 左方向に移動した場合の調整を行う
 * DIR_UP 上方向に移動した場合の調整を行う
 * DIR_DOWN 下方向に移動した場合の調整を行う
 * DIR_WAIT 向きによる調整をしない
 * 
 * @retval None
 */
int32_t get_unit_index(GameWrapper *const game, uint8_t dir)
{
    /* キャラクターの現在座標からインデックス番号を計算 */
    SDL_Rect unit_pos = {
        .x = (game->unit.pos.unitx + game->unit.pos.fieldx) >> MAPCHIP_SHIFT,
        .y = ((game->unit.pos.unity + game->unit.pos.fieldy) >> MAPCHIP_SHIFT) * get_mapsize('w'),
        .h = unit_pos.x + unit_pos.y,
    };

    switch (dir)
    {
    case DIR_RIGHT:
        return unit_pos.h + 1;

    case DIR_LEFT:
        return unit_pos.h - 1;

    case DIR_UP:
        return unit_pos.h - get_mapsize('w');

    case DIR_DOWN:
        return unit_pos.h + get_mapsize('w');

    default:
        return unit_pos.h;
    }
}


/*
 * ver1. 2021/06/24
 * スイッチ入力による、対象方向のイベント検出処理
 * 入力がなければ画面外の座標に設定し、入力が行われた場合に
 * キャラクターの向き + 1マス分の座標判定の値を保存する
 * 移動中は判定を行わない
 */
static void eventpos_update_key(GameWrapper *const game, uint8_t sw)
{
    static uint8_t old = 0;

    game->unit.pos.eventx = -1;
    game->unit.pos.eventy = -1;

    if ((old != sw) && (sw & SW_A))
    {
        switch (game->unit.pos.old_key)
        {
        case SW_RIGHT:
            game->unit.pos.eventx = game->unit.pos.unitx + game->unit.pos.fieldx + MAPCHIP_WIDTH;
            game->unit.pos.eventy = game->unit.pos.unity + game->unit.pos.fieldy;
            break;

        case SW_LEFT:
            game->unit.pos.eventx = game->unit.pos.unitx + game->unit.pos.fieldx - MAPCHIP_WIDTH;
            game->unit.pos.eventy = game->unit.pos.unity + game->unit.pos.fieldy;
            break;

        case SW_UP:
            game->unit.pos.eventx = game->unit.pos.unitx + game->unit.pos.fieldx;
            game->unit.pos.eventy = game->unit.pos.unity + game->unit.pos.fieldy - MAPCHIP_HEIGHT;
            break;

        case SW_DOWN:
            game->unit.pos.eventx = game->unit.pos.unitx + game->unit.pos.fieldx;
            game->unit.pos.eventy = game->unit.pos.unity + game->unit.pos.fieldy + MAPCHIP_HEIGHT;
            break;

        default:
            break;
        }
    }

    old = sw;
}


/*
 * キャラクターの右方向の座標更新
 * 
 */
static void unit_right(GameWrapper *const game)
{
    game->conf.display.drawtype = DISPLAY_FIELD_CENTER_DRAW;

    if ((MAPCHIP_DRAW_MAX_WIDTH + (game->unit.pos.unitx >> MAPCHIP_SHIFT)) >= get_mapsize('w'))
    {
        game->unit.pos.unitx += game->unit.pos.animation_pixel_x;
    }
    else if ((game->unit.pos.unitx >> MAPCHIP_SHIFT) >= (MAPCHIP_DRAW_MAX_WIDTH >> 1))
    {
        game->conf.display.drawtype = DISPLAY_FIELD_RIGHT_DRAW;
        game->unit.pos.fieldx += game->unit.pos.animation_pixel_x;
    }
    else
    {
        game->unit.pos.unitx += game->unit.pos.animation_pixel_x;
    }
}


/*
 * キャラクターの左方向の座標更新
 */
static void unit_left(GameWrapper *const game)
{
    game->conf.display.drawtype = DISPLAY_FIELD_CENTER_DRAW;

    if ((game->unit.pos.unitx >> MAPCHIP_SHIFT) > (MAPCHIP_DRAW_MAX_WIDTH >> 1))
    {
        game->unit.pos.unitx -= game->unit.pos.animation_pixel_x;
    }
    else if (game->unit.pos.fieldx != 0)
    {
        game->conf.display.drawtype = DISPLAY_FIELD_LEFT_DRAW;
        game->unit.pos.fieldx -= game->unit.pos.animation_pixel_x;
    }
    else
    {
        game->unit.pos.unitx -= game->unit.pos.animation_pixel_x;
    }
}


/*
 * キャラクターの上方向の座標更新
 */
static void unit_up(GameWrapper *const game)
{
    game->conf.display.drawtype = DISPLAY_FIELD_CENTER_DRAW;

    if ((MAPCHIP_DRAW_MAX_HEIGHT >> 1) < ((game->unit.pos.unity - game->unit.pos.animation_pixel_y) >> MAPCHIP_SHIFT))
    {
        game->unit.pos.unity -= game->unit.pos.animation_pixel_y;
    }
    else if (game->unit.pos.fieldy != 0)
    {
        game->conf.display.drawtype = DISPLAY_FIELD_UP_DRAW;
        game->unit.pos.fieldy -= game->unit.pos.animation_pixel_y;
    }
    else
    {
        game->unit.pos.unity -= game->unit.pos.animation_pixel_y;
    }
}


/*
 * キャラクターの下方向の座標更新
 */
static void unit_down(GameWrapper *const game)
{
    game->conf.display.drawtype = DISPLAY_FIELD_CENTER_DRAW;
    
    if (get_mapsize('h') <= (MAPCHIP_DRAW_MAX_HEIGHT + (game->unit.pos.fieldy >> MAPCHIP_SHIFT)))
    {
        game->unit.pos.unity += game->unit.pos.animation_pixel_y;
    }
    else if ((MAPCHIP_DRAW_MAX_HEIGHT >> 1) < (game->unit.pos.unity >> MAPCHIP_SHIFT))
    {
        game->conf.display.drawtype = DISPLAY_FIELD_DOWN_DRAW;
        game->unit.pos.fieldy += game->unit.pos.animation_pixel_y;
    }
    else
    {
        game->unit.pos.unity += game->unit.pos.animation_pixel_y;
    }
}



/*
 * 一定時間経過したらキャラクターの歩行画像データの切り抜き座標を更新
 */
static void unit_mapchippos_update(GameWrapper *const game)
{
    static uint32_t t = 0;

	if (true == tmr_constant(&t, PLAYER_RATE))
	{
		game->unit.draw.workpos++;
		t = get_time();
	}

    switch (game->unit.pos.unitdir)
    {
    case DIR_RIGHT:
        game->unit.draw.cutpos = UNIT_CUT_RIGHT + game->unit.draw.chara_chipid;
        break;

    case DIR_LEFT:
        game->unit.draw.cutpos = UNIT_CUT_LEFT + game->unit.draw.chara_chipid;
        break;

    case DIR_UP:
        game->unit.draw.cutpos = UNIT_CUT_UP + game->unit.draw.chara_chipid;
        break;

    case DIR_DOWN:
        game->unit.draw.cutpos = UNIT_CUT_DOWN + game->unit.draw.chara_chipid;
        break;

    default:
        game->unit.draw.workpos = UNIT_WORK_TYPE_CENTER;
        break;
    }

    switch (game->unit.draw.workpos & UNIT_WALK_TYPE_NUM)
    {
    case UNIT_WORK_TYPE_LEFT:
        game->unit.draw.mapchip_id = UNIT_WORK_TYPE_LEFT + game->unit.draw.cutpos;
        break;

    case UNIT_WORK_TYPE_CENTER:
        game->unit.draw.mapchip_id = UNIT_WORK_TYPE_CENTER + game->unit.draw.cutpos;
        break;

    case UNIT_WORK_TYPE_RIGHT:
        game->unit.draw.mapchip_id = UNIT_WORK_TYPE_RIGHT + game->unit.draw.cutpos;
        break;

    default:
        game->unit.draw.mapchip_id = UNIT_WORK_TYPE_CENTER + game->unit.draw.cutpos;
        break;
    }
}


/*
 * ミニゲーム時のアクション時にキャラクターの座標を調整する
 * 当たり判定の範囲
 * 1マスの0 ~ 高さの最大値(y = 0, y = SIZE_UNIT_HEIGHT - 1)の判定を行い座標を更新する
 */
static void adjust_unit_action(GameWrapper *const game)
{
    if (game->unit.pos.unity < 0)   /* 画面上部に達した時の処理 */
    {
        game->unit.pos.unity = 0;
    }

    if (SIZE_UNIT_MAX_YDRAW <= game->unit.pos.unity)    /* ジャンプ時の画面下部の座標処理 */
    {
        set_jump_motion(JUMP_OFF);
    }
    
    switch (game->unit.pos.unitdir)
    {
    case DIR_RIGHT:
        if (SIZE_UNIT_MAX_XDRAW < game->unit.pos.unitx)
        {
            game->unit.pos.unitx -= game->unit.pos.animation_pixel_x;
        }
        break;

    case DIR_LEFT:
        if (game->unit.pos.unitx < 0)
        {
            game->unit.pos.unitx += game->unit.pos.animation_pixel_x;
        }
        break;

    default:
        break;
    }

}


/*
 * ver1. 2021/08/01
 * 仲間の死亡状態を確認し、プレーヤー描画関数のループ回数を指定する
 */
static uint8_t get_dynig_chip(GameWrapper *const game, uint8_t hero_id)
{
    if (game->conf.battle.hero.anime_order[hero_id] == BATTLE_HERO_CHIP_DEATH_1)
    {
        return 2;
    }

    return 1;
}
