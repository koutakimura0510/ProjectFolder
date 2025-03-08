/**-----------------------------------------------------------------------------
 * OS Windows11 for WSL2
 * VSCode 1.94.1
 * Author Kimura
 * 
 * 構造体 データベース作成による write / read サンプル
 * 変数宣言の部分のみ修正するだけで、ソース部分には手を加えなくてもよい構成にする。
 * Switch-case による冗長なアクセスは採用しない。
 * 
 * 本ソースでは、「アドレス・マップによるアドレス定義部分」と、「データベースの初期化部分」のみであり、
 * 書き込みと読み込み関数処理は、修正を加えずに済む。
 * レジスタが今後増えていった場合は、ブロックごとに区切るか、線形探索ではないアルゴリズムを使用する。
 * 
 *-----------------------------------------------------------------------------*/
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
//
#include "fx10_config.h"

/**-----------------------------------------------------------------------------
 * ユーザマクロ
 *-----------------------------------------------------------------------------*/
#define FX10_REG_CONFIG_DB_SIZE			((sizeof (Fx10RegEntry)) / (sizeof (Fx10RegEntry_t)))
#define FX10_REG_ERROR_CODE				(0xFFFFFFFF)	// 

/**-----------------------------------------------------------------------------
 * 構造体
 *-----------------------------------------------------------------------------*/
typedef struct {
	const uint32_t adrs;	// アドレスは動的変更不可
	uint32_t data;			// レジスタ値は上書き可能
} Fx10RegEntry_t;

static Fx10RegEntry_t Fx10RegEntry[] = {	// アドレスとレジスタの初期化
	//{FX10_REG_CUSTOM_CODE,			FX10_CUSTOM_CODE},
	{FX10_REG_FSYNC_CLK_ADRS,		1},
	{FX10_REG_FSYNC_PERIOD_ADRS,	10},
};


/**-----------------------------------------------------------------------------
 * データベースにデータを書き込み
 *-----------------------------------------------------------------------------*/
void fx10_reg_write(uint32_t adrs, uint32_t data)
{
	Fx10RegEntry_t *pFx10Reg = &Fx10RegEntry[0];	// 構造体の先頭アドレスを取得

	for (uint16_t i = 0; i < FX10_REG_CONFIG_DB_SIZE; i++, pFx10Reg++) {	// データベースのアドレスが一致するまでポインタを進める
		if (pFx10Reg->adrs == adrs) {
			pFx10Reg->data = data;
			break;
		}
	}
}

/**-----------------------------------------------------------------------------
 * データベースからデータを読み込み
 *-----------------------------------------------------------------------------*/
uint32_t fx10_reg_read(uint32_t adrs)
{
	Fx10RegEntry_t *pFx10Reg = &Fx10RegEntry[0];	// 構造体の先頭アドレスを取得

	for (uint16_t i = 0; i < FX10_REG_CONFIG_DB_SIZE; i++, pFx10Reg++) {	// データベースのアドレスが一致するまでポインタを進める
		if (pFx10Reg->adrs == adrs) {
			printf("Special Reg Adrs = 0x%x, Data = %d (0x%x)\n", pFx10Reg->adrs, pFx10Reg->data, pFx10Reg->data);
			return pFx10Reg->data;
		}
	}

	return FX10_REG_ERROR_CODE;	// エラーコード
}

/**-----------------------------------------------------------------------------
 * main 関数
 *-----------------------------------------------------------------------------*/
int main(void)
{
	fx10_reg_read(FX10_REG_FSYNC_CLK_ADRS);				// 初期化されているか、アドレスを指定して読み出し
	fx10_reg_read(FX10_REG_FSYNC_PERIOD_ADRS); 
	fx10_reg_write(FX10_REG_FSYNC_CLK_ADRS, 1234);		// 書き込みしてみる
	fx10_reg_write(FX10_REG_FSYNC_PERIOD_ADRS, 100000);
	fx10_reg_read(FX10_REG_FSYNC_CLK_ADRS);				// 上書きされているか呼び出してみる
	fx10_reg_read(FX10_REG_FSYNC_PERIOD_ADRS);

	return 0;
}