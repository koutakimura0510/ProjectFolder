/**
 * Create 2021/09/23
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * @brief npcの描画に関する状態遷移の構造体をまとめたファイル
 */


#define NPC_STATE_FUNC_DB_SIZE ((sizeof (npc_drawing))/(sizeof (NpcDrawing)))


/* NPCのアニメーション処理時の座標・向き更新関数 */
static void npc_dir_update(GameWrapper *const game, uint8_t index);
static void npc_pixel_update(GameWrapper *const game, uint8_t index);


/* DRAMにNPC描画データを保存する時の位置調整関数 */
static void npc_center_draw(GameWrapper *const game, DrawElement *const npc);
static void npc_right_draw(GameWrapper *const game, DrawElement *const npc);
static void npc_left_draw(GameWrapper *const game, DrawElement *const npc);
static void npc_up_draw(GameWrapper *const game, DrawElement *const npc);
static void npc_down_draw(GameWrapper *const game, DrawElement *const npc);


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


/**
 * @brief  npc描画時の座標計算状態遷移データベース
 * @note   
 * @retval None
 */
typedef struct npc_drawing
{
	uint8_t drawtype;
	void (*npc_window)(GameWrapper *const game, DrawElement *const npc);
} NpcDrawing;

static const NpcDrawing npc_drawing[] =
{
	{DISPLAY_FIELD_CENTER_DRAW, npc_center_draw },
	{DISPLAY_FIELD_RIGHT_DRAW, 	npc_right_draw  },
	{DISPLAY_FIELD_LEFT_DRAW, 	npc_left_draw   },
	{DISPLAY_FIELD_UP_DRAW, 	npc_up_draw     },
	{DISPLAY_FIELD_DOWN_DRAW, 	npc_down_draw   },
};
