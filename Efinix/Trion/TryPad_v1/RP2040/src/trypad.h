/*------------------------------------------------------------------------------
 * Create  2024/06/16
 * Author  Kouta Kimura
 * 
 * TRYPAD v1 Header, Wrapper File
 * 全ファイルで共通して使用するマクロやLib を管理する。
 * 基本的に Cソースファイルの先頭で必ず Include する。
 *-----------------------------------------------------------------------------*/
#ifndef trypad_h
#define trypad_h

/**-----------------------------------------------------------------------------
 * USER DEBUG MACRO
 *-----------------------------------------------------------------------------*/
// #define DEBUG_MODE

/**-----------------------------------------------------------------------------
 * USER MACRO
 *-----------------------------------------------------------------------------*/
#define LEN(ary) (sizeof(ary)/sizeof(ary[0]))			// 一次元配列 行数取得 深さ
#define ROWS(ary) (sizeof(ary)/sizeof(ary[0]))			// 一次元配列 行数取得 深さ
#define COLS(ary) (sizeof(ary[0])/sizeof(ary[0][0]))	// 二次元配列 列数取得 長さ

/**-----------------------------------------------------------------------------
 * GPIO MACRO
 * XIAO RP2040 回路図とピンアサインが一致しないので注意
 *-----------------------------------------------------------------------------*/
#define LED_R				(17)	// pin no ではなく端子名
#define LED_B				(25)
#define LED_G				(16)
#define NEO_PWR				(11)
#define NEO_PIX				(12)
#define PICO_ADC			(26)
#define TRION_CDONE 		(27)
#define TRION_CFGRST 		(0)
#define TRION_PICO_IO1 		(28)	// USI Bus Sel "0" External, "1" Internal
#define TRION_PICO_IO2 		(29)	// FPGA System RST
#define TRION_PICO_IO3 		(6)
#define TRION_PICO_SPI_CS	(1)
#define TRION_PICO_SPI_SCK	(2)
#define TRION_PICO_SPI_MOSI	(3)
#define TRION_PICO_SPI_MISO	(4)
#define HARDWARE_SPI_PORT	(spi0)

/**-----------------------------------------------------------------------------
 * Common Lib Inclde
 *-----------------------------------------------------------------------------*/
#include <stdbool.h>
#include <stdint.h>

/**-----------------------------------------------------------------------------
 * User Lib Inclde
 *----------------------------------------------------------------------------*/
#include "./trypad_fpga_macro.h"
#include "./Mvideo.h"
#include "./Mtimer.h"
#include "./Mpsram.h"
#include "./Mgpio.h"
#include "./MflashPico.h"
#include "./Musb.h"
#include "./Mspi.h"

#endif