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
#include "char8x8.h"


//----------------------------------------------------------
// 配列長取得マクロ
//----------------------------------------------------------
#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))


//----------------------------------------------------------
// 作成ファイル名
//----------------------------------------------------------
const char *name = "font8x8.dat";


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

    //----------------------------------------------------------
    // font8x8のデータ構造の場合、msbとlsbの向きが逆のため反転させなければならなかった
    //----------------------------------------------------------
    for (uint32_t i = 0; i < NUM(font8x8); i++) 
    {
        uint8_t fontdata = 0;

        for (uint32_t j = 0; j < 8; j++)
        {
            if (font8x8[i] & (0x01 << j))
            {
                fontdata |= 0x01 << (7 - j);
            }
        }

        fprintf(fp, "%02x\n", fontdata);
    }

	fclose(fp);

    return 0;
}