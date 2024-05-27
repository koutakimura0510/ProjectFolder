#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char path[] = " >> sample.txt";

int main(int argc, char **argv)
{
    char command[50] = "xxd -p ";

    if (!argv[1]) {
        printf("file error\n");
        return 1;
    }

    strcat(command, argv[1]);
    strcat(command, path);

    if (system(command) == -1) {
        printf("コマンドエラー\n");
    }

    return 0;
}