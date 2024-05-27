/* Copyright(C) 2017 Cobac.Net All Rights Reserved.       */
/* chapter: 第6章課題              */
/* project: nios2clock1            */
/* outline: Nios IIを使った1時間計 */

#include "system.h"
#include "io.h"
#include "altera_avalon_timer_regs.h"
#include "sys/alt_irq.h"
#include "sys/alt_stdio.h"

#define PERIOD (50000000-1)

int seg7dec( int );

int sec = 0;
int min = 0;

/* 割り込み処理ルーチン */
void alarm_callback( void* context )
{
    int in;
    sec++;
    if ( sec>=60 ) {
        sec = 0;
        min++;
    }
    in = IORD_32DIRECT(MYPIO_0_BASE, 4);
    if ( (in & 1)==0 )
        min++;
    if ( (in & 2)==0 ) {
        sec = 0;
        min = 0;
    }
    if ( min>=60 )
        min = 0;
    IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0);
    alt_printf("min=%x sec=%x in=%x\n", min, sec, in);
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
        out = (seg7dec(min/10) << 24) | (seg7dec(min%10) << 16) |
              (seg7dec(sec/10) <<  8) |  seg7dec(sec%10);
        IOWR_32DIRECT(MYPIO_0_BASE, 0, out);
    }
    return 0;
}

/* 7セグメントデコーダ */
int seg7dec( int in )
{
    switch ( in ) {
        case 0x0: return 0x40;
        case 0x1: return 0x79;
        case 0x2: return 0x24;
        case 0x3: return 0x30;
        case 0x4: return 0x19;
        case 0x5: return 0x12;
        case 0x6: return 0x02;
        case 0x7: return 0x58;
        case 0x8: return 0x00;
        case 0x9: return 0x10; 
        default : return 0xff;
    }
}
