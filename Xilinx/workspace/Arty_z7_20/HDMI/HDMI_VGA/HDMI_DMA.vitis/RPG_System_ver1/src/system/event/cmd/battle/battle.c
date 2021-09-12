/*
 * Create 2021/08/15
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * IC      XC7Z020-1CLG400C
 * ROM     256KB
 * RAM     512KB
 * L1Cache 32KB
 * -
 * バトル時のコマンド入力確定時の操作関数を管理するファイル
 */
#include "../../../wrapper/game_wrapper.h"
#include "cmd_battle.h"
#include "../standerd/cmd_standerd.h"


/* ファイル内関数 */
static void cmd_battle_system(GameWrapper *const game);
static bool cmd_battle_main(GameWrapper *const game);
static void cmd_battle_sub(GameWrapper *const game);
static bool cmd_item_conf(GameWrapper *const game);
static void cmd_magic_conf(GameWrapper *const game);
static void cmd_finish_config_update(GameWrapper *const game, uint8_t anime_order);


/*
 * ver1. 2021/08/21
 * バトル中のキー入力の操作処理を管理する
 */
void battle_key(GameWrapper *const game, uint8_t sw)
{
	game->cmd.cursol.finish = false;
	
	if (sw & SW_A)
	{
		cmd_battle_system(game);
	}
	
	cmd_key_all(game, sw);
}


/*
 * ver2. 2021/07/03
 * コマンド選択処理を分類に分けて処理を行うよう変更
 * -
 * ver1. 2021/07/01
 * バトル中のコマンド入力処理
 * コマンド確定時にシステムメンバがCOMMAND_BATTLE_DONEになるため
 * コマンドのコンフィグデータを初期化し、コマンド確定を判定するメンバをtrueにする
 */
static void cmd_battle_system(GameWrapper *const game)
{
	switch (game->cmd.sub_system)
	{
	case COMMAND_MAIN:
		if (true == cmd_battle_main(game))
		{
			game->cmd.sub_system = COMMAND_SUB;
		}
		break;

	case COMMAND_SUB:
		cmd_battle_sub(game);
		break;

	default:
		break;
	}

	if (game->cmd.window.system == COMMAND_BATTLE_DONE)
	{
		game->cmd.sub_system     = COMMAND_MAIN;
		game->cmd.cursol.yend    = BATTLE_CMD_END;
		game->cmd.cursol.finish  = true;
		game->cmd.cursol.y_enter = game->cmd.cursol.y;
		game->cmd.window.sub_id  = BATTLE_WINDOW_SUB_NON;
	}
}


/*
 * ver1. 2021/07/03
 * バトル画面のコマンド入力時のメインの状態遷移を管理
 * -
 * たたかうコマンド
 * 敵選択カーソル移動に変更
 * -
 * わざコマンド
 * 技選択カーソル移動に変更
 * -
 * アイテムコマンド
 * アイテム選択カーソル移動に変更
 * -
 * いれかえ
 * 仲間入れ替え選択カーソル移動に変更
 * 
 * はなす
 * 仲間とのメッセージウィンドウ描画
 * -
 * にげる
 * 成功の場合逃走ウィンドウに変更
 * 失敗の場合カーソル位置を初期値に戻す
 */
