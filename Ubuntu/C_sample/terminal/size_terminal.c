#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>

int main(void)
{
	struct winsize ws;

	if (ioctl(STDIN_FILENO, TIOCGWINSZ, &ws) != -1) {
		printf("width  = %d\n", ws.ws_col);
		printf("height = %d\n", ws.ws_row);
	}
	return 0;
}
