/*
 * ミニゲームの関数を管理するファイル
 */

#include "../wrapper/game_wrapper.h"
#include "minigame.h"
#include "minigame_struct.h"

#ifdef MYDEBUG
#include "xil_io.h"
#endif

#define MINIGAME_FUNC_DB_SIZE ((sizeof (minigame_state))/(sizeof (MinigameState)))


/*
 * 構造体の確保
 */
static BombWork   bombwork;
static ScoreBoard scoreboard;
static PlayTimer  playtimer;



/* 状態遷移関数 */
static void barrage_sd_load(GameWrapper *const game);
static void barrage_minigame_title(GameWrapper *const game);
static void barrage_player_select(GameWrapper *const game);
static void barrage_game_play(GameWrapper *const game);
static void barrage_result(GameWrapper *const game);

/* コンフィグ関数 */
static void barrage_character_update(GameWrapper *const game, uint8_t unit_id);
static void barrage_unit_reset(GameWrapper *const game);
static void barrage_unitselect_draw(GameWrapper *const game);
static void barrage_object_reset(GameWrapper *const game);
static void barrage_bomb_draw(GameWrapper *const game);
static void barrage_time_draw(GameWrapper *const game);
static void barrage_score_draw(GameWrapper *const game, uint8_t mode);
static void barrage_bomb_use(GameWrapper *const game, uint8_t sw);


/**
 * @brief  ミニゲームの状態遷移関数を管理するデータベース
 * @note   
 * @retval None
 */
typedef struct
{
	uint8_t id;
	void (*minigame)(GameWrapper *const game);
} MinigameState;

static const MinigameState minigame_state[] = {
	{MINIGAME_START_LOAD_ID,	barrage_sd_load			},
	{MINIGAME_TITLE_DRAW_ID,	barrage_minigame_title	},
	{MINIGAME_UNIT_SELECT_ID,	barrage_player_select	},
	{MINIGAME_PLAYING_ID,		barrage_game_play		},
	{MINIGAME_RESULT_DRAW_ID,	barrage_result			},
};


/*
 * 弾幕ミニゲームを管理
 * タイトル画面時にBボタンでミニゲームを終了する
 */
void barrage_mingame(GameWrapper *const game)
{
	const MinigameState *p = minigame_state;

	for (uint8_t i = 0; i < MINIGAME_FUNC_DB_SIZE; i++, p++)
	{
		if (game->conf.display.sub_state == p->id)
		{
			p->minigame(game);
			break;
		}
	}
}


/*
 * 弾幕の踏みつけ時に得点の計算を行う
 */
void set_score(GameWrapper *const game, uint32_t step_on_count, uint32_t bullet_speed)
{
    ScoreBoard *sb = &scoreboard;

    for (uint8_t i = 0; i < MINIGAME_SCORE_TOTAL_ID_END; i++)
    {
        if (fetch_dram_db(game, MEMORY_MINIGAME_SCORE_ID, i, MINIGAME_SUB_MEMBER_TIME) < bullet_speed)
        {
			sb->score += (fetch_dram_db(game, MEMORY_MINIGAME_SCORE_ID, i, MINIGAME_SUB_MEMBER_SCORE1 + step_on_count) + (33 * get_jump_count()));
            break;
        }
    }

    if (SCORE_MAX < sb->score)
    {
        sb->score = SCORE_MAX;
    }
}


/**
 * @brief  弾幕ミニゲームの起動時のロード処理
 * @note   
 * @param  game: 
 * @retval None
 */
static void barrage_sd_load(GameWrapper *const game)
{
	bgm_stop();

	static const uint8_t barrage_init[] =
	{
		FILE_ACCESS_MAPDATA_MINIGAME,
		FILE_ACCESS_BACK_YUUHI,
	};

    static const uint8_t sound_init[] =
	{
        FILE_ACCESS_BGM_COIN,
		FILE_ACCESS_BGM_JUMP,
		FILE_ACCESS_BGM_BOM,
		FILE_ACCESS_BGM_PITYN,
		FILE_ACCESS_BGM_ENDING,
    };

	for (uint8_t i = 0; i < NUM(barrage_init); i++)
	{
		sd_fread(barrage_init[i]);
	}

	for (uint8_t i = 0; i < NUM(sound_init); i++)
	{
		file_sound_load(sound_init[i]);
	}
	game->conf.display.sub_state = MINIGAME_TITLE_DRAW_ID;

#ifdef MYDEBUG
	xil_printf("SD Barrage Read End\r\n");
#endif
}


