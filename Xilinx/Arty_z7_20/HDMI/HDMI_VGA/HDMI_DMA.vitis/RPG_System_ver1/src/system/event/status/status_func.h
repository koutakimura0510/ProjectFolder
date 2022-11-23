/*
 * Create 2021/08/06
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * IC      XC7Z020-1CLG400C
 * ROM     256KB
 * RAM     512KB
 * L1Cache 32KB
 * -
 * ステータス関連の処理をまとめたヘッダーファイル
 */
#ifndef status_func_h   /* prevent circular inclusions */
#define status_func_h   /* by using protection macros */


/*
 * ver1. 2021/08/07
 * ステータス操作時のループ回数を保存
 * 
 * index_loop   隊列参照用のループ回数
 * sort_pos     コマンド確定時のインデックスポジション
 */
typedef struct
{
    uint8_t index_loop;
    uint8_t sort_pos;
    uint8_t element;
    uint8_t type;
    uint8_t anime_id;
    uint8_t range;
} StatusRef;

/* 外部フォルダ参照用関数 */
void hero_damege_cure(GameWrapper *const game, uint8_t hero_id, int32_t heal_result);
void hero_alive_cure(GameWrapper *const game, uint8_t hero_id, int32_t odd_hp);
void hero_sp_cure(GameWrapper *const game, uint8_t hero_id, int32_t sp);
void equip_ref_update(GameWrapper *const game, uint8_t hero_id);
void status_conf_update(GameWrapper *const game, StatusRef *const ref);
void status_ref_update(GameWrapper *const game, StatusRef *const ref, uint8_t memory_id, uint8_t effect_id);
void item_status_update(GameWrapper *const game);

#endif
