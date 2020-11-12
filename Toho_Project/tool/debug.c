#include <stdio.h>

#define SIZE 16

int main(int argc, char **argv)
{
	int x = 0;
	int y = 0;
	int w = SIZE;
	int h = SIZE;
	int i, n;

	for (i = 0; i < 2; i++) {
		for (int n = 0; n < 4; n++) {
			x = SIZE * (n % 2);
			if (n > 1) {
				y = SIZE;
			}else{
				y = 0;
			}
			printf("%d %d x = %2d, y = %2d\n", i, n, x, y);
		}
	}
	return 0;
}