/**
 * @brief  ミニゲームのタイトル画面の描画処理
 * @note   
 * @retval None
 */
static void barrage_minigame_title(GameWrapper *const game)
{
	patblt(game->conf.work.adr, 0, 0, VIDEO_WIDTH, VIDEO_HEIGHT, COLOR_BLACK);

	switch (get_key(false))
	{
	case SW_A:
		game->conf.display.sub_state = MINIGAME_UNIT_SELECT_ID;
		bgm_update(game, SOUND_ID_CMD_BUTTON, SOUND_CH_KEY_WORK);
		break;

	case SW_B:
		game->conf.display.system  = SYSTEM_NEXT_ALLDATA_READING;
		game->conf.display.uncommon_window = 0;
		game->conf.animation.count = 0;
		game->conf.event.id   	   = DIRECT_ROMEN_ID_EXIT;
		game->conf.event.type 	   = EVENT_TYPE_WORLD_STATE_OTHER_MAP;		
		break;

	default:
		break;
	}
}


/**
 * @brief  キャラクターの選択を行い、選択後に次の状態の設定を行う
 * 
 * @note   現在のフレームバッファ領域にミニゲームの画面の描画を行った後に、バックアップ領域に描画データをコピーしておく
 *         ミニゲーム中はマップやバックグラウンドの画像データの変更は行わないため、バックアップ領域のデータをコピーだけすればよく
 *         処理速度の改善を行うことができる
 * 
 * @param  game: 
 * @retval None
 */
static void barrage_player_select(GameWrapper *const game)
{
	patblt(game->conf.work.adr, 0, 0, VIDEO_WIDTH, VIDEO_HEIGHT, COLOR_DARK_BLUE);
	barrage_unitselect_draw(game);

	if (SW_A == cmd_key(game))
	{
		/* 初期化処理 */
		barrage_character_update(game, game->cmd.cursol.y);
		file_sound_load(fetch_dram_db(game, MEMORY_MINIGAME_MSG_ID, game->cmd.cursol.y, MINIGAME_SUB_MEMBER_SOUND_ID));
		bgm_update(game, fetch_dram_db(game, MEMORY_MINIGAME_MSG_ID, game->cmd.cursol.y, MINIGAME_SUB_MEMBER_BGM_ID), SOUND_CH_BGM_WORK);
		barrage_unit_reset(game);
		animation_reset();
		barrage_object_reset(game);
		shooting_reset();
		background_draw(game, DRAM_BACKGROUND_ADDR_BASE);
		standerd_game(game);
		framebuffer_copy(game->conf.work.adr, DRAM_BACKUP_FBUF_ADDR_BASE, VIDEO_WIDTH, VIDEO_HEIGHT, VIDEO_WIDTH);
		game->conf.display.uncommon_window = 0;
		game->conf.display.sub_state = MINIGAME_PLAYING_ID;
	}
}


/*
 * 弾幕避けゲームモードの管理
 * 弾幕に被弾したら処理を終える
 */
static void barrage_game_play(GameWrapper *const game)
{
	if (game->conf.display.uncommon_window == 0)
	{
		uint8_t sw = get_key(true);
		direction_update_key(game, sw);
		unit_pos_update(game);
		unit_action_update(game, sw);
		bullet_pos_update(game);
		barrage_bomb_use(game, sw);
	}

	framebuffer_copy(DRAM_BACKUP_FBUF_ADDR_BASE, game->conf.work.adr, VIDEO_WIDTH, VIDEO_HEIGHT, VIDEO_WIDTH);
	player_draw(game);
	barrage_score_draw(game, DRAW_SCORE_ID);
	barrage_bomb_draw(game);
	barrage_time_draw(game);
	bullet_draw(game);
	realtime_effect_draw(game, EFFECT_STEP_ON_ID);
	realtime_effect_draw(game, EFFECT_BOMB_ID);

	if (false == realtime_effect_draw(game, EFFECT_PITYUN_ID))
	{
		game->conf.display.sub_state = MINIGAME_RESULT_DRAW_ID;
		barrage_unit_reset(game);
		bgm_stop();
		bgm_update(game, SOUND_ID_ENDING, SOUND_CH_BGM_WORK);
	}
}

