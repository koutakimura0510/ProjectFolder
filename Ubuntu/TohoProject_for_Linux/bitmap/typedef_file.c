/*
 * Create 2021/07/13
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * 構造体のデータをbinファイルに書き出すサンプル
 */
#include <stdio.h>
#include <stdint.h>

typedef struct {
	// char name[80];
	uint8_t hp;
	uint8_t mp;
	uint8_t level;
	// uint8_t strength;
	// uint8_t speed;
	// uint8_t wisdom;
	// uint32_t experience;
} t_status;

// static const t_status status[] = {
// 	{"穣子", 20, 15, 1,  7,  7, 27, 0 },
// 	{"静葉", 32,  4, 1, 20, 11, 21, 0 },
// };


int main(int argc, char **argv)
{
	t_status status;

	status.hp = 0x12;
	status.mp = 0x0;
	status.level = 5;

	FILE *fp = NULL;

	fp = fopen("Status.bin", "wb");

	if (fp == NULL) {
		printf("open error\n");
		return 0;
	}
	fwrite(&status, sizeof(t_status), sizeof(uint8_t), fp);
	fwrite(&status, sizeof(t_status), sizeof(uint8_t), fp);
	// fwrite(status, sizeof(t_status), sizeof(status) / sizeof(status[0]), fp);
	fclose(fp);
	printf("file write end\n");

	return 0;
}
