// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xmuladd.h"

extern XMuladd_Config XMuladd_ConfigTable[];

XMuladd_Config *XMuladd_LookupConfig(u16 DeviceId) {
	XMuladd_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XMULADD_NUM_INSTANCES; Index++) {
		if (XMuladd_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XMuladd_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMuladd_Initialize(XMuladd *InstancePtr, u16 DeviceId) {
	XMuladd_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMuladd_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMuladd_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

