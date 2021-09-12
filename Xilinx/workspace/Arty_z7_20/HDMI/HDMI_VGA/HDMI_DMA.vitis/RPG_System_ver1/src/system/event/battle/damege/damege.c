/*
 * Create 2021/08/02
 * Author kimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * IC
 * -
 * ダメージ描画とダメージ計算の処理をまとめたファイル
 * actioc.cにすべて記入していたが、1000行を超えてしまったのでファイルを分けた
 */
#include "../../../wrapper/game_wrapper.h"
#include "../wrapper/local_share.h"

#ifdef MYDEBUG
#include "xil_printf.h"
#endif


/*
 * ver1. 2021/08/03
 * ダメージ計算用のパラメータ保存構造体
 * 
 * ローカル変数として使用するため、使用する関数内で定義を行う
 * ResultCalc calc
 */
typedef struct
{
    int32_t  str;       //キャラクターの力のステータス
    int32_t  power;     //わざの威力
    int32_t  atk;       //力と威力を計算した攻撃力
    int32_t  def;       //防御力
    int32_t  ratio;     //倍率
    uint8_t  sort;      //キャラクター番号
    uint8_t  enemy_id;  //攻撃対象の敵のID
    uint8_t  effect;    //技のID
    uint32_t element;   //技の属性
    uint8_t  type;      //技のタイプ
    uint32_t result;    //計算結果
} ResultCalc;


/* ファイル内関数 */
static void hero_heal_calc(GameWrapper *const game);
static void hero_attack_calc(GameWrapper *const game);
static void hero_rase_calc(GameWrapper *const game);
static void enemy_attack_calc(GameWrapper *const game);
static void enemy_hp_calc(GameWrapper *const game, ResultCalc *const calc);
static void hero_hp_calc(GameWrapper *const game, ResultCalc *const calc);
static void hero_calc_def(GameWrapper *const game, ResultCalc *const calc);
static uint32_t get_calc_element(GameWrapper *const game, ResultCalc *const calc, uint8_t target);
static int32_t get_calc_attack(int32_t atk, int32_t enchant, int32_t ratio, uint8_t type);
static int32_t get_calc_ratio(int32_t str, int32_t level, uint8_t type);
static int32_t get_calc_skill(GameWrapper *const game, int32_t update);
static int32_t get_calc_total(ResultCalc *const calc);
static void hero_result_font(GameWrapper *const game, uint8_t hero_id, uint32_t srcin);
static void hero_heal_draw(GameWrapper *const game, uint8_t memory_id);
static void hero_damege_draw(GameWrapper *const game);
static void enemy_damege_draw(GameWrapper *const game, uint8_t memory_id);


/*
 * ver1. 2021/07/30
 * ダメージと回復の計算関数を管理
 */
void select_unit_calc(GameWrapper *const game, uint8_t calc_id)
{
    switch (calc_id)
    {
    case COMMAND_BATTLE_MAGIC_UNIT:
        hero_heal_calc(game);
        break;

    case COMMAND_BATTLE_ATTACK_UNIT:
        enemy_attack_calc(game);
        break;

	case COMMAND_BATTLE_MAGIC_RISE:
		hero_rase_calc(game);
		break;

	default:
        hero_attack_calc(game);
        break;
    }
}


/*
 * ver1. 2021/07/30
 * ダメージと回復の描画関数を管理
 * 
 * COMMAND_BATTLE_MAGIC_UNIT    仲間の回復リザルト値描画
 * COMMAND_BATTLE_ATTACK_UNIT   仲間のダメージ値描画
 * default                      敵のダメージ値描画
 */
void select_unit_damege_draw(GameWrapper *const game, uint8_t draw_id, uint8_t memory_id)
{
    switch (draw_id)
    {
    case COMMAND_BATTLE_MAGIC_UNIT:
        hero_heal_draw(game, memory_id);
        break;

    case COMMAND_BATTLE_ATTACK_UNIT:
        hero_damege_draw(game);
        break;

    default:
        enemy_damege_draw(game, memory_id);
        break;
    }
}


