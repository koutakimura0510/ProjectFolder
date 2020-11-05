/**-------------------------------------------------
 * ファイル操作サンプルプログラム
 * リソース管理ライブラリを作成し、リソースリークを
 * 起こしにくくするよう設計した。
 * 定型処理はライブラリに任せつつ、変化する処理を
 * 関数ポインタで外出しにし、変更を可能にした。
 * -------------------------------------------------
 * Ubuntu LTS 20.04 kimura
 * -------------------------------------------------*/


/**-------------------------------------------------
 * includeファイル
 * -------------------------------------------------*/
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>
#include "../include/LIB.H"
#include "../include/FILE.H"


/**-------------------------------------------------
 * パラメータ定数
 * -------------------------------------------------*/
#define MAX_DIGIT 	8	//保存データの最大桁数
#define ROM_BUFFER	32	//ROM容量


/**-------------------------------------------------
 * ファイルパーティション管理
 * -------------------------------------------------*/
#define SIREAD  	0x0100
#define SIWRITE 	0x0080


/**-------------------------------------------------
 * 書き込みリソース管理構造体
 * -------------------------------------------------
 * pname    	| アクセスするファイル名
 * pmode		| アクセスするモード
 * open_error	| openエラー人時に呼び出す処理
 * process		| ファイルが開かれている間に実行する処理
 * access_error | processの処理で失敗時に呼び出す処理
 * close_error	| ファイルのclose失敗時に呼び出す処理
 * pdata		| アプリケーションで自由に使用できるデータ
 * -------------------------------------------------*/
typedef struct t_file_access{
	const char *pname;
	const char *pmode;
	void (*open_error)(struct t_file_access *pthis, int32_t err_no);
	bool (*process)(struct t_file_access *pthis, FILE *fp);
	void (*access_error)(struct t_file_access *pthis, int32_t err_no);
	void (*close_error)(struct t_file_access *pthis, int32_t err_no);
	void *pdata;
} t_file_access;


/**-------------------------------------------------
 * ファイル内グローバル変数
 * -------------------------------------------------*/
static uint32_t savefile[ROM_BUFFER];
static const char filename[] = "../savedata/sd.dat";
static char wbuffer[MAX_DIGIT+1];	//指定桁数+改行文字


/**-------------------------------------------------
 * ファイル内関数
 * -------------------------------------------------*/
static void open_err(t_file_access *pthis, int32_t err_no);
static void close_err(t_file_access *pthis, int32_t err_no);
static void access_err(t_file_access *pthis, int32_t err_no);
//static bool file_chmod(char rw);
static bool file_write(t_file_access *p, FILE *fp);
static void *accessfile(t_file_access *p);


/**-------------------------------------------------
 * ファイル操作関数呼び出し
 * -------------------------------------------------*/
void savewrite(void)
{
	accessfile(&(t_file_access) {
		.pname = filename,
		.pmode = "w",
		.process = file_write,
		.pdata = wbuffer,
	});
}


/**-------------------------------------------------
 * セーブデータ読み込み
 * プログラム開始時に全データ読み込み
 * ファイル内はasciiコードを10進数に変換して配列に格納
 * -------------------------------------------------*/
bool file_read(void)
{
	FILE *fp;
	uint32_t *p;	//配列参照用ポインタ
	int32_t c;		//ファイルデータ保持用

//	file_chmod('r');
	fp = fopen(filename, "r");

	if (fp == NULL) {
		printf("File read open error\r\n");
		return false;
	}

	p = &savefile[0];

	while ((c = fgetc(fp)) != EOF) {
		if (c == '\n') {
			p++;
		}else{
			*p = ((*p * 10) + (c - '0'));
		}
	}

	fclose(fp);

	return true;
}


/**-------------------------------------------------
 * ファイル操作処理関数
 * -------------------------------------------------
 * arg1:ファイル操作用構造体のポインタ
 * -------------------------------------------------
 * (1)	指定されたファイル名・モードでオープンする
 * (2)	openエラー時、openerrorメンバが設定されていれば
 * 		その処理を行う。なければエラー関数処理を行う
 *
 * (3)	processメンバに指定された関数を呼び出す
 * 		失敗した場合は、失敗処理を呼び出す。
 *
 * (4)	最後は必ずclose処理を行う
 * -------------------------------------------------*/
static void *accessfile(t_file_access *p)
{
	FILE *fp = fopen(p->pname, p->pmode);
	uint32_t div, r, wdata;	//書き込みデータ生成用変数


	if (!fp) {
		(p->open_error ? p->open_error : open_err)(p, errno);
		return p->pdata;
	}

	for (uint32_t i = 0; i < ROM_BUFFER; i++) {
		wdata = savefile[i];
		for (uint8_t j = MAX_DIGIT; j > 0; j--) {	//ASCIIコード変換処理
			div = wdata;
			wdata /= 10;
			r = div - ((wdata << 3) + (wdata << 1));
			wbuffer[j-1] = r + '0';
		}
		wbuffer[MAX_DIGIT] = '\n';
		if (!p->process(p, fp)) {
			(p->access_error ? p->access_error : access_err)(p, errno);
			break;
		}
	}

	if (fclose(fp) == EOF) {
		(p->close_error ? p->close_error : close_err)(p, errno);
	}

	return p->pdata;

}


/**-------------------------------------------------
 * openエラー処理
 * -------------------------------------------------
 * arg1:ファイル操作用構造体のポインタ
 * arg2:エラー処理
 * -------------------------------------------------*/
static void open_err(t_file_access *pthis, int32_t err_no)
{
	fprintf(stderr, "Cannot open file '%s' in mode '%s': %s\n",
			pthis->pname, pthis->pmode, strerror(err_no));
}


/**-------------------------------------------------
 * closeエラー処理
 * -------------------------------------------------
 * arg1:ファイル操作用構造体のポインタ
 * arg2:エラー処理
 * -------------------------------------------------*/
static void close_err(t_file_access *pthis, int32_t err_no)
{
	fprintf(stderr, "Cannot close file '%s' in mode '%s': %s\n",
			pthis->pname, pthis->pmode, strerror(err_no));
}


/**-------------------------------------------------
 * アクセスエラー処理
 * -------------------------------------------------
 * arg1:ファイル操作用構造体のポインタ
 * arg2:エラー処理
 * -------------------------------------------------*/
static void access_err(t_file_access *pthis, int32_t err_no)
{
	fprintf(stderr, "Cannot access file '%s' in mode '%s': %s\n",
			pthis->pname, pthis->pmode, strerror(err_no));
}


/**-------------------------------------------------
 * 構造体のpdataメンバのデータをテキストとみなして
 * ファイルに書き込む関数
 * -------------------------------------------------
 * arg1:ファイル操作用構造体のポインタ
 * arg2:ファイルポインタ
 * -------------------------------------------------*/
static bool file_write(t_file_access *p, FILE *fp)
{
	return fputs((const char *)p->pdata, fp) != EOF;
}



/**-------------------------------------------------
 * ファイルの実行権限操作
 * -------------------------------------------------*/
/*static bool file_chmod(char rw)
{
	int rc;

	if (rw == 'r') {
		rc = chmod(filename, SIREAD);
		printf("%d\r\n", SIREAD);
	}

	else if (rw == 'w') {
		rc = chmod(filename, SIWRITE);
		printf("%d\r\n", SIWRITE);
	}

	if (rc != 0) {
		return false;
	}

	return true;
}
*/
