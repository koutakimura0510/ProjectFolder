#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n, m, t0, pe;
  double *f0, *e, gain;
  
  pcm.fs = 44100; /* 標本化周波数 */
  pcm.bits = 16; /* 量子化精度 */
  pcm.length = pcm.fs * 0.6; /* 音データの長さ */
  pcm.s = calloc(pcm.length, sizeof(double)); /* 音データ */
  
  f0 = calloc(pcm.length, sizeof(double));
  
  /* 基本周波数 */
  for (n = 0; n < pcm.fs * 0.1; n++)
  {
    f0[n] = 987.77; /* B5 */
  }
  for (n = pcm.fs * 0.1; n < pcm.length; n++)
  {
    f0[n] = 1318.51; /* E6 */
  }
  
  /* 矩形波 */
  t0 = pcm.fs / f0[0]; /* 矩形波の基本周期 */
  m = 0;
  for (n = 0; n < pcm.length; n++)
  {
    if (m < t0 / 2.0)
    {
      pcm.s[n] = 1.0;
    }
    else
    {
      pcm.s[n] = -1.0;
    }
    
    m++;
    if (m >= t0)
    {
      t0 = pcm.fs /f0[n]; /* 矩形波の基本周期 */
      m = 0;
    }
  }
  
  e = calloc(pcm.length, sizeof(double));
  
  pe = pcm.length; /* 単調減少にかかる時間 */
  
  /* 時間エンベロープ */
  for(n = 0; n < pcm.length; n++)
  {
    e[n] = 1.0 - (double)n / pe;
  }
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= e[n] * gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex8_7.wav");
  
  free(pcm.s);
  free(f0);
  free(e);
  
  return 0;
}
