// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xaffine_scale.h"

extern XAffine_scale_Config XAffine_scale_ConfigTable[];

XAffine_scale_Config *XAffine_scale_LookupConfig(u16 DeviceId) {
	XAffine_scale_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XAFFINE_SCALE_NUM_INSTANCES; Index++) {
		if (XAffine_scale_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XAffine_scale_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XAffine_scale_Initialize(XAffine_scale *InstancePtr, u16 DeviceId) {
	XAffine_scale_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XAffine_scale_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XAffine_scale_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

