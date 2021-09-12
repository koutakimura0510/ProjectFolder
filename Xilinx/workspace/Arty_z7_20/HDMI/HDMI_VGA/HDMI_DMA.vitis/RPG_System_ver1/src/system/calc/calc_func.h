#ifndef calc_func_h   /* prevent circular inclusions */
#define calc_func_h   /* by using protection macros */

#include "calc.h"

bool isCompareTo(uint32_t num1, uint32_t num2);
uint32_t digit_count(uint32_t number);
uint32_t bit_count(uint32_t bits);
bool isEscape(void);
uint32_t xorshift(uint32_t seed);
uint32_t get_rand(uint32_t seed);
uint8_t get_percent(uint8_t seed);

#endif
