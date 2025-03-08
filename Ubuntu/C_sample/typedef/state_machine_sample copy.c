/**-----------------------------------------------------------------------------
 * @file	state_machine_sample.c
 * @brief	ステートマシンを関数ポインタで処理するサンプルコード。
 * @details	このサンプルは、関数ポインタを使用してステートマシンを実装する方法を示します。
 *			IDLE ステートから始まり、END ステートに遷移してループを抜ける動作を行います。
 *			複数のステートを処理する際の基本構造を示します。
 *
 * @environment
 *			OS: Windows 11 for WSL2
 *			IDE: VSCode 1.94.1
 *
 * @author Kimura
 *
 * @sample_flow
 *			1. IDLE ステート -> END ステート
 *			2. END ステート -> ループ終了
 *
 * @note	このサンプルコードは、動作の確認や開発の参考のための簡単なサンプルです。
 *			実際のステート処理に応じて、ステートや処理を拡張してください。
 *-----------------------------------------------------------------------------*/

/**-----------------------------------------------------------------------------
 * include header
 *-----------------------------------------------------------------------------*/
#include <stdio.h>		// printf 出力に使用します
#include <stdint.h>		// マイコンに移植しやすいように、uintxx_t を使用します
#include <stdbool.h>	// bool 値を使用します


/** ----------------------------------------------------------------------------
 * Data Index
 *-----------------------------------------------------------------------------*/
#define DATA_A_INDEX	(0)
#define DATA_B_INDEX	(10)
#define DATA_C_INDEX	(20)


/** ----------------------------------------------------------------------------
 * 
 *-----------------------------------------------------------------------------*/
typedef struct {
	uint8_t data[100];
} HandleStateFunc_t;


/** ----------------------------------------------------------------------------
 * @section static function
 * @brief	ファイル内関数のプロトタイプ宣言です。
 * @note	プレフィックスに static をつけることで、外部ファイルから extern で実行されないことを示します。
 * 
 *-----------------------------------------------------------------------------*/
static HandleStateEnum svmctl_cmd_check(uint8_t *pbuff);
static void handle_status_entry(HandleStatus_t *HandleStatus, uint16_t wlen, uint16_t rlen, bool app_done, HandleStateEnum state);
static void svmctl_state_idle(HandleStatus_t *HandleStatus);
static void svmctl_state_end(HandleStatus_t *HandleStatus);
// static void svmctl_state_verinfo(HandleStatus_t *HandleStatus);
// static void svmctl_state_update_start(HandleStatus_t *HandleStatus);
// static void svmctl_state_updating(HandleStatus_t *HandleStatus);
// static void svmctl_state_verify_start(HandleStatus_t *HandleStatus);
// static void svmctl_state_verifing(HandleStatus_t *HandleStatus);
// static void svmctl_state_rom_read(HandleStatus_t *HandleStatus);
// static void svmctl_state_rom_write(HandleStatus_t *HandleStatus);
// static void svmctl_state_fpga_write(HandleStatus_t *HandleStatus);
// static void svmctl_state_fpga_read(HandleStatus_t *HandleStatus);
// static void svmctl_state_i2c_write(HandleStatus_t *HandleStatus);
// static void svmctl_state_i2c_read(HandleStatus_t *HandleStatus);
// static void svmctl_state_i2c_unexpected(HandleStatus_t *HandleStatus);

/** ----------------------------------------------------------------------------
 * @section static variable
 * @brief	ROM 操作に関する情報を管理するための静的変数。
 * @note	この変数は、ROM へのデータアクセスに関する情報（アドレス、データサイズ、進行状況など）を保持し、
 *			各ステート間で共通して使用される。データ操作が行われる度に、この変数の内容が更新される。
 *			初期化時には、アドレスやデータサイズは 0、countCheck は -1 に設定されており、操作が未開始であることを示す。
 *			プレフィックスに static をつけることで、外部ファイルから extern で利用されないことを示します。
 * 
 * @param toDoDataAddr		次にアクセスする ROM のアドレス。初期値は 0。
 * @param toDoDataLength	次に操作するデータのバイトサイズ。初期値は 0。
 * @param currentDataLength	これまでに処理されたデータサイズ。初期値は 0。
 * @param countCheck		ROM 操作の進行状況を管理するカウンタ。初期値は -1 で、まだ操作が開始されていないことを示す。
 * 
 *-----------------------------------------------------------------------------*/