/**
 * @brief  リザルトモードの描画処理
 * @note   
 * @retval None
 */
static void barrage_result(GameWrapper *const game)
{
	framebuffer_copy(DRAM_BACKUP_FBUF_ADDR_BASE, game->conf.work.adr, VIDEO_WIDTH, VIDEO_HEIGHT, VIDEO_WIDTH);
	player_draw(game);
	barrage_score_draw(game, DRAW_RESULT_ID);

	if (SW_A == cmd_key(game))
	{
		game->conf.display.sub_state = MINIGAME_TITLE_DRAW_ID;
		bgm_stop();
	}
}


/*
 * ミニゲームのキャラクターのステータスの保存
 */
static void barrage_character_update(GameWrapper *const game, uint8_t unit_id)
{
    game->unit.draw.chara_chipid      = fetch_dram_db(game, MEMORY_MINIGAME_MSG_ID, unit_id, MINIGAME_SUB_MEMBER_CHIP_ID);
    game->unit.action.move_speed      = fetch_dram_db(game, MEMORY_MINIGAME_MSG_ID, unit_id, MINIGAME_SUB_MEMBER_MOVE_SPEED);
    game->unit.action.jump_rise_speed = fetch_dram_db(game, MEMORY_MINIGAME_MSG_ID, unit_id, MINIGAME_SUB_MEMBER_JUMP_RISESPEED);
	game->unit.action.jump_fall_speed = fetch_dram_db(game, MEMORY_MINIGAME_MSG_ID, unit_id, MINIGAME_SUB_MEMBER_JUMP_FALLSPEED);
	game->unit.action.jump_height     = fetch_dram_db(game, MEMORY_MINIGAME_MSG_ID, unit_id, MINIGAME_SUB_MEMBER_JUMP_HEIGHT);
	game->unit.action.bomb_number     = fetch_dram_db(game, MEMORY_MINIGAME_MSG_ID, unit_id, MINIGAME_SUB_MEMBER_BOMB_NUMBER);
}


/* 
 * キャラクターの座標データのリセット
 */
static void barrage_unit_reset(GameWrapper *const game)
{
	game->conf.map.back				= DRAM_MAPDATA_ADDR_START;
	game->conf.map.obj				= DRAM_MAPDATA_ADDR_START;
    game->conf.display.system       = SYSTEM_MINIGAME_WINDOW;
    game->conf.display.drawtype		= DISPLAY_FIELD_CENTER_DRAW;
    game->unit.pos.fieldy      		= 0;
    game->unit.pos.fieldx      		= 0;
    game->unit.pos.unitx       		= VIDEO_WIDTH >> 1;
    game->unit.pos.unity       		= VIDEO_HEIGHT-SIZE_UNIT_HEIGHT-MAPCHIP_HEIGHT;
	game->unit.pos.unitdir	  		= DIR_WAIT;
	game->unit.pos.animation_pixel_x = ANIMATION_MINIGAME_PIXEL_X;
	game->unit.pos.animation_pixel_y = ANIMATION_MINIGAME_PIXEL_Y;
	game->unit.draw.workpos    		= UNIT_WORK_TYPE_CENTER;
	game->unit.draw.cutpos     		= UNIT_CUT_DOWN + game->unit.draw.chara_chipid;
	game->unit.draw.mapchip_id 		= UNIT_WORK_TYPE_CENTER + game->unit.draw.cutpos;
}


/*
 * オブジェクト構造体のリセット
 */
static void barrage_object_reset(GameWrapper *const game)
{
    BombWork *bomb = &bombwork;
    ScoreBoard *sb = &scoreboard;
    PlayTimer *p   = &playtimer;

    bomb->number         = game->unit.action.bomb_number;
    bomb->animation_time = 0;
    bomb->mapchip_id     = MAPFILE_ACCESS_CHIP_MINIGAME_BOMB1;
    bomb->used           = false;
    sb->score            = 0;
    p->play_timer        = 0;
    p->count             = 0;
}


