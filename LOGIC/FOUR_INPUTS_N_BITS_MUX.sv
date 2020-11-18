module FOUR_INPUTS_N_BITS_MUX #(parameter BITS = 8) (IN0, IN1, IN2, IN3, S, OUT);

	input [BITS-1:0] IN0, IN1, IN2, IN3; // Inputs
	input [1:0] S;								 // Select
	output logic [BITS-1:0] OUT;			 // Output
	
	always_comb begin
		
		case (S)
			
			2'd0: OUT = IN0;
			2'd1: OUT = IN1;
			2'd2: OUT = IN2;
			2'd3: OUT = IN3;
			
		endcase
		
	end
	
endmodule
