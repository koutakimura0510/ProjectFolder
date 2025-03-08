/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * Wrapper Include File
 * 
 * v1.00 new release
 * v1.01 gpio_func add
 *-----------------------------------------------------------------------------*/

#ifndef system_wrapper_h
#define system_wrapper_h

//-----------------------------------------------------------------------------
// User Macro
//-----------------------------------------------------------------------------
#define ROWS(ary) (sizeof(ary)/sizeof(ary[0]))			// バッファ行数取得
#define COLS(ary) (sizeof(ary[0])/sizeof(ary[0][0]))	// 二次元配列 列数取得

//-----------------------------------------------------------------------------
// common lib
//-----------------------------------------------------------------------------
#include <stdint.h>
#include <stdbool.h>
#include "bsp.h"
#include "periheral_macro.h"

//-----------------------------------------------------------------------------
// user lib / function
//-----------------------------------------------------------------------------
#include "../fpga_block/usi_func.h"
#include "../fpga_block/timer_func.h"
#include "../fpga_block/gpio_func.h"
#include "../fpga_block/spi_func.h"
#include "../fpga_block/mcb_cache_func.h"
#include "../fpga_block/synth_func.h"
#include "../fpga_block/video_func.h"
#include "../fpga_block/i2c_func.h"
#include "../fpga_block/ram_func.h"
#include "../flash_rom/flash_rom_func.h"

#endif
