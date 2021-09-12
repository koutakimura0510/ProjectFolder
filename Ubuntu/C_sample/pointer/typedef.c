/*
 * ver1. 2021/08/2
 * 構造体一括代入サンプルプログラム
 */
#include <stdio.h>

/* 構造体定義 */
typedef struct 
{
	int data[3];
	int len[3];
	int sub[3];
} SubStruct;

typedef struct 
{
	SubStruct sub;
} ModuleWrapper;


/* 構造体の確保 */
static ModuleWrapper module;


/* 構造体の一括コピー */
void module_copy(ModuleWrapper *module)
{
	printf("%p\n", module);
	module->sub[0] = module->sub[1];
}


/* メイン関数 */
int main(void)
{
	ModuleWrapper *p = &module;

	printf("data %d\n", p->sub.data[0]);
	printf("len  %d\n", p->sub.len[0]);
	printf("sub  %d\n", p->sub.sub[0]);
	printf("%p\n", p);
	p->sub.data[1] = 1000;
	p->sub.len[1]  = 1234;
	p->sub.sub[1]  = 5643;
	module_copy(p);

	printf("data %d\n", p->sub.data[1]);
	printf("len  %d\n", p->sub.len[1]);
	printf("sub  %d\n", p->sub.sub[1]);
	printf("data %d\n", p->sub.data[0]);
	printf("len  %d\n", p->sub.len[0]);
	printf("sub  %d\n", p->sub.sub[0]);

	return 0;
}