/**-----------------------------------------------------------------------------
 * Create  2023/08/06
 * Author  kouta kimura
 * -
 *-----------------------------------------------------------------------------*/
#include "../include/system_wrapper.h"

#define SIN_OFFSET			(32767.0)
#define SIN_BASE_HZ			(1.0)
#define SIN_SAMPLING_RATE	(44100.0)
// #define SIN_ANGLE			(2764.601535)
// #define SIN_ANGLE			(2.0 * 3.141592654 * SIN_BASE_HZ)
#define SIN_ANGLE			(6.283185307)

/**-----------------------------------------------------------------------------
 * External RAM Sin Wave Write
 *-----------------------------------------------------------------------------*/
void synth_sinwave_write(void)
{
	for (uint32_t i = 0; i < 44100; i++) {
		double d = (SIN_ANGLE * (double)i) / SIN_SAMPLING_RATE;
		uint16_t sin_wave = sin(d) * SIN_OFFSET + SIN_OFFSET;

		cache_write(sin_wave, i);
		while(!(true == cache_burst_bool()));
	}
}
