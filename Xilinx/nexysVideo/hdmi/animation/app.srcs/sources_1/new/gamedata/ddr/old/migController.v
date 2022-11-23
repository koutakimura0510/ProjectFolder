/*
 * Create 2021/12/30
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * MIG制御用コントローラ
 */
module migController #(
    parameter pDramAddrWidth = 29,
    parameter pDramDataWidth = 128,
    parameter pDramMaskWidth = 16
)(
    input                       iCLK,
    input                       iRST,
    
    // user design signals
    input                       iWEnable,
    input                       iREnable,
    input  [pDramAddrWidth-1:0] iAddr,
    input  [pDramDataWidth-1:0] iWdData,
    input  [pDramMaskWidth-1:0] iMask,
    output [pDramDataWidth-1:0] oRdData,

    // Mig Signals Bridge
    output                      oRdDataValid,
    output                      oReady,
    output                      oWdReady,
    output                      oInitCalibComplete,

    // Mig Signals
    output [pDramAddrWidth-1:0] oAppAddr,
    output [ 2:0]               oAppCmd,
    output                      oAppEnable,
    output [pDramDataWidth-1:0] oAppWdfData,
    output                      oAppWdfWren,
    output [pDramMaskWidth-1:0] oAppWdfMask,
    input  [pDramDataWidth-1:0] iAppRdData,
    input                       iAppRdDataValid,
    input                       iAppReady,
    input                       iAppWdfReady,
    input                       iInitCalibComplete
);


//----------------------------------------------------------
// MIG制御コマンド定数
//----------------------------------------------------------
localparam CMD_WRITE = 3'b000;
localparam CMD_READ  = 3'b001;


//----------------------------------------------------------
// MIG 制御ステートマシン定数
//----------------------------------------------------------
localparam [2:0]
    MIG_CALIBRATION = 0,
    MIG_IDLE        = 1,
    MIG_NEXT_CMD    = 2,
    MIG_WRITE       = 3,
    MIG_READ        = 4;


//----------------------------------------------------------
// MIGのハンドシェイク信号をそのまま出力
// Schematicの出力の際に信号線がモジュール間をまたがないようにした
// 
// Signal Direct
// MIG -> Controller -> User Design
//----------------------------------------------------------
assign oRdDataValid         = iAppRdDataValid;      // データ出力時High
assign oReady               = iAppReady;            // DDR3動作可能時High
assign oWdReady             = iAppWdfReady;         // 書き込み可能時High
assign oInitCalibComplete   = iInitCalibComplete;   // キャリブレーション終了時High


//----------------------------------------------------------
// MIG 読み込みデータ出力
//----------------------------------------------------------
assign oRdData = iAppRdData;


//----------------------------------------------------------
// MIG IP 操作データ出力
//----------------------------------------------------------
reg [pDramAddrWidth-1:0] app_addr;          assign oAppAddr     = app_addr;
reg [2:0] app_cmd;                          assign oAppCmd      = app_cmd;
reg app_enable;                             assign oAppEnable   = app_enable;
reg [pDramDataWidth-1:0] app_wdf_data;      assign oAppWdfData  = app_wdf_data;
reg app_wdf_wren;                           assign oAppWdfWren  = app_wdf_wren;
reg [pDramMaskWidth-1:0] app_wdf_mask;      assign oAppWdfMask  = app_wdf_mask;
reg [2:0] mig_state;


