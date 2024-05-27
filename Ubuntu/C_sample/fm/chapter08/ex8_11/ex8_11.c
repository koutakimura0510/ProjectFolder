#include <stdio.h>
#include <stdlib.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, m, t0, ratio;
  double *f0, gain;
  
  pcm0.fs = 192000; /* 標本化周波数 */
  pcm0.bits = 16; /* 量子化精度 */
  pcm0.length = pcm0.fs * 2; /* 音データの長さ */
  pcm0.s = calloc(pcm0.length, sizeof(double)); /* 音データ */
  
  f0 = calloc(pcm0.length, sizeof(double));
  
  /* 基本周波数 */
  f0[0] = 500.0;
  f0[pcm0.length - 1] = 3500.0;
  for (n = 0; n < pcm0.length; n++)
  {
    f0[n] = f0[0] + (f0[pcm0.length - 1] - f0[0]) * n / (pcm0.length - 1);
  }
  
  /* ノコギリ波 */
  t0 = pcm0.fs / f0[0]; /* 基本周期 */
  m = 0;
  for (n = 0; n < pcm0.length; n++)
  {
    pcm0.s[n] = 1.0 - 2.0 * m / t0;
    
    m++;
    if (m >= t0)
    {
      t0 = pcm0.fs / f0[n]; /* 基本周期 */
      m = 0;
    }
  }
  
  pcm1.fs = 8000; /* 標本化周波数 */
  pcm1.bits = 16; /* 量子化精度 */
  pcm1.length = pcm1.fs * 2; /* 音データの長さ */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* 音データ */
  
  ratio = pcm0.fs / pcm1.fs; /* ダウンサンプリングのレシオ */
  
  /* データを間引く */
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] = pcm0.s[n * ratio];
  }
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm1, "ex8_11.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(f0);
  
  return 0;
}
