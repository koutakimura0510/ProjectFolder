//----------------------------------------------------------
// Create 2021/2/19
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// DDRメモリに確保しているフレームバッファ領域にアクセスするためのアドレスを生成するモジュール
//----------------------------------------------------------
module frameBufferTop # (
    parameter pDramAddrWidth = 29           // address
)(
    input           iCLK,       // system clk
    input           iRST,       // system rst
    input           iVDE,       // video enable High->Lowの変化を確認しフレームバッファのchを切り替える
    input           iFVDE,      // fast video enable, 通常のvdeよりも1クロック早くHigh
    output 
);


endmodule