/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: ëÊ6èÕ           */
/* project: nios2mypio      */
/* outline: é©çÏPIOÇÃÉeÉXÉg */

#include "system.h"
#include "io.h"

int main()
{
    int in, out;

    while (1) {
        in = IORD_8DIRECT(MYPIO_0_BASE, 1);
        switch ( in ) {
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
            case 0xA: out = 0x08; break;
            case 0xB: out = 0x03; break;
            case 0xC: out = 0x46; break;
            case 0xD: out = 0x21; break;
            case 0xE: out = 0x06; break;
            case 0xF: out = 0x0e; break;
            default:  out = 0x7f; break;
        }

        IOWR_8DIRECT(MYPIO_0_BASE, 0, out);
    }
    return 0;
}
