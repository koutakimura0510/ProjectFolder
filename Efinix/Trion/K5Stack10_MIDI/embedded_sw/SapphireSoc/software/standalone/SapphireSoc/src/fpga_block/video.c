/**-----------------------------------------------------------------------------
 * Create  2023/10/15
 * Author  kouta kimura
 * -
 * Video Tx Block function
 *-----------------------------------------------------------------------------*/
#include "../include/system_wrapper.h"

/**-----------------------------------------------------------------------------
 * color bar 描画設定
 *-----------------------------------------------------------------------------*/
void video_color_bar(void)
{
	usi_write_cmd(0x000000ff, VIDEO_REG_DOT_SQUARE_COLOR1);
	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT1);
	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT1);
	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_TOP1);
	usi_write_cmd(45, VIDEO_REG_DOT_SQUARE_UNDER1);

	usi_write_cmd(0x0000ff00, VIDEO_REG_DOT_SQUARE_COLOR2);
	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT2);
	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT2);
	usi_write_cmd(46, VIDEO_REG_DOT_SQUARE_TOP2);
	usi_write_cmd(91, VIDEO_REG_DOT_SQUARE_UNDER2);

	usi_write_cmd(0x00ff0000, VIDEO_REG_DOT_SQUARE_COLOR3);
	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT3);
	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT3);
	usi_write_cmd(92, VIDEO_REG_DOT_SQUARE_TOP3);
	usi_write_cmd(137, VIDEO_REG_DOT_SQUARE_UNDER3);

	usi_write_cmd(0x0000fa9a, VIDEO_REG_DOT_SQUARE_COLOR4);
	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT4);
	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT4);
	usi_write_cmd(183, VIDEO_REG_DOT_SQUARE_TOP4);
	usi_write_cmd(228, VIDEO_REG_DOT_SQUARE_UNDER4);

	usi_write_cmd(0x00ff00ff, VIDEO_REG_DOT_SQUARE_COLOR5);
	usi_write_cmd(0, VIDEO_REG_DOT_SQUARE_LEFT5);
	usi_write_cmd(480, VIDEO_REG_DOT_SQUARE_RIGHT5);
	usi_write_cmd(229, VIDEO_REG_DOT_SQUARE_TOP5);
	usi_write_cmd(272, VIDEO_REG_DOT_SQUARE_UNDER5);
}

/**-----------------------------------------------------------------------------
 * color bar 描画設定
 *-----------------------------------------------------------------------------*/
void video_gauge(uint32_t gauge)
{
	usi_write_cmd(0x0000, VIDEO_REG_DOT_SQUARE_COLOR1);
	usi_write_cmd(0x0000, VIDEO_REG_DOT_SQUARE_COLOR2);
	usi_write_cmd(0xffff, VIDEO_REG_DOT_SQUARE_COLOR3);
	usi_write_cmd(82, VIDEO_REG_DOT_SQUARE_LEFT3);
	usi_write_cmd(190, VIDEO_REG_DOT_SQUARE_RIGHT3);
	usi_write_cmd(180, VIDEO_REG_DOT_SQUARE_TOP3);
	usi_write_cmd(220, VIDEO_REG_DOT_SQUARE_UNDER3);
	usi_write_cmd(0x0000, VIDEO_REG_DOT_SQUARE_COLOR4);
	usi_write_cmd(86, VIDEO_REG_DOT_SQUARE_LEFT4);
	usi_write_cmd(186, VIDEO_REG_DOT_SQUARE_RIGHT4);
	usi_write_cmd(180+2, VIDEO_REG_DOT_SQUARE_TOP4);
	usi_write_cmd(220-2, VIDEO_REG_DOT_SQUARE_UNDER4);
	usi_write_cmd(0x000f, VIDEO_REG_DOT_SQUARE_COLOR5);
	usi_write_cmd(86, VIDEO_REG_DOT_SQUARE_LEFT5);
	usi_write_cmd(86+gauge, VIDEO_REG_DOT_SQUARE_RIGHT5);
	usi_write_cmd(180+2, VIDEO_REG_DOT_SQUARE_TOP5);
	usi_write_cmd(220-2, VIDEO_REG_DOT_SQUARE_UNDER5);
}

/**
 * @brief  
 * @note   
 * @param  sdl: SDL_Rect adrs
 * @param  color: 描画色
 * @param  adrs_id: fpga_square_adrs の参照用 Index
 * @retval None
 */
void video_square_draw(SDL_Rect *sdl, uint16_t color, uint32_t adrs_id)
{
	static const uint32_t fpga_square_adrs[7][5] = {
		{VIDEO_REG_DOT_SQUARE_COLOR1, VIDEO_REG_DOT_SQUARE_LEFT1, VIDEO_REG_DOT_SQUARE_RIGHT1, VIDEO_REG_DOT_SQUARE_TOP1, VIDEO_REG_DOT_SQUARE_UNDER1},
		{VIDEO_REG_DOT_SQUARE_COLOR2, VIDEO_REG_DOT_SQUARE_LEFT2, VIDEO_REG_DOT_SQUARE_RIGHT2, VIDEO_REG_DOT_SQUARE_TOP2, VIDEO_REG_DOT_SQUARE_UNDER2},
		{VIDEO_REG_DOT_SQUARE_COLOR3, VIDEO_REG_DOT_SQUARE_LEFT3, VIDEO_REG_DOT_SQUARE_RIGHT3, VIDEO_REG_DOT_SQUARE_TOP3, VIDEO_REG_DOT_SQUARE_UNDER3},
		{VIDEO_REG_DOT_SQUARE_COLOR4, VIDEO_REG_DOT_SQUARE_LEFT4, VIDEO_REG_DOT_SQUARE_RIGHT4, VIDEO_REG_DOT_SQUARE_TOP4, VIDEO_REG_DOT_SQUARE_UNDER4},
		{VIDEO_REG_DOT_SQUARE_COLOR5, VIDEO_REG_DOT_SQUARE_LEFT5, VIDEO_REG_DOT_SQUARE_RIGHT5, VIDEO_REG_DOT_SQUARE_TOP5, VIDEO_REG_DOT_SQUARE_UNDER5},
		{VIDEO_REG_DOT_SQUARE_COLOR6, VIDEO_REG_DOT_SQUARE_LEFT6, VIDEO_REG_DOT_SQUARE_RIGHT6, VIDEO_REG_DOT_SQUARE_TOP6, VIDEO_REG_DOT_SQUARE_UNDER6},
		{VIDEO_REG_DOT_SQUARE_COLOR7, VIDEO_REG_DOT_SQUARE_LEFT7, VIDEO_REG_DOT_SQUARE_RIGHT7, VIDEO_REG_DOT_SQUARE_TOP7, VIDEO_REG_DOT_SQUARE_UNDER7}
	};
	
	usi_write_cmd(color, fpga_square_adrs[adrs_id][0]);
	usi_write_cmd(sdl->x, fpga_square_adrs[adrs_id][1]);
	usi_write_cmd(sdl->w, fpga_square_adrs[adrs_id][2]);
	usi_write_cmd(sdl->y, fpga_square_adrs[adrs_id][3]);
	usi_write_cmd(sdl->h, fpga_square_adrs[adrs_id][4]);
}
