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
 * 操作キャラクターの描画に必要な座標データと、画像データの切り取りアドレス関連を管理するファイル
 */

#ifndef unit_wrapper_h   /* prevent circular inclusions */
#define unit_wrapper_h   /* by using protection macros */

/**
 * @brief  ミニゲームのアニメーションのメンバを管理
 * @note   
 * 
 * @param  jump_count_number ジャンプの残り回数を保存
 * @param  bomb_number 爆弾の数を保存
 * @retval None
 */
typedef struct unit_action
{
    uint8_t jump_count_number;
	uint8_t  bomb_number;
} UnitAction;


/*
 * キャラクターの描画方法を管理
 *
 * 表示を行うキャラクターを保存
 * mapchip_id
 * 
 * 歩行の画像データ参照用カウンター
 * workpos
 * 
 * 歩行の画像データの切り取り座標を保存
 * cutpos
 * 
 * 表示を行うキャラクター画像データのIDを保存
 */
typedef struct unitdraw
{
    uint32_t mapchip_id;
    uint8_t  workpos;
    uint32_t cutpos;
    uint32_t chara_chipid;
} UnitDraw;


/*
 * ver3. 2021/06/27
 * エンカウント用のカウント値、encountメンバ追加
 *
 * ver2. 2021/06/24
 * 対象物イベント判定用座標のeventx, y追加
 *
 * キャラクターの現在座標を保存
 * x, y
 * 
 * キャラクターの現在の向きを保存
 * unitdir
 * 
 * マップアニメーションを行うためのフィールドの現在座標を保存
 * fieldx, y
 * 
 * スイッチ入力を行った時に、キャラクターの現在位置と向きによって対象物のイベントを判定する座標
 * eventx, y
 * 
 * マップアニメーション時のpixel数を管理
 * anime_cnt, pixel_x, pixel_y
 */
typedef struct pos
{
    int32_t unitx;
    int32_t unity;
    uint8_t unitdir;
    int32_t fieldx;
    int32_t fieldy;
    int32_t eventx;
    int32_t eventy;
    uint32_t anime_cnt;
    uint32_t animation_pixel_x;
    uint32_t animation_pixel_y;
    uint8_t old_key;
    uint32_t encount;
} UnitPos;


/*
 * ver1. 2021/07/04
 * ファイルの構造体を管理するラッパー構造体
 */
typedef struct unit
{
    UnitPos    pos;
    UnitDraw   draw;
    UnitAction action;
} UnitWrapper;

#endif
