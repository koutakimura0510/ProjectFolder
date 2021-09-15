/*
 * Create 2021/06/22
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * IC      XC7Z020-1CLG400C
 * ROM     256KB
 * RAM     512KB
 * L1Cache 32KB
 * -
 * ストーリーモードのオープニングに関する関数を管理するファイル
 */
#include "../wrapper/game_wrapper.h"
#include "opening.h"

#ifdef MYDEBUG
	// #include "xil_io.h"
	#include "xil_printf.h"
#endif


/* demoウィンドウを描画する時にコメントを外す */
#define DEMO_WINDOW_ON


/* ファイル内関数 */
static void config_initialize(GameWrapper *const game);


/*
 * ver2. 2021/08/13
 * ゲージの描画を追加
 *
 * ver1. 2021/07/30
 * ロード画面の作成
 */
void load_display_draw(GameWrapper *const game)
{
	patblt(game->conf.work.adr, 0, 0, VIDEO_WIDTH, VIDEO_HEIGHT, COLOR_BLACK);
	game->conf.animation.count = ((game->conf.display.uncommon_window * DIG_3_FIX) / game->conf.animation.acc) + 1;
	font_dram_draw(game, LOAD_FONT_XDRAW_POS, LOAD_FONT_YDRAW_POS, MEMORY_CMD_MSG_ID, CMD_MSG_ID_LOAD_GAME_1, EVENT_MSG_SUB_MSG, COLOR_WHITE);
	patblt(game->conf.work.adr, LOAD_GAUGE_XSTART_WHITE, LOAD_GAUGE_YSTART_WHITE, LOAD_GAUGE_WIDTH_WHITE, LOAD_GAUGE_HEIGHT_WHITE, COLOR_WHITE);
	patblt(game->conf.work.adr, LOAD_GAUGE_XSTART_BLACK, LOAD_GAUGE_YSTART_BLACK, LOAD_GAUGE_WIDTH_BLACK, LOAD_GAUGE_HEIGHT_BLACK, COLOR_BLACK);
	patblt(game->conf.work.adr, LOAD_GAUGE_XSTART_ATB,   LOAD_GAUGE_YSTART_ATB,   game->conf.animation.count, LOAD_GAUGE_HEIGHT_ATB, COLOR_GREEN_SPRING);
}


/*
 * ver3. 2021/07/02
 * タイトル処理をシステムの関数ポインタと結合
 * 
 * ver2. 2021/06/28
 * タイトル画面のアニメーション処理追加
 */
void story_opening_mode(GameWrapper *const game)
{
#ifdef MYDEBUG_SDREAD
	debug_sdread(game);
	return;
#endif

	const OpeningState *p = opening_state;

	for (uint8_t i = 0; i < OPENING_FUNC_DB_SIZE; i++, p++)
	{
		if (game->conf.display.sub_state == p->system)
		{
			p->opening_func(game);
			break;
		}
	}
}


/*
 * ver1. 2021/07/21
 * main関数内で呼び出しを行う。
 * 起動時の周辺機器の初期設定を行う。
 */
void opening_hardware_init(GameWrapper *const game)
{
	sdread_image_init();
	dtmwork_init();
	fpga_mapchip_init();
	vdma_init();
	timer_init();
	frame_buffer_clear();

#ifdef DEMO_WINDOW_ON
	game->conf.display.sub_state = OPENING_DEMO_WINDOW;
#else
	game->conf.display.sub_state = OPENING_BITMAP_LOAD;
#endif
}


/**
 * @brief  起動時のデモ動作用の映像データを出力する
 * @note   
 * @retval None
 */
