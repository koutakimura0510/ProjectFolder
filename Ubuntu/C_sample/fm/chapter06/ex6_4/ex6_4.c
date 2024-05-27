#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "wave.h"
#include "window_function.h"
#include "fft.h"

int main(void)
{
  MONO_PCM pcm0, pcm1;
  int n, k, N, offset, frame, number_of_frame;
  double *x_real, *x_imag, *y_real, *y_imag, *b_real, *b_imag;
  double fe, *w;
  
  wave_read_16bit_mono(&pcm0, "sine_500hz_3500hz.wav");
  
  pcm1.fs = pcm0.fs; /* 標本化周波数 */
  pcm1.bits = pcm0.bits; /* 量子化精度 */
  pcm1.length = pcm0.length; /* 音データの長さ */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* 音データ */
  
  N = 256; /* DFTのサイズ */
  
  x_real = calloc(N, sizeof(double));
  x_imag = calloc(N, sizeof(double));
  y_real = calloc(N, sizeof(double));
  y_imag = calloc(N, sizeof(double));
  b_real = calloc(N, sizeof(double));
  b_imag = calloc(N, sizeof(double));
  
  w = calloc(N, sizeof(double));
  
  Hanning_window(w, N); /* ハニング窓 */
  
  number_of_frame = (pcm0.length - N / 2) / (N / 2); /* フレームの数 */
  
  for (frame = 0; frame < number_of_frame; frame++)
  {
    offset = N / 2 * frame;
    
    /* X(n) */
    for (n = 0; n < N; n++)
    {
      x_real[n] = pcm0.s[offset + n] * w[n];
      x_imag[n] = 0.0;
    }
    FFT(x_real, x_imag, N);
    
    /* B(k) */
    fe = 1000.0 / pcm0.fs; /* エッジ周波数 */
    fe *= N;
    for (k = 0; k <= fe; k++)
    {
      b_real[k] = 1.0;
      b_imag[k] = 0.0;
    }
    for (k = fe + 1; k <= N / 2; k++)
    {
      b_real[k] = 0.0;
      b_imag[k] = 0.0;
    }
    for (k = 1; k < N / 2; k++)
    {
      b_real[N - k] = b_real[k];
      b_imag[N - k] = -b_imag[k];
    }
    
    /* フィルタリング */
    for (k = 0; k < N; k++)
    {
      y_real[k] = x_real[k] * b_real[k] - x_imag[k] * b_imag[k];
      y_imag[k] = x_imag[k] * b_real[k] + x_real[k] * b_imag[k];
    }
    IFFT(y_real, y_imag, N);
    
    /* オーバーラップアド */
    for (n = 0; n < N; n++)
    {
      pcm1.s[offset + n] += y_real[n];
    }
  }
  
  wave_write_16bit_mono(&pcm1, "ex6_4.wav"); 
  
  free(pcm0.s);
  free(pcm1.s);
  free(x_real);
  free(x_imag);
  free(y_real);
  free(y_imag);
  free(b_real);
  free(b_imag);
  free(w);
  
  return 0;
}
