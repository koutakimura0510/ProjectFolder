#include <stdio.h>

#define MINI(num, com)	(num != com ? num-- : num)
#define XPOS(x)			((x >> 1) << 2)

int main(void)
{
	int x = 100;

	x = XPOS(x);

	printf("x = %d\n", x);

	return 0;
}