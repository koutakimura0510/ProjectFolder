#include "../../wrapper/game_wrapper.h"
#include "xaxivdma.h"
#include "vdma_struct.h"
// #include "xvtc.h"


/*
 * vdma設定ライブラリ
 */
static XAxiVdma axivdma;
static VdmaWork vdmawork;
//static XVtc s_vtc;


/*
 * video controllerの初期化
 */
// bool vtc_init(void)
// {
	// XVtc_Config *config;

	// config = XVtc_LookupConfig(XPAR_VTC_0_DEVICE_ID);

	// if (!config)
	// {
	// 	msg_fprintf("VTC Device ID Error", __func__, __LINE__);
	// 	return false;
	// }

	// if (XVtc_CfgInitialize(&s_vtc, config, config->BaseAddress))
	// {
	// 	msg_fprintf("Vtc Config ID Error", __func__, __LINE__);
	// 	return false;
	// }


	// /*
	//  * インターレース方式に対応
	//  * 偶数ライン(V0)と奇数ライン(V1)に同じ値を設定
	//  */
	// XVtc_Timing Timing;

	// Timing.HActiveVideo  = 640;
	// Timing.HFrontPorch   = 656 - 640;
	// Timing.HSyncWidth	 = 752 - 656;
	// Timing.HBackPorch	 = 799 - 752 + 1;
	// Timing.HSyncPolarity = 0;
	// Timing.VActiveVideo  = 480;
	// Timing.V0FrontPorch  = 490 - 480;
	// Timing.V0SyncWidth	 = 492 - 490;
	// Timing.V0BackPorch	 = 524 - 492 + 1;
	// Timing.V1FrontPorch	 = 490 - 480;
	// Timing.V1SyncWidth	 = 492 - 490;
	// Timing.V1BackPorch	 = 524 - 492 + 1;
	// Timing.VSyncPolarity = 0;


	// /*
	//  * vivadoで設定したビデオフォーマットを使用
	//  */
	// XVtc_SourceSelect Sourse;

	// memset((void *)&Sourse, 0, sizeof(Sourse));
	// Sourse.VBlankPolSrc		 	= 0;
	// Sourse.VSyncPolSrc		 	= 0;
	// Sourse.HBackPorchSrc	 	= 0;
	// Sourse.HSyncPolSrc		 	= 0;
	// Sourse.ActiveVideoPolSrc	= 0;
	// Sourse.ActiveChromaPolSrc 	= 0;
	// Sourse.VChromaSrc			= 0;
	// Sourse.VActiveSrc			= 0;
	// Sourse.VBlankPolSrc			= 0;
	// Sourse.VSyncSrc				= 0;
	// Sourse.VFrontPorchSrc		= 0;
	// Sourse.VTotalSrc			= 0;
	// Sourse.HActiveSrc			= 0;
	// Sourse.HBackPorchSrc		= 0;
	// Sourse.HSyncSrc				= 0;
	// Sourse.HTotalSrc			= 0;

	// XVtc_SelfTest(&s_vtc);
	// XVtc_RegUpdateEnable(&s_vtc);
	// XVtc_SetGeneratorTiming(&s_vtc, &Timing);
	// XVtc_SetSource(&s_vtc, &Sourse);
	// XVtc_EnableGenerator(&s_vtc);
	// xil_printf("VTC Init OK\r\n");

// 	return true;
// }



/*
 * VDMAの初期化
 * 描画アドレスを手動で変更する場合 0x89を設定
 * 描画アドレスを自動で変更する場合 0x8bを設定
 * 
 * DDRメモリに確保するフレームバッファ領域のアドレスを指定し
 * ディスプレイの描画範囲を設定
 */