/*
 * ver4. 2021/08/04
 * ダメージ計算の処理とダメージ計算に使用する要素の取得の処理を分けた
 * 
 * ver3. 2021/07/29
 * 技の効果範囲が全体の場合のダメージ計算処理を追加
 * -
 * ver2. 2021/07/24
 * わざのダメージ処理計算内容変更、わざ自体に威力を持たせて計算する
 *
 * ver1. 2021/06/27
 * ダメージ = (行動キャラの攻撃力 - 対象キャラの防御力) x 倍率
 * -
 * 物理
 * 攻撃力   = 武器の攻撃力 + わざの補正値 + (武器の攻撃力 / 8)
 * 防御力   = 対象の物理防御力
 * 倍率     = ((自分の力 * 自分のレベル) / 128) + 2 + 乱数0~3
 * -
 * 参考URL https://wikiwiki.jp/ultinnania/%E3%83%80%E3%83%A1%E3%83%BC%E3%82%B8%E8%A8%88%E7%AE%97%E5%BC%8F%E4%B8%80%E8%A6%A7
 */
static void hero_attack_calc(GameWrapper *const game)
{
    ResultCalc calc;
    calc.effect     = game->conf.battle.effect.id[0];
    calc.sort       = game->conf.battle.effect.hero_id[0];
    calc.element    = fetch_dram_db(game, MEMORY_MAGIC_ID, calc.effect,  MAGIC_SUB_MEMBER_ELEMENT);
    calc.element    = fetch_dram_db(game, MEMORY_ELEMENT_TYPE_ID, calc.element, ELEMENT_SUB_MEMBER_TYPE_BIT);

    switch (fetch_dram_db(game, MEMORY_MAGIC_ID, calc.effect, MAGIC_SUB_MEMBER_TYPE))
    {
    case COMMAND_BATTLE_ATTACK_ENEMY:
        calc.str   = fetch_dram_db(game, MEMORY_WEAPON_ID, game->hero[calc.sort].equip.weapon, WEAPON_SUB_MEMBER_ATK);
        calc.str  += (game->hero[calc.sort].status.love * fetch_dram_db(game, MEMORY_ELEMENT_WEAPON_ID, game->hero[calc.sort].equip.weapon, WEAPON_ELEMENT_SUB_MEMBER_LOVE));
        calc.power = fetch_dram_db(game, MEMORY_MAGIC_ID, calc.effect, MAGIC_SUB_MEMBER_POWER);
        calc.atk   = get_calc_attack(calc.str, game->hero[calc.sort].status.enchant.atk + game->hero[calc.sort].equip.enchant.atk, calc.power, COMMAND_BATTLE_ATTACK_ENEMY);
        calc.ratio = get_calc_ratio(game->hero[calc.sort].status.atk, game->hero[calc.sort].status.level, COMMAND_BATTLE_ATTACK_ENEMY);
        calc.type  = ENEMY_SUB_MEMBER_PARA_DEF;
        break;

    case COMMAND_BATTLE_MAGIC_ENEMY:
        calc.str   = fetch_dram_db(game, MEMORY_MAGIC_ID, calc.effect, MAGIC_SUB_MEMBER_POWER);
        calc.atk   = get_calc_attack(calc.str, game->hero[calc.sort].status.enchant.mag + game->hero[calc.sort].equip.enchant.mag, 0, COMMAND_BATTLE_MAGIC_ENEMY);
        calc.ratio = get_calc_ratio(game->hero[calc.sort].status.mag, game->hero[calc.sort].status.level, COMMAND_BATTLE_MAGIC_ENEMY);
        calc.type  = ENEMY_SUB_MEMBER_PARA_RES;
        break;

    default:
        break;
    }

    enemy_hp_calc(game, &calc);
}


/*
 * ver3. 2021/08/04
 * 回復をしたキャラクターが技動作中のキャラクターの場合、状態終了時にチップデータの変更を行うため回復処理中はチップの変更を行わない
 *
 * ver2. 2021/07/29
 * 全体技選択時の計算処理を追加
 * -
 * ver1. 2021/07/24
 * 回復時の計算処理
 * 
 * 回復リザルト値計算
 * 
 * リザルト = (攻撃力 * 倍率) + 乱数(0~xxxx)
 */
