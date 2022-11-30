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
#include "xiomodule.h"

XIOModule xio;

/**----------------------------------------------------------
 * ソフトウェア ループ
 *---------------------------------------------------------*/
void wait_time(uint32_t time)
{
	for (uint32_t i = 0; i < time; i++);
}


/**----------------------------------------------------------
 * main 関数
 *---------------------------------------------------------*/
int main(void)
{
    init_platform();
	XIOModule_Initialize(&xio, XPAR_IOMODULE_0_DEVICE_ID);

    uint32_t usi_data = 0x00000001;
    uint32_t usi_adrs = 0x00010000;
    uint32_t usi_cke  = 0x00000001;
	uint32_t d;

    while (1)
    {
		wait_time(1000000);
		XIOModule_DiscreteWrite(&xio, 1, usi_data);	// data
		XIOModule_DiscreteWrite(&xio, 2, usi_adrs);	// adrs
		XIOModule_DiscreteWrite(&xio, 3, usi_cke);	// cke assert
		XIOModule_DiscreteWrite(&xio, 3, 0);		// cke dissert
		d = XIOModule_DiscreteRead(&xio, 1);
		usi_data ^= 0x00000001;
    }

    xil_printf("Hello World\n\r");
    cleanup_platform();

    return 0;
}
