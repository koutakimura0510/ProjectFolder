/**-------------------------------------------------
 * Ubuntu LTS 20.04 kimura
 * 分解能に応じた音階の整数部と小数部、sin波形のデータテーブルを出力するプログラム
 * プログラム実行時、2の乗数倍の分解能を求められるので数値を入力し計算を行う
 * -------------------------------------------------*/


/**-------------------------------------------------
 * インクルードファイル
 * -------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>

#define LOOP 128		//使用する音階数
#define DIV  1000000	//固定少数
#define INTERRUPT	31.25


/**-------------------------------------------------
 * main関数
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	FILE *fp;
	double sound;	//#を含めた音階の上り幅
	double onkai = 440;	//基本音階
	double decimal[LOOP];
	double integer[LOOP];
	uint8_t line = 0;
	double pwm, volt, n, clk, sine, sinclk;
	uint32_t d = 1;
	uint32_t shift;

	while (1) {
		printf("分解能選択 8~16bitを入力 = ");
		scanf("%d", &shift);
		printf("\r\n");

		if ((shift >= 8) && (shift <= 16)) {
			break;
		}else{
			printf("8bitから16bitを指定してください\r\n");
		}
	}

	d <<= shift;

	pwm = d;
	volt = pwm / 2;
	n    = pwm - 1;
	clk  = 1 / ((INTERRUPT * pwm) / DIV);
	sinclk = 1 / n;

	printf("pwm    = %fd\r\n", pwm);
	printf("volt   = %fd\r\n", volt);
	printf("n      = %fd\r\n", n);
	printf("clk    = %fd\r\n", clk);
	printf("sinclk = %fd\r\n", sinclk);

	fp = fopen("sin.txt", "w");

	if (fp == NULL) {
		fprintf(stderr, "file open error");
		return 1;
	}

	/**-------------------------------------------------
	 * 音階の整数部と小数部の取得
	 * -------------------------------------------------*/
	for (int16_t i = 0; i < LOOP; i++) {
		sound = onkai*pow(2, (i-69) / 12.0);
		decimal[i] = sound / clk;
		integer[i] = (uint32_t)decimal[i];
		decimal[i] = decimal[i] - integer[i];
		decimal[i] = (uint32_t)(decimal[i] * pwm);
	}
	fprintf(fp, "static const uint16_t bgm_integer[] = {\n    ");

	/**-------------------------------------------------
	 * 整数部書き込み
	 * -------------------------------------------------*/
	for (uint16_t i = 0; i < LOOP; i++) {
		fprintf(fp, " %5d,", (uint16_t)integer[i]);
		if (line++ > 20) {
			line = 0;
			fprintf(fp, "\n    ");
		}
	}
	fprintf(fp, "\n};\n");
	line = 0;


	/**-------------------------------------------------
	 * 小数部書き込み
	 * -------------------------------------------------*/
	fprintf(fp, "static const uint16_t bgm_decimal[] = {\n    ");

	for (uint32_t i = 0; i < LOOP; i++) {
		fprintf(fp, " %5d,", (uint16_t)decimal[i]);
		if (line++ > 20) {
			line = 0;
			fprintf(fp, "\n    ");
		}

	}
	fprintf(fp, "\n};\n");
	line = 0;


	/**-------------------------------------------------
	 * sinカーブのデータを取得し書き込み
	 * -------------------------------------------------*/
	fprintf(fp, "static const uint16_t bgm_sin[] = {\n    ");

	for (double i = 0; i < pwm; i++) {
		sine = (sin(6.283185307 * (sinclk * i)) * volt) + volt;
		fprintf(fp, " %5d,", (uint16_t)sine);
		if (line++ > 20) {
			line = 0;
			fprintf(fp, "\n    ");
		}
	}
	fprintf(fp, "\n};");


	/**-------------------------------------------------
	 * verilogのsinカーブ初期化を出力
	 * -------------------------------------------------*/
	fprintf(fp, "initial begin\n    ");

	for (uint32_t i = 0; i < pwm; i++) {
		sine = (sin(6.283185307 * (sinclk * (double)i)) * volt) + volt;

		fprintf(fp, "sin[%d:%d] <= ", (8*i)+7, 8*i);
		fprintf(fp, "8'd%d;", (uint16_t)sine);
		fprintf(fp, "\n    ");
	}
	fprintf(fp, "end");

	//fwrite(array, sizeof(uint32_t), sizeof(array) / sizeof(array[0]), fp);

	fclose(fp);
	printf("sin.txtファイルを出力しました\n");

	return 0;
}
