#include <stdio.h>
#include <stdlib.h>
#include "xil_printf.h"
#include "xparameters.h"
#include "xmuladd.h"

#define SIZE 16

/* インスタンス変数*/
XMuladd Instance;

int main()
{
    u32 a[SIZE], b[SIZE];
    int i, temp = 0;

    if (XMuladd_Initialize(&Instance, XPAR_XMULADD_0_DEVICE_ID) != XST_SUCCESS) {
        xil_printf("Init Error\r\n");
        return XST_FAILURE;
    }

    for (i = 0; i < SIZE; i++) {
        a[i] = rand() & 0xffff;
        b[i] = rand() & 0xffff;
        temp += a[i] * b[i];
        xil_printf("a[%2d] = %04x, b[%2d] = %04x, temp = %08x\n", i, a[i], i, b[i], temp);
    }

    /* ポート経由してデータ書き込み */
    XMuladd_Write_a_Words(&Instance, 0, a, SIZE);
    XMuladd_Write_b_Words(&Instance, 0, b, SIZE);

    /* 乗算回路を起動し計算 */
    XMuladd_Start(&Instance);
    while (XMuladd_IsDone(&Instance) == 0);

    /* 演算結果を比較し結果が同じか確認 */
    if (temp == XMuladd_Get_return(&Instance)) {
        xil_printf("OK,\n");
    }else{
        xil_printf("error,\n");
    }

    return 0;
}
