module raw_to_rgb
#(
	parameter	P_DEPTH			= 10,
	parameter	PW				= P_DEPTH*2,
	parameter	X_CNT_WIDTH		= 12
)
(
	input			i_arstn,
	input			i_pclk,
			
	input			i_vsync,
	input			i_hsync,
	input			i_de,
	input[PW-1:0]	i_p_11,
	input[PW-1:0]	i_p_00,	
	input[PW-1:0]	i_p_01,
	
	output			o_vsync,
	output			o_hsync,
	output			o_de,
	output[10:0]	o_cnt,
	output[PW-1:0]	o_r,
	output[PW-1:0]	o_g,	
	output[PW-1:0]	o_b
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// y -1  0  +1  x
// 
//   -1  0  +1 
//   -1  0  +1 
//   -1  0  +1 
//
//				r_bayer_11_11_2P						r_bayer_11_01_1P                       	r_bayer_11_01_0P
//				r_bayer_00_11_2P						r_bayer_00_00_1P                       	r_bayer_00_01_0P
//				r_bayer_01_11_2P						r_bayer_01_01_1P                       	r_bayer_01_01_0P
//
//	r_bayer_11_11_2P_0	r_bayer_11_11_2P_1	r_bayer_11_00_1P_0	r_bayer_11_00_1P_1	r_bayer_11_01_0P_0	r_bayer_11_01_0P_1
//	r_bayer_00_11_2P_0	r_bayer_00_11_2P_1	r_bayer_00_00_1P_0	r_bayer_00_00_1P_1	r_bayer_00_01_0P_0	r_bayer_00_01_0P_1
//	r_bayer_01_11_2P_0	r_bayer_01_11_2P_1	r_bayer_01_00_1P_0	r_bayer_01_00_1P_1	r_bayer_01_01_0P_0	r_bayer_01_01_0P_1
//
//  R | G | R | G | R | G              R G B | R G B | R G B | R G B | R G B | R G B
// --- --- --- --- --- ---            ------- ------- ------- ------- ------- -------
//  G | B | G | B | G | B        |\    R G B | R G B | R G B | R G B | R G B | R G B
// --- --- --- --- --- ---  -----  \  ------- ------- ------- ------- ------- -------
//  R | G | R | G | R | G   -----  /   R G B | R G B | R G B | R G B | R G B | R G B
// --- --- --- --- --- ---       |/   ------- ------- ------- ------- ------- -------
//  G | B | G | B | G | B              R G B | R G B | R G B | R G B | R G B | R G B
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
reg	[9:0]			r_x_cnt;
reg	[9:0]			r_x_cnt_1P;
reg	[9:0]			r_x_cnt_2P;
reg	[10:0]			r_y_cnt;

reg	[PW-1:0]		r_r_00_00_1P;
reg	[PW-1:0]		r_g_00_00_1P;
reg	[PW-1:0]		r_b_00_00_1P;

reg	[P_DEPTH-1:0]	r_bayer_11_01_0P_0;
reg	[P_DEPTH-1:0]	r_bayer_11_01_0P_1;
reg	[P_DEPTH-1:0]	r_bayer_00_01_0P_0;
reg	[P_DEPTH-1:0]	r_bayer_00_01_0P_1;
reg	[P_DEPTH-1:0]	r_bayer_01_01_0P_0;
reg	[P_DEPTH-1:0]	r_bayer_01_01_0P_1;
reg	[P_DEPTH-1:0]	r_bayer_11_00_1P_0;
reg	[P_DEPTH-1:0]	r_bayer_11_00_1P_1;
reg	[P_DEPTH-1:0]	r_bayer_00_00_1P_0;
reg	[P_DEPTH-1:0]	r_bayer_00_00_1P_1;
reg	[P_DEPTH-1:0]	r_bayer_01_00_1P_0;
reg	[P_DEPTH-1:0]	r_bayer_01_00_1P_1;
reg	[P_DEPTH-1:0]	r_bayer_11_11_2P_0;
reg	[P_DEPTH-1:0]	r_bayer_11_11_2P_1;
reg	[P_DEPTH-1:0]	r_bayer_00_11_2P_0;
reg	[P_DEPTH-1:0]	r_bayer_00_11_2P_1;
reg	[P_DEPTH-1:0]	r_bayer_01_11_2P_0;
reg	[P_DEPTH-1:0]	r_bayer_01_11_2P_1;

reg					r_vsync_00_1P;
reg					r_hsync_00_1P;
reg					r_de_00_1P;
reg					r_vsync_00_2P;
reg					r_hsync_00_2P;
reg					r_de_00_2P;

/* RAW to RGB Debayer filter */
always@(posedge i_pclk)
begin
	if (~i_arstn)
	begin
		r_x_cnt 			<= 10'b0;
		r_x_cnt_1P			<= 10'b0;
		r_x_cnt_2P			<= 10'b0;
		r_y_cnt				<= 11'b0;
		r_vsync_00_1P		<= 0;
		r_hsync_00_1P		<= 0;
		r_de_00_1P			<= 0;	

		r_bayer_11_01_0P_0	<= {P_DEPTH{1'b0}};
        r_bayer_11_01_0P_1	<= {P_DEPTH{1'b0}};
        r_bayer_00_01_0P_0	<= {P_DEPTH{1'b0}};
        r_bayer_00_01_0P_1	<= {P_DEPTH{1'b0}};
        r_bayer_01_01_0P_0	<= {P_DEPTH{1'b0}};
        r_bayer_01_01_0P_1	<= {P_DEPTH{1'b0}};
		
        r_bayer_11_00_1P_0	<= {P_DEPTH{1'b0}};
        r_bayer_11_00_1P_1	<= {P_DEPTH{1'b0}};
        r_bayer_00_00_1P_0	<= {P_DEPTH{1'b0}};
        r_bayer_00_00_1P_1	<= {P_DEPTH{1'b0}};
        r_bayer_01_00_1P_0	<= {P_DEPTH{1'b0}};
        r_bayer_01_00_1P_1	<= {P_DEPTH{1'b0}};
		
        r_bayer_11_11_2P_0	<= {P_DEPTH{1'b0}};
        r_bayer_11_11_2P_1	<= {P_DEPTH{1'b0}};
        r_bayer_00_11_2P_0	<= {P_DEPTH{1'b0}};
        r_bayer_00_11_2P_1	<= {P_DEPTH{1'b0}};
        r_bayer_01_11_2P_0	<= {P_DEPTH{1'b0}};
        r_bayer_01_11_2P_1	<= {P_DEPTH{1'b0}};
		
		r_r_00_00_1P		<= {PW{1'b0}};
		r_g_00_00_1P		<= {PW{1'b0}};
		r_b_00_00_1P		<= {PW{1'b0}};		
	end
	else
	begin
		r_vsync_00_1P		<= i_vsync;
		r_hsync_00_1P		<= i_hsync;
		r_de_00_1P			<= i_de;
		r_vsync_00_2P		<= r_vsync_00_1P;
		r_hsync_00_2P		<= r_hsync_00_1P;
		r_de_00_2P			<= r_de_00_1P;
		r_x_cnt_1P			<= r_x_cnt;
		r_x_cnt_2P          <= r_x_cnt_1P;
	
		if (r_y_cnt == 11'd0)
		begin
			r_bayer_11_01_0P_0	<= i_p_01[P_DEPTH-1:0];
			r_bayer_11_01_0P_1	<= i_p_01[PW-1:P_DEPTH];
			r_bayer_00_01_0P_0	<= i_p_01[P_DEPTH-1:0];
			r_bayer_00_01_0P_1	<= i_p_01[PW-1:P_DEPTH];
		end
		else if (r_y_cnt == 11'd1)
		begin
			r_bayer_11_01_0P_0	<= i_p_00[P_DEPTH-1:0];
			r_bayer_11_01_0P_1	<= i_p_00[PW-1:P_DEPTH];
			r_bayer_00_01_0P_0	<= i_p_00[P_DEPTH-1:0];
			r_bayer_00_01_0P_1	<= i_p_00[PW-1:P_DEPTH];
		end
		else
		begin
			r_bayer_11_01_0P_0	<= i_p_11[P_DEPTH-1:0];
			r_bayer_11_01_0P_1	<= i_p_11[PW-1:P_DEPTH];
			r_bayer_00_01_0P_0	<= i_p_00[P_DEPTH-1:0];
			r_bayer_00_01_0P_1	<= i_p_00[PW-1:P_DEPTH];
		end		
		r_bayer_01_01_0P_0	<= i_p_01[P_DEPTH-1:0];
		r_bayer_01_01_0P_1	<= i_p_01[PW-1:P_DEPTH];		
		
		if (r_x_cnt == 10'd0)
		begin
			r_bayer_11_00_1P_0	<= {P_DEPTH{1'b0}};
			r_bayer_11_00_1P_1	<= {P_DEPTH{1'b0}};
			r_bayer_00_00_1P_0	<= {P_DEPTH{1'b0}};
			r_bayer_00_00_1P_1	<= {P_DEPTH{1'b0}};
			r_bayer_01_00_1P_0	<= {P_DEPTH{1'b0}};
			r_bayer_01_00_1P_1	<= {P_DEPTH{1'b0}};
			
			r_bayer_11_11_2P_0	<= {P_DEPTH{1'b0}};
			r_bayer_11_11_2P_1	<= {P_DEPTH{1'b0}};
			r_bayer_00_11_2P_0	<= {P_DEPTH{1'b0}};
			r_bayer_00_11_2P_1	<= {P_DEPTH{1'b0}};
			r_bayer_01_11_2P_0	<= {P_DEPTH{1'b0}};
			r_bayer_01_11_2P_1	<= {P_DEPTH{1'b0}};
		end
		else
		begin
			r_bayer_11_00_1P_0	<= r_bayer_11_01_0P_0;
			r_bayer_11_00_1P_1	<= r_bayer_11_01_0P_1;
			r_bayer_00_00_1P_0	<= r_bayer_00_01_0P_0;
			r_bayer_00_00_1P_1	<= r_bayer_00_01_0P_1;
			r_bayer_01_00_1P_0	<= r_bayer_01_01_0P_0;
			r_bayer_01_00_1P_1	<= r_bayer_01_01_0P_1;
			
			r_bayer_11_11_2P_0	<= r_bayer_11_00_1P_0;
			r_bayer_11_11_2P_1	<= r_bayer_11_00_1P_1;
			r_bayer_00_11_2P_0	<= r_bayer_00_00_1P_0;
			r_bayer_00_11_2P_1	<= r_bayer_00_00_1P_1;
			r_bayer_01_11_2P_0	<= r_bayer_01_00_1P_0;
			r_bayer_01_11_2P_1	<= r_bayer_01_00_1P_1;
		end
			
		if (!i_vsync && r_vsync_00_1P)		//Falling edge of VSYNC
			r_y_cnt	<= 11'b0;
			
		if (r_de_00_1P && !i_de)			//Falling edge of DE		
			r_y_cnt 	<= r_y_cnt + 1'b1;
					
		if (i_de)
			r_x_cnt	<= r_x_cnt + 1'b1;
		else
			r_x_cnt 	<= 10'b0;
			
		if (!r_de_00_1P)
		begin
			r_r_00_00_1P	<= {PW{1'b0}};
			r_g_00_00_1P	<= {PW{1'b0}};
			r_b_00_00_1P	<= {PW{1'b0}};	
		end
		else if (!r_y_cnt[0])
		begin
			/* R Gr RG R */
			//r_r_00_00_1P[P_DEPTH-1:0]	<= r_bayer_00_00_1P_0;
			//r_g_00_00_1P[P_DEPTH-1:0]	<= (((r_bayer_11_00_1P_0 >> 1) + (r_bayer_01_00_1P_0 >> 1)) >> 1) + (((r_bayer_00_00_1P_1 >> 1) + (r_bayer_00_11_2P_1 >> 1)) >> 1);
			//r_b_00_00_1P[P_DEPTH-1:0]	<= (((r_bayer_11_00_1P_1 >> 1) + (r_bayer_01_11_2P_1 >> 1)) >> 1) + (((r_bayer_01_00_1P_1 >> 1) + (r_bayer_11_11_2P_1 >> 1)) >> 1);
			//
			//r_r_00_00_1P[PW-1:P_DEPTH]	<= (r_bayer_00_01_0P_0 >> 1) + (r_bayer_00_00_1P_0 >> 1);
			//r_g_00_00_1P[PW-1:P_DEPTH]	<= r_bayer_00_00_1P_1;				
			//r_b_00_00_1P[PW-1:P_DEPTH]	<= (r_bayer_11_00_1P_1 >> 1) + (r_bayer_01_00_1P_1 >> 1);
			
			/* Gr R Gr R */
			r_r_00_00_1P[P_DEPTH-1:0]		<= (r_bayer_00_00_1P_1 >> 1) + (r_bayer_00_11_2P_1 >> 1);
			r_g_00_00_1P[P_DEPTH-1:0]		<= r_bayer_00_00_1P_0;				
			r_b_00_00_1P[P_DEPTH-1:0]		<= (r_bayer_11_00_1P_0 >> 1) + (r_bayer_01_00_1P_0 >> 1);
			
			r_r_00_00_1P[PW-1:P_DEPTH]	<= r_bayer_00_00_1P_1;
			r_g_00_00_1P[PW-1:P_DEPTH]	<= (((r_bayer_00_01_0P_0 >> 1) + (r_bayer_00_00_1P_0 >> 1)) >> 1) + (((r_bayer_11_00_1P_1 >> 1) + (r_bayer_01_00_1P_1 >> 1)) >> 1);
			r_b_00_00_1P[PW-1:P_DEPTH]	<= (((r_bayer_11_01_0P_0 >> 1) + (r_bayer_01_00_1P_0 >> 1)) >> 1) + (((r_bayer_01_01_0P_0 >> 1) + (r_bayer_11_00_1P_0 >> 1)) >> 1);			
		end
		else
		begin
			/* Gb B Gb G */
			//r_r_00_00_1P[P_DEPTH-1:0]	<= (r_bayer_11_00_1P_0 >> 1) + (r_bayer_01_00_1P_0 >> 1);
			//r_g_00_00_1P[P_DEPTH-1:0]	<= r_bayer_00_00_1P_0;				
			//r_b_00_00_1P[P_DEPTH-1:0]	<= (r_bayer_00_00_1P_1 >> 1) + (r_bayer_00_11_2P_1 >> 1);
			//			
			//r_r_00_00_1P[PW-1:P_DEPTH]	<= (((r_bayer_01_01_0P_0 >> 1) + (r_bayer_11_00_1P_0 >> 1)) >> 1) + (((r_bayer_11_01_0P_0 >> 1) + (r_bayer_01_00_1P_0 >> 1)) >> 1);
			//r_g_00_00_1P[PW-1:P_DEPTH]	<= (((r_bayer_11_00_1P_1 >> 1) + (r_bayer_01_00_1P_1 >> 1)) >> 1) + (((r_bayer_00_01_0P_0 >> 1) + (r_bayer_00_00_1P_0 >> 1)) >> 1);		
			//r_b_00_00_1P[PW-1:P_DEPTH]	<= r_bayer_00_00_1P_1;
			
			/* B Gb B Gb */
			r_r_00_00_1P[P_DEPTH-1:0]		<= (((r_bayer_11_00_1P_1 >> 1) + (r_bayer_01_11_2P_1 >> 1)) >> 1) + (((r_bayer_01_00_1P_1 >> 1) + (r_bayer_11_11_2P_1 >> 1)) >> 1);
			r_g_00_00_1P[P_DEPTH-1:0]		<= (((r_bayer_11_00_1P_0 >> 1) + (r_bayer_01_00_1P_0 >> 1)) >> 1) + (((r_bayer_00_00_1P_1 >> 1) + (r_bayer_00_11_2P_1 >> 1)) >> 1);
			r_b_00_00_1P[P_DEPTH-1:0]		<= r_bayer_00_00_1P_0;
						
			r_r_00_00_1P[PW-1:P_DEPTH]	<= (r_bayer_11_00_1P_1 >> 1) + (r_bayer_01_00_1P_1 >> 1);
			r_g_00_00_1P[PW-1:P_DEPTH]	<= r_bayer_00_00_1P_1;				
			r_b_00_00_1P[PW-1:P_DEPTH]	<= (r_bayer_00_01_0P_0 >> 1) + (r_bayer_00_00_1P_0 >> 1);
		end
	end	
end

assign	o_vsync	= r_vsync_00_2P;
assign	o_hsync	= r_hsync_00_2P;
assign	o_de	= r_de_00_2P;
assign	o_cnt	= r_x_cnt_2P;	
assign	o_r		= r_r_00_00_1P;
assign	o_g		= r_g_00_00_1P;
assign	o_b		= r_b_00_00_1P;

endmodule
