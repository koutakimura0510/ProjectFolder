#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "iir_filter.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, m, I, J;
  double *fc, Q, a[3], b[3];
  
  wave_read_16bit_mono(&pcm0, "pulse_train.wav");
  
  fc = calloc(pcm0.length, sizeof(double));
  
  /* LPFの遮断周波数 */
  for (n = 0; n < pcm0.length; n++)
  {
    fc[n] = 10000.0 * exp(-5.0 * n / pcm0.length);
  }
  
  Q = 1.0 / sqrt(2); /* クオリティファクタ */
  I = 2; /* 遅延器の数 */
  J = 2; /* 遅延器の数 */
  
  pcm1.fs = pcm0.fs; /* 標本化周波数 */
  pcm1.bits = pcm0.bits; /* 量子化精度 */
  pcm1.length = pcm0.length; /* 音データの長さ */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* 音データ */
  
  for (n = 0; n < pcm1.length; n++)
  {
    IIR_LPF(fc[n] / pcm1.fs, Q, a, b); /* IIRフィルタの設計 */
    
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
  
  wave_write_16bit_mono(&pcm1, "ex7_1.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(fc);
  
  return 0;
}
