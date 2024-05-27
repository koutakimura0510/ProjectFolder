#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>
#include <mmsystem.h>
#include "wave.h"

#define NUMBER_OF_BUFFER 8 /* 出力バッファの数 */
#define BUFFER_SIZE 160 /* 出力バッファのサイズ */

int main(void)
{
  MONO_PCM pcm;
  int n, out0, out1, offset, frame, number_of_frame;
  
  short out_buffer[NUMBER_OF_BUFFER][BUFFER_SIZE]; /* 出力バッファ */
  WAVEHDR out_hdr[NUMBER_OF_BUFFER]; /* 出力バッファのヘッダ */
  HWAVEOUT out_hdl = 0; /* サウンドデバイスのハンドル */
  
  WAVEFORMATEX wave_format_ex = {WAVE_FORMAT_PCM, /* PCM */
                                 1, /* モノラル */
                                 8000, /* 標本化周波数（8000Hz） */
                                 16000, /*1秒あたりの音データのサイズ（16000byte） */
                                 2, /* 音データの最小単位（2byte） */
                                 16, /* 量子化精度（16bit） */
                                 0 /* オプション情報のサイズ（0byte） */
                                };
  
  wave_read_16bit_mono(&pcm, "speech.wav"); /* 音データの入力 */
  
  number_of_frame = pcm.length / BUFFER_SIZE;
  
  /* サウンドデバイスのオープン */
  waveOutOpen(&out_hdl, 0, &wave_format_ex, 0, 0, CALLBACK_NULL);
  
  /* サウンドデバイスの一時停止 */
  waveOutPause(out_hdl);
  
  /* 0を書き込むことでout_hdrをクリアする */
  for (out0 = 0; out0 < NUMBER_OF_BUFFER; out0++)
  {
    memset(&out_hdr[out0], 0, sizeof(WAVEHDR));
  }
  
  out0 = 0;
  out1 = 0;
  offset = 0;
  frame = 0;
  
  while (frame < number_of_frame)
  {
    if (out0 < NUMBER_OF_BUFFER)
    {
      /* 出力バッファに音データを書き込む */
      for (n = 0; n < BUFFER_SIZE; n++)
      {
        out_buffer[out0][n] = (short)(32768.0 * pcm.s[offset + n]);
      }
      offset += BUFFER_SIZE;
      frame++;
      
      /* 出力バッファの設定 */
      out_hdr[out0].lpData = (char *)out_buffer[out0]; /* 出力バッファの指定 */
      out_hdr[out0].dwBufferLength = BUFFER_SIZE * 2; /* 出力バッファのサイズ */
      out_hdr[out0].dwFlags = 0; /* フラグのクリア */
      
      /* 出力バッファのロック */
      waveOutPrepareHeader(out_hdl, &out_hdr[out0], sizeof(WAVEHDR));
      
      /* 出力バッファを出力待ちキューに追加する */
      waveOutWrite(out_hdl, &out_hdr[out0], sizeof(WAVEHDR));
      
      out0++;
      if (out0 == NUMBER_OF_BUFFER)
      /* すべての出力バッファが出力待ちキューに格納されたとき */
      {
        /* 再生を開始する */
        waveOutRestart(out_hdl);
      }
    }
    else
    {
      if ((out_hdr[out1].dwFlags & WHDR_DONE) != 0)
      /* 出力バッファのおわりまで音データが再生されたとき */
      {
        /* 出力バッファに音データを書き込む */
        for (n = 0; n < BUFFER_SIZE; n++)
        {
          out_buffer[out1][n] = (short)(32768.0 * pcm.s[offset + n]);
        }
        offset += BUFFER_SIZE;
        frame++;
        
        /* 出力バッファのアンロック */
        waveOutUnprepareHeader(out_hdl, &out_hdr[out1], sizeof(WAVEHDR));
        
        /* 出力バッファの設定 */
        out_hdr[out1].lpData = (char *)out_buffer[out1]; /* 出力バッファの指定 */
        out_hdr[out1].dwBufferLength = BUFFER_SIZE * 2; /* 出力バッファのサイズ */
        out_hdr[out1].dwFlags = 0; /* フラグのクリア */
        
        /* 出力バッファのロック */
        waveOutPrepareHeader(out_hdl, &out_hdr[out1], sizeof(WAVEHDR));
        
        /* 出力バッファを出力待ちキューに追加する */
        waveOutWrite(out_hdl, &out_hdr[out1], sizeof(WAVEHDR));
        
        out1++;
        if (out1 == NUMBER_OF_BUFFER)
        {
          out1 = 0; /* out1を0に戻し，出力バッファを再利用する */
        }
      }
    }
    
    Sleep(1); /* 1msのスリープをはさむことで，プログラムの実行速度を調節する */
  }
  
  for (out0 = 0; out0 < NUMBER_OF_BUFFER; out0++)
  {
    while ((out_hdr[out0].dwFlags & WHDR_DONE) == 0)
    /* 再生が完了するのを待つ */
    {
      Sleep(1); /* 1msのスリープをはさむことでプログラムの実行速度を調節する */
    }
  }
  
  waveOutPause(out_hdl); /* 音データの出力を停止する */
  for (out0 = 0; out0 < NUMBER_OF_BUFFER; out0++)
  {
    /* 出力バッファのアンロック */
    if ((out_hdr[out0].dwFlags & WHDR_PREPARED) != 0)
    {
      waveOutUnprepareHeader(out_hdl, &out_hdr[out0], sizeof(WAVEHDR));
    }
  }
  waveOutClose(out_hdl); /* サウンドデバイスのクローズ */
  
  free(pcm.s);
  
  return 0;
}
