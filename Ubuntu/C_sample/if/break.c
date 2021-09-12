/*
 * Create 2021/09/01
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * いり子になったif文のbreakが動作するか確認するサンプル
 * 結論、エラーになったため無理みたいだ
 */
#include <stdio.h>


/**
 * @brief  main処理
 * @note   
 * @retval 
 */
int main(void)
{
	int fix = 0;
	int dec = 0;

	if (fix == 0)
	{
		if (dec == 0)
		{
			dec = 10;
			break;
		}

		if (dec != 1)
		{
			dec = 100;
			break;
		}
	}

	printf("dec = %d\n", dec);

	return 0;
}