/*
 * Create 2021/11/20
 * Author kouta kimura
 * Editor VSCode ver1.57.1
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * LED状態遷移プロジェクト
 */
module nv_top
#(
parameter pCLKFreqDiv10	= 12000000
)(
output oCB, oCY, oCR, // Lamp-Out for Car Side Signal
output oWB, oWR, oWD, // Lamp-Out for Walker Side Signal
input  iWPBS,	      // Push Button
input  iRST,	      // System Reset
input  iCLK	          // System Clock
);

reg	rCb, rCy, rCr;	assign {oCB,oCY,oCR} = {rCb,rCy,rCr};
reg	rWb, rWr, rWd;	assign {oWB,oWR,oWD} = {rWb,rWr,rWd};

localparam[2:0]
    lpsCbWrKeep	 = 3'h0,		// oCB=ON, oWR=ON, Other=OFF
    lpsCbWrPass	 = 3'h1,		// lpsCbWr状態に加えlpsCyWrへ遷移するまでの待機
    lpsCyWr		 = 3'h2,
    lpsCrWrInter = 3'h3,
    lpsCrWb		 = 3'h4,
    lpsCrWbBlink = 3'h5,
    lpsCrWrTurn	 = 3'h6;

localparam[3:0] // sec
    lpctCbWrKeep  = 4'd10,
    lpctCbWrPass  = 4'd1,
    lpctCyWr	  = 4'd2,
    lpctCrWr	  = 4'd1,
    lpctCrWb	  = 4'd7,
    lpctCrWbBlink = 4'd4;
    
reg [23:0] tmp_count;  // 最大クロック数のカウント値を保存
reg [6:0]  sec_count;  // 各状態の経過時間を保存
reg [6:0]  state_time; // 各状態で指定された点灯時間を保存
reg [2:0]  lamp_state; // LEDの状態遷移を管理
reg [5:0]  lamp_flash; // 点灯パターン保存

wire ENABLE;           // 10hz周期のenable信号
wire EN_BLINK;         // blink信号
wire STATE_START;      // 状態開始フラグ信号

assign ENABLE    = ((tmp_count[23:0] == (pCLKFreqDiv10 - 1)) && (STATE_START == 1'd1)) ? 1'd1 : 1'd0;
assign EN_BLINK  = (tmp_count >= ((pCLKFreqDiv10 / 2) - 1)) ? 1'b0 : 1'b1;
reg state_start;  assign STATE_START = state_start;


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
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        lamp_flash <= 6'b100010;
        state_time <= lpctCbWrKeep;
    end else begin
        case (lamp_state)
        lpsCbWrKeep: begin
            lamp_flash <= 6'b100010;
            state_time <= lpctCbWrKeep;
        end

        lpsCbWrPass: begin
            lamp_flash <= 6'b100010;
            state_time <= lpctCbWrPass;
        end

        lpsCyWr: begin
            lamp_flash <= 6'b010010;
            state_time <= lpctCyWr;
        end

        lpsCrWrInter: begin
            lamp_flash <= 6'b001010;
            state_time <= lpctCrWr;
        end

        lpsCrWb: begin
            lamp_flash <= 6'b001100;
            state_time <= lpctCrWb;
        end

        lpsCrWbBlink: begin
            lamp_flash[2] <= (EN_BLINK == 1'b1) ? lamp_flash[2] ^ 1'd1 : lamp_flash[2];
            state_time <= lpctCrWbBlink;
        end

        lpsCrWrTurn: begin
            lamp_flash <= 6'b001010;
            state_time <= 7'd2;
        end

        default: begin
            lamp_flash <= 6'b100010;
            state_time <= 7'd0;
        end
        endcase
    end
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

endmodule