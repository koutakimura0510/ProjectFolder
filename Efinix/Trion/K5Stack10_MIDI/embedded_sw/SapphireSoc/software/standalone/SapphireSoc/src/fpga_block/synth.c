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
		int16_t sin_wave = sin(d) * SIN_OFFSET + SIN_OFFSET;

		cache_write(sin_wave, i);
		while(!(true == cache_burst_bool()));
	}
}

/**-----------------------------------------------------------------------------
 * Audio Amp Settings
 *-----------------------------------------------------------------------------*/
void synth_audio_amp(void)
{
	uint32_t note_number;
	uint32_t audio_amp;

	note_number = usi_read_cmd(SYNTH_REG_ON_NOTE_NUMBER);

	for (uint8_t i = 0; i < 4; i++) {
		switch (note_number & 0xff)
		{
		case /* constant-expression */:
			/* code */
			break;
		
		default:
			break;
		}

		note_number = note_number >> 8;
	}

	usi_write_cmd(audio_amp, SYNTH_REG_AUDIO_AMP_CH4321);
}