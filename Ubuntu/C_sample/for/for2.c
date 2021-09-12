#include <stdio.h>

#define A (0b0000000000000010)

int main(int argc, char **argv)
{
	for (int i = 0; i < A; i++) {
		if (3 < i) {
			if (5 < i) {
				break;
			}
		}
		printf("i = %d\n", i);
	}


	return 0;
}
