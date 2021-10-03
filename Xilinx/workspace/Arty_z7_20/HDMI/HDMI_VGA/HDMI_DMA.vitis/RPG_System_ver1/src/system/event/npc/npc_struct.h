/**
 * Create 2021/09/23
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * @brief npcの描画に関する状態遷移の構造体をまとめたファイル
 */


/* NPCのアニメーション処理時の座標・向き更新関数 */
static void npc_dir_update(GameWrapper *const game, uint8_t index);
static void npc_pixel_update(GameWrapper *const game, uint8_t index);


/**
 * @brief  NPCのアニメーション状態によってメンバの更新関数を変更する関数ポインタ
 * @note   
 * @retval None
 */
typedef struct
{
	void (*const npc_position[NPC_ACTIVE_NUMBER])(GameWrapper *const game, uint8_t index);
} NpcPosition;

static const NpcPosition npc_position = {
	{npc_dir_update, npc_pixel_update},
};