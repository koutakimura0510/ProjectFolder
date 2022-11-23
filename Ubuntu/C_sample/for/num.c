#include <stdio.h>





int main(void)
{
    int num = 2123324321;
    int d[9];
    int count = 0;

    do
    {
        d[count] = num % 10;
        num /= 10;
        printf("%d\n", d[count]);
        count++;
    } while (num != 0);

    return 0;
}