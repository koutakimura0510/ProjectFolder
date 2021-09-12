#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    char *heap;

    heap = (char *)malloc(sizeof(char) * 20000);

    if (heap == NULL)
    {
        printf("heap error \n");
        exit(1);
    }
    heap[19999] = 100;
    printf("heap[19999] = %d\n", heap[19999]);
    free(heap);

    return 0;
}