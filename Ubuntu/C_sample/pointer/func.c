/*
 * Create 2021/11/4
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * アドレス参照のスコープ範囲を確認
 * アドレス参照の時に、どれくらいまで関数のネストを行えるか確認
 */

#include <stdio.h>


/* アドレスネスト2 */
void func2(int *buff)
{
	for (int i = 0; i < 5; i++)
	{
		printf("%d, %p\n", buff[i], &buff[i]);
		buff[i] = 4 - i;
	}
}


/* アドレスネスト1*/
void func1(int *buff)
{
	for (int i = 0; i < 5; i++)
	{
		printf("%d, %p\n", buff[i], &buff[i]);
	}

	func2(buff);
}

int main(void)
{
	int buff[5];

	for (int i = 0; i < 5; i++)
	{
		buff[i] = i;
	}

	func1(buff);
	
	for (int i = 0; i < 5; i++)
	{
		printf("%d, %p\n", buff[i], &buff[i]);
	}

	return 0;
}