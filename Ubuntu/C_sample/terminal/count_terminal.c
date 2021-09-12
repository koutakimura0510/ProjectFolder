#include <stdio.h>
#include <unistd.h>

int main(void)
{
	for (int i = 0; i <= 100; i++) {
		fprintf(stderr, "\r[%3d / 100]", i);
		usleep(100000);
	}
	fprintf(stderr, "\nfinish!\n");

	return 0;
}
