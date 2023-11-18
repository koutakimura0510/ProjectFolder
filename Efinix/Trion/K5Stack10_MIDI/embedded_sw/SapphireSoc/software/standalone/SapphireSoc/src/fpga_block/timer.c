/**-----------------------------------------------------------------------------
 * Create  2023/10/15
 * Author  kouta kimura
 * -
 * Video Tx Block function
 *-----------------------------------------------------------------------------*/
#include "../include/system_wrapper.h"

/**-----------------------------------------------------------------------------
 * *tmr 時間格納変数のアドレス
 * duration 経過時間の指定
 *-----------------------------------------------------------------------------*/
bool timer_wait(uint32_t *tmr, uint32_t duration, uint32_t adrs)
{
	uint32_t now_t = usi_read_cmd(adrs);

	if (*tmr + duration < now_t) {
		*tmr = now_t;
		return true;
	}

	return false;
}
