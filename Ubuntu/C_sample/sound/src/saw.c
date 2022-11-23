/**-------------------------------------------------
 * ノコギリ波生成プログラム
 * Ubuntu LTS 20.04
 * -------------------------------------------------*/

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>


#define RATE 4096

static float buff[RATE];

/**-------------------------------------------------
 * メイン関数
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	FILE *fp;
	int32_t t0 = RATE / 440;
	float gain = RATE;
	uint8_t line = 0;
	int32_t m = 0;

	fp = fopen("../wave_txt/saw.txt", "w");

	if (fp == NULL) {
		printf("\r\n");
		printf("ファイル名かディレクトリのパスが間違っています\r\n");
		return 0;
	}

	for (int32_t i = 0; i < RATE; i++) {
		buff[i] = (1.0 - 2.0 * m / t0);
		buff[i] = (buff[i] * gain) + gain;

		if (m++ >= t0) {
			m = 0;
		}
	}

	fprintf(fp, "static const uint16_t saw[4096] = {\n    ");

	for (int32_t i = 0; i < RATE; i++) {
		fprintf(fp, "%4d, ", (uint16_t)buff[i]);
		if (line++ > 20) {
			line = 0;
			fprintf(fp, "\n    ");
		}
	}
	fprintf(fp, "\n};");
	printf("wave_txtディレクトリ内にsaw.txtを作成しました\r\n");
	fclose(fp);

	return 0;
}
