/* Copyright(C) 2017 Cobac.Net All Rights Reserved.  */
/* chapter: 第8章             */
/* project: sdram             */
/* outline: sdramの簡易テスト */

#include "sys/alt_stdio.h"
#include "sys/alt_cache.h"
#include "system.h"

/* アドレスを直接指定しマクロを配列のように扱えるよう定義 */
#define SDRAM_C ((volatile unsigned char  *) NEW_SDRAM_CONTROLLER_0_BASE)
#define SDRAM_S ((volatile unsigned short *) NEW_SDRAM_CONTROLLER_0_BASE)
#define SDRAM_I ((volatile unsigned int   *) NEW_SDRAM_CONTROLLER_0_BASE)

#define MEMSIZE 0x04000000

int main()
{
    int i, err=0;
    unsigned int i1, i2, i3;
    unsigned int ary[3];

    /* SDRAMに書き込む値 */
    ary[0] = 0x47bd9f6a;
    ary[1] = 0x1e806c95;
    ary[2] = 0x2fdc3a5c;

    /* BYTE書き込み */
    alt_printf("BYTE Checking...\n");

    for ( i=0; i<MEMSIZE-3; i=i+3 ) {
        SDRAM_C[i]   = ary[0];
        SDRAM_C[i+1] = ary[1];
        SDRAM_C[i+2] = ary[2];
    }
    alt_dcache_flush_all();

    /* BYTE読み出し */
    for ( i=0; i<MEMSIZE-3; i=i+3 ) {
        i1 = SDRAM_C[i];
        i2 = SDRAM_C[i+1];
        i3 = SDRAM_C[i+2];
        if ( i1 != (ary[0] & 0xff) ) err=1;
        if ( i2 != (ary[1] & 0xff) ) err=1;
        if ( i3 != (ary[2] & 0xff) ) err=1;
    }

    /* SHORT書き込み */
    alt_printf("SHORT Checking...\n");

    for ( i=0; i<MEMSIZE/2-3; i=i+3 ) {
        SDRAM_S[i]   = ary[0];
        SDRAM_S[i+1] = ary[1];
        SDRAM_S[i+2] = ary[2];
    }
    alt_dcache_flush_all();

    /* SHORT読み出し */
    for ( i=0; i<MEMSIZE/2-3; i=i+3 ) {
        i1 = SDRAM_S[i];
        i2 = SDRAM_S[i+1];
        i3 = SDRAM_S[i+2];
        if ( i1 != (ary[0] & 0xffff) ) err=1;
        if ( i2 != (ary[1] & 0xffff) ) err=1;
        if ( i3 != (ary[2] & 0xffff) ) err=1;
    }

    /* INT書き込み */
    alt_printf("INT Checking...\n");

    for ( i=0; i<MEMSIZE/4-3; i=i+3 ) {
        SDRAM_I[i]   = ary[0];
        SDRAM_I[i+1] = ary[1];
        SDRAM_I[i+2] = ary[2];
    }
    alt_dcache_flush_all();

    /* INT読み出し */
    for ( i=0; i<MEMSIZE/4-3; i=i+3 ) {
        i1 = SDRAM_I[i];
        i2 = SDRAM_I[i+1];
        i3 = SDRAM_I[i+2];
        if ( i1 != ary[0] ) err=1;
        if ( i2 != ary[1] ) err=1;
        if ( i3 != ary[2] ) err=1;
    }

    /* 結果表示 */
    if ( err==1 )
        alt_printf("NG!\n");
    else
        alt_printf("OK! Checking End.\n");

    return 0;
}
