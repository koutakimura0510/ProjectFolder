#include "ap_int.h"

#define BIT_POS     (2)
#define HEIGHT      (480)
#define WIDTH       (640 + 96 + 96)
#define LEFT        (1)
#define RIGHT       (2)

typedef ap_uint<8>   u8;
typedef ap_uint<32>  u32;

u32 str[HEIGHT * WIDTH];
u32 copy[HEIGHT * WIDTH];

void background_loop(volatile u32 *ddr_copy, volatile u32 *ddr_update, u8 direction);

int main(void)
{
	for (int i = 0; i < HEIGHT; i++) {
		for (int j = 0; j < WIDTH; j++) {
			str[j + (i * WIDTH)] = j + (i * WIDTH);
		}
	}

//	display_shift();

	return 0;
}
