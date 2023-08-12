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
	usi_write_cmd(0x0, 		TIMER_REG_ENABLE);	// Timer Rst
	usi_write_cmd(499999, 	TIMER_REG_DIV1);	// Timer Div1
	usi_write_cmd(49999, 	TIMER_REG_DIV2);	// Timer Div2
	usi_write_cmd(49, 		TIMER_REG_DIV3);	// Timer Div3
	usi_write_cmd(0x7, 		TIMER_REG_ENABLE);	// Timer Enable

	// SPI
	usi_write_cmd(0x8,		SPI_REG_DIV);		// 動作周波数
	usi_write_cmd(1,		SPI_REG_GPIO_ALT);	// SPI 機能有効

	// Synthesizer
	synth_sinwave_write();
	usi_write_cmd(0,		SYNTH_REG_DMA_ADRS_START);
	usi_write_cmd(44100-1,	SYNTH_REG_DMA_ADRS_END);
	usi_write_cmd(440,		SYNTH_REG_DMA_ADRS_ADD);
	usi_write_cmd(1,		SYNTH_REG_DMA_CYCLE_ENABLE);	// Cycle Mode Enable
	usi_write_cmd(1,		SYNTH_REG_DMA_ENABLE);			// DMA Run

	// flash rom
	flash_protection_reg_write();
}


/**-----------------------------------------------------------------------------
 * main 関数
 *-----------------------------------------------------------------------------*/
void main()
{
	uint16_t sin_buff[8] = {262,294,329,349,391,440,493,523};
	uint8_t rp = 0;
	system_initialize();
	
	while (1) {
		led_auto_flash(100, TIMER_REG_COUNT1);
		usi_write_cmd(sin_buff[rp],	SYNTH_REG_DMA_ADRS_ADD);
		rp++;
		rp &= 0x07;
		bsp_uDelay(100000);
//		cache_write(2, 60000);
		// flash_id_read();
		// flash_write();
		// flash_read();
	}
}
