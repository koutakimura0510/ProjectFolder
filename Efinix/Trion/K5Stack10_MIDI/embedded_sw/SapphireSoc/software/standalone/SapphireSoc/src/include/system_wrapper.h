/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * Wrapper Include File
 * 
 *-----------------------------------------------------------------------------*/

#ifndef system_wrapper_h
#define system_wrapper_h

// バッファ個数計算
#define DEPTH(ary) (sizeof(ary)/sizeof(ary[0]))

#include <stdint.h>
#include <stdbool.h>
#include "bsp.h"
#include "periheral_macro.h"

#include "../fpga_block/usi_func.h"
#include "../fpga_block/spi_func.h"
#include "../flash_rom/flash_rom_func.h"

#endif