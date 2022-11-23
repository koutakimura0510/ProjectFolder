#include <stdio.h>
#include <stdbool.h>

/*
 * ver1. 2021/08/04
 * プロトタイプ宣言
 */
inline bool juge(int a, int b);


/* サンプル関数 */
inline bool juge(int a, int b)
{
	return (a < b) ? true : false;
}


/* メイン関数 */
int main(void)
{
	if (true == juge(0, 1))
	{
		printf("true\n");
	}
	else
	{
		printf("false\n");
	}

	return 0;
}