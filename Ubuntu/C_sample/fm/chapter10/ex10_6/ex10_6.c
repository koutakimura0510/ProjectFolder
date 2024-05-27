#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "adsr.h"

int main(void)
{
  MONO_PCM pcm;
  int n, A, D, R, gate, duration;
  double *ac, fc, *am, fm, ratio, gain, S;
  
  pcm.fs = 44100; /* 標本化周波数 */
  pcm.bits = 16; /* 量子化精度 */
  pcm.length = pcm.fs * 4; /* 音データの長さ */
  pcm.s = calloc(pcm.length, sizeof(double)); /* 音データ */
  
  ac = calloc(pcm.length, sizeof(double));
  am = calloc(pcm.length, sizeof(double));
  
  /* キャリア振幅 */
  gate = pcm.fs * 4;
  duration = pcm.fs * 4;
  A = 0;
  D = pcm.fs * 4;
  S = 0.0;
  R = pcm.fs * 4;
  ADSR(ac, A, D, S, R, gate, duration);
  
  fc = 440.0; /* キャリア周波数 */
  
  /* モジュレータ振幅 */
  gate = pcm.fs * 4;
  duration = pcm.fs * 4;
  A = 0;
  D = pcm.fs * 2;
  S = 0.0;
  R = pcm.fs * 2;
  ADSR(am, A, D, S, R, gate, duration);
  
  ratio = 3.5;
  fm = fc * ratio; /* モジュレータ周波数 */
  
  /* AM変調 */
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] = ac[n] * sin(2.0 * M_PI * fc * n / pcm.fs)
             * (1.0 + am[n] * sin(2.0 * M_PI * fm * n / pcm.fs));
  }
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm.length; n++)
  {
    pcm.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm, "ex10_6.wav");
  
  free(pcm.s);
  free(ac);
  free(am);
  
  return 0;
}
