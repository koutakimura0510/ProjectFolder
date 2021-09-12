#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n, m, t0;
  double *f0, gain;
  
  pcm.fs = 8000; /* 標本化周波数 */
  pcm.bits = 16; /* 量子化精度 */
  pcm.length = pcm.fs * 2; /* 音データの長さ */
  pcm.s = calloc(pcm.length, sizeof(double)); /* 音データ */
  
  f0 = calloc(pcm.length, sizeof(double));
  
  /* 基本周波数 */
  f0[0] = 500.0;
  f0[pcm.length - 1] = 3500.0;
  for (n = 0; n < pcm.length; n++)
  {
    f0[n] = f0[0] + (f0[pcm.length - 1] - f0[0]) * n / (pcm.length - 1);
  }
  
  /* ノコギリ波 */
  t0 = pcm.fs / f0[0]; /* 基本周期 */
  m = 0;
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = 1.0 - 2.0 * m / t0;
    
    m++;
    if (m >= t0)
    {
      t0 = pcm.fs / f0[n]; /* 基本周期 */
      m = 0;
    }
  }
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex8_9.wav");
  
  free(pcm.s);
  free(f0);
  
  return 0;
}
