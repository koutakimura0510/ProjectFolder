/*
 * Create 2021/07/04
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
 * 仲間キャラクターのステータスや状態に関する構造体を管理するファイル
 * 要素を追加する場合は、子要素となる構造体を定義しHeroWrapper構造体の中で宣言を行う
 */

#ifndef hero_wrapper_h   /* prevent circular inclusions */
#define hero_wrapper_h   /* by using protection macros */


/*
 * ver1. 2021/08/06
 * 仲間と敵の技やアイテムを使用した時のステータス補正値を保存
 */
typedef struct
{
    int32_t atk;
    int32_t def;
    int32_t mag;
    int32_t res;
    int32_t agi;
} HeroEnchant;


/*
 * ver1. 2021/08/08
 * 装備中の装備の属性と耐性を保存
 * 
 * weapon   攻撃時の属性を保存
 * armor    属性や状態異常の耐性を保存
 */
typedef struct
{
    uint32_t weapon;
    uint32_t armor;
} HeroElement;


/*
 * ver1. 2021/07/03
 * 仲間キャラクターのステータスを管理
 * -
 * ステータスのパラメータついて
 * 経験値参照テーブルとキャラクターに応じたステータスの上昇値を管理する構造体を作成しレベルアップ時の上昇値を決める。
 * 現在値と上昇値を合算したデータを保存する。
 * -
 * level        レベル
 * hp           ヒットポイント
 * odd_hp       残りヒットポイント
 * atk          攻撃力
 * def          守備力
 * agi          素早さ
 * mag          魔法攻撃力
 * res          魔法防御力
 * exp          取得経験値
 * love         好感度
 * enchant      ステータスのわざとアイテムによる補正値(上昇・下降)を保存
 */
typedef struct status
{
    uint32_t  level;
    int32_t   hp;
    int32_t   odd_hp;
    int32_t   sp;
    int32_t   odd_sp;
    int32_t   atk;
    int32_t   def;
    int32_t   agi;
    int32_t   mag;
    int32_t   res;
    uint32_t  exp;
    uint8_t   love;
    HeroEnchant enchant;
} HeroStatus;


/*
 * ver1. 2021/07/04
 * 仲間キャラクターの戦闘データを管理
 * -
 * damege       リザルト結果を保存
 * draw_pos     バトル中の基本描画ポジションを管理
 * draw_xpos    アニメーション時のx座標の管理を行う、draw_posに対してx座標の値を調整してアニメーションを行う
 * draw_ypos    アニメーション時のy座標の管理を行う、draw_posに対してy座標の値を調整してアニメーションを行う
 * item_gauge   アイテムのATBゲージの数値を保存
 * item_timer   アイテムのATBゲージ更新速度タイマー
 * arive        true 生存 false ひん死状態
 * enchant      現在のバフとデバフ
 * condition    状態異常
 * atb_gauge    ATBのゲージの数値を管理
 * atb_timer    ATBゲージの更新速度管理タイマー
 * skill[]      習得した技を保存
 * skill_number 習得している技の数を保存
 * levelup      レベルアップ時true
 */
typedef struct battle
{
    uint32_t damege;
    uint32_t draw_pos;
    int32_t  draw_xpos;
    int32_t  draw_ypos;
    uint8_t  item_gauge;
    uint32_t item_timer;
    bool     arive;
    uint32_t condition;
    int8_t   atb_gauge;
    uint32_t atb_timer;
    uint8_t  skill[SKILL_MAX];
    uint8_t  skill_number;
    bool     levelup;
} HeroBattle;


/*
 * ver2. 2021/08/08
 * 装備中の効果によるステータスの上昇値と下降値を保存
 *
 * ver1. 2021/07/03
 * 仲間キャラクターの装備を管理
 * -
 * 装備について
 * enumのIDで武器防具それぞれに連番を定義しておく。
 * 指定した番号をこの構造体に保存し、ダメージ計算や状態異常のチェック時に保存IDから
 * 装備のデータベースにアクセスし定数値を取得。その後にダメージ計算を行う。
 * -
 * weapon       装備中の武器ID
 * hat          装備中の帽子ID
 * amulet       装備中のアクセサリーID
 * item         登録中のアイテム
 * condition    装備中の装備の永続状態異常を保存
 * enchant      装備中の装備の補正値の合計値を保存
 * element      装備中の装備の耐性と属性を保存
 */
typedef struct equip
{
    uint8_t  weapon;
    uint8_t  armor;
    uint8_t  amulet;
    uint8_t  item;
    uint8_t condition;
    HeroEnchant enchant;
    HeroElement element;
} HeroEquip;


/*
 * ver2. 2021/07/03
 * 仲間キャラクターのデータ構造を分けてラッパーで管理するように変更
 *
 * ver1. 2021/06/27
 * 仲間キャラクターの詳細を保存
 */
typedef struct hero_wrapper
{
    HeroStatus status;
    HeroEquip  equip;
    HeroBattle battle;
} HeroWrapper;

#endif
