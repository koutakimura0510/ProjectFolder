/*
 * メッセージ処理操作ファイル
 */

#include "../wrapper/game_wrapper.h"
#include <stdio.h>


/*
 * エラー処理関数
 */
void msg_fprintf(const char *msg, const char *filename, const char *func, int line)
{
	fprintf(stderr, "\n");
	fprintf(stderr, "--------------------\n");
	fprintf(stderr, "[Msg]  = %s\n", msg);
	fprintf(stderr, "[File] = %s\n", filename);
	fprintf(stderr, "[Line] = %d\n", line);
	fprintf(stderr, "[func] = %s\n", func);
	fprintf(stderr, "--------------------\n");
	fprintf(stderr, "\n");
}
