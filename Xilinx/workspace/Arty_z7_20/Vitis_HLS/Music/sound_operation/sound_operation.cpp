#include "ap_int.h"

typedef ap_uint<32>  u32;

u32 cnt;
u32 ope;

void sound_operation(volatile u32 *ramadr, u32 *sdata, u32 *opeout)
{
	sound_operation_label1:for (int i = 0; i < 5; i++) {
		*opeout = ope;
		*sdata = ramadr[cnt];
	}
}
