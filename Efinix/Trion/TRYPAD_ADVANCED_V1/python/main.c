#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdarg.h>
#include <signal.h>
#include "libmpsse-windows-1.0.7\release\libftd2xx\ftd2xx.h"
#include "libmpsse-windows-1.0.7\release\include\libmpsse_spi.h"

FT_HANDLE ft;

FT_STATUS write_mpsse(int num, ...) {
	FT_STATUS ret;
	va_list args;
	UCHAR outBuffer[10];
	ULONG written;
	va_start(args, num);
	for(int i=0; i<num; i++) {
		outBuffer[i] = va_arg(args, int);
	}
	ret = FT_Write(ft, outBuffer, num, &written);
	va_end(args);
	return ret;
}

void signal_handler(int signum) {
	FT_Close(ft);
	exit(0);
}

int main(void){
	signal(SIGINT, signal_handler);
	if( FT_Open(0, &ft) != FT_OK ) {
		fprintf(stderr, "Error\n");
		return 1;
	}

	FT_SetBitMode(ft, 0x00, FT_BITMODE_RESET);
	FT_SetBitMode(ft, (UCHAR)0xFF, FT_BITMODE_MPSSE); // MPSSE, all output
	FT_SetLatencyTimer(ft, 16);
	FT_SetTimeouts(ft, 1000, 1000);

	write_mpsse(1, 0x8A); // disable /5 divider
	write_mpsse(3, 0x86, 0x01, 0x00); // set clock diviser
	write_mpsse(3, 0x80, 0x08, 0x0B); // set pin direction SK, DO, CS for output

	uint16_t dat = 0;
	while(1){
		write_mpsse(3, 0x80, 0x00, 0x0B); // set pin direction SK, DO, CS for output
		write_mpsse(5, 0x10, 2, 0, 0x20 | (dat >> 8), dat & 0xFF);
		write_mpsse(1, 0x87); // set values immediately
		write_mpsse(3, 0x80, 0x08, 0x0B); // set pin direction SK, DO, CS for output
		dat += 128;
		if( dat >= 0x1000 ) {
			dat = 0;
		}
	}
	FT_Close(ft);
	return 0;
}