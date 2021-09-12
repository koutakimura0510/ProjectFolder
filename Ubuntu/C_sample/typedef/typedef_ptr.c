/**-------------------------------------------------
 * Ubuntu LTS 20.04
 * 12-17 kimura
 * -------------------------------------------------
 * 構造体のアドレス更新確認サンプルプログラム
 * -------------------------------------------------*/
#include <stdio.h>



/**-------------------------------------------------
 * 構造体定義
 * -------------------------------------------------*/
typedef struct {
	int max;
	int min;
	int name;
	int id;
	int total;
} t_data;

static t_data data[10];


/**-------------------------------------------------
 * 構造体のアドレス確認
 * -------------------------------------------------*/
void adr_printf(t_data *p)
{
	int *ptr;

	printf("---メンバのアドレス確認---\n");
	printf("p = %p\n", &p->max);
	printf("p = %p\n", &p->min);
	printf("p = %p\n", &p->name);
	printf("p = %p\n", &p->id);
	printf("p = %p\n", &p->total);
	printf("\n");

	printf("---キャストしてアドレスを更新---\n");

	for (int i = 0; i < 5; i++)
	{
		ptr = (int *)p + i;
		printf("p = %p\n", ptr);
		*ptr = i;
	}
	printf("\n");

	printf("---メンバのデータ---\n");
	printf("max   = %d\n", p->max);
	printf("min   = %d\n", p->min);
	printf("name  = %d\n", p->name);
	printf("id    = %d\n", p->id);
	printf("total = %d\n", p->total);
	printf("\n");

	printf("---構造体のアドレスをインクリメントして更新---\n");

	for (int i = 0; i < 5; i++)
	{
		p = (t_data *)((int *)p+1);
		printf("p = %p\n", p);
	}
	printf("\n");

	printf("---p++してアドレスを更新---\n");
	printf("p = %p\n", p);
	p++;
	printf("p = %p\n", p);
	printf("\n");

}



/**-------------------------------------------------
 * main処理
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	t_data *p = data;

	adr_printf(p);

	return 0;
}
