/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第6章                   */
/* project: timer                   */
/* outline: HALを用いたタイマー制御 */

#include "stddef.h"
#include "sys/alt_stdio.h"
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_alarm.h"

int cnt;

/* 1秒ごとに呼び出される関数 */
alt_u32 alarm_callback( void* context )
{
    cnt++;
    return alt_ticks_per_second();
}

int main()
{
    int out;
    alt_alarm alarm;
    cnt = 0;

    /* 一定時間ごとに呼び出す関数と時間などを登録 */
    if ( alt_alarm_start( &alarm, alt_ticks_per_second(),
                          alarm_callback, NULL ) <0 )
        alt_printf("Timer Error!!");
    else
        alt_printf("OK!");

    while (1) {
        /* 表示 */
        switch ( cnt % 10 ) {
            case 0x0: out = 0x40; break;
            case 0x1: out = 0x79; break;
            case 0x2: out = 0x24; break;
            case 0x3: out = 0x30; break;
            case 0x4: out = 0x19; break;
            case 0x5: out = 0x12; break;
            case 0x6: out = 0x02; break;
            case 0x7: out = 0x58; break;
            case 0x8: out = 0x00; break;
            case 0x9: out = 0x10; break;
            default:  out = 0x7f; break;
        }
        IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, out);
    }
    return 0;
}
