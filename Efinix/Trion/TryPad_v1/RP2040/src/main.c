#include <stdio.h>
#include "pico/stdlib.h"

int main() {
	// pico_sdk_init()
	setup_default_uart();
	printf("Hello, world!\n");
	
	return 0;
}