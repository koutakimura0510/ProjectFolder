/**-------------------------------------------------
 * 三角波生成プログラム
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
	float t0 = RATE;
	float gain = RATE;
	uint8_t line = 0;

	fp = fopen("../wave_txt/triangle.txt", "w");

	if (fp == NULL) {
		printf("\r\n");
		printf("ファイル名かディレクトリのパスが間違っています\r\n");
		return 0;
	}

	for (int32_t i = 0; i < RATE; i++) {
		if (i < (t0 / 2)) {
			buff[i] = (-1.0 + (4.0 * i / t0));
		}else{
			buff[i] = (3.0 - (4.0 * i / t0));
		}
		buff[i] = (buff[i] * gain) + gain;
	}

	fprintf(fp, "static const uint16_t triangle[4096] = {\n    ");

	for (int32_t i = 0; i < RATE; i++) {
		fprintf(fp, "%4d, ", (uint16_t)buff[i]);
		if (line++ > 20) {
			line = 0;
			fprintf(fp, "\n    ");
		}
	}
	fprintf(fp, "\n};");
	printf("wave_txtディレクトリ内にtriangle.txtを作成しました\r\n");
	fclose(fp);

	return 0;
}