static RomOperation_t RomOperation = {0,0,0,-1};

/** ----------------------------------------------------------------------------
 * @section static variable
 * @brief	各ステートに対応する関数ポインタテーブル
 * @note	ステートごとに対応する関数が記載され、必要に応じてステートが増えた場合、対応する関数をここに追加できます。
 * 
 *-----------------------------------------------------------------------------*/
static const HandleStateFunc_t HandleStateFunc[] = {
	{SVMCTL_STATE_IDLE,				svmctl_state_idle			},
	{SVMCTL_STATE_END,				svmctl_state_end			},
	// {SVMCTL_STATE_VERINFO,			svmctl_state_verinfo		},	// ステートが増えた場合
	// {SVMCTL_STATE_UPDATE_START,		svmctl_state_update_start	},
	// {SVMCTL_STATE_UPDATING,			svmctl_state_updating		},
	// {SVMCTL_STATE_VERIFY_START,		svmctl_state_verify_start	},
	// {SVMCTL_STATE_VERIFYING,		svmctl_state_verifing		},
	// {SVMCTL_STATE_SPIROM_READ,		svmctl_state_rom_read		},
	// {SVMCTL_STATE_SPIROM_WRITE,		svmctl_state_rom_write		},
	// {SVMCTL_STATE_FPGA_WRITE,		svmctl_state_fpga_write		},
	// {SVMCTL_STATE_FPGA_READ,		svmctl_state_fpga_read		},
	// {SVMCTL_STATE_I2C_WRITE,		svmctl_state_i2c_write		},
	// {SVMCTL_STATE_I2C_READ,			svmctl_state_i2c_read		},
	// {SVMCTL_STATE_UNEXPECTED,		svmctl_state_i2c_unexpected	},
};


/** ----------------------------------------------------------------------------
 * @brief	ホストから受信したコマンドに基づいて、適切なステート・マシン処理を実行します。
 * @note	この関数は、現在のステート(状態)に応じて、定義されたステート・マシンの処理を呼び出します。
 * 
 * @param	*pbuff: ホストから受信したデータが格納されている DMA バッファへのポインタ。
 * @param	data_size: DMA バッファ内の受信データサイズを指定
 * @param	*wlen: ホストへの送信データサイズ。例："SUCCESS + データ数 4" なら wlen=5。
 * @param	*rlen: ホストに対する受信可能データサイズ。例：1024 パケット受信可能状態なら rlen=1024
 * @param	*app_done: ステート・マシンの処理が完了したかどうかを通知するためのポインタ。終了なら true, 処理途中なら false を設定します。
 * 
 * @retval	戻り値はありませんが、ステートに応じた関数が実行され、適切な処理が行われます。
 * 
 *-----------------------------------------------------------------------------*/
void svctl_handle(uint8_t *pbuff, uint16_t data_size, uint16_t *wlen, uint16_t *rlen, bool *app_done)
{
	static HandleStateEnum fx10State = SVMCTL_STATE_IDLE;				// IDLE STATE で初期化
	const HandleStateFunc_t *pHandleStateFunc = &HandleStateFunc[0];	// 関数ポインタテーブルの先頭アドレスを取得
	HandleStatus_t HandleStatus = {pbuff, data_size, wlen, rlen, app_done, &fx10State, &RomOperation};	// 状態やバッファ情報を構造体に格納

	for (uint8_t i = 0; i < SVCTL_STATE_DB_SIZE; i++, pHandleStateFunc++) {	// 現在のステートと一致する処理を探し実行
		if (pHandleStateFunc->state == fx10State) {
			pHandleStateFunc->func(&HandleStatus);
			break;
		}
	}
}

