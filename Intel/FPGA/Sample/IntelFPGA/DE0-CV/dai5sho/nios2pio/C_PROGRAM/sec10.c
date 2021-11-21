/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: ëÊ5èÕâ€ëË  */
/* project: nios2pio   */
/* outline: 1ïbåÖ      */

#include "system.h"
#include "altera_avalon_pio_regs.h"

#define MAX 3400000

int main()
{
    int in, out;
    int cnt=0, i;

    while (1) {
        in = IORD_ALTERA_AVALON_PIO_DATA(PIO_1_BASE);
        if ( (in & 0x02) != 0 ) {
            cnt = 0;
        }
        else if ( (in & 0x01) != 0 ) {
            for ( i=0; i<MAX; i++ );
            cnt++;
        }
        switch ( cnt % 10 ) {
            case 0x0: out = 0xc0; break;
            case 0x1: out = 0xf9; break;
            case 0x2: out = 0xa4; break;
            case 0x3: out = 0xb0; break;
            case 0x4: out = 0x99; break;
            case 0x5: out = 0x92; break;
            case 0x6: out = 0x82; break;
            case 0x7: out = 0xd8; break;
            case 0x8: out = 0x80; break;
            case 0x9: out = 0x90; break;
            default:  out = 0xff; break;
        }
        IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, out);
    }
    return 0;
}
