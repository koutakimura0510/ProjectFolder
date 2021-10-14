/*
 * Create 2021/10/14
 * Author kimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * 関数ポインタを利用した関数処理サンプル
 * 関数にstaticを付けなくても動作するかどうか確認する
 */
#include <stdio.h>

/* プロトタイプ宣言 */
void max_printf(void);
void min_printf(void);

/* 構造体型関数ポインタテーブル */
typedef struct
{
	void (*const func[2])(void);
} FuncTable;

static const FuncTable func_table = {
	{max_printf, min_printf},
};

/* 配列型関数ポインタテーブル、この場合インデックスを指定しなくてよい*/
static const void (*const funcArray[])(void) = {
	max_printf,
	min_printf,
};

/* ポインタ型関数処理、constを入れてはいけない */
static void (*funcPtr)(void) = NULL;


/**
 * @brief  maxの文字列表示関数
 * @note   
 * @retval None
 */
void max_printf(void)
{
	printf("max\n");
}


/**
 * @brief  minの文字列表示関数
 * @note   
 * @retval None
 */
void min_printf(void)
{
	printf("min\n");
}


/**
 * @brief  関数ポインタを利用した関数を実行
 * @note   
 * @retval 
 */
int main(void)
{
	/* 構造体型の関数ポインタを利用するパターン */
	const FuncTable *p = &func_table;
	p->func[0]();
	p->func[1]();

	/* 配列の関数ポインタテーブルを利用するパターン */
	funcArray[0]();
	funcArray[1]();

	/* ポインタ利用関数処理 */
	funcPtr = max_printf;
	funcPtr();

	return 0;
}