static void hero_heal_calc(GameWrapper *const game)
{
    ResultCalc calc;
    StatusRef ref;

    status_ref_update(game, &ref, MEMORY_MAGIC_ID, game->conf.battle.effect.id[0]);
    calc.power  = fetch_dram_db(game, MEMORY_MAGIC_ID, game->conf.battle.effect.id[0], MAGIC_SUB_MEMBER_POWER);
    calc.power  = get_calc_attack(calc.power, 0, 0, COMMAND_BATTLE_MAGIC_UNIT);
    calc.power  = get_calc_skill(game, calc.power);
    calc.ratio  = get_calc_ratio(game->hero[game->conf.battle.effect.hero_id[0]].status.mag, game->hero[game->conf.battle.effect.hero_id[0]].status.level, COMMAND_BATTLE_MAGIC_UNIT);
    calc.result = calc.power * calc.ratio;

    for (uint8_t i = 0; i < ref.index_loop; i++)
    {
        uint8_t hero_id = game->conf.battle.hero.sort_order[ref.sort_pos + i];
        hero_damege_cure(game, hero_id, calc.result + get_rand(0x0f));
    }
}


/*
 * ver2. 2021/08/06
 * 蘇生処理を技以外でも使用するため、外部関数化した
 * 
 * ver1. 2021/08/01
 * 蘇生系の技を使用した時の仲間の状態変更を行う処理
 * -
 * 蘇生HPの計算
 * 再生HP = 最大HP / わざのパワー
 * わざのパワーが1で完全蘇生
 */
static void hero_rase_calc(GameWrapper *const game)
{
    StatusRef ref;
    status_ref_update(game, &ref, MEMORY_MAGIC_ID, game->conf.battle.effect.id[0]);

    for (uint8_t i = 0; i < ref.index_loop; i++)
    {
        uint8_t pos = ref.sort_pos + i;
        hero_alive_cure(game, pos, game->hero[pos].status.hp / fetch_dram_db(game, MEMORY_MAGIC_ID, game->conf.battle.effect.id[0], MAGIC_SUB_MEMBER_POWER));
    }
}


/*
 * TOP
 * 敵の攻撃の計算処理を行う
 *
 * ver2. 2021/08/04
 * ダメージ計算に使用する要素の取得と、ダメージ計算の処理を分けた
 * 
 * ver1. 2021/07/30
 * 関数作成
 * -
 * 計算式
 * 攻撃 = 敵の攻撃力 + (敵の攻撃力 / 8)
 * 防御 = 対象の防御力
 * 倍率 = モンスター固有の倍率
 * ダメージ = ((攻撃 - 防御) x 倍率) >> 耐性の数)
 * 
 * 魔法攻撃も同様
 */
static void enemy_attack_calc(GameWrapper *const game)
{
    ResultCalc calc;
    // uint8_t element = fetch_dram_db(game, MEMORY_MAGIC_ID, game->conf.battle.effect.id[0], MAGIC_SUB_MEMBER_ELEMENT);

    calc.sort    = game->enemy[game->conf.battle.enemy.sort_order[0]].id;
    calc.effect  = game->conf.battle.enemy.effect_id[0];
    calc.type    = fetch_dram_db(game, MEMORY_MAGIC_ID,  calc.effect,  MAGIC_SUB_MEMBER_TYPE);
    calc.element = fetch_dram_db(game, MEMORY_MAGIC_ID,  calc.effect,  MAGIC_SUB_MEMBER_ELEMENT);
    calc.element = fetch_dram_db(game, MEMORY_ELEMENT_TYPE_ID, calc.element, ELEMENT_SUB_MEMBER_TYPE_BIT);

    switch (calc.type)
    {
    case COMMAND_BATTLE_ATTACK_UNIT:
        calc.str   = fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, calc.sort, ENEMY_SUB_MEMBER_PARA_ATK);
        calc.power = fetch_dram_db(game, MEMORY_MAGIC_ID, calc.effect, MAGIC_SUB_MEMBER_POWER);
        calc.atk   = get_calc_attack(calc.str, game->enemy[game->conf.battle.enemy.sort_order[0]].enchant.atk, calc.power, COMMAND_BATTLE_ATTACK_UNIT);
        calc.ratio = get_calc_ratio(calc.str, fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, calc.sort, ENEMY_SUB_MEMBER_PARA_LEVEL), COMMAND_BATTLE_ATTACK_UNIT);
        break;

    case COMMAND_BATTLE_MAGIC_UNIT:
        calc.str   = fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, calc.sort, ENEMY_SUB_MEMBER_PARA_MAG);
        calc.power = fetch_dram_db(game, MEMORY_MAGIC_ID, calc.effect, MAGIC_SUB_MEMBER_POWER);
        calc.atk   = get_calc_attack(calc.power, game->enemy[game->conf.battle.enemy.sort_order[0]].enchant.mag, 0, COMMAND_BATTLE_MAGIC_UNIT);
        calc.ratio = get_calc_ratio(calc.str, fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, calc.sort, ENEMY_SUB_MEMBER_PARA_LEVEL), COMMAND_BATTLE_MAGIC_UNIT);
        break;

    default:
        calc.ratio = 0;

