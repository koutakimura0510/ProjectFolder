#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm0, pcm1, pcm2;
  int n, m, J;
  
  wave_read_16bit_mono(&pcm0, "drum.wav");
  wave_read_16bit_mono(&pcm1, "response.wav");
  
  pcm2.fs = pcm0.fs; /* 標本化周波数 */
  pcm2.bits = pcm0.bits; /* 量子化精度 */
  pcm2.length = pcm0.length; /* 音データの長さ */
  pcm2.s = calloc(pcm2.length, sizeof(double)); /* 音データ */
  
  J = pcm1.fs * 1.0; /* 遅延器の数 */
  
  /* フィルタリング */
  for (n = 0; n < pcm2.length; n++)
  {
    for (m = 0; m <= J; m++)
    {
      if (n - m >= 0)
      {
        pcm2.s[n] += pcm1.s[m] * pcm0.s[n - m];
      }
    }
  }
  
  wave_write_16bit_mono(&pcm2, "ex6_5.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(pcm2.s);
  
  return 0;
}
