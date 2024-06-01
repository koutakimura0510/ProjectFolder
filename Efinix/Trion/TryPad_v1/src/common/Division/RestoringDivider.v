/*-----------------------------------------------------------------------------
 * Create  2023/04/15
 * Author  kouta kimura
 * -
 * 除算器回路
 * アルゴリズム:一般的な割り算の筆算による回復法を用いる(回復型除算)
 * 
 *-----------------------------------------------------------------------------*/
module RestoringDivider #(
	parameter pNumBitWidth	= 4
)(
	input  [pNumBitWidth-1:0] iP,	// 被除数
	input  [pNumBitWidth-1:0] iQ,	// 除数
	output [pNumBitWidth-1:0] oDivision,	// 商
	output [pNumBitWidth-1:0] oRemainder,	// 余り
	input  iCKE,
	input  iRST,
	input  iCLK
);

reg [pNumBitWidth-1:0] rP;

always @(posedge iCLK)
begin
	if (iRST) 		rP <= {pNumBitWidth{1'b0}};
	else if (iCKE) 	rP <= iP - iQ;
	else 			rP <= rP;
end

endmodule



module divid (                          // Module name : divid
  CLR,                                  // port list
  CLK,
  a,
  b,
  start,
  division,
  remainder,
  complete
) ;
  
// port declaration ----------------
input              CLR      ;
input              CLK      ;
input       [15:0] a        ;
input       [15:0] b        ;
input              start    ;
output reg  [15:0] division   ;
output reg  [15:0] remainder  ;
output reg         complete ;
  
// parameter declaration -----------
parameter P_DLY = 1 ;
  
// internal signal declaration -----
wire        op_cnt_en   ;
wire        borrow      ;
wire [17:0] sub         ;
wire        div_en      ;
 
reg   [4:0] op_cnt      ;
reg  [32:0] div_ref     ;
reg  [15:0] div_val     ;
 
// logical description -------------
 
assign op_cnt_en = (op_cnt < 6'd16) ;
 
always @(posedge CLK or posedge CLR)
  if (CLR)				op_cnt <= 5'd31 ;
  else if (start)		op_cnt <= 5'd0 ;
  else if (op_cnt_en)	op_cnt <= op_cnt + 5'd1 ;
 
always @(posedge CLK or posedge CLR)
  if (CLR)						div_ref <= 32'd0 ;
  else if (start)				div_ref <= {16'b0,a} ;
  else if (~borrow & div_en)	div_ref <= {sub[15:0],div_ref[14:0],1'b0} ;
  else if (div_en)				div_ref <= div_ref << 1 ;
 
assign sub 		= {1'b0,div_ref[31:15]} - {2'b0,b} ;
assign borrow 	= sub[17] ;
assign div_en 	= (op_cnt <= 5'd15) ;
 
always @(posedge CLK or posedge CLR)
  if (CLR)			div_val <= 16'd0 ;
  else if (start)	div_val <= 16'd0 ;
  else if (div_en)	div_val <= {div_val[14:0],~borrow} ;
 
always @(posedge CLK or posedge CLR)
  if (CLR)		complete <= 1'b0 ;
  else 			complete <= (op_cnt == 5'd16) ;
 
always @(posedge CLK or posedge CLR)
  if (CLR)		division <= 16'd0 ;
  else 			division <= div_val ;
 
always @(posedge CLK or posedge CLR)
  if (CLR)		remainder <= 16'd0 ;
  else 			remainder <= div_ref[31:16] ;
 
endmodule