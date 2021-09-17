/*
 * Create 2021/07/06
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * -
 * シンボリックファイルのヘッダーをインクルード
 */

#ifndef MyLIB_h   /* prevent circular inclusions */
#define MyLIB_h   /* by using protection macros */

#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))

/* ファイル操作用にインクルード */
#include <stdio.h>
#include <stdint.h>

/* システムのインクルード */
#include "../../../../../Xilinx/workspace/Arty_z7_20/HDMI/HDMI_VGA/HDMI_DMA.vitis/RPG_System_ver1/src/system/wrapper/game_wrapper.h"
#include "toho_macro.h/macro_wrapper.h"
#include "rom_db_struct.h"


/* 容量確認用にシステム構造体をインスタンス */
GameWrapper game_wrapper;


/* 文字列カウント用関数 */
uint32_t sjis_write(FILE *fp, const char *msg);
uint32_t sjis_length(const char *msg);

void error_print(uint32_t a, uint32_t b)
{
	if (a != b)
	{
		printf(" --- ERROR --- === ");
	}
}

/* データベースのインクルード */
#include "system_db.h"
#include "item_db.h"
#include "event_db.h"
#include "minigame_db.h"
#include "effect_db.h"
#include "level_db.h"
#include "enemy_db.h"
#include "encount_db.h"
#include "animation.h"
#include "status_db.h"
#include "element_db.h"
#include "dtm_db.h"
#include "cooking_db.h"
#include "npc_db.h"
#include "sin_cos.h"
#include "event_variable_msg_db.h"
// #include "sound_db.h"
// #include "bitmap_db.h"



/* 関数ポインタデータベースの参照 */
#define FUNC_FILE_SIZE  ((sizeof (funcfile))/(sizeof (FuncFile)))

typedef struct
{
	const char *path;
	void (*file_func)(FILE *fp, FILE *byte);
} FuncFile;

#endif
