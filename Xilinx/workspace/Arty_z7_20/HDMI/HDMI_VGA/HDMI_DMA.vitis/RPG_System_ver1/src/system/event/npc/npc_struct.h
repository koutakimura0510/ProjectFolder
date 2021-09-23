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


static void npc_center_draw(GameWrapper *const game, DrawElement *const npc);
static void npc_right_draw(GameWrapper *const game, DrawElement *const npc);
static void npc_left_draw(GameWrapper *const game, DrawElement *const npc);
static void npc_up_draw(GameWrapper *const game, DrawElement *const npc);
static void npc_down_draw(GameWrapper *const game, DrawElement *const npc);


/**
 * @brief  npc描画の状態遷移データベース
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