/*
 * キャラクター選択画面のキャラクターと説明文の描画
 */
static void barrage_unitselect_draw(GameWrapper *const game)
{
	static const uint8_t chip[] = {
		MAPCHIP_MINORIKO,
		MAPCHIP_SIZUHA,
		MAPCHIP_KANAKO,
		MAPCHIP_KOGASA,
		MAPCHIP_YUUKA,
		MAPCHIP_REMIRIA,
		MAPCHIP_SATORI,
		MAPCHIP_TENSI,
	};

    for (uint32_t i = 0; i < game->conf.system.paty_member; i++)
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
		game->mapchip.id 	 	 = chip[i];
		game->mapchip.dstin  	 = MINIGAME_UNIT_XPOS + (MAPCHIP_WIDTH * (MAX_V_WIDTH * i)) + game->conf.work.adr;
		game->mapchip.dstout 	 = game->mapchip.dstin;
        png_mapchip(game);
		font_dram_draw(game, MINIGAME_MSG_XPOS, MINIGAME_MSG_YPOS + (i << MAPCHIP_SHIFT), MEMORY_MINIGAME_MSG_ID, i, MINIGAME_SUB_MEMBER_MSG, COLOR_WHITE);
    }
}


/*
 * ボムの残り個数分描画を行う
 */
static void barrage_bomb_draw(GameWrapper *const game)
{
    BombWork *bomb = &bombwork;

    if (bomb->number == 0)
    {
        return;
    }

	if (true == tmr_constant(&bomb->animation_time, TM_500MS_COUNT))
	{
		if (bomb->mapchip_id == MAPFILE_ACCESS_CHIP_MINIGAME_BOMB1)
		{
			bomb->mapchip_id = MAPFILE_ACCESS_CHIP_MINIGAME_BOMB2;
		}
		else
		{
			bomb->mapchip_id = MAPFILE_ACCESS_CHIP_MINIGAME_BOMB1;
		}
        bomb->animation_time = get_time();
	}

    game->mapchip.srcin		 = DRAM_MINIGAME_FRAME_ADDR_BASE;
    game->mapchip.maxwidth	 = MAPCHIP_WIDTH;
    game->mapchip.maxheight	 = MAPCHIP_HEIGHT;
    game->mapchip.draw_xsize = MAPCHIP_WIDTH;
    game->mapchip.draw_ysize = MAPCHIP_HEIGHT;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = COLOR_ALPHA_MAX;
    game->mapchip.id         = bomb->mapchip_id;
	game->mapchip.cut_color  = COLOR_WHITE;

    for (uint8_t i = 0; i < bomb->number; i++)
    {
        game->mapchip.dstin  = ((VIDEO_WIDTH - (MAPCHIP_WIDTH * (i+1))) << RGB_BYTE_SHIFT) + BOMB_DRAW_YPOS + game->conf.work.adr;
        game->mapchip.dstout = game->mapchip.dstin;
		put_mapchip(game);
    }
}


/*
 * 経過時間の描画
 *
 * カウント値から分秒を抽出
 * 分秒の画像データを描画してからドットを描画する
 */
static void barrage_time_draw(GameWrapper *const game)
{
    PlayTimer *p = &playtimer;

    if (true == tmr_constant(&p->play_timer, TM_1SEC_COUNT))
    {
        p->count++;
        p->play_timer = get_time();
    }

    uint32_t sec  = p->count;
    uint32_t minu = (sec % 3600) / 60;
    sec = sec % 60;
    uint32_t time = (minu * 100) + sec;
    game->mapchip.srcin		 = DRAM_FONT_ADDR_BASE;
    game->mapchip.maxwidth	 = SIZE_FONT_NUMBER_WIDTH;
    game->mapchip.maxheight	 = SIZE_FONT_NUMBER_HEIGHT;
    game->mapchip.draw_xsize = SIZE_FONT_NUMBER_WIDTH;
    game->mapchip.draw_ysize = SIZE_FONT_NUMBER_HEIGHT;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = 255;
    game->mapchip.cut_color  = COLOR_WHITE;

    for (uint8_t j = 0; j < 2; j++)
    {
        for (uint32_t i = 0; i < 2; i++)
        {
            uint32_t adr = ((TIME_DRAW_XPOS - (SIZE_FONT_NUMBER_WIDTH * (i + j * 3))) << RGB_BYTE_SHIFT) + TIME_DRAW_YPOS;
            game->mapchip.dstin      = adr + DRAM_BACKUP_FBUF_ADDR_BASE;
            game->mapchip.dstout     = adr + game->conf.work.adr;
            game->mapchip.id = time % 10;
            time /= 10;
            put_mapchip(game);
        }
    }
    game->mapchip.dstin  = TIME_PERIOD_DRAW_POS + DRAM_BACKUP_FBUF_ADDR_BASE;
    game->mapchip.dstout = TIME_PERIOD_DRAW_POS + game->conf.work.adr;
    game->mapchip.id = MAPCCHIP_PERIOD;
    put_mapchip(game);
}


