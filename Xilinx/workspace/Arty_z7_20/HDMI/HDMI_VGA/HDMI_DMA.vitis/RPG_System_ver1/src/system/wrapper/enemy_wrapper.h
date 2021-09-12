/*
 * Create 2021/07/23
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
 * 戦闘に参加する敵のデータを管理するラッパー
 */

#ifndef enemy_wrapper_h   /* prevent circular inclusions */
#define enemy_wrapper_h   /* by using protection macros */


/*
 * ver1. 2021/08/07
 * 敵のステータスのエンチャントを管理
 */
typedef struct
{
    int32_t atk;
    int32_t def;
    int32_t mag;
    int32_t res;
    int32_t agi;
} EnemyEnchant;


/*
 * ver1. 2021/07/03
 * -
 * id           戦闘開始時に敵のIDを保存
 * hp           残りHP
 * atb_gauge    ATBのゲージの数値を管理
 * atb_timer    ATBゲージの更新速度管理タイマー
 * trun_order   ATBゲージがMAXまでたまったら行動可能になる true = active  false = non
 * terget_hero  ATBゲージがMAXまでたまったら攻撃する仲間のIDを保存する
 * draw_pos     バトル中の基本描画ポジションを管理
 * draw_xpos    アニメーション時のx座標の管理を行う、draw_posに対してx座標の値を調整してアニメーションを行う
 * draw_ypos    アニメーション時のy座標の管理を行う、draw_posに対してy座標の値を調整してアニメーションを行う
 * enchant      現在のバフとデバフ
 * condition    状態異常
 * join         死亡した場合false 生存中であればtrue
 * down_on      倒した演出ON true  OFF false
 * alpha        描画中のalpha値
 */
typedef struct
{
    uint8_t  id;
    int16_t  hp;
    int16_t  damege;
    uint8_t  atb_gauge;
    uint32_t atb_timer;
    uint8_t target_hero;
    uint8_t  condition;
    uint32_t draw_pos;
    uint32_t draw_xpos;
    uint32_t draw_ypos;
    uint32_t adjust_pos;
    bool     join;
    bool     down_on;
    uint8_t alpha;
    EnemyEnchant enchant;
} EnemyWrapper;

#endif
