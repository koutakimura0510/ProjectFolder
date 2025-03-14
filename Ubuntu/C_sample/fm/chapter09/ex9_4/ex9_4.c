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
  double vco, vcf, *vca, gain, S, Q, a[3], b[3];
  
  pcm0.fs = 44100; /* W{»üg */
  pcm0.bits = 16; /* Êq»¸x */
  pcm0.length = pcm0.fs * 4; /* ¹f[^Ì·³ */
  pcm0.s = calloc(pcm0.length, sizeof(double)); /* ¹f[^ */
  
  vco = 440.0; /* î{üg */
  
  /* mRMg */
  t0 = pcm0.fs / vco; /* î{üú */
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
  
  vcf = 1500.0; /* Õfüg */
  Q = 5.0; /* ]iX */
  I = 2; /* xíÌ */
  J = 2; /* xíÌ */
  
  IIR_LPF(vcf / pcm0.fs, Q, a, b);  /* IIRtB^ÌÝv */
  
  pcm1.fs = pcm0.fs; /* W{»üg */
  pcm1.bits = pcm0.bits; /* Êq»¸x */
  pcm1.length = pcm0.length; /* ¹f[^Ì·³ */
  pcm1.s = calloc(pcm1.length, sizeof(double)); /* ¹f[^ */
  
  /* tB^O */
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
  
  vca = calloc(pcm0.length, sizeof(double)); /* U */
  gate = pcm1.fs * 4;
  duration = pcm1.fs * 4;
  A = 0;
  D = 0;
  S = 1.0;
  R = 0;
  ADSR(vca, A, D, S, R, gate, duration);
  
  gain = 0.1; /* QC */
  
  for (n = 0; n < pcm1.length; n++)
  {
    pcm1.s[n] *= vca[n] * gain;
  }
  
  /* tF[h */
  for (n = 0; n < pcm1.fs * 0.01; n++)
  {
    pcm1.s[n] *= (double)n / (pcm1.fs * 0.01);
    pcm1.s[pcm1.length - n - 1] *= (double)n / (pcm1.fs * 0.01);
  }
  
  wave_write_16bit_mono(&pcm1, "ex9_4.wav");
  
  free(pcm0.s);
  free(pcm1.s);
  free(vca);
  
  return 0;
}
