/**-------------------------------------------------
 * イベント座標を表示するアプリ
 * -------------------------------------------------*/
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <locale.h>


#define FIELD_SIZE ((sizeof (map))/(sizeof (t_map)))

/**-------------------------------------------------
 * field
 * -------------------------------------------------*/
static const char *str[] ={
		 /* 0   2   4   6   8  10  12  14  16  18  20  22  24  26  28  30  32  34  36  38  40  42 */
		 /*   1   3   5   7   9  11  13  15  17  19  21  23  25  27  29  31  33  35  37  39  41   */
/*00*/    "■■■",
/*01*/    "■出■■■■■■■■■■■■■■■■■■■■■",
/*02*/    "■　　　　　　　　　　　　　　　　　　　　　■",
/*03*/    "■　　　　　　　　　　　　　　　　　　　　　■■■■■■■■■■■■■■■■■■■■■",
/*04*/    "■　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　■",
/*05*/    "■　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　■",
/*06*/    "■　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　■",
/*07*/    "■　　　　□□□□□□□□□□　　　　　　　　　　　　　　　　　　　　　　　　　　　■",
/*08*/    "■　　　　□　　　　　　　　□　　　　　　　　　　　　　　　　　　　　　　　　　　　■",
/*09*/    "■　　　　□　　　　　　　　□　　　　　　　　■■■■■■■■■■■■■■■■■■　■",
/*10*/    "■　　　　□　　　　宝　　　□　　　　　　　　　　　　　　　　　　　　　　　　　　Ｐ■",
/*11*/    "■　　　　□　　　　　　　　□　　　　　　　　■■■■■■■■■■■■■■■■■■■■",
/*12*/    "■　　　　□　　　　　　　　□　　　　　　　　■",
/*13*/    "■　　　　□　　　　　　　　□　　　　　　　　■",
/*14*/    "■　　　　□□□□　　　□□□　　　　　　　　■",
/*15*/    "■　　　　　　　　　　　　　　　　　　　　　　■",
/*16*/    "■　　　　　　　　　　　　　　　　　　　　　　■",
/*17*/    "■　　　　　　　　　　　　　　　　　　　　　　■",
/*18*/    "■　　　　　　　　　　　　　　　　　　　　　　■",
/*19*/    "■　　　　　　　　　　　　　　　　　　　　　　■",
/*20*/    "■　　　　　　　　　　　　　　　　　　　　　　■",
/*21*/    "■　　　　　　　　■■■■■■■■■■■■■■■",
/*22*/    "■　　　　　　　　■",
/*23*/    "■■■■■■■■■■",
/*24*/    "\0"
};

static const char *str1[] = {
	"■■■あいうえお漢字",
	"\0",
};


/**-------------------------------------------------
 * チェック用配列
 * -------------------------------------------------*/
static const char *wall[] = {
		"■",
		"□",
		"◇",
		"◆",
		"●",
		"▼",
		"▲",
		"▽",
		"△",
		"木",
		"　",
		"\0",
};

static const char *common[] = {
	"宝",
	"出",
	"\0",
};


typedef struct {
    int id;
    char **field_adr;
	char **name;
} t_map;

static const t_map map[] = {
    {0, (char **)str , (char **)"紅魔館"		},
    {1, (char **)str1, (char **)"デバッグ用"	},
};

/**-------------------------------------------------
 * 関数宣言
 * -------------------------------------------------*/
static bool locale_change(void);
static bool multibyte_eof(int id);
static uint32_t get_height(char **s);
static char **search_field_map(int32_t id);
static char **search_field_name(int32_t id);

/**--------------------------------------------
 * フィールドのマップ情報を取得する
 * --------------------------------------------
 * arg1: id    フィールドのIDを指定
 *--------------------------------------------*/
static char **search_field_map(int32_t id)
{
    const t_map *p = map;

    for (uint8_t i = 0; i < FIELD_SIZE; i++, p++) {
        if (p->id == id) {
            return p->field_adr;
        }
    }
	return '\0';
}


/**--------------------------------------------
 * フィールドの名前を取得する
 * --------------------------------------------
 * arg1: id    フィールドのIDを指定
 *--------------------------------------------*/
static char **search_field_name(int32_t id)
{
    const t_map *p = map;

    for (uint8_t i = 0; i < FIELD_SIZE; i++, p++) {
        if (p->id == id) {
            return p->name;
        }
    }
	return '\0';
}


/**-------------------------------------------------
 * Ｃロケールに変更
 * -------------------------------------------------*/
