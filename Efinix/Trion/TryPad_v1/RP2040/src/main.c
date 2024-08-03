/*------------------------------------------------------------------------------
 * Create 2024/06/15
 * Author Kouta Kimura
 * Target XIAO RP2040 for TRYPAD v1
 * 
 *-----------------------------------------------------------------------------*/
#include "trypad.h"							// Borad システム、システム全体で共通して使用する
#include "./BraveFrontier/brave_frontier.h"	// ゲームシステム
#include <stdio.h>							// printf に使用
#include "pico/stdlib.h"					// pico sdk Initialize
#include "hardware/watchdog.h"				// 初期設定でバグったときに使用
#include "hardware/resets.h"				// USB デバイス初期設定でバグったときに使用


/**-----------------------------------------------------------------------------
 * USER MACRO
 *-----------------------------------------------------------------------------*/
#define FPGA_CONFIG_RST		(1)	// "0" RST OFF, "1" RST ON


/**-----------------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
static void trypad_pico_init(void);
static void trypad_fpga_init(void);
static void trypad_peri_init(void);
static void trypad_game_mode(void);
static void trypad_update_mode(void);

/**-----------------------------------------------------------------------------
 * trypad_pico_init
 *-----------------------------------------------------------------------------*/
static void trypad_pico_init(void)
{
	static const uint8_t pin[][2] = {	//[x][0]=pin no, [x][1]=dir
		{LED_R, 1},
		{LED_G, 1},
		{LED_B, 1},
		{NEO_PWR, 1},
		{NEO_PIX, 1},
		{PICO_ADC, 0},
		{TRION_CDONE, 0},
		{TRION_CFGRST, FPGA_CONFIG_RST},
		{TRION_PICO_IO1, 1},
		{TRION_PICO_IO2, 1},
		{TRION_PICO_IO3, 1},
	};

	reset_block(RESETS_RESET_USBCTRL_BITS);			// USB 接続中にデバッグを行うと認識されなくなるため、
	unreset_block_wait(RESETS_RESET_USBCTRL_BITS);	// 確実に USB ブロックをリセットし、ホストと切断してから、再度 接続設定を行う。
	stdio_init_all();								// CMakefile で UART/USB 切り替え

	for (uint8_t i = 0; i < ROWS(pin); i++) {
		gpio_init(pin[i][0]);
		gpio_set_dir(pin[i][0], pin[i][1]);
	}

	gpio_put(TRION_CFGRST, 0);
	gpio_put(TRION_PICO_IO1, 0);
	gpio_put(TRION_PICO_IO2, 1);
	wait_ms(1);
	gpio_put(TRION_PICO_IO2, 0);
	gpio_put(TRION_PICO_IO3, 0);
	wait_ms(10);						// FPGA RST Low から少なくとも 10ms 待機が必要
	gpio_set_dir(TRION_CFGRST, 0);		// ドライブすると JTAG Write できなくなるため、入力設定にする
	wait_ms(1);
	while (!gpio_get(TRION_CDONE));		// FPGA CDONE , QSPI min 150ms, SPI min 800ms
	pico_spi_init(0, SPI_BAUDRATE);
	gpio_put(LED_R, 1);
	gpio_put(LED_G, 1);
	gpio_put(LED_B, 1);
}

/**-----------------------------------------------------------------------------
 * trypad fpga reg init
 *-----------------------------------------------------------------------------*/
static void trypad_fpga_init(void)
{
	usi_write(GPIO_REG_VIDEO_GPIO_OE, 0xffffff);
	usi_write(GPIO_REG_ROM_GPIO_OE, 0x11);
	usi_write(GPIO_REG_CFG_ROM_GPIO_OE, 0x00);
	usi_write(GPIO_REG_AUDIO_GPIO_OE, 0x00);
	uint32_t fpga = usi_read(MCB_REG_FPGA_VERSION);
	usi_write(MCB_REG_FPGA_VERSION, fpga);
}

/**-----------------------------------------------------------------------------
 * trypad Periheral init
 *-----------------------------------------------------------------------------*/
static void trypad_peri_init(void)
{
	st7789_init();
	psram_init();
	// psram_device_test();
	// flash_rom_init();
	usi_write(VIDEO_REG_VTU_CONVERTER_RST, 0x00);
	printf("Flash ID %x\n", flash_id_read(0));
	printf("Flash ID %x\n", flash_id_read(1));
	printf("Flash ID %x\n", flash_id_read(2));
	printf("TRYPAD Init Complete\n");
}

/**-----------------------------------------------------------------------------
 * trypad game mode
 *-----------------------------------------------------------------------------*/
static void trypad_game_mode(void)
{
	brave_frontier();
}

/**-----------------------------------------------------------------------------
 * trypad update mode
 *-----------------------------------------------------------------------------*/
static void trypad_update_mode(void)
{
	// アップデートモード T.B.D.
	return;
}


/**-----------------------------------------------------------------------------
 * main 関数
 * 
 * 起動時にハードウェアの設定を行う。
 * 正常に終了したらゲームモードに移行する。
 *-----------------------------------------------------------------------------*/
int main()
{
	watchdog_enable(5000, true);	// ペリフェラルの設定で、まれにフリーズするため、5秒間 init 完了しない場合リセット
	trypad_pico_init();
	trypad_fpga_init();
	trypad_peri_init();
	hw_clear_bits(&watchdog_hw->ctrl, WATCHDOG_CTRL_ENABLE_BITS);	// Init Complete でウォッチ・ドッグ解除

	while (1) {
		trypad_game_mode();
		trypad_update_mode();
	}

	return 0;
}