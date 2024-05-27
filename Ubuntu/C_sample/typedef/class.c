#include <stdint.h>
#include <stdio.h>
#include <stddef.h>

typedef struct
{
} Data1;

typedef struct
{
    int data;
    int xpos;
    int ypos;
} MenuDB;


MenuDB get_data(void)
{
    MenuDB db;

    db.data = 100;
    db.xpos = 100;
    db.ypos = 50;

    return db;
}


int main(void)
{
    MenuDB db = get_data();

    printf("data = %d\n", db.data);
    printf("xpos = %d\n", db.xpos);
    printf("ypos = %d\n", db.ypos);

    return 0;
}