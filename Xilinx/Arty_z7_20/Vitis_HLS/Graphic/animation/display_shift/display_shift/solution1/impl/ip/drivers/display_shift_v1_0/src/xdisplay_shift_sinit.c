// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xdisplay_shift.h"

extern XDisplay_shift_Config XDisplay_shift_ConfigTable[];

XDisplay_shift_Config *XDisplay_shift_LookupConfig(u16 DeviceId) {
	XDisplay_shift_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XDISPLAY_SHIFT_NUM_INSTANCES; Index++) {
		if (XDisplay_shift_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XDisplay_shift_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XDisplay_shift_Initialize(XDisplay_shift *InstancePtr, u16 DeviceId) {
	XDisplay_shift_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XDisplay_shift_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XDisplay_shift_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

