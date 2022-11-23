/*
 * Create 2021/09/08
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * 
 * リージョンマップ作成の処理を管理するファイル
 */
#include "../include/MYLIB.H"



/**
 * @brief  キャラクターの現在の座標にフレームバッファにNPCのIDを保存
 * @note   
 * @retval None
 */
void npc_write(MapchipWork *chip)
{
	uint32_t unit_pos  = get_posinfo(UNIT_XPOS)  + (get_posinfo(UNIT_YPOS) * chip->ysize);
	uint32_t filed_pos = get_posinfo(FIELD_XPOS) + (get_posinfo(FIELD_YPOS) * chip->ysize);

	for (uint32_t y = 0; y < chip->diry_loop; y++)
	{
		for (uint32_t x = 0; x < chip->dirx_loop; x++)
		{
			chip->fbuf_npc[unit_pos + filed_pos + x + (y * chip->xsize)] = chip->region.id[1];
		}
	}
}


/**
 * @brief  キャラクターの現在の座標にフレームバッファにリージョンIDを保存
 * @note   
 * @retval None
 */
void region_write(MapchipWork *chip)
{
	uint32_t unit_pos  = get_posinfo(UNIT_XPOS)  + (get_posinfo(UNIT_YPOS) * chip->ysize);
	uint32_t filed_pos = get_posinfo(FIELD_XPOS) + (get_posinfo(FIELD_YPOS) * chip->ysize);

	for (uint32_t y = 0; y < chip->diry_loop; y++)
	{
		for (uint32_t x = 0; x < chip->dirx_loop; x++)
		{
			chip->fbuf_reg[unit_pos + filed_pos + x + (y * chip->xsize)] = chip->region.id[0];
		}
	}
}


/**
 * @brief  リージョンIDの数値を設定
 * @note   
 * @param  id: リージョンIDの数値を指定
 * @retval None
 */
void request_region_id(MapchipWork *chip, uint32_t id, uint8_t index)
{
	switch (chip->region.digit[index])
	{
	case 1:
		chip->region.id[index] = id;
		chip->region.key_count[index] = 0;
		break;

	case 2:
		if (chip->region.key_count[index] == 0)
		{
			chip->region.id[index] = id;
			chip->region.key_count[index] = 1;
		}
		else
		{
			chip->region.id[index] = (chip->region.id[index] * 10) + id;
			chip->region.key_count[index] = 0;
		}
		break;

	case 3:
		if (chip->region.key_count[index] == 0)
		{
			chip->region.id[index] = id;
			chip->region.key_count[index] = 1;
		}
		else
		{
			if (chip->region.key_count[index] == 1)
			{
				chip->region.key_count[index] = 2;
			}
			else
			{
				chip->region.key_count[index] = 0;
			}
			chip->region.id[index] = (chip->region.id[index] * 10) + id;
		}
		break;
	}
}