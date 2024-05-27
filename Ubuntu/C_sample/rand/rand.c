#include <stdio.h>

int main(void)
{
	for (int i = 0; i < 30; i++)
	{
		printf("%d\n", i % 20);
	}

	return 0;
}