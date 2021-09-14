// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xbackground_loop.h"

extern XBackground_loop_Config XBackground_loop_ConfigTable[];

XBackground_loop_Config *XBackground_loop_LookupConfig(u16 DeviceId) {
	XBackground_loop_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XBACKGROUND_LOOP_NUM_INSTANCES; Index++) {
		if (XBackground_loop_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XBackground_loop_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XBackground_loop_Initialize(XBackground_loop *InstancePtr, u16 DeviceId) {
	XBackground_loop_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XBackground_loop_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XBackground_loop_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

