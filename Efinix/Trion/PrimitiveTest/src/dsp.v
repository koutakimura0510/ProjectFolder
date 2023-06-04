/*-----------------------------------------------------------------------------
 * Create  2023/6/3
 * Author  KoutaKimura
 * Editor  VSCode ver1.73.1
 * Build   Efinity 2022.2.322.1.8
 * -
 * V1.0：Trion DSP プリミティブを使用した乗算回路
 * 
 *-----------------------------------------------------------------------------*/	
module dsp #(
	parameter pMultRegEnable = 0
)(
	input signed  [17:0] iA,
	input signed  [17:0] iB,
	output signed [35:0] oX,
	input  iCLK
);

(* syn_use_dsp = "yes" *) wire signed [35:0] wSum = iA * iB;	assign oX = wSum;
// (* syn_use_dsp = "yes" *) reg [35:0] rSum;		assign oX = rSum;
// always @(posedge iCLK)
// begin
// 	rSum <= wSum;
// end


// EFX_MULT #(
// 	.WIDTH(18),				//= 18;
// 	.A_REG(1'b0),	//= 1'b0;
// 	.B_REG(1'b0),	//= 1'b0;
// 	.O_REG(1'b0),	//= 1'b0;
// 	.CLK_POLARITY(1'b1),	//= 1'b1; // 0 falling edge, 1 rising edge
// 	.CEA_POLARITY(1'b1),	//= 1'b1; // 0 negative, 1 positive
// 	.RSTA_POLARITY(1'b1),	//= 1'b1; // 0 negative, 1 positive
// 	.RSTA_SYNC(1'b0),		//= 1'b0; // 0 async, 1 sync
// 	.RSTA_VALUE(1'b0),		//= 1'b0; // 0 reset, 1 set
// 	.CEB_POLARITY(1'b1),	//= 1'b1; // 0 negative, 1 positive
// 	.RSTB_POLARITY(1'b1),	//= 1'b1; // 0 negative, 1 positive
// 	.RSTB_SYNC(1'b0),		//= 1'b0; // 0 async, 1 sync
// 	.RSTB_VALUE(1'b0),		//= 1'b0; // 0 reset, 1 set
// 	.CEO_POLARITY(1'b1),	//= 1'b1; // 0 negative, 1 positive
// 	.RSTO_POLARITY(1'b1),	//= 1'b1; // 0 negative, 1 positive
// 	.RSTO_SYNC(1'b0),		//= 1'b0; // 0 async, 1 sync
// 	.RSTO_VALUE(1'b0),		//= 1'b0; // 0 reset, 1 set
// 	.SR_SYNC_PRIORITY(1'b1)	//= 1'b1; // 0 CE, 1 SR
// ) efx_mult (
// 	.A(iA),
// 	.B(iB),
// 	.O(oX),
// 	.CLK(iCLK),
// 	.CEA(1'b0),
// 	.RSTA(iRST),
// 	.CEB(1'b0),
// 	.RSTB(iRST),
// 	.CEO(1'b0),
// 	.RSTO(1'b0)
// );

endmodule