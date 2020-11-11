module N_BITS_ADDER #(parameter BITS = 32) (OP0, OP1, RESULT);

	input  [BITS-1:0] OP0, OP1;
	output [BITS-1:0] RESULT;
	
	assign RESULT = OP0 + OP1;
	
endmodule
