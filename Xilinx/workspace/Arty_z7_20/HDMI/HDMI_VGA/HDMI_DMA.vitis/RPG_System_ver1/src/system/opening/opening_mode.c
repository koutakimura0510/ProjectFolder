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
	game->conf.display.sub_state = OPENING_BITMAP_LOAD;
	game->conf.display.uncommon_window = 0;
	game->conf.animation.count = 0;
	game->conf.animation.acc = NUM(bitmap_init) + NUM(sound_init);
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
	// bgm_update(game, SOUND_ID_TITLE, SOUND_CH_BGM_WORK);

#ifdef DEMO_WINDOW_ON
	game->conf.display.sub_state = OPENING_DEMO_WINDOW;

	game->conf.display.sub_state = OPENING_BUILD_SELECT;
	cmd_db_reset(game, COMMAND_BUILD_SYSTEM, 0);

#else
	game->conf.display.sub_state = OPENING_SYSTEM_DRAW;
#endif
}


/**
 * @brief  起動時のデモ動作用の映像データを出力する
 * @note   
 * @retval None
 */
static void opening_demo_window(GameWrapper *const game)
{
	static SDL_Rect rect = (SDL_Rect){0, 0, 0, 0,};
	static SDL_Timer timer = {0};
	patblt(game->conf.work.adr, 0, 0, VIDEO_WIDTH, VIDEO_HEIGHT, COLOR_BLACK);
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

	switch (GET_FPGA_SW)
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

	case SW_B:
		game->conf.display.sub_state = OPENING_SYSTEM_DRAW;
		cmd_db_reset(game, COMMAND_OPENING_SYSTEM, 1);
		bgm_update(game, SOUND_ID_TITLE, SOUND_CH_BGM_WORK);
		break;

	default:
		break;
	}
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

	if (SW_A & cmd_key(game))
	{
		bgm_stop();
		bgm_update(game, SOUND_ID_CMD_BUTTON2, SOUND_CH_KEY_WORK);
		game->conf.display.sub_state = OPENING_BUILD_SELECT;
		cmd_db_reset(game, COMMAND_BUILD_SYSTEM, 0);
	}
}


/**
 * @brief  デバッグを開始する町、フィールド、ダンジョンを選択する
 * @note   
 * @retval None
 */
static void build_select(GameWrapper *const game)
{
	patblt(game->conf.work.adr, 0, 0, VIDEO_WIDTH, VIDEO_HEIGHT, COLOR_BLACK);
	font_dram_draw(game, LOAD_FONT_XDRAW_POS, LOAD_FONT_YDRAW_POS, MEMORY_BUILD_CONFIG_ID, game->cmd.cursol.y, BUILD_SUB_MEMBER_CONFIG_NAME, COLOR_WHITE);

	if (SW_A & cmd_key(game))
	{
		game->conf.display.sub_state = OPENING_SAVE_LOAD;
		game->conf.map.name        = fetch_dram_db(game, MEMORY_BUILD_CONFIG_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_CONFIG_MAP_NAME);
		game->conf.map.canpass_id  = fetch_dram_db(game, MEMORY_BUILD_CONFIG_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_CONFIG_CANPASS_ID);
		game->conf.map.obj_startid = fetch_dram_db(game, MEMORY_BUILD_CONFIG_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_CONFIG_OBJ_START_ID);
		game->conf.map.obj_endid   = fetch_dram_db(game, MEMORY_BUILD_CONFIG_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_CONFIG_OBJ_END_ID);
		game->conf.event.type      = fetch_dram_db(game, MEMORY_BUILD_CONFIG_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_CONFIG_DEBUG_EVENT_TYPE);
		game->unit.pos.fieldx      = fetch_dram_db(game, MEMORY_BUILD_CONFIG_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_CONFIG_DEBUG_START_FIELDX) << MAPCHIP_SHIFT;
		game->unit.pos.fieldy      = fetch_dram_db(game, MEMORY_BUILD_CONFIG_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_CONFIG_DEBUG_START_FIELDY) << MAPCHIP_SHIFT;
		game->unit.pos.unitx       = fetch_dram_db(game, MEMORY_BUILD_CONFIG_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_CONFIG_DEBUG_START_UNITX) << MAPCHIP_SHIFT;
		game->unit.pos.unity       = fetch_dram_db(game, MEMORY_BUILD_CONFIG_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_CONFIG_DEBUG_START_UNITY) << MAPCHIP_SHIFT;
		
		/* 選択したマップ情報読み込み */
		sd_fread(fetch_dram_db(game, MEMORY_BUILD_FILE_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_FILE_MAPCHIP_FILE));
		sd_fread(fetch_dram_db(game, MEMORY_BUILD_FILE_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_FILE_MAP_FILE));
		sd_fread(fetch_dram_db(game, MEMORY_BUILD_FILE_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_FILE_OBJ_FILE));
		sd_fread(fetch_dram_db(game, MEMORY_BUILD_FILE_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_FILE_REGION_FILE));
		sd_fread(fetch_dram_db(game, MEMORY_BUILD_FILE_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_FILE_NPC_FILE));
		bgm_load(game, fetch_dram_db(game, MEMORY_BUILD_FILE_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_FILE_SOUND_FILE));
		bgm_update(game, fetch_dram_db(game, MEMORY_BUILD_FILE_ID, game->cmd.cursol.oldy, BUILD_SUB_MEMBER_FILE_SOUND_FILE), SOUND_CH_BGM_WORK);
	}
}


/* TODO セーブデータ処理追加
 * ver1. 2021/06/28
 * 読み込んだセーブデータの情報からファイルの読み込むデータを参照しDRAMに保存する
 */
static void opening_savedata_load(GameWrapper *const game)
{
	config_initialize(game);
	hero_initialize(game);
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

    game->conf.display.system           = SYSTEM_MAP_DEFAULT_WINDOW;
    game->conf.display.drawtype         = DISPLAY_FIELD_CENTER_DRAW;
    game->conf.map.back                 = DRAM_MAPDATA_ADDR_START;
    game->conf.map.obj                  = DRAM_MAPDATA_OBJECT_ADDR_START;
	game->unit.pos.unitdir	            = DIR_WAIT;
    game->unit.pos.animation_pixel_x    = 2;
    game->unit.pos.animation_pixel_y    = 2;
    // game->unit.pos.animation_pixel_x    = ANIMATION_STORY_PIXEL_NUM;
    // game->unit.pos.animation_pixel_y    = ANIMATION_STORY_PIXEL_NUM;
    game->unit.pos.anime_cnt            = 0;
    game->unit.pos.encount              = 0;
	game->unit.draw.workpos             = UNIT_WORK_TYPE_CENTER;
	game->unit.draw.cutpos              = UNIT_CUT_DOWN + game->unit.draw.chara_chipid;
	game->unit.draw.mapchip_id          = UNIT_WORK_TYPE_CENTER + game->unit.draw.cutpos;
    game->unit.draw.chara_chipid        = MAPCHIP_MINORIKO;
	npc_config(game);
}