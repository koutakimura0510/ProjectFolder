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
#include "FONT.H"


//----------------------------------------------------------
// 配列長取得マクロ
//----------------------------------------------------------
#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))


//----------------------------------------------------------
// 作成ファイル名
//----------------------------------------------------------
const char *name = "font6.dat";


//----------------------------------------------------------
// main 関数
//----------------------------------------------------------
int main(void)
{
    FILE *fp = fopen(name, "w");

	if (fp == NULL) {
		printf("File %s open error\r\n", name);
		return 1;
	}

    for (uint32_t i = 0; i < NUM(fontdata6); i++) 
    {
        for (uint32_t j = 0; j < FONT6_W; j++)
        {
            fprintf(fp, "%02x\n", fontdata6[i][j]);
        }
    }

	fclose(fp);

    return 0;
}