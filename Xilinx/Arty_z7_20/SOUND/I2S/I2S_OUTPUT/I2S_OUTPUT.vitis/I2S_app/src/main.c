/*
 * Ubuntu LTS 20.04
 * Vitis ver 20.2
 * -
 * Board ArtyZ7-20
 * -
 * 2021/03/21 Kimura
 */


/*
 * Includeファイル
 */
#include "xparameters.h"
#include "xsdps.h"
#include "ff.h"
#include <stdint.h>
#include <stdio.h>
#include "xsound_operation.h"
#include <sleep.h>

/*
 * DDR_ADDRESS
 * 音源データの保存を行うDDRメモリの開始アドレスを定義
 */
#define DDR_ADDRESS		(uint32_t *)0x02000000


/*
 * 音源再生
 */
#define PLAY_START			16


/*
 * rawファイルパラメータ
 * xxd -p sa.rawでファイルを作成
 * 
 * データ構造
 * 1行60byte + n改行
 * 
 * STR_BYTE
 * １つの音源データのバイト数
 * 
 * READ_LINE
 * 一度に読み込む行数を指定
 * 
 * F_READ_SIZE
 * 読み込み配列サイズ
 */
#define STR_BYTE		(2)
#define F_READ_SIZE		(3840 + 1)


/*
 * 音源再生ループ処理
 */
int32_t len = 0;
XSound_operation xsound;


/*
 * ファイル内関数宣言
 */
static uint8_t sd_read(void);
static uint32_t str_hex(char *str);


/*
 * SDカードから音源データを読み出しGPポートを使用しFPGAにデータを送信する
 * FPGA側のwpの位置によって送信データの更新を行う
 */
int main(void)
{
	if (XST_SUCCESS != sd_read())
	{
		return XST_FAILURE;
	}

	if (XST_SUCCESS != XSound_operation_Initialize(&xsound, XPAR_SOUND_OPERATION_0_DEVICE_ID))
	{
		return XST_FAILURE;
	}

	XSound_operation_Set_ramadr(&xsound, (uint32_t)DDR_ADDRESS);
	XSound_operation_Set_status(&xsound, PLAY_START);

	while(1) {
		char c = getchar();

		if (c == 's') {
			XSound_operation_Set_status(&xsound, 0);
		}
	}

	return XST_SUCCESS;
}


/*
 * 音源データの読み込みを行いDDRメモリに保存
 */
static uint8_t sd_read(void)
{
	FATFS fatfs;
    FIL fil;
	UINT bytes;
    const TCHAR *filename = "super_stream.raw";
    TCHAR *Path = "0:/";
	char rdata[F_READ_SIZE];
	uint32_t *p = DDR_ADDRESS;

    if (FR_OK != f_mount(&fatfs, Path, 0))
    {
        xil_printf("SD Mount Error\r\n");
        return XST_FAILURE;
    }
	xil_printf("SD Mount OK\r\n");

    if (FR_OK != f_open(&fil, filename, FA_READ))
    {
        xil_printf("SD Open Error\r\n");
        return XST_FAILURE;
    }
	xil_printf("SD Open OK\r\n");

	do {
		if (FR_OK != f_read(&fil, rdata, F_READ_SIZE, &bytes))
		{
			xil_printf("SD Read Error\r\n");
			f_close(&fil);
			return XST_FAILURE;
		}

		for (uint32_t i = 0; i < bytes - 1; i = i + STR_BYTE)
		{
			*p = str_hex(&rdata[i]);
			p++;
			len++;
		}
	} while (bytes == F_READ_SIZE);

	xil_printf("SD Read OK\r\n");

    if (FR_OK != f_close(&fil))
    {
        xil_printf("SD Close Error\r\n");
        return XST_FAILURE;
    }
	xil_printf("SD Close OK\r\n");

	return XST_SUCCESS;
}


/*
 * 文字列を数値に変換
 * キャッシュの仕様上変数dを0クリアする必要がある
 * 
 * 最大32bit取得
 */
static uint32_t str_hex(char *str)
{
	uint32_t d;
    char *p = str;

    d = 0;

    for (uint8_t i = 0; i < STR_BYTE; i++, p++)
    {
        d <<= 4;
        if (('0' <= *p) && (*p <= '9'))
        {
            d |= (*p - '0');
        }else{
            d |= (*p - 'a' + 10);
        }
    }

    return d;
}
