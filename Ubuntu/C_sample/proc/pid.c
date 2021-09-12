#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>

int main(void)
{
    pid_t pid;

    printf("root getpid:%d\n", getpid());
    printf("root getpid:%d\n", getppid());

    pid = fork();

    if (pid < 0)
    {
        fprintf(stderr, "Error fork %d\n", errno);
        exit(EXIT_FAILURE);
    }
    else if (pid = 0)
    {
        /* code */
    }
    else
    {

    }
    
    return 0;
}