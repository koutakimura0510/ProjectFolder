/**-------------------------------------------------
 * Ubuntu LTS 20.04 kimura
 * 
 * Midiファイルを解析し、音源データ部分のみ抽出するプログラム
 * プログラム実行時の引数にMidiファイルまでのパスを入力し、指定したファイル名に落とし込む
 *
 * -------------------------------------------------*/


/**-------------------------------------------------
 * インクルードファイル
 * -------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <ctype.h>


/**-------------------------------------------------
 * 配列帳取得マクロ
 * -------------------------------------------------*/
#define NUM(ary) (sizeof(ary)/sizeof(ary[0]))


/**-------------------------------------------------
 * 固定少数
 * -------------------------------------------------*/
#define XP 10000


/**---------------------------------------------------
 * 文字コード変換用定数
 *----------------------------------------------------*/
typedef enum {
	ISSPACE,//!< ISSPACE
	ISALPHA,//!< ISALPHA
	ISDIGIT,//!< ISDIGIT
	ISNON,  //!< ISNON
} T_ISASCII;


typedef enum {
	DELTA,
	CH,
	TONE,
	VELOCITY,
	DIVISION,
	TEMP,
	NON_STATUS,
} T_STATUS;


typedef struct {
	int32_t division;
	int32_t temp;
	int32_t delta;
	int32_t ch;
	int32_t tone;
	int32_t velocity;
} t_midi;

static t_midi midi;

/**-------------------------------------------------
 * グローバル変数
 * -------------------------------------------------*/
FILE *rp;		//MIDIファイル読み込み用ポインタ
FILE *delta_fp;	
FILE *ch_fp;	
FILE *tone_fp;	
FILE *velo_fp;
static uint32_t length = 0;


/**-------------------------------------------------
 * ファイル操作関数
 * -------------------------------------------------*/
static void file_read(void);
static void midi_fwrite(void);
static void new_line(void);
static void get_status(uint8_t status);


/**-------------------------------------------------
 * 文字列検索関数
 * -------------------------------------------------*/
static uint8_t get_ascii_type(char *msg);
static void division_search(char s);
static void temp_search(char s);
static void delta_search(char s);


/**-------------------------------------------------
 * 計算処理
 * -------------------------------------------------*/
static uint32_t delta_odp(double d, double division, double temp);



/**--------------------------------------------------------
 * ASCII文字の種類を識別しコードを返す
 * --------------------------------------------------------
 * msg		: 識別を行う文字列コードアドレスを指定
 * ---------
 * return	: 識別コードを取得
 *---------------------------------------------------------*/
static uint8_t get_ascii_type(char *msg)
{
	if (isspace(*msg)) {
		return ISSPACE;	//空白文字処理
	}

	if (isalpha(*msg)) {
		return ISALPHA;	//英字処理
	}

	if (isdigit(*msg)) {
		return ISDIGIT;	//英数字処理
	}

	return ISNON;
}


/**-------------------------------------------------
 * division検索
 * -------------------------------------------------*/
static void division_search(char s)
{
	static uint8_t n = 0;
	char str[] = "DIV";

	if (s == str[n]) {
		n++;
	}else{
		n = 0;
	}

	if (n == (NUM(str) - 1)) {
		get_status(DIVISION);
		n = 0;
		printf("division\n");
	}
}


/**-------------------------------------------------
 * Temp検索
 * -------------------------------------------------*/
static void temp_search(char s)
{
	static uint8_t n = 0;
	char str[] = "Temp";

	if (s == str[n]) {
		n++;
	}else{
		n = 0;
	}

	if (n == (NUM(str) - 1)) {
		get_status(TEMP);
		n = 0;
	}
}


/**-------------------------------------------------
 * Delta検索
 * Note On Offのステータスならば音源データをファイルに書き込む
 * -------------------------------------------------
 * s	: 文字コードを指定
 * -------------------------------------------------*/
static void delta_search(char s)
{
	static uint8_t n = 0;
	char str[] = "DELTA";
	t_midi *p = &midi;

	if (s == str[n]) {
		n++;
	}else{
		n = 0;
	}

	if (n == (NUM(str) - 1)) {
		get_status(DELTA);
		get_status(CH);

		if (p->ch != 0) {	//音源データ書き込み
			get_status(TONE);
			get_status(VELOCITY);
			midi_fwrite();
			length++;
		} else if (p->delta != 0) {	//コントロールチェンジデルタタイム書き込み
			p->ch = 0;
			p->tone = 0;
			p->velocity = 0;
			midi_fwrite();
			length++;
		}
		n = 0;
	}
}


/**-------------------------------------------------
 * ファイルから読み込んだデータをMIDI構造体に書き込む
 * -------------------------------------------------*/
static void get_status(uint8_t status)
{
	t_midi *p = &midi;
	int32_t *wdata;
	char s;

	switch (status) {
		case DELTA:
			wdata = &p->delta;
			break;
		
		case CH:
			wdata = &p->ch;
			break;
		
		case TONE:
			wdata = &p->tone;
			break;
		
		case VELOCITY:
			wdata = &p->velocity;
			break;

		case DIVISION:
			wdata = &p->division;
			break;

		case TEMP:
			wdata = &p->temp;
			break;
	}

	*wdata = 0;

	while (1) {
		fread(&s, sizeof(char), 1, rp);
		if (ISDIGIT == get_ascii_type(&s)) {
			*wdata *= 10;
			*wdata += (s - '0');
		}else{
			break;
		}
	}

	if (status == DIVISION) {
		printf("%6d \n", *wdata);
	}

	if (status == TEMP) {
		printf("%6d \n", *wdata);
	}
}