static bool cmd_battle_main(GameWrapper *const game)
{
	switch (game->cmd.cursol.y)
	{
	case BATTLE_ATTACK_SELECT:
		game->cmd.cursol.yend   = game->conf.battle.enemy.number - 1;
		game->cmd.window.system = COMMAND_BATTLE_ATTACK_ENEMY;
		game->cmd.window.anime  = COMMAND_ANIME_MAGIC;
		game->cmd.window.sub_id = BATTLE_WINDOW_SUB_CMD;
		game->cmd.window.effect = fetch_dram_db(game, MEMORY_WEAPON_ID, game->hero[game->conf.battle.trun.hero[0]].equip.weapon, WEAPON_SUB_MEMBER_EFFECT_DRAW_ID);
		return true;

	case BATTLE_MAGIC_SELECT:
		game->cmd.window.system = COMMAND_BATTLE_MAGIC;
		game->cmd.window.anime  = COMMAND_ANIME_MAGIC;
		game->cmd.cursol.yend   = game->hero[game->conf.battle.trun.hero[0]].battle.skill_number - 1;
		game->cmd.window.sub_id = BATTLE_WINDOW_SUB_MAGIC;
		return true;

	case BATTLE_ITEM_SELECT:
		return cmd_item_conf(game);

	case BATTLE_SWAP_SELECT:
		game->cmd.cursol.yend   = game->conf.system.paty_member - game->conf.battle.hero.counter - 1;	//仲間の最大人数 - 戦闘参加人数 = 入れ替え可能人数
		game->cmd.window.anime  = COMMAND_ANIME_SWAP;
		game->cmd.window.system = COMMAND_BATTLE_SWAP;
		game->cmd.window.effect = E_SWAP_ACTIVE;
		game->cmd.window.sub_id = BATTLE_WINDOW_SUB_SWAP;
		return true;

	case BATTLE_TALK_SELECT:
		game->cmd.window.sub_id = BATTLE_WINDOW_SUB_TALK;
		// game->cmd.window.anime  = COMMAND_ANIME_TALK;
		game->cmd.window.system = COMMAND_BATTLE_TALK;
		// game->cmd.window.effect = E_TALK_ACTIVE;
		return false;

	case BATTLE_ESCAPE_SELECT:
		game->cmd.window.anime  = COMMAND_ANIME_ESCAPE;
		game->cmd.window.system = COMMAND_BATTLE_DONE;
		game->cmd.window.effect = E_ESCAPE_ACTIVE;
		return false;

	default:
		return true;
	}
}


/*
 * ver1. 2021/07/03
 * バトル画面のコマンド入力時のサブの状態遷移を管理
 * -
 * わざコマンド
 * 選択したわざが味方に使用する技でなければ、敵の人数分カーソル移動を可能にする
 * -
 * 敵、味方の選択コマンド決定時に仲間のアニメーション画像IDの切り替えを行い
 * サブシステムの状態遷移を通常状態に戻す
 */
static void cmd_battle_sub(GameWrapper *const game)
{
	switch (game->cmd.window.system)
	{
	case COMMAND_BATTLE_MAGIC:
		cmd_magic_conf(game);
		break;

	case COMMAND_BATTLE_UNIT:
		cmd_finish_config_update(game, BATTLE_HERO_CHIP_WAIT);
		break;

	case COMMAND_BATTLE_ATTACK_UNIT:
		break;

	case COMMAND_BATTLE_ATTACK_ENEMY:
		game->hero[game->conf.battle.trun.hero[0]].status.odd_sp -= fetch_dram_db(game, MEMORY_MAGIC_ID, game->cmd.window.effect, MAGIC_SUB_MEMBER_ROSS_SP);
		cmd_finish_config_update(game, BATTLE_HERO_CHIP_WAIT);
		break;

	case COMMAND_BATTLE_MAGIC_UNIT:
		game->hero[game->conf.battle.trun.hero[0]].status.odd_sp -= fetch_dram_db(game, MEMORY_MAGIC_ID, game->cmd.window.effect, MAGIC_SUB_MEMBER_ROSS_SP);
		cmd_finish_config_update(game, BATTLE_HERO_CHIP_MAGIC_1);
		break;

	case COMMAND_BATTLE_MAGIC_ENEMY:
		game->hero[game->conf.battle.trun.hero[0]].status.odd_sp -= fetch_dram_db(game, MEMORY_MAGIC_ID, game->cmd.window.effect, MAGIC_SUB_MEMBER_ROSS_SP);
		cmd_finish_config_update(game, BATTLE_HERO_CHIP_MAGIC_1);
		break;

	case COMMAND_BATTLE_SWAP:
		game->cmd.window.system = COMMAND_BATTLE_DONE;
		break;

	default:
		break;
	}
}