#ifdef MYDEBUG
        xil_printf("ATK TYPE = %d\n", calc.type);
        xil_printf("EFFECT ID = %d\n", calc.effect);
#endif
        break;
    }

    hero_hp_calc(game, &calc);
}


/*
 * ver1. 2021/08/04
 * 仲間の攻撃のダメージ計算と敵のHPの計算処理を行う
 */
static void enemy_hp_calc(GameWrapper *const game, ResultCalc *const calc)
{
    StatusRef ref;

    status_ref_update(game, &ref, MEMORY_MAGIC_ID, calc->effect);
    calc->atk = get_calc_skill(game, calc->atk);

    for (uint8_t i = 0; i < ref.index_loop; i++)
    {
        uint8_t pos     = ref.sort_pos + i;
        int32_t enchant = (calc->type == ENEMY_SUB_MEMBER_PARA_RES) ? game->enemy[pos].enchant.res : game->enemy[pos].enchant.def;
        calc->def       = (int32_t)fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[pos].id, calc->type) + enchant;
        calc->enemy_id  = game->enemy[pos].id;
        game->enemy[pos].damege = get_calc_total(calc) >> get_calc_element(game, calc, COMMAND_BATTLE_ATTACK_ENEMY);
        game->enemy[pos].hp -= game->enemy[pos].damege;
    }

#ifdef MYDEBUG
    for (uint8_t i = 0; i < game->conf.battle.enemy.number; i++)    //デバッグ用に敵のHP出力
    {
        xil_printf("Enemy%d HP = %d\n", game->enemy[i].id, game->enemy[i].hp);
    }
#endif
}


/*
 * ver2. 2021/08/10
 * カリスマガード状態のダメージ計算処理を追加
 * 状態がカリスマガードならば、ダメージ64%軽減
 * 
 * ver2. 2021/08/08
 * エンチャントと装備のステータスの補正値の計算処理を追加
 *
 * ver1. 2021/08/04
 * 敵の攻撃のダメージ計算と仲間のHPの計算処理を行う
 */
static void hero_hp_calc(GameWrapper *const game, ResultCalc *const calc)
{
    for (uint8_t i = 0; i < game->conf.battle.loop.counter; i++)
    {
        calc->sort = game->conf.battle.hero.sort_order[game->conf.battle.loop.cursol + i];
        hero_calc_def(game, calc);
        game->hero[calc->sort].battle.damege = get_calc_total(calc) >> get_calc_element(game, calc, COMMAND_BATTLE_ATTACK_UNIT);

        if (game->hero[calc->sort].battle.condition == UNIT_CONDITION_RIFREK)
        {
            game->hero[calc->sort].battle.damege >>= GUARD_REMIRIA;
            game->hero[calc->sort].battle.condition = 0;
        }
        
        game->hero[calc->sort].status.odd_hp -= game->hero[calc->sort].battle.damege;

        if (game->hero[calc->sort].status.odd_hp < 0)
        {
            game->hero[calc->sort].status.odd_hp = 0;
            battle_dying_sort(game, calc->sort);
        }
    }
}


/*
 * ver1. 2021/08/08
 * 敵から攻撃を受けたときの攻撃の種類を判定し、ダメージ計算用に仲間の防御力の合計値を保存する
 */
static void hero_calc_def(GameWrapper *const game, ResultCalc *const calc)
{
    switch (calc->type)
    {
    case COMMAND_BATTLE_ATTACK_UNIT:
        calc->def = game->hero[calc->sort].status.def + game->hero[calc->sort].status.enchant.def + game->hero[calc->sort].equip.enchant.def;
        break;

    case COMMAND_BATTLE_MAGIC_UNIT:
        calc->def = game->hero[calc->sort].status.res + game->hero[calc->sort].status.enchant.res + game->hero[calc->sort].equip.enchant.res;
        break;

    default:
        calc->def = 0;
        break;
    }
}


