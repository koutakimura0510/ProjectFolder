// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XLED_BLINK_H
#define XLED_BLINK_H

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
#include "xled_blink_hw.h"

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
} XLed_blink_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XLed_blink;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XLed_blink_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XLed_blink_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XLed_blink_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XLed_blink_ReadReg(BaseAddress, RegOffset) \
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
int XLed_blink_Initialize(XLed_blink *InstancePtr, u16 DeviceId);
XLed_blink_Config* XLed_blink_LookupConfig(u16 DeviceId);
int XLed_blink_CfgInitialize(XLed_blink *InstancePtr, XLed_blink_Config *ConfigPtr);
#else
int XLed_blink_Initialize(XLed_blink *InstancePtr, const char* InstanceName);
int XLed_blink_Release(XLed_blink *InstancePtr);
#endif


void XLed_blink_Set_onoff_offset(XLed_blink *InstancePtr, u64 Data);
u64 XLed_blink_Get_onoff_offset(XLed_blink *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
