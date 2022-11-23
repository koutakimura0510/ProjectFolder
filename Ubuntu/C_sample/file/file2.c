/**-------------------------------------------------
 * 2022-08-28
 * kimura
 * 
 * fscanfデモ動作
 * wsl2 Ubuntu20.04LTS
 * 変換指定子	変数データ型	詳細
 * %hhd			char
 * 				unsigned char	10進数で解釈し、１バイト変数へ格納する
 * %hd			short
 * 				unsigned short	10進数で解釈し、２バイト変数へ格納する
 * %d			int
 * 				unsigned int	10進数で解釈し、int型変数へ格納する
 * %ld			long
 * 				unsigned long	10進数で解釈し、４バイト変数へ格納する
 * %hhx			char
 * 				unsigned char	16進数で解釈し、１バイト変数へ格納する
 * %hx			short
 * 				unsigned short	16進数で解釈し、２バイト変数へ格納する
 * %x			int
 * 				unsigned int	16進数で解釈し、int型変数へ格納する
 * %lx			long
 * 				unsigned long	16進数で解釈し、４バイト変数へ格納する
 * %f			float			単精度浮動小数点数で解釈し、float型変数へ格納する
 * %lf			double			倍精度浮動小数点数で解釈し、double型変数へ格納する
 * %c			char			１文字として解釈し、char型変数へ文字として格納する
 * %s			char*			文字列として解釈し、文字列を格納する
 * %p			void*			16進数の番地として解釈し、番地を格納する
 * -------------------------------------------------*/


/**-------------------------------------------------
 * グローバルincludeファイル
 * -------------------------------------------------*/
#include <stdio.h>
#include <stdint.h>


/**-------------------------------------------------
 * メイン関数
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	FILE *fp = NULL;
	char comment[256];
	unsigned int d1, d2, d3, d4;

	fp = fopen("set.txt", "r");

	if (fp == NULL)
	{
		printf("open error\r\n");
		return 1;
	}

	// %x , のように、カンマと空白スペースを入れると、ファイル読み込み時に判定してくれるようになる
	while (EOF != fscanf(fp, "%x %x %x %x %s ", &d1, &d2, &d3, &d4, comment))
	{
		printf("%x %x %x %x %s\r\n", d1, d2, d3, d4, comment);
	}

	fclose(fp);
	printf("end\r\n");

	return 0;
}
