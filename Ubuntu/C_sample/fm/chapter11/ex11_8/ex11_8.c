#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  
  wave_read_16bit_mono(&pcm0, "vocal.wav"); /* 音データ（PCM）の入力 */
  
  wave_write_PCMA_mono(&pcm0, "pcma.wav"); /* 音データ（PCMA）の出力 */
  
  wave_read_PCMA_mono(&pcm1, "pcma.wav"); /* 音データ（PCMA）の入力 */
  
  wave_write_16bit_mono(&pcm1, "pcm.wav"); /* 音データ（PCM）の出力 */
  
  free(pcm0.s);
  free(pcm1.s);
  
  return 0;
}
