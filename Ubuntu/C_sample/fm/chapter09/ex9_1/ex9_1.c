#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n, m, t0;
  double vco, *vca, gain, am, fm;
  
  pcm.fs = 44100; /* 標本化周波数 */
  pcm.bits = 16; /* 量子化精度 */
  pcm.length = pcm.fs * 2; /* 音データの長さ */
  pcm.s = calloc(pcm.length, sizeof(double)); /* 音データ */
  
  vco = 500.0; /* 基本周波数 */
  
  /* ノコギリ波 */
  t0 = pcm.fs / vco; /* 基本周期 */
  m = 0;
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = 1.0 - 2.0 * m / t0;
    
    m++;
    if (m >= t0)
    {
      m = 0;
    }
  }
  
  vca = calloc(pcm.length, sizeof(double));
  
  /* 時間エンベロープ */
  vca[0] = 1.0;
  am = 0.2; /* LFOの振幅 */
  fm = 2.0; /* LFOの周波数 */
  /* LFO */
  for (n = 0; n < pcm.length; n++)
  {
    vca[n] = vca[0] + am * sin(2.0 * M_PI * fm * n / pcm.fs);
  }
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= vca[n] * gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex9_1.wav");
  
  free(pcm.s);
  free(vca);
  
  return 0;
}