/*
 * ver1. 2021/08/08
 * キャラクターの攻撃時の属性を攻撃対象が耐性をもっているか判定を行いbit数を取得する
 * 
 * terget 敵を攻撃する時に選択      COMMAND_BATTLE_ATTACK_ENEMY
 *        仲間が攻撃される時に選択  COMMAND_BATTLE_ATTACK_UNIT
 * return 耐性の数分だけシフト演算を行うため、1が立っていた個数を取得
 * -
 * 耐性bit計算
 * 
 * 仲間が攻撃する時   (武器の属性 | 仲間の技の属性) & 敵の耐性
 * 敵が攻撃する時     仲間の装備の耐性 & 敵の技の属性
 */
static uint32_t get_calc_element(GameWrapper *const game, ResultCalc *const calc, uint8_t target)
{
    switch (target)
    {
    case COMMAND_BATTLE_ATTACK_ENEMY:
        return bit_count((game->hero[calc->sort].equip.element.weapon | calc->element) & fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, calc->enemy_id, ENEMY_SUB_MEMBER_PARA_REGISTER));

    case COMMAND_BATTLE_ATTACK_UNIT:
        return bit_count(game->hero[calc->sort].equip.element.armor & calc->element);

    default:
        return 0;
    }
}


/*
 * ver1. 2021/07/31
 * ダメージ計算の攻撃力の計算をし取得
 * 
 * 魔法攻撃の場合は素の攻撃力を計算し取得する
 * 物理攻撃の場合は、わざの全体攻撃などでダメージ量が変動するため補正値の計算をし取得
 * 
 * 攻撃力 = (攻撃力 + (攻撃力 / 8)) * 技の威力補正値 / 100
 * 魔法   = 魔法の威力 + (魔法の威力 / 8)
 */
static int32_t get_calc_attack(int32_t atk, int32_t enchant, int32_t ratio, uint8_t type)
{
    atk = atk + enchant + (atk >> 3);

    if ((type == COMMAND_BATTLE_ATTACK_ENEMY) || (type == COMMAND_BATTLE_ATTACK_UNIT))
    {
        atk = (atk * ratio) / DIG_3_FIX;
    }

    return atk;
}


/*
 * ver1. 2021/07/31
 * ダメージ計算の倍率の計算処理
 * 
 * 攻撃 = ((自分の攻撃力 * 自分のレベル) / 128) + 2 + 乱数0~2
 * 魔法 = ((自分の魔力   * 自分のレベル) / 256) + 4 + 乱数0~2
 */
static int32_t get_calc_ratio(int32_t str, int32_t level, uint8_t type)
{
    if ((type == COMMAND_BATTLE_ATTACK_ENEMY) || (type == COMMAND_BATTLE_ATTACK_UNIT))
    {
        return ((str * level) >> 7) + 2 + get_rand(0x03);
    }
    
    if ((type == COMMAND_BATTLE_MAGIC_ENEMY) || (type == COMMAND_BATTLE_MAGIC_UNIT))
    {
        return ((str * level) >> 8) + 4 + get_rand(0x03);
    }

    return 1;
}


/*
 * ver1. 2021/07/24
 * わざの補正値を計算し取得
 * -
 * DAMEGE_TYPE_STANDERD
 * 通常攻撃の場合は補正はかからない
 * 
 * DAMEGE_TYPE_HIGH_HP
 * ダメージを受けていない程効果増大
 * ratio = 100 + (15 / (MAX HP / ODD HP))
 * 最大1.15倍の威力になる
 * 
 * DAMEGE_TYPE_LOW_HP
 * ダメージを受けている程効果増大]
 * ratio = 100 + (1 + (100 / (odd_hp / (hp / 100)))) / 2
 * 最大1.5倍の威力になる
 * 
 * DAMEGE_TYPE_LOVE
 * 好感度が高いほど効果増大
 * ratio = 100 + (MAX 100 / 4)
 * 最大1.25倍の威力になる
 */
static int32_t get_calc_skill(GameWrapper *const game, int32_t update)
{
    switch (fetch_dram_db(game, MEMORY_MAGIC_ID, game->conf.battle.effect.id[0], MAGIC_SUB_MEMBER_POWER))
    {
    case DAMEGE_TYPE_STANDERD:
        return update;
        
    case DAMEGE_TYPE_HIGH_HP:
        return update + (15 / (game->hero[game->conf.battle.effect.hero_id[0]].status.hp / game->hero[game->conf.battle.effect.hero_id[0]].status.odd_hp));

    case DAMEGE_TYPE_LOW_HP:
        return update + (100 / ((game->hero[game->conf.battle.effect.hero_id[0]].status.odd_hp / (game->hero[game->conf.battle.effect.hero_id[0]].status.hp / 100)) + 1) >> 1);

    case DAMEGE_TYPE_LOVE:
        return update + (game->hero[game->conf.battle.effect.hero_id[0]].status.love >> 2);

    default:
        return update;
    }
}


