/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * Soc Project
 * 
 * v1.00 new release
 * v1.01
 *-----------------------------------------------------------------------------*/
#include "./include/system_wrapper.h"
#include <math.h>

/**-----------------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
static void system_initialize(void);


/**-----------------------------------------------------------------------------
 * Inisialize
 *-----------------------------------------------------------------------------*/
static void system_initialize(void)
{
	// GPIO
	usi_write_cmd(0x0, GPIO_REG_ALTNATE);	// Altanate mode off, CPU Side Control

	// Timer
	usi_write_cmd(0x0, TIMER_REG_ENABLE);	// Timer Rst
	usi_write_cmd(999999, TIMER_REG_DIV1);	// Timer Div1 1s
	usi_write_cmd(99999, TIMER_REG_DIV2);	// Timer Div2 1ms
	usi_write_cmd(99, TIMER_REG_DIV3);		// Timer Div3 1us
	usi_write_cmd(0x7, TIMER_REG_ENABLE);	// Timer Enable

	// SPI
	usi_write_cmd(0x2, SPI_REG_DIV);		// 動作周波数
	usi_write_cmd(1, SPI_REG_GPIO_ALT);		// SPI 機能有効

	// RAM
	// Config Setting
	usi_write_cmd(0, RAM_REG_RAM_MEM_CLK_DIV);
	usi_write_cmd(1, RAM_REG_RAM_CFG_RST);
	usi_write_cmd(0x35, RAM_REG_RAM_CFG_CMD);
	usi_write_cmd(1, RAM_REG_RAM_CFG_ENABLE);
	usi_write_cmd(0, RAM_REG_RAM_CFG_RST);
	usi_read_wait(RAM_REG_RAM_CFG_DONE, 0x01);
	usi_write_cmd(1, RAM_REG_RAM_CFG_RST);

	// Ram Data Write
	usi_write_cmd(1, RAM_REG_RAM_MAT_RST);
	usi_write_cmd(1, RAM_REG_RAM_MAT_MEM_WD_OE);
	ram_mcu_matset(0x3333, 0);	// cmd1
	ram_mcu_matset(0x8888, 1);	// cmd2
	ram_mcu_matset(0x0000, 2);	// adrs0
	ram_mcu_matset(0x0000, 3);	// adrs1
	ram_mcu_matset(0x0000, 4);	// adrs2
	ram_mcu_matset(0x0000, 5);	// adrs3
	ram_mcu_matset(0x0000, 6);	// adrs4
	ram_mcu_matset(0x0000, 7);	// adrs5

	for (uint8_t i = 0; i < 247; i++) {
		ram_mcu_matset(0xaaaa+i, i+8);	// wd set
	}

	usi_write_cmd(1, RAM_REG_RAM_MAT_ENABLE);
	usi_write_cmd(0, RAM_REG_RAM_MAT_RST);
	usi_read_wait(RAM_REG_RAM_MAT_DONE, 0x01);
	usi_write_cmd(1, RAM_REG_RAM_MAT_RST);

	// Ram Data Read
	usi_write_cmd(0, RAM_REG_RAM_MAT_MEM_WD_OE);
	ram_mcu_matset(0xEEEE, 0);	// cmd1
	ram_mcu_matset(0xBBBB, 1);	// cmd2
	ram_mcu_matset(0x0000, 2);	// adrs0
	ram_mcu_matset(0x0000, 3);	// adrs1
	ram_mcu_matset(0x0000, 4);	// adrs2
	ram_mcu_matset(0x0000, 5);	// adrs3
	ram_mcu_matset(0x0000, 6);	// adrs4
	ram_mcu_matset(0x0000, 7);	// adrs5
	usi_write_cmd(1, RAM_REG_RAM_MAT_ENABLE);
	usi_write_cmd(0, RAM_REG_RAM_MAT_RST);
	usi_read_wait(RAM_REG_RAM_MAT_DONE, 0x01);
	usi_write_cmd(1, RAM_REG_RAM_MAT_RST);

	for (uint8_t i = 0; i < 255; i++) {
		usi_write_cmd(i, RAM_REG_RAM_MAT_MEM_RA);
		uint32_t wd = usi_read_cmd(RAM_REG_RAM_MAT_MEM_RD);
		ram_mcu_matset(i, wd);	// cmd1
	}

	// Audio
	 usi_write_cmd(0x040404, AUDIO_REG_SFM_CLK_DIV);		// 動作周波数
	 usi_write_cmd(0x020202, AUDIO_REG_SFM_CS_HOLD_TIME);
	 usi_write_cmd(0x7, AUDIO_REG_SFM_CPU_VALID);
	 flash_id_read(0);
	 flash_id_read(1);
	 flash_protection_reg_write(0);
	 flash_protection_reg_write(1);
	 usi_write_cmd(0x0, AUDIO_REG_SFM_CPU_VALID);
	 usi_write_cmd(0, AUDIO_REG_SFM_START_ADRS_1);
	 usi_write_cmd(4100, AUDIO_REG_SFM_END_ADRS_1);
	 usi_write_cmd(0x1, AUDIO_REG_SFM_CYCLE_ENABLE);
	 usi_write_cmd(0x1, AUDIO_REG_SFM_ENABLE);

	// Video
//	video_tft_init();
//	video_color_bar();

//	uint8_t rbuff[2048];
//
//	for (uint16_t i = 0; i < 4700; i++) {
//		flash_read(2, rbuff, 0, i, 2048);
//
//		for (uint16_t j = 0; j < 2048; j = j+2) {
//			uint16_t msb = (rbuff[j+1] << 8) & 0xff00;
//			uint16_t lsb = rbuff[j] & 0x00ff;
//			uint16_t wd = msb | lsb;
//			usi_write_cmd(wd, AUDIO_REG_AAC_CPU_WD);
//			usi_write_cmd(0x01, AUDIO_REG_AAC_CPU_WE);
//			usi_write_cmd(0x00, AUDIO_REG_AAC_CPU_WE);
//			while (1) {
//				if (0 == usi_read_cmd(AUDIO_REG_AAC_ALERT)) {
//					break;
//				}
//			}
//		}
//	}
}


