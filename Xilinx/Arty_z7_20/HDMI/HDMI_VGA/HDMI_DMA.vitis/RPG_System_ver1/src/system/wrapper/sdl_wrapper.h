/*
 * Create 2021/08/18
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
 * SDLを模倣した構造体を管理するヘッダーファイル
 * このSDL構造体は静的に確保はしない
 * 関数内でローカル変数として宣言し計算処理を分かりやすくするために使用する
 */
#ifndef sdl_wrapper_h   /* prevent circular inclusions */
#define sdl_wrapper_h   /* by using protection macros */

/*
 * ver1. 2021/08/11
 * 描画時のx,y座標と横縦のサイズを保存
 * SDLのRect構造体を模倣した
 */
typedef struct sdl_rect
{
	int32_t x, y;
	int32_t w, h;
} SDL_Rect;


/*
 * ver1. 2021/08/18
 * メニュー画面などでカーソル操作時の座標における、
 * 画面のスライド移動や文字列の色を判定する計算処理に利用
 * 
 * col		カーソルの位置が表示画面内の最大値まで移動しているか確認する時に使用
 * scroll	カーソルが移動した際に画面のスクロールの必要があればスクロール計算用に使用する
 * color	カーソルと一致した行の文字列の色変更の時に使用
 */
typedef struct sdl_cursol
{
	int32_t  col;
	uint32_t scroll;
	uint32_t color;
	uint32_t xpos;
	uint32_t ypos;
} SDL_Cursol;


/*
 * ver1. 2021/08/21
 * コマンド入力時のキーデータや再生する音源のIDを保存し処理を実行する時に利用
 * 
 * bit			スイッチのbit値を保存
 * sound_id		再生する音源データのIDを保存
 * sound_ch		音源の再生chを指定し利用
 */
typedef struct sdl_key
{
	uint8_t bit;
	uint8_t sound_id;
	uint8_t sound_ch;
} SDL_Key;


/**
 * @brief  SDLのタイマー管理を行う構造体
 * @note   時間計測を使用する時に利用する
 * @retval None
 */
typedef struct sdl_timer
{
	uint32_t count;
} SDL_Timer;

#endif
