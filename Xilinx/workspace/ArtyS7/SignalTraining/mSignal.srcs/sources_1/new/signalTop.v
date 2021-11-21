/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MSignalSystem_NV_Training_03.v
 * Description : 
 * Simulator   : VeritakWin Ver.3.43E Build Mar.20.2008
 * Implem. Tool: ISE... Ver.14.1 Appl Ver. P.15xf
 * Explanation : 新人向けSVM-03ボードを使用したFPGA設計、実装、
 *               Verilog-HDLトレーニング
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
module nv_top
#(
parameter		pCLKFreqDiv10	= 12000000	// iCLK周波数[Hz]/10を指定
)(
// Car Side Lamp is Blue, Yellow and Red
// Walker Side Lamp is Blue, Red and Display for Wait
output			oCB,	oCY,	oCR,	// Lamp-Out for Car Side Signal
output			oWB,	oWR,	oWD,	// Lamp-Out for Walker Side Signal
//
// Push Button Switch Input
input 			iWPBS,	// Push Button Switch for Walker Side
//
// Common System Lines
input 			iRST,	// System Reset(Sync. Pos.)
input 			iCLK	// System Clock
//
);
//-----------------------------------------------------------------------------
// Lamp-Out Port, State Code and Time Const. Definition
//-----------------------------------------------------------------------------
reg			rCb,	rCy,	rCr;			assign {oCB,oCY,oCR}	= {rCb,rCy,rCr};
reg			rWb,	rWr,	rWd;			assign {oWB,oWR,oWD}	= {rWb,rWr,rWd};

localparam[2:0]	// Each State
    lpsCbWrKeep	 = 3'h0,		// oCB=ON, oWR=ON, Other=OFF
    lpsCbWrPass	 = 3'h1,		// lpsCbWr状態に加えlpsCyWrへ遷移するまでの待機
    lpsCyWr			 = 3'h2,
    lpsCrWrInter = 3'h3,
    lpsCrWb			 = 3'h4,
    lpsCrWbBlink = 3'h5,
    lpsCrWrTurn	 = 3'h6;
  // 各Lampの点灯状態の組み合わせで、各ステートを定義
  // WDの点灯状態は信号機としてのランプではないので、あえて含めない。

  localparam[3:0]	// Each Count Time[sec]
    lpctCbWrKeep  = 4'd10,
    lpctCbWrPass  = 4'd1,
    lpctCyWr		  = 4'd2,
    lpctCrWr		  = 4'd1,
    lpctCrWb		  = 4'd7,
    lpctCrWbBlink	= 4'd4;
  // 各Lampの点灯状態での点灯または点滅時間を定義
  // 各ステートの滞在を示す時間となる。
    
//-----------------------------------------------------------------------------
  // ※. ここに合成可能なRTLにて実装してください。
/* 
 * 出力信号 | 機能 | 対応レジスタ
 * oWB 歩行者青信号 reg rWb
 * oWR 歩行者赤信号 reg rWr
 * oWD 何かのランプ reg rWd
 *
 * oCB 車道青信号     reg rCb
 * oCY 車道黄色信号   reg rCy
 * oCR 車道赤信号     reg rCr
 *
 * 基本的な信号動作順序
 * 
 * 0. ユーザーがスイッチを押す
 * 1. 車道側の信号が青、黄、赤の順に切り替わる
 * 2. 歩道側の信号が赤、青に切り替わる
 * 3. 歩道側の信号青が点滅する
 * 4. 歩道側の信号が赤に切り替わる
 * 5. 車道側の信号が青に切り替わる
 */

reg [23:0] tmp_count;  // 最大クロック数のカウント値を保存
reg [6:0]  sec_count;  // 各状態の経過時間を保存
reg [6:0]  state_time; // 各状態で指定された点灯時間を保存
reg [2:0]  lamp_state; // LEDの状態遷移を管理
reg [5:0]  lamp_flash; // 点灯パターン保存
reg state_start;       // ボタン押下時の状態開始フラグを管理

wire ENABLE;           // 10hz周期のenable信号
wire STATE_START;      // 状態開始フラグ信号

