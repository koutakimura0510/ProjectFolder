/**-------------------------------------------------
 * ppm出力
 * -------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>

#define WIDTH  16
#define HEIGHT 16

int main(int argc, char **argv)
{
	unsigned char r[] = "255";
	unsigned char g[] = "255";
	unsigned char b[] = "255";
	FILE *fp;

	fp = fopen("white.ppm", "w");

	if (fp == NULL) {
		return 0;
	}

	fprintf(fp, "P3\n");
	fprintf(fp, "%d %d\n", HEIGHT, WIDTH);
	fprintf(fp, "255\n");

	for (int y = 0; y < HEIGHT; y++) {
		for (int x = 0; x < WIDTH; x++) {
			fprintf(fp, "%s %s %s ", r, g, b);
		}
		fprintf(fp, "\n");
	}

	return 0;
}
