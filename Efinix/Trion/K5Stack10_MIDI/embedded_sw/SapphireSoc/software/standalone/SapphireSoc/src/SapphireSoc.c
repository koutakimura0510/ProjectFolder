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
	usi_write_cmd(499999, TIMER_REG_DIV1);	// Timer Div1
	usi_write_cmd(49999, TIMER_REG_DIV2);	// Timer Div2
	usi_write_cmd(49, TIMER_REG_DIV3);		// Timer Div3
	usi_write_cmd(0x7, TIMER_REG_ENABLE);	// Timer Enable

	// SPI
	usi_write_cmd(0x2, SPI_REG_DIV);		// 動作周波数
	usi_write_cmd(1, SPI_REG_GPIO_ALT);		// SPI 機能有効

	// Audio
	usi_write_cmd(0x020202, AUDIO_REG_SFM_CLK_DIV);		// 動作周波数
	usi_write_cmd(0x020202, AUDIO_REG_SFM_CS_HOLD_TIME);
	usi_write_cmd(0x7, AUDIO_REG_SFM_CPU_VALID);
	flash_protection_reg_write(0);
	flash_protection_reg_write(1);
	flash_protection_reg_write(2);
	flash_protection_reg_write(3);
	flash_id_read(3);

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

	 usi_write_cmd(0x0, AUDIO_REG_SFM_CPU_VALID);
	 usi_write_cmd(0, AUDIO_REG_SFM_START_ADRS_3);
	 usi_write_cmd(4400, AUDIO_REG_SFM_END_ADRS_3);
	 usi_write_cmd(0x4, AUDIO_REG_SFM_CYCLE_ENABLE);
	 usi_write_cmd(0x4, AUDIO_REG_SFM_ENABLE);
}


/**-----------------------------------------------------------------------------
 * main 関数
 *-----------------------------------------------------------------------------*/
void main()
{
	system_initialize();
	
	while (1) {
		led_auto_flash(50, TIMER_REG_COUNT1);
	}
}
