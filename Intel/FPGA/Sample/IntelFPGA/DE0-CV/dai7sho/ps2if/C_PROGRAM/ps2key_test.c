/* Copyright(C) 2017 Cobac.Net All Rights Reserved.  */
/* chapter: 第7章                    */
/* project: ps2if                    */
/* outline: PS/2キーボード入力テスト */

#include "sys/alt_stdio.h"
#include "io.h"
#include "system.h"

unsigned char chgcode( unsigned char code );

/* キーコード変換用配列 */
const unsigned char keytbl[128][2] = {
    {0x16, '1'}, {0x1e, '2'}, {0x26, '3'}, {0x25, '4'},
    {0x2e, '5'}, {0x36, '6'}, {0x3d, '7'}, {0x3e, '8'},
    {0x46, '9'}, {0x45, '0'}, {0x4e, '-'}, {0x55, '^'},
    {0x6a, '\\'},{0x15, 'q'}, {0x1d, 'w'}, {0x24, 'e'},
    {0x2d, 'r'}, {0x2c, 't'}, {0x35, 'y'}, {0x3c, 'u'},
    {0x43, 'i'}, {0x44, 'o'}, {0x4d, 'p'}, {0x54, '@'},
    {0x5b, '['}, {0x1c, 'a'}, {0x1b, 's'}, {0x23, 'd'},
    {0x2b, 'f'}, {0x34, 'g'}, {0x33, 'h'}, {0x3b, 'j'},
    {0x42, 'k'}, {0x4b, 'l'}, {0x4c, ';'}, {0x52, ':'},
    {0x5d, ']'}, {0x1a, 'z'}, {0x22, 'x'}, {0x21, 'c'},
    {0x2a, 'v'}, {0x32, 'b'}, {0x31, 'n'}, {0x3a, 'm'},
    {0x41, ','}, {0x49, '.'}, {0x4a, '/'}, {0x51, '\\'},
    {0x29, ' '} };

#define VALID   0x01
#define KYCDMAX 49  /* 配列に用意したキーコードの数 */

int main()
{ 
    int ps2in;
    int postF0=0;

    while(1) {
        while ( (IORD_8DIRECT(PS2IF_IP_0_BASE, 0) & VALID)==0 );
        IOWR_8DIRECT(PS2IF_IP_0_BASE, 0, 0);
        ps2in = IORD_8DIRECT(PS2IF_IP_0_BASE, 1) & 0xff;
        if ( ps2in==0xf0 )  /* F0とその直後は表示しない */
            postF0 = 1;
        else if ( postF0==1 )
            postF0 = 0;
        else
            alt_printf("%c", chgcode(ps2in));
   }
   return 0;
}

/* キーコードの変換 */
unsigned char chgcode( unsigned char code )
{
    int i;

    for ( i=0; i<KYCDMAX; i++ ) {
        if ( keytbl[i][0]==code )
            break;
    }

    if ( i>=KYCDMAX )
        return 0x00;
    else
        return keytbl[i][1];
}
