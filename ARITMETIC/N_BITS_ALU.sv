module N_BITS_ALU #(parameter BITS = 32) (IN0, IN1, OP, OUT, FLAGS);

	input        [BITS-1:0] IN0, IN1; // Inputs
	input        [1:0]      OP;		 // Operation
	output logic [BITS-1:0] OUT;      // Output
	output logic [1:0]      FLAGS;    // Flags
	
	logic [BITS-1:0] W_OUT;
	
	always_comb begin
		
		case (OP)
			
			2'b00: W_OUT = IN0 + IN1;
			2'b01: W_OUT = IN0 - IN1;
			2'b10: W_OUT = IN0 * IN1;
			2'b11: W_OUT = IN0 / IN1;
			
		endcase
		
	end
	
	assign FLAGS[0] = W_OUT[BITS-1];				 // N Flag
	assign FLAGS[1] = (W_OUT == {BITS{1'b0}}); // Z Flag
	
	assign OUT = W_OUT;

endmodule 