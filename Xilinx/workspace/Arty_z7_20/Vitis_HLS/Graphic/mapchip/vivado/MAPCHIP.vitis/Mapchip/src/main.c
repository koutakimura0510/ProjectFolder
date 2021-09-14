#include "xmapchip.h"
#include "xparameters.h"
#include "xil_printf.h"
#include <stdint.h>
#include <sleep.h>

#define VRAM 0x10000000
#define TEX  0x1012c000

#define WIDTH	640
#define HEIGHT	480

uint32_t buff[WIDTH * HEIGHT];
XMapchip ChipInstance;

void mapchip(int srcin, int dstout, int alpha)
{
	XMapchip_Set_srcin(&ChipInstance, srcin);
	XMapchip_Set_dstout(&ChipInstance, dstout);
	XMapchip_Set_alpha(&ChipInstance, alpha);
	XMapchip_Start(&ChipInstance);
	while (XMapchip_IsDone(&ChipInstance) == 0);
}

int main(void)
{
	uint32_t *p = (uint32_t *)VRAM;
	uint32_t *ptr = (uint32_t *)TEX;

	if (XST_SUCCESS != XMapchip_Initialize(&ChipInstance, XPAR_MAPCHIP_0_DEVICE_ID)) {
		return 1;
	}
	xil_printf("system start\n");

	for (int y = 0; y < HEIGHT; y++) {
		for (int x = 0; x < WIDTH; x++) {
			*p = x + (y * WIDTH);
			p++;
		}
	}

	mapchip(VRAM, TEX, 255);
	sleep(3);

	while (1) {
		for (int y = 0; y < HEIGHT; y++) {
			for (int x = 0; x < WIDTH; x++) {
				buff[x + (y * WIDTH)] = *ptr;
				ptr++;
			}
		}
		ptr = (uint32_t *)TEX;
	}

	return 0;
}
