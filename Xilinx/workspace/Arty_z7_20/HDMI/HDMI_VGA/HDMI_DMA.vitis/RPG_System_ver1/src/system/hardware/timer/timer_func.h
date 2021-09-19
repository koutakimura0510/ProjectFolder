#ifndef timer_func_h   /* prevent circular inclusions */
#define timer_func_h   /* by using protection macros */

#include "timer_macro.h"

bool timer_init(void);
uint8_t get_key(bool longkey);
uint8_t get_demo_key(bool longkey);
bool tmr_constant(uint32_t *com_timer, uint32_t progress_timer);
uint32_t get_time(void);
void wait_time(uint32_t time);

#endif