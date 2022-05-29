//----------------------------------------------------------
// Create 2022/5/02
// Author koutakimura
// -
// CoreMasterBlock Control Status Register
// 
//----------------------------------------------------------
module cmbCsr #(
)(
    input           iSysClk,        // System Clk
    input           iRst,           // Active High Sync Reset
);


always @(posedge iSysClk)
begin
    case (rAddr)
        'h00: rCsr <= ;
        default: 
    endcase
end


endmodule