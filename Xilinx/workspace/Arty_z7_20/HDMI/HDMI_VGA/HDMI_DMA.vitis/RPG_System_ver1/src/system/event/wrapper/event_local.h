/*
 * Create 2021/08/15
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
 * イベントに関するデータを管理するヘッダーファイル
 */
#ifndef event_local_h   /* prevent circular inclusions */
#define event_local_h   /* by using protection macros */


/*
 * ver1. 2021/08/19
 * マップ描画やNPCの描画に必要な座標計算用の変数を管理する構造体
 * バックグラウンドとオブジェクト描画の計算処理が同様のため、
 * 描画関数を呼び出す前に計算処理をしておき、メンバ変数を共有して使用することにした
 * 
 * obj_start    :オブジェクトとして使用するマップチップの開始ID
 * obj_end      :オブジェクトとして使用するマップチップの終了ID
 * xsize        :マップのxサイズ
 * field        :キャラクターの現在座標からフィールドの座標参照用の数値を保存
 * center       :キャラクターの移動アニメーション時の座標系産地を保存
 * draw_adr     :描画を行うアドレスの基本値の計算結果を保存
 * index        :マップのデータが保存されている配列のインデックス参照用の値を保存
 * *buffer      :マップデータが保存されているアドレスを保存
 */
typedef struct
{
    uint32_t obj_start;
    uint32_t obj_end;
    uint32_t xsize;
    uint32_t field;
    uint32_t center;
    uint32_t draw_adr;
    uint32_t index;
    uint32_t *buffer;
} DrawElement;



/* マクロ定数を定義 */
#include "../draw/detection_macro.h"
#include "../draw/draw_macro.h"
#include "../unit/unit_event_macro.h"
#include "../msg/msg_macro.h"
#include "../cmd/cmd_macro.h"
#include "../animation/animation_macro.h"
#include "../status/status_macro.h"
#include "../menu/menu_macro.h"



/* フォルダ全体で共有する関数ファイルを宣言 */
#include "../npc/npc_func.h"
#include "../exp/exp_func.h"
#include "../draw/draw_func.h"
#include "../direct/direct_func.h"
#include "../unit/unit_func.h"
#include "../msg/msg_func.h"
#include "../map/event_map_func.h"
#include "../battle/wrapper/battle_func.h"
#include "../cmd/cmd_func.h"
#include "../animation/animation_func.h"
#include "../status/status_func.h"
#include "../item/item_func.h"
#include "../formation/formation_func.h"
#include "../menu/menu_func.h"

#endif
