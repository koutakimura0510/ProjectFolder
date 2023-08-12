/*-----------------------------------------------------------------------------
 * Create  2023/7/15
 * Author  koutakimura
 * -
 * UfiAdrs Bit Assign
 * [31]    1'b1 Enable,   	1'b0 Disable
 * [30]    1'b1 ReadCmd,	1'b0 WriteCmd
 * [28:25] Block ID
 * [24: 0] RAM Adrs
 *
 * [Read]
 * Master 側は自身が発行した ReadCmd の判定として、Block ID,Enable bit を使用する、
 * 自身がもつ Block ID と比較して、有効データとみなす仕組みにすることで、
 * Slave からの Read データはスルーで済むようになり、処理が考えやすい。
 *
 * [Write]
 * 例として Master1,2 が存在する場合、Master1 がバスを占有している時は、Master2 は バスを利用発行できない
 *
 * V1.0 : new Relaese
 *-----------------------------------------------------------------------------*/
module UFIB #(
	// variable parameter
	parameter pBlockConnectNum 	= 	3,	// UfiBus Master接続ブロック数
	parameter pBlockAdrsWidth 	= 	3,
	parameter pUfiDqBusWidth	=  16,	// バスのデータ幅は、使用する外部RAMのデータ幅と合わせている
	parameter pUfiAdrsBusWidth	=  32,
	// not valiable parameter
	parameter pMUfiDqWidth 		= pUfiDqBusWidth * pBlockConnectNum,
	parameter pMUfiAdrsWidth	= pUfiAdrsBusWidth * pBlockConnectNum
)(
	// Ufi Bus Master Read
	input  [pUfiDqBusWidth-1:0] 	iSUfiRd,
	input  [pUfiAdrsBusWidth-1:0] 	iSUfiAdrs,
	output [pUfiDqBusWidth-1:0] 	oMUfiRd,
	output [pUfiAdrsBusWidth-1:0] 	oMUfiAdrs,
	// Ufi Bus Master Write
	output [pUfiDqBusWidth-1:0] 	oSUfiWd,
	output [pUfiAdrsBusWidth-1:0] 	oSUfiAdrs,
	input  							iSUfiRdy,
	input  [pMUfiDqWidth-1:0] 		iMUfiWd,
	input  [pMUfiAdrsWidth-1:0] 	iMUfiAdrs,
	output [pBlockConnectNum-1:0]	oMUfiRdy,
    // CLK Reset
    input  iRST,
    input  iCLK 
);


//-----------------------------------------------------------------------------
// Arbiter
//-----------------------------------------------------------------------------
genvar x;

// Read Thru
assign oMUfiRd   = iSUfiRd;
assign oMUfiAdrs = iSUfiAdrs;	// 各 Master は有効データの判定を Block ID で行う。
// Write
reg  [pUfiDqBusWidth-1:0] 	rMUfiWd;							assign oSUfiWd   = rMUfiWd;
reg  [pUfiAdrsBusWidth-1:0] rMUfiAdrs;							assign oSUfiAdrs = rMUfiAdrs;
reg  [pBlockConnectNum-1:0] qMUfiRdy; 							assign oMUfiRdy  = qMUfiRdy;
wire [pUfiDqBusWidth-1:0]	wMUfiWd[pBlockConnectNum-1:0];
wire [pUfiAdrsBusWidth-1:0]	wMUfiAdrs[pBlockConnectNum-1:0];
wire [pBlockAdrsWidth-1:0]	wBlockId[pBlockConnectNum-1:0];
wire [pBlockConnectNum-1:0]	wEnableBit;
reg  [pBlockAdrsWidth-1:0]	rBlockSelect;
reg 						qBlockSelectRst,	qBlockSelectCke;
reg  [2:0]					rLatencyCnt;
reg 						qLatencyCntCke,		qLatencyCntRst;

always @(posedge iCLK)
begin
	rMUfiWd 	<= wMUfiWd[rBlockSelect];

	if (iRST) 	rMUfiAdrs 	<= {pUfiAdrsBusWidth{1'b0}};
	else		rMUfiAdrs 	<= wMUfiAdrs[rBlockSelect];

	if (qBlockSelectRst)		rBlockSelect <= {pBlockAdrsWidth{1'b0}};
	else if (qBlockSelectCke)	rBlockSelect <=  rBlockSelect + 1'b1;
	else						rBlockSelect <=  rBlockSelect;

	if (qLatencyCntRst)			rLatencyCnt <= 3'd0;
	else if (qLatencyCntCke)	rLatencyCnt <= rLatencyCnt;
	else						rLatencyCnt <= rLatencyCnt + 1'b1;
end

// アドレスのインデックス参照で取得しやすいように
// Read Dataをデータ幅で分解し二次元配列に保存
generate
	for (x = 0; x < pBlockConnectNum; x = x + 1)
	begin
		assign wMUfiWd[x]		= iMUfiWd[((x+1)*pUfiDqBusWidth)-1:x*pUfiDqBusWidth];
		assign wMUfiAdrs[x]		= iMUfiAdrs[((x+1)*pUfiAdrsBusWidth)-1:x*pUfiAdrsBusWidth];
		assign wBlockId[x]		= wMUfiAdrs[x][28:25];
		assign wEnableBit[x]	= wMUfiAdrs[x][31];
	end
endgenerate

// .現在アクセスしている Master 以外の Master はバス使用不可
// .Master は最大 Burst 転送量が決まっており、一度のトランザクションが完了した場合、他のMaster にバスの所有権を譲らなければならない。
// .クロックサイクルを合わせるため、Rdyはレジスタを経由しない
// .Rdy発行後、ある程度待機して Master からバス使用通知がなければ、次の Master への通知待ちに移行する。
//  Master が FIFO 経由でデータ送信する場合、Rdy が丁度次の Master に切り替わるタイミングと、現在の Master の有効通知と交差してしまうことがあるため、
//  特定カウント以上になった場合 Rdy を Dissert し、FIFO の有効通知の最大レイテンシ以上待機してから Master を切り替えることにする。
//  特定カウント以上時に 有効通知があった場合は、現在の Master のデータを有効とする。
localparam [pBlockAdrsWidth-1:0] lpBlockConnectNum = pBlockConnectNum - 1;

generate
	always @*
	begin
		qBlockSelectRst 	<= |{iRST,(rBlockSelect == pBlockConnectNum)};
		qBlockSelectCke 	<= &{~wEnableBit[rBlockSelect],rLatencyCnt==3'd6};
		qLatencyCntRst		<= iRST;
		qLatencyCntCke		<= wEnableBit[rBlockSelect];
	end

	for (x = 0; x < pBlockConnectNum; x = x + 1)
	begin
		always @*	qMUfiRdy[x] <= &{iSUfiRdy,(rBlockSelect == x),(rLatencyCnt < 3'd3)};
	end
endgenerate

endmodule