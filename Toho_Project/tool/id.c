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
	char str1[16], sid[16], endid[16], nid[16], pass[16];
	FILE *fp = NULL;

	printf("- 横幅 = ");
	scanf("%d", &max_x);
	printf("\r\n");

	printf("- 横pixel = ");
	scanf("%d", &xpixel);
	printf("\r\n");

	printf("- 縦幅 = ");
	scanf("%d", &max_y);
	printf("\r\n");

	printf("- 縦pixel = ");
	scanf("%d", &ypixel);
	printf("\r\n");

	printf("- id名 = ");
	scanf("%s", str1);
	printf("\r\n");

	printf("- 開始id = ");
	scanf("%s", sid);
	printf("\r\n");

	printf("- 終了id = ");
	scanf("%s", endid);
	printf("\r\n");


	printf("- static const情報 number = ");
	scanf("%d", &number);
	printf("\r\n");

	printf("- static const情報 pass名 = ");
	scanf("%s", pass);
	printf("\r\n");

	printf("- データは途中からですか。yes=1, no=0  === ");
	scanf("%d", &check);
	printf("\r\n");

	fp = fopen("iddefine.txt", "w");

	if (fp == NULL) {
		return false;
	}

	dx = (max_x / xpixel);
	dy = (max_y / ypixel);
	d  = dx * dy;

	if (check == 1) {
		printf("- 途中id = ");
		scanf("%s", nid);
		printf("\r\n");
		fprintf(fp, "#define	%s (%s+%d)\n", sid, nid, 1);
	}else{
		fprintf(fp, "#define	%s (%d)\n", sid,  0);
	}

	for (i = 0; i < d; i++) {
		printf("#define	%s%d (%s+%d)\n", str1, i, sid, i);
		fprintf(fp, "#define	%s%d (%s+%d)\n", str1, i, sid, i);
	}
	fprintf(fp, "#define	%s (%s%d)\n", endid, str1, i-1);
	fprintf(fp, "\n");


	for (i = 0; i < dy; i++) {
		for (uint32_t j = 0; j < dx; j++) {
			printf("{	%s%d,	%d,	(char **)%s, %3d, %3d, %d },\n", str1, j+(i*dx), number, pass, j*xpixel, i*ypixel, 0);
			fprintf(fp, "{	%s%d,  %d,  (char **)%s,  %3d,  %3d,  %d  },\n", str1, j+(i*dx), number, pass, j*xpixel, i*ypixel, 0);
		}
	}

	for (i = 0; i < 50; i++) {
		if (1 & (xpixel >> i)) {
			break;
		}
		bit++;
	}

	fprintf(fp, "{	%s,  %s,  %3d,  %3d,  %3d,  %3d,  %d  },\n", sid, endid, xpixel, ypixel, max_x, max_y, bit);

	fclose(fp);


	return 0;
}
