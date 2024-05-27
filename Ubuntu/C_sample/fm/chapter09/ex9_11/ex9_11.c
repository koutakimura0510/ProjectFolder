#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "sinc.h"
#include "adsr.h"
#include "iir_filter.h"

int main(void)
{
  MONO_PCM pcm0, pcm1, pcm2, pcm3;
  int n, m, I, J, N, ta, tb, A, D, R, gate, duration;
  double vco, vcf, *vca, gain, t0, t, *s, S, Q, a[3], b[3];
  
  pcm0.fs = 44100; /* 標本化周波数 */
  pcm0.bits = 16; /* 量子化精度 */
  pcm0.length = pcm0.fs * 4; /* 音データの長さ */
  pcm0.s = calloc(pcm0.length, sizeof(double)); /* 音データ */
  
  s = calloc(pcm0.length, sizeof(double));
  
  vco = 440.0; /* 基本周波数 */
  
  /* パルス列 */
  t0 = pcm0.fs / vco; /* 基本周期 */
  t = 0.0;
  N = 128;
  while (t < pcm0.length)
  {
    ta = (int)t;
    
    if (t == ta)
    {
      tb = ta;
    }
    else
    {
      tb = ta + 1;
    }
    
    for (n = tb - N / 2; n <= ta + N / 2; n++)
    {
      if (n >= 0 && n < pcm0.length)
      {
        pcm0.s[n] += sinc(M_PI * (t - n)) * (0.5 + 0.5 * cos(2.0 * M_PI * (t - n) / (N * 2 + 1)));
      }
    }
    
    t += t0;
  }
  
  for (n = 0; n < pcm0.length; n++)
  {
    pcm0.s[n] -= 1.0 / t0;
  }
  
  /* 積分フィルタ */
  s[0] = pcm0.s[0] - 0.5;
  for (n = 1; n < pcm0.length; n++)
  {
    s[n] = pcm0.s[n] + 0.98 * s[n - 1];
  }
  
  for (n = 0; n < pcm0.length; n++)
  {
    pcm0.s[n] = s[n] * 2.0;
  }
  
  vcf = 4000.0; /* 遮断周波数 */
  Q = 1 / sqrt(2); /* レゾナンス */
  I = 2; /* 遅延器の数 */
  J = 2; /* 遅延器の数 */
  
  IIR_LPF(vcf / pcm0.fs, Q, a, b);  /* IIRフィルタの設計 */
  
  pcm1.fs = pcm0.fs; /* 標本化周波数 */
  pcm1.bits = pcm0.bits; /* 量子化精度 */
  pcm1.length = pcm0.length; /* 音データの長さ */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* 音データ */
  
  /* フィルタリング */
  for (n = 0; n < pcm1.length; n++)
  {
    for (m = 0; m <= J; m++)
    {
      if (n - m >= 0)
      {
        pcm1.s[n] += b[m] * pcm0.s[n - m];
      }
    }
    for (m = 1; m <= I; m++)
    {
      if (n - m >= 0)
      {
        pcm1.s[n] += -a[m] * pcm1.s[n - m];
      }
    }
  }
  
  vca = calloc(pcm1.length, sizeof(double)); /* 振幅 */
  gate = pcm1.fs * 3;
  duration = pcm1.fs * 4;
  A = pcm1.fs * 1;
  D = 0;
  S = 1.0;
  R = pcm1.fs * 1;
  ADSR(vca, A, D, S, R, gate, duration);
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] *= vca[n] * gain;
  }
  
  pcm2.fs = 44100; /* 標本化周波数 */
  pcm2.bits = 16; /* 量子化精度 */
  pcm2.length = pcm2.fs * 4; /* 音データの長さ */
  pcm2.s = calloc(pcm2.length, sizeof(double)); /* 音データ */
  
  vco = 440.5; /* 基本周波数 */
  
  /* パルス列 */
  t0 = pcm2.fs / vco; /* 基本周期 */
  t = 0.0;
  N = 128;
  while (t < pcm2.length)
  {
    ta = (int)t;
    
    if (t == ta)
    {
      tb = ta;
    }
    else
    {
      tb = ta + 1;
    }
    
    for (n = tb - N / 2; n <= ta + N / 2; n++)
    {
      if (n >= 0 && n < pcm2.length)
      {
        pcm2.s[n] += sinc(M_PI * (t - n)) * (0.5 + 0.5 * cos(2.0 * M_PI * (t - n) / (N * 2 + 1)));
      }
    }
    
    t += t0;
  }
  
  for (n = 0; n < pcm2.length; n++)
  {
    pcm2.s[n] -= 1.0 / t0;
  }
  
  /* 積分フィルタ */
  s[0] = pcm2.s[0] - 0.5;
  for (n = 1; n < pcm2.length; n++)
  {
    s[n] = pcm2.s[n] + 0.98 * s[n - 1];
  }
  
  for (n = 0; n < pcm2.length; n++)
  {
    pcm2.s[n] = s[n] * 2.0;
  }
  
  vcf = 4000.0; /* 遮断周波数 */
  Q = 1 / sqrt(2); /* レゾナンス */
  I = 2; /* 遅延器の数 */
  J = 2; /* 遅延器の数 */
  
  IIR_LPF(vcf / pcm2.fs, Q, a, b);  /* IIRフィルタの設計 */
  
  pcm3.fs = pcm2.fs; /* 標本化周波数 */
  pcm3.bits = pcm2.bits; /* 量子化精度 */
  pcm3.length = pcm2.length; /* 音データの長さ */
  pcm3.s = calloc(pcm3.length, sizeof(double)); /* 音データ */
  
  /* フィルタリング */
  for (n = 0; n < pcm3.length; n++)
  {
    for (m = 0; m <= J; m++)
    {
      if (n - m >= 0)
      {
        pcm3.s[n] += b[m] * pcm2.s[n - m];
      }
    }
    for (m = 1; m <= I; m++)
    {
      if (n - m >= 0)
      {
        pcm3.s[n] += -a[m] * pcm3.s[n - m];
      }
    }
  }
  
  vca = calloc(pcm3.length, sizeof(double)); /* 振幅 */
  gate = pcm3.fs * 3;
  duration = pcm3.fs * 4;
  A = pcm3.fs * 1;
  D = 0;
  S = 1.0;
  R = pcm3.fs * 1;
  ADSR(vca, A, D, S, R, gate, duration);
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm3.length; n++)
  {
    pcm3.s[n] *= vca[n] * gain;
  }
  
  /* デチューン */
  for (n = 0; n < pcm3.length; n++)
  {
    pcm1.s[n] += pcm3.s[n];
  }
  
  wave_write_16bit_mono(&pcm1, "ex9_11.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(pcm2.s);
  free(pcm3.s);
  free(vca);
  free(s);
  
  return 0;
}
