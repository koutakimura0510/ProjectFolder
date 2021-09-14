// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XPATBIT_H
#define XPATBIT_H

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
#include "xpatbit_hw.h"

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
} XPatbit_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XPatbit;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XPatbit_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XPatbit_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XPatbit_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XPatbit_ReadReg(BaseAddress, RegOffset) \
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
int XPatbit_Initialize(XPatbit *InstancePtr, u16 DeviceId);
XPatbit_Config* XPatbit_LookupConfig(u16 DeviceId);
int XPatbit_CfgInitialize(XPatbit *InstancePtr, XPatbit_Config *ConfigPtr);
#else
int XPatbit_Initialize(XPatbit *InstancePtr, const char* InstanceName);
int XPatbit_Release(XPatbit *InstancePtr);
#endif

void XPatbit_Start(XPatbit *InstancePtr);
u32 XPatbit_IsDone(XPatbit *InstancePtr);
u32 XPatbit_IsIdle(XPatbit *InstancePtr);
u32 XPatbit_IsReady(XPatbit *InstancePtr);
void XPatbit_EnableAutoRestart(XPatbit *InstancePtr);
void XPatbit_DisableAutoRestart(XPatbit *InstancePtr);

void XPatbit_Set_dstout(XPatbit *InstancePtr, u64 Data);
u64 XPatbit_Get_dstout(XPatbit *InstancePtr);
void XPatbit_Set_xpos(XPatbit *InstancePtr, u32 Data);
u32 XPatbit_Get_xpos(XPatbit *InstancePtr);
void XPatbit_Set_ypos(XPatbit *InstancePtr, u32 Data);
u32 XPatbit_Get_ypos(XPatbit *InstancePtr);
void XPatbit_Set_width(XPatbit *InstancePtr, u32 Data);
u32 XPatbit_Get_width(XPatbit *InstancePtr);
void XPatbit_Set_height(XPatbit *InstancePtr, u32 Data);
u32 XPatbit_Get_height(XPatbit *InstancePtr);
void XPatbit_Set_color(XPatbit *InstancePtr, u32 Data);
u32 XPatbit_Get_color(XPatbit *InstancePtr);

void XPatbit_InterruptGlobalEnable(XPatbit *InstancePtr);
void XPatbit_InterruptGlobalDisable(XPatbit *InstancePtr);
void XPatbit_InterruptEnable(XPatbit *InstancePtr, u32 Mask);
void XPatbit_InterruptDisable(XPatbit *InstancePtr, u32 Mask);
void XPatbit_InterruptClear(XPatbit *InstancePtr, u32 Mask);
u32 XPatbit_InterruptGetEnabled(XPatbit *InstancePtr);
u32 XPatbit_InterruptGetStatus(XPatbit *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
