// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xsound_operation.h"

extern XSound_operation_Config XSound_operation_ConfigTable[];

XSound_operation_Config *XSound_operation_LookupConfig(u16 DeviceId) {
	XSound_operation_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XSOUND_OPERATION_NUM_INSTANCES; Index++) {
		if (XSound_operation_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XSound_operation_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XSound_operation_Initialize(XSound_operation *InstancePtr, u16 DeviceId) {
	XSound_operation_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XSound_operation_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XSound_operation_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

