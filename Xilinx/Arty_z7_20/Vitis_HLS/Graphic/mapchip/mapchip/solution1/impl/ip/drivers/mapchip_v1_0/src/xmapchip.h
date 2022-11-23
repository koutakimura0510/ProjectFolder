// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XMAPCHIP_H
#define XMAPCHIP_H

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
#include "xmapchip_hw.h"

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
} XMapchip_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XMapchip;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XMapchip_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XMapchip_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XMapchip_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XMapchip_ReadReg(BaseAddress, RegOffset) \
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
int XMapchip_Initialize(XMapchip *InstancePtr, u16 DeviceId);
XMapchip_Config* XMapchip_LookupConfig(u16 DeviceId);
int XMapchip_CfgInitialize(XMapchip *InstancePtr, XMapchip_Config *ConfigPtr);
#else
int XMapchip_Initialize(XMapchip *InstancePtr, const char* InstanceName);
int XMapchip_Release(XMapchip *InstancePtr);
#endif

void XMapchip_Start(XMapchip *InstancePtr);
u32 XMapchip_IsDone(XMapchip *InstancePtr);
u32 XMapchip_IsIdle(XMapchip *InstancePtr);
u32 XMapchip_IsReady(XMapchip *InstancePtr);
void XMapchip_EnableAutoRestart(XMapchip *InstancePtr);
void XMapchip_DisableAutoRestart(XMapchip *InstancePtr);

void XMapchip_Set_srcin(XMapchip *InstancePtr, u64 Data);
u64 XMapchip_Get_srcin(XMapchip *InstancePtr);
void XMapchip_Set_dstin(XMapchip *InstancePtr, u64 Data);
u64 XMapchip_Get_dstin(XMapchip *InstancePtr);
void XMapchip_Set_dstout(XMapchip *InstancePtr, u64 Data);
u64 XMapchip_Get_dstout(XMapchip *InstancePtr);
void XMapchip_Set_mapchip_maxwidth(XMapchip *InstancePtr, u32 Data);
u32 XMapchip_Get_mapchip_maxwidth(XMapchip *InstancePtr);
void XMapchip_Set_mapchip_maxheight(XMapchip *InstancePtr, u32 Data);
u32 XMapchip_Get_mapchip_maxheight(XMapchip *InstancePtr);
void XMapchip_Set_mapchip_draw_xsize(XMapchip *InstancePtr, u32 Data);
u32 XMapchip_Get_mapchip_draw_xsize(XMapchip *InstancePtr);
void XMapchip_Set_mapchip_draw_ysize(XMapchip *InstancePtr, u32 Data);
u32 XMapchip_Get_mapchip_draw_ysize(XMapchip *InstancePtr);
void XMapchip_Set_xstart_pos(XMapchip *InstancePtr, u32 Data);
u32 XMapchip_Get_xstart_pos(XMapchip *InstancePtr);
void XMapchip_Set_ystart_pos(XMapchip *InstancePtr, u32 Data);
u32 XMapchip_Get_ystart_pos(XMapchip *InstancePtr);
void XMapchip_Set_frame_size(XMapchip *InstancePtr, u32 Data);
u32 XMapchip_Get_frame_size(XMapchip *InstancePtr);
void XMapchip_Set_alpha(XMapchip *InstancePtr, u32 Data);
u32 XMapchip_Get_alpha(XMapchip *InstancePtr);
void XMapchip_Set_id(XMapchip *InstancePtr, u32 Data);
u32 XMapchip_Get_id(XMapchip *InstancePtr);
void XMapchip_Set_crip(XMapchip *InstancePtr, u32 Data);
u32 XMapchip_Get_crip(XMapchip *InstancePtr);

void XMapchip_InterruptGlobalEnable(XMapchip *InstancePtr);
void XMapchip_InterruptGlobalDisable(XMapchip *InstancePtr);
void XMapchip_InterruptEnable(XMapchip *InstancePtr, u32 Mask);
void XMapchip_InterruptDisable(XMapchip *InstancePtr, u32 Mask);
void XMapchip_InterruptClear(XMapchip *InstancePtr, u32 Mask);
u32 XMapchip_InterruptGetEnabled(XMapchip *InstancePtr);
u32 XMapchip_InterruptGetStatus(XMapchip *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
