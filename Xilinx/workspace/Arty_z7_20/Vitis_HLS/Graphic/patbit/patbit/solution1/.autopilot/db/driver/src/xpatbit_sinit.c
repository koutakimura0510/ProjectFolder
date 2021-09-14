// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xpatbit.h"

extern XPatbit_Config XPatbit_ConfigTable[];

XPatbit_Config *XPatbit_LookupConfig(u16 DeviceId) {
	XPatbit_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XPATBIT_NUM_INSTANCES; Index++) {
		if (XPatbit_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XPatbit_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XPatbit_Initialize(XPatbit *InstancePtr, u16 DeviceId) {
	XPatbit_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XPatbit_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XPatbit_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

