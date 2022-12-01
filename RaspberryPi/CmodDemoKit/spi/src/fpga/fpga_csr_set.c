/**-----------------------------------------------------------------------------
 * Create  2022/08/27
 * Author  koutakimura
 * -
 * FPGA 設定ライブラリ
 * -
 * FPGA Slave は下記のデータ幅と順番でデータを受け付ける
 * 4byte Adrs
 * 1byte dummy + 1byte Cmd + 2byte Data Length
 * 4byte Data
 * 
 * コマンド内容は下記の通り
 * 0. Non
 * 1. Csr Write
 * 2. Csr Read
 * 3. PSRAM Write
 * 
 * Csr 操作時は 連続アクセスは可能としない、必ず Data Length は 4byte 固定とする
 * PSRAM 操作時は Data Length は最大 2048 byte とする
 *-----------------------------------------------------------------------------*/
#include <main.h>
#include <unistd.h>

/**----------------------------------------------------------
 * 起動時の設定ファイル内容を FPGA に反映
 *---------------------------------------------------------*/
void fpga_csr_init(void)
{
	FILE *fp = NULL;
	char *path[] = {
		"./res/settings/GpioCsrInit.txt",
		"./res/settings/VideoCsrInit.txt",
		// "./res/settings/AudioCsrInit.txt",
		// "./res/settings/RamWrite.txt",
		// "./res/settings/RamRead.txt"
	};

	for (uint8_t i = 0; i < NUM(path); i++)
	{
		fpga_csr_write(fp, path[i]);
	}
}


/**----------------------------------------------------------
 * FPGA Slave に CSR の設定データ送信
 * 
 * 
 * FILE *fp : CSR設定ファイルのアドレス
 *---------------------------------------------------------*/
int fpga_csr_write(FILE *fp, char *file)
{
	unsigned int adrs, cmd, data;	// ファイルデータ保存 ヘッダコメント参照
	char wbuff[12];					// SPI 送信バッファ
	char rbuff[NUM(wbuff)];			// SPI 受信バッファ
	char comment[256];				// 設定ファイルコメント読み込み

	fp = fopen(file, "r");

	if (fp == NULL)
	{
		printf("File Open Error %s\r\n", file);
		return 1;
	}

	printf("ファイルの読み込みを開始します %s\r\n", file);

	// File Read Start, 配列で渡せないので要素ずつを指定する
	while (EOF != fscanf(fp, "%x %x %x %s ", &adrs, &cmd, &data, comment))
	{

		if (adrs == 0xffffffff)	// 0xfff... アドレスは存在しないため wait専用
		{
			usleep(data);
			printf("wait to ... \r\n");
		}
		else
		{
			for (int i = 0; i < 4; i++)	// 4byte を 1byte data に振り分け
			{
				unsigned int shift = (24 - (8 * i));
				wbuff [i]    = (adrs >> shift);
				wbuff [i+4]  = (cmd  >> shift);
				wbuff [i+8]  = (data >> shift);
			}
			gpio_spi_transfernb(wbuff, rbuff, NUM(wbuff));

			if (cmd & 0x00010000 || cmd & 0x00040000)
			{
				printf("CsrWrite : ");
			}
			else
			{
				uint32_t rdata = (rbuff[8] << 24) | (rbuff[9] << 16) | (rbuff[10] << 8) | rbuff[11];	// RCmd 発行時データ表示
				printf("CsrRead = Hex 0x%8x, Dec[31~16] %5d, Dec[15~0] %5d : ", rdata, rdata >> 16, rdata & 0xffff);
			}
			printf("0x%08x 0x%08x 0x%08x %s  \n", adrs, cmd, data, comment);
		}
	}

	if (EOF == fclose(fp))
	{
		printf("ファイルの close に失敗しました\n");
		return 1;
	}

	printf("File close ok\n\n");

	return 0;
}