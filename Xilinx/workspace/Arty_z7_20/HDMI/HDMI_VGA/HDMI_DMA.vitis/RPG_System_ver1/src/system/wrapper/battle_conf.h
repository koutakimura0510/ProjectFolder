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
 * バトルに関するコンフィグ構造体をまとめたヘッダーファイル
 */
#ifndef battle_conf_h   /* prevent circular inclusions */
#define battle_conf_h   /* by using protection macros */


/*
 * ver1. 2021/07/27
 * バトルに使用するステートマシンの状態変数を管理する
 * -
 * 一つの状態遷移メンバにまとめてもよかったが、分けた方が
 * 考えやすかったためこのような形にした
 * -
 * module   状態遷移管理メンバ
 * timer    アニメーション更新タイマー
 * victory  戦闘の終了状況を保存
 */
typedef struct
{
    uint8_t  module;
    uint32_t timer;
    uint8_t  victory;
} StateMachine;


/*
 * ver. 2021/08/06
 * アイテム用のループカウンタメンバの追加
 * 
 * ver1. 2021/08/02
 * 使用したわざの範囲が単体か全体かで、ダメージの計算やエフェクトの描画などの座標参照の値とループ回数が変わる。
 * バトル中の状態遷移ローカル関数内で、同じようにループ回数を取得する処理を何度も行っていたため
 * 座標参照の開始位置とループ回数を保持しておくことにした。
 * 
 * counter      ループ回数
 * cursol       仲間や敵のポジション配列のインデックス参照用
 * item_range   使用アイテムの効果範囲を保存
 * item_sort    使用アイテムを対象としたキャラクターの隊列番号を保存、範囲が全体の場合0を保存
 */
typedef struct loop_position
{
    uint8_t counter;
    uint8_t cursol;
    uint8_t item_range;
    uint8_t item_sort;
} LoopPosition;

/*
 * ver1. 2021/08/02
 * 仲間のエフェクトの描画関連に関するメンバをまとめた
 * 
 * hero_id[]         コマンド完了後、空いているchにキャラクターIDを保存する
 * id[]              コマンド完了後、空いているchに選択したエフェクトのIDを保存
 * cursol_enemy[]    コマンド完了後、カーソルで選択したキャラクターの隊列インデックスを保存
 * cursol_hero[]     コマンド完了後、カーソルで選択したキャラクターの隊列インデックスを保存
 * active[]          コマンド完了後、空いているchをtrueにする
 *                   true  エフェクトタイマーのchが空いている
 *                   false エフェクトタイマーのchが空いていない
 * wait_time[]       コマンド完了後、エフェクト発動までの待機時間を保存
 * com_time[]        コマンド完了後、エフェクト発動までの時間を計測するため、現在の時間を保存
 * anime_select[]    アニメーションの方法を選択
 * loop_count        エフェクトの繰り返し回数
 * sound             発動時にtrue エフェクトのサウンドON、
 * mapchip_id        エフェクトのマップチップID
 * update_time       エフェクトの描画時間
 */
typedef struct
{
    uint8_t  hero_id[HERO_NUMBER];
    uint8_t  id[HERO_NUMBER];
    uint8_t  cursol_enemy[HERO_NUMBER];
    uint8_t  cursol_hero[HERO_NUMBER];
    bool     active[HERO_NUMBER];
    uint32_t wait_time[HERO_NUMBER];
    uint32_t com_time[HERO_NUMBER];
    uint8_t  anime_select[HERO_NUMBER];
    uint8_t  loop_count;
    bool     sound;
    uint8_t  mapchip_id;
    uint32_t update_time;
} EffectStatus;


/*
 * ver1. 2021/08/02
 * 仲間の行動順に関するデータをまとめた構造体
 * 
 * number              戦闘に参加していて、生存している仲間の人数を保存
 * counter             現在のフィールドの最大戦闘参加人数を保存
 * sort_order[]        仲間の隊列を管理し仲間のIDを隊列順に保存
 * anime_order[]       仲間のアニメーションを指定するIDを管理
 * aniamtion_time[]    行動待機中のアニメーション更新タイマー
 * motion_update[]     アニメーションの切り替えチェックに使用する
 */
typedef struct
{
    uint8_t  number;
    uint8_t  counter;
    uint8_t  sort_order[HERO_NUMBER];
    uint8_t  anime_order[HERO_NUMBER];
    uint8_t  old_anime_order[HERO_NUMBER];
    uint32_t animation_time[HERO_NUMBER];
} HeroAnimation;


/*
 * ver1. 2021/08/02
 * エネミーの行動順に関するデータをまとめた構造体
 * 
 * number           戦闘に参加している敵の人数を保存
 * counter          エネミー構造体参照用に戦闘開始時の敵の数を保存
 * sort_order[]     行動予定のエネミーのインデックス番号を保存
 * trun_order[]     行動予定の順番にtrueが保存されていく
 * effect_id[]      行動確定時の攻撃方法を保存
 */
typedef struct
{
    uint8_t  number;
    uint8_t  counter;
    uint8_t  sort_order[BATTLE_ENEMY_NUMBER];
    bool     trun_order[BATTLE_ENEMY_NUMBER];
    uint8_t  effect_id[BATTLE_ENEMY_NUMBER];
} EnemyAnimation;


/*
 * ver1. 2021/08/02
 * ATB関連のデータをまとめた構造体
 * 
 * trun_sound               行動順が回ってきたときの効果音のONOFF指定
 * trun_hero[]              ATBゲージがたまったキャラクターのIDを順番に保存
 * trun_order[]             仲間キャラクターの行動順を管理
 *                          true  行動可能
 *                          false 行動不可
 */
typedef struct
{
    bool     sound;
    uint8_t  hero[HERO_NUMBER];
    bool     order[HERO_NUMBER];
} AtbTrun;


/*
 * ver3. 2021/07/27
 * 最大8人による戦闘を可能にした
 * イベントや地形によって戦闘参加人数を調整することによって
 * パーティで戦う印象を持たせることにした
 *
 * ver2. 2021/07/05
 * エフェクトの処理メンバを追加
 *
 * ver1. 2021/07/04
 * バトルモードのコンフィグを管理
 * -
 * sp バトル突入時の初期spを保存し、戦闘中のspを管理
 */
typedef struct
{
    StateMachine   state;
    LoopPosition   loop;
    EffectStatus   effect;
    HeroAnimation  hero;
    EnemyAnimation enemy;
    AtbTrun trun;
    int8_t sp;
    int8_t max_sp;
    uint8_t motion_update[HERO_NUMBER];
} BattleConf;

#endif