/**-------------------------------------------------
 * ファイルデータ読み込み
 * -------------------------------------------------*/
static void file_read(void)
{
	char s;
	int32_t ret;

	while (1) {
		fread(&s, sizeof(char), 1, rp);
		division_search(s);
		temp_search(s);
		delta_search(s);
		ret = feof(rp);

		if (ret != 0) {
			break;
		}
	}

	printf("length = %5d\n", length);

	if (ret != 0) {
		printf("ファイルはEOFです/n");
	}else{
		printf("ファイルはEOFではありません/n");
	}
}


/**-------------------------------------------------
 * MIDIステータス書き込み
 * -------------------------------------------------*/
static void midi_fwrite(void)
{
	t_midi *p = &midi;

	p->delta = delta_odp(p->delta, p->division, p->temp);
	fprintf(delta_fp,	"%4d, ", p->delta);
	fprintf(ch_fp,		"%d, ", p->ch);
	fprintf(tone_fp,	"%3d, ", p->tone);
	fprintf(velo_fp,	"%3d, ", p->velocity);
	new_line();
}


/**-------------------------------------------------
 * 改行文字挿入
 * -------------------------------------------------*/
static void new_line(void)
{
	static uint8_t n = 0;

	n++;

	if (n == 40) {
		fprintf(delta_fp,	"\n    ");
		fprintf(ch_fp,		"\n    ");
		fprintf(tone_fp,	"\n    ");
		fprintf(velo_fp,	"\n    ");
		n = 0;
	}
}


/**-------------------------------------------------
 * デルタタイム計算
 * -------------------------------------------------
 * d	: デルタタイムを指定
 * -------------------------------------------------*/
static uint32_t delta_odp(double d, double division, double temp)
{
	d *= XP;
	d = (d / division) * (temp / 1000);
	d = (d / XP);

	return d;
}



/**------------------------------------------------------------------------------
 * main関数
 * ------------------------------------------------------------------------------*/
int main(int argc, char **argv)
{
	static const char *status_buffer[] = {
		"delta[] = {\n    ",
		"ch[] = {\n    ",
		"tone[] = {\n    ",
		"velocity[] = {\n    ",
		"\n",
	};

	uint8_t fopen_eoc = 0;
	char s[128];
	char **statuspath = (char **)status_buffer;

	/**-----------------------------------------------------------------------------
	 * ファイル操作処理 
	 * -----------------------------------------------------------------------------*/
	if (!argv[1]) {
		fprintf(stderr, " ERROR: 引数が入力されていません \r\n");
		return 1;
	}

	rp = fopen(argv[1], "r");
	delta_fp = fopen("../txtbuffer/delta.txt",		"w");
	ch_fp    = fopen("../txtbuffer/ch.txt",			"w");
	tone_fp  = fopen("../txtbuffer/tone.txt",		"w");
	velo_fp  = fopen("../txtbuffer/velocity.txt",	"w");

	if (rp == NULL) {
		fprintf(stderr, "  Midiファイルのパスが正しくありません --- Not File Path %s\r\n", argv[1]);
		fopen_eoc = 1;
	}

	if (delta_fp == NULL) {
		fprintf(stderr, "  ファイルが開けません、パスか名前を確認してください delta.txt\r\n");
		fopen_eoc = 1;
	}

	if (ch_fp == NULL) {
		fprintf(stderr, "  ファイルが開けません、パスか名前を確認してください ch.txt\r\n");
		fopen_eoc = 1;
	}

	if (tone_fp == NULL) {
		fprintf(stderr, "  ファイルが開けません、パスか名前を確認してください tone.txt\r\n");
		fopen_eoc = 1;
	}

	if (velo_fp == NULL) {
		fprintf(stderr, "  ファイルが開けません、パスか名前を確認してください velocity.txt\r\n");
		fopen_eoc = 1;
	}

	if (fopen_eoc == 1) {
		fclose(rp);
		fclose(delta_fp);
		fclose(ch_fp);
		fclose(tone_fp);
		fclose(velo_fp);

		return 1;
	}

	printf("作成する配列名を入力してください === ");
	scanf("%s", s);

	/**------------------------------------------------------------
	 * MIDIデータ、ファイル書き込み処理
	 * ------------------------------------------------------------*/

	fprintf(delta_fp,	"static const uint16_t %s_%s" , s, statuspath[DELTA]);
	fprintf(ch_fp,		"static const uint8_t %s_%s"  , s, statuspath[CH]);
	fprintf(tone_fp,	"static const uint8_t %s_%s"  , s, statuspath[TONE]);
	fprintf(velo_fp,	"static const uint8_t %s_%s"  , s, statuspath[VELOCITY]);

	file_read();

	fprintf(delta_fp,	"\n};\n");
	fprintf(ch_fp,		"\n};\n");
	fprintf(tone_fp,	"\n};\n");
	fprintf(velo_fp,	"\n};\n");

	fclose(rp);
	fclose(delta_fp);
	fclose(ch_fp);
	fclose(tone_fp);
	fclose(velo_fp);

	return 0;
}
