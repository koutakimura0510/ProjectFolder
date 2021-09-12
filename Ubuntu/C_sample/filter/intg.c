/**-------------------------------------------------
 * Ubuntu LTS 20.04
 * -------------------------------------------------
 * 積分回路サンプルプログラム
 * 積分フィルタ(Integrator Filter)の生成を行う
 *
 * 動作:データを全て加算していけば積分になる
 * 一つ前のデータを保持しておいて新しいデータと加算する
 * -------------------------------------------------*/
#define M 1
#define M2 1
#define IN 32

/**-------------------------------------------------
 * Include
 * -------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int line1[256];
int line2[256];

int main(int argc, char **argv)
{
	int i, in = 22;
	int out, out2;
	int m  = M;
	int m2 = M2;
	int k = 0;

	if (argc > 1) {
		m = atoi(argv[1]);
	}

	for (i = 0; i < 256; i++) {
		line1[i] = 0;
		line2[i] = 0;
	}
	i = 0;
	
	for (int j = 0; j < IN; j++) {
		out = line1[i];
		line1[i] += in;
		i = (i + 1) % m;

		out2 = out - line2[k];
		line2[k] = out; 
		k = (k + 1) % m2;

		printf("%d\n", out2);
	}

	return 0;
}
