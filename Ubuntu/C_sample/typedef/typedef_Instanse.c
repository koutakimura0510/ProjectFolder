/*
 * Ubuntu LTS 20.04
 *
 * オブジェクト指向型サンプルプログラム
 */

#include <stdio.h>

#define MENU_SIZE ((sizeof (unitdb)) / (sizeof (UnitDB)))

enum
{
    REIMU,
    MARISA,
    SANAE,
    SAKUYA,
    YOUMU,
    NAME_END,
};

enum
{
    ID,
    ATTACK,
    SIELD,
    PARAMATE_END,
};

typedef struct
{
    int menu[PARAMATE_END];
} UnitParamate;

typedef struct
{
    int id;
    int attack;
    int sield;
} UnitDB;

static const UnitDB unitdb[] = {
    {REIMU,  100, 100},
    {MARISA, 200, 400},
    {SANAE,  300, 600},
    {SAKUYA, 400, 800},
    {YOUMU,  500, 900},
};


int get_menu_paramate(const UnitDB *p, int member)
{
    switch (member)
    {
    case ATTACK:
        return p->attack;
    
    case SIELD:
        return p->sield;

    default:
        return 0;
    }
}


int search_db(int id, int member)
{
    const UnitDB *p = unitdb;

    for (int i = 0; i < NAME_END; i++, p++)
    {
        if (p->id == id)
        {
            break;
        }
    }

    return get_menu_paramate(p, member);
}


void set_menu_instanse(int id, UnitParamate *db)
{
    for (int i = 0; i < PARAMATE_END; i++)
    {
        db->menu[i] = search_db(id, i);
    }
}


int main(void)
{
    UnitParamate db;
    int d;

    printf("0 ~ %ldの数字を入力\n", MENU_SIZE-1);
    scanf("%d", &d);

    if (MENU_SIZE <= d) {
        printf("入力エラー\n");
        return 1;
    }

    set_menu_instanse(d, &db);

    printf("attack = %d\n", db.menu[ATTACK]);
    printf("sield  = %d\n", db.menu[SIELD]);

    return 0;
}