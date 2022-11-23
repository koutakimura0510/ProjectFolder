/**-------------------------------------------------
 * for文の動作確認サンプルプログラム
 *
 * Ubuntu LTS 20.04
 * 11-02	kimura
 * -------------------------------------------------*/

#include <stdio.h>
#include <stdint.h>


#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))

static uint8_t buff[] = {1, 0, 0, 0, 0, 0, 0, 0,};

/**-------------------------------------------------
 * main処理
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	char str[] = "divi";
	uint8_t *p;
	uint8_t len = 0;

	p = buff;

	while (p) {
		p++;
		len++;
	}

	printf("文字列配列長 = %d\r\n", NUM(str));
	printf("10進数配列長 = %d\r\n", len);


	return 0;
}
