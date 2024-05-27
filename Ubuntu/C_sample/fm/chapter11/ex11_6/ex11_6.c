#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "sinc.h"

int main(void)
{
  MONO_PCM pcm0, pcm1, pcm2;
  int n, m, template_size, pmin, pmax, p, q, offset0, offset1, N, ta, tb;
  double rate, rmax, t, pitch, *x, *y, *r;
  
  wave_read_16bit_mono(&pcm0, "vocal.wav");
  
  rate = 0.5; /* 0.5 <= rate < 1.0 */
  
  pcm1.fs = pcm0.fs; /* 標本化周波数 */
  pcm1.bits = pcm0.bits; /* 量子化精度 */
  pcm1.length = (int)(pcm0.length / rate) + 1; /* 音データの長さ */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* 音データ */
  
  template_size = (int)(pcm1.fs * 0.01); /* 相関関数のサイズ */
  pmin = (int)(pcm1.fs * 0.005); /* ピークの探索範囲の下限 */
  pmax = (int)(pcm1.fs * 0.02); /* ピークの探索範囲の上限 */
  
  x = calloc(template_size, sizeof(double));
  y = calloc(template_size, sizeof(double));
  r = calloc((pmax + 1), sizeof(double));
  
  offset0 = 0;
  offset1 = 0;
  
  while (offset0 + pmax * 2 < pcm0.length)
  {
    for (n = 0; n < template_size; n++)
    {
      x[n] = pcm0.s[offset0 + n]; /* 本来の音データ */
    }
    
    rmax = 0.0;
    p = pmin;
    for (m = pmin; m <= pmax; m++)
    {
      for (n = 0; n < template_size; n++)
      {
        y[n] = pcm0.s[offset0 + m + n]; /* mサンプルずらした音データ */
      }
      r[m] = 0.0;
      for (n = 0; n < template_size; n++)
      {
        r[m] += x[n] * y[n]; /* 相関関数 */
      }
      if (r[m] > rmax)
      {
        rmax = r[m]; /* 相関関数のピーク */
        p = m; /* 波形の周期 */
      }
    }
    
    for (n = 0; n < p; n++)
    {
      pcm1.s[offset1 + n] = pcm0.s[offset0 + n];
    }
    for (n = 0; n < p; n++)
    {
      pcm1.s[offset1 + p + n] = pcm0.s[offset0 + p + n] * (p - n) / p; /* 単調減少の重み付け */
      pcm1.s[offset1 + p + n] += pcm0.s[offset0 + n] * n / p; /* 単調増加の重み付け */
    }
    
    q = (int)(p * rate / (1.0 - rate) + 0.5);
    for (n = p; n < q; n++)
    {
      if (offset0 + n >= pcm0.length)
      {
        break;
      }
      pcm1.s[offset1 + p + n] = pcm0.s[offset0 + n];
    }
    
    offset0 += q; /* offset0の更新 */
    offset1 += p + q; /* offset1の更新 */
  }
  
  pitch = 1.0 / rate;
  
  pcm2.fs = pcm0.fs; /* 標本化周波数 */
  pcm2.bits = pcm0.bits; /* 量子化精度 */
  pcm2.length = pcm0.length; /* 音データの長さ */
  pcm2.s = calloc(pcm2.length, sizeof(double)); /* 音データ */
  
  N = 128;
  
  for (n = 0; n < pcm2.length; n++)
  {
    t = pitch * n;
    
    ta = (int)t;
    
    if (t == ta)
    {
      tb = ta;
    }
    else
    {
      tb = ta + 1;
    }
    
    for (m = tb - N / 2; m <= ta + N / 2; m++)
    {
      if (m >= 0 && m < pcm1.length)
      {
        pcm2.s[n] += pcm1.s[m] * sinc(M_PI * (t - m)) * (0.5 + 0.5 * cos(2.0 * M_PI * (t - m) / (N * 2 + 1)));
      }
    }
  }
  
  wave_write_16bit_mono(&pcm2, "ex11_6.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(pcm2.s);
  free(x);
  free(y);
  free(r);
  
  return 0;
}
