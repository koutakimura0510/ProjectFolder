// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XMAPCHIP_PNG_H
#define XMAPCHIP_PNG_H

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
#include "xmapchip_png_hw.h"

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
} XMapchip_png_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XMapchip_png;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XMapchip_png_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XMapchip_png_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XMapchip_png_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XMapchip_png_ReadReg(BaseAddress, RegOffset) \
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
int XMapchip_png_Initialize(XMapchip_png *InstancePtr, u16 DeviceId);
XMapchip_png_Config* XMapchip_png_LookupConfig(u16 DeviceId);
int XMapchip_png_CfgInitialize(XMapchip_png *InstancePtr, XMapchip_png_Config *ConfigPtr);
#else
int XMapchip_png_Initialize(XMapchip_png *InstancePtr, const char* InstanceName);
int XMapchip_png_Release(XMapchip_png *InstancePtr);
#endif

void XMapchip_png_Start(XMapchip_png *InstancePtr);
u32 XMapchip_png_IsDone(XMapchip_png *InstancePtr);
u32 XMapchip_png_IsIdle(XMapchip_png *InstancePtr);
u32 XMapchip_png_IsReady(XMapchip_png *InstancePtr);
void XMapchip_png_EnableAutoRestart(XMapchip_png *InstancePtr);
void XMapchip_png_DisableAutoRestart(XMapchip_png *InstancePtr);

void XMapchip_png_Set_srcin(XMapchip_png *InstancePtr, u64 Data);
u64 XMapchip_png_Get_srcin(XMapchip_png *InstancePtr);
void XMapchip_png_Set_dstin(XMapchip_png *InstancePtr, u64 Data);
u64 XMapchip_png_Get_dstin(XMapchip_png *InstancePtr);
void XMapchip_png_Set_dstout(XMapchip_png *InstancePtr, u64 Data);
u64 XMapchip_png_Get_dstout(XMapchip_png *InstancePtr);
void XMapchip_png_Set_mapchip_maxwidth(XMapchip_png *InstancePtr, u32 Data);
u32 XMapchip_png_Get_mapchip_maxwidth(XMapchip_png *InstancePtr);
void XMapchip_png_Set_mapchip_maxheight(XMapchip_png *InstancePtr, u32 Data);
u32 XMapchip_png_Get_mapchip_maxheight(XMapchip_png *InstancePtr);
void XMapchip_png_Set_mapchip_draw_xsize(XMapchip_png *InstancePtr, u32 Data);
u32 XMapchip_png_Get_mapchip_draw_xsize(XMapchip_png *InstancePtr);
void XMapchip_png_Set_mapchip_draw_ysize(XMapchip_png *InstancePtr, u32 Data);
u32 XMapchip_png_Get_mapchip_draw_ysize(XMapchip_png *InstancePtr);
void XMapchip_png_Set_xstart_pos(XMapchip_png *InstancePtr, u32 Data);
u32 XMapchip_png_Get_xstart_pos(XMapchip_png *InstancePtr);
void XMapchip_png_Set_ystart_pos(XMapchip_png *InstancePtr, u32 Data);
u32 XMapchip_png_Get_ystart_pos(XMapchip_png *InstancePtr);
void XMapchip_png_Set_frame_size(XMapchip_png *InstancePtr, u32 Data);
u32 XMapchip_png_Get_frame_size(XMapchip_png *InstancePtr);
void XMapchip_png_Set_alpha(XMapchip_png *InstancePtr, u32 Data);
u32 XMapchip_png_Get_alpha(XMapchip_png *InstancePtr);
void XMapchip_png_Set_id(XMapchip_png *InstancePtr, u32 Data);
u32 XMapchip_png_Get_id(XMapchip_png *InstancePtr);

void XMapchip_png_InterruptGlobalEnable(XMapchip_png *InstancePtr);
void XMapchip_png_InterruptGlobalDisable(XMapchip_png *InstancePtr);
void XMapchip_png_InterruptEnable(XMapchip_png *InstancePtr, u32 Mask);
void XMapchip_png_InterruptDisable(XMapchip_png *InstancePtr, u32 Mask);
void XMapchip_png_InterruptClear(XMapchip_png *InstancePtr, u32 Mask);
u32 XMapchip_png_InterruptGetEnabled(XMapchip_png *InstancePtr);
u32 XMapchip_png_InterruptGetStatus(XMapchip_png *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
