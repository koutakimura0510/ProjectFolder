#include <stdio.h>

typedef struct 
{
    int data;
    int xpos;
    int ypos;
} DB;

DB db[100];


void printf_data(DB *p)
{
    printf("address = %p\n", p);
    printf("data = %d\n", p->data);
    printf("xpos = %d\n", p->xpos);
    printf("ypos = %d\n", p->ypos);
}


void db_update(DB *p)
{
    p = p + 1;
    printf_data(p);
}


int main(void)
{
    DB *p = db;

    printf_data(p);
    db_update(p);

    return 0;
}