#ifndef direct_macro_h   /* prevent circular inclusions */
#define direct_macro_h   /* by using protection macros */

/*
 * 移動判定用bool値
 */
#define CAN_MOVE        (true)
#define NOT_CAN_MOVE    (false)
#define ON_DIRECT       (true)
#define NON_DIRECT      (false)

/**
 * @brief  NPCのイベント番号を管理
 * @note   
 * @retval None
 */
typedef enum
{
    EVENT_ID_START,
    ROMEN_NPC_ID_1,
    ROMEN_NPC_ID_2,
    ROMEN_NPC_ID_3,
    ROMEN_NPC_ID_4,
} BuildNpcNumber;


/**
 * @brief  MapConf.name構造体に保存するマップ名を管理する。
 * @note   名前の付け方としては下記のとおりとする
 *         1. 村の名前
 *         2. 村の名前_家の番号x_部屋の番号x
 * @retval None
 */
typedef enum
{
    GEKAI_MAP_ID,
    TIKAI_MAP_ID,
    TENKAI_MAP_ID,
    HAZAMA_MAP_ID,
    MAKAI_MAP_ID,
    ROMEN_VIRRAGE_ID,
    ROMEN_HOUSE1_LOOM1_ID,
    ROMEN_HOUSE2_LOOM1_ID,
    ROMEN_DANGEON_ID,
    BEGINNING_HILL_ID,  // はじまりの丘
    MAP_NAME_ID_END,
} MapNameID;


/**
 * @brief  マップ間移動時に使用する定数
 * @note   
 * @retval None
 */
typedef enum
{
    TRY_ROMEN_VIRRAGE_ID,
    TRY_ROMEN_DANGEON_ID,
    TRY_ROMEN_EXIT_ID,
    TRY_MAP_NAME_NULL,
} NextMapNameID;


/**
 * @brief  ワールドマップのマップ移動判定用データベースのIDを定義
 * @note   
 * @retval None
 */
typedef enum
{
    WORLD_DIRECT_GEKAI_START,
    WORLD_DIRECT_GEKAI_ROMEN_VILLAGE = WORLD_DIRECT_GEKAI_START,
    WORLD_DIRECT_GEKAI_ROMEN_TREE,
    WORLD_DIRECT_GEKAI_END,

    // WORLD_DIRRECT_GEKAI_START = WORLD_DIRECT_GEKAI_END 連番にする
    // WORLD_DIRRECT_GEKAI_xxx   = WORLD_DIRECT_GEKAI_END 連番にする
} MapDirectNumber;




#endif