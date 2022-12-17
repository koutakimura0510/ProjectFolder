/**----------------------------------------------------------
 * Create  2022/12/10
 * Author  kimura
 * -
 * vitis22.04
 * 
 * Build 手順
 * ctrl + B
 * toolber -> xilinx -> program device -> generate
 * 
 * download.bit が無いと error が出た場合の処置
 * folder -> _ide -> bitstream -> xxx.mmi ファイルの下記の inst を削除。
 * パスが正しくないので download.bit が生成されない。
 * <Processor Endianness="Little" InstPath="Processor/MicroControllerBlock/MCS/inst/microblaze_I">
 * 
 *--------------------------------------------------------*/


#include <stdint.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"


// MicroBlaze GPO GPI Adrs
// 使用していない Pin はコメントアウト
#define USI_GPO1	(*(volatile unsigned int *) 0x80000010)
#define USI_GPO2	(*(volatile unsigned int *) 0x80000014)
#define USI_GPO3	(*(volatile unsigned int *) 0x80000018)
// #define USI_GPO4    (*(volatile unsigned int *) 0x8000001C)
//
#define USI_GPI1	(*(volatile unsigned int *) 0x80000020)
 #define USI_GPI2    (*(volatile unsigned int *) 0x80000024)
// #define USI_GPI3    (*(volatile unsigned int *) 0x80000028)
// #define USI_GPI4    (*(volatile unsigned int *) 0x8000002C)


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
	USI_GPO1	= wd;
	USI_GPO2	= adrs;
	USI_GPO3	= 0x00000001;
	USI_GPO3	= 0x00000000;
}


/**----------------------------------------------------------
 * Usi Bus Read
 *---------------------------------------------------------*/
uint32_t usi_read(uint32_t adrs)
{
	USI_GPO2 = adrs;
	return USI_GPI2;
}


/**----------------------------------------------------------
 * main 関数
 *---------------------------------------------------------*/
int main(void)
{
    init_platform();
	usi_write(0x00000000, 0x00010000);
	usi_write(0x00000001, 0x00010004);
	usi_write(0x00000000, 0x00010008);
	usi_write(0x00000000, 0x0001000c);
	usi_write(0x00000000, 0x00010010);
	usi_write(0x00000000, 0x00010014);
	usi_write(0x00000000, 0x00010018);
	usi_write(0x0112A880, 0x0001001c);
	usi_write(0x015752A0, 0x00010020);
	usi_write(0x01C9C380, 0x00010024);
	usi_write(0x02AEA540, 0x00010028);
	usi_write(0x055D4A80, 0x0001002c);
	usi_write(0x0000001f, 0x00010000);
	//
	usi_write(0x00000003, 0x00040010);
	usi_write(0x00000003, 0x00060000);
	usi_write(0x00000000, 0x00060000);
	usi_write(0x0000000f, 0x00040010);
	usi_write(0x0000000e, 0x00040010);
	wait_time(100000);
	usi_write(0x0000000c, 0x00040010);
	usi_write(0x0000006f, 0x00040014);
	//
	usi_write(0x0000f000, 0x0004002c);
//	usi_write(0x0000001f, 0x00040030);
//	usi_write(0x00000001, 0x00040034);
	//

    while (1)
    {
		uint32_t rd;
		rd = usi_read(0x00040030);
		rd = usi_read(0x00044000);
    }

    xil_printf("Hello World\n\r");
    cleanup_platform();

    return 0;
}
