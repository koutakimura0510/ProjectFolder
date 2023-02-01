------------- Begin Cut here for COMPONENT Declaration ------
component edb_top
  port (
         bscan_CAPTURE : in  std_logic;
         bscan_DRCK    : in  std_logic;
         bscan_RESET   : in  std_logic;
         bscan_RUNTEST : in  std_logic;
         bscan_SEL     : in  std_logic;
         bscan_SHIFT   : in  std_logic;
         bscan_TCK     : in  std_logic;
         bscan_TDI     : in  std_logic;
         bscan_TMS     : in  std_logic;
         bscan_UPDATE  : in  std_logic;
         bscan_TDO     : out std_logic;
         la0_clk       : in  std_logic;
         la0_memory_checker_0/r_Wcs_mon : in  std_logic;
         la0_memory_checker_0/r_AWvalid_mon : in  std_logic;
         la0_memory_checker_0/r_Wlast_mon : in  std_logic;
         la0_memory_checker_0/r_ARready_mon : in  std_logic;
         la0_memory_checker_0/r_Rrow_mon : in  std_logic_vector(16 downto 0);
         la0_memory_checker_0/r_Wready_mon : in  std_logic;
         la0_memory_checker_0/r_ARvalid_mon : in  std_logic;
         la0_memory_checker_0/r_AWready_mon : in  std_logic;
         la0_memory_checker_0/r_Bready_mon : in  std_logic;
         la0_memory_checker_0/r_Rready_mon : in  std_logic;
         la0_memory_checker_0/r_Rcs_mon : in  std_logic;
         la0_memory_checker_0/r_Wvalid_mon : in  std_logic;
         la0_memory_checker_0/r_Rdata_mon : in  std_logic_vector(31 downto 0);
         la0_memory_checker_0/i_cfg_done : in  std_logic;
         la0_memory_checker_0/r_Wbank_mon : in  std_logic_vector(2 downto 0);
         la0_memory_checker_0/r_Wrow_mon : in  std_logic_vector(16 downto 0);
         la0_memory_checker_0/r_Bresp_mon : in  std_logic_vector(1 downto 0);
         la0_memory_checker_0/r_Rbank_mon : in  std_logic_vector(2 downto 0);
         la0_memory_checker_0/r_Rcol_mon : in  std_logic_vector(9 downto 0);
         la0_memory_checker_0/r_Rlast_mon : in  std_logic;
         la0_memory_checker_0/r_Wdata_mon : in  std_logic_vector(31 downto 0);
         la0_memory_checker_0/r_Wcol_mon : in  std_logic_vector(9 downto 0)
       );