/*
 * ver3. 2021/08/06
 * アイテムが設定されていなければウィンドウの表示とカーソル表示を行わないように変更
 * 
 * ver2. 2021/08/05
 * わざの範囲判定処理とアイテムの範囲判定処理を一緒にすると何だか分かりにくくなったため
 * アイテムコマンド時に、カーソル移動とアイテム描画を同時に行うように変更した
 * 
 * ver1. 2021/08/05
 * アイテム選択中のコマンドカーソル処理
 */
static bool cmd_item_conf(GameWrapper *const game)
{
	if (ITEM_NON == game->hero[game->conf.battle.trun.hero[0]].equip.item)
	{
		bgm_update(game, SOUND_ID_CMD_CANSEL, SOUND_CH_EFFECT2_WORK);
		game->cmd.window.system = COMMAND_BATTLE_UNIT;
		return false;
	}

	game->cmd.window.sub_id = BATTLE_WINDOW_SUB_ITEM;
	game->cmd.window.system = COMMAND_BATTLE_UNIT;
	game->cmd.window.anime  = COMMAND_ANIME_ITEM;
	game->cmd.cursol.yend   = (game->cmd.window.system == COMMAND_BATTLE_UNIT) ? game->conf.battle.hero.counter : game->conf.battle.enemy.number;
	game->cmd.cursol.yend   -= 1;
	game->cmd.window.effect = game->hero[game->conf.battle.trun.hero[0]].equip.item;

	return true;
}


/*
 * ver1. 2021/08/05
 * 技選択中のコマンドカーソル処理
 * 残りSPより選択中のわざの消費SPが低ければターゲット選択コマンドの状態に遷移する
 */
static void cmd_magic_conf(GameWrapper *const game)
{
	game->cmd.window.effect = game->hero[game->conf.battle.trun.hero[0]].battle.skill[game->cmd.cursol.y];

	if ((game->hero[game->conf.battle.trun.hero[0]].status.odd_sp - (int32_t)fetch_dram_db(game, MEMORY_MAGIC_ID, game->cmd.window.effect, MAGIC_SUB_MEMBER_ROSS_SP)) < 0)
	{
		bgm_update(game, SOUND_ID_CMD_CANSEL, SOUND_CH_EFFECT2_WORK);
		return;
	}

	game->cmd.window.system  = fetch_dram_db(game, MEMORY_MAGIC_ID, game->cmd.window.effect, MAGIC_SUB_MEMBER_TYPE);
	game->cmd.window.sub_id  = BATTLE_WINDOW_SUB_CMD;
	game->cmd.cursol.yend 	 = (game->cmd.window.system == COMMAND_BATTLE_MAGIC_UNIT) ? game->conf.battle.hero.counter : game->conf.battle.enemy.number;
	game->cmd.cursol.yend    -= 1;
}


/*
 * ver2. 2021/08/06
 * アニメーション画像が通常の立ち姿と、ひん死の姿以外の時は状態遷移のモジュールが起動中なので
 * 終了時に画像が切り替わるようにメンバにデータの設定を行うように変更
 * 
 * ver1. 2021/08/05
 * バトル時のコマンド確定時のコンフィグデータの設定
 */
static void cmd_finish_config_update(GameWrapper *const game, uint8_t anime_order)
{
	if (true == isHeroActivate(game->conf.battle.hero.anime_order[game->conf.battle.trun.hero[0]]))
	{
		game->conf.battle.hero.anime_order[game->conf.battle.trun.hero[0]] = anime_order;
	}
	else
	{
		game->conf.battle.hero.old_anime_order[game->conf.battle.trun.hero[0]] = anime_order;
	}

	game->cmd.window.system = COMMAND_BATTLE_DONE;
}