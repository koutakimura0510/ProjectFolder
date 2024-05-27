#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    char command[] = "echo 23 > sample.txt";

    if (system(command) != 0) {
        printf("command error\n");
    }
    
    printf("プログラムを終了します\n");

    return 0;
}