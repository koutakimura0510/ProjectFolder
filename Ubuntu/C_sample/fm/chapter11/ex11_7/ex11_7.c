#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  
  wave_read_16bit_mono(&pcm0, "vocal.wav"); /* 音データ（PCM）の入力 */
  
  wave_write_PCMU_mono(&pcm0, "pcmu.wav"); /* 音データ（PCMU）の出力 */
  
  wave_read_PCMU_mono(&pcm1, "pcmu.wav"); /* 音データ（PCMU）の入力 */
  
  wave_write_16bit_mono(&pcm1, "pcm.wav"); /* 音データ（PCM）の出力 */
  
  free(pcm0.s);
  free(pcm1.s);
  
  return 0;
}