/** ----------------------------------------------------------------------------
 * @brief	IDLE State を処理する関数です。
 * @note	この関数は、ホストから受信したコマンドを解析し、適切な次のステート・マシンへの遷移を設定します。
 *			IDLE 状態にいる間、ホストからのコマンドに応じてシステムの動作を決定します。
 * 
 * @param	*HandleStatus: HnadleStatus_t 構造体へのポインタ。
 * 
 * @retval	戻り値はありませんが、次のステートに遷移する準備が整います。
 *
 *-----------------------------------------------------------------------------*/
static void svmctl_state_idle(HandleStatus_t *HandleStatus)
{
	HandleStateEnum next_state = svmctl_cmd_check(HandleStatus->pbuff);
	handle_status_entry(HandleStatus, 0, 0, APP_DONE_FALSE, next_state);
}

/** ----------------------------------------------------------------------------
 * @brief	END State を処理する関数です。
 * @note	この関数は、トランザクションが正常に完了したことを示し、システムを IDLE 状態に戻します。
 * 
 * @param	*HandleStatus: HnadleStatus_t 構造体へのポインタ。
 * 
 * @retval	戻り値はありませんが、システムは終了状態に入り、IDLE 状態へ遷移します。
 *
 *-----------------------------------------------------------------------------*/
static void svmctl_state_end(HandleStatus_t *HandleStatus)
{
	handle_status_entry(HandleStatus, 0, 1024, APP_DONE_TRUE, SVMCTL_STATE_IDLE);
}

/** ----------------------------------------------------------------------------
 * @brief	SVCtl の通知コマンドを確認し、次のステートを決定します。
 * @note	この関数は、受信したデータに基づいて次のステートを返します。サンプルソースであるため、簡素化されています。
 * 
 * @param	*pbuff: 受信したコマンドが格納されているバッファへのポインタ
 * 
 * @retval	HandleStateEnum: コマンドに応じて遷移する次のステートを返します。
 * 			- SVMCTL_STATE_VERINFO: コマンドが 0 の場合
 * 			- SVMCTL_STATE_END: コマンドが 1 の場合
 * 			- default: default になることは想定していませんが、エラー時に適切に終了するように SVMCTL_STATE_SUCCESS を返します。
 *
 *-----------------------------------------------------------------------------*/
static HandleStateEnum svmctl_cmd_check(uint8_t *pbuff)
{
	uint8_t cmd = pbuff[0];

	switch (cmd)
	{
		case 0:
			return SVMCTL_STATE_VERINFO;

		case 1:
			return SVMCTL_STATE_END;

		default:
			return SVMCTL_STATE_SUCCESS;

		// case SVMCTL_IF_VERINFO:
		// 	return SVMCTL_STATE_VERINFO;

		// case SVMCTL_IF_I2CWRITE:
		// 	return SVMCTL_STATE_I2C_WRITE;

		// case SVMCTL_IF_SPIREAD:
		// 	return SVMCTL_STATE_SPIROM_READ;
			
		// case SVMCTL_IF_SPIWRITE:
		// 	return SVMCTL_STATE_SPIROM_WRITE;
			
		// case SVMCTL_IF_UPDATE:
		// 	return SVMCTL_STATE_UPDATE_START; 
			
		// case SVMCTL_IF_ROMREAD:
		// 	return SVMCTL_STATE_VERIFY_START;
			
		// case SVMCTL_IF_REGREAD:
		// 	return SVMCTL_STATE_FPGA_READ;

		// case SVMCTL_IF_REGWRITE:
		// 	return SVMCTL_STATE_FPGA_WRITE;
			
		// case SVMCTL_IF_I2CREAD_LONG:
		// 	return SVMCTL_STATE_I2C_READ;
			
		// case SVMCTL_IF_I2CWRITE_LONG:
		// 	return SVMCTL_STATE_I2C_WRITE;

		// // case SVMCTL_IF_FX3WRITE:	
			
		// default:
		// 	return SVMCTL_STATE_UNEXPECTED;
	}
}

