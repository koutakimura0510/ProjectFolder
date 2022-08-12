/*
 * ファイル操作をまとめたファイル
 */
#include "../include/MYLIB.H"
#include <stdlib.h>

#define FILL_FBUFFER

/* ファイル内関数 */
static bool bin_read(MapchipWork *chip, uint32_t *buffer, char *filename);
static bool raw_write(MapchipWork *chip, uint32_t *buffer, char *filename);
static bool bin_write(MapchipWork *chip, uint32_t *buffer, char *filename);



/*
 * フレームバッファのデータをファイルに書き込む
 * 誤動作対策のため、キー入力を二回行った時に書き込む用に変更
 */
bool mapf_write(MapchipWork *chip)
{
	static uint8_t key_count = 0;

	if (key_count == 1)
	{
		raw_write(chip, chip->fbuf_map, chip->raw_map);
		raw_write(chip, chip->fbuf_obj, chip->raw_obj);
		raw_write(chip, chip->fbuf_reg, chip->raw_reg);
		raw_write(chip, chip->fbuf_npc, chip->raw_npc);
		bin_write(chip, chip->fbuf_map, chip->bin_map);
		bin_write(chip, chip->fbuf_obj, chip->bin_obj);
		bin_write(chip, chip->fbuf_reg, chip->bin_reg);
		bin_write(chip, chip->fbuf_npc, chip->bin_npc);
		key_count = 0;
	}
	else
	{
		key_count++;
	}

	return true;
}


/*
 * バイナリファイルのデータをフレームバッファに読み込む
 * 誤動作対策のため、キー入力を二回行った時に読み込むように変更
 */
bool mapf_read(MapchipWork *chip)
{
	static uint8_t read_count = 0;

	if (read_count == 1)
	{
		bin_read(chip, chip->fbuf_map, chip->bin_map);
		bin_read(chip, chip->fbuf_obj, chip->bin_obj);
		bin_read(chip, chip->fbuf_reg, chip->bin_reg);
		bin_read(chip, chip->fbuf_npc, chip->bin_npc);
		read_count = 0;
	}
	else
	{
		read_count++;
	}

#ifdef FILL_FBUFFER	/*　読み込み時に指定のマップチップを塗りつぶす場合に使用 */
	static const uint32_t old[] = {
		0,
	};

	static const uint32_t new[] = {
		167,
	};
	for (uint32_t i = 0; i < chip->xsize; i++)
	{
		for (uint32_t j = 0; j < chip->xsize; j++)
		{
			uint32_t pos = i + (j * chip->xsize);
			for (uint32_t n = 0; n < NUM(old); n++)
			{
				if (chip->fbuf_map[pos] == old[n]) {
					// printf("%d\n", chip->fbuf_map[pos]);
					chip->fbuf_map[pos] = new[n];
				}
			}
		}
	}
#endif

	return true;
}


/**
 * @brief  フレームバッファにbinファイルのデータを読み込み
 * @note   
 * @param  *chip: 
 * @param  *buffer: フレームバッファのアドレスを指定
 * @param  *filename: パスを含んだファイル名を指定
 * @retval 書き込み完了ならばtrue
 */
static bool bin_read(MapchipWork *chip, uint32_t *buffer, char *filename)
{
	FILE *fp = NULL;
	uint32_t mapsize = chip->xsize * chip->ysize;

	fp = fopen(filename, "rb");

	if (fp == NULL) {
		printf("file read error %s\n", filename);
		printf("ファイルが存在しないため空のファイルを作成します %s\n", filename);
		bin_write(chip, buffer, filename);
		return false;
	}

	fread(buffer, sizeof(uint32_t), mapsize, fp);
	terminal_str("マップ読み込み完了", filename);
	fclose(fp);

	return true;
}

/**
 * @brief  rawファイルの書き出し処理
 * @note   
 * @param  *chip: 
 * @param  *buffer: 書き出しデータが保存されているフレームバッファのアドレスを指定
 * @param  *filename: パスを含んだファイル名を指定
 * @retval 書き込み完了ならばtrue
 */
static bool raw_write(MapchipWork *chip, uint32_t *buffer, char *filename)
{
	FILE *fp = NULL;
	uint32_t mapsize = chip->xsize * chip->ysize;
	uint32_t line = 0;

	terminal_str("マップを作成します", filename);
	fp = fopen(filename, "wb");

	if (fp == NULL) {
		printf("file open error %s\n", filename);
		fclose(fp);
		return false;
	}

	fprintf(fp, "0x%08x\n", chip->xsize);
	fprintf(fp, "0x%08x\n", chip->ysize);

	for (int i = 0; i < mapsize; i++) {
		fprintf(fp, "0x%08x,", buffer[i]);
		line++;
		if (line == chip->xsize) {
			line = 0;
			fprintf(fp, "\n");
		}
	}

	printf("rawファイル作成完了 = %s\n", filename);
	fclose(fp);

	return true;
}


/**
 * @brief  binファイルの書き出し処理
 * @note   
 * @param  *chip: 
 * @param  *buffer: 書き出しデータが保存されているフレームバッファのアドレスを指定
 * @param  *filename: パスを含んだファイル名を指定
 * @retval 書き込み完了ならばtrue
 */
static bool bin_write(MapchipWork *chip, uint32_t *buffer, char *filename)
{
	FILE *fp = NULL;
	uint32_t mapsize = chip->xsize * chip->ysize;
	
	fp = fopen(filename, "wb");

	if (fp == NULL) {
		printf("file open error %s\n", filename);
		fclose(fp);
		return false;
	}

	printf("xsize %d\n", chip->ysize);
	printf("ysize %d\n", chip->ysize);
	fwrite(buffer, sizeof(uint32_t), mapsize, fp);
	printf("binファイル作成完了 = %s\n", filename);
	fclose(fp);

	return true;
}
