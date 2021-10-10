/*
 * ストーリーモードの関数を管理するファイル
 */

#include "../wrapper/game_wrapper.h"
#include "story_struct.h"


/*
 * ファイル内関数
 */
static void draw_update_state(GameWrapper *const game);


/*
 * ver1. 2021/06/10
 * ストーリーモードのシステムを管理
 * セーブデータの読み込み完了後キャラクターの座標更新をする
 * VDMAとフレームバッファの切り替えタイミングを管理しながらストーリーの進行を行う
 */
void story_toho_rpg(GameWrapper *const game)
{
	uint8_t fpos = 0;

	while (1)
	{
		if (true == vdma_IsChannel())
		{
			fpos = vdma_circular();
			workarea_update(game, fpos);
			draw_update_state(game);
		}

		if (true == hvsync_state())
		{
			vdma_channel(fpos);
		}
	}
}


/*
 * ver1. 2021/06/14
 * システム動作の関数を管理
 * 現在のシステムの状態に対応した関数を関数ポインタで呼び出しを行う
 */
static void draw_update_state(GameWrapper *const game)
{
	const SystemState *p = system_state;

	for (uint8_t i = 0; i < SYSTEM_FUNC_DB_SIZE; i++, p++)
	{
		if (game->conf.display.system == p->system)
		{
			p->system_func(game);
			break;
		}
	}
}


/*
 * ver1. 2021/07/02
 * 初期起動時のデータロードシステム
 */
static void system_opening_window(GameWrapper *const game)
{
	story_opening_mode(game);
}


/*
 * ver2. 2021/06/19 
 * 画面のちらつき防止のため、マップ移動の当たり判定時に現在のバッファのアドレスに画面データを描画するように変更
 * -
 * ver1. 2021/06/01 
 * マップ移動時の通常描画の処理を管理
 * キー入力を読み込み方向を取得後マップのオブジェクトとイベントの当たり判定を行う
 * イベント判定を取得した場合、描画の更新は行わず暗転描画状態に移行する
 */
static void system_standerd_window(GameWrapper *const game)
{
	uint8_t sw = get_key(true);
	direction_update_key(game, sw);
	bool can    = isDirect_object(game);
	bool direct = isDirect_event(game);
	bool npc    = isNpc_event(game);

	if ((npc == NON_DIRECT) && (direct == NON_DIRECT) && (SW_A == (sw & SW_A)))
	{
		menu_window_init(game);
	}

	if (SW_B == sw)
	{
		cmd_db_reset(game, COMMAND_MINIGAME_SYSTEM, 0);
		game->conf.display.system = SYSTEM_NEXT_SYSTEM_PIPE;
		game->conf.display.sub_state = SYSTEM_MINIGAME_STATE;
	}

	if (CAN_MOVE == can)
	{
		unit_pos_update(game);
	}

	if (direct == NON_DIRECT)
	{
		direct = battle_rush_state(game);
	}

	if ((direct == NON_DIRECT) && (npc == NON_DIRECT))
	{
		standerd_game(game);
	}
	else
	{
		nextdraw_ready(game);
		frame_buffer_other_copy(game);
		// game->conf.display.drawtype = DISPLAY_DARKENING_DRAW;
	}
}

/*
 * ver1. 2021/06/14
 * 次の描画状態に移行するためのパイプ処理を管理
 */
static void system_state_nextwindow(GameWrapper *const game)
{
	const DarkingState *p = darking_state;
	
	standerd_game(game);

	for (uint8_t i = 0; i < DARKING_STATE_DB_SIZE; i++, p++)
	{
		if (p->now_system == game->conf.display.system)
		{
			break;
		}
	}

	if (SYSTEM_MAP_DEFAULT_WINDOW != p->next_system)
	{
		bgm_update(game, SOUND_ID_CMD_ENTER, SOUND_CH_EFFECT1_WORK);
	}
	game->conf.display.system   = p->next_system;
	game->conf.display.drawtype = p->next_draw_type;
}


/*
 * ver1. 2021/06/14
 * ワールドマップを含んだ移動時には、BGMの停止後に移動先に対応したマップチップデータ、音源データ、マップデータの読み込みを行う
 * サブマップ間移動の場合は、次に描画予定のマップデータのみ読み込みを行う
 * 読み込み終了後、描画データの準備を行い徐々にマップ描画モードにシステムを移行する
 */
