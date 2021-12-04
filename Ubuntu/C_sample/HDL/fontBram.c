/*
 * Create 2021/12/4
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  gcc9.0.2
 * -
 * FPGAのBRAMに初期値として代入するフォントデータが保存された
 * datファイルを作成するプログラム
 */

#include <stdio.h>
#include <stdint.h>

//----------------------------------------------------------
// 作成ファイル名
//----------------------------------------------------------
const char *name = "font6.dat";


//----------------------------------------------------------
// main 関数
//----------------------------------------------------------
int main(void)
{
    FILE *fp;

	fp = fopen(name, "w");

	if (fp == NULL) {
		printf("File %s open error\r\n", name);
		return 1;
	}

	fclose(fp);

    return 0;
}