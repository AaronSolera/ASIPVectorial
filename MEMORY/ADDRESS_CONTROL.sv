module ADDRESS_CONTROL (CLK, A, RD, WD, WE_IN, SWITCH, WE_OUT, RD_OUT, IMAGE);

	input         CLK, WE_IN;
	input  [31:0] A, RD, WD;
	input	 [4:0]  SWITCH;
	output 		  WE_OUT;
	output [31:0] RD_OUT;
	output [7:0]  IMAGE;
	
	logic 		W_EQU0, W_EQU1;
	logic [4:0] W_REG_SWITCH;
	
	N_BITS_REGISTER #(5)
		SWITCH_REG (CLK, CLK, 1'b0, SWITCH, W_REG_SWITCH);
		
	N_BITS_REGISTER #(8)
		IMAGE_REG (CLK, WE_IN && W_EQU1, 1'b0, WD, IMAGE);
		
	N_BITS_EQU_COMPARATOR #(32) 
		A_EQU0 (A, 32'd81928, W_EQU0),
		A_EQU1 (A, 32'd81929, W_EQU1);
	
	TWO_INPUTS_N_BITS_MUX #(32) 
		RD_MUX (RD, {27'd0,W_REG_SWITCH}, W_EQU0, RD_OUT);
		
	assign WE_OUT = (~W_EQU0 && ~W_EQU1) && WE_IN;

endmodule 