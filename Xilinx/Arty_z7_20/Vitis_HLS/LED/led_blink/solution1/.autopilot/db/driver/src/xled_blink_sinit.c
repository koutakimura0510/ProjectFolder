// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xled_blink.h"

extern XLed_blink_Config XLed_blink_ConfigTable[];

XLed_blink_Config *XLed_blink_LookupConfig(u16 DeviceId) {
	XLed_blink_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XLED_BLINK_NUM_INSTANCES; Index++) {
		if (XLed_blink_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XLed_blink_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XLed_blink_Initialize(XLed_blink *InstancePtr, u16 DeviceId) {
	XLed_blink_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XLed_blink_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XLed_blink_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

