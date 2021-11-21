/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第9章      */
/* project: capture    */
/* outline: CBLANK作成 */

module cap_flag
  (
    input       CLK,
    input       PCLK,
    input       RST,
    input       VSYNC,
    input       CLRCBLNK,
    output      SETCBLNK,
    output      FIFORST,
    output  reg CBLANK
    );

/* VSYNCをPCLKで受ける */
reg iVSYNC;

always @( posedge PCLK ) begin
    if ( RST )
        iVSYNC <= 1'b0;
    else
        iVSYNC <= VSYNC;
end

/* CBLANKセット信号・・・VSYNCをCLKで同期化 */
reg [2:0]   cblank_ff;

always @( posedge CLK ) begin
    if ( RST )
        cblank_ff <= 3'b000;
    else begin
        cblank_ff[0] <= iVSYNC;
        cblank_ff[1] <= cblank_ff[0];
        cblank_ff[2] <= cblank_ff[1];
    end
end

assign SETCBLNK = (cblank_ff[2:1] == 2'b01);
assign FIFORST  = cblank_ff[2];

/* CBLANKフラグ */
always @( posedge CLK ) begin
    if ( RST )
        CBLANK <= 1'b0;
    else if ( CLRCBLNK )
        CBLANK <= 1'b0;
    else if ( SETCBLNK )
        CBLANK <= 1'b1;
end

endmodule
