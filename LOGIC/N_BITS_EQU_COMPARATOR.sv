module N_BITS_EQU_COMPARATOR #(parameter BITS = 2) (IN0, IN1, OUT);

	input  [BITS-1:0] IN0, IN1;
	output [BITS-1:0] OUT;
	
	assign OUT = (IN0 == IN1);

endmodule 