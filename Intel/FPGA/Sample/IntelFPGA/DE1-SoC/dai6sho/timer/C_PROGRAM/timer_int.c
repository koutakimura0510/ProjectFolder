/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第6章                        */
/* project: timer                        */
/* outline: 割り込みによるタイマー制御   */

#include "system.h"
#include "altera_avalon_timer_regs.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"

#define PERIOD (50000000-1)

int cnt = 0;

/* 割り込み処理ルーチン */
void alarm_callback( void* context )
{
    cnt++;
    IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0);
}

int main()
{
    int out;

    /* 割り込みとタイマーの初期化 */
    alt_ic_isr_register( TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID, TIMER_0_IRQ,
            alarm_callback, (void *)0, (void *)0 );
    IOWR_ALTERA_AVALON_TIMER_PERIODL(TIMER_0_BASE, PERIOD & 0xffff);
    IOWR_ALTERA_AVALON_TIMER_PERIODH(TIMER_0_BASE, PERIOD >> 16);
    IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,
        ALTERA_AVALON_TIMER_CONTROL_ITO_MSK  |
        ALTERA_AVALON_TIMER_CONTROL_CONT_MSK |
        ALTERA_AVALON_TIMER_CONTROL_START_MSK );

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
