/*
 * Include File
 */
#include "../../wrapper/game_wrapper.h"
#include "xscutimer.h"
#include "xscugic.h"
#include "xil_exception.h"


/*
 * タイマー構造体のインスタンス
 */
XScuTimer TimerInstance;
XScuGic IntcInstance;


/*
 * ファイル内関数
 */
static int scugicint_init(void);
static int ScuGicInt_Reg(u32 Int_Id, void *InstancePtr, void *IntHandler);


/*
 * タイマー割り込み関数
 */
void TimerCounterHandler(void *CallBackRef)
{
    XScuTimer *TimerInstancePtr	= (XScuTimer *)CallBackRef;

    if (XScuTimer_IsExpired(TimerInstancePtr))
    {
        XScuTimer_ClearInterruptStatus(TimerInstancePtr);
        bgm_playback();
    }
}


/*
 * 割り込みコントローラのドライバ初期化
 */
static int scugicint_init(void)
{
    int Status;
    XScuGic_Config *ConfigPtr;

    ConfigPtr = XScuGic_LookupConfig(XPAR_PS7_SCUGIC_0_DEVICE_ID);
    Status = XScuGic_CfgInitialize(&IntcInstance, ConfigPtr, ConfigPtr->CpuBaseAddress);

#ifdef MYDEBUG
    if (Status != XST_SUCCESS)
    {
        xil_printf("scugic init error");
        return XST_FAILURE;
    }
#endif
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (Xil_ExceptionHandler)XScuGic_InterruptHandler, &IntcInstance);
    Xil_ExceptionEnable();

    return XST_SUCCESS;
}


/*
 * 割り込み処理関数の登録
 */
static int ScuGicInt_Reg(u32 Int_Id, void *InstancePtr, void *IntHandler)
{
    int status;

    status = XScuGic_Connect(&IntcInstance, Int_Id, (Xil_ExceptionHandler)IntHandler, (void *)InstancePtr);

    if (status != XST_SUCCESS)
    {
        msg_fprintf("Interrupt Connect Error", " ", __func__, __LINE__);
        return XST_FAILURE;
    }

    XScuGic_Enable(&IntcInstance, Int_Id);

    return XST_SUCCESS;
}



/*
 * タイマー割り込みの初期設定
 */
bool timer_init(void)
{
	int8_t status;
    XScuTimer_Config *ConfigPtr;

    /* タイマーのドライバ初期化 */
    ConfigPtr = XScuTimer_LookupConfig(XPAR_XSCUTIMER_0_DEVICE_ID);
    status = XScuTimer_CfgInitialize(&TimerInstance, ConfigPtr, ConfigPtr->BaseAddr);

#ifdef MYDEBUG
    if (status != XST_SUCCESS)
    {
    	xil_printf("timer init error");
        return false;
    }

    /* 割り込みの初期化 */
    status = scugicint_init();

    if (status != XST_SUCCESS)
    {
    	xil_printf("interput init error");
        return false;
    }

    /* 割り込み関数の登録 */
    status = ScuGicInt_Reg(XPAR_SCUTIMER_INTR, &TimerInstance, TimerCounterHandler);

    if (status != XST_SUCCESS)
    {
    	xil_printf("connect error");
        return false;
    }

    XScuTimer_EnableAutoReload(&TimerInstance);             /* 自動再ロードレジスタの設定 */
    XScuTimer_LoadTimer(&TimerInstance, TIMER_LOAD_VALUE);  /* タイマーロード値の設定 */
    XScuTimer_EnableInterrupt(&TimerInstance);              /* 割り込み許可設定 */
    XScuTimer_Start(&TimerInstance);                        /* タイマー起動 */
    xil_printf("Timer Start !\n");
#else
    scugicint_init();
    ScuGicInt_Reg(XPAR_SCUTIMER_INTR, &TimerInstance, TimerCounterHandler);
    XScuTimer_EnableAutoReload(&TimerInstance);             /* 自動再ロードレジスタの設定 */
    XScuTimer_LoadTimer(&TimerInstance, TIMER_LOAD_VALUE);  /* タイマーロード値の設定 */
    XScuTimer_EnableInterrupt(&TimerInstance);              /* 割り込み許可設定 */
    XScuTimer_Start(&TimerInstance);                        /* タイマー起動 */
#endif

	return true;
}




/*
 * スイッチの立ち上がり値の取得
 *
 * 長押しキー指定の場合に、十字キーの長押し処理は行うがABキーは単発押し判定だけ行うため
 * 前回のキー入力を保存してABキーの判定を行うようにした
 */
uint8_t get_key(bool longkey)
{
    static uint8_t sw_up  = 0;
    uint8_t sw = GET_FPGA_SW;

    if (sw == 0)
    {
        sw_up = 0;
    }

    if ((sw != sw_up) && (sw != 0) && (longkey == false))
    {
#ifdef MYDEBUG
        xil_printf("key = %d\n", sw);
#endif
        sw_up = sw;
        return sw;
    }

    if (longkey == true)
    {
        uint8_t sw_ab = sw_up & SW_AB;
        sw_up = sw;
        return sw ^ sw_ab;
    }

    return 0;
}


/*
 * 指定時間経過したか判断を行う
 *
 * *com_timer
 * 比較用タイマーのアドレスを指定
 *
 * progress_tmr
 * 経過時間を指定
 */
bool tmr_constant(uint32_t *com_timer, uint32_t progress_timer)
{
	uint32_t t;

	t = *com_timer + progress_timer;

	if (t >= MAX_TOTAL)
    {
		*com_timer = 0;
        t = 0;
    }

    if (t <= GET_FPGA_COUNT)
    {
		return true;
	}
    else
    {
		return false;
	}
}


/*
 * FPGAのカウンターの値を取得
 */
uint32_t get_time(void)
{
	return GET_FPGA_COUNT;
}


/*
 * 指定時間wait
 */
void wait_time(uint32_t time)
{
	uint32_t t = get_time();

	while (1U)
    {
		if (true == tmr_constant(&t, time))
        {
			return;
		}
	}
}
