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


/**
 * @brief  npcのアニメーション処理に使用するデータを管理する構造体
 * @note   
 * 
 * @param  map_npcid マップが保持するNPCの連番を保存
 * @param  id npc自身が持つIDを保存
 * @param  pos[] NPCのx,y座標の移動量を保存
 * @param  mapchip_id 描画を行うマップチップのIDを保存
 * @param  cut_pos マップチップの切り取り箇所を保存
 * @param  dir NPCの現在の向きを保存
 * @param  anime_time マップチップ切り替え時間を保存
 * @param  dir_time 行動パターンを実行する時間を保存
 * @param  number 現在のマップに描画するNPCの最大数を保存
 * @retval None
 */
typedef struct npc_wrapper
{
    uint32_t map_npcid[NPC_MAX_DRAW_NUM];
    uint32_t id[NPC_MAX_DRAW_NUM];
    uint32_t pos[NPC_INDEX_NUMBER][NPC_MAX_DRAW_NUM];
    uint8_t mapchip_id[NPC_MAX_DRAW_NUM];
    uint8_t cut_pos[NPC_MAX_DRAW_NUM];
    uint8_t dir[NPC_MAX_DRAW_NUM];
    uint32_t anime_time[NPC_MAX_DRAW_NUM];
    uint32_t dir_time[NPC_MAX_DRAW_NUM];
    uint8_t number;
} NpcWrapper;

#endif