static void opening_demo_window(GameWrapper *const game)
{
	patblt(DEMO_WINDOW_CENTER_POS, 0, 0, DEMO_WINDOW_FILL_XSIZE, DEMO_WINDOW_FILL_YSIZE, game->conf.display.uncommon_window);
	game->mapchip.srcin      = DEMO_WINDOW_CENTER_POS;
	game->mapchip.dstin      = DEMO_WINDOW_CENTER_POS;
	game->mapchip.dstout     = game->conf.work.adr;
	game->mapchip.maxwidth   = DEMO_WINDOW_FILL_XSIZE;
	game->mapchip.maxheight  = DEMO_WINDOW_FILL_YSIZE;
	game->mapchip.alpha      = COLOR_ALPHA_MAX;
	game->mapchip.id         = 0;
	affine_roulette(game);

	if (true == tmr_constant(&game->conf.animation.count, TM_100MS_COUNT))
	{
		game->mapchip.rad += 15;

		if (359 < game->mapchip.rad)
		{
			game->mapchip.rad = 0;
		}

		game->conf.animation.count = get_time();
	}

	for (uint32_t i = 0; i < COLOR_NUMBER_RBG; i++)
	{
		if (true == tmr_constant(&game->conf.battle.effect.com_time[i], TM_10MS_COUNT + (i * TM_20MS_COUNT)))
		{
			uint32_t bit  = i << COLOR_NUMBER_RBG;
			uint32_t mask = (MAX_32BIT ^ (MAX_8BIT << bit));
			game->conf.battle.effect.com_time[i] = get_time();
			game->conf.display.uncommon_window   = mask | ((((game->conf.display.uncommon_window >> bit) + 1) & COLOR_MAX_MASK) << bit);
		}
	}

	if (SW_A & get_key(false))
	{
		game->conf.display.sub_state = OPENING_BITMAP_LOAD;
		game->conf.display.uncommon_window = 0;
		game->conf.animation.count = 0;
		game->conf.animation.acc = NUM(bitmap_init) + NUM(sound_init);
	}
}


/*
 * ver2 2021/07/21
 * オープニング状態遷移の処理を関数ポインタで行うように変更
 *
 * オープニングデータの初期データを読み込み
 */
static void opening_bitmap_load(GameWrapper *const game)
{
	sd_fread(bitmap_init[game->conf.display.uncommon_window]);
	game->conf.display.uncommon_window++;
	load_display_draw(game);

	if (game->conf.display.uncommon_window == NUM(bitmap_init))
	{
		game->conf.display.sub_state = OPENING_MUSIC_LOAD;

#ifdef MYDEBUG
		xil_printf("BITMAP Read End\r\n");
#endif
	}
}

/*
 * ver2 2021/08/13
 *
 * システムの動作に使用する音源データファイルをロードする
 */
static void opening_music_load(GameWrapper *const game)
{
	file_sound_load(sound_init[game->conf.display.uncommon_window - NUM(bitmap_init)]);
	game->conf.display.uncommon_window++;
	load_display_draw(game);

	if ((game->conf.display.uncommon_window - NUM(bitmap_init)) == NUM(sound_init))
	{
		game->conf.display.sub_state = OPENING_DB_LOAD;
#ifdef MYDEBUG
		xil_printf("MUSIC Read End\r\n");
#endif
	}
}


/*
 * ver1. 2021/07/21
 * オープニングのカーソル位置の初期設定
 */
static void opening_db_load(GameWrapper *const game)
{
	cmd_db_reset(game, COMMAND_OPENING_SYSTEM, 1);
	bgm_update(game, SOUND_ID_TITLE, SOUND_CH_BGM_WORK);
	game->conf.display.sub_state = OPENING_SYSTEM_DRAW;
}


/*
 * ver. 2021/06/28
 * タイトル画面の背景描画
 */
