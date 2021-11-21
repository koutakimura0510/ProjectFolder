/* Copyright(C) 2017 Cobac.Net All Rights Reserved.  */
/* chapter: 第7章課題                      */
/* project: ps2if                          */
/* outline: スクロールホイール・マウス対応 */

#include "sys/alt_stdio.h"
#include "io.h"
#include "system.h"

#define DVALID  0x01
#define EMPTY   0x02

void putdata( int data );
int getdata(void);
int seg7dec( int indata );

int main()
{
    int data1, data2, data3, data4, L, R;
    int posx=0, posy=0, posz=0, dx, dy, dz;
    int piodata=0x40404040;
    IOWR_32DIRECT(PIO_0_BASE, 0, piodata);   /* 7セグ表示をすべて0に初期化 */

    putdata(0xFF);      /* リセットコマンド送信 */
    data1 = getdata();  /* マウス応答を受信（チェックしない） */
    data2 = getdata();
    data3 = getdata();
    // alt_printf("res1=%x %x %x\n", data1, data2, data3);

    putdata(0xF3);      /* セットサンプルレート送信 */
    data1 = getdata();  /* マウス応答を受信（チェックしない） */
    putdata(0xC8);      /* サンプルレート200 */
    data1 = getdata();  /* マウス応答を受信（チェックしない） */

    putdata(0xF3);      /* セットサンプルレート送信 */
    data1 = getdata();  /* マウス応答を受信（チェックしない） */
    putdata(0x64);      /* サンプルレート100 */
    data1 = getdata();  /* マウス応答を受信（チェックしない） */

    putdata(0xF3);      /* セットサンプルレート送信 */
    data1 = getdata();  /* マウス応答を受信（チェックしない） */
    putdata(0x50);      /* サンプルレート80 */
    data1 = getdata();  /* マウス応答を受信（チェックしない） */

    putdata(0xF2);      /* ID読み出し送信 */
    data1 = getdata();  /* マウス応答を受信（チェックしない） */
    data1 = getdata();  /* ID応答を受信 */
    alt_printf("ID=%x\n", data1);


    putdata(0xF4);      /* イネーブルコマンド送信 */
    data1 = getdata();  /* マウス応答を受信（チェックしない） */
    // alt_printf("res2=%x\n", data1);

    while(1) {
        /* マウスから4データ受信 */
        data1 = getdata();
        data2 = getdata();
        data3 = getdata();
        data4 = getdata();

        /* X、Yの符号ビットを取り出し、9ビットの移動量とする */
        if ( (data1 & 0x10) != 0)
            dx = data2 | 0xffffff00;
        else
            dx = data2;
        if ( (data1 & 0x20) != 0)
            dy = data3 | 0xffffff00;
        else
            dy = data3;

        /* 移動量を現在位置に加算 */
        posx = posx + dx;
        posy = posy + dy;

        /* 左右ボタンの検出 */
        L = ( (data1 & 0x01) != 0) ? 1: 0;
        R = ( (data1 & 0x02) != 0) ? 1: 0;
        // alt_printf("dx=%x dy=%x L=%x R=%x\n", dx, dy, L, R);

        /* スクロールホイール */
        dz = data4;
        posz = posz + dz;


        /* 表示用のデータ作り（現在位置） */
        piodata = seg7dec((posx >> 4) & 0x0f);
        piodata = (piodata <<8) | (seg7dec(posx & 0x0f)        & 0xff);
/*
        piodata = (piodata <<8) | (seg7dec((posy >> 4) & 0x0f) & 0xff);
        piodata = (piodata <<8) | (seg7dec(posy & 0x0f)        & 0xff);
*/

        piodata = (piodata <<8) | (seg7dec((posz >> 4) & 0x0f) & 0xff);
        piodata = (piodata <<8) | (seg7dec(posz & 0x0f)        & 0xff);

        /* 表示用のデータ作り（左右ボタン） */
        if ( L==1 )
            piodata |= 0x00008000;
        if ( R==1 )
            piodata |= 0x00000080;
        if ( L==1 && R==1 )
            posx = posy = posz = 0;    /* 両方押されたら現在位置をリセット */

        /* PIOに書き込んで表示 */
        IOWR_32DIRECT(PIO_0_BASE, 0, piodata);
    }
    return 0;
}

/* マウスへ1バイト送出 */
void putdata( int data )
{
    while ( (IORD_8DIRECT(PS2IF_IP_0_BASE, 0) & EMPTY)==0 );
    IOWR_8DIRECT(PS2IF_IP_0_BASE, 2, data);
}

/* マウスから1バイト受信 */
int getdata(void)
{
    int ps2in = 0;
    while ( (ps2in & DVALID)==0 ) {
        ps2in=IORD_8DIRECT(PS2IF_IP_0_BASE, 0);
    }
    ps2in &= ~DVALID;
    IOWR_8DIRECT(PS2IF_IP_0_BASE, 0, ps2in);
    return IORD_8DIRECT(PS2IF_IP_0_BASE, 1);
}

/* 7セグメント・デコーダ */
int seg7dec( int indata )
{
    int temp;
    switch ( indata ) {
        case 0x0: temp = 0x40; break;
        case 0x1: temp = 0x79; break;
        case 0x2: temp = 0x24; break;
        case 0x3: temp = 0x30; break;
        case 0x4: temp = 0x19; break;
        case 0x5: temp = 0x12; break;
        case 0x6: temp = 0x02; break;
        case 0x7: temp = 0x58; break;
        case 0x8: temp = 0x00; break;
        case 0x9: temp = 0x10; break;
        case 0xA: temp = 0x08; break;
        case 0xB: temp = 0x03; break;
        case 0xC: temp = 0x46; break;
        case 0xD: temp = 0x21; break;
        case 0xE: temp = 0x06; break;
        case 0xF: temp = 0x0e; break;
        default:  temp = 0x7f; break;
    }

    return temp;
}