/*
 * ミニゲーム時の現在のスコアの描画
 */
static void barrage_score_draw(GameWrapper *const game, uint8_t mode)
{
    PlayTimer *time = &playtimer;
    ScoreBoard *p   = &scoreboard;
    uint32_t score  = p->score;
    uint32_t ypos   = SCORE_DRAW_YPOS;
    uint32_t xpos   = SIZE_FONT_NUMBER_WIDTH;
    uint32_t xstart = 0;

	game->mapchip.xstart_pos = 0;
	game->mapchip.ystart_pos = 0;
	game->mapchip.frame_size = VIDEO_WIDTH;
	game->mapchip.alpha		 = COLOR_ALPHA_MAX;
	game->mapchip.srcin      = DRAM_FONT_ADDR_BASE;
	game->mapchip.maxwidth	 = SIZE_FONT_NUMBER_WIDTH;
	game->mapchip.maxheight	 = SIZE_FONT_NUMBER_HEIGHT;
	game->mapchip.draw_xsize = SIZE_FONT_NUMBER_WIDTH;
	game->mapchip.draw_ysize = SIZE_FONT_NUMBER_HEIGHT;
	game->mapchip.draw_ysize = SIZE_FONT_NUMBER_HEIGHT;
	game->mapchip.cut_color  = COLOR_WHITE;

	if (mode == DRAW_RESULT_ID)
	{
        score  = p->score * (time->count >> 3);
        ypos   = RESULT_DRAW_YPOS;
        xpos   = SIZE_FONT_RESULT_WIDTH;
        xstart = (VIDEO_WIDTH - (SIZE_FONT_RESULT_WIDTH * SCORE_DIGIT_NUMBER)) >> 2;
        game->mapchip.srcin      = DRAM_FONT_RESULT_ADDR_BASE;
        game->mapchip.maxwidth	 = SIZE_FONT_RESULT_WIDTH;
        game->mapchip.maxheight	 = SIZE_FONT_RESULT_HEIGHT;
        game->mapchip.draw_xsize = SIZE_FONT_RESULT_WIDTH;
        game->mapchip.draw_ysize = SIZE_FONT_RESULT_HEIGHT;
	}

    for (uint32_t i = 0; i < SCORE_DIGIT_NUMBER; i++)
    {
        uint32_t adr = ((((SCORE_DIGIT_NUMBER - i) * xpos) + xstart) << RGB_BYTE_SHIFT) + ypos;
        game->mapchip.id = score % 10;
        score /= 10;
        game->mapchip.dstin  = adr + DRAM_BACKUP_FBUF_ADDR_BASE;
		game->mapchip.dstout = adr + game->conf.work.adr;
		put_mapchip(game);
    }
}


/*
 * ボムの使用回数を減らしボムのエフェクトを描画する
 */
static void barrage_bomb_use(GameWrapper *const game, uint8_t sw)
{
    if (SW_B & sw)
    {
        BombWork *bomb = &bombwork;
        if ((bomb->number != 0) && (EFFECT_OFF == get_effect_trigger(EFFECT_BOMB_ID)))
        {
            bomb->number--;
            bgm_update(game, SOUND_ID_BOMB, SOUND_CH_EFFECT2_WORK);
            shooting_reset();
            set_effect_trigger(EFFECT_ON, EFFECT_BOMB_ID);
        }
    }
}