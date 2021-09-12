/*
 * Create 2021/08/06
 * Author kimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * IC
 * -
 * 仲間のステータスや状態に関する関数をまとめたファイル
 * 
 */
#include "../../wrapper/game_wrapper.h"


/*
 * ver1. 2021/08/07
 * エンチャントの補正値と操作する対象bitを保存する構造体
 * 
 * fit_status	: 補正値の計算結果を保存
 * power		: 補正値を指定
 * bit			: 補正値の操作を行うbitを指定
 */
typedef struct
{
	int32_t fit_status[STATUS_FIT_NUM];
	int32_t power;
	uint32_t bit;
} EnchantRef;


/* ファイル内関数 */
static void hero_status_enchant(GameWrapper *const game, EnchantRef *const enchant, uint8_t hero_id);
static void enemy_status_enchant(GameWrapper *const game, EnchantRef *const enchant, uint8_t enemy_id);
static void fit_status_update(EnchantRef *const enchant);
static void enchant_conf_update(GameWrapper *const game, StatusRef *const ref);
static void hero_condition_update(GameWrapper *const game, StatusRef *const ref, uint32_t type_bit, uint8_t condition);


/**
 * @brief   仲間の回復処理
 * @ingroup hero group
 *
 * @note 回復処理とマップチップを変更する処理を分けたい
 *
 * @param  hero_id 回復を行う仲間のIDを指定
 * @param  heal_result 回復量を指定
 * @version 1.0 2021/08/28
 */
void hero_damege_cure(GameWrapper *const game, uint8_t hero_id, int32_t heal_result)
{
	if (BATTLE_HERO_DEATH == game->hero[hero_id].battle.arive)  // 死亡している仲間は回復できない
	{
		return;
	}

	game->hero[hero_id].battle.damege = heal_result;
	heal_result += game->hero[hero_id].status.odd_hp;
	game->hero[hero_id].status.odd_hp = (heal_result < game->hero[hero_id].status.hp) ? heal_result : game->hero[hero_id].status.hp;
	
	if (SYSTEM_BATTLE_ENEMY == game->conf.display.system)	//戦闘中のみマップチップ判定を行う
	{
		if (hero_id == game->conf.battle.effect.hero_id[0]) // 技、又はアイテム発動中の仲間のマップチップは変更しない
		{
			return;
		}

		if (false == isHeroActivate(game->conf.battle.hero.anime_order[hero_id]))	// 仲間が動作中の場合はマップチップを変更しない
		{
			return;
		}
	}

	game->conf.battle.hero.anime_order[hero_id] = odd_hp_mapchip(game, hero_id);
}


/*
 * ver1. 2021/08/06
 * 引数に指定された仲間の死亡状況を確認し、死亡していれば指定したHPで蘇生させる
 * 蘇生時にステータス補正値と状態異常をクリアする
 * 
 * hero_id  仲間のID
 * odd_hp   蘇生させるときのHP
 */
void hero_alive_cure(GameWrapper *const game, uint8_t hero_id, int32_t odd_hp)
{
    if (BATTLE_HERO_DEATH == game->hero[hero_id].battle.arive)
    {
        game->conf.battle.hero.number++;
        game->hero[hero_id].battle.arive            = BATTLE_HERO_ALIVE;
        game->hero[hero_id].status.odd_hp           = odd_hp;
        game->conf.battle.hero.anime_order[hero_id] = odd_hp_mapchip(game, hero_id);
		game->hero[hero_id].status.enchant.atk      = 0;
		game->hero[hero_id].status.enchant.def      = 0;
		game->hero[hero_id].status.enchant.mag      = 0;
		game->hero[hero_id].status.enchant.res      = 0;
		game->hero[hero_id].status.enchant.agi      = 0;
		game->hero[hero_id].battle.condition        = 0;
    }
}


/*
 * ver1. 2021/08/06
 * SP回復処理、回復量が最大SPを超えている場合最大値を設定する
 */
void hero_sp_cure(GameWrapper *const game, uint8_t hero_id, int32_t sp)
{
	if (BATTLE_HERO_DEATH == game->hero[hero_id].battle.arive)
	{
		return;
	}

	game->hero[hero_id].status.odd_sp += sp;
	game->hero[hero_id].status.odd_sp = (game->hero[hero_id].status.odd_sp < game->hero[hero_id].status.sp) ? game->hero[hero_id].status.odd_sp : game->hero[hero_id].status.sp;
}


