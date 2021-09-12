/* --------------------------------------------------------
 * 端末色表示プログラム
 * --------------------------------------------------------
 * 2019/05/23 kimura
 * --------------------------------------------------------
 * \033			8進数のエスケープ文字
 * ESC[0		指定リセット
 * ESC[1		ボールド表示
 * ESC[2		薄く表示する
 * ESC[3		イタリック表示
 * ESC[4		アンダーライン
 * ESC[5		毎分150回以下のペースで点滅
 * ESC[6		高速ブリンク
 * ESC[7		反転
 * ESC[8		表示を隠す
 * ESC[9		取り消し
 * ESC[30~37	文字色指定
 * ESC[38		文字色RGB指定
 * ESC[40~47	文字色をデフォルトに戻す
 * ESC[48		背景色RGB指定 --5:xでカラーインデックス指定 2;r;g;bでRGB指定
 * ESC[49		背景色をデフォルトに戻す
 * ESC[90~97	前景色指定
 * ESC[100~107	背景色指定
 *
 * \033[1;30;47m ---のように繋げることもできる
 * --------------------------------------------------------*/

#include <stdio.h>

#define XMAX 16
#define YMAX 16

int main(void)
{
//	printf("\033[2J");
//	printf("\033[%d;%dH", 10, 0);
	for (int i = 0; i < XMAX; i++) {
		for (int j = 0; j < YMAX; j++) {
			fprintf(stderr, "\033[48;2;%d;%d;255m", i << 4, j << 3);
		}
		printf("\r\n");
	}
	fprintf(stderr, "\033[0m\r\n");	//リセット
	printf("\r\n");

	for (int i = 0; i < XMAX; i++) {
		for (int j = 0; j < YMAX; j++) {
			const int v = i*16+j;
			fprintf(stderr, "\033[38;5;%dm%02X\033[0m ", v, v);
		}
		printf("\r\n");
	}
	printf("\r\n");

	for (int i = 0; i < XMAX; i++) {
		for (int j = 0; j < YMAX; j++) {
			const int v = i*16+j;
			fprintf(stderr, "\033[48;5;%dm%02X\033[0m ", v, v);
		}
		printf("\r\n");
	}
	printf("\r\n");

	return 0;
}
