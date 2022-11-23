#include <stdio.h>


typedef struct {
	int data;
} t_data1;

typedef struct {
	int data;
} t_data2;

typedef struct {
	int data;
} t_data3;

static const t_data1 data1[] = {
	{  0,},
	{100,},
	{200,},
	{300,},
	{400,},
	{500,},
};

static const t_data2 data2[] = {
	{0,},
	{1000,},
	{2000,},
	{3000,},
	{4000,},
	{5000,},
};

static const t_data3 data3[] = {
	{0,  },
	{10000,},
	{20000,},
	{30000,},
	{40000,},
	{50000,},
};

typedef struct {
	const t_data1 **p1;
	const t_data2 **p2;
	const t_data3 **p3;
} t_db;
static const t_db db = {(const t_data1 **)data1, (const t_data2 **)data2, (const t_data3 **)data3};


int main(int argc, char **argv)
{
	const t_db *p = &db;
	int d;

	printf("0, 1, 2の数値入力\n");
	scanf("%d", &d);
	printf("\n");

	for (int i = 0; i < 6; i++, p->(t_data1 *)p1++) {
		printf("p = %p\n", p->p1);
//		printf("d = %d\n", p->*p1->data);
	}

	return 0;
}
