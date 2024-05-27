/**-----------------------------------------------------------------------------
 * Create  2023/08/06
 * Author  Kouta Kimura
 * -
 * Wave ファイル生成サンプルプログラム
 * 
 * v1.0 new release
 *-----------------------------------------------------------------------------*/
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/**-------------------------------------------------
 * 音源データのパラメータを保存する構造体
 * -------------------------------------------------*/
typedef struct {
	int32_t fs;			// 標本化周波数
	int32_t bits;		// 量子化精度
	int32_t length;		// 音データの長さ
	int32_t sec;		// 出力波形の長さ
	int32_t filesize;
	float   amp;		// ゲイン
	float   freq;		// 基本周波数
	float   *pbuff;		// 音データ
} t_pcm;


/**-------------------------------------------------
 * 音源データ初期値設定
 * -------------------------------------------------*/
static void pcm_init(t_pcm *p)
{
	p->fs 	= 48000;
	p->bits = 16;
	p->sec  = 1;
	p->filesize = p->fs / p->sec;
	p->amp  = 0.5;
	p->freq = 440.0;
}


int main(void){
  FILE *fpw;/* 書き込み用ファイルポインタ */
  float *pbuff; /* メモリのデータを指す */
  int samplingfreq = 44100;/* サンプリング周波数 */
  int sec = 10; /* 作成する波形の長さ(秒) */
  int fileSize = samplingfreq * sec; /* ファイルの大きさ */
  float a = 0.4; /* Aの値 初期振幅 */
  float note = 440;
  float step = 2 * 3.14159265358979323846 / samplingfreq;/* 点間のステップ */
  int i;
  int j;

  /* 新規ファイル作成 */
  fpw = fopen("saw_32bitF_raw.wav", "wb");
  /* 失敗時終了 */
  if (fpw == NULL) exit(EXIT_FAILURE);
  /* メモリを確保して先頭アドレスをpbuffに入れる */
  pbuff = (float*)malloc(sizeof(float) * fileSize);
  /* 失敗時終了 */
  if (pbuff == NULL) exit(EXIT_FAILURE);

  /* SAW 整数倍sinの合成(30回) メモリ書き込み */
  for(i=1; i<=30; i++){
   for(j=0; j<fileSize; j++){
        *(pbuff+j) += a/i * sin(i * j * step * note);
   } 
  }
  /* ファイルへ書き込み */
  fwrite(pbuff, sizeof(float), fileSize, fpw);
  /* ファイル閉じる */
  fclose(fpw);
  /* メモリ解放 */
  free(pbuff);
  return 0;
}