static bool locale_change(void)
{
	if (setlocale(LC_CTYPE, "") == NULL) {
		fputs("ロケールの設定に失敗しました\n", stderr);
		return false;
	}

	return true;
}


/**--------------------------------------------
 * フィールドの縦幅を取得する
 * --------------------------------------------
 * arg1: **s    fieldの先頭アドレス
 *--------------------------------------------*/
static uint32_t get_height(char **s)
{
    uint32_t count = 0;

    while (**s++ != '\0') {
        count++;
    }

    return count;
}


/**-------------------------------------------------
 * 文字列配列の要素数を取得し各文字のバイト数を取得する関数
 * -------------------------------------------------*/
static bool multibyte_eof(int id)
{
	int height, wallinfo, res, juge, com;
	int check = 0;
	int byte = 0;
	int count = 0;	//文字数取得
	char **field;
	char **name;
	char s[4];
	FILE *fp;

	fp = fopen("event.txt", "w");

	if (fp == NULL) {
		return false;
	}

	name  = search_field_name(id);
	field = search_field_map(id);
	height = get_height(field);
	wallinfo = get_height((char **)wall);
	juge = get_height((char **)common);
	fprintf(fp, "%s イベント座標 (x, y) 出力結果\n\n", (char *)name);
	fprintf(fp, "typedef struct {\n	int32_t x;\n	int32_t y;\n	char **msg;\n} t_event;\n\n");
	fprintf(fp, "static const t_event event[] = {\n");

	printf("- フィールド名   = %s\r\n", (char *)name);
	printf("- フィールド高さ = %d\r\n", height);
	printf("- 壁の種類       = %d\r\n", wallinfo);

	for (int i = 0; i < height; i++) {
		while (field[i][byte] != '\0') {
			res = mblen(&field[i][byte], MB_CUR_MAX);
			//printf("res = %d\r\n", res);
			for (int k = 0; k < wallinfo; k++) {
				for (int j = 0; j < res; j++) {
					if (wall[k][j] != field[i][byte + j]) {
						check++;
						break;
					}
				}
				if (check == wallinfo) {
					for (int n = 0; n < res; n++) {
						s[n] = field[i][byte + n];
					}
					s[3] = '\0';
					for (int z = 0; z < juge; z++) {
						com = 0;
						for (int m = 0; m < res; m++) {
							if (common[z][m] == s[m]) {
								com++;
							}
						}
					}
					//printf("- event(%s) pos(x = %2d, y = %2d)\r\n", s, count, i);
					if (res == com) {
						fprintf(fp, "	{%2d, %2d,	(char **)common_msg},	//%s\n", count, i, s);
					}else{
						fprintf(fp, "	{%2d, %2d,	(char **)},	//%s\n", count, i, s);
					}
				}
			}
			if (check == wallinfo) {
				for (int num = 0; num < res; num++) {
					printf("%c", field[i][num+byte]);
				}
			}else{
				for (int num = 0; num < res; num++) {
					printf("%c", field[i][num+byte]);
				}
				printf(" ");
			}
			check = 0;
			byte += res;
			count++;
		}
		printf("\r\n");
		byte = 0;
		count = 0;
	}

	fprintf(fp, "};\n\n");
	fprintf(fp, "	 0   2   4   6   8  10  12  14  16  18  20  22  24  26  28  30  32  34  36  38  40  42\n");
	fprintf(fp, "	   1   3   5   7   9  11  13  15  17  19  21  23  25  27  29  31  33  35  37  39  41  \n");

	for (int i = 0; i < height; i++) {
		fprintf(fp, "%2d. %s\n", i, &field[i][0]);
	}

	fclose(fp);

	return true;
}



/**-------------------------------------------------
 * main
 * -------------------------------------------------*/
int main(int argc, char **argv)
{
	int id, div;

	div = FIELD_SIZE-1;

	if (false == locale_change()) {
		return EXIT_FAILURE;
	}

	while (1) {
		printf("------------------------------------------------------------\r\n\n");
		printf("- 0～%d までの数値入力\r\n", div);
		printf("- %ld以上の数値入力でプログラムを終了します\r\n", FIELD_SIZE);
		printf("- 数値入力 = ");
		scanf("%d", &id);
		printf("\r\n");

		if (div < id) {
			printf("- 終了します\r\n");
			return 0;
		}

		if (false == multibyte_eof(id)) {
			printf("- file open error");
			return 0;
		}
		printf("- ok \r\n");
		printf("\r\n");
	}

	return 0;
}
