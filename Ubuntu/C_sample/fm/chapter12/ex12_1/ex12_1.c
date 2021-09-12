#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>
#include <mmsystem.h>
#include "wave.h"

#define NUMBER_OF_BUFFER 8 /* 入力バッファの数 */
#define BUFFER_SIZE 160 /* 入力バッファのサイズ */

int main(void)
{
  MONO_PCM pcm;
  int n, in0, in1, offset, frame, number_of_frame;
  
  short in_buffer[NUMBER_OF_BUFFER][BUFFER_SIZE]; /* 入力バッファ */
  WAVEHDR in_hdr[NUMBER_OF_BUFFER]; /* 入力バッファのヘッダ */
  HWAVEIN in_hdl = 0; /* サウンドデバイスのハンドル */
  
  WAVEFORMATEX wave_format_ex = {WAVE_FORMAT_PCM, /* PCM */
                                 1, /* モノラル */
                                 8000, /* 標本化周波数（8000Hz） */
                                 16000, /*1秒あたりの音データのサイズ（16000byte） */
                                 2, /* 音データの最小単位（2byte） */
                                 16, /* 量子化精度（16bit） */
                                 0 /* オプション情報のサイズ（0byte） */
                                };
  
  pcm.fs = 8000; /* 標本化周波数 */
  pcm.bits = 16; /* 量子化精度 */
  pcm.length = pcm.fs * 4; /* 音データの長さ */
  pcm.s = calloc(pcm.length, sizeof(double)); /* 音データ */
  
  number_of_frame = pcm.length / BUFFER_SIZE;
  
  /* サウンドデバイスのオープン */
   waveInOpen(&in_hdl, 0, &wave_format_ex, 0, 0, CALLBACK_NULL);
  
  /* 0を書き込むことでin_hdrをクリアする */
  for (in0 = 0; in0 < NUMBER_OF_BUFFER; in0++)
  {
    memset(&in_hdr[in0], 0, sizeof(WAVEHDR));
  }
  
  in0 = 0;
  in1 = 0;
  offset = 0;
  frame = 0;
  
  while (frame < number_of_frame)
  {
    if (in0 < NUMBER_OF_BUFFER)
    {
      /* 入力バッファの設定 */
      in_hdr[in0].lpData = (char *)in_buffer[in0]; /* 入力バッファの指定 */
      in_hdr[in0].dwBufferLength = BUFFER_SIZE * 2; /* 入力バッファのサイズ */
      in_hdr[in0].dwFlags = 0; /* フラグのクリア */
      
      /* 入力バッファのロック */
      waveInPrepareHeader(in_hdl, &in_hdr[in0], sizeof(WAVEHDR));
      
      /* 入力バッファを入力待ちキューに追加する */
      waveInAddBuffer(in_hdl, &in_hdr[in0], sizeof(WAVEHDR));
      
      in0++;
      if (in0 == NUMBER_OF_BUFFER)
      /* すべての入力バッファが入力待ちキューに格納されたとき */
      {
        /* 録音を開始する */
        waveInStart(in_hdl);
      }
    }
    else
    {
      if ((in_hdr[in1].dwFlags & WHDR_DONE) != 0)
      /* 入力バッファのおわりまで音データが録音されたとき */
      {
        /* 入力バッファのアンロック */
        waveInUnprepareHeader(in_hdl, &in_hdr[in1], sizeof(WAVEHDR));
        
        /* 入力バッファから音データを読み取る */
        for (n = 0; n < BUFFER_SIZE; n++)
        {
          pcm.s[offset + n] = in_buffer[in1][n] / 32768.0;
        }
        offset += BUFFER_SIZE;
        frame++;
        
        /* 入力バッファの設定 */
        in_hdr[in1].lpData = (char *)in_buffer[in1]; /* 入力バッファの指定 */
        in_hdr[in1].dwBufferLength = BUFFER_SIZE * 2; /* 入力バッファのサイズ */
        in_hdr[in1].dwFlags = 0; /* フラグのクリア */
        
        /* 入力バッファのロック */
        waveInPrepareHeader(in_hdl, &in_hdr[in1], sizeof(WAVEHDR));
        
        /* 入力バッファを入力待ちキューに追加する */
        waveInAddBuffer(in_hdl, &in_hdr[in1], sizeof(WAVEHDR));
        
        in1++;
        if (in1 == NUMBER_OF_BUFFER)
        {
          in1 = 0; /* in1を0に戻し，入力バッファを再利用する */
        }
      }
    }
    
    Sleep(1); /* 1msのスリープをはさむことで，プログラムの実行速度を調節する */
  }
  
  waveInStop(in_hdl); /* 音データの入力を停止する */
  for (in0 = 0; in0 < NUMBER_OF_BUFFER; in0++)
  {
    /* 入力バッファのアンロック */
    if ((in_hdr[in0].dwFlags & WHDR_PREPARED) != 0)
    {
      waveInUnprepareHeader(in_hdl, &in_hdr[in0], sizeof(WAVEHDR ));
    }
  }
  waveInClose(in_hdl); /* サウンドデバイスのクローズ */
  
  wave_write_16bit_mono(&pcm, "ex12_1.wav"); /* 音データの出力 */
  
  free(pcm.s);
  
  return 0;
}
