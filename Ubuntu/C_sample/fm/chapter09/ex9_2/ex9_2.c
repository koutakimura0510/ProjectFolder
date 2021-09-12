#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n, m, t0;
  double *vco, gain, am, fm;
  
  pcm.fs = 44100; /* 標本化周波数 */
  pcm.bits = 16; /* 量子化精度 */
  pcm.length = pcm.fs * 2; /* 音データの長さ */
  pcm.s = calloc(pcm.length, sizeof(double)); /* 音データ */
  
  vco = calloc(pcm.length, sizeof(double));
  
  /* 時間エンベロープ */
  vco[0] = 500.0; /* Hz */
  am = 100.0; /* LFOの振幅 */
  fm = 2.0; /* LFOの周波数 */
  /* LFO */
  for (n = 0; n < pcm.length; n++)
  {
    vco[n] = vco[0] + am * sin(2.0 * M_PI * fm * n / pcm.fs);
  }
  
  /* ノコギリ波 */
  t0 = pcm.fs / vco[0]; /* 基本周期 */
  m = 0;
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = 1.0 - 2.0 * m / t0;
    
    m++;
    if (m >= t0)
    {
      t0 = pcm.fs / vco[n]; /* 基本周期 */
      m = 0;
    }
  }
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex9_2.wav");
  
  free(pcm.s);
  free(vco);
  
  return 0;
}
