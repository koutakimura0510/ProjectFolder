#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "adsr.h"
#include "iir_filter.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, m, t0, I, J, A, D, R, gate, duration;
  double vco, *vcf, *vca, gain, offset, depth, S, Q, a[3], b[3];
  
  pcm0.fs = 44100; /* 標本化周波数 */
  pcm0.bits = 16; /* 量子化精度 */
  pcm0.length = pcm0.fs * 4; /* 音データの長さ */
  pcm0.s = calloc(pcm0.length, sizeof(double)); /* 音データ */
  
  vco = 440.0; /* 基本周波数 */
  
  /* ノコギリ波 */
  t0 = pcm0.fs / vco; /* 基本周期 */
  m = 0;
  for (n = 0; n < pcm0.length; n++)
  {
    pcm0.s[n] = 1.0 - 2.0 * m / t0;
    
    m++;
    if (m >= t0)
    {
      m = 0;
    }
  }
  
  vcf = calloc(pcm0.length, sizeof(double));  /* 遮断周波数 */
  gate = pcm0.fs * 1;
  duration = pcm0.fs * 4;
  A = 0;
  D = pcm0.fs * 1;
  S = 0.0;
  R = pcm0.fs * 1;
  ADSR(vcf, A, D, S, R, gate, duration);
  
  offset = 500.0; /* 時間エンベロープのオフセット */
  depth = 500.0; /* 時間エンベロープのデプス */
  for (n = 0; n < pcm0.length; n++)
  {
    vcf[n] = offset + vcf[n] * depth;
  }
  
  Q = 1 / sqrt(2); /* レゾナンス */
  I = 2; /* 遅延器の数 */
  J = 2; /* 遅延器の数 */
  
  pcm1.fs = pcm0.fs; /* 標本化周波数 */
  pcm1.bits = pcm0.bits; /* 量子化精度 */
  pcm1.length = pcm0.length; /* 音データの長さ */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* 音データ */
  
  /* フィルタリング */
  for (n = 0; n < pcm1.length; n++)
  {
    IIR_LPF(vcf[n] / pcm1.fs, Q, a, b); /* IIRフィルタの設計 */
    
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
  gate = pcm0.fs * 4;
  duration = pcm0.fs * 4;
  A = 0;
  D = pcm0.fs * 4;
  S = 0.0;
  R = pcm0.fs * 1;
  ADSR(vca, A, D, S, R, gate, duration);
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] *= vca[n] * gain;
  }
  
  /* フェード処理 */
  for (n = 0; n < pcm1.fs * 0.01; n++)
  {
    pcm1.s[n] *= (double)n / (pcm1.fs * 0.01);
    pcm1.s[pcm1.length - n - 1] *= (double)n / (pcm1.fs * 0.01);
  }
  
  wave_write_16bit_mono(&pcm1, "ex9_6.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(vcf);
  free(vca);
  
  return 0;
}
