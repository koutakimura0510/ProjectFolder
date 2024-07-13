/*------------------------------------------------------------------------------
 * Create 2024/06/15
 * Author Kouta Kimura
 * Target XIAO RP2040 for TRYPAD v1
 * 
 *-----------------------------------------------------------------------------*/
#include "trypad.h"
#include <stdio.h>			// printf
#include "pico/stdlib.h"	// pico sdk
#include "hardware/spi.h"	// pico hardware timer
// #include "hardware/irq.h"
// #include "hardware/clocks.h"
// #include "pico/binary_info.h"


/**-----------------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
static void trypad_pico_init(void);
static void trypad_fpga_init(void);


/**-----------------------------------------------------------------------------
 * trypad_pico_init
 *-----------------------------------------------------------------------------*/
static void trypad_pico_init(void)
{
	uint8_t pin[][2] = {	//[x][0]=pin no, [x][1]=dir
		{LED_R, 1},
		{LED_G, 1},
		{LED_B, 1},
		{NEO_PWR, 1},
		{NEO_PIX, 1},
		{PICO_ADC, 0},
		{TRION_CDONE, 0},
		{TRION_CFGRST, 1},
		{TRION_PICO_IO1, 1},
		{TRION_PICO_IO2, 1},
		{TRION_PICO_IO3, 1},
	};

	for (uint8_t i = 0; i < ROWS(pin); i++) {
		gpio_init(pin[i][0]);
		gpio_set_dir(pin[i][0], pin[i][1]);
	}

	gpio_put(TRION_CFGRST, 0);
	gpio_put(TRION_PICO_IO1, 0);
	gpio_put(TRION_PICO_IO2, 0);
	gpio_put(TRION_PICO_IO3, 0);
	wait_ms(10);
	gpio_set_dir(TRION_CFGRST, 0);	// ドライブすると JTAG Write できなくなるため、入力設定にする
	wait_ms(1000);					// USB 接続完了まで、ある程度待機
	alarm_in_us(1000000);

	while (0 == gpio_get(TRION_CDONE)) {	// FPGA CDONE , QSPI min 150ms, SPI min 800ms
		if (true == is_alarm_fired()) {
			printf("FPGA Not Configlation\n");
			break;
		}
	}

	if (gpio_get(TRION_CDONE)) {
		printf("FPGA CDONE\n");
	}

	trypad_spi_init(0, SPI_BAUDRATE);
	gpio_put(LED_R, 1);
	gpio_put(LED_G, 1);
	gpio_put(LED_B, 1);
	printf("Trypad GPIO Init Complete\n");
}

/**-----------------------------------------------------------------------------
 * trypad fpga reg init
 *-----------------------------------------------------------------------------*/
static void trypad_fpga_init(void)
{
	uint32_t fpga_ver = usi_read(MCB_REG_FPGA_VERSION);
	uint32_t fpga_code = usi_read(MCB_REG_CUSTOM_CODE);
	printf("fpga ver = %d\n", fpga_ver);
	printf("fpga code = %d\n", fpga_code);

	// IO OE
	usi_write(GPIO_REG_VIDEO_GPIO_OE, 0xffffff);
	usi_write(GPIO_REG_ROM_GPIO_OE, 0x11);
	usi_write(GPIO_REG_CFG_ROM_GPIO_OE, 0xff);
	usi_write(GPIO_REG_AUDIO_GPIO_OE, 0x00);
}

/**-----------------------------------------------------------------------------
 * Debug Console
 *-----------------------------------------------------------------------------*/
void debug_usi_printf(uint32_t adrs, char *s)
{
	printf("%s %d\r\n", s, usi_read(adrs));
}

/**-----------------------------------------------------------------------------
 * main 関数
 *-----------------------------------------------------------------------------*/
int main()
{
	SdlRect rect = {.top=0, .under=32, .left=0, .right=160, .color=0xffff};
	stdio_init_all();
	trypad_pico_init();
	trypad_fpga_init();
	st7789_init();
	usi_write(VIDEO_REG_VTU_CONVERTER_RST, 0x00);

	while (1) {
		if (rect.right == 352) {
			rect.right = 0;
			rect.left = -32;
		}
		rect.right++;
		rect.left++;
		gpio_put(LED_B, 0);
		gpio_put(LED_G, 1);
		gpio_put(LED_R, 1);
		rect_draw(&rect);
		wait_ms(10);
	}

	return 0;
}