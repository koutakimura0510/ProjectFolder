/*
 * Create 2021/07/27
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
 * 戦闘アニメーションの状態遷移の定数を管理するヘッダーファイル
 */
#ifndef action_macro_h   /* prevent circular inclusions */
#define action_macro_h   /* by using protection macros */

/* アニメーション更新タイム */
#define SWAP_ACTION_SPEED               (TM_200MS_COUNT)
#define VICTPRY_FANDARE_WAIT_TIME       (TM_500MS_COUNT)
#define VICTORY_ANIME_SPEED             (TM_500MS_COUNT)


/* 入れ替えアニメーションのバンザイの回数 */
#define SWAP_ANIME_LOOP_SET             (0)
#define SWAP_ANIME_LOOP_COUNT           (2)


/* 仲間の二つの画像データで交互にアニメーションをする時の切り替え用定数 */
#define ANIME_CHANGE_MOTION_1          (0)
#define ANIME_CHANGE_MOTION_2          (1)


/* HPに関与するわざか、ステータスに関与するわざか判定する定数 */
#define SKILL_DAMEGE_POWER_NON          (0) //ステータスに関与するわざは威力が0である
#define SKILL_DAMEGE_POWER_CAN          (1) //ステータスに関与する技以外は威力が1以上ある

/* 敵を倒したときの効果音ON/OFF */
#define ENEMY_DEFEAT_SOUND_ON           (true)
#define ENEMY_DEFEAT_SOUND_OFF          (false)


/*
 * ver1. 2021/07/21
 * バトルの行動確定時のアニメ―ション状態遷移定数を定義
 */
typedef enum
{
    BATTLE_NORMAL_STATE_DEFAULT,        // どの状態に遷移するか判定を行うモジュール
    BATTLE_NORMAL_STATE_SWAP_WALK,      // 入れ替え時の入れ替えアニメーション
    BATTLE_NORMAL_STATE_SWAP_SORT,      // 入れ替え時の隊列入れ替え処理
    BATTLE_NORMAL_STATE_ADVANCE_WALK,   // 行動開始時の歩きモーション
    BATTLE_NORMAL_STATE_PAUSE,          // 待機モーション、エフェクトの描画方法を選定
    BATTLE_NORMAL_STATE_MAGIC_EFFECT,   // 魔法の場合、魔法陣エフェクトを描画
    BATTLE_NORMAL_STATE_MAGIC_POS,      // 対象座標にエフェクトを描画
    BATTLE_NORMAL_STATE_ITEM_DRAW,      // アイテム使用状態
    BATTLE_NORMAL_STATE_ITEM_USE,       // アイテム使用状態
    BATTLE_NORMAL_STATE_DAMEGE_NUM,     // ダメージ計算
    BATTLE_NORMAL_STATE_DAMEGE_DRAW,    // ダメージ描画
    BATTLE_NORMAL_STATE_BACK_WALK,      // 定位置に歩くモーション
    BATTLE_NORMAL_STATE_DOWN_JUGE,      // 与えたダメージで倒したか判定する
    BATTLE_NORMAL_STATE_DOWN_DRAW,      // 倒したアニメーション
    BATTLE_NORMAL_STATE_FINISH,         // データを形成し終了
    BATTLE_ENEMY_STATE_CHIP,
    BATTLE_ENEMY_STATE_MAGIC_EFFECT,
    BATTLE_ENEMY_STATE_MAGIC_POS,
    BATTLE_ENEMY_STATE_ENEMY_MOVE,
    BATTLE_ENEMY_STATE_ANIME,
    BATTLE_ENEMY_STATE_CALC,
    BATTLE_ENEMY_STATE_DAMEGE,
    BATTLE_ENEMY_STATE_RESULT,
	BATTLE_VICTORY_STATE_SOUND_START,
	BATTLE_VICTORY_STATE_RESULT,
	BATTLE_VICTORY_STATE_ANIME_START,
    BATTLE_NORMAL_STATE_END,
    BATTLE_NORMAL_ANIME_SPEED = 2,
    BATTLE_DAMEGE_ANIME_SPEED = 4,
    BATTLE_ENEMY_ANIME_SPEED  = 4,
} BattleNormalStateID;

#endif