/*
 * ver1. 2021/08/09
 * 状態異常とステータス補正系のわざの処理を管理
 * 
 * E_RECOVERY	状態異常回復
 * E_CONDITION  状態異常付与
 * E_STATUS		ステータス補正
 */
void status_conf_update(GameWrapper *const game, StatusRef *const ref)
{
	if (E_RECOVERY == ref->element)
	{
		hero_condition_update(game, ref, UNIT_RES_GOOD, CONDITION_CURE_GOOD);
		return;
	}

	if ((E_CONDITION_START < ref->element) && (ref->element < E_CONDITION_END))
	{
		hero_condition_update(game, ref, fetch_dram_db(game, MEMORY_CONDITION_ID, ref->element, CONDITION_SUB_MEMBER_TYPE_BIT), fetch_dram_db(game, MEMORY_CONDITION_ID, ref->element, CONDITION_SUB_MEMBER_CONDITION_BIT));
		return;
	}

	if ((E_STATUS_START < ref->element) && (ref->element < E_STATUS_END))
	{
		enchant_conf_update(game, ref);
		return;
	}
}


/*
 * ver1. 2021/08/10
 * アイテム使用時のステータスの上昇処理
 */
void item_status_update(GameWrapper *const game)
{
	EnchantRef enchant;

	enchant.power = fetch_dram_db(game, MEMORY_ITEM_ENCHANT_ID, game->conf.battle.effect.id[0], ITEM_SUB_MEMBER_ENCHANT_POWER);
	enchant.bit   = fetch_dram_db(game, MEMORY_ITEM_ENCHANT_ID, game->conf.battle.effect.id[0], ITEM_SUB_MEMBER_ENCHANT_ENABLE_BIT);
	hero_status_enchant(game, &enchant, game->conf.battle.hero.sort_order[game->conf.battle.loop.item_sort]);
}



/*
 * ver1. 2021/08/08
 * 装備中の装備の効果によるステータス補正値と属性・耐性を保存する
 * 
 * データベースの装備の補正値の並び順が下記の通りに並んでいるため、インデックスを順番に参照していき補正値の合計値を計算し保存する
 * 0. atk
 * 1. def
 * 2. mag
 * 3. res
 * 4. agi
 */
void equip_ref_update(GameWrapper *const game, uint8_t hero_id)
{
	EnchantRef enchant;

	for (uint8_t i = 0; i < STATUS_FIT_NUM; i++)
	{
		enchant.fit_status[i]  = (int32_t)fetch_dram_db(game, MEMORY_ELEMENT_WEAPON_ID, game->hero[hero_id].equip.weapon, WEAPON_ELEMENT_SUB_MEMBER_ATK + i);
		enchant.fit_status[i] += (int32_t)fetch_dram_db(game, MEMORY_ELEMENT_ARMOR_ID,  game->hero[hero_id].equip.armor,  ARMOR_ELEMENT_SUB_MEMBER_ATK  + i);
		enchant.fit_status[i] += (int32_t)fetch_dram_db(game, MEMORY_ELEMENT_AMULET_ID, game->hero[hero_id].equip.amulet, AMULET_ELEMENT_SUB_MEMBER_ATK + i);
	}

	game->hero[hero_id].equip.enchant.atk = enchant.fit_status[0];
	game->hero[hero_id].equip.enchant.def = enchant.fit_status[1];
	game->hero[hero_id].equip.enchant.mag = enchant.fit_status[2];
	game->hero[hero_id].equip.enchant.res = enchant.fit_status[3];
	game->hero[hero_id].equip.enchant.agi = enchant.fit_status[4];
	game->hero[hero_id].equip.element.weapon = fetch_dram_db(game, MEMORY_ELEMENT_WEAPON_ID, game->hero[hero_id].equip.weapon, WEAPON_ELEMENT_SUB_MEMBER_TYPE_BIT);
	game->hero[hero_id].equip.element.armor  = fetch_dram_db(game, MEMORY_ELEMENT_ARMOR_ID, game->hero[hero_id].equip.armor, ARMOR_ELEMENT_SUB_MEMBER_TYPE_BIT) | fetch_dram_db(game, MEMORY_ELEMENT_AMULET_ID, game->hero[hero_id].equip.amulet, AMULET_ELEMENT_SUB_MEMBER_TYPE_BIT);
	game->hero[hero_id].equip.condition      = fetch_dram_db(game, MEMORY_ELEMENT_AMULET_ID, game->hero[hero_id].equip.amulet, AMULET_ELEMENT_SUB_MEMBER_CONDI_BIT);
}



