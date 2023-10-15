/**-----------------------------------------------------------------------------
 * Create  2023/10/01
 * Author  kouta kimura
 * -
 * RAW ファイルを xxd コマンドを使用してダンプする
 * RAW ファイルは 16bit signed を想定している
 * 
 * プログラム自体は2020年辺りに作成したもので、コメントが一切記載されてなかったので記載
 * output ディレクトリには xxd コマンドでダンプしたファイルが出力される。
 * sdfile には ダンプ出力したファイルを FILE_LINE_BYTE_NUMBER の数値分 1行にまとめたファイルが出力される。
 * SDカード接続の マイコン等で読み込む場合は、RAMに制限があるので2048 など小さい数値を指定する。
 * OS で使う場合は大きくても問題ない
 * 
 * 2023/10/01 new release
 * 
 *-----------------------------------------------------------------------------*/

/**-----------------------------------------------------------------------------
 * Include File
 *-----------------------------------------------------------------------------*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>


/**-----------------------------------------------------------------------------
 * define
 *-----------------------------------------------------------------------------*/
#define FILE_LINE_BYTE_NUMBER (4096)


/**-----------------------------------------------------------------------------
 * 関数宣言
 *-----------------------------------------------------------------------------*/
static void error_fprintf(const char *s, int line);
static void get_filename(char *path, char *filename);
static void xxd_cmd(char *file, char *filename);
static void file_generate(void);
static int system_init(char *path);

/**-----------------------------------------------------------------------------
 * FILE ptr
 *-----------------------------------------------------------------------------*/
FILE *fp;
FILE *read_fp;


/**-----------------------------------------------------------------------------
 * エラー発生時のターミナル表示関数
 *-----------------------------------------------------------------------------*/
static void error_fprintf(const char *s, int line)
{
	fprintf(stderr, "[Line] = %d\n", line);
	fprintf(stderr, "[func] = %s\n", s);
}


/**-----------------------------------------------------------------------------
 * ディレクトリのパスとファイル名を取得
 * 
 * *path = ダンプを行う raw ファイルパスを入力する, 例: raw/battle/hogehoge.raw
 * *filename = 出力先のファイル名をコピー 例: battle/hogehoge.raw
 *-----------------------------------------------------------------------------*/
static void get_filename(char *path, char *filename)
{
	uint32_t count = 0;
    uint32_t n = 0;

	// .raw 拡張子までアドレスを進める
	do {
		path++;
		if (*path == '/') {
			n++;
		}
	} while (*path != '.');

	// path アドレスが拡張子まで進んでいるので、
	// ファイル名の開始までアドレスを戻す
	for (int i = 0; i < n; i++) {
		do {
			path--;
		} while (*path != '/');
	}

	// ファイル名のコピー
	path++;
	while (path[count] != '\0')
	{
		filename[count] = path[count];
		count++;
	}
}


/**-----------------------------------------------------------------------------
 * rawファイルをxxdコマンドでダンプ
 *
 * リダイレクトコマンドはファイルに追加動作をしてしまうため
 * 既存のファイルを消去してから出力を行う
 * 
 * *path = ダンプを行う raw ファイルパスを入力する, 例: raw/battle/hogehoge.raw
 * *filename = 出力のファイル名 例: hogehoge.raw
 *-----------------------------------------------------------------------------*/
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

/**-----------------------------------------------------------------------------
 * ファイル生成
 *-----------------------------------------------------------------------------*/
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

        if (count == FILE_LINE_BYTE_NUMBER) {
            count = 0;
            fwrite(&c, sizeof(unsigned char), 1, fp);
        }
    }
}


/**-----------------------------------------------------------------------------
 * 初期設定関数 
 *-----------------------------------------------------------------------------*/
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
	fp = fopen(dir_path, "wr");

	if (fp == NULL) {
		fprintf(stderr, "File Open error\n");
		printf("%s\n", dir_path);
		error_fprintf(__func__, __LINE__);
		return 1;
	}

	fprintf(stderr, "ファイルを生成します = %s\n", dir_path);
	fprintf(stderr, "\n");

	// File コピーして配置整列
	file_generate();

	// ファイルの末尾文字を削除
    fseek(fp, -1, SEEK_END);
    ftruncate(fileno(fp), ftell(fp));
	fclose(fp);

	return 0;
}


/**-----------------------------------------------------------------------------
 * main 関数
 *-----------------------------------------------------------------------------*/
int main(int argc, char **argv)
{
    if (1 == system_init(argv[1])) {
        return 1;
    }

    // file_generate();
    // fclose(fp);
    // fclose(read_fp);

    return 0;
}
