/**-----------------------------------------------------------------------------
 * Create  2023/08/06
 * Author  kouta kimura
 * -
 *-----------------------------------------------------------------------------*/
#include "../include/system_wrapper.h"

#define SIN_ANGLE			(2764.601535)
#define SIN_OFFSET			(32768.0)
// #define SIN_WAVE			(440.0)
#define SIN_SAMPLING_RATE	(48000.0)

/**-----------------------------------------------------------------------------
 * External RAM Sin Wave Write
 *-----------------------------------------------------------------------------*/
void synth_sinwave_write(void)
{
	for (uint32_t i = 0; i < 48000; i++) {
		double d = (SIN_ANGLE * (double)i) / SIN_SAMPLING_RATE;
		int32_t sin_wave = sin(d) * SIN_OFFSET + SIN_OFFSET;

		if (65535 < sin_wave) {
			sin_wave = 65535;
		}

		if (sin_wave < 1) {
			sin_wave = 0;
		}

		cache_write(sin_wave, i);
		cache_flush();
		while(!(true == cache_burst_bool()));

		// if (sin_wave != cache_read(i)) {
		// 	return;
		// }
	}

	// double angle = 2764.601535;
	// double offset = 32768.0;
	// double wave = 440.0;
	// double sampling_rate = 48000.0;

	// for (uint32_t i = 0; i < 65535; i++) {
	// 	double d = (angle * (double)i) / sampling_rate;
	// 	double sin_wave = sin(d) * offset + offset;
	// 	cache_write((uint16_t)sin_wave, i);

	// 	if ((i & 0xff) == 255) {
	// 		cache_flush();
	// 		while(!(true == cache_burst_bool()));
	// 	}
	// }
}