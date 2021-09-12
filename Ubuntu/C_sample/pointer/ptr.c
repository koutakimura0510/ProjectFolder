#include <stdio.h>
#include <stdint.h>

#define DRAM_VDMA_ADDR_1    (uint32_t *)(DRAM_VDMA_ADDR_BASE)

#define WIDTH 5
#define HEIGHT 5

#define BUFFER_WIDTH 16
#define BUFFER_HEIGHT 16

int main(int argc, char **argv)
{
	//uint32_t xpos = 0, ypos = 0;
	uint32_t x, y;
	uint32_t buff[BUFFER_WIDTH * BUFFER_HEIGHT];
	uint32_t *p;

	for (int i = 0; i < 255; i++) {
		buff[i] = 0;
	}
	p = buff;
	printf("buff init !! \r\n");

	for (y = 0; y < HEIGHT; y++) {
		for (x = 0; x < WIDTH; x++, p++) {
			printf("d = %3d, p = %p\r\n", *p, p);
			*p = 5;
		}
      	p = p + (16 - WIDTH);
	}

	for (y = 0; y < BUFFER_HEIGHT; y++) {
		for (x = 0; x < BUFFER_WIDTH; x++, p++) {
			printf("%d,", buff[x + (y * BUFFER_HEIGHT)]);
		}
		printf("\r\n");
	}

	return 0;
}