/*
 * ver1. 2021/08/07
 * ローカル構造体にステータス操作時のループ回数を保存する
 * 
 * memory_id	: DRAMに保存されているデータベースのテーブルID
 * effect_id	: テーブルの行IDを選択
 */
void status_ref_update(GameWrapper *const game, StatusRef *const ref, uint8_t memory_id, uint8_t effect_id)
{
	switch (memory_id)
	{
	case MEMORY_MAGIC_ID:
		ref->range     = fetch_dram_db(game, memory_id, effect_id, MAGIC_SUB_MEMBER_RANGE);
		ref->element   = fetch_dram_db(game, memory_id, effect_id, MAGIC_SUB_MEMBER_ELEMENT);
		ref->type      = fetch_dram_db(game, memory_id, effect_id, MAGIC_SUB_MEMBER_TYPE);
		ref->anime_id  = fetch_dram_db(game, memory_id, effect_id, MAGIC_SUB_MEMBER_ANIME);
		break;

	case MEMORY_ITEM_ID:
		ref->range     = fetch_dram_db(game, memory_id, effect_id, ITEM_SUB_MEMBER_RANGE);
		ref->anime_id  = fetch_dram_db(game, memory_id, effect_id, ITEM_SUB_MEMBER_ANIME);
		ref->type      = COMMAND_BATTLE_MAGIC_UNIT;
		break;
	}

	switch (ref->type)
	{
	case COMMAND_BATTLE_MAGIC_UNIT:
		ref->index_loop = (E_SINGLE == ref->range) ? 1 : game->conf.battle.hero.counter;
		ref->sort_pos   = (E_SINGLE == ref->range) ? game->conf.battle.effect.cursol_hero[0] : 0;
		break;

	default:
		ref->index_loop = (E_SINGLE == ref->range) ? 1 : game->conf.battle.enemy.number;
		ref->sort_pos   = (E_SINGLE == ref->range) ? game->conf.battle.effect.cursol_enemy[0] : 0;
		break;
	}
}


/*
 * ver1. 2021/08/07
 * 仲間のわざとアイテムによるステータスの補正値処理
 * bit演算を使用すれば一つの関数で全てのステータスの計算を行えたためこの様な処理にした
 * 死亡状態でも補正値の効果を受けるようになっているが、蘇生した時に補正値を0クリアしているため問題はない
 * 
 * 攻撃力操作 bit = 0001
 * 防御力操作 bit = 0010
 * 魔防力操作 bit = 0100
 * 素早さ操作 bit = 1000
 * 
 * 1が立っているbitを演算すると 0xffffffffになる
 * 0が立っているbitを演算すると 0x00000000になる
 */
static void hero_status_enchant(GameWrapper *const game, EnchantRef *const enchant, uint8_t hero_id)
{
	enchant->fit_status[0] = game->hero[hero_id].status.enchant.atk + (enchant->power & (~((enchant->bit >> 0) & 0x01) + 1));
	enchant->fit_status[1] = game->hero[hero_id].status.enchant.def + (enchant->power & (~((enchant->bit >> 1) & 0x01) + 1));
	enchant->fit_status[2] = game->hero[hero_id].status.enchant.mag + (enchant->power & (~((enchant->bit >> 2) & 0x01) + 1));
	enchant->fit_status[3] = game->hero[hero_id].status.enchant.res + (enchant->power & (~((enchant->bit >> 3) & 0x01) + 1));
	enchant->fit_status[4] = game->hero[hero_id].status.enchant.agi + (enchant->power & (~((enchant->bit >> 4) & 0x01) + 1));
	fit_status_update(enchant);
	game->hero[hero_id].status.enchant.atk = enchant->fit_status[0];
	game->hero[hero_id].status.enchant.def = enchant->fit_status[1];
	game->hero[hero_id].status.enchant.mag = enchant->fit_status[2];
	game->hero[hero_id].status.enchant.res = enchant->fit_status[3];
	game->hero[hero_id].status.enchant.agi = enchant->fit_status[4];
}


/*
 * ver1. 2021/08/07
 * エネミーのステータスの補正値処理
 */
