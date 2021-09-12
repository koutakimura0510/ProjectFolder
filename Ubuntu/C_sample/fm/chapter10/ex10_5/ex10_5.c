#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "adsr.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, A, D, R, gate, duration;
  double *ac, fc, *am, fm, ratio, gain, S;
  
  pcm0.fs = 44100; /* 標本化周波数 */
  pcm0.bits = 16; /* 量子化精度 */
  pcm0.length = pcm0.fs * 4; /* 音データの長さ */
  pcm0.s = calloc(pcm0.length, sizeof(double)); /* 音データ */
  
  pcm1.fs = pcm0.fs; /* 標本化周波数 */
  pcm1.bits = pcm0.bits; /* 量子化精度 */
  pcm1.length = pcm0.length; /* 音データの長さ */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* 音データ */
  
  ac = calloc(pcm0.length, sizeof(double));
  am = calloc(pcm0.length, sizeof(double));
  
  /* キャリア振幅 */
  gate = pcm0.fs * 4;
  duration = pcm0.fs * 4;
  A = 0;
  D = pcm0.fs * 4;
  S = 0.0;
  R = pcm0.fs * 1;
  ADSR(ac, A, D, S, R, gate, duration);
  
  fc = 440.0; /* キャリア周波数 */
  
  /* モジュレータ振幅 */
  gate = pcm0.fs * 4;
  duration = pcm0.fs * 4;
  A = 0;
  D = pcm0.fs * 2;
  S = 0.0;
  R = pcm0.fs * 2;
  ADSR(am, A, D, S, R, gate, duration);
  
  ratio = 1.0;
  fm = 440.0 * ratio; /* モジュレータ周波数 */
  
  /* FM音源 */
  for (n = 0; n < pcm0.length; n++)
  {
    pcm0.s[n] = ac[n] * sin(2.0 * M_PI * fc * n / pcm0.fs
              + am[n] * sin(2.0 * M_PI * fm * n / pcm0.fs));
  }
  
  /* キャリア振幅 */
  gate = pcm1.fs * 4;
  duration = pcm1.fs * 4;
  A = 0;
  D = pcm1.fs * 1;
  S = 0.0;
  R = pcm1.fs * 1;
  ADSR(ac, A, D, S, R, gate, duration);
  
  fc = 440.0; /* キャリア周波数 */
  
  /* モジュレータ振幅 */
  gate = pcm1.fs * 4;
  duration = pcm1.fs * 4;
  A = 0;
  D = pcm1.fs * 1;
  S = 0.0;
  R = pcm1.fs * 1;
  ADSR(am, A, D, S, R, gate, duration);
  
  ratio = 14.0;
  fm = fc * ratio; /* モジュレータ周波数 */
  
  /* FM音源 */
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] = ac[n] * sin(2.0 * M_PI * fc * n / pcm1.fs
              + am[n] * sin(2.0 * M_PI * fm * n / pcm1.fs));
  }
  
  gain = 0.1; /* ゲイン */
  
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] += pcm0.s[n];
    pcm1.s[n] *= gain;
  }
  
  wave_write_16bit_mono(&pcm1, "ex10_5.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(ac);
  free(am);
  
  return 0;
}
