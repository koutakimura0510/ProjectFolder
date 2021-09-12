/*
 * Ubuntu LTS 20.04
 * Kouta Kimura
 */


/**-------------------------------------------------
 * Include
 * -------------------------------------------------*/
#include <stdio.h>
#include <unistd.h>

int num(void)
{
	return 0;
}


/**-------------------------------------------------
 * main関数
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	int n = 0;

	while (1)
	{
		printf("%d\n", n);
		n++;
		sleep(1);
	}

	return 0;
}
