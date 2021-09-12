#ifndef direct_build_funcptr_h   /* prevent circular inclusions */
#define direct_build_funcptr_h   /* by using protection macros */


/*
 * ラッパー構造体をインクルード
 */
#include "direct_build_struct.h"


/*
 * 構造体の要素数
 */
#define NEXTMAP_DIRECT_ID_DB_SIZE ((sizeof (nextmap_state))/(sizeof (NextmapState)))



/*
 * 
 * ver1. 2021/06/21
 * 現在キャラクターが存在しているマップIDのデータを取得する。
 * 指定されているIDはSubmapDirect構造体の行検索に使用する
 */
typedef struct nextmap_state
{
	uint32_t nextmap;
	uint32_t nextmap_direct_startid;
	uint32_t nextmap_direct_endid;
} NextmapState;

static const NextmapState nextmap_state[] =
{
	{ROMEN_VIRRAGE_ID, DIRECT_ROMEN_ID_START,	DIRECT_ROMEN_ID_END},
};

#endif
