/*
 * Create 2021/08/10
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * IC      XC7Z020-1CLG400C
 * ROM     256KB
 * RAM     512KB
 * L1Cache 32KB
 * -
 * バトルのアニメーション状態遷移を管理するヘッダーファイル
 */

#ifndef action_struct_h   /* prevent circular inclusions */
#define action_struct_h   /* by using protection macros */


/* 構造体要素数 */
#define BATTLE_ANIMATION_DB_SIZE  ((sizeof (battle_animation))/(sizeof (BattleAnimation)))

/* バトルアニメーション状態遷移関数 */
static void battle_module_wrapper(GameWrapper *const game);
static void hero_action_timer(GameWrapper *const game);
static void hero_swap_action(GameWrapper *const game);
static void hero_swap_sort(GameWrapper *const game);
static void hero_advance_walk(GameWrapper *const game);
static void hero_stand_pause(GameWrapper *const game);
static void magic_activate_draw(GameWrapper *const game);
static void magic_draw_state(GameWrapper *const game);
static void item_draw_state(GameWrapper *const game);
static void item_use_state(GameWrapper *const game);
static void result_calc_state(GameWrapper *const game);
static void action_result_state(GameWrapper *const game);
static void back_walk_state(GameWrapper *const game);
static void action_finish_state(GameWrapper *const game);
static void enemy_down_check(GameWrapper *const game);
static void enemy_down_draw(GameWrapper *const game);

/* 敵の行動の状態遷移関数 */
static void enemy_attack_state(GameWrapper *const game);
static void enemy_magic_activate(GameWrapper *const game);
static void enemy_magic_draw(GameWrapper *const game);
static void enemy_animation_state(GameWrapper *const game);
static void hero_damege_chip_state(GameWrapper *const game);
static void hero_damege_animation_state(GameWrapper *const game);
static void hero_damege_calc_state(GameWrapper *const game);
static void hero_damege_draw_state(GameWrapper *const game);
static void enemy_result_sort_state(GameWrapper *const game);

/* 勝利時の状態遷移関数 */
static void victory_timer_set(GameWrapper *const game);
static void victory_fanfare_start(GameWrapper *const game);
static void victory_animation(GameWrapper *const game);
static void victory_result_store(GameWrapper *const game);


/*
 * ver1. 2021/07/24
 * アニメーションの状態遷移を管理するデータベース
 */
typedef struct
{
    uint8_t system;
    void (*animation_state)(GameWrapper *const game);
} BattleAnimation;

static const BattleAnimation battle_animation[] = 
{
    {BATTLE_NORMAL_STATE_DEFAULT,       battle_module_wrapper       },
    {BATTLE_NORMAL_STATE_SWAP_WALK,     hero_swap_action            },
    {BATTLE_NORMAL_STATE_SWAP_SORT,     hero_swap_sort              },
    {BATTLE_NORMAL_STATE_ADVANCE_WALK,  hero_advance_walk           },
    {BATTLE_NORMAL_STATE_PAUSE,         hero_stand_pause            },
    {BATTLE_NORMAL_STATE_MAGIC_EFFECT,  magic_activate_draw         },
    {BATTLE_NORMAL_STATE_MAGIC_POS,     magic_draw_state            },
    {BATTLE_NORMAL_STATE_ITEM_DRAW,     item_draw_state             },
    {BATTLE_NORMAL_STATE_ITEM_USE,      item_use_state              },
    {BATTLE_NORMAL_STATE_DAMEGE_NUM,    result_calc_state           },
    {BATTLE_NORMAL_STATE_DAMEGE_DRAW,   action_result_state         },
    {BATTLE_NORMAL_STATE_BACK_WALK,     back_walk_state             },
    {BATTLE_NORMAL_STATE_DOWN_JUGE,     enemy_down_check            },
    {BATTLE_NORMAL_STATE_DOWN_DRAW,     enemy_down_draw             },
    {BATTLE_NORMAL_STATE_FINISH,        action_finish_state         },
    {BATTLE_ENEMY_STATE_ENEMY_MOVE,     enemy_animation_state       },
    {BATTLE_ENEMY_STATE_MAGIC_EFFECT,   enemy_magic_activate        },
    {BATTLE_ENEMY_STATE_MAGIC_POS,      enemy_magic_draw            },
    {BATTLE_ENEMY_STATE_CHIP,           hero_damege_chip_state      },
    {BATTLE_ENEMY_STATE_ANIME,          hero_damege_animation_state },
    {BATTLE_ENEMY_STATE_CALC,           hero_damege_calc_state      },
    {BATTLE_ENEMY_STATE_DAMEGE,         hero_damege_draw_state      },
    {BATTLE_ENEMY_STATE_RESULT,         enemy_result_sort_state     },
    {BATTLE_VICTORY_STATE_SOUND_START,  victory_fanfare_start       },
    {BATTLE_VICTORY_STATE_RESULT,       victory_result_store        },
    {BATTLE_VICTORY_STATE_ANIME_START,  victory_animation	        },
};

#endif