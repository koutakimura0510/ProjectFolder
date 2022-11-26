/////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
//
// mipi_pi_cam_debayer_i2c_top.v
//
// *******************************
// Revisions:
// 1.0 Initial rev
// *******************************
/////////////////////////////////////////////////////////////////////////////

module mipi_pi_cam_debayer_i2c_top
#(
)
(
	// Clock and Reset Pins
	input	i_arstn,
	input	i_sysclk,
	input	i_pll_locked,
	
	output[1:0]	cfg_CBSEL,
	output		cfg_ENA,
	output		cfg_CONFIG,
			
	// Debug
	output[1:0]	DEBUG_CBSEL,
	output		DEBUG_DONE,
	output		DEBUG_ENA,
	
	// HDMI bridge chip I2C Pins
	input	hdmi_i_sda,
	output	hdmi_o_sda_oe,
	input	hdmi_i_scl,
	output	hdmi_o_scl_oe,
	output	hdmi_o_xclr,
	output	hdmi_rstn
);

/* RESET signals for HDMI chip */
assign	hdmi_rstn 	= i_pll_locked;

/* I2C debugger control */
wire	w_hdmi_confdone;

/* Control signals for multi images */
reg	[1:0]	r_CBSEL;
reg			r_done;
reg			r_ENA;

/* I2C initialization for IT6263 */
it6263_config
(
	.i_arst			(~i_arstn			),
	.i_sysclk		(i_sysclk			),
	.i_pll_locked	(i_pll_locked		),
	.o_state		(w_hdmi_i2c_state	),
	.o_confdone		(w_hdmi_confdone	),
	
	.i_sda			(hdmi_i_sda		),
	.o_sda_oe		(hdmi_o_sda_oe	),
	.i_scl			(hdmi_i_scl		),
	.o_scl_oe		(hdmi_o_scl_oe	),
	.o_rstn			(hdmi_o_xclr	)
);

/* Multi images control */
assign	cfg_CONFIG	= w_hdmi_confdone ? 1'b1 	: 1'b0;
assign	cfg_CBSEL	= r_CBSEL;
assign	cfg_ENA		= r_ENA;

assign	DEBUG_CBSEL	= cfg_CBSEL;
assign	DEBUG_DONE	= cfg_CONFIG;
assign	DEBUG_ENA	= cfg_ENA;
   
always @ (posedge i_sysclk)
begin
	if(~i_arstn)
	begin
		r_done	<= 1'b0;
		r_CBSEL	<= 2'b01;
		r_ENA	<= 1'b1;
	end
	else if (w_hdmi_confdone)
	begin
		r_done	<= 1'b1;
		r_CBSEL	<= 2'b01;
		r_ENA	<= 1'b1;
	end
	else
	begin
		r_done	<= 1'b0;
		r_CBSEL	<= 2'b01;
		r_ENA	<= 1'b1;
	end
end

endmodule

//////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
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
/////////////////////////////////////////////////////////////////////////////