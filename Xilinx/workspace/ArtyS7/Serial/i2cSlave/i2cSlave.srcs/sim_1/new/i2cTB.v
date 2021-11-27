`timescale 1ns / 1ps
/*
 * Create 2021/11/25
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.62.1
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * I2Cテストベンチ
 */
module i2cTB;

reg ioSCL   = 1;    
reg ioSDA   = 1;
reg iCLK    = 0;
reg iRST    = 0;
wire [6:0] oSEG;
wire oSEL;
wire ioscl, iosda;
wire iosclf, iosdaf;

assign ioscl    = ioSCL;
assign iosda    = ioSDA;

// タイミング定数
parameter sysCycle      = 10;               // system-clkの速度
parameter rstCycle      = (sysCycle * 4);   // reset timing
parameter sclCycle      = (sysCycle * 16);  // sclの速度

// demoデータ送信回数
parameter sendCnt       = 5;

// enable信号
parameter SimMax        = 8;                // enable
parameter DynMax        = 2;                // seg sel dynamic flash test
parameter Scl400Max     = 2;                // scl400khz test

// for 変数
integer i, main;

// top module 結合
i2cTop #(
.pSysClk(SimMax),
.pDynClk(DynMax),
.pSclClk(Scl400Max)
)
i0(
.ioSCL(ioscl),
.ioSDA(iosda),
.ioSCLF(iosclf),
.ioSDAF(iosdaf),
.iRST(iRST), 
.iCLK(iCLK),
.oSEG(oSEG),
.oSEL(oSEL)
);


/*
 * システムクロック発生
 */
always begin
    #(sysCycle/2)
    iCLK = ~iCLK;
end


/*
 * start condition発行
 */
task startCondition();
begin
    ioSDA = 1'b0;   #(sclCycle);
    ioSCL = 1'b0;   #(sclCycle);
end
endtask

/*
 * stop condition発行
 */
task stopCondition();
begin
    ioSCL = 1'b1;   #(sclCycle);
    ioSDA = 1'b1;   #(sclCycle);
end
endtask


/*
 * i2cシングル送信
 */
task i2cSendSingle(
    input [7:0] data  // byte
);
begin
    ioSDA = data; #(sclCycle);

    // (立上り + 立下り) = 2clk
    // 1byte + ack      = 9clk
    // 9clk x 2clk      = 18clk loop回数
    for (i = 0; i < 18; i = i + 1) begin
        ioSCL = ~ioSCL;

        if (i & 1'b1) begin
            data  = data >> 8'd1;
            if (15 == i || 16 == i) begin
                #(sysCycle * 4);
                ioSDA = 1'bz;
            end else begin
                ioSDA = data;
            end
        end
        #(sclCycle / 2);
    end
end
endtask


/*
 * I2C連続送信
 */
task i2cSendContinue(
    input [7:0] data
);
begin
    ioSDA = data; #(sclCycle / 2);

    for (i = 0; i < 18; i = i + 1) begin
        ioSCL = ~ioSCL;

        if (i & 1'b1) begin
            data  = data >> 8'd1;
            ioSDA = data;
        end
        #(sclCycle / 2);
    end
    ioSCL = 1'b0;
end
endtask


/*
 * AB両方のwrite/read/Rs信号onoffのシミュレーションを行う
 * まずA側masterを行い、次にB側masterの処理を行う
 */
initial begin
    iRST    = 1'b1;     #(rstCycle);
    iRST    = 1'b0;     #(rstCycle);

    for (main = 0; main < sendCnt; main = main + 1) begin
        startCondition();
        i2cSendSingle(8'haa);
        stopCondition();
    end

    startCondition();
    for (main = 0; main < sendCnt; main = main + 1) begin
        i2cSendContinue(8'haa);
    end
    stopCondition();

    #(sysCycle * 8);
    $stop;
end


endmodule
