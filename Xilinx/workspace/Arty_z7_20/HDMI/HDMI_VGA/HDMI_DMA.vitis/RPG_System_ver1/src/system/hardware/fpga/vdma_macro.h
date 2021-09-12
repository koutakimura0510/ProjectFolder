#ifndef vdma_h   /* prevent circular inclusions */
#define vdma_h   /* by using protection macros */


/*
 * 同期信号取得
 */
#define GET_SYNC *((volatile uint32_t *)(XPAR_GPIO_3_BASEADDR))



/*
 * VDMAレジスタ操作コマンド
 */
#define CYCLE_VDMA  (0x8b)
#define POS_VDMA    (0x89)
#define VDMA_ADDR_0x30 (XPAR_AXI_VDMA_0_BASEADDR + 0x30)
#define VDMA_ADDR_0xAC (XPAR_AXI_VDMA_0_BASEADDR + 0xAC)
#define VDMA_ADDR_0xB0 (XPAR_AXI_VDMA_0_BASEADDR + 0xB0)
#define VDMA_ADDR_0xB4 (XPAR_AXI_VDMA_0_BASEADDR + 0xB4)
#define VDMA_ADDR_0xA8 (XPAR_AXI_VDMA_0_BASEADDR + 0xA8)
#define VDMA_ADDR_0xA4 (XPAR_AXI_VDMA_0_BASEADDR + 0xA4)
#define VDMA_ADDR_0xA0 (XPAR_AXI_VDMA_0_BASEADDR + 0xA0)
#define VDMA_ADDR_0x00 (XPAR_AXI_VDMA_0_BASEADDR + 0x00)
#define VDMA_ADDR_0x5C (XPAR_AXI_VDMA_0_BASEADDR + 0x5C)
#define VDMA_ADDR_0x60 (XPAR_AXI_VDMA_0_BASEADDR + 0x60)
#define VDMA_ADDR_0x64 (XPAR_AXI_VDMA_0_BASEADDR + 0x64)
#define VDMA_ADDR_0x58 (XPAR_AXI_VDMA_0_BASEADDR + 0x58)
#define VDMA_ADDR_0x54 (XPAR_AXI_VDMA_0_BASEADDR + 0x54)
#define VDMA_ADDR_0x50 (XPAR_AXI_VDMA_0_BASEADDR + 0x50)
#define VDMA_ADDR_0x28 (XPAR_AXI_VDMA_0_BASEADDR + 0x28)

#endif