end component ;
---------------------- End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template -----
edb_top_inst : edb_top
port map (
           bscan_CAPTURE => jtag_inst1_CAPTURE,
           bscan_DRCK    => jtag_inst1_DRCK,
           bscan_RESET   => jtag_inst1_RESET,
           bscan_RUNTEST => jtag_inst1_RUNTEST,
           bscan_SEL     => jtag_inst1_SEL,
           bscan_SHIFT   => jtag_inst1_SHIFT,
           bscan_TCK     => jtag_inst1_TCK,
           bscan_TDI     => jtag_inst1_TDI,
           bscan_TMS     => jtag_inst1_TMS,
           bscan_UPDATE  => jtag_inst1_UPDATE,
           bscan_TDO     => jtag_inst1_TDO,
           la0_clk      => #INSERT_YOUR_CLOCK_NAME,
           la0_memory_checker_0/r_Wcs_mon   => la0_memory_checker_0/r_Wcs_mon,
           la0_memory_checker_0/r_AWvalid_mon   => la0_memory_checker_0/r_AWvalid_mon,
           la0_memory_checker_0/r_Wlast_mon => la0_memory_checker_0/r_Wlast_mon,
           la0_memory_checker_0/r_ARready_mon   => la0_memory_checker_0/r_ARready_mon,
           la0_memory_checker_0/r_Rrow_mon  => la0_memory_checker_0/r_Rrow_mon,
           la0_memory_checker_0/r_Wready_mon    => la0_memory_checker_0/r_Wready_mon,
           la0_memory_checker_0/r_ARvalid_mon   => la0_memory_checker_0/r_ARvalid_mon,
           la0_memory_checker_0/r_AWready_mon   => la0_memory_checker_0/r_AWready_mon,
           la0_memory_checker_0/r_Bready_mon    => la0_memory_checker_0/r_Bready_mon,
           la0_memory_checker_0/r_Rready_mon    => la0_memory_checker_0/r_Rready_mon,
           la0_memory_checker_0/r_Rcs_mon   => la0_memory_checker_0/r_Rcs_mon,
           la0_memory_checker_0/r_Wvalid_mon    => la0_memory_checker_0/r_Wvalid_mon,
           la0_memory_checker_0/r_Rdata_mon => la0_memory_checker_0/r_Rdata_mon,
           la0_memory_checker_0/i_cfg_done  => la0_memory_checker_0/i_cfg_done,
           la0_memory_checker_0/r_Wbank_mon => la0_memory_checker_0/r_Wbank_mon,
           la0_memory_checker_0/r_Wrow_mon  => la0_memory_checker_0/r_Wrow_mon,
           la0_memory_checker_0/r_Bresp_mon => la0_memory_checker_0/r_Bresp_mon,
           la0_memory_checker_0/r_Rbank_mon => la0_memory_checker_0/r_Rbank_mon,
           la0_memory_checker_0/r_Rcol_mon  => la0_memory_checker_0/r_Rcol_mon,
           la0_memory_checker_0/r_Rlast_mon => la0_memory_checker_0/r_Rlast_mon,
           la0_memory_checker_0/r_Wdata_mon => la0_memory_checker_0/r_Wdata_mon,
           la0_memory_checker_0/r_Wcol_mon  => la0_memory_checker_0/r_Wcol_mon
         );
------------------------ End INSTANTIATION Template ---------

--------------------------------------------------------------------------------
-- Copyright (C) 2013-2021 Efinix Inc. All rights reserved.              
--
-- This   document  contains  proprietary information  which   is        
-- protected by  copyright. All rights  are reserved.  This notice       
-- refers to original work by Efinix, Inc. which may be derivitive       
-- of other work distributed under license of the authors.  In the       
-- case of derivative work, nothing in this notice overrides the         
-- original author's license agreement.  Where applicable, the           
-- original license agreement is included in it's original               
-- unmodified form immediately below this header.                        
--                                                                       
-- WARRANTY DISCLAIMER.                                                  
--     THE  DESIGN, CODE, OR INFORMATION ARE PROVIDED “AS IS” AND        
--     EFINIX MAKES NO WARRANTIES, EXPRESS OR IMPLIED WITH               
--     RESPECT THERETO, AND EXPRESSLY DISCLAIMS ANY IMPLIED WARRANTIES,  
--     INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF          
--     MERCHANTABILITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR    
--     PURPOSE.  SOME STATES DO NOT ALLOW EXCLUSIONS OF AN IMPLIED       
--     WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO LICENSEE.           
--                                                                       
-- LIMITATION OF LIABILITY.                                              
--     NOTWITHSTANDING ANYTHING TO THE CONTRARY, EXCEPT FOR BODILY       
--     INJURY, EFINIX SHALL NOT BE LIABLE WITH RESPECT TO ANY SUBJECT    
--     MATTER OF THIS AGREEMENT UNDER TORT, CONTRACT, STRICT LIABILITY   
--     OR ANY OTHER LEGAL OR EQUITABLE THEORY (I) FOR ANY INDIRECT,      
--     SPECIAL, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY    
--     CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF      
--     GOODWILL, DATA OR PROFIT, WORK STOPPAGE, OR COMPUTER FAILURE OR   
--     MALFUNCTION, OR IN ANY EVENT (II) FOR ANY AMOUNT IN EXCESS, IN    
--     THE AGGREGATE, OF THE FEE PAID BY LICENSEE TO EFINIX HEREUNDER    
--     (OR, IF THE FEE HAS BEEN WAIVED, $100), EVEN IF EFINIX SHALL HAVE 
--     BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGES.  SOME STATES DO 
--     NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR            
--     CONSEQUENTIAL DAMAGES, SO THIS LIMITATION AND EXCLUSION MAY NOT   
--     APPLY TO LICENSEE.                                                
--
--------------------------------------------------------------------------------