static void opening_title_draw(GameWrapper *const game)
{
	game->mapchip.maxwidth   = VIDEO_WIDTH;
	game->mapchip.maxheight  = VIDEO_HEIGHT;
	game->mapchip.draw_xsize = VIDEO_WIDTH;
	game->mapchip.draw_ysize = VIDEO_HEIGHT;
	game->mapchip.xstart_pos = 0;
	game->mapchip.ystart_pos = 0;
	game->mapchip.frame_size = VIDEO_WIDTH;
	game->mapchip.id 		 = 0;
	game->mapchip.srcin      = DRAM_TITLE_1_ADDR_BASE;
	game->mapchip.dstin      = DRAM_TITLE_1_ADDR_BASE;
	game->mapchip.dstout     = game->conf.work.adr;
	game->mapchip.alpha		 = COLOR_ALPHA_MAX;
	game->mapchip.cut_color	 = COLOR_WHITE;
	put_mapchip(game);
	cursol_draw(game, OPENING_CURSOL_DEFAULT_POS, OPENING_CURSOL_INTERVAL_YPOS, CURSOL_TYPE_DEFAULT_DRAW);

	// if (SW_A & cmd_key(game))
	// {
	// 	bgm_update(game, SOUND_ID_CMD_BUTTON2, SOUND_CH_KEY_WORK);
	// 	game->conf.display.sub_state = OPENING_SAVE_LOAD;
	// }

	static SDL_Rect rect = (SDL_Rect){0, 0, 0, 0,};
	static SDL_Timer timer = {0};

	game->mapchip.maxwidth   = SIZE_UNIT_WIDTH;
	game->mapchip.maxheight  = SIZE_UNIT_HEIGHT;
	game->mapchip.draw_xsize = VIDEO_WIDTH;
	game->mapchip.draw_ysize = VIDEO_HEIGHT;
	game->mapchip.xstart_pos = 0;
	game->mapchip.ystart_pos = 0;
	game->mapchip.frame_size = VIDEO_WIDTH;
	game->mapchip.srcin      = DRAM_UNIT_ADDR_BASE;
	game->mapchip.dstin      = game->conf.work.adr;
	game->mapchip.dstout     = game->conf.work.adr;
	game->mapchip.alpha      = COLOR_ALPHA_MAX;
	game->mapchip.a          = 100 + rect.w;
	game->mapchip.b          = 0;
	game->mapchip.c          = 0;
	game->mapchip.d          = 100 + rect.h;
	game->mapchip.m          = rect.x;
	game->mapchip.n          = rect.y;
	game->mapchip.id         = 0;
	affine_scale(game);

	game->mapchip.draw_xsize = SIZE_UNIT_WIDTH;
	game->mapchip.draw_ysize = SIZE_UNIT_HEIGHT;
	game->mapchip.srcin      = DRAM_UNIT_ADDR_BASE;
	game->mapchip.dstin      = game->conf.work.adr;
	game->mapchip.id         = 0;
	affine_roulette(game);

	if (true == tmr_constant(&timer.count, TM_100MS_COUNT))
	{
		game->mapchip.rad += 30;

		if (359 < game->mapchip.rad)
		{
			game->mapchip.rad = 0;
		}

		timer.count = get_time();
	}

	switch (get_key(true))
	{
	case SW_RIGHT:
		rect.w+=8;
		break;

	case SW_LEFT:
		rect.w-=8;
		break;

	case SW_UP:
		rect.h+=8;
		break;

	case SW_DOWN:
		rect.h-=8;
		break;

	case SW_A_RIGHT:
		rect.x+=4;
		break;

	case SW_A_LEFT:
		rect.x-=4;
		break;

	case SW_A_UP:
		rect.y+=4;
		break;

	case SW_A_DOWN:
		rect.y-=4;
		break;

	default:
		break;
	}
}


/* TODO セーブデータ処理追加
 * ver1. 2021/06/28
 * 読み込んだセーブデータの情報からファイルの読み込むデータを参照しDRAMに保存する
 */
static void opening_savedata_load(GameWrapper *const game)
{
	bgm_stop();

	if (game->cmd.sub_system == COMMAND_OPENING_MINIGAME)
	{
		game->conf.display.system = SYSTEM_MINIGAME_WINDOW;
		return;
	}

	config_initialize(game);
	hero_initialize(game);
	bgm_load(game, SOUND_ID_FIELD_GEKAI);	//今はとりあえずフィールド音源を流す
	bgm_update(game, SOUND_ID_FIELD_GEKAI, SOUND_CH_BGM_WORK);
}