static void system_nextdata_reading(GameWrapper *const game)
{
	next_stage_update(game);
	npc_config(game);

	switch (game->conf.display.system)
	{
	case SYSTEM_NEXT_ALLDATA_READING:
		bgm_stop();
		bgm_load(game, game->conf.file.bgm);
		bgm_load(game, SOUND_ID_BATTLE_FANFARE);
		bgm_load(game, SOUND_ID_BATTLE_DEFAULT);
		bgm_update(game, game->conf.file.bgm, SOUND_CH_BGM_WORK);
		sd_fread(game->conf.file.mapchip);
		sd_fread(game->conf.file.mapdata);
		sd_fread(game->conf.file.object);
		sd_fread(game->conf.file.region);
		sd_fread(game->conf.file.npc);
		break;

	case SYSTEM_NEXT_SUBMAP_READING:
		sd_fread(game->conf.file.mapdata);
		sd_fread(game->conf.file.object);
		sd_fread(game->conf.file.region);
		sd_fread(game->conf.file.npc);
		break;

	default:
		break;
	}

	standerd_game(game);
	game->conf.display.system   = SYSTEM_MAP_GRADUALLY_WINDOW;
	game->conf.display.drawtype = DISPLAY_GRADUALLY_DRAW;
}


/*
 * ver1. 2021/06/25
 * メッセージのイベント発生時のメッセージウィンドウの描画
 * スイッチ入力が行われた場合、メッセージウィンドウの処理を終え通常描画に戻る
 */
static void system_msg_window(GameWrapper *const game)
{
	// nextdraw_ready(game);
	event_msg_draw(game);
	
	if (SW_A == get_key(false))
	{
		game->conf.display.system   = SYSTEM_MAP_DEFAULT_WINDOW;
		game->conf.display.drawtype = DISPLAY_FIELD_CENTER_DRAW;
		game->conf.event.type 		= EVENT_TYPE_SUBMAP_MOVE;
	}
}


/**
 * @brief  特定のイベントモードに移行する際のパイプ処理を行う
 * @note   今のところは戦闘モードとミニゲームモードの2種類のみである
 * 
 * @retval None
 */
static void system_next_pipe(GameWrapper *const game)
{
	patblt(game->conf.work.adr, 0, 0, VIDEO_WIDTH, VIDEO_HEIGHT, COLOR_BLACK);
	frame_buffer_other_copy(game);

	switch (game->conf.display.sub_state)
	{
	case SYSTEM_BATTLE_STATE:
		game->conf.display.system = SYSTEM_BATTLE_ENEMY;
		break;

	case SYSTEM_MINIGAME_STATE:
		game->conf.display.system = SYSTEM_MINIGAME_WINDOW;
		game->conf.display.sub_state = MINIGAME_START_LOAD_ID;	/* ミニゲームの状態遷移用にIDを設定しておく */
		break;

	default:
		break;
	}
}


/*
 * ver1. 2021/06/27
 * システムの戦闘モードの管理を行う
 * 戦闘終了時の状態によって、次のシステム遷移を変更する
 */
static void system_battle_window(GameWrapper *const game)
{
	if (true == battle_window_draw(game))
	{
		patblt(game->conf.work.adr, 0, 0, VIDEO_WIDTH, VIDEO_HEIGHT, COLOR_BLACK);
		frame_buffer_other_copy(game);
		game->conf.display.system = SYSTEM_MAP_DEFAULT_WINDOW;
		game->conf.display.drawtype = DISPLAY_FIELD_CENTER_DRAW;
		bgm_stop();
		bgm_update(game, SOUND_ID_FIELD_GEKAI, SOUND_CH_BGM_WORK);
	}
}


/*
 * イベント進行の管理
 */


/*
 * メニューの管理
 */
static void system_menu_window(GameWrapper *const game)
{
	// nextdraw_ready(game);
	menu_window_wrapper(game);
}



/*
 * ver1. 2021/07/02
 * ミニゲームモードの管理
 */
static void system_minigame_window(GameWrapper *const game)
{
	barrage_mingame(game);
}
