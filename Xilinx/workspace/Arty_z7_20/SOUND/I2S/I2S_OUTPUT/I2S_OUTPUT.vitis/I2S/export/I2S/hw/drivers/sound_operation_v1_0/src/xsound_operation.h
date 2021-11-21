// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XSOUND_OPERATION_H
#define XSOUND_OPERATION_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xsound_operation_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Control_BaseAddress;
} XSound_operation_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XSound_operation;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XSound_operation_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XSound_operation_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XSound_operation_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XSound_operation_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XSound_operation_Initialize(XSound_operation *InstancePtr, u16 DeviceId);
XSound_operation_Config* XSound_operation_LookupConfig(u16 DeviceId);
int XSound_operation_CfgInitialize(XSound_operation *InstancePtr, XSound_operation_Config *ConfigPtr);
#else
int XSound_operation_Initialize(XSound_operation *InstancePtr, const char* InstanceName);
int XSound_operation_Release(XSound_operation *InstancePtr);
#endif


void XSound_operation_Set_ramadr(XSound_operation *InstancePtr, u64 Data);
u64 XSound_operation_Get_ramadr(XSound_operation *InstancePtr);
void XSound_operation_Set_status(XSound_operation *InstancePtr, u32 Data);
u32 XSound_operation_Get_status(XSound_operation *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
