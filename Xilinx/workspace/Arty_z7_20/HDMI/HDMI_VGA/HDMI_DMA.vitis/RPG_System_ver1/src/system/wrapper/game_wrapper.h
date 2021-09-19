/*
 * Create 2021/06/03
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
 * ラッパーとローカル関数を管理
 */

#ifndef game_wrapper_h   /* prevent circular inclusions */
#define game_wrapper_h   /* by using protection macros */


/*
 * 読み込み順番
 * 
 * 1. グローバル関数を読み込み
 * 2. 各ラッパー構造体を読み込み
 * 3. ゲームモードを管理するヘッダーファイルを読み込み
 * 4. ストーリーモードに使用するローカル関数を読み込み
 */

#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))

#define MYDEBUG

#include <stdint.h>
#include <stdbool.h>
#include "macro/macro_wrapper.h"
#include "hero_wrapper.h"
#include "unit_wrapper.h"
#include "mapchip_wrapper.h"
#include "conf_wrapper.h"
#include "cmd_wrapper.h"
#include "enemy_wrapper.h"

/*TODO システム構造体も、ファイルの命令に従ってDRAMにデータを保存するように変更する予定である。
 * 保存したデータのアドレスでアクセスする形になる。
 * プログラムメモリが尽きたら移行するようにする
 * 
 * 描画に関する情報を管理するラッパー
 * 関数の引数に指定しデータの共有を行う
 *
 * ver2 2021/07/21
 * システム全体を管理する構造体をラッパー管理するように変更
 *  
 * 2021/06/12 18:00
 * 描画に関する構造体を全て一つのラッパーで管理するように変更
 */
typedef struct game
{
    ConfWrapper conf;
    UnitWrapper unit;
    ChipWrapper mapchip;
    CmdWrapper  cmd;
    HeroWrapper hero[HERO_NUMBER];
    EnemyWrapper enemy[BATTLE_ENEMY_NUMBER];
} GameWrapper;


#include "sdl_wrapper.h"
#include "../calc/calc_func.h"
#include "../debug/msg.h"
#include "../hardware/wrapper/hard_func.h"
#include "../event/wrapper/event_local.h"
#include "../story/story_local.h"
#include "../opening/opening_local.h"
#include "../minigame/minigame_local.h"


#endif