/** ----------------------------------------------------------------------------
 * @brief	ホストとの通信トランザクションに必要なデータを設定します。
 * @note	この関数は SV アプリケーション内で、ホストとの通信状態を管理するために使用されます。
 * 
 * @param	*HandleStatus: HnadleStatus_t 構造体へのポインタ。
 * @param	wlen: ホストへの送信データサイズ。例："SUCCESS + データ数 4" なら wlen=5。
 * @param	rlen: ホストに対する受信可能データサイズ。例：1024 パケット受信可能状態なら rlen=1024
 * @param	app_done: トランザクションが終了の場合は、APP_DONE_TRUE, 次のステート・マシンの処理が残っている場合は、APP_DONE_FALSE を設定
 * @param	next_state: HandleStateEnum に定義されている、次のステート・マシンの状態を設定
 * 
 * @retval 戻り値はありませんが、HandleStatus 構造体のメンバが更新されます。
 * 
 *-----------------------------------------------------------------------------*/
static void handle_status_entry(HandleStatus_t *HandleStatus, uint16_t wlen, uint16_t rlen, bool app_done, HandleStateEnum next_state)
{
	// ポインタにデータ代入する場合は *() で囲む
	*(HandleStatus->wlen) = wlen;
	*(HandleStatus->rlen) = rlen;
	*(HandleStatus->app_done) = app_done;
	*(HandleStatus->state) = next_state;

	printf("HandleStatus = wlen = %d\n",				*(HandleStatus->wlen));
	printf("HandleStatus = datasize = %d\n",			  HandleStatus->data_size);
	printf("HandleStatus = rlen = %d\n",				*(HandleStatus->rlen));
	printf("HandleStatus = app_done = %d\n",			*(HandleStatus->app_done));
	printf("HandleStatus = next_state = %d\n",			*(HandleStatus->state));
	printf("RomOperation = toDoDataAddr = %d\n",		HandleStatus->RomOperation->toDoDataAddr);
	printf("RomOperation = toDoDataLength = %d\n",		HandleStatus->RomOperation->toDoDataLength);
	printf("RomOperation = currentDataLength = %d\n",	HandleStatus->RomOperation->currentDataLength);
	printf("RomOperation = countCheck = %d\n",			HandleStatus->RomOperation->countCheck);
	printf("\n");
}


/** ----------------------------------------------------------------------------
 * @brief	メイン関数
 * @note	ホストとの通信トランザクションを処理するループを実行します。
 *			初期設定として、サンプルデータを用意し、状態管理を行います。
 * 
 * @retval	0 プログラムの正常終了を示します。
 * 
 *-----------------------------------------------------------------------------*/
int main(void)
{
	uint8_t pbuff[128];			// ホストから受信したデータを格納するためのバッファ
	uint16_t data_size = 123;	// 受信データのサイズ（例示用に固定）
	uint16_t wlen;				// ホストへの送信データサイズ
	uint16_t rlen;				// ホストへの受信データサイズ
	bool app_done;				// アプリケーションの処理が完了したかどうかを示すフラグ

	pbuff[0] = 1;				// サンプルデータとして "1" を設定
	printf("DB SIZE %ld\n", SVCTL_STATE_DB_SIZE); // 状態遷移関数の配列サイズを表示

	// アプリケーションの処理ループ
	do {
		svctl_handle(pbuff, data_size, &wlen, &rlen, &app_done); // 状態に応じた処理を実行
	} while (app_done == false);		// app_done が false の間、ループを続ける

	return 0;
}