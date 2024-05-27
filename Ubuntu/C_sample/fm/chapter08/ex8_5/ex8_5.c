#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n, m, te;
  double *e, gain;
  
  pcm.fs = 44100; /* 標本化周波数 */
  pcm.bits = 16; /* 量子化精度 */
  pcm.length = pcm.fs * 8; /* 音データの長さ */
  pcm.s = calloc(pcm.length, sizeof(double)); /* 音データ */
  
  /* 白色雑音 */
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = (double)rand() / RAND_MAX * 2.0 - 1.0;
  }
  
  e = calloc(pcm.length, sizeof(double));
  
  te = pcm.fs * 2; /* 単調増加または単調減少にかかる時間 */
  
  /* 時間エンベロープ */
  m = 0;
  for (n = 0; n < pcm.length; n++)
  {
    if (m < te)
    {
      e[n] = (double)m / te;
    }
    else
    {
      e[n] = 1.0 - ((double)m - te) / te;
    }
    
    m++;
    if (m >= te * 2)
    {
      m = 0;
    }
  }
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= e[n] * gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex8_5.wav");
  
  free(pcm.s);
  free(e);
  
  return 0;
}
