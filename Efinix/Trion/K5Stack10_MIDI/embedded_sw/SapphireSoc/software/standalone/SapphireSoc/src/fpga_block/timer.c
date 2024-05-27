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

/**----------------------------------------------------------------------------
 * 1ms wait 関数
 * time 待機時間
 *---------------------------------------------------------------------------*/
void wait_ms(uint32_t time)
{
	uint32_t tmr = usi_read_cmd(TIMER_REG_COUNT2);

	while (1) {
		if (true == timer_wait(&tmr, time, TIMER_REG_COUNT2)) {
			break;
		}
	}
}