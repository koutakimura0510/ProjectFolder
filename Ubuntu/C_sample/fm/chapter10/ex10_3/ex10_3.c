#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"

int main(void)
{
  MONO_PCM pcm;
  int n;
  double ac, fc, am, fm, ratio, gain;
  
  pcm.fs = 44100; /* 標本化周波数 */
  pcm.bits = 16; /* 量子化精度 */
  pcm.length = pcm.fs * 1; /* 音データの長さ */
  pcm.s = calloc(pcm.length, sizeof(double)); /* 音データ */
  
  ac = 1.0; /* キャリア振幅 */
  fc = 500.0; /* キャリア周波数 */
  
  am = 1.0; /* モジュレータ振幅 */
  ratio = 3.5; /* 周波数比 */
  fm = fc * ratio; /* モジュレータ周波数 */
  
  /* FM音源 */
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = ac * sin(2.0 * M_PI * fc * n / pcm.fs
             + am * sin(2.0 * M_PI * fm * n / pcm.fs));
  }
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex10_3.wav");
  
  free(pcm.s);
  
  return 0;
}
