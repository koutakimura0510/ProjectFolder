edb_top edb_top_inst (
    .bscan_CAPTURE      ( jtag_inst1_CAPTURE ),
    .bscan_DRCK         ( jtag_inst1_DRCK ),
    .bscan_RESET        ( jtag_inst1_RESET ),
    .bscan_RUNTEST      ( jtag_inst1_RUNTEST ),
    .bscan_SEL          ( jtag_inst1_SEL ),
    .bscan_SHIFT        ( jtag_inst1_SHIFT ),
    .bscan_TCK          ( jtag_inst1_TCK ),
    .bscan_TDI          ( jtag_inst1_TDI ),
    .bscan_TMS          ( jtag_inst1_TMS ),
    .bscan_UPDATE       ( jtag_inst1_UPDATE ),
    .bscan_TDO          ( jtag_inst1_TDO ),
    .la0_clk            ( $INSERT_YOUR_CLOCK_NAME ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[8]        ( la0_memory_checker_0/axi4_write_sequence/r_wdata[8] ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[12]       ( la0_memory_checker_0/axi4_write_sequence/r_wdata[12] ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[15]       ( la0_memory_checker_0/axi4_write_sequence/r_wdata[15] ),
    .la0_memory_checker_0/axi4_write_sequence/q_bresp       ( la0_memory_checker_0/axi4_write_sequence/q_bresp ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[9]        ( la0_memory_checker_0/axi4_write_sequence/r_wdata[9] ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[14]       ( la0_memory_checker_0/axi4_write_sequence/r_wdata[14] ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[4]        ( la0_memory_checker_0/axi4_write_sequence/r_wdata[4] ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[7]        ( la0_memory_checker_0/axi4_write_sequence/r_wdata[7] ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[11]       ( la0_memory_checker_0/axi4_write_sequence/r_wdata[11] ),
    .la0_memory_checker_0/axi4_write_sequence/r_wstart      ( la0_memory_checker_0/axi4_write_sequence/r_wstart ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[0]        ( la0_memory_checker_0/axi4_write_sequence/r_wdata[0] ),
    .la0_memory_checker_0/axi4_write_sequence/q_awready     ( la0_memory_checker_0/axi4_write_sequence/q_awready ),
    .la0_memory_checker_0/axi4_write_sequence/r_awvalid     ( la0_memory_checker_0/axi4_write_sequence/r_awvalid ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[10]       ( la0_memory_checker_0/axi4_write_sequence/r_wdata[10] ),
    .la0_memory_checker_0/axi4_write_sequence/rBurstCnt     ( la0_memory_checker_0/axi4_write_sequence/rBurstCnt ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[5]        ( la0_memory_checker_0/axi4_write_sequence/r_wdata[5] ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[13]       ( la0_memory_checker_0/axi4_write_sequence/r_wdata[13] ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[1]        ( la0_memory_checker_0/axi4_write_sequence/r_wdata[1] ),
    .la0_memory_checker_0/axi4_write_sequence/r_bready      ( la0_memory_checker_0/axi4_write_sequence/r_bready ),
    .la0_memory_checker_0/axi4_write_sequence/r_wrow        ( la0_memory_checker_0/axi4_write_sequence/r_wrow ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdone       ( la0_memory_checker_0/axi4_write_sequence/r_wdone ),
    .la0_memory_checker_0/axi4_write_sequence/r_wlast       ( la0_memory_checker_0/axi4_write_sequence/r_wlast ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[2]        ( la0_memory_checker_0/axi4_write_sequence/r_wdata[2] ),
    .la0_memory_checker_0/axi4_write_sequence/q_wready      ( la0_memory_checker_0/axi4_write_sequence/q_wready ),
    .la0_memory_checker_0/axi4_write_sequence/qBurstMaxCke      ( la0_memory_checker_0/axi4_write_sequence/qBurstMaxCke ),
    .la0_memory_checker_0/axi4_write_sequence/r_wvalid      ( la0_memory_checker_0/axi4_write_sequence/r_wvalid ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[3]        ( la0_memory_checker_0/axi4_write_sequence/r_wdata[3] ),
    .la0_memory_checker_0/axi4_write_sequence/q_bvalid      ( la0_memory_checker_0/axi4_write_sequence/q_bvalid ),
    .la0_memory_checker_0/axi4_write_sequence/r_wdata[6]        ( la0_memory_checker_0/axi4_write_sequence/r_wdata[6] ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[1]     ( la0_memory_checker_0/axi4_read_sequence/r_rdata[1] ),
    .la0_memory_checker_0/axi4_read_sequence/q_rvalid       ( la0_memory_checker_0/axi4_read_sequence/q_rvalid ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[0]     ( la0_memory_checker_0/axi4_read_sequence/r_rdata[0] ),
    .la0_memory_checker_0/axi4_read_sequence/q_rrast        ( la0_memory_checker_0/axi4_read_sequence/q_rrast ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[3]     ( la0_memory_checker_0/axi4_read_sequence/r_rdata[3] ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[5]     ( la0_memory_checker_0/axi4_read_sequence/r_rdata[5] ),
    .la0_memory_checker_0/axi4_read_sequence/r_rstart       ( la0_memory_checker_0/axi4_read_sequence/r_rstart ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[9]     ( la0_memory_checker_0/axi4_read_sequence/r_rdata[9] ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[12]        ( la0_memory_checker_0/axi4_read_sequence/r_rdata[12] ),
    .la0_memory_checker_0/axi4_read_sequence/r_rready       ( la0_memory_checker_0/axi4_read_sequence/r_rready ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[8]     ( la0_memory_checker_0/axi4_read_sequence/r_rdata[8] ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[2]     ( la0_memory_checker_0/axi4_read_sequence/r_rdata[2] ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[13]        ( la0_memory_checker_0/axi4_read_sequence/r_rdata[13] ),
    .la0_memory_checker_0/axi4_read_sequence/q_rresp        ( la0_memory_checker_0/axi4_read_sequence/q_rresp ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[15]        ( la0_memory_checker_0/axi4_read_sequence/r_rdata[15] ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[10]        ( la0_memory_checker_0/axi4_read_sequence/r_rdata[10] ),
    .la0_memory_checker_0/axi4_read_sequence/r_rrow     ( la0_memory_checker_0/axi4_read_sequence/r_rrow ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[6]     ( la0_memory_checker_0/axi4_read_sequence/r_rdata[6] ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[14]        ( la0_memory_checker_0/axi4_read_sequence/r_rdata[14] ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[4]     ( la0_memory_checker_0/axi4_read_sequence/r_rdata[4] ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[11]        ( la0_memory_checker_0/axi4_read_sequence/r_rdata[11] ),
    .la0_memory_checker_0/axi4_read_sequence/r_arvalid      ( la0_memory_checker_0/axi4_read_sequence/r_arvalid ),
    .la0_memory_checker_0/axi4_read_sequence/q_arready      ( la0_memory_checker_0/axi4_read_sequence/q_arready ),
    .la0_memory_checker_0/axi4_read_sequence/r_rdata[7]     ( la0_memory_checker_0/axi4_read_sequence/r_rdata[7] ),
    .la0_ddr_reset_sequencer/r_ddr_init_done        ( la0_ddr_reset_sequencer/r_ddr_init_done ),
    .la0_memory_checker_0/iRST      ( la0_memory_checker_0/iRST )
);

////////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2013-2021 Efinix Inc. All rights reserved.              
//
// This   document  contains  proprietary information  which   is        
// protected by  copyright. All rights  are reserved.  This notice       
// refers to original work by Efinix, Inc. which may be derivitive       
// of other work distributed under license of the authors.  In the       
// case of derivative work, nothing in this notice overrides the         
// original author's license agreement.  Where applicable, the           
// original license agreement is included in it's original               
// unmodified form immediately below this header.                        
//                                                                       
// WARRANTY DISCLAIMER.                                                  
//     THE  DESIGN, CODE, OR INFORMATION ARE PROVIDED “AS IS” AND        
//     EFINIX MAKES NO WARRANTIES, EXPRESS OR IMPLIED WITH               
//     RESPECT THERETO, AND EXPRESSLY DISCLAIMS ANY IMPLIED WARRANTIES,  
//     INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF          
//     MERCHANTABILITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR    
//     PURPOSE.  SOME STATES DO NOT ALLOW EXCLUSIONS OF AN IMPLIED       
//     WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO LICENSEE.           
//                                                                       
// LIMITATION OF LIABILITY.                                              
//     NOTWITHSTANDING ANYTHING TO THE CONTRARY, EXCEPT FOR BODILY       
//     INJURY, EFINIX SHALL NOT BE LIABLE WITH RESPECT TO ANY SUBJECT    
//     MATTER OF THIS AGREEMENT UNDER TORT, CONTRACT, STRICT LIABILITY   
//     OR ANY OTHER LEGAL OR EQUITABLE THEORY (I) FOR ANY INDIRECT,      
//     SPECIAL, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY    
//     CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF      
//     GOODWILL, DATA OR PROFIT, WORK STOPPAGE, OR COMPUTER FAILURE OR   
//     MALFUNCTION, OR IN ANY EVENT (II) FOR ANY AMOUNT IN EXCESS, IN    
//     THE AGGREGATE, OF THE FEE PAID BY LICENSEE TO EFINIX HEREUNDER    
//     (OR, IF THE FEE HAS BEEN WAIVED, $100), EVEN IF EFINIX SHALL HAVE 
//     BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGES.  SOME STATES DO 
//     NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR            
//     CONSEQUENTIAL DAMAGES, SO THIS LIMITATION AND EXCLUSION MAY NOT   
//     APPLY TO LICENSEE.                                                
//
////////////////////////////////////////////////////////////////////////////////