assign ENABLE = ((tmp_count[23:0] == (pCLKFreqDiv10 - 1)) && (STATE_START == 1'd1)) ? 1'd1 : 1'd0; // 1HzでENABLEが立ち上げ
assign STATE_START = state_start;


// ENABLEカウンター
always @(posedge iCLK) begin
    if (iRST == 1'd1) begin
        tmp_count <= 24'd0;
    end else if ((ENABLE == 1'd1) || (STATE_START == 1'd0)) begin
        tmp_count <= 24'd0;
    end else begin
        tmp_count <= tmp_count + 24'd1;
    end
end

// Btn押下時の状態遷移開始、状態終了まで1をキープする
always @(posedge iCLK) begin
    if (iRST == 1'd1) begin
        state_start <= 1'd0;
    end else if (iWPBS == 1'b1) begin
        state_start <= 1'd1;
    end else if ((ENABLE == 1'b1) && (lamp_state == lpsCrWrTurn) && (sec_count == state_time)) begin // 最終状態切替時にstartflag off
        state_start <= 1'd0;
    end
end

// 指定時間カウント用カウンター
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        sec_count <= 7'd0;
    end else if ((ENABLE == 1'd1) && (STATE_START == 1'd1)) begin
        if (sec_count == state_time) begin
            sec_count <= 7'd0;
        end else begin
            sec_count <= sec_count + 7'd1;
        end
    end
end

// ランプ状態遷移、指定時間経過したら処理
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        lamp_state <= lpsCbWrKeep;
    end else if ((ENABLE == 1'd1) && (STATE_START == 1'd1) && (sec_count == state_time)) begin
        if (lamp_state == lpsCrWrTurn) begin
            lamp_state <= lpsCbWrKeep;
        end else begin
            lamp_state <= lamp_state + 3'd1;
        end
    end
end

// ランプ点灯パターン・時間切替
always @(lamp_flash or lamp_state or state_time) begin
    case (lamp_state)
    lpsCbWrKeep: begin // 車道青点灯、歩道赤点灯、他消灯
        lamp_flash <= 6'b100010;
        state_time <= lpctCbWrKeep;
    end

    lpsCbWrPass: begin // lpsCyWr遷移までKeepと同じ動作を行う
        lamp_flash <= 6'b100010;
        state_time <= lpctCbWrPass;
    end

    lpsCyWr: begin // 車道黄点灯、歩道赤点灯、他消灯
        lamp_flash <= 6'b010010;
        state_time <= lpctCyWr;
    end

    lpsCrWrInter: begin // 車道赤点灯、歩道赤点灯、他消灯
        lamp_flash <= 6'b001010;
        state_time <= lpctCrWr;
    end

    lpsCrWb: begin // 車道赤点灯、歩道青信号点灯、他消灯
        lamp_flash <= 6'b001100;
        state_time <= lpctCrWb;
    end

    lpsCrWbBlink: begin // 車道赤点灯、歩道青信号点滅、他消灯
        lamp_flash <= 6'b001100;
        state_time <= lpctCrWbBlink;
        //  rWb <= (ENABLE == 1'b1) ? rWb ^ 1'b1 : rWb;
    end

    lpsCrWrTurn: begin // 車道赤点灯、歩道赤点灯、他消灯
        lamp_flash <= 6'b001010;
        state_time <= 7'd2;
    end

    default: begin // 操作が無ければ車道青点灯、歩道赤点灯
        lamp_flash <= 6'b100010;
        state_time <= 7'd0;
    end
    endcase
end

// ランプ点灯デコーダー
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        rCb <= 1'd1;
        rCy <= 1'd1;
        rCr <= 1'd1;
        rWb <= 1'd1;
        rWr <= 1'd1;
        rWd <= 1'd1;
    end else begin
        rCb <= lamp_flash[5];
        rCy <= lamp_flash[4];
        rCr <= lamp_flash[3];
        rWb <= lamp_flash[2];
        rWr <= lamp_flash[1];
        rWd <= lamp_flash[0];
    end
end


//-----------------------------------------------------------------------------
endmodule  // MTopSvm03_NV_Training_03
//-----------------------------------------------------------------------------