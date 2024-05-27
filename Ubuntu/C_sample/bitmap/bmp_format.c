/**----------------------------------------------------------
 * Create  2022/12/15
 * Author  kimura
 * -
 * BMP の白一色画像を生成するプログラム
 * BMP のヘッダ情報が正しいか確認するために作った
 * 
 * http://www.awm.jp/~yoya/cache/www.umekkii.jp/data/computer/file_format/bitmap.cgi
 * https://www.setsuki.com/hsp/ext/bmp.htm
 * https://www.mm2d.net/main/prog/c/image_io-05.html
 *--------------------------------------------------------*/
#include <stdio.h>
#include <stdint.h>


//-----------------------------------------------------------------------------
// BMP info
//-----------------------------------------------------------------------------
#define BMP_FILE_WIDTH			(20)		// 必ず4の倍数
#define BMP_FILE_HEIGHT			(20)		// 必ず4の倍数
#define BMP_FORMAT				(3)			// ARGBの場合4, RGBの場合3
#define BMP_FILE_TYPE			(0x4d42)	// リトルエンディアンで解釈
#define BMP_FILE_HEADER_SIZE	(14)
#define BMP_INFO_HEADER_SIZE	(40)
#define BMP_TOTAL_HEADER_SIZE	(BMP_FILE_HEADER_SIZE + BMP_INFO_HEADER_SIZE)


/**----------------------------------------------------------
 * BMP Header struct
 * pragma pack 指定で 2byte区切りで構造体を扱う変更にする
 * 末尾の pragme pach() 引数なしで アライメント設定を元に戻す 
 * 
 * OS によるがデフォルトで 4Byte 区切りのため,fwrite,read で
 * 2byte データを取り扱う場合、空きバイトに 0詰めしてしまう
 *---------------------------------------------------------*/
#pragma pack(2)
typedef struct bmp_header {
	// File Header
	uint16_t bf_type;				// "BM"
	uint32_t bf_size;				// file size
	uint16_t bf_reserved1;			// 常に 0
	uint16_t bf_reserved2;			// 常に 0
	uint32_t bf_offbits;			// ファイル先頭から画像データまでのオフセット[byte]
	// Infomation Header
	uint32_t bi_size;				// 情報ヘッダサイズ 40
	int32_t  bi_width;				// 画像の幅
	int32_t  bi_height;				// 画像の高さ,正数なら画像は下から上へ、負数なら上から下へ
	uint16_t bi_planes;				// プレーン数 常に1
	uint16_t bi_bitcount;			// 色bit深度 1,4,8,16,24,32, 256色bitmapなら8
	uint32_t bi_compression;		// 圧縮形式 0,1,2,3, 0で無圧縮 RGB
	uint32_t bi_sizeimage;			// 画像データサイズ
	int32_t  bi_x_permeter;			// 水平解像度[dot/m]
	int32_t  bi_y_permeter;			// 垂直解像度[dot/m]
	uint32_t bi_clrused;			// 格納パレット数[使用色数]
	uint32_t bi_cirlmportant;		// 重要色数
} BmpHeader;
#pragma pack()

/**----------------------------------------------------------
 * BMP Header 情報の設定
 *---------------------------------------------------------*/
BmpHeader bmp_header_set(void)
{
	BmpHeader bmp_header;

	bmp_header.bf_type				= 0x4d42; // "BM"固定
	bmp_header.bf_size				= BMP_FILE_WIDTH * BMP_FILE_HEIGHT * BMP_FORMAT + BMP_TOTAL_HEADER_SIZE;
	bmp_header.bf_reserved1			= 0;
	bmp_header.bf_reserved2			= 0;
	bmp_header.bf_offbits			= 54;
	bmp_header.bi_size				= 40;
	bmp_header.bi_width				= BMP_FILE_WIDTH;
	bmp_header.bi_height			= BMP_FILE_HEIGHT;
	bmp_header.bi_planes			= 1;
	bmp_header.bi_bitcount			= 24;
	bmp_header.bi_compression		= 0;	// RGB 無圧縮では 0 ,ピクセルフォーマット RGB 無圧縮
	bmp_header.bi_sizeimage			= BMP_FILE_WIDTH * BMP_FILE_HEIGHT * BMP_FORMAT;	// example, 200 * 150 * RGB(3bit) = 90000
	bmp_header.bi_x_permeter		= 0;	// RGB 無圧縮では 0
	bmp_header.bi_y_permeter		= 0;	// RGB 無圧縮では 0
	bmp_header.bi_clrused			= 0;	// 0で無制限
	bmp_header.bi_cirlmportant		= 0;	// 0で無制限

	return bmp_header;
}


/**----------------------------------------------------------
 * サンプル BMPファイルの info を読み取り表示
 *---------------------------------------------------------*/
int bmp_info_read(void)
{
	FILE *fp = NULL;
	BmpHeader bmp_header;

	fp = fopen("./s_bmp/win-24.bmp", "rb");

	if (fp == NULL) {
		printf("file opwn error\r\n");
		return 1;
	}

	fread(&bmp_header, sizeof(BmpHeader), 1, fp);
	fclose(fp);

	printf("ファイルタイプ %x\r\n", bmp_header.bf_type);
	printf("ファイルサイズ %d\r\n", bmp_header.bf_size);
	printf("予約領域0 %d\r\n", bmp_header.bf_reserved1);
	printf("予約領域1 %d\r\n", bmp_header.bf_reserved2);
	printf("画像データまでのオフセット %d\r\n", bmp_header.bf_offbits);
	printf("ヘッダサイズ %d\r\n", bmp_header.bi_size);
	printf("画像の幅 %d\r\n", bmp_header.bi_width);
	printf("画像の高さ %d\r\n", bmp_header.bi_height);
	printf("プレーン数 %d\r\n", bmp_header.bi_planes);
	printf("1画素あたりのデータサイズ %d\r\n", bmp_header.bi_bitcount);
	printf("圧縮形式 %d\r\n", bmp_header.bi_compression);
	printf("画像データ部のサイズ %d\r\n", bmp_header.bi_sizeimage);
	printf("横方向解像度 %d\r\n", bmp_header.bi_x_permeter);
	printf("縦方向解像度 %d\r\n", bmp_header.bi_y_permeter);
	printf("パレット数 %d\r\n", bmp_header.bi_clrused);
	printf("重要パレット数 %d\r\n", bmp_header.bi_cirlmportant);

	return 0;
}


/**----------------------------------------------------------
 * BMP は 24bitの場合 B,G,R,B,G,R の順
 * BMP は 32bitの場合 B,G,R,A,B,G,R,A の順
 *---------------------------------------------------------*/
int main(void)
{
	//
	FILE *fp = NULL;
	BmpHeader bmp_header = bmp_header_set();
	uint8_t bmp_data_buff[BMP_FILE_HEIGHT*BMP_FILE_WIDTH*BMP_FORMAT];

	bmp_info_read();
	fp = fopen("sample.bmp", "wb");

	if (fp == NULL) {
		printf("file opwn error\r\n");
		return 1;
	}

	for (uint16_t i = 0; i < (BMP_FILE_HEIGHT*BMP_FILE_WIDTH*BMP_FORMAT); i++) {
		bmp_data_buff[i] = 0xff;
	}

	fwrite(&bmp_header, sizeof(BmpHeader), 1, fp);	// Header 情報書き込み
	fwrite(bmp_data_buff, 1, sizeof(bmp_data_buff)/sizeof(bmp_data_buff[0]), fp);	// データ部書き込み

	fclose(fp);
	printf("file close end\r\n");

	return 0;
}