//----------------------------------------------------------
// 書き込み時
// iAppReady. iAppWdfReadyが0になり完了時にどちらかもしくは両方が1になる
//
// 読み込み時
// iAppReadyが0になり完了時に1になる
//
// 上記2つの信号と書き込み・読み込みEnable信号を使用してステートマシン制御を行う
// 読み込みコマンド発行後はiAppReadyの信号を確認し、命令Enable信号によって遷移を行う
// 書き込みコマンド発行後はiAppReady. iAppWdfReadyの信号を確認し、命令Enable信号によって遷移を行う
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        mig_state    <= MIG_CALIBRATION;
        app_addr     <= 0;
        app_cmd      <= 0;
        app_enable   <= 0;
        app_wdf_data <= 0;
        app_wdf_wren <= 0;
        app_wdf_mask <= 0;
    end else begin
        case (mig_state)
            MIG_CALIBRATION: begin
                if (iInitCalibComplete == 1'b1) begin
                    mig_state <= MIG_IDLE;
                end
            end

            MIG_IDLE: begin
                if (iWEnable == 1'b1) begin
                    app_addr     <= iAddr;
                    app_cmd      <= CMD_WRITE;
                    app_enable   <= 1'b1;
                    app_wdf_data <= iWdData;
                    app_wdf_wren <= 1'b1;
                    app_wdf_mask <= iMask;
                    mig_state    <= MIG_NEXT_CMD;
                end else if (iREnable == 1'b1) begin
                    app_addr     <= iAddr;
                    app_cmd      <= CMD_READ;
                    app_enable   <= 1'b1;
                    app_wdf_wren <= 1'b0;
                    mig_state    <= MIG_READ;
                end
            end

            MIG_NEXT_CMD: begin
                if (iAppReady == 1'b1 && iAppWdfReady == 1'b1) begin
                    if (iWEnable == 1'b1) begin
                        app_addr     <= iAddr;
                        app_cmd      <= CMD_WRITE;
                        app_enable   <= 1'b1;
                        app_wdf_data <= iWdData;
                        app_wdf_wren <= 1'b1;
                        app_wdf_mask <= iMask;
                        mig_state    <= MIG_NEXT_CMD;
                    end else if (iREnable == 1'b1) begin
                        app_addr     <= iAddr;
                        app_cmd      <= CMD_READ;
                        app_enable   <= 1'b1;
                        app_wdf_wren <= 1'b0;
                        mig_state    <= MIG_READ;
                    end else begin
                        app_enable   <= 1'b0;
                        app_wdf_wren <= 1'b0;
                        mig_state    <= MIG_IDLE;
                    end
                end else if (iAppReady == 1'b1) begin
                    app_enable   <= 1'b0;
                    mig_state    <= MIG_WRITE;
                end else if (iAppWdfReady == 1'b1) begin
                    app_wdf_wren <= 1'b0;
                    mig_state    <= MIG_READ;
                end
            end

            MIG_READ: begin
                if (iAppReady == 1'b1) begin
                    if (iWEnable == 1'b1) begin
                        app_addr     <= iAddr;
                        app_cmd      <= CMD_WRITE;
                        app_enable   <= 1'b1;
                        app_wdf_data <= iWdData;
                        app_wdf_wren <= 1'b1;
                        app_wdf_mask <= iMask;
                        mig_state    <= MIG_WRITE;
                    end else if (iREnable == 1'b1) begin
                        app_addr     <= iAddr;
                        app_cmd      <= CMD_READ;
                        app_enable   <= 1'b1;
                        app_wdf_wren <= 1'b0;
                        mig_state    <= MIG_READ;
                    end else begin
                        app_enable   <= 1'b0;
                        app_wdf_wren <= 1'b0;
                        mig_state    <= MIG_IDLE;
                    end
                end
            end

            MIG_WRITE: begin
                if (iAppWdfReady == 1'b1) begin
                    if (iWEnable == 1'b1) begin
                        app_addr     <= iAddr;
                        app_cmd      <= CMD_WRITE;
                        app_enable   <= 1'b1;
                        app_wdf_data <= iWdData;
                        app_wdf_wren <= 1'b1;
                        app_wdf_mask <= iMask;
                        mig_state    <= MIG_NEXT_CMD;
                    end else if (iREnable == 1'b1) begin
                        app_addr     <= iAddr;
                        app_cmd      <= CMD_READ;
                        app_enable   <= 1'b1;
                        app_wdf_wren <= 1'b0;
                        mig_state    <= MIG_READ;
                    end else begin
                        app_enable   <= 1'b0;
                        app_wdf_wren <= 1'b0;
                        mig_state    <= MIG_IDLE;
                    end
                end
            end

            default: begin
                app_enable   <= 1'b0;
                app_wdf_wren <= 1'b0;
                mig_state    <= MIG_IDLE;
            end
        endcase
    end
end


endmodule