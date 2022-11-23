/*
 * Create 2021/08/06
 * Author kimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * IC
 * -
 * 戦闘時の通常描画以外に関する描画イベントの情報の状態を管理するファイル
 * 
 * 参照ヘッダーファイル /hardware/macro/item_xxx.h
 */
#include "../../wrapper/game_wrapper.h"


/*
 * ファイル内関数
 */
static void item_heal(GameWrapper *const game, uint8_t item_type);
static void item_alive(GameWrapper *const game);
static void item_sp(GameWrapper *const game, uint8_t item_type);


/* 関数内で使用するサブモジュール */
static int32_t item_calc_heal(GameWrapper *const game, uint8_t item_type, uint8_t hero_id, int32_t power);


/*
 * ver1. 2021/08/06
 * バトル中にアイテムを使用した場合のアイテム効果を適応させる処理
 */
bool battle_item_use(GameWrapper *const game)
{
	switch (fetch_dram_db(game, MEMORY_ITEM_ID, game->conf.battle.effect.id[0], ITEM_SUB_MEMBER_USE_TYPE))
	{
    case ITEM_TYPE_HEEL:
		item_heal(game, ITEM_TYPE_HEEL);
		return ITEM_RESULT_DRAW_OK;

	case ITEM_TYPE_HEEL_RATIO:
		item_heal(game, ITEM_TYPE_HEEL_RATIO);
		return ITEM_RESULT_DRAW_OK;

	case ITEM_TYPE_ALIVE:
		item_alive(game);
		break;

	case ITEM_TYPE_SP:
		item_sp(game, ITEM_TYPE_SP);
		return ITEM_RESULT_DRAW_OK;

	case ITEM_TYPE_SP_RATIO:
		item_sp(game, ITEM_TYPE_SP_RATIO);
		return ITEM_RESULT_DRAW_OK;

    case ITEM_TYPE_ENCHANT:
		item_status_update(game);
		break;

	case ITEM_TYPE_CONDITION:
		update_condition_db(game, game->conf.battle.hero.sort_order[game->conf.battle.loop.item_sort]);
		game->hero[game->conf.battle.hero.sort_order[game->conf.battle.loop.item_sort]].battle.condition = fetch_dram_db(game, MEMORY_ITEM_CONDITION_ID, game->conf.battle.effect.id[0], ITEM_SUB_MEMBER_CONDITION_CONDIBIT);
		break;

    case ITEM_TYPE_ESCAPE:
		break;
	
	default:
		break;
	}

	return ITEM_RESULT_DRAW_NON;
}

/*
 * ver1. 2021/08/06
 * 回復アイテムによるHPの回復処理
 */
static void item_heal(GameWrapper *const game, uint8_t item_type)
{
	int32_t heal = fetch_dram_db(game, MEMORY_ITEM_ID, game->conf.battle.effect.id[0], ITEM_SUB_MEMBER_POWER);

	for (uint8_t i = 0; i < game->conf.battle.loop.item_range; i++)
	{
		uint8_t hero_id = game->conf.battle.hero.sort_order[game->conf.battle.loop.item_sort + i];
		hero_damege_cure(game, hero_id, item_calc_heal(game, item_type, hero_id, heal));
	}
}


/*
 * ver1. 2021/08/06
 * 蘇生系アイテムの使用
 */
static void item_alive(GameWrapper *const game)
{
	int32_t result = fetch_dram_db(game, MEMORY_ITEM_ID, game->conf.battle.effect.id[0], ITEM_SUB_MEMBER_POWER);

	for (uint8_t i = 0; i < game->conf.battle.loop.item_range; i++)
	{
		uint8_t hero_id = game->conf.battle.hero.sort_order[game->conf.battle.loop.item_sort + i];
		hero_alive_cure(game, hero_id, result);
	}
}


/**
 * @brief   SP回復アイテムのによるSPの回復処理
 * @ingroup item group
 *
 * @note 
 *
 * @version 1.0 2021/08/29
 */
static void item_sp(GameWrapper *const game, uint8_t item_type)
{
	int32_t heal = fetch_dram_db(game, MEMORY_ITEM_ID, game->conf.battle.effect.id[0], ITEM_SUB_MEMBER_POWER);

	for (uint8_t i = 0; i < game->conf.battle.loop.item_range; i++)
	{
		uint8_t hero_id = game->conf.battle.hero.sort_order[game->conf.battle.loop.item_sort + i];
		hero_sp_cure(game, hero_id, item_calc_heal(game, item_type, hero_id, heal));
	}
}


/*
 * ver1. 2021/08/06
 * 回復方法の計算結果を取得
 * -
 * 固定回復と割合回復があり、個別に関数を作るのはもったいないためswitch-case文で計算方法を判定することとした
 * -
 * HEEL			固定回復
 * HEEL_RATIO	((MAX_HP / 100) * 割合% )
 */
static int32_t item_calc_heal(GameWrapper *const game, uint8_t item_type, uint8_t hero_id, int32_t power)
{
	switch (item_type)
	{
    case ITEM_TYPE_HEEL:
		return power;

	case ITEM_TYPE_HEEL_RATIO:
		return fix_num(game->hero[hero_id].status.hp, power);

	case ITEM_TYPE_SP:
		return power;

	case ITEM_TYPE_SP_RATIO:
		return fix_num(game->hero[hero_id].status.hp, power);

	default:
		return 0;
	}
}