bool vdma_init(void)
{
	XAxiVdma_Config *config;

	config = XAxiVdma_LookupConfig(XPAR_AXI_VDMA_0_DEVICE_ID);

#ifdef MYDEBUG
	if (!config)
	{
		xil_printf("Vdma Device ID Error");
		return false;
	}

	if (XST_SUCCESS != XAxiVdma_CfgInitialize(&axivdma, config, config->BaseAddress))
	{
		xil_printf("Vdma Driver Init Error");
		return false;
	}
#else
	XAxiVdma_CfgInitialize(&axivdma, config, config->BaseAddress);
#endif

	XAxiVdma_DmaSetup Readcfg;
	Readcfg.VertSizeInput			= VIDEO_HEIGHT;
	Readcfg.HoriSizeInput			= MAX_V_WIDTH;
	Readcfg.Stride			  		= MAX_V_WIDTH;
	Readcfg.FrameDelay		  		= 0;
	Readcfg.EnableCircularBuf 		= 0;
	Readcfg.EnableSync		  		= 0;
	Readcfg.PointNum		  		= 0;
	Readcfg.EnableFrameCounter 		= 0;
	Readcfg.FixedFrameStoreAddr 	= 0;
	Readcfg.FrameStoreStartAddr[0]  = FBUF_ADDR_1;
	Readcfg.FrameStoreStartAddr[1]	= FBUF_ADDR_2;
	Readcfg.FrameStoreStartAddr[2]	= FBUF_ADDR_3;

#ifdef MYDEBUG
	if (XST_SUCCESS != XAxiVdma_DmaConfig(&axivdma, XAXIVDMA_READ, &Readcfg))
	{
		/*
		 * XST_DEVICE_BUSY  	: DMAチャネル使用中
		 * XST_INVAID_PARAM 	: パラメータ設定のエラー
		 * XST_DEVICE_NOT_FOUND : チャネルが正しく設定されていない 
		 */
		xil_printf("Vdma Config Error");
		return false;
	}

	if (XST_SUCCESS != XAxiVdma_DmaSetBufferAddr(&axivdma, XAXIVDMA_READ, Readcfg.FrameStoreStartAddr))
	{
		xil_printf("Vdma Config Error");
		return false;
	}

	if (XST_SUCCESS != XAxiVdma_DmaStart(&axivdma, XAXIVDMA_READ))
	{
		xil_printf("Vdma Config Error");
		return false;
	}

	/*
	 * 出力フレームバッファを設定
	 */
	if (XST_SUCCESS != XAxiVdma_StartParking(&axivdma, 0, XAXIVDMA_READ))
	{
		xil_printf("Vdma Config Error");
		return false;
	}

	xil_printf("VDMA Init OK\r\n");
#else
	XAxiVdma_DmaConfig(&axivdma, XAXIVDMA_READ, &Readcfg);
	XAxiVdma_DmaSetBufferAddr(&axivdma, XAXIVDMA_READ, Readcfg.FrameStoreStartAddr);
	XAxiVdma_DmaStart(&axivdma, XAXIVDMA_READ);
	XAxiVdma_StartParking(&axivdma, 0, XAXIVDMA_READ);
#endif

	return true;
}


/*
 * 指定したチャンネルのフレームバッファ領域の描画をVDMAに設定
 * vdmaのチャンネル切り替え完了として変数をtrueにし、
 * 次回の描画データの更新を可能とする
 */
int8_t vdma_channel(uint8_t ch)
{
	VdmaWork *p = &vdmawork;

	p->ischannel = true;

	return XAxiVdma_StartParking(&axivdma, ch, XAXIVDMA_READ);
}


/*
 * VDMAに指定するフレームバファ領域の切り替え状態を取得
 */
bool vdma_IsChannel(void)
{
	VdmaWork *p = &vdmawork;

	return p->ischannel;
}


/*
 * vdmaのフレームバッファ切り替えサイクル動作
 * 実際に指定したチャンネルにVDMAが切り替わるまで、描画データ更新の
 * 判定を行う変数をfalseにする
 */
uint8_t vdma_circular(void)
{
	VdmaWork *p = &vdmawork;

	p->pos++;
	p->ischannel = false;

	if (FBUF_NUM <= p->pos)
	{
		p->pos = 0;
	}

	return p->pos;
}


/*
 * 同期信号の状態を管理
 * syncの値が非表示範囲内であればtrueを返し次回の非表示範囲内までfalseを返す
 */
bool hvsync_state(void)
{
	static uint8_t state = 0;

	if (VIDEO_HEIGHT < (GET_SYNC & 0x000003ff))
	{
		if (state == 0)
		{
			state = 1;
			return true;
		}
	}
	else
	{
		state = 0;
	}

	return false;
} 
