
/*
 * キャラクターのステータスデータベース構造体管理ヘッダーファイル
 */

#ifndef minigame_struct_h   /* prevent circular inclusions */
#define minigame_struct_h   /* by using protection macros */



/*
 * ボムのデータを管理
 *
 * ボムの残り個数
 * bomb_number
 * 
 * アニメーションの更新時間
 * animation_time
 * 
 * 描画を行うマップチップID
 * mapchip_id
 * 
 * ボムを使用したか判定
 * bomb_used    : true  使用
 *              : false 使用していない
 */
typedef struct bombwork
{
    uint8_t  number;
    uint32_t animation_time;
    uint32_t mapchip_id;
    bool     used;
} BombWork;


/*
 * 得点の合計値を管理
 */
typedef struct scoreboard
{
    uint32_t score;
} ScoreBoard;


/*
 * プレイ画面の経過時間の管理
 */
typedef struct playtimer
{
    uint32_t play_timer;
    uint32_t count;
} PlayTimer;

#endif