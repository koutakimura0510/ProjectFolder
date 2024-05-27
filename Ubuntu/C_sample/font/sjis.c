/*
 * Ubuntu20.04 漢字フォントアドレス検索
 */
#include <stdio.h>
#include <stdint.h>
#include "KanjiFont12.h"


void sjis(char *str)
{
    uint32_t sjis;

    while (str[0] != '\0')
    {
        printf("%s\n", str);
        printf("dec = %d, hex = 0x%x\n", str[0] & 0xff, str[0] & 0xff);
        printf("dec = %d, hex = 0x%x\n", str[1] & 0xff, str[1] & 0xff);

        sjis = (((*str & 0xff) - 129) * 188) + (*(str + 1) & 0xff);

        if (*(str+1) < 0x80) {
            printf("0 number\n");
            sjis = sjis - 64;
        }
        else
        {
            printf("1 number\n");
            sjis = sjis - 65;
        }

        printf("Index = %d\n", sjis);
        str += 2;
    }
}


int main(int argc, char **argv)
{
    //240
    char str[] = "穣子";

    sjis(str);

    return 0;
}