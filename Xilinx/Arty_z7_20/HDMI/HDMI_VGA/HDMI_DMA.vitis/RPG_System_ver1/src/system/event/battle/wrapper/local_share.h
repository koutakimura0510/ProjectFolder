/*
 * Create 2021/08/04
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
 * battleフォルダ内でのみ共有する関数やマクロファイルを定義するヘッダーファイル
 */

#ifndef local_share_h   /* prevent circular inclusions */
#define local_share_h   /* by using protection macros */

/* マクロ */
#include "../action/action_macro.h"
#include "../damege/damege_macro.h"



/* 関数 */
#include "../subwindow/sub_window_func.h"
#include "../action/action_func.h"
#include "../config/config_func.h"
#include "../sort/sort_func.h"
#include "../damege/damege_func.h"
#include "../animation/anime_func.h"
#include "../condition/condition_func.h"

#endif
