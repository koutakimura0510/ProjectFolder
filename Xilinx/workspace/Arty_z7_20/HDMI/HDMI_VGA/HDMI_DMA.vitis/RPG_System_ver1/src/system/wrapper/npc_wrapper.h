/**
 * Create 2021/09/20
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * @brief npcの描画データを管理するラッパーファイル
 */
#ifndef npc_wrapper_h   /* prevent circular inclusions */
#define npc_wrapper_h   /* by using protection macros */

typedef struct npc_wrapper
{
    uint32_t id[NPC_MAX_DRAW_NUM];
    uint32_t xpos[NPC_MAX_DRAW_NUM];
    uint32_t ypos[NPC_MAX_DRAW_NUM];
    uint8_t number;
} NpcWrapper;

#endif
