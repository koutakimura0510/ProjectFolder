/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第9章              */
/* project: capture（OV7670版）*/
/* outline: カメラ入力部       */

module cap_in
  (
    input           CLK,
    input           RST,
    input           CAPON,
    output  reg     FIFOWR,
    output  [11:0]  FIFOIN,
    /* カメラ */
    input           PCLK,
    input           HREF,
    output          XCLK,
    input   [7:0]   CAMDATA
    );

/* CLK（100MHz）を4分周してXCLK（25MHz）を生成 */
reg [1:0] cnt4;

always @( posedge CLK ) begin
    if ( RST )
        cnt4 <= 2'b00;
    else
        cnt4 <= cnt4 + 2'b01;
end

assign XCLK = cnt4[1];

/* CAPONをPCLKで同期化 */
reg [1:0] capon_ff;

always @( posedge PCLK ) begin
    if ( RST )
        capon_ff <= 2'b00;
    else
        capon_ff <= {capon_ff[0], CAPON};
end

wire captureon = capon_ff[1];

/* FIFO書き込み信号 */
reg HREF_dly;
always @( posedge PCLK ) begin
    if ( RST )
        HREF_dly <= 1'b0;
    else
        HREF_dly <= HREF;
end

always @( posedge PCLK ) begin
    if ( RST )
        FIFOWR <= 1'b0;
    else if ( HREF_dly & captureon )
        FIFOWR <= ~FIFOWR;
    else
        FIFOWR <= 1'b0;
end

/* カメラデータ取り込み */
reg [7:0] dat0, dat1;

always @( posedge PCLK ) begin
    if ( RST ) begin
        dat1 <= 8'h00;
        dat0 <= 8'h00;
    end
    else if ( HREF ) begin
        dat1 <= dat0;
        dat0 <= CAMDATA;
    end
end

assign FIFOIN = {dat0[3:0], dat0[7:4], dat1[3:0]};

endmodule
