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


/* マクロ定数を定義 */
#include "event_id_macro.h"

#include "../draw/detection_macro.h"
#include "../draw/draw_macro.h"
#include "../unit/unit_event_macro.h"
#include "../msg/msg_macro.h"
#include "../cmd/cmd_macro.h"
#include "../animation/animation_macro.h"
#include "../status/status_macro.h"
#include "../menu/menu_macro.h"



/* フォルダ全体で共有する関数ファイルを宣言 */
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
