/**
 * Create 2021/09/20
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * @brief npcの操作に関する関数を管理するヘッダーファイル
 */
#ifndef npc_func_h   /* prevent circular inclusions */
#define npc_func_h   /* by using protection macros */


void npc_config(GameWrapper *const game);
void npc_draw(GameWrapper *const game);

#endif