/**----------------------------------------------------------------------------
 * 座標更新の判定
 *---------------------------------------------------------------------------*/
static bool is_wall_point(void)
{
	static uint8_t sel = 0;
	uint16_t vpos = usi_read_cmd(VIDEO_REG_PDP_VPOS);

	if (sel == 0) {
		if (256 < vpos) {
			sel = 1;
			return true;
		}
	} else {
		if (vpos < 10) {
			sel = 0;
		}
	}

	return false;
}


/**----------------------------------------------------------------------------
 * 壁の位置更新
 * 
 * speed 加速度
 *---------------------------------------------------------------------------*/
static void wall_point_update(SDL_Rect *sdl, int8_t speed)
{
	sdl->x = sdl->x - speed;
	sdl->w = sdl->w - speed;

	if (sdl->x < -32) {
		sdl->x = 480;
		sdl->w = 480+16;
	}

	if (sdl->x > 512) {
		sdl->x = -16;
		sdl->w = 0;
	}
}

/**----------------------------------------------------------------------------
 * 
 *---------------------------------------------------------------------------*/
uint8_t get_sw(void)
{
	return i2c_read();
}


/**-----------------------------------------------------------------------------
 * main 関数
 *-----------------------------------------------------------------------------*/
void main()
{
	system_initialize();
	// SDL_Rect sdl_bg    = {.x = 0, .w = 480, .y = 0, .h = 272};				// back ground
	// SDL_Rect sdl_gl    = {.x = 0, .w = 480, .y = 272-16, .h = 272,};		// gound line
	// SDL_Rect sdl_pl    = {.x = 16, .w = 32, .y = 272-16-16, .h = 272-16,};	// player
	// SDL_Rect sdl_tile1 = {.x = 480/2-20, .w = 480/2+20, .y = 100, .h = 100+4,};
	// SDL_Rect sdl_tile2 = {.x = 480/2-20, .w = 480/2+20, .y = 180, .h = 180+4,};
	// SDL_Rect sdl_wall1 = {.x = 480, .w = 480+16, .y = 120, .h = 272-16,};

	// video_square_draw(&sdl_bg, 0x0000, 0);		// Back Ground
	// video_square_draw(&sdl_gl, 0x00, 0);		// Ground Line

	while (1) {
		led_auto_flash(50, TIMER_REG_COUNT1);
		// usi_read_printf(GPIO_REG_PUSH_SW);
		// uint8_t sw = get_sw();

		// if (true == is_wall_point()) {
		// 	video_square_draw(&sdl_pl, 0xf000, 1);
		// 	video_square_draw(&sdl_tile1, 0x44C8, 2);
		// 	video_square_draw(&sdl_tile2, 0x44C8, 3);
		// 	video_square_draw(&sdl_wall1, 0x000f, 4);

		// 	if (sw & 0x04) {
		// 		wall_point_update(&sdl_wall1, 1);
		// 	}else if (sw & 0x02){
		// 		wall_point_update(&sdl_wall1, -1);
		// 	}
		// }

//			playback_time = usi_read_cmd(AUDIO_REG_SFM_ADD_ADRS_3);
//			playback_time = (playback_time * 100) / 4100;
//			video_gauge(playback_time);
	}
}
