//----------------------------------------------------------
// Create 2022/4/21
// Author koutakimura
// -
// ホスト後処理ブロック
//----------------------------------------------------------
module PostProcesser #(
    input           iPixelClk,      // 画面サイズに対応したclkを入力
    input           iTmdsClk,       // PixelClkの10倍のクロック入力
    input           iRst,           // Active High
    output          oHdmiClkPos,    // hdmi clk negedge
    output          oHdmiClkNeg,    // hdmi clk posedge
    output [ 2:0]   oHdmiDataPos,   // hdmi Data 8b10b posedge
    output [ 2:0]   oHdmiDataNeg,   // hdmi Data 8b10b negedge
    output          oHdmiScl,       // hdmi I2c scl
    inout           ioHdmiSda,      // hdmi I2c sda
    inout           ioHdmiCec,      // hdmi cec
    input           iHdmiHpd,       // hdmi hpd
    input  [23:0]   iVRGB,          // Pixel Data
    input           iVde,           // video enable signal
    input           iHsync,
    input           iVsync,
    output [1:0]    oLed
);


//----------------------------------------------------------
// TMDS Generate Block
// 
// HDMI Output
//----------------------------------------------------------
wire wHdmiHpd;

tgbWrapper TGB (
    .iPixelClk      (iPixelClk),
    .iTmdsClk       (iTmdsClk),
    .iRst           (iRst),
    .oHdmiClkPos    (oHdmiClkPos),
    .oHdmiClkNeg    (oHdmiClkNeg),
    .oHdmiDataPos   (oHdmiDataPos),
    .oHdmiDataNeg   (oHdmiDataNeg),
    .oHdmiScl       (oHdmiScl),
    .ioHdmiSda      (ioHdmiSda),
    .ioHdmiCec      (ioHdmiCec),
    .iHdmiHpd       (wHdmiHpd),
    .iVRGB          (iVRGB),
    .iVDE           (iVde),
    .iHSYNC         (iHsync),
    .iVSYNC         (iVsync)
);

IBUF IBUF_HDMI_HPD ( 
    .O (wHdmiHpd),
    .I (iHdmiHpd)
);

//---------------------------------------------------------------------------
// Debug Pin
// 
// HPD は通常ケーブル接続時に High になるが、トランジスタのスイッチング回路経由でポートに入力されるため
// ケーブル接続時は Low 信号が検出される
//---------------------------------------------------------------------------
reg [1:0] rHpd;

always @( posedge iPixelClk )
begin
   if       (iRst)        rHpd <= 1'b0;
   else if  (wHdmiHpd)    rHpd <= 1'b0;
   else                   rHpd <= 1'b1;
end

assign oLed = {1'b0, rHpd};


endmodule