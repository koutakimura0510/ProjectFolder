#include <stdio.h>
#include <stdint.h>

typedef struct {
	char name[32];
	uint32_t hp;
	uint32_t mp;
	uint8_t level;
	uint8_t strength;
	uint8_t speed;
	uint8_t wisdom;
	uint32_t expr;
} t_status;

int main(int argc, char **argv)
{
	FILE *fp = NULL;
	t_status status[2] = {0};

	fp = fopen("Status.bin", "rb");
	fread(status, sizeof(t_status), sizeof(status) / sizeof(status[0]), fp);

	for (uint32_t i = 0; i < sizeof(status) / sizeof(status[0]); i++) {
		printf("%s, HP:%d, MP:%d, レベル:%d, 強さ:%d, 素早さ:%d, 賢さ:%d, 経験値:%d\n",
		status[i].name, status[i].hp, status[i].mp, status[i].level, status[i].strength, 
		status[i].speed, status[i].wisdom, status[i].expr);
	}

	return 0;
}
