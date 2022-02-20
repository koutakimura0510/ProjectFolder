//----------------------------------------------------------
// Create 2021/2/19
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// DDRメモリに確保しているフレームバッファ領域の、読み込みと書き込みのアクセス領域を制御する
//----------------------------------------------------------

module frameStateRW #(
    pBitLengthState = 2
)(
    input                           iCLK,       // system clk
    input                           iRST,       // system rst
    input                           iRE,        // 1フレーム中の有効領域 読み込み完了Enable信号
    input                           iWE,        // 1フレーム中の有効領域 書き込み完了Enable信号
    output                          oRE,        // read start enable
    output [pBitLengthState-1:0]    oRS,        // read state
    output [pBitLengthState-1:0]    oWS         // write state
);


////////////////////////////////////////////////////////////
`include "../include/commonAddr.vh"


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// RW共通変数
//----------------------------------------------------------
reg [pBitLengthState-1:0] rWState;      assign oWS = rWState;
reg [pBitLengthState-1:0] rRState;      assign oRS = rRState;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// writeフレームバッファ切り替えステートマシン
// フレームバッファを切り替える条件は下記とする
// 
// WE立ち上がり時、次回書き込み先のフレームバッファを読み込み中だった場合、書き込み待機の IDOL モードに突入する。
// RE立ち上がりまで待機し、読み込み完了時にアクセスしていたフレームバッファ領域に書き込み領域を変更する。
// read side は動作を止めずに動作しているため、 write side で禁止・許可の動作を管理することとした。
//
// また、WE・RE が同時に発生した場合は、次回バッファ領域に書き込みを行っても良いと判断ができるので、
// 同時状態の条件を入れて判定している
//----------------------------------------------------------
reg qRWE;

always @(posedge iCLK)
begin
    if (iRST)
    begin
        rWState <= FBUF_AREA_1;
    end
    else
    begin
        case (rWState)
        IDOL: begin
            if (iRE)    rWState <= rRState;
            else        rWState <= IDOL;
        end

        FBUF_AREA_1:
        begin
            if (qRWE)       rWState <= FBUF_AREA_2;
            else if (iWE)   rWState <= (rRState == FBUF_AREA_2) ? IDOL : FBUF_AREA_2;
            else            rWState <= FBUF_AREA_1;
        end

        FBUF_AREA_2:
        begin
            if (qRWE)       rWState <= FBUF_AREA_3;
            else if (iWE)   rWState <= (rRState == FBUF_AREA_3) ? IDOL : FBUF_AREA_3;
            else            rWState <= FBUF_AREA_2;
        end

        FBUF_AREA_3:
        begin
            if (qRWE)       rWState <= FBUF_AREA_1;
            else if (iWE)   rWState <= (rRState == FBUF_AREA_1) ? IDOL : FBUF_AREA_1;
            else            rWState <= FBUF_AREA_3;
        end

        default:
        begin
            rWState <= FBUF_AREA_1;
        end

        endcase
    end
end

always @*
begin
    qRWE <= (iRE & iWE);
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// readフレームバッファ切り替えステートマシン
// フレームバッファを切り替える条件は下記とする
// 
// 最初の1フレーム目は IDOL 状態とし読み込みは開始しない
// 60FPS動作のため、読み込みバッファ切替時に切替先の書き込みが完了していなければならない
// 書き込みが完了している前提なので、バッファ切り替えの際のエラー処理などを施していない
// Readステートマシン側は1フレーム読み込み完了時にアクセスするアドレス先を切り替えるだけにする
//----------------------------------------------------------
reg qRE;                    assign oRE = qRE;

always @(posedge iCLK)
begin
    if (iRST)
    begin
        rRState <= IDOL;
    end
    else
    begin
        case (rRState)
            IDOL:
            begin
                if (iWE)    rRState <= FBUF_AREA_1;
                else        rRState <= IDOL;
            end

            FBUF_AREA_1:
            begin
                if (iRE)    rRState <= (rWState == FBUF_AREA_2) ? FBUF_AREA_1 : FBUF_AREA_2;
                else        rRState <= FBUF_AREA_1;
            end

            FBUF_AREA_2:
            begin
                if (iRE)    rRState <= (rWState == FBUF_AREA_3) ? FBUF_AREA_2 : FBUF_AREA_3;
                else        rRState <= FBUF_AREA_2;
            end

            FBUF_AREA_3:
            begin
                if (iRE)    rRState <= (rWState == FBUF_AREA_1) ? FBUF_AREA_3 : FBUF_AREA_1;
                else        rRState <= FBUF_AREA_3;
            end

            default:
            begin
                rRState <= IDOL;
            end
        endcase
    end
end

always @*
begin
    qRE <= (rRState == IDOL) ? 1'b0 : 1'b1;
end

endmodule