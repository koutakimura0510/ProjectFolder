/* Copyright(C) 2017 Cobac.Net All Rights Reserved.  */
/* chapter: 第7章                       */
/* project: vgaif                       */
/* outline: VGA文字表示回路の表示テスト */

#include "system.h"
#include "io.h"

/* X, Yサイズ */
#define XSIZE 80
#define YSIZE 50

int main()
{
    int x, y;

    /* 全文字と全色を表示 */
    for ( x=0; x<XSIZE*YSIZE; x++ ) {
        IOWR_32DIRECT(VGAIF_IP_0_BASE, x*4, (x<<16)+x);
    }

    /* 1行上にスクロール */
    for ( y=0; y<YSIZE; y++ ) {     /* ★この行にブレークポイントを置く★ */
        for ( x=0; x<XSIZE; x++ ){
            if ( y != YSIZE-1 ) {
                IOWR_32DIRECT(VGAIF_IP_0_BASE, (x+y*XSIZE)*4,
                    IORD_32DIRECT(VGAIF_IP_0_BASE, (x+(y+1)*XSIZE)*4));
            }
            else
                IOWR_32DIRECT(VGAIF_IP_0_BASE, (x+y*XSIZE)*4, 0x0fff0020);
        }
    }

    /* 色だけ白に変更 */
    for ( y=0; y<YSIZE; y++ ) {     /* ★この行にブレークポイントを置く★ */
        for ( x=0; x<XSIZE; x++ ){
            IOWR_16DIRECT(VGAIF_IP_0_BASE, (x+y*XSIZE)*4+2, 0x0fff);
        }
    }

    return 0;
}
