#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>


/**-------------------------------------------------
 * 音源データのパラメータを保存する構造体
 * -------------------------------------------------*/
typedef struct {
	int32_t fs;		//標本化周波数
	int32_t bits;	//量子化精度
	int32_t length;	//音データの長さ
	int32_t sec;	//出力波形の長さ
	int32_t filesize;
	float   amp;
	float   freq;
	float   *pbuff;		//音データ
} t_pcm;

static t_pcm pcm;


/**-------------------------------------------------
 * 音源データ初期値設定
 * -------------------------------------------------*/
static void pcm_init(void)
{
	t_pcm *p = &pcm;

	p->fs = 44100;
	p->bits = 16;
	p->sec  = 10;
	p->filesize = p->fs / p->sec;
	p->amp  = 2;
	p->freq = 440;
}



/**-------------------------------------------------
 * メイン関数
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	FILE *fp;
	t_pcm *p = &pcm;
	float pi = 3.141592654;
	float step;

	fp = fopen("../wav/sample.wav", "wb");
	pcm_init();
	p->pbuff = (float *)malloc(sizeof(float) * p->filesize);
	step = (2 * pi) / p->fs;

	if (p->pbuff == NULL) {
		return 0;
	}

	for (uint32_t i = 1; i < 29; i++) {
		for (uint32_t j = 0; j < p->filesize; j++) {
			if ((i % 2) == 1) {
				p->pbuff[j] += p->amp / i / i * sin(pi * i / 2.0) * sin(i * j * step * p->freq);
			}
		}
	}

	fwrite(p->pbuff, sizeof(float), p->filesize, fp);

	fclose(fp);
	free(p->pbuff);

	return 0;
}
