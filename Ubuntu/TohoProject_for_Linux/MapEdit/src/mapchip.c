#include <string.h>
#include "../include/MYLIB.H"
#include "../include/MAPCHIP_DB.h"


/*
 * ファイル内関数
 */
static void fbuf_backup(MapchipWork *chip);



/*
 * プログラム実行時の引数に指定した、使用するファイルのパスとデータベースのパスを比較し
 * 一致した行のデータを作業領域に保存
 */
bool mapchip_init(MapchipWork *chip, char *path)
{
	const t_buildinfo *p = buildinfo;

	if (!path) {
		fprintf(stderr, "ファイルのパスが正しくありません\n");
		fprintf(stderr, "エラー内容は以下が考えられます\n");
		fprintf(stderr, "1. toolのカレントディレクトリでプログラムを実行して下さい\n");
		fprintf(stderr, "2. ./program res/ファイル名.png とパスを入力してください(ファイル名は恐らくchip_xxx.pngです)\n");
		fprintf(stderr, "3. includeディレクトリのMAPCHIP.Hに記述されているファイル名が間違っている可能性があります\n");
		fprintf(stderr, "4. t_buildinfo構造体の中身を確認してください\n");
		return false;
	}

	for (int i = 0; i < BUILD_SIZE; i++, p++)
	{
		if (strcmp(p->mapfile, path) == 0)
		{
			break;
		}
	}

	chip->map_mode   = MAP_CONFIG;
	chip->xsize		 = p->xsize;
	chip->ysize		 = p->ysize;
	chip->chip_xsize = p->chip_xsize;
	chip->chip_ysize = p->chip_ysize;
	chip->mapfile	 = p->mapfile;
	chip->bin_map	 = p->bin_map;
	chip->bin_obj	 = p->bin_obj;
	chip->bin_reg	 = p->bin_reg;
	chip->bin_npc	 = p->bin_npc;
	chip->raw_map	 = p->raw_map;
	chip->raw_obj	 = p->raw_obj;
	chip->raw_reg	 = p->raw_reg;
	chip->raw_npc	 = p->raw_npc;
	chip->chip_xpos  = 0;
	chip->chip_ypos  = 0;
	chip->mapchip_id = 0;
	chip->cutpos	 = p->cutpos;
	chip->obj_start  = p->obj_start;
	chip->obj_end    = p->obj_end;
	chip->dirx_loop	 = 1;
	chip->diry_loop	 = 1;
	chip->fbuf_map	 = p->fbuf_map;
	chip->fbuf_obj	 = p->fbuf_obj;
	chip->fbuf_reg	 = p->fbuf_reg;
	chip->fbuf_npc	 = p->fbuf_npc;
	chip->fbuf_map_backup = p->fbuf_map_backup;
	chip->fbuf_obj_backup = p->fbuf_obj_backup;
	chip->fbuf_reg_backup = p->fbuf_reg_backup;
	chip->region.digit[0] = 1;
	chip->region.digit[1] = 1;
	chip->isEnd = 0;
	fprintf(stderr, "初期設定が完了しました\n");
	fprintf(stderr, "マップデータの読み込みを行います\n");
	mapf_read(chip);
	mapf_read(chip);

	return true;
}


/*
 * ver1. 2021/06/19
 * 指定チップでバッファを全て塗りつぶし
 */
void mapchip_all_fill(MapchipWork *chip, char fbuf)
{
	for (uint32_t y = 0; y < chip->ysize; y++)
	{
		if (fbuf == 'f') {
			for (uint32_t x = 0; x < chip->xsize; x++)
			{
				chip->fbuf_map[x + (y * chip->xsize)] = chip->mapchip_id;
			}
		}

		if (fbuf == 'o') {
			for (uint32_t x = 0; x < chip->xsize; x++)
			{
				chip->fbuf_obj[x + (y * chip->xsize)] = 0;
			}
		}
	}
}


/**
 * @brief  矩形選択したマップチップIDをフレームバッファに保存
 * @note   
 * @param  *chip: 作業領域用ラッパー構造体のアドレスを指定
 * @param  fill: 配置方法を指定、矩形選択部分配置FILL_SQUARE、同じマップチップ配置FILL_LOT
 * @param  fbuf: 'q'マップデータを配置  'x' オブジェクトを配置
 * @retval None
 */
void mapchip_rect_fill(MapchipWork *chip, uint32_t fill, char fbuf)
{
	uint32_t unit_pos;
	uint32_t filed_pos;
	uint32_t chip_fill_pos;

	fbuf_backup(chip);

	for (uint32_t y = 0; y < chip->diry_loop; y++)
	{
		for (uint32_t x = 0; x < chip->dirx_loop; x++)
		{
			unit_pos	  = get_posinfo(UNIT_XPOS)  + (get_posinfo(UNIT_YPOS) * chip->ysize);
			filed_pos	  = get_posinfo(FIELD_XPOS) + (get_posinfo(FIELD_YPOS) * chip->ysize);
			chip_fill_pos = x + (y * (chip->chip_xsize >> MAPCHIP_SHIFT));

			if (fbuf == 'q') {
				if ((chip->obj_start <= chip->mapchip_id) && (chip->mapchip_id <= chip->obj_end)) {
					// chip->object[unit_pos + filed_pos + x + (y * chip->xsize)] = chip->mapchip_id + (chip_fill_pos & fill);
				}else{
					chip->fbuf_map[unit_pos + filed_pos + x + (y * chip->xsize)] = chip->mapchip_id + (chip_fill_pos & fill);
				}
			}

			if (fbuf == 'x') {
				if ((chip->obj_start <= chip->mapchip_id) && (chip->mapchip_id <= chip->obj_end)) {
					chip->fbuf_obj[unit_pos + filed_pos + x + (y * chip->xsize)] = chip->mapchip_id + (chip_fill_pos & fill);
				}
			}
		}
	}
}


