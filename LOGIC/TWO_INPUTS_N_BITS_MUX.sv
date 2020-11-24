module TWO_INPUTS_N_BITS_MUX #(parameter BITS = 8) (IN0, IN1, S, OUT);

	input        [BITS-1:0] IN0, IN1; // Inputs
	input 			  			S;			 // Select
	output logic [BITS-1:0] OUT; 		 // Output
	
	always_comb begin
		
		case (S)
			
			1'd0: OUT = IN0;
			1'd1: OUT = IN1;
			
		endcase
		
	end
	
endmodule 