#include <stdio.h>
#include <stdint.h>

typedef struct public_malloc
{
    uint32_t data;
    uint32_t xpos;
    uint32_t ypos;
} PublicMalloc;

PublicMalloc *p;


/*
 * 関数宣言
 */
int malloc_ptr(PublicMalloc **p, uint32_t len);

int main(void)
{
    
}


/*
 * 構造体の配列の動的確保
 */
int malloc_ptr(PublicMalloc **p, uint32_t len)
{
    *p = (PublicMalloc *)malloc(len * sizeof(PublicMalloc));

    if (NULL == *p)
    {
        printf("Error Malloc heap\n");
        exit(1);
    }

    for (uint32_t i = 0; i < len; i++)
    {
        (*p + i)->data = 100 * (i + 100);
        (*p + i)->xpos = 200 * (i + 200);
        (*p + i)->ypos = 300 * (i + 300);
    }
}