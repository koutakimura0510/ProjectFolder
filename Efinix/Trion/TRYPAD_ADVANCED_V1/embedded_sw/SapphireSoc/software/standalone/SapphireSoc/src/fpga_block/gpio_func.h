/**-----------------------------------------------------------------------------
 * Create  2023/07/29
 * Author  kouta kimura
 * -
 * グローバル関数プロトタイプ宣言
 * 
 *-----------------------------------------------------------------------------*/

#ifndef gpio_func_h
#define gpio_func_h

void led_auto_flash(uint32_t time, uint32_t timer_csr_adrs);
void led_user_flash(uint8_t flash);

#endif