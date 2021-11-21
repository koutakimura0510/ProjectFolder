#define SIZE 16

int muladd(int a[SIZE], int b[SIZE])
{
    int i, temp = 0;

    muladd_loop:for (i = 0; i < SIZE; i++)
    {
        temp += a[i] * b[i];
    }

    return temp;
}
