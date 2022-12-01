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

#include <stdint.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"

// MicroBlazeAdrs 
#define USI_GPI1    (*(volatile unsigned int *) 0x80000010)
#define USI_GPI2	(*(volatile unsigned int *) 0x80000014)
#define USI_GPI3    (*(volatile unsigned int *) 0x80000018)
#define USI_GPI1    (*(volatile unsigned int *) 0x80000020)


/**----------------------------------------------------------
 * ソフトウェア ループ
 *---------------------------------------------------------*/
void wait_time(uint32_t time)
{
	for (uint32_t i = 0; i < time; i++);
}


/**----------------------------------------------------------
 * Usi Bus Write
 *---------------------------------------------------------*/
void usi_write(uint32_t wd, uint32_t adrs)
{
	USI_GPI1	= wd;
	USI_GPI2	= adrs;
	USI_GPI3	= 0x00000001;
	USI_GPI3	= 0x00000000;
}


/**----------------------------------------------------------
 * Usi Bus Read
 *---------------------------------------------------------*/
uint32_t usi_read(uint32_t adrs)
{
	return USI_GPI1;
}


/**----------------------------------------------------------
 * main 関数
 *---------------------------------------------------------*/
int main(void)
{
    init_platform();

    uint32_t usi_data = 0x00000001;

    while (1)
    {
		wait_time(1000000);
		usi_write(usi_data, 0x00010000);
		usi_data ^= 0x00000001;
    }

    xil_printf("Hello World\n\r");
    cleanup_platform();

    return 0;
}
