/**-------------------------------------------------
 * イベント座標を表示するアプリ
 * -------------------------------------------------*/
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>


/**-------------------------------------------------
 * main
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	uint32_t max_x, max_y, xpixel, ypixel, d, dx, dy, i, check, number, bit = 0;
	char str1[16], nid[16], pass[16], fi[32];
	FILE *fp = NULL;

	printf("- ファイル名 = ");
	scanf("%s", fi);
	printf("\r\n");

	printf("- 画像データの横幅 = ");
	scanf("%d", &max_x);
	printf("\r\n");

	printf("- 一つの要素の横pixel数 = ");
	scanf("%d", &xpixel);
	printf("\r\n");

	printf("- 画像データの縦幅 = ");
	scanf("%d", &max_y);
	printf("\r\n");

	printf("- 一つの要素の縦pixel数 = ");
	scanf("%d", &ypixel);
	printf("\r\n");

	printf("- id名 = ");
	scanf("%s", str1);
	printf("\r\n");

	printf("- static const情報 select番号 = ");
	scanf("%d", &number);
	printf("\r\n");

	printf("- static const情報 path名 = ");
	scanf("%s", pass);
	printf("\r\n");

	printf("- データは途中からですか。yes=1, no=0  === ");
	scanf("%d", &check);
	printf("\r\n");

	fp = fopen(fi, "w");

	if (fp == NULL) {
		return false;
	}

	dx = (max_x / xpixel);
	dy = (max_y / ypixel);
	d  = dx * dy;

	if (check == 1) {
		printf("- どのIDの続きから開始しますか 終了id名 = ");
		scanf("%s", nid);
		printf("\r\n");
		fprintf(fp, "#define	%s_S (%s+%d)\n", str1, nid, 1);
	}else{
		fprintf(fp, "#define	%s_S (%d)\n", str1,  0);
	}

	for (i = 0; i < d; i++) {
		printf("#define	%s%d (%s_S+%d)\n", str1, i, str1, i);
		fprintf(fp, "#define	%s%d (%s_S+%d)\n", str1, i, str1, i);
	}
	fprintf(fp, "#define	%s_E (%s%d)\n", str1, str1, i-1);
	fprintf(fp, "\n");


	for (i = 0; i < dy; i++) {
		for (uint32_t j = 0; j < dx; j++) {
			printf("{	%s%d,  %3d, %3d, %d },\n", str1, j+(i*dx), j*xpixel, i*ypixel, 0);
			fprintf(fp, "{	%s%d,  %3d,  %3d,  %d  },\n", str1, j+(i*dx), j*xpixel, i*ypixel, 0);
		}
	}

	for (i = 0; i < 50; i++) {
		if (1 & (xpixel >> i)) {
			break;
		}
		bit++;
	}

	fprintf(fp, "{	%s_S,  %s_E,  %d,  (char **)%s,  %3d,  %3d,  %3d,  %3d,  %d  },\n", str1, str1, number, pass, xpixel, ypixel, max_x, max_y, bit);

	fclose(fp);


	return 0;
}
