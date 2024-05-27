#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "window_function.h"
#include "sinc.h"
#include "fir_filter.h"

int main(void)
{
  MONO_PCM pcm0, pcm1, pcm2, pcm3;
  int n, m, t0, J, ratio;
  double *f0, gain, fe, delta, *b, *w;
  
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
  
  fe = 0.45 / ratio; /* エッジ周波数 */
  delta = 0.1 / ratio; /* 遷移帯域幅 */
  
  J = (int)(3.1 / delta + 0.5) - 1; /* 遅延器の数 */
  if (J % 2 == 1)
  {
    J++; /* J+1が奇数になるように調整する */
  }
  
  b = calloc((J + 1), sizeof(double));
  w = calloc((J + 1), sizeof(double));
  
  Hanning_window(w, (J + 1)); /* ハニング窓 */
  
  FIR_LPF(fe, J, b, w); /* FIRフィルタの設計 */
  
  /* フィルタリング */
  for (n = 0; n < pcm1.length; n++)
  {
    for (m = 0; m <= J; m++)
    {
      if (n * ratio + J / 2 - m >= 0 && n * ratio + J / 2 - m < pcm0.length )
      {
        pcm1.s[n] += b[m] * pcm0.s[n * ratio + J / 2 - m];
      }
    }
  }
  
  pcm2.fs = 192000; /* 標本化周波数 */
  pcm2.bits = 16; /* 量子化精度 */
  pcm2.length = pcm2.fs * 2; /* 音データの長さ */
  pcm2.s = calloc(pcm2.length, sizeof(double)); /* 音データ */
  
  /* 0を挿入する */
  for (n = 0; n < pcm1.length; n++)
  {
    pcm2.s[n * ratio] = pcm1.s[n];
  }
  
  pcm3.fs = 192000; /* 標本化周波数 */
  pcm3.bits = 16; /* 量子化精度 */
  pcm3.length = pcm3.fs * 2; /* 音データの長さ */
  pcm3.s = calloc(pcm3.length, sizeof(double)); /* 音データ */
  
  /* フィルタリング */
  for (n = 0; n < pcm3.length; n++)
  {
    for (m = 0; m <= J; m++)
    {
      if (n + J / 2 - m >= 0 && n + J / 2 - m < pcm2.length )
      {
        pcm3.s[n] += b[m] * pcm2.s[n + J / 2 - m];
      }
    }
  }
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm3.length; n++)
  {
    pcm3.s[n] *= ratio * gain;
  }
  
  wave_write_16bit_mono(&pcm3, "ex8_12.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(pcm2.s);
  free(pcm3.s);
  free(f0);
  free(b);
  free(w);
  
  return 0;
}
