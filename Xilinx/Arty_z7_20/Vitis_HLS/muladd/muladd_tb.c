#include <stdio.h>
#include <stdlib.h>
#define SIZE 16

int muladd(int[], int[]);

int main()
{
    int a[SIZE], b[SIZE];
    int i, retval = 0, temp = 0;

    for (i = 0; i < SIZE; i++) {
        a[i] = rand() & 0xffff;
        b[i] = rand() & 0xffff;
        temp += a[i] * b[i];
        printf("a[%2d] = %04x, b[%2d] = %04x, temp = %08x\n", i, a[i], i, b[i], temp);
    }

    if (temp == muladd(a, b)) {
        printf("OK,\n");
    }else{
        printf("error,\n");
        retval = 1;
    }

    return retval;
}