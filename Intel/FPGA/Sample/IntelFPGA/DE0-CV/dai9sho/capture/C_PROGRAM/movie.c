/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第9章                  */
/* project: capture                */
/* outline: 動画記録再生プログラム */

#include "system.h"
#include "altera_avalon_pio_regs.h"

#include "ov7725.h"

#define DISPADDR PIO_0_BASE
#define CLRV_DON PIO_1_BASE
#define VBLANK   PIO_2_BASE

#define CAPADDR  PIO_3_BASE
#define CLRC_CON PIO_4_BASE
#define CBLANK   PIO_5_BASE

#define ON_BIT  0x01
#define CLR_BIT 0x02

#define SCCBREG  SCCB_0_BASE
#define SCCBSTAT (SCCB_0_BASE + 0x02)
#define SCCBBUSY 1

#define PICBEGIN 0x00100000
#define PICSIZE  640*480*2
#define PICNUM   107

/* VBLANK待ち */
void wait_vblank(void) {
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRV_DON, CLR_BIT);
    IOWR_ALTERA_AVALON_PIO_CLEAR_BITS(CLRV_DON, CLR_BIT);
    while (IORD_ALTERA_AVALON_PIO_DATA(VBLANK)==0);
}

/* CBLANK待ち */
void wait_cblank(void) {
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRC_CON, CLR_BIT);
    IOWR_ALTERA_AVALON_PIO_CLEAR_BITS(CLRC_CON, CLR_BIT);
    while (IORD_ALTERA_AVALON_PIO_DATA(CBLANK)==0);
}

/* SCCB経由でカメラの設定レジスタに書き込み */
void sccb_write( int data )
{
    while ((IORD_16DIRECT(SCCBSTAT, 0) & SCCBBUSY) != 0);
    IOWR_16DIRECT(SCCBREG, 0, data);
}

/* センサーチップOV7725の初期化 */
void ov7725_init( void )
{
    int i=0;
    int data=init_data[0];

    while ( data!=0xffff ) {
        sccb_write( data );
        data = init_data[++i];
    }
    while ((IORD_ALTERA_AVALON_PIO_DATA(SCCBSTAT) & SCCBBUSY) != 0);
}

int main()
{
    int i;
    ov7725_init();

    /* 表示ON */
    wait_vblank();
    IOWR_ALTERA_AVALON_PIO_DATA(DISPADDR, PICBEGIN);
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRV_DON, ON_BIT);

    /* キャプチャON */
    wait_cblank();
    IOWR_ALTERA_AVALON_PIO_DATA(CAPADDR, PICBEGIN);
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRC_CON, ON_BIT);

    /* 動画記録 */
    for ( i=0; i<PICNUM; i++ ) {    /* ★この行にブレークポイントを置く★ */
        wait_cblank();
        IOWR_ALTERA_AVALON_PIO_DATA(CAPADDR, PICBEGIN+PICSIZE*i);
    }

    /* キャプチャOFF */
    wait_cblank();
    IOWR_ALTERA_AVALON_PIO_CLEAR_BITS(CLRC_CON, ON_BIT);

    /* 動画再生（無限に繰り返す） */
    while (1) {
        for ( i=0; i<PICNUM; i++ ) {
            wait_vblank();
            wait_vblank();
            IOWR_ALTERA_AVALON_PIO_DATA(DISPADDR, PICBEGIN+PICSIZE*i);
        }
    }

    return 0;
}
