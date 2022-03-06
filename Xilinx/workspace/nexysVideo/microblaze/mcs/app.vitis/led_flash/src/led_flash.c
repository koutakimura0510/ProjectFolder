/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

//----------------------------------------------------------
// Create 2021/3/6
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// Micro Blaze MCS サンプル動作
// 外部割り込み機能を使用して、ボード付属のLEDを点灯させる
//
// Xilinx DS865 LogiCORE IP MicroBlaze MCS 参照
//----------------------------------------------------------
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xiomodule.h"      // GPIO駆動
#include "mb_interface.h"   // 割り込み駆動

//----------------------------------------------------------
// 割り込みアドレス
//----------------------------------------------------------
#define IRQ_ACK     (*(volatile unsigned int *) 0x8000003C)
#define IRQ_ENABLE  (*(volatile unsigned int *) 0x80000038)     //

XIOModule xio;
static uint8_t led = 0;

void int00(void)
{
//	microblaze_disable_interrupts();
	IRQ_ACK = 0x00010000;       // 割り込み発生時 Highになるレジスタをクリア
    XIOModule_DiscreteWrite(&xio, 1, led);
    led++;
    IRQ_ENABLE = 0x00010000;    // 再度割り込み許可
//	microblaze_enable_interrupts();
}

int main()
{
    init_platform();

    // GPO 設定
    XIOModule_Initialize(&xio, XPAR_IOMODULE_0_DEVICE_ID);

    // 割り込み設定
    microblaze_register_handler((XInterruptHandler)int00, (void *)0);
    IRQ_ENABLE = 0x00010000;
    microblaze_enable_interrupts();
    
    print("Successfully ran Hello World application");

    while (1)
    {
    	;
    }

    cleanup_platform();
    return 0;
}