/* TODO
 * ここでセーブデータファイルを全て読み込み
 * 構造体に保存するように変更する
 *
 * ver1. 2021/07/27
 * セーブデータを読み込みコンフィグの初期設定を行う
 */
static void config_initialize(GameWrapper *const game)
{
    game->conf.db.old_main_member  = MAX_8BIT;
    game->conf.db.old_sub_id       = MAX_32BIT;
    game->conf.db.old_sub_member   = MAX_32BIT;
	game->conf.system.paty_member  = HERO_NUMBER;	//とりあえず仮の仲間人数設定
	game->conf.battle.hero.number  = 4;
	game->conf.battle.hero.counter = 4;
	game->conf.cook.isCook   = true;

	for (uint8_t i = 0; i < COOK_MAX; i++)
	{
		game->conf.cook.master[i] = (i < 6) ? i : COOK_ID_NON;
		game->conf.cook.level[i]  = (i < 5) ? i : 0;
		game->conf.cook.count[i]  = 0;
	}

	for (uint8_t i = 0; i < WEAPON_NAME_ID_END; i++)
	{
		game->conf.item.weapon[i] = i;
	}
	game->conf.item.weapon[WEAPON_NAME_ID_END-3] = WEAPON_NOT_FOUND;

	for (uint8_t i = 0; i < ARMOR_NAME_ID_END; i++)
	{
		game->conf.item.armor[i] = i;
	}

	for (uint8_t i = 0; i < AMULET_NAME_ID_END; i++)
	{
		game->conf.item.amulet[i] = i;
	}

	for (uint8_t i = 0; i < ITEM_NAME_ID_END; i++)
	{
		game->conf.item.tool[i] = i;
	}

	for (uint8_t i = 0; i < game->conf.system.paty_member; i++)
	{
		game->conf.battle.hero.sort_order[i] = i;
	}
    game->conf.event.type               = EVENT_TYPE_WORLD_MOVE;
    game->conf.display.system           = SYSTEM_MAP_DEFAULT_WINDOW;
    game->conf.display.drawtype         = DISPLAY_FIELD_CENTER_DRAW;
    game->conf.map.back                 = DRAM_MAPDATA_ADDR_START;
    game->conf.map.obj                  = DRAM_MAPDATA_OBJECT_ADDR_START;
    game->conf.map.next                 = GEKAI_MAP_ID;
    game->conf.map.canpass_id           = CAN_PASS_MAPCHIP_ID_MAX_GEKAI; 
    game->conf.map.obj_startid          = OBJECT_START_MAPID_GEKAI;
    game->conf.map.obj_endid            = OBJECT_END_MAPID_GEKAI;
    game->unit.pos.fieldx               = 160 << MAPCHIP_SHIFT;
    game->unit.pos.fieldy               = 39  << MAPCHIP_SHIFT;
    game->unit.pos.unitx                = 320;
    game->unit.pos.unity                = 224;
	game->unit.pos.unitdir	            = DIR_WAIT;
    game->unit.pos.animation_pixel_x    = ANIMATION_STORY_PIXEL_NUM;
    game->unit.pos.animation_pixel_y    = ANIMATION_STORY_PIXEL_NUM;
    game->unit.pos.anime_cnt            = 0;
    game->unit.pos.encount              = 0;
	game->unit.draw.workpos             = UNIT_WORK_TYPE_CENTER;
	game->unit.draw.cutpos              = UNIT_CUT_DOWN + game->unit.draw.chara_chipid;
	game->unit.draw.mapchip_id          = UNIT_WORK_TYPE_CENTER + game->unit.draw.cutpos;
    game->unit.draw.chara_chipid        = MAPCHIP_MINORIKO;
    game->unit.action.move_speed        = TM_300US_COUNT;
}
