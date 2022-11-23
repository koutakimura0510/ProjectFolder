#ifndef minigame_local_h   /* prevent circular inclusions */
#define minigame_local_h   /* by using protection macros */


/**
 * @brief  ミニゲームの状態遷移のIDを定義
 * @note   
 * @retval None
 */
typedef enum
{
	MINIGAME_START_LOAD_ID,
	MINIGAME_TITLE_DRAW_ID,
	MINIGAME_PLAYING_ID,
	MINIGAME_RESULT_DRAW_ID,
} MinigameStateID;


void barrage_mingame(GameWrapper *const game);

#endif
