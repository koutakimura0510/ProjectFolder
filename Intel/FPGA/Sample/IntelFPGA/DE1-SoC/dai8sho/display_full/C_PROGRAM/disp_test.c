/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第8章                                   */
/* project: display                                 */
/* outline: グラフィック表示回路のテストプログラム  */
/* board  : DE1-SoC 24bitフルカラー対応版           */

#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_cache.h"

#define DISPADDR PIO_0_BASE
#define CLRV_DON PIO_1_BASE
#define VBLANK   PIO_2_BASE
#define DISPON_BIT 0x01
#define CLRVB_BIT  0x02

#define XSIZE 640
#define YSIZE 480
#define VRAM ((volatile unsigned int *) 0x02000000)

/* VBLANK待ち */
void wait_vblank(void) {
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRV_DON, CLRVB_BIT);
    IOWR_ALTERA_AVALON_PIO_CLEAR_BITS(CLRV_DON, CLRVB_BIT);
    while (IORD_ALTERA_AVALON_PIO_DATA(VBLANK)==0);
}

/* 原点（xpos, ypos)、大きさ（width, height）、色（color）を指定して箱を書く */
void drawbox( int xpos, int ypos, int width, int height, int col ) {
    int x, y;

    for ( x=xpos; x<xpos+width; x++ ) {
        VRAM[ ypos*XSIZE + x ] = col;
        VRAM[ (ypos+height-1)*XSIZE + x ] = col;
    }
    for ( y=ypos; y<ypos+height; y++ ) {
        VRAM[ y*XSIZE + xpos ] = col;
        VRAM[ y*XSIZE + xpos + width -1 ] = col;
    }
}

int main()
{
    int i;

    /* 表示ON */
    wait_vblank();
    IOWR_ALTERA_AVALON_PIO_DATA(DISPADDR, 0x02000000);
    IOWR_ALTERA_AVALON_PIO_SET_BITS(CLRV_DON, DISPON_BIT);

    /* 画面クリア */
    for ( i=0; i<XSIZE*YSIZE; i++) {         /* ★この行にブレークポイントを置く */
        VRAM[i] = 0;
    }
    alt_dcache_flush_all();

    /* 枠線をいくつか引いてみる */
    drawbox(  0,   0, 640, 480, 0x00ffffff); /* ★この行にブレークポイントを置く */
    drawbox( 10,  10, 200, 100, 0x00ff0000); // R
    drawbox( 40,  30, 150, 300, 0x0000ff00); // G
    drawbox(100, 150, 400, 300, 0x000000ff); // B
    alt_dcache_flush_all();

    /* 縞模様を書く */
    for ( i=0; i<XSIZE*YSIZE; i++) {         /* ★この行にブレークポイントを置く */
        VRAM[i] = i;
    }
    alt_dcache_flush_all();

    return 0;
}
