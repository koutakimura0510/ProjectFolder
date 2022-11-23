/*
 * Create 2021/07/09
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
 * キャラクターのステータスに関連する関数をまとめたファイル
 */
#include "../../wrapper/game_wrapper.h"


/*
 * ファイル内関数宣言
 */
static void search_levelup(GameWrapper *const game, uint8_t hero_id);
static void update_hero_status(GameWrapper *const game, uint8_t hero_id);
static void update_hero_skill(GameWrapper *const game, uint8_t hero_id);


/*
 * ver1. 2021/07/09
 * 仲間キャラクターのステータスの初期設定
 */
void hero_initialize(GameWrapper *const game)
{
	static const uint8_t level[] = {
		2, 20, 5, 99, 99, 99, 99, 99,
	};

	static const uint8_t weapon[] = {
		WEAPON_KODUTI,
		WEAPON_SHORT_SHORT,
		WEAPON_KODUTI,
		WEAPON_SWORAD_TETU,
		WEAPON_UMBRELLA_SUN,
		WEAPON_SPEAR_NIGHT,
		WEAPON_ROD,
		WEAPON_SWORAD_HISOUKEN,
	};

	for (uint8_t i = 0; i < HERO_NUMBER; i++)
    {
		game->hero[i].status.level 			= level[i];
		game->hero[i].status.exp 			= fetch_dram_db(game, MEMORY_HERO_LEVEL_ID, level[i], HERO_SUB_MEMBER_LEVEL_EXP);
		update_hero_status(game, i);
		update_hero_skill(game, i);
		game->hero[i].status.love           = 0;
        game->hero[i].status.odd_hp         = game->hero[i].status.hp;
        game->hero[i].status.sp             = 99;
        game->hero[i].status.odd_sp         = 99;
        game->hero[i].status.enchant.atk    = 0;
        game->hero[i].status.enchant.def    = 0;
        game->hero[i].status.enchant.mag    = 0;
        game->hero[i].status.enchant.res    = 0;
        game->hero[i].status.enchant.agi    = 0;
        game->hero[i].battle.condition      = 0;
        game->hero[i].battle.atb_gauge      = 0;
        game->hero[i].battle.atb_timer      = 0;
		game->hero[i].battle.arive 			= true;
		game->hero[i].equip.weapon 			= weapon[i];
		game->hero[i].equip.armor			= ARMOR_CLIP_TREE;
		game->hero[i].equip.amulet			= AMULET_RING_13;
		game->hero[i].equip.item   			= i;
		equip_ref_update(game, i);
	}
}


/*
 * ver1. 2021/07/09
 * 経験値獲得時、または初期設定時にレベルの判定処理を行う
 * 仲間の人数、かつ隊列の順番でレベルアップ判定を行う
 */
void update_levelup(GameWrapper *const game)
{
	for (uint8_t i = 0; i < game->conf.system.paty_member; i++)
	{
		game->hero[game->conf.battle.hero.sort_order[i]].battle.levelup = false;
		search_levelup(game, game->conf.battle.hero.sort_order[i]);
	}
}


/*
 * ver2. 2021/07/20
 * データベースをファイル化しDRAMに保存するシステムに変更したため、DRAMに保存されているデータを参照するように変更
 * そのためレベルアップの判定方法を変更した
 * 
 * 例
 * 現在の経験値と次のレベルに必要な経験値を比較し、超えていたらレベルを上げる
 * 一度に数レベル上がる可能性があるため経験値が越さなくなるまでレベルアップの判定を行う
 * -
 * ver1. 2021/07/09
 * レベルアップ経験値データテーブル参照処理
 * レベルアップ時にステータスとスキルの更新を行う
 * 
 * 例 現在の経験値11000
 * lv 30	exp 10000
 * lv 31	exp 13000
 * アドレスはlv31まで進むため、lv - 1の値が現在のレベルに設定される
 */
static void search_levelup(GameWrapper *const game, uint8_t hero_id)
{
	uint8_t level = game->hero[hero_id].status.level;

	if (LEVEL_MAX == level)
	{
		return;
	}

	for (uint8_t i = 1; i < LEVEL_MAX; i++)
	{
		if (fetch_dram_db(game, MEMORY_HERO_LEVEL_ID, level + i, HERO_SUB_MEMBER_LEVEL_EXP) < game->hero[hero_id].status.exp)
		{
			game->hero[hero_id].status.level++;
			game->hero[hero_id].battle.levelup = true;
			update_hero_status(game, hero_id);
			update_hero_skill(game, hero_id);
		}
		else
		{
			break;
		}
	}
}

/*
 * ver2. 2021/07/20
 * データベースをファイル化しDRAMに保存するシステムに変更したため、DRAMに保存されているデータを参照するように変更
 *
 * ver1. 2021/07/09
 * 仲間の現在のレベルに応じてステータス管理データベースにアクセスしステータスの設定を行う
 */
static void update_hero_status(GameWrapper *const game, uint8_t hero_id)
{
	game->hero[hero_id].status.hp  = fetch_dram_db(game, MEMORY_HERO_LEVEL_ID, game->hero[hero_id].status.level, HERO_SUB_MEMBER_LEVEL_HP  + hero_id);
	game->hero[hero_id].status.atk = fetch_dram_db(game, MEMORY_HERO_LEVEL_ID, game->hero[hero_id].status.level, HERO_SUB_MEMBER_LEVEL_ATK + hero_id);
	game->hero[hero_id].status.def = fetch_dram_db(game, MEMORY_HERO_LEVEL_ID, game->hero[hero_id].status.level, HERO_SUB_MEMBER_LEVEL_DEF + hero_id);
	game->hero[hero_id].status.agi = fetch_dram_db(game, MEMORY_HERO_LEVEL_ID, game->hero[hero_id].status.level, HERO_SUB_MEMBER_LEVEL_AGI + hero_id);
	game->hero[hero_id].status.mag = fetch_dram_db(game, MEMORY_HERO_LEVEL_ID, game->hero[hero_id].status.level, HERO_SUB_MEMBER_LEVEL_MAG + hero_id);
	game->hero[hero_id].status.res = fetch_dram_db(game, MEMORY_HERO_LEVEL_ID, game->hero[hero_id].status.level, HERO_SUB_MEMBER_LEVEL_RES + hero_id);
	game->hero[hero_id].status.odd_hp += (game->hero[hero_id].status.hp - game->hero[hero_id].status.odd_hp);
}

/*
 * ver2. 2021/07/20
 * データベースをファイル化しDRAMに保存するシステムに変更したため、DRAMに保存されているデータを参照するように変更
 * 
 * ver1. 2021/07/09
 * 仲間のレベルに応じて、データベースにアクセスし技の習得処理を行う
 */
static void update_hero_skill(GameWrapper *const game, uint8_t hero_id)
{
	for (uint8_t i = 0; i < SKILL_MAX; i++)
	{
		if (fetch_dram_db(game, MEMORY_HERO_SKILL_ID, hero_id, HERO_SUB_MEMBER_SKILL_LEVEL + i) <= game->hero[hero_id].status.level)
		{
			game->hero[hero_id].battle.skill[i] = fetch_dram_db(game, MEMORY_HERO_SKILL_ID, hero_id, HERO_SUB_MEMBER_SKILL_SKILL + i);
			game->hero[hero_id].battle.skill_number = i + 1;
		}
		else
		{
			break;
		}
	}
}