/*
 * ver1. 2021/07/31
 * 計算した攻撃力、防御力、倍率に応じてダメージの計算を行う
 */
static int32_t get_calc_total(ResultCalc *const calc)
{
    if (calc->atk < calc->def)
    {
        return 1 - (xorshift(get_time()) & 0x01);
    }
    else
    {
        return (calc->atk - calc->def) * calc->ratio;
    }
}


/*
 * ver1. 2021/08/11
 * 仲間のダメージと回復フォントの描画座標計算
 */
static void hero_result_font(GameWrapper *const game, uint8_t hero_id, uint32_t srcin)
{
    int32_t pos  = game->hero[hero_id].battle.draw_pos + YRGB(game->conf.animation.y) + XRGB(game->hero[hero_id].battle.draw_xpos);
    int32_t xpos = XRGB((BATTLE_DAMEGE_UNIT_DRAW_XPOS - (BATTLE_DAMEGE_UNIT_DRAW_NUM * digit_count(game->hero[hero_id].battle.damege))));
    damege_font_draw(game, pos + xpos + BATTLE_DAMEGE_UNIT_DRAW_YPOS, game->hero[hero_id].battle.damege, srcin);
}


/*
 * ver2. 2021/08/04
 * 描画座標の計算方法を改善した
 * 魔法発動中の仲間の座標にエフェクトを描画する時の座標計算に分岐を使用していたが、
 * draw_xposを計算すれば求まることに気が付いた
 * -
 * 移動中の仲間のx座標は0以外であるため、計算で求まる。移動していない味方のdraw_xposは0である
 * 
 * -
 * ver1. 2021/07/29
 * 仲間の回復のフォント描画処理
 */
static void hero_heal_draw(GameWrapper *const game, uint8_t memory_id)
{
    StatusRef ref;

    status_ref_update(game, &ref, memory_id, game->conf.battle.effect.id[0]);

    for (uint8_t i = 0; i < ref.index_loop; i++)
    {
        hero_result_font(game, game->conf.battle.hero.sort_order[ref.sort_pos + i], DRAM_FONT_HEAL_ADDR_BASE);
    }
}


/*
 * ver1. 2021/07/29
 * 仲間が受けるダメージのフォント描画処理
 */
static void hero_damege_draw(GameWrapper *const game)
{
    for (uint8_t i = 0; i < game->conf.battle.loop.counter; i++)
    {
        hero_result_font(game, game->conf.battle.hero.sort_order[game->conf.battle.loop.cursol + i], DRAM_FONT_DAMEGE_ADDR_BASE);
    }
}


/*
 * ver1. 2021/07/29
 * 敵が受けるダメージのフォント描画処理
 */
static void enemy_damege_draw(GameWrapper *const game, uint8_t memory_id)
{
    StatusRef ref;
    SDL_Rect rect;

    status_ref_update(game, &ref, memory_id, game->conf.battle.effect.id[0]);

    for (uint8_t i = 0; i < ref.index_loop; i++)
    {
        uint8_t enemy_id = ref.sort_pos + i;
        rect.h = game->enemy[enemy_id].draw_pos + YRGB(game->conf.animation.y);
        rect.w = fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[enemy_id].id, ENEMY_SUB_MEMBER_PARA_WIDTH) >> 1;
        rect.x = BATTLE_DAMEGE_ENEMY_DRAW_NUM * digit_count(game->enemy[enemy_id].damege);
        rect.x = XRGB((rect.w - rect.x));
        rect.y = YRGB((fetch_dram_db(game, MEMORY_ENEMY_PARA_ID, game->enemy[enemy_id].id, ENEMY_SUB_MEMBER_PARA_HEIGHT) - ADJUST_RESULT_FONT_DRAW_POS));
        damege_font_draw(game, rect.h + rect.x + rect.y, game->enemy[enemy_id].damege, DRAM_FONT_DAMEGE_ADDR_BASE);
    }
}