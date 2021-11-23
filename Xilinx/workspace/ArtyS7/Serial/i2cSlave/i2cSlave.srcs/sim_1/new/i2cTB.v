`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/23 08:58:16
// Design Name: 
// Module Name: i2c_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module i2cTB;

reg io_sclA = 1'bz;
reg io_sdaA = 1'bz;
reg io_sclB = 1'bz;
reg io_sdaB = 1'bz;
reg ienable = 0;
reg reset   = 1;
reg clk     = 0;
reg rw_dir = 0;

// inoutのoutput
wire sclA, sdaA, sclB, sdaB;


// inout対応
assign sclA = io_sclA;
assign sdaA = io_sdaA;
assign sclB = io_sclB;
assign sdaB = io_sdaB;


// clk発生用変数
parameter CYCLE = 20;      // system-clkの速度
parameter SCLK_CYCLE = 20 * 16; // sclの速度
parameter SEND_COUNT = 4;  // 送信回数
integer i, j, z, count;
integer send_data;

i2c_top i0(
    .ioSclA(sclA),
    .ioSdaA(sdaA),
    .ioSclB(sclB),
    .ioSdaB(sdaB),
    .iEnable(ienable),
    .iRST(reset),
    .iCLK(clk)
);


/*
 * システムクロック発生
 */
always begin
    #(CYCLE/2)
    clk = ~clk;
end


/*
 * i2cテスト通信
 */
task i2c_test(
    input [31:0] data,  // アドレスデータ
    input [31:0] data2, // 送信データ
    input rs_onoff,     // 1.RsON / 0.RsOFF
    input [31:0] rw,    // 1.Read / 0.Write
    input abSel         // 0.Amaster, 1.Bmaster
);
begin
    // 起動時初期設定
    clk     = 1'b0;
    ienable = 1'b0;

    if (abSel == 1'b0) begin
        scl_port(1'b0, 1'b1, 1'b0);
        sda_port(1'b0, 1'b1);
        scl_port(1'b1, 1'bz, 1'b0);
        sda_port(1'b1, 1'bz);
    end else begin
        scl_port(1'b0, 1'bz, 1'b0);
        sda_port(1'b0, 1'bz);
        scl_port(1'b1, 1'b1, 1'b0);
        sda_port(1'b1, 1'b1);
    end
    reset   = 1'd1;
    count   = 0;
    send_data = data | rw;
    rw_dir = 0;

    // 起動開始
    #CYCLE reset   = 1'd0;

    // start condition
    #(CYCLE * 4);
    #CYCLE sda_port(abSel, 1'b0);
    #(CYCLE * 4);
    #CYCLE scl_port(abSel, 1'b0, 1'b0);
    #(CYCLE * 4);
    #CYCLE ienable = 1'b1;

    // データ送信
    for (z = 0; z < SEND_COUNT; z = z + 1) begin
        if ((rw & 1) && (0 < z)) begin
            if (abSel == 1'b0) begin
                if (rs_onoff != 1) begin
                    rw_dir = 0;
                end
                sda_port(0, 1'bz);
            end else begin
                if (rs_onoff != 1) begin
                    rw_dir = 1;
                end
                sda_port(1, 1'bz);
            end
        end
        sda_port(rw_dir, send_data >> 7);
        send_data = send_data << 1;


        // 8bitデータの送信
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 2; j = j + 1) begin
                #SCLK_CYCLE;

                // 立下りエッジ時にデータ更新
                count = count + 1;
                if ((count & 1) == 0) begin
                    sda_port(rw_dir, send_data >> 7);
                    send_data = send_data << 1;
                end
                scl_port(abSel, 1'b0, 1'b1);
            end
        end

        // ack　クロック
        for (j = 0; j < 2; j = j + 1) begin
            #SCLK_CYCLE;
            scl_port(abSel, 1'b0, 1'b1);
        end

        // stop condition
        if (z == (SEND_COUNT - 1)) begin
            #SCLK_CYCLE;
            scl_port(abSel, 1'b1, 1'b0);
            #SCLK_CYCLE;
            sda_port(rw_dir, 1'b1);
            #(SCLK_CYCLE * 4);
        end else begin

            // Rs信号
            if (rs_onoff == 1'b1) begin
                #SCLK_CYCLE;
                sda_port(abSel, 1'b1);
                #SCLK_CYCLE;
                for (j = 0; j < 2; j = j + 1) begin
                    scl_port(abSel, 1'b0, 1'b1);
                    #SCLK_CYCLE;
                    sda_port(abSel, 1'b0);
                    #SCLK_CYCLE;
                end
            end

            #SCLK_CYCLE;
            send_data = data2;
        end
    end
end
endtask

/*
 * sclのio設定
 */
task scl_port(
    input io_select,
    input io_data,
    input toggle
);
begin
    if (io_select == 1'b0) begin
        io_sclA = (toggle == 1'b0) ? io_data : ~io_sclA;
    end else begin
        io_sclB = (toggle == 1'b0) ? io_data : ~io_sclB;
    end
end
endtask


/*
 * sdaのio設定
 */
task sda_port(
    input io_select,
    input io_data
);
begin
    if (io_select == 1'b0) begin
        io_sdaA = io_data;
    end else begin
        io_sdaB = io_data;
    end
end
endtask



/*
 * AB両方のwrite/read/Rs信号onoffのシミュレーションを行う
 * まずA側masterを行い、次にB側masterの処理を行う
 */
initial begin
    i2c_test(32'h000000d6, 32'h000000aa, 1'b0, 32'd0, 1'b0); // write / rsOFF
    i2c_test(32'h000000d6, 32'h000000aa, 1'b1, 32'd0, 1'b0); // write / rsON
    i2c_test(32'h000000d6, 32'h000000aa, 1'b0, 32'd1, 1'b0); // read  / rsOFF
    i2c_test(32'h000000d6, 32'h000000ab, 1'b1, 32'd1, 1'b0); // read  / rsON
    i2c_test(32'h000000d6, 32'h000000aa, 1'b0, 32'd0, 1'b1); // write / rsOFF
    i2c_test(32'h000000d6, 32'h000000aa, 1'b1, 32'd0, 1'b1); // write / rsON
    i2c_test(32'h000000d6, 32'h000000aa, 1'b0, 32'd1, 1'b1); // read  / rsOFF
    i2c_test(32'h000000d6, 32'h000000ab, 1'b1, 32'd1, 1'b1); // read  / rsON
    #(CYCLE * 4 * 100);
    $stop;
end


endmodule
