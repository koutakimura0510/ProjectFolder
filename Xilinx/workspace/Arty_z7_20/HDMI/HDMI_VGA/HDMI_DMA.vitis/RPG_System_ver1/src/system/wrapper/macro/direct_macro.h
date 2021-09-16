#ifndef direct_macro_h   /* prevent circular inclusions */
#define direct_macro_h   /* by using protection macros */

/*
 * 移動判定用bool値
 */
#define CAN_MOVE        (true)
#define NOT_CAN_MOVE    (false)
#define ON_DIRECT       (true)
#define NON_DIRECT      (false)

/*
 * 当たり判定座標参照用ID
 */
typedef enum
{
    DIRECT_GEKAI_ID_START,
    DIRECT_GEKAI_ROMEN_VILLAGE_ID,
    DIRECT_GEKAI_ROMEN_TREE_ID,
    DIRECT_GEKAI_ID_END,

    DIRECT_ROMEN_ID_START,
    DIRECT_ROMEN_ID_EXIT,
    DIRECT_ROMEN_ID_HOUSE1,
    DIRECT_ROMEN_ID_HOUSE2,
    DIRECT_ROMEN_ID_KANBAN1,
    DIRECT_ROMEN_ID_KANBAN3_1,
    DIRECT_ROMEN_ID_KANBAN3_2,
    DIRECT_ROMEN_ID_KANBAN4,
    DIRECT_ROMEN_ID_KANBAN5,
    DIRECT_ROMEN_ID_ITEM_SHOP,
    DIRECT_ROMEN_ID_WEPON_SHOP,
    DIRECT_ROMEN_ID_ITEM1,
    DIRECT_ROMEN_ID_ITEM2,
    DIRECT_ROMEN_ID_ITEM3,
    DIRECT_ROMEN_ID_END,

    DIRECT_ROMEN_ID_LOOM1_START,
    DIRECT_ROMEN_ID_LOOM1,
    DIRECT_ROMEN_ID_LOOM1_END,

    DIRECT_ROMEN_ID_LOOM2_START,
    DIRECT_ROMEN_ID_LOOM2,
    DIRECT_ROMEN_ID_LOOM2_END,

    DIRECT_ROMEN_DANGEON_ID_START,
    DIRECT_ROMEN_DANGEON_ID_END,

    DIRECT_NULL,
} ExitID;


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
    MAP_NAME_ID_END,
} MapNameID;

#endif