/*
 * 16進数文字列を変換する
 */

#include <stdio.h>
#include <stdint.h>


int main(void)
{
    // uint32_t d = 0;
    // const char str[] = "0xff123456";
    // const char *p = str;
    // uint8_t s[2];

    // printf("str = %s\n", p);
    // p = p + 2;

    // for (uint8_t j = 0; j < 4; j++)
    // {
    //     for (uint8_t i = 0; i < 2; i++, p++)
    //     {
    //         if (('0' <= *p) && (*p <= '9'))
    //         {
    //             s[i & 0x01] = (*p - '0');
    //         }else{
    //             s[i & 0x01] = (*p - 'a') + 10;
    //         }
    //     }
    //     d |= ((s[0] << 4) | s[1]) << (24 - (j << 3));
    //     printf("d = 0x%2x\n", d);
    // }

    uint32_t d;
    const char str[] = "0xff123456";
    const char *p = str;

    printf("str = %s\n", p);
    p = p + 2;

    for (uint8_t i = 0; i < 8; i++, p++)
    {
        d <<= 4;
        if (('0' <= *p) && (*p <= '9'))
        {
            d |= (*p - '0');
        }else{
            d |= (*p - 'a' + 10);
        }
        printf("d = 0x%8x\n", d);
    }
    printf("return = 0x%x\n", d);

    return 0;
}