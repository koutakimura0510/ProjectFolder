#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int *heap;

    heap = (int *)malloc(sizeof(int) * 20000);

    if (heap == NULL)
    {
        printf("heap error \n");
        exit(1);
    }
    heap[19999] = 100;
    printf("heap[19999] = %d\n", heap[19999]);
    printf("heap = %p\n", heap);
    free(heap);

    return 0;
}