/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第8章                                   */
/* project: display                                 */
/* outline: ヘッダファイル化した画像の表示          */

#include "system.h"
#include "sys/alt_cache.h"
#include "altera_avalon_pio_regs.h"

#include "funamori.h"

#define DISPADDR PIO_0_BASE
#define CLRV_DON PIO_1_BASE
#define VBLANK   PIO_2_BASE
#define DISPON_BIT 0x01
#define CLRVB_BIT  0x02
#define VRAM ((volatile unsigned short *) 0x02000000)

/* VBLANK待ち */
void wait_vblank(void) {
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRV_DON, CLRVB_BIT);
    IOWR_ALTERA_AVALON_PIO_CLEAR_BITS(CLRV_DON, CLRVB_BIT);
    while (IORD_ALTERA_AVALON_PIO_DATA(VBLANK)==0);
}

int main()
{
    char *data = header_data;
    unsigned char pic[3];
    int i;

    /* ヘッダファイルからVRAMに読み込み */
    for ( i=0; i<width*height; i++ ) {
        HEADER_PIXEL(data, pic);
        VRAM[i] = ((pic[0] & 0xf0) << 4) | (pic[1] & 0xf0) | (pic[2] >> 4);
    }
    alt_dcache_flush_all();

    /* 表示をON */
    wait_vblank();
    IOWR_ALTERA_AVALON_PIO_DATA(DISPADDR, 0x02000000);
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRV_DON, DISPON_BIT);

  return 0;
}
