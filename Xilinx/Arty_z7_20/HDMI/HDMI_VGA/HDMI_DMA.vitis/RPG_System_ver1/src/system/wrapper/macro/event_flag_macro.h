/**
 * Create 2021/09/20
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * @brief イベントのフラグについて管理するヘッダーファイル
 * @note フラグ処理にはit演算を使用し、見やすくするためにenumで定義する
 */
#ifndef event_flag_macro_h   /* prevent circular inclusions */
#define event_flag_macro_h   /* by using protection macros */

/**
 * @brief  ロメン村に関するフラグを管理
 * @note   
 * @retval None
 */
typedef enum romen_flag_bit
{
    ROMEN_KANBAN_READ = 1,
    ROMEN_BOSS_DYE = 2,
} Romen_Flag_Bit;

#endif