static void enemy_status_enchant(GameWrapper *const game, EnchantRef *const enchant, uint8_t enemy_id)
{
	enchant->fit_status[0] = game->enemy[enemy_id].enchant.atk + (enchant->power & (~((enchant->bit >> 1) & 0x01) + 1));
	enchant->fit_status[1] = game->enemy[enemy_id].enchant.def + (enchant->power & (~((enchant->bit >> 2) & 0x01) + 1));
	enchant->fit_status[2] = game->enemy[enemy_id].enchant.mag + (enchant->power & (~((enchant->bit >> 2) & 0x01) + 1));
	enchant->fit_status[3] = game->enemy[enemy_id].enchant.res + (enchant->power & (~((enchant->bit >> 3) & 0x01) + 1));
	enchant->fit_status[4] = game->enemy[enemy_id].enchant.agi + (enchant->power & (~((enchant->bit >> 4) & 0x01) + 1));
	fit_status_update(enchant);
	game->enemy[enemy_id].enchant.atk = enchant->fit_status[0];
	game->enemy[enemy_id].enchant.def = enchant->fit_status[1];
	game->enemy[enemy_id].enchant.mag = enchant->fit_status[2];
	game->enemy[enemy_id].enchant.res = enchant->fit_status[3];
	game->enemy[enemy_id].enchant.agi = enchant->fit_status[4];
}


/*
 * ver1. 2021/08/07
 * ステータスの補正値が上限値を超えていないか判定を行い、超えていれば上限値を設定する
 */
static void fit_status_update(EnchantRef *const enchant)
{
	for (uint8_t i = 0; i < STATUS_FIT_NUM; i++)
	{
		if (MAX_STATUS_ENCHANT < enchant->fit_status[i])
		{
			enchant->fit_status[i] = MAX_STATUS_ENCHANT;
		}
		else
		if (enchant->fit_status[i] < MIN_STATUS_ENCHANT)
		{
			enchant->fit_status[i] = MIN_STATUS_ENCHANT;
		}
	}
}


/*
 * ver1. 2021/08/07
 * ステータスの上昇、下降処理を管理
 */
static void enchant_conf_update(GameWrapper *const game, StatusRef *const ref)
{
	EnchantRef enchant;
	enchant.power = fetch_dram_db(game, MEMORY_STATUS_CONFIG_ID, ref->element, STATUS_SUB_MEMBER_CONFIG_POWER);
	enchant.bit   = fetch_dram_db(game, MEMORY_STATUS_CONFIG_ID, ref->element, STATUS_SUB_MEMBER_CONFIG_ENABLE_BIT);

	for (uint8_t i = 0; i < ref->index_loop; i++)
	{
		uint8_t unit_id = ref->sort_pos + i;

		switch (ref->type)
		{
		case COMMAND_BATTLE_MAGIC_UNIT:
			hero_status_enchant(game, &enchant, game->conf.battle.hero.sort_order[unit_id]);
			break;

		case COMMAND_BATTLE_MAGIC_ENEMY:
			enemy_status_enchant(game, &enchant, unit_id);
			break;

		default:
			break;
		}
	}
}


/*
 * ver2. 2021/08/10
 * 状態異常は一つだけかかるようにした。
 * 状態異常は状態異常で上書き可能として、耐性が無い場合状態異常にかかるようにした
 * 
 * ver1. 2021/08/06
 * 仲間の状態異常操作処理
 * 
 * type_bit
 * 状態異常に対応したbitを指定、耐性が無ければcondition定数の状態異常にする
 * 
 * condition UNIT_CONDITION_xxx定数を指定
 * CONDITION_CURE_GOOD 		回復
 * UNIT_CONDITION_POISON	毒など
 */
static void hero_condition_update(GameWrapper *const game, StatusRef *const ref, uint32_t type_bit, uint8_t condition)
{
	for (uint8_t i = 0; i < ref->index_loop; i++)
	{
		uint8_t hero_id = game->conf.battle.hero.sort_order[ref->sort_pos + i];

		if (game->hero[hero_id].battle.arive == BATTLE_HERO_DEATH)
		{
			continue;
		}

		if (bit_count(game->hero[hero_id].equip.element.armor & type_bit) == 0)
		{
			update_condition_db(game, hero_id);
			game->hero[hero_id].battle.condition = condition;
		}
	}
}
