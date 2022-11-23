// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XFRAMEBUFFER_COPY_H
#define XFRAMEBUFFER_COPY_H

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
#include "xframebuffer_copy_hw.h"

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
} XFramebuffer_copy_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XFramebuffer_copy;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XFramebuffer_copy_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XFramebuffer_copy_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XFramebuffer_copy_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XFramebuffer_copy_ReadReg(BaseAddress, RegOffset) \
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
int XFramebuffer_copy_Initialize(XFramebuffer_copy *InstancePtr, u16 DeviceId);
XFramebuffer_copy_Config* XFramebuffer_copy_LookupConfig(u16 DeviceId);
int XFramebuffer_copy_CfgInitialize(XFramebuffer_copy *InstancePtr, XFramebuffer_copy_Config *ConfigPtr);
#else
int XFramebuffer_copy_Initialize(XFramebuffer_copy *InstancePtr, const char* InstanceName);
int XFramebuffer_copy_Release(XFramebuffer_copy *InstancePtr);
#endif

void XFramebuffer_copy_Start(XFramebuffer_copy *InstancePtr);
u32 XFramebuffer_copy_IsDone(XFramebuffer_copy *InstancePtr);
u32 XFramebuffer_copy_IsIdle(XFramebuffer_copy *InstancePtr);
u32 XFramebuffer_copy_IsReady(XFramebuffer_copy *InstancePtr);
void XFramebuffer_copy_EnableAutoRestart(XFramebuffer_copy *InstancePtr);
void XFramebuffer_copy_DisableAutoRestart(XFramebuffer_copy *InstancePtr);

void XFramebuffer_copy_Set_copy(XFramebuffer_copy *InstancePtr, u64 Data);
u64 XFramebuffer_copy_Get_copy(XFramebuffer_copy *InstancePtr);
void XFramebuffer_copy_Set_update(XFramebuffer_copy *InstancePtr, u64 Data);
u64 XFramebuffer_copy_Get_update(XFramebuffer_copy *InstancePtr);
void XFramebuffer_copy_Set_width(XFramebuffer_copy *InstancePtr, u32 Data);
u32 XFramebuffer_copy_Get_width(XFramebuffer_copy *InstancePtr);
void XFramebuffer_copy_Set_height(XFramebuffer_copy *InstancePtr, u32 Data);
u32 XFramebuffer_copy_Get_height(XFramebuffer_copy *InstancePtr);
void XFramebuffer_copy_Set_display_xsize(XFramebuffer_copy *InstancePtr, u32 Data);
u32 XFramebuffer_copy_Get_display_xsize(XFramebuffer_copy *InstancePtr);

void XFramebuffer_copy_InterruptGlobalEnable(XFramebuffer_copy *InstancePtr);
void XFramebuffer_copy_InterruptGlobalDisable(XFramebuffer_copy *InstancePtr);
void XFramebuffer_copy_InterruptEnable(XFramebuffer_copy *InstancePtr, u32 Mask);
void XFramebuffer_copy_InterruptDisable(XFramebuffer_copy *InstancePtr, u32 Mask);
void XFramebuffer_copy_InterruptClear(XFramebuffer_copy *InstancePtr, u32 Mask);
u32 XFramebuffer_copy_InterruptGetEnabled(XFramebuffer_copy *InstancePtr);
u32 XFramebuffer_copy_InterruptGetStatus(XFramebuffer_copy *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
