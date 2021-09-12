#include <stdio.h>
#include <string.h>




int main(void)
{
	char path[100];
	char *raw  = ".raw";
	char *str  = "abc";

	for (int i = 0; i < 100; i++)
	{
		path[i] = '\0';
	}

	strcat(path, str);
	strcat(path, raw);
	puts(path);

	return 0;
}