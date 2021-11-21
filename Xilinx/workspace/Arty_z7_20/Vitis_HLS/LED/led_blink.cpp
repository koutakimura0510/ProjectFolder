#include "ap_int.h"

void led_blink(volatile ap_uint<1> *onoff, ap_uint<4> *led)
{
	*led = onoff[0];
}
