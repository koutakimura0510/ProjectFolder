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
	PROGRAM_CHANGE,
	TONENO,
} T_STATUS;

typedef enum {
	Piano,
	Percussion,
	Organ,
	Guitar,
	Bass,
	Strings,
	Ensamble,
	Brass,
	Sax,
	Pipe,
	SyntheSax,
	SynthePad,
	SyntheEffect,
	Ethnic,
	Percussive,
	SoundEffect,
} MUSICAL_TYPE;

typedef struct {
	uint8_t id;
	uint8_t start;
	uint8_t end;
} t_database;

static const t_database database[] = {
	{Piano,			0,		7  },
	{Percussion,	8,		15 },
	{Organ,			16,		23 },
	{Guitar,		24,		31 },
	{Bass,			32,		39 },
	{Strings,		40,		47 },
	{Ensamble,		48,		55 },
	{Brass,			56,		63 },
	{Sax,			64,		71 },
	{Pipe,			72,		79 },
	{SyntheSax,		80,		87 },
	{SynthePad,		88,		95 },
	{SyntheEffect,	96,		103},
	{Ethnic,		104,	111},
	{Percussive,	112,	119},
	{SoundEffect,	120,	127},
};

typedef struct {
	int32_t program_change;
	int32_t musical;
} t_midi;
static t_midi midi;


static const char *status[] = {
	"Piano, ",
	"Percussion, ",
	"Organ, ",
	"Guitar, ",
	"Bass, ",
	"Strings, ",
	"Ensamble, ",
	"Brass, ",
	"Sax, ",
	"Pipe, ",
	"SyntheSax, ",
	"SynthePad, ",
	"SyntheEffect, ",
	"Ethnic, ",
	"Percussive, ",
	"SoundEffect, ",
	"\n"
};


/**-------------------------------------------------
 * グローバル変数
 * -------------------------------------------------*/
FILE *rp;		// MIDIファイル読み込み用ポインタ
FILE *pc_fp;	// プログラムチェンジポインタ	
FILE *tn_fp;	// 楽器番号取得
static uint32_t length = 0;


/**-------------------------------------------------
 * ファイル操作関数
 * -------------------------------------------------*/
static void file_read(void);
static void midi_fwrite(void);
static void get_status(uint8_t status);


/**-------------------------------------------------
 * 文字列検索関数
 * -------------------------------------------------*/
static uint8_t get_ascii_type(char *msg);
static void program_change_search(char s);
static void tone_no_search(char s);



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
 * プログラムチェンジ検索
 * -------------------------------------------------*/
static void program_change_search(char s)
{
	static uint8_t n = 0;
	char str[] = "Program Change [";

	if (s == str[n]) {
		n++;
	}else{
		n = 0;
	}

	if (n == (NUM(str) - 1)) {
		get_status(PROGRAM_CHANGE);
		n = 0;
	}
}


/**-------------------------------------------------
 * プログラムチェンジ検索
 * -------------------------------------------------*/
static void tone_no_search(char s)
{
	static uint8_t n = 0;
	char str[] = "ToneNo / ";

	if (s == str[n]) {
		n++;
	}else{
		n = 0;
	}

	if (n == (NUM(str) - 1)) {
		get_status(TONENO);
		midi_fwrite();
		length++;
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
		case PROGRAM_CHANGE:
			wdata = &p->program_change;
			break;
		
		case TONENO:
			wdata = &p->musical;
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

	if (status == PROGRAM_CHANGE) {
		printf("ch = %2d \n", *wdata);
	}

	if (status == TONENO) {
		printf("musical = %3d \n", *wdata);
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
		program_change_search(s);
		tone_no_search(s);
		ret = feof(rp);

		if (ret != 0) {
			break;
		}
	}

	printf("length = %2d\n", length);

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
	const t_database *dp = database;
	t_midi *p = &midi;
	uint8_t m = p->musical - 1;
	uint8_t pos;
	char **s = (char **)status;

	for (uint8_t i = 0; i < 16; i++, dp++) {
		if ((dp->start <= m) && (dp->end >= m)) {
			pos = i;
			break;
		}
	}
	fprintf(tn_fp, "%s", s[pos]);
	fprintf(pc_fp, "%2d, ", p->program_change);
}



/**------------------------------------------------------------------------------
 * main関数
 * ------------------------------------------------------------------------------*/
int main(int argc, char **argv)
{
	static const char *status_buffer[] = {
		"program_change[] = {\n    ",
		"musical[] = {\n    ",
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
	pc_fp = fopen("../txtbuffer/program_change.txt", "w");
	tn_fp    = fopen("../txtbuffer/ToneNo.txt", "w");

	if (rp == NULL) {
		fprintf(stderr, "  Midiファイルのパスが正しくありません --- Not File Path %s\r\n", argv[1]);
		fopen_eoc = 1;
	}

	if (pc_fp == NULL) {
		fprintf(stderr, "  ファイルが開けません、パスか名前を確認してください pc.txt\r\n");
		fopen_eoc = 1;
	}

	if (tn_fp == NULL) {
		fprintf(stderr, "  ファイルが開けません、パスか名前を確認してください tn.txt\r\n");
		fopen_eoc = 1;
	}

	if (fopen_eoc == 1) {
		fclose(rp);
		fclose(pc_fp);
		fclose(tn_fp);

		return 1;
	}

	printf("作成する配列名を入力してください === ");
	scanf("%s", s);

	/**------------------------------------------------------------
	 * MIDIデータ、ファイル書き込み処理
	 * ------------------------------------------------------------*/

	fprintf(pc_fp, "static const uint8_t %s_%s" , s, statuspath[PROGRAM_CHANGE]);
	fprintf(tn_fp, "static const uint8_t %s_%s"  , s, statuspath[TONENO]);

	file_read();

	fprintf(pc_fp, "\n};\n");
	fprintf(tn_fp, "\n};\n");

	fclose(rp);
	fclose(pc_fp);
	fclose(tn_fp);

	return 0;
}
