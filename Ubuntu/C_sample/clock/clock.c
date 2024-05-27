/**-------------------------------------------------
 * math.hライブラリの関数速度確認
 * -------------------------------------------------*/

#include <stdio.h>
#include <time.h>
#include <math.h>
#include <stdint.h>

#define LOOP 1000000
#define LOG2 0.693147180559945309417f

double exp_fast(double x)
{
	static double waru[7] = {
		1.0 / (2*3*4*5*6),
		1.0 / (2*3*4*5),
		1.0 / (2*3*4),
		1.0 / (2*3),
		1.0 / 2,
		1.0,
		1.0,
	};

	static uint64_t table[16] = {
		0x059B0D3158574ull,
		0x11301D0125B51ull,
		0x29E9DF51FDEE1ull,
		0x371A7373AA9CBull,
		0x44E086061892Dull,
		0x5342B569D4F82ull,
		0x6247EB03A5585ull,
		0x71F75E8EC5F74ull,
		0x82589994CCE13ull,
		0x93737B0CDC5E5ull,
		0xA5503B23E255Dull,
		0xB7F76F2FB5E47ull,
		0xCB720DCEF9069ull,
		0xDFC97337B9B5Full,
		0xF50765B6E4540ull,
	};

	double y = 1.0/(2*3*4*5*6*7), *p = waru,z,r;
	int q;
	uint64_t w;
	z = x * (16.0 / LOG2);
	q = (int)z - (x < 0);
	r = x - ((q << 1) + 1) * (LOG2/32.0);
	w = (uint64_t)(1023 + (q >> 4)) << 52 ^ table[q & 0xF];
	z = *(double*)&w;

	do {
		y = y * r + (*p);
		p++;
	} while ( p < waru + 7);


	return y * z;
}


/**-------------------------------------------------
 * メイン関数
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	int i;
	float d = 32000;
	long cpu_time;
	double sec;

	for (i = 0; i < LOOP; i++) {
		//printf("%f\n", exp_fast(-5.0 * (i - 0) / d));
		printf("%f\n", exp(-5.0 * (i - 0) / d));
	}

	cpu_time = clock();
	sec = (double)cpu_time / CLOCKS_PER_SEC;

	printf("CPU時間: %f\n", sec);

	return 0;
}