/**
 * @brief  オブジェクトのバッファ領域の削除
 * @note   
 * @retval None
 */
void mapchip_rect_fill_zero(MapchipWork *chip)
{
	uint32_t unit_pos;
	uint32_t filed_pos;

	for (uint32_t y = 0; y < chip->diry_loop; y++)
	{
		for (uint32_t x = 0; x < chip->dirx_loop; x++)
		{
			unit_pos  = get_posinfo(UNIT_XPOS)  + (get_posinfo(UNIT_YPOS) * chip->ysize);
			filed_pos = get_posinfo(FIELD_XPOS) + (get_posinfo(FIELD_YPOS) * chip->ysize);
			chip->fbuf_obj[unit_pos + filed_pos + x + (y * chip->xsize)] = 0;
		}
	}
}


/*
 * ショートカットキーの登録
 */
void mapchip_shortcut_update(MapchipWork *chip, uint32_t num)
{
	chip->shortcut_key[num] = chip->mapchip_id;
}


/*
 * ショートカットに登録したマップチップを矩形選択分配置
 */
void mapchip_shortcut_fill(MapchipWork *chip, uint32_t num)
{
	uint32_t unit_pos;
	uint32_t filed_pos;

	fbuf_backup(chip);

	for (uint32_t y = 0; y < chip->diry_loop; y++)
	{
		for (uint32_t x = 0; x < chip->dirx_loop; x++)
		{
			unit_pos	= get_posinfo(UNIT_XPOS)  + (get_posinfo(UNIT_YPOS) * chip->ysize);
			filed_pos	= get_posinfo(FIELD_XPOS) + (get_posinfo(FIELD_YPOS) * chip->ysize);
			chip->fbuf_map[unit_pos + filed_pos + x + (y * chip->xsize)] = chip->shortcut_key[num];
		}
	}
}


/*
 * マップチップの選択座標更新
 */
void mapchip_pos_update(MapchipWork *chip, uint8_t key)
{
	switch (key)
	{
	case CHIP_RIGHT:
		if (((chip->chip_xsize >> MAPCHIP_SHIFT) - 1) == chip->chip_xpos)
		{
			chip->chip_xpos = 0;
		}
		else
		{
			chip->chip_xpos++;
		}
		break;

	case CHIP_LEFT:
		if (chip->chip_xpos == 0)
		{
			chip->chip_xpos = (chip->chip_xsize >> MAPCHIP_SHIFT) - 1;
		}
		else
		{
			chip->chip_xpos--;
		}
		break;

	case CHIP_UP:
		if (chip->chip_ypos == 0)
		{
			chip->chip_ypos = (chip->chip_ysize >> MAPCHIP_SHIFT) - 1;
		}
		else
		{
			chip->chip_ypos--;
		}
		break;

	case CHIP_DOWN:
		if (((chip->chip_ysize >> MAPCHIP_SHIFT) - 1)  == chip->chip_ypos)
		{
			chip->chip_ypos = 0;
		}
		else
		{
			chip->chip_ypos++;
		}
		break;
	
	default:
		break;
	}

	chip->mapchip_id = chip->chip_xpos + (chip->chip_ypos * (chip->chip_xsize >> MAPCHIP_SHIFT));
}


/*
 * フレームバッファを直前のバックアップから復元
 */
void fbuf_update(MapchipWork *chip)
{
	for (uint32_t y = 0; y < chip->ysize; y++)
	{
		for (uint32_t x = 0; x < chip->xsize; x++)
		{
			chip->fbuf_map[x + (y * chip->xsize)] = chip->fbuf_map_backup[x + (y * chip->xsize)];
			chip->fbuf_obj[x + (y * chip->xsize)] = chip->fbuf_obj_backup[x + (y * chip->xsize)];
			chip->fbuf_reg[x + (y * chip->xsize)] = chip->fbuf_reg_backup[x + (y * chip->xsize)];
		}
	}
}


/*
 * 直前のマップチップ情報を保存
 */
static void fbuf_backup(MapchipWork *chip)
{
	for (uint32_t y = 0; y < chip->ysize; y++)
	{
		for (uint32_t x = 0; x < chip->xsize; x++)
		{
			chip->fbuf_map_backup[x + (y * chip->xsize)] = chip->fbuf_map[x + (y * chip->xsize)];
			chip->fbuf_obj_backup[x + (y * chip->xsize)] = chip->fbuf_obj[x + (y * chip->xsize)];
			chip->fbuf_reg_backup[x + (y * chip->xsize)] = chip->fbuf_reg[x + (y * chip->xsize)];
		}
	}
}