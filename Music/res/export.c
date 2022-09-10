#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>

FILE *fp;
FILE *read_fp;


/*
 * エラー処理関数
 */
void error_fprintf(const char *s, int line)
{
	fprintf(stderr, "[Line] = %d\n", line);
	fprintf(stderr, "[func] = %s\n", s);
}


/*
 * ディレクトリのパスとファイル名を取得
 *
 * パスを指定
 * raw/battle/battle.raw
 * 
 * filenameに取得
 * battle/battle.raw
 */
void get_filename(char *path, char *filename)
{
	uint32_t count = 0;
    uint32_t n = 0;

	do
	{
		path++;
        if (*path == '/') {
            n++;
        }
	} while (*path != '.');

    for (int i = 0; i < n; i++) {
        do
        {
            path--;
        } while (*path != '/');
    }

	path++;
	while (path[count] != '\0')
	{
		filename[count] = path[count];
		count++;
	}
}


/*
 * rawファイルをxxdコマンドでダンプ
 *
 * リダイレクトコマンドはファイルに追加動作をしてしまうため
 * 既存のファイルを消去してから出力を行う
 */
void xxd_cmd(char *file, char *filename)
{
	char rm[128]  = "rm ./output/";
	char xxd[128] = "xxd -p ";
	char direct[] = " >> ./output/";

    strcat(rm, filename);
    strcat(xxd, file);
	strcat(xxd, direct);
	strcat(xxd, filename);

    if (system(rm) == -1) {
        printf("rm error\n");
		error_fprintf(__func__, __LINE__);
    }

    if (system(xxd) == -1) {
		printf("xxd error\n");
		error_fprintf(__func__, __LINE__);
    }
}


/*
 * 初期設定関数
 */
int system_init(char *path)
{
	char dir_path[256] = "./sdfile/";
	char out_path[128] = "./output/";
	char filename[128];

	if (!path) {
		fprintf(stderr, "ファイル名が指定されていません\n");
		error_fprintf(__func__, __LINE__);
		return 1;
	}

	get_filename(path, filename);
	xxd_cmd(path, filename);
	strcat(out_path, filename);
    read_fp = fopen(out_path, "r");
	fprintf(stderr, "%s\n", out_path);

    if (read_fp == NULL) {
		fprintf(stderr, "ファイルが読み込めませんでした\n");
		error_fprintf(__func__, __LINE__);
		return 1;
	}

    fprintf(stderr, "読み込みファイル = %s\n", out_path);
	strcat(dir_path, filename);
	fp = fopen(dir_path, "w");

	if (fp == NULL) {
		fprintf(stderr, "File Open error\n");
		error_fprintf(__func__, __LINE__);
		return 1;
	}

	fprintf(stderr, "ファイルを生成します = %s\n", dir_path);
	fprintf(stderr, "\n");

	return 0;
}


void file_generate(void)
{
    int count = 0;
    int s;
    unsigned char c = '\n';

    while (!feof(read_fp))
    {
        s = fgetc(read_fp);

        if (s != '\n') {
            fwrite(&s, sizeof(unsigned char), 1, fp);
            count++;
        }

        if (count == 3840) {
            count = 0;
            fwrite(&c, sizeof(unsigned char), 1, fp);
        }
    }
}


int main(int argc, char **argv)
{
    if (1 == system_init(argv[1])) {
        return 1;
    }

    file_generate();
    fclose(fp);
    // fclose(read_fp);

    return 0;
}
