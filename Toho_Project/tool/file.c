/**-------------------------------------------------
 * バイナリデータ作成
 * -------------------------------------------------*/
#include <stdio.h>
#include <stdint.h>

void mapf_write(void);
void mapf_read(void);


//配列データ書き込み
void mapf_write(void)
{
	FILE *fp = NULL;

	uint32_t array[16] = {
		0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
	};

	fp = fopen("map.bin", "wb");

	if (fp == NULL) {
		printf("ファイルopenエラー\n");
		return;
	}

	fwrite(array, sizeof(uint32_t), sizeof(array) / sizeof(array[0]), fp);

	fclose(fp);
}


//配列データ読み込み
void mapf_read(void)
{
	FILE *fp = NULL;
	uint32_t read[16] = {0};

	fp = fopen("map.bin", "rb");

	if (fp == NULL) {
		printf("ファイルreadエラー\n");
		return;
	}
	fread(read, sizeof(uint32_t), sizeof(read) / sizeof(read[0]), fp);

	for (uint32_t i = 0; i < 16; i++) {
		printf("0x%04x \r\n", read[i]);
	}

	fclose(fp);
}


int main(int argc, char **argv)
{
	mapf_write();
	mapf_read();

	